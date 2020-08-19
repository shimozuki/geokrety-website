*** Settings ***
Library         SeleniumLibrary  timeout=10  implicit_wait=0
Library         DependencyLibrary
Resource        ../functions/PageRegistration.robot
Resource        ../vars/users.resource
Force Tags      CreateAccount
# Test Teardown   Execute Manual Step    message

*** Test Cases ***
Seed an account
    [Documentation]         Seed an account
    Clear Database
    Seed 1 users

Email is already taken
    Depends on test         Seed an account
    [Documentation]         Prevent usage of already used email addresses
    Go To Url               ${PAGE_REGISTER_URL}
    Fill Registration Form    ${USER_2.name}    ${USER_1.email}
    ...                       language=${USER_2.lang}   daily_mail=${USER_2.daily_mail}
    Click Button    ${REGISTRATION_REGISTER_BUTTON}

    Location Should Be    ${PAGE_REGISTER_URL}
    Page Should Contain    Sorry but this mail address is already in use.

Form content keeped
    Depends on test         Email is already taken
    [Documentation]         On error the form content should be displayed again
    ...                     But password fileds stayed empty
    Textfield Value Should Be    ${REGISTRATION_USERNAME_INPUT}    ${USER_2.name}
    Textfield Value Should Be    ${REGISTRATION_EMAIL_INPUT}    ${USER_1.email}
    Textfield Value Should Be    ${REGISTRATION_PASSWORD_INPUT}    ${EMPTY}
    Textfield Value Should Be    ${REGISTRATION_PASSWORD_CONFIRM_INPUT}    ${EMPTY}
    ${language}=    Get Selected List Value    ${REGISTRATION_PREFERRED_LANGUAGE_SELECT}
    Should Be Equal As Strings    ${LANGUAGE}    ${USER_2.lang}
    Checkbox Should Be Selected    ${REGISTRATION_DAILY_MAIL_CHECKBOX}
    Checkbox Should Be Selected    ${REGISTRATION_TERMS_OF_USE_CHECKBOX}
