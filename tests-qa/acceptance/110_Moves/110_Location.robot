*** Settings ***
Library         SeleniumLibrary  timeout=10  implicit_wait=0
Library         RobotEyes
Resource        ../functions/FunctionsGlobal.robot
Resource        ../functions/PageMoves.robot
Resource        ../vars/waypoints.resource
Force Tags      Moves    Location
Suite Setup     Seed

*** Test Cases ***

Form Initial Status
    Go To Url                               ${PAGE_MOVES_URL}
    Open Panel                              ${MOVE_NEW_LOCATION_PANEL}
    Element Should Be Visible               ${MOVE_NEW_LOCATION_WAYPOINT_INPUT}
    Element Should Not Be Visible           ${MOVE_NEW_LOCATION_OC_INPUT}
    Element Should Not Be Visible           ${MOVE_NEW_LOCATION_MAP_PANEL}

Empty Waypoint
    Go To Url                               ${PAGE_MOVES_URL}
    Open Panel                              ${MOVE_NEW_LOCATION_PANEL}
    Input Text                              ${MOVE_NEW_LOCATION_WAYPOINT_INPUT}         ${EMPTY}
    Simulate Event                          ${MOVE_NEW_LOCATION_WAYPOINT_INPUT}         blur
    Panel validation has error              ${MOVE_NEW_LOCATION_PANEL}
    Element Text Should Be                  ${MOVE_NEW_LOCATION_PANEL_HEADER_TEXT}      ${EMPTY}
    Input validation has error help         ${MOVE_NEW_LOCATION_WAYPOINT_INPUT}         Waypoint seems empty.
    Element Should Be Visible               ${MOVE_NEW_LOCATION_MAP_PANEL}

Invalid Waypoint
    Go To Url                               ${PAGE_MOVES_URL}
    Open Panel                              ${MOVE_NEW_LOCATION_PANEL}
    Input Text                              ${MOVE_NEW_LOCATION_WAYPOINT_INPUT}         ${INVALID_WPT}
    Simulate Event                          ${MOVE_NEW_LOCATION_WAYPOINT_INPUT}         blur
    Panel validation has error              ${MOVE_NEW_LOCATION_PANEL}
    Input validation has error help         ${MOVE_NEW_LOCATION_WAYPOINT_INPUT}         View the cache page.
    Input validation has error help         ${MOVE_NEW_LOCATION_WAYPOINT_INPUT}         Sorry, but this waypoint is not (yet) in our database.
    Element Should Be Visible               ${MOVE_NEW_LOCATION_MAP_PANEL}
    Element Should Not Be Visible           ${MOVE_NEW_LOCATION_MAP_COORDINATES_INPUT}

Coordinates Field Can Be Manually Open
    Go To Url                               ${PAGE_MOVES_URL}
    Open Panel                              ${MOVE_NEW_LOCATION_PANEL}
    Input Text                              ${MOVE_NEW_LOCATION_WAYPOINT_INPUT}         ${INVALID_WPT}
    Simulate Event                          ${MOVE_NEW_LOCATION_WAYPOINT_INPUT}         blur
    Panel validation has error              ${MOVE_NEW_LOCATION_PANEL}
    Element Should Not Be Visible           ${MOVE_NEW_LOCATION_MAP_COORDINATES_INPUT}
    Click Element                           ${MOVE_NEW_LOCATION_MAP_PANEL_HEADER}
    Element Should Be Visible               ${MOVE_NEW_LOCATION_MAP_COORDINATES_INPUT}

Invalid GC Waypoint
    Go To Url                               ${PAGE_MOVES_URL}
    Open Panel                              ${MOVE_NEW_LOCATION_PANEL}
    Input Text                              ${MOVE_NEW_LOCATION_WAYPOINT_INPUT}         ${INVALID_GC_WPT}
    Simulate Event                          ${MOVE_NEW_LOCATION_WAYPOINT_INPUT}         blur
    Panel validation has error              ${MOVE_NEW_LOCATION_PANEL}
    Input validation has error help         ${MOVE_NEW_LOCATION_WAYPOINT_INPUT}         View the cache page.
    Input validation has error help         ${MOVE_NEW_LOCATION_WAYPOINT_INPUT}         This is a Geocaching.com cache that no one logged yet on GeoKrety.org.
    Element Should Be Visible               ${MOVE_NEW_LOCATION_MAP_PANEL}
    Element Should Be Visible               ${MOVE_NEW_LOCATION_MAP_COORDINATES_INPUT}

