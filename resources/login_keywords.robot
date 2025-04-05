*** Settings ***
Documentation    Keywords for login functionality
Library    SeleniumLibrary

*** Variables ***
${USERNAME}         %{MYTAMRO_USERNAME}
${PASSWORD}         %{MYTAMRO_PASSWORD}
${TIMEOUT}         20s
${INITIAL_CHECK}   1s

*** Keywords ***
Input Username
    [Arguments]    ${username}
    Wait Until Element Is Visible    id=userNameInput    ${INITIAL_CHECK}
    Input Text    id=userNameInput    ${username}

Input Password
    [Arguments]    ${password}
    Wait Until Element Is Visible    id=passwordInput    ${INITIAL_CHECK}
    Input Text    id=passwordInput    ${password}    clear=True

Click Sign In
    Wait Until Element Is Enabled    id=submitButton    ${INITIAL_CHECK}
    Click Element    id=submitButton
    
Wait Until Login Complete
    Wait Until Element Is Visible    css=.welcome-message, .dashboard    ${INITIAL_CHECK}    error=Login did not complete within ${INITIAL_CHECK} 