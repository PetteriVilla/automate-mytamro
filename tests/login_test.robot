*** Settings ***
Documentation     A test suite for MyTamro login functionality
Library          SeleniumLibrary
Library          DateTime
Library          OperatingSystem
Resource         ../resources/login_keywords.robot
Suite Setup      Run Keywords    
...    Create Directory    ${CURDIR}${/}..${/}screenshots    AND
...    Open Browser    about:blank    chrome
Suite Teardown   Run Keywords    
...    ${timestamp}=    Get Current Date    result_format=%Y%m%d-%H%M%S    AND
...    Capture Page Screenshot    filename=${CURDIR}${/}..${/}screenshots${/}valid_login_${timestamp}.png    AND
...    Sleep    3s    AND    
...    Close All Browsers

*** Test Cases ***
Valid Login
    [Documentation]    Test the login functionality with valid credentials
    [Tags]    login    smoke
    Go To    https://mytamro.fi
    Input Username    ${USERNAME}
    Input Password    ${PASSWORD}
    Click Sign In
    Wait Until Login Complete
    Page Should Contain    Welcome to MyTamro 