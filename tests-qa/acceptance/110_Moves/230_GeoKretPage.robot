*** Settings ***
Library         SeleniumLibrary  timeout=10  implicit_wait=0
Library         RobotEyes
Resource        ../functions/FunctionsGlobal.robot
Resource        ../functions/PageMoves.robot
Resource        ../vars/moves.resource
Resource        ../vars/geokrety.resource
Force Tags      Moves    GeoKret Details
Test Setup     Seed

*** Test Cases ***

Moves Should Be Shown On GeoKret Page
    Go To Url                               ${PAGE_GEOKRETY_1_DETAILS_URL}
    Element Count Should Be                 ${GEOKRET_DETAILS_MOVES}        6
    Check Move                              ${1}                            ${MOVE_6}    distance=14
    Check Move                              ${2}                            ${MOVE_5}
    Check Move                              ${3}                            ${MOVE_4}    distance=14
    Check Move                              ${4}                            ${MOVE_3}
    Check Move                              ${5}                            ${MOVE_2}
    Check Move                              ${6}                            ${MOVE_1}    distance=0

    Wait Until Page Contains Element        //*[@id="mapid" and @data-map-loaded="true"]    timeout=30
    Check Image                             ${GEOKRET_DETAILS_MAP_PANEL}

*** Keywords ***

Seed
    Clear DB And Seed 2 users
    Seed 1 geokrety owned by 2
    Sign Out Fast
    Post Move                               ${MOVE_1}
    Post Move                               ${MOVE_2}
    Post Move                               ${MOVE_3}
    Post Move                               ${MOVE_4}
    Post Move                               ${MOVE_5}
    Post Move                               ${MOVE_6}

Check Move
    [Arguments]    ${row}    ${move}    ${gk}=${GEOKRETY_1}    ${comment}=${move.comment}    ${distance}=${EMPTY}    ${author}=username1
    Page Should Contain Element             ${GEOKRET_DETAILS_MOVES}\[${row}]//div[contains(@class, "move-type")]//img[@data-gk-move-type="${move.move_type}"]
    Page Should Contain Element             ${GEOKRET_DETAILS_MOVES}\[${row}]//div[contains(@class, "move-author")]//*[contains(text(), "${author}")]
    Page Should Contain Element             ${GEOKRET_DETAILS_MOVES}\[${row}]//div[contains(@class, "move-comment")]//*[contains(text(), "${comment}")]

    Run Keyword If      ${move.move_type} in @{REQUIRE_COORDINATES}     Page Should Contain Element    ${GEOKRET_DETAILS_MOVES}\[${row}]//small[contains(@class, "move-distance") and contains(text(), "${distance} km")]
    ...                 ELSE                                            Page Should Contain Element    ${GEOKRET_DETAILS_MOVES}\[${row}]//small[contains(@class, "move-distance") and normalize-space(text())=""]
    Run Keyword If      ${move.move_type} in @{REQUIRE_COORDINATES}     Page Should Contain Element    ${GEOKRET_DETAILS_MOVES}\[${row}]//div[contains(@class, "move-cache")]//*[contains(text(), "${move.waypoint}")]
    ...                 ELSE                                            Page Should Contain Element    ${GEOKRET_DETAILS_MOVES}\[${row}]//div[contains(@class, "move-cache") and normalize-space(text())=""]
