*** Settings ***
Library         SeleniumLibrary  timeout=10  implicit_wait=0
Resource        ../functions/FunctionsGlobal.robot
Resource        ../vars/users.resource
Resource        ../vars/geokrety.resource
Force Tags      Moves    Inventory
Suite Setup     Seed

*** Test Cases ***

Fill Tracking Code Should Load GeoKret
    Go To Url                               ${PAGE_MOVES_URL}
    Input Text                              ${MOVE_TRACKING_CODE_INPUT}                 ${GEOKRETY_1.tc}
    Wait Until Page Contains Element        ${MOVE_TRACKING_CODE_FIRST_RESULT_ITEM}
    Element Should Be Visible               ${MOVE_TRACKING_CODE_RESULT_LIST}
    Element Should Contain                  ${MOVE_TRACKING_CODE_FIRST_RESULT_ITEM}     ${GEOKRETY_1.name} by ${USER_1.name}
    Element Should Contain                  ${MOVE_TRACKING_CODE_FIRST_RESULT_ITEM}     Never moved

Fill Invalid Tracking Code
    Go To Url                               ${PAGE_MOVES_URL}
    Input Text                              ${MOVE_TRACKING_CODE_INPUT}                 ${TC_INVALID}
    Input validation has error              ${MOVE_TRACKING_CODE_INPUT}
    Input validation has error help         ${MOVE_TRACKING_CODE_INPUT}                 Sorry, but Tracking Code "${TC_INVALID}" was not found in our database.
    Pannel validation has error             ${MOVE_TRACKING_CODE_PANEL}

Fill Tracking Code With Reference Number
    [Template]    Fill Tracking Code With Reference Number
    GK
    GK0
    GK001
    GK0001

GeoKret Reference Should Be Displayed In Panel Heading
    Go To Url                               ${PAGE_MOVES_URL}
    Input Text                              ${MOVE_TRACKING_CODE_INPUT}                 ${GEOKRETY_1.tc}
    Click Button                            ${MOVE_TRACKING_CODE_CHECK_BUTTON}
    Element Text Should Be                  ${MOVE_TRACKING_CODE_PANEL_HEADER_TEXT}     ${GEOKRETY_1.ref}

    Input Text                              ${MOVE_TRACKING_CODE_INPUT}                 ${TC_INVALID}
    Click Button                            ${MOVE_TRACKING_CODE_CHECK_BUTTON}
    Element Text Should Be                  ${MOVE_TRACKING_CODE_PANEL_HEADER_TEXT}     ${EMPTY}

*** Keywords ***

Seed
    Clear DB And Seed 1 users
    Seed 1 geokrety owned by 1
    Sign Out Fast

Fill Tracking Code With Reference Number
    [Arguments]    ${tc}
    Go To Url                               ${PAGE_MOVES_URL}
    Input Text                              ${MOVE_TRACKING_CODE_INPUT}                 ${tc}
    Click Button                            ${MOVE_TRACKING_CODE_CHECK_BUTTON}
    Input validation has error              ${MOVE_TRACKING_CODE_INPUT}
    Input validation has error help         ${MOVE_TRACKING_CODE_INPUT}                 You seems to have used the GeoKret public identifier "${tc}".
    Pannel validation has error             ${MOVE_TRACKING_CODE_PANEL}







    #
