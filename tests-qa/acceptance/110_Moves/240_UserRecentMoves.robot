*** Settings ***
Library         SeleniumLibrary  timeout=10  implicit_wait=0
Library         RobotEyes
Resource        ../functions/FunctionsGlobal.robot
Resource        ../functions/PageMoves.robot
Resource        ../vars/moves.resource
Resource        ../vars/geokrety.resource
Force Tags      Moves    Location
Test Setup     Seed

*** Test Cases ***

Moves Should Be Shown On GeoKret Page
    Go To Url                               ${PAGE_USER_1_RECENT_MOVES_URL}    user=${MOVE_1.author}
    Element Count Should Be                 ${USER_RECENT_MOVES_TABLE}/tbody/tr        6
    Check Move                              ${1}                            ${MOVE_6}    distance=14
    Check Move                              ${2}                            ${MOVE_5}
    Check Move                              ${3}                            ${MOVE_4}    distance=14
    Check Move                              ${4}                            ${MOVE_3}
    Check Move                              ${5}                            ${MOVE_2}
    Check Move                              ${6}                            ${MOVE_1}    distance=0

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
    Page Should Contain Element             ${USER_RECENT_MOVES_TABLE}//tr[${row}]/td[1]//img[@data-gk-move-type=${move.move_type}]
    Table Cell Should Contain               ${USER_RECENT_MOVES_TABLE}    ${row + 1}    2    ${gk.name}
    Table Cell Should Contain               ${USER_RECENT_MOVES_TABLE}    ${row + 1}    2    ${gk.ref}
    Table Cell Should Contain               ${USER_RECENT_MOVES_TABLE}    ${row + 1}    3    ${move.waypoint}
    Table Cell Should Contain               ${USER_RECENT_MOVES_TABLE}    ${row + 1}    4    ${comment}
    Table Cell Should Contain               ${USER_RECENT_MOVES_TABLE}    ${row + 1}    5    ${author}

    Run Keyword If      ${move.move_type} in @{REQUIRE_COORDINATES}     Table Cell Should Contain    ${USER_RECENT_MOVES_TABLE}    ${row + 1}    6    ${distance} km
    ...                 ELSE                                            Table Cell Should Contain    ${USER_RECENT_MOVES_TABLE}    ${row + 1}    6    ${EMPTY}
