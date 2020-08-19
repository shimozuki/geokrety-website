*** Settings ***
Library         SeleniumLibrary  timeout=10  implicit_wait=0
Resource        ../functions/FunctionsGlobal.robot
Resource        ../vars/users.resource

*** Test Cases ***

Refresh should display a message
    Clear DB And Seed 1 users
    Sign In ${USER_1.name} Fast
    Go To User 1 url
    Click Link                              ${USER_PROFILE_SECID_REFRESH_BUTTON}
    Wait Until Modal                        Refresh your secid?
    Click Button                            ${MODAL_DIALOG_SUBMIT_BUTTON}
    Flash message shown                     Your secid has been refreshed.
