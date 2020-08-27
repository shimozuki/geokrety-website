*** Settings ***
Library         SeleniumLibrary  timeout=10  implicit_wait=0
Library         RobotEyes
Resource        ../functions/FunctionsGlobal.robot
Resource        ../functions/PageMoves.robot
Resource        ../vars/moves.resource
Resource        ../vars/users.resource
Resource        ../vars/geokrety.resource
Force Tags      Moves    Inventory
Suite Setup     Seed

*** Test Cases ***

Moves Should Be Shown On User Inventory Page
    Go To Url                               ${PAGE_USER_INVENTORY_URL}              userid=${USER_1.id}
    Element Count Should Be                 ${USER_INVENTORY_TABLE}/tbody/tr        1
    Check GeoKrety Inventory                ${1}    ${GEOKRETY_1}    ${USER_2}      ${MOVE_6}    last_mover=${USER_1}     distance=28    caches=3

Owner Inventory Page Should Be Empty
    Go To Url                               ${PAGE_USER_INVENTORY_URL}              userid=${USER_2.id}
    Page Should Not Contain Element         ${USER_INVENTORY_TABLE}
    Page Should Contain                     ${USER_2.name}'s inventory is currently empty.

Owner Inventory Page Should Be Empty - Authenticated
    Sign In ${USER_2.name} Fast
    Go To Url                               ${PAGE_USER_INVENTORY_URL}              userid=${USER_2.id}
    Page Should Not Contain Element         ${USER_INVENTORY_TABLE}
    Page Should Contain                     Your inventory is empty.

*** Keywords ***

Seed
    Clear DB And Seed 2 users
    Seed 1 geokrety owned by ${USER_2.id}
    Sign Out Fast
    Post Move                               ${MOVE_1}
    Post Move                               ${MOVE_2}
    Post Move                               ${MOVE_3}
    Post Move                               ${MOVE_4}
    Post Move                               ${MOVE_25}
    Post Move                               ${MOVE_6}
