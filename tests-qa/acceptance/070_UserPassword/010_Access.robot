*** Settings ***
Library         SeleniumLibrary  timeout=10  implicit_wait=0
Resource        ../functions/FunctionsGlobal.robot
Resource        ../vars/users.resource
Force Tags      Users Details    Security

*** Test Cases ***

Seed
    Clear DB And Seed 1 users

Anonymous users should not access form
    Sign Out Fast
    Go To Url                               ${PAGE_USER_CHANGE_PASSWORD_URL}
    Page Should Contain                     Unauthorized

User himself can access form - Form
    Sign In ${USER_1.name} Fast
    Go To Url                               ${PAGE_USER_CHANGE_PASSWORD_URL}
    Page Should Not Contain                 Unauthorized
    Wait Until Panel                        Change your password

User himself can access form - Modal
    Sign In ${USER_1.name} Fast
    Go To User 1 url
    Click Link                              ${USER_PROFILE_PASSWORD_EDIT_BUTTON}
    Page Should Not Contain                 Unauthorized
    Wait Until Modal                        Change your password

Expired session ask to login
    Sign In ${USER_1.name} Fast
    Go To Url                               ${PAGE_USER_1_PROFILE_URL}
    Press Keys                              None      CTRL+T
    Sign Out Fast
    Press Keys                              None      CTRL+W
