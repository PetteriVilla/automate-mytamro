*** Settings ***
Documentation    Test suite for Oikotie apartment search functionality
Resource    ../resources/login_keywords.robot
Resource    ../resources/oikotie_keywords.robot

*** Variables ***
${SCREENSHOT_DIR}    ${CURDIR}/screenshots
${SCREENSHOT_INDEX}    1
${ACCEPT_COOKIES}    css:#notice > div.message-component.message-row.btns-container > button.message-component.message-button.no-children.focusable.sp_choice_type_11.last-focusable-el
${LOCATION_INPUT}        //*[@id="autocomplete1-input"]
${APARTMENT_TYPE}       /html/body/main/div[4]/listing-search/section[1]/div/search-form/ng-include/div/div[2]/ng-form[1]/div/div[2]/div[1]/sub-type/apartment-type

*** Test Cases ***
Navigate To Oikotie Web Page And Accept Cookies
    [Documentation]    Navigate to the Oikotie web page and accept cookies.
    Open Browser    https://asunnot.oikotie.fi/myytavat-asunnot?cardType=100    chrome
    Log     ACCEPT COOKIES
    Sleep    3s
    Log    COOKIES ACCEPTED
    Wait Until Page Contains    Myytävät asunnot
    Take Screenshot    screenshot_${SCREENSHOT_INDEX}.png
    ${SCREENSHOT_INDEX}=    Set Variable    ${SCREENSHOT_INDEX} + 1

Set location to Helsinki
    Log    Setting location to Helsinki
    Wait Until Element Is Visible    ${LOCATION_INPUT}    timeout=10s
    Input Text    ${LOCATION_INPUT}    Helsinki 
    Sleep    1s
    
    Wait Until Page Contains    Helsinki
    Take Screenshot    screenshot_${SCREENSHOT_INDEX}.png
    ${SCREENSHOT_INDEX}=    Set Variable    ${SCREENSHOT_INDEX} + 1

    Log    Setting apartment type to Kerrostalo
    Wait Until Element Is Visible    ${APARTMENT_TYPE}    timeout=10s
    Click Element    ${APARTMENT_TYPE}

    Take Screenshot    screenshot_${SCREENSHOT_INDEX}.png
    ${SCREENSHOT_INDEX}=    Set Variable    ${SCREENSHOT_INDEX} + 1
