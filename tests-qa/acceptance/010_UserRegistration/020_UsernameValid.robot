*** Settings ***
Library         SeleniumLibrary  timeout=10  implicit_wait=0
Library         DependencyLibrary
Resource        ../functions/PageRegistration.robot
Resource        ../vars/users.resource
Force Tags      CreateAccount

*** Test Cases ***
Seed an account
    [Documentation]         Seed an account
    Clear Database
    Seed 1 users

Check username
    [Template]    Fill username
    ${USER_2.name}
    ${USER_2.email}
    🦧 Orangutan
    🐂🐃🐄
    🐂🐃🐄👶👼🎅🤶

*** Keywords ***
Fill username
    [Arguments]    ${username}
    Go To Url                        ${PAGE_REGISTER_URL}
    Input Text                       ${REGISTRATION_USERNAME_INPUT}    ${username}
    Simulate Event                   ${REGISTRATION_USERNAME_INPUT}    blur
    Input validation has success     ${REGISTRATION_USERNAME_INPUT}
