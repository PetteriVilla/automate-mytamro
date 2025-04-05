*** Settings ***
Documentation     A test suite for MyTamro login functionality
Library          SeleniumLibrary
Resource         ../resources/login_keywords.robot
Suite Setup      Open Browser    about:blank    chrome
Suite Teardown   Close All Browsers

*** Test Cases ***
Valid Login
    [Documentation]    Test the login functionality with valid credentials
    [Tags]    login    smoke
    Go To    https://mytamro.tamro.fi
    Input Username    ${USERNAME}
    Input Password    ${PASSWORD}
    Click Sign In
    Page Should Contain    Welcome to MyTamro 