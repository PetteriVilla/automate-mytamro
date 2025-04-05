*** Settings ***
Documentation    Keywords for Oikotie functionality
Library    SeleniumLibrary

*** Variables ***
${OIKOTIE_URL}    https://asunnot.oikotie.fi/myytavat-asunnot
${TIMEOUT}    20s
${INITIAL_CHECK}    3s
${SEARCH_INPUT}    css=#autocomplete1-input
${SEARCH_BUTTON}    css=.search-inputs__controls button:nth-child(2)
${RESULTS_CONTAINER}    css=.listing-page__results

*** Keywords ***
# This keyword checks for the presence of a cookie consent banner on the Oikotie website.
# It waits for 5 seconds at the beginning to ensure the page has loaded properly.
# If the banner is present, it will wait for the banner to be visible, click the accept cookies button,
# and then wait for the banner to disappear.

Take Screenshot
    [Arguments]    ${filename}
    ${screenshot_path}=    Set Variable    screenshots/${filename}
    Capture Page Screenshot    ${screenshot_path}


