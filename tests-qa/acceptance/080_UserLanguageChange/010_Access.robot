*** Settings ***
Library         SeleniumLibrary  timeout=10  implicit_wait=0
Resource        ../functions/FunctionsGlobal.robot
Resource        ../vars/users.resource

*** Test Cases ***

Seed
    Clear DB And Seed 1 users

Anonymous users should not access form
    Sign Out Fast
    Go To Url                               ${PAGE_USER_CHANGE_LANGUAGE_URL}
    Page Should Contain                     Unauthorized

User himself can access form - Form
    Sign In ${USER_1.name} Fast
    Go To Url                               ${PAGE_USER_CHANGE_LANGUAGE_URL}
    Page Should Not Contain                 Unauthorized
    Wait Until Panel                        Choose your preferred language

User himself can access form - Modal
    Sign In ${USER_1.name} Fast
    Go To User 1 url
    Click Button                            ${USER_PROFILE_LANGUAGE_EDIT_BUTTON}
    Page Should Not Contain                 Unauthorized
    Wait Until Modal                        Choose your preferred language

Expired session ask to login
    Sign In ${USER_1.name} Fast
    Go To Url                               ${PAGE_USER_CHANGE_LANGUAGE_URL}
    Press Keys                              None      CTRL+T
    Sign Out Fast
    Press Keys                              None      CTRL+W
