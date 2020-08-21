*** Settings ***
Library         SeleniumLibrary  timeout=10  implicit_wait=0
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
    ${USER_1.name}    Sorry, but username "${USER_1.name}" is already used.
    ${SPACE}${USER_1.name}    Sorry, but username "${USER_1.name}" is already used.
    ${SPACE}${USER_1.name}${SPACE}    Sorry, but username "${USER_1.name}" is already used.
    ${SPACE}${SPACE}${SPACE}${USER_1.name}${SPACE}${SPACE}${SPACE}    Sorry, but username "${USER_1.name}" is already used.
    ${USER_1.email}    Sorry, but username "${USER_1.email}" is already used.

*** Keywords ***
Fill username
    [Arguments]    ${username}    ${expected}
    Go To Url                        ${PAGE_REGISTER_URL}
    Input Text                       ${REGISTRATION_USERNAME_INPUT}    ${username}
    Simulate Event                   ${REGISTRATION_USERNAME_INPUT}    blur
    Input validation has error       ${REGISTRATION_USERNAME_INPUT}
    Input validation has error help  ${REGISTRATION_USERNAME_INPUT}   ${expected}
