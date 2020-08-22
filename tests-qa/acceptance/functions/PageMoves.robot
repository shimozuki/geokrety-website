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
