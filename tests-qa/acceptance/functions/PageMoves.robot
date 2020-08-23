*** Settings ***
Library         RequestsLibrary
Resource        FunctionsGlobal.robot

*** Variables ***
&{CONTENT_TYPE_FORM_URLENCODED}    Content-Type=application/x-www-form-urlencoded

*** Keywords ***

Click Move
    [Arguments]    ${action}
    # let activate retry as sometimes the ToolTip is still over element
    Wait Until Keyword Succeeds    2x    200ms    Click Element    ${action}/parent::label

Post Move
    [Arguments]    ${move}
    Create Session    gk        ${GK_URL}
    ${resp}=          Post Request    gk    /devel/db/geokrety/move/seed    data=${move}    headers=${CONTENT_TYPE_FORM_URLENCODED}
    Request Should Be Successful     ${resp}


Check Move
    [Arguments]    ${table}    ${row}    ${move}    ${gk}=${GEOKRETY_1}    ${comment}=${move.comment}    ${distance}=${EMPTY}    ${author}=username1
    Page Should Contain Element             ${table}//tr[${row}]/td[1]//img[@data-gk-move-type=${move.move_type}]
    Table Cell Should Contain               ${table}    ${row + 1}    2    ${gk.name}
    Table Cell Should Contain               ${table}    ${row + 1}    2    ${gk.ref}
    Table Cell Should Contain               ${table}    ${row + 1}    3    ${move.waypoint}
    Table Cell Should Contain               ${table}    ${row + 1}    4    ${comment}
    Table Cell Should Contain               ${table}    ${row + 1}    5    ${author}

    Run Keyword If      ${move.move_type} in @{REQUIRE_COORDINATES}     Table Cell Should Contain    ${table}    ${row + 1}    6    ${distance} km
    ...                 ELSE                                            Table Cell Should Contain    ${table}    ${row + 1}    6    ${EMPTY}


Check GeoKrety Owned
    [Arguments]    ${row}    ${gk}    ${move}    ${last_mover}=${EMPTY}    ${distance}=${EMPTY}    ${caches}=${EMPTY}
    # TODO check status icon
    # Page Should Contain Element             ${USER_OWNED_GEOKRETY_TABLE}//tr[${row}]/td[1]//img[@data-gk-move-type=${move.move_type}]
    Table Cell Should Contain               ${USER_OWNED_GEOKRETY_TABLE}    ${row + 1}    2    ${gk.name}
    Table Cell Should Contain               ${USER_OWNED_GEOKRETY_TABLE}    ${row + 1}    2    ${gk.ref}
    Table Cell Should Contain               ${USER_OWNED_GEOKRETY_TABLE}    ${row + 1}    3    ${move.waypoint}
    # TODO check last move type icon
    Table Cell Should Contain               ${USER_OWNED_GEOKRETY_TABLE}    ${row + 1}    4    ${last_mover.name}
    Table Cell Should Contain               ${USER_OWNED_GEOKRETY_TABLE}    ${row + 1}    5    ${distance} km
    Table Cell Should Contain               ${USER_OWNED_GEOKRETY_TABLE}    ${row + 1}    6    ${caches}


Check GeoKrety Inventory
    [Arguments]    ${row}    ${gk}    ${owner}    ${move}    ${last_mover}=${EMPTY}    ${distance}=${EMPTY}    ${caches}=${EMPTY}
    # TODO check status icon
    # Page Should Contain Element             ${USER_INVENTORY_TABLE}//tr[${row}]/td[1]//img[@data-gk-move-type=${move.move_type}]
    Table Cell Should Contain               ${USER_INVENTORY_TABLE}    ${row + 1}    2    ${gk.name}
    Table Cell Should Contain               ${USER_INVENTORY_TABLE}    ${row + 1}    2    ${gk.ref}
    Table Cell Should Contain               ${USER_INVENTORY_TABLE}    ${row + 1}    3    ${owner.name}
    Table Cell Should Contain               ${USER_INVENTORY_TABLE}    ${row + 1}    4    ${last_mover.name}
    # TODO check last move type icon
    Table Cell Should Contain               ${USER_INVENTORY_TABLE}    ${row + 1}    5    ${distance} km
    Table Cell Should Contain               ${USER_INVENTORY_TABLE}    ${row + 1}    6    ${caches}
