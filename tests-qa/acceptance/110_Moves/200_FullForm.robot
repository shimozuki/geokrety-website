*** Settings ***
Library         SeleniumLibrary  timeout=10  implicit_wait=0
Library         Dialogs
Resource        ../functions/FunctionsGlobal.robot
Resource        ../functions/PageMoves.robot
Resource        ../vars/users.resource
Resource        ../vars/waypoints.resource
Resource        ../vars/geokrety.resource
Force Tags      Moves    Location
Suite Setup     Seed

*** Test Cases ***

Fill Form Naturally
    Sign Out Fast
    Go To Url                               ${PAGE_MOVES_URL}

    Input Text                              ${MOVE_TRACKING_CODE_INPUT}                 ${GEOKRETY_1.tc}
    Click Button                            ${MOVE_TRACKING_CODE_NEXT_BUTTON}
    Panel validation has success            ${MOVE_TRACKING_CODE_PANEL}

    Click Move                              ${MOVE_LOG_TYPE_DROPPED_RADIO}
    Click Button                            ${MOVE_LOG_TYPE_NEXT_BUTTON}
    Panel validation has success            ${MOVE_LOG_TYPE_PANEL}

    Input Text                              ${MOVE_NEW_LOCATION_WAYPOINT_INPUT}         ${WPT_GC_1.id}
    Click Button                            ${MOVE_NEW_LOCATION_NEXT_BUTTON}
    Panel validation has success            ${MOVE_NEW_LOCATION_PANEL}

    Input Text                              ${MOVE_ADDITIONAL_DATA_USERNAME_INPUT}      ${USER_1.name}
    Input Inscrybmde                        \#comment                                   TEST
    Panel validation has success            ${MOVE_ADDITIONAL_DATA_PANEL}
    Click Button                            ${MOVE_ADDITIONAL_DATA_SUBMIT_BUTTON}

    Wait Until Location Is                  ${PAGE_GEOKRETY_1_DETAILS_URL}/page/1\#log1


    # TODO Check log on GK page
    # TODO Check log on Home page
    # TODO Check user inventory
    # TODO Check user owned
    # TODO Check user moves owned
    # TODO Check user moves


*** Keywords ***

Seed
    Clear DB And Seed 1 users
    Seed 2 geokrety owned by 1
    Seed 3 waypoints OC
    Seed 1 waypoints GC

Set DateTime
    [Arguments]    ${datetime}=2020-08-12 07:30:00    ${timezone}=+00:00
    Execute Javascript                      $("#datetimepicker").data("DateTimePicker").date(moment.utc("${datetime}").zone("${timezone}"));
    Simulate Event                          ${MOVE_ADDITIONAL_DATA_DATE_TIME_INPUT}         blur
