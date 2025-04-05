*** Settings ***
Documentation    Keywords for login functionality
Library    Browser

*** Variables ***
${USERNAME}         %{MYTAMRO_USERNAME}
${PASSWORD}         %{MYTAMRO_PASSWORD}
${TIMEOUT}         20s
${INITIAL_CHECK}   1s
${BROWSER}         chromium
${HEADLESS}        ${False}

*** Keywords ***
Open MyTamro
    [Arguments]    ${url}
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page    ${url}
    Wait Until Page Is Loaded

Wait Until Page Is Loaded
    Wait For Load State    state=networkidle    timeout=${TIMEOUT}
    Wait For Load State    state=domcontentloaded    timeout=${TIMEOUT}

Input Username
    [Arguments]    ${username}
    Wait Until Page Is Loaded
    Wait For Elements State    id=userNameInput    visible    timeout=${INITIAL_CHECK}
    Fill Text    id=userNameInput    ${username}

Input Password
    [Arguments]    ${password}
    Wait For Elements State    id=passwordInput    visible    timeout=${INITIAL_CHECK}
    Fill Secret    id=passwordInput    ${password}

Click Sign In
    Wait For Elements State    id=submitButton    visible    timeout=${INITIAL_CHECK}
    Click    id=submitButton
    
Wait Until Login Complete
    Wait Until Page Is Loaded
    Wait For Elements State    css=.welcome-message, .dashboard    visible    timeout=${TIMEOUT}    message=Login did not complete within ${TIMEOUT}

Close MyTamro
    Close Browser 