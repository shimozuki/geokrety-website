*** Settings ***
Library         SeleniumLibrary  timeout=10  implicit_wait=0
Library         DependencyLibrary
Resource        ../functions/FunctionsGlobal.robot
Resource        ../vars/users.resource
Resource        ../vars/geokrety.resource
Force Tags      Moves    Inventory
Suite Setup     Seed

*** Variables ***
${start}    ${1}
${gk_seed_count}    ${2}

*** Test Cases ***

Inventory Button Not Displayed For Anonymous
    Sign Out Fast
    Go To Url                               ${PAGE_MOVES_URL}
    Page Should Not Contain Button          ${MOVE_TRACKING_CODE_INVENTORY_BUTTON}

Inventory Button Displayed For Connected
    Sign In ${USER_1.name} Fast
    Go To Url                               ${PAGE_MOVES_URL}
    Page Should Contain Button              ${MOVE_TRACKING_CODE_INVENTORY_BUTTON}

Click Inventory Button Show Inventory
    Sign In ${USER_1.name} Fast
    Go To Url                               ${PAGE_MOVES_URL}
    Open Inventory

Inventory Should Show GeoKrety
    Depends on test                         Click Inventory Button Show Inventory
    Element Count Should Be                 ${MOVE_INVENTORY_TABLE}/tr     ${gk_seed_count}

First Inventory Item
    Depends on test                         Inventory Should Show GeoKrety
    Check Item At Row Is                    1    &{GEOKRETY_1}

Second Inventory Item
    Depends on test                         Inventory Should Show GeoKrety
    Check Item At Row Is                    2    &{GEOKRETY_2}

Checkbox Should Increment Button Badge
    Sign In ${USER_1.name} Fast
    Go To Url                               ${PAGE_MOVES_URL}
    Open Inventory
    Element Should Contain                  ${MOVE_INVENTORY_SELECT_BUTTON_BADGE}    0

    FOR    ${index}    IN RANGE    ${start}    ${gk_seed_count} + 1
        Log    ${index}
        Select Checkbox                         ${MOVE_INVENTORY_TABLE}//tr[${index}]//input[@type="checkbox"]
        ${value} =                              Convert To String                        ${index}
        Element Should Contain                  ${MOVE_INVENTORY_SELECT_BUTTON_BADGE}    ${value}
    END

*** Keywords ***

Seed
    Clear DB And Seed 1 users
    Seed ${gk_seed_count} geokrety owned by 1

Open Inventory
    Click Button                            ${MOVE_TRACKING_CODE_INVENTORY_BUTTON}
    Wait Until Modal                        Select GeoKrety from inventory

Check Item At Row Is
    [Arguments]    ${row}     &{gk}
    Table Row Should Contain                ${MOVE_INVENTORY_TABLE}    ${row}    Choose
    Table Row Should Contain                ${MOVE_INVENTORY_TABLE}    ${row}    ${gk.name}
    Table Row Should Contain                ${MOVE_INVENTORY_TABLE}    ${row}    ${gk.ref}
    Table Row Should Contain                ${MOVE_INVENTORY_TABLE}    ${row}    ${USER_1.name}




    #
