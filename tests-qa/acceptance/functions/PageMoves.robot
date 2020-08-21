*** Settings ***
Resource        FunctionsGlobal.robot

*** Keywords ***

Click Move
    [Arguments]    ${action}
    # let activate retry as sometimes the ToolTip is still over element
    Wait Until Keyword Succeeds    2x    200ms    Click Element    ${action}/parent::label