Fill Valid Waypoint Validate The Form
    [Template]    Fill Valid Waypoint Validate The Form
    ${WPT_OC_1.id}      ${WPT_OC_1.coords}
    ${WPT_GC_1.id}      ${WPT_GC_1.coords}

Fill Coordinates Validate The Form
    [Template]    Fill Coordinates Validate The Form
    ${INVALID_WPT}      ${WPT_GC_1.coords}
    ${INVALID_GC_WPT}   ${WPT_GC_1.coords}

Fill Coordinates With Invalid Coordinates
    [Template]    Fill Coordinates Validate The Form As Error
    ${INVALID_GC_WPT}    A
    ${INVALID_GC_WPT}    1
    ${INVALID_GC_WPT}    1111111111 222222222

Fill Coordinates Show Map Centered
    Fill Coordinates                        ${INVALID_GC_WPT}                   ${WPT_GC_1.coords}
    Check Image                             ${MOVE_NEW_LOCATION_MAP_MAP}

No Selection Should Show Error
    Go To Url                               ${PAGE_MOVES_URL}
    Open Panel                              ${MOVE_NEW_LOCATION_PANEL}
    Click Button                            ${MOVE_NEW_LOCATION_NEXT_BUTTON}
    Panel validation has error              ${MOVE_NEW_LOCATION_PANEL}

# TODO
Open OC Search Field
    Go To Url                               ${PAGE_MOVES_URL}
    Open Panel                              ${MOVE_NEW_LOCATION_PANEL}
    Click Button                            ${MOVE_NEW_LOCATION_OC_BUTTON}
    Input Text                              ${MOVE_NEW_LOCATION_OC_INPUT}       ${WPT_OC_1.name}

*** Keywords ***

Seed
    Clear DB And Seed 1 users
    Seed 1 geokrety owned by 1
    Seed 3 waypoints OC
    Seed 1 waypoints GC
    Sign Out Fast

Fill Coordinates
    [Arguments]    ${wpt}    ${coords}
    Go To Url                               ${PAGE_MOVES_URL}
    Open Panel                              ${MOVE_NEW_LOCATION_PANEL}
    Input Text                              ${MOVE_NEW_LOCATION_WAYPOINT_INPUT}         ${wpt}
    Simulate Event                          ${MOVE_NEW_LOCATION_WAYPOINT_INPUT}         blur
    Panel validation has error              ${MOVE_NEW_LOCATION_PANEL}

    Click Element                           ${MOVE_NEW_LOCATION_MAP_PANEL_HEADER}
    Element Should Be Visible               ${MOVE_NEW_LOCATION_MAP_COORDINATES_INPUT}
    Input Text                              ${MOVE_NEW_LOCATION_MAP_COORDINATES_INPUT}  ${coords}
    Click Button                            ${MOVE_NEW_LOCATION_MAP_COORDINATES_SEARCH_BUTTON}

Fill Valid Waypoint Validate The Form
    [Arguments]    ${wpt}    ${coords}
    Go To Url                               ${PAGE_MOVES_URL}
    Open Panel                              ${MOVE_NEW_LOCATION_PANEL}
    Input Text                              ${MOVE_NEW_LOCATION_WAYPOINT_INPUT}         ${wpt}
    Panel validation has success            ${MOVE_NEW_LOCATION_PANEL}
    Input validation has success            ${MOVE_NEW_LOCATION_WAYPOINT_INPUT}
    Input validation has success            ${MOVE_NEW_LOCATION_MAP_COORDINATES_INPUT}
    Element Should Be Visible               ${MOVE_NEW_LOCATION_MAP_PANEL}

Fill Coordinates Validate The Form
    [Arguments]    ${wpt}    ${coords}
    Fill Coordinates                        ${wpt}    ${coords}
    Panel validation has success            ${MOVE_NEW_LOCATION_PANEL}
    Input validation has success            ${MOVE_NEW_LOCATION_WAYPOINT_INPUT}
    Input validation has success            ${MOVE_NEW_LOCATION_MAP_COORDINATES_INPUT}

Fill Coordinates Validate The Form As Error
    [Arguments]    ${wpt}    ${coords}
    Fill Coordinates                        ${wpt}    ${coords}
    Panel validation has error              ${MOVE_NEW_LOCATION_PANEL}
    Input validation has error              ${MOVE_NEW_LOCATION_WAYPOINT_INPUT}











#
