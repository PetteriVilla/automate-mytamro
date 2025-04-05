*** Settings ***
Documentation    Keywords for login functionality
Library    SeleniumLibrary

*** Variables ***
${USERNAME}         %{MYTAMRO_USERNAME}
${PASSWORD}         %{MYTAMRO_PASSWORD}

*** Keywords ***
Input Username
    [Arguments]    ${username}
    Input Text    id=userNameInput    ${username}

Input Password
    [Arguments]    ${password}
    Input Password    id=passwordInput    ${password}

Click Sign In
    Click Element    id=submitButton 