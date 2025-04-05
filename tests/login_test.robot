*** Settings ***
Documentation     A test suite for MyTamro login functionality
Library          Browser
Library          DateTime
Library          OperatingSystem
Resource         ../resources/login_keywords.robot
Suite Setup      Run Keywords    
...    Create Directory    ${CURDIR}${/}..${/}screenshots    AND
...    New Browser    chromium    headless=False
Suite Teardown   Run Keywords    
...    Set Suite Variable    ${timestamp}    ${None}    AND
...    Set Suite Variable    ${timestamp}    %{GET_TIME=yyyy-MM-dd-HHmmss}    AND
...    Take Screenshot    filename=${CURDIR}${/}..${/}screenshots${/}valid_login_${timestamp}.png    AND
...    Sleep    3s    AND    
...    Close Browser

*** Test Cases ***
Valid Login
    [Documentation]    Test the login functionality with valid credentials
    [Tags]    login    smoke
    New Page    https://mytamro.fi
    Input Username    ${USERNAME}
    Input Password    ${PASSWORD}
    Click Sign In
    Wait Until Login Complete
    ${welcome_text}=    Get Text    css=.welcome-message
    Should Contain    ${welcome_text}    Welcome to MyTamro 