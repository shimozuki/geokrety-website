*** Settings ***
Library         SeleniumLibrary  timeout=10  implicit_wait=0
Library         RobotEyes
Resource        ../functions/FunctionsGlobal.robot
Resource        ../functions/PageMoves.robot
Resource        ../vars/moves.resource
Resource        ../vars/users.resource
Resource        ../vars/geokrety.resource
Force Tags      Moves    Recent Moves
Suite Setup     Seed

*** Test Cases ***

Moves Should Be Shown On User Recent Moves Page
    Go To Url                               ${PAGE_USER_RECENT_MOVES_URL}    userid=${USER_1.id}
    Element Count Should Be                 ${USER_RECENT_MOVES_TABLE}/tbody/tr        6
    Check Move                              ${USER_RECENT_MOVES_TABLE}    ${1}    ${MOVE_6}    distance=14
    Check Move                              ${USER_RECENT_MOVES_TABLE}    ${2}    ${MOVE_5}
    Check Move                              ${USER_RECENT_MOVES_TABLE}    ${3}    ${MOVE_4}    distance=14
    Check Move                              ${USER_RECENT_MOVES_TABLE}    ${4}    ${MOVE_3}
    Check Move                              ${USER_RECENT_MOVES_TABLE}    ${5}    ${MOVE_2}
    Check Move                              ${USER_RECENT_MOVES_TABLE}    ${6}    ${MOVE_1}    distance=0

Owner Recent Moves Page Should Be Empty
    Go To Url                               ${PAGE_USER_RECENT_MOVES_URL}    userid=${USER_2.id}
    Page Should Not Contain Element         ${USER_RECENT_MOVES_TABLE}
    Page Should Contain                     ${USER_2.name} didn't moved any GeoKrety yet.

*** Keywords ***

Seed
    Clear DB And Seed 2 users
    Seed 1 geokrety owned by ${USER_2.id}
    Sign Out Fast
    Post Move                               ${MOVE_1}
    Post Move                               ${MOVE_2}
    Post Move                               ${MOVE_3}
    Post Move                               ${MOVE_4}
    Post Move                               ${MOVE_5}
    Post Move                               ${MOVE_6}
