*** Settings ***
Library         SeleniumLibrary  timeout=10  implicit_wait=0
Library         DependencyLibrary
Resource        ../functions/PageRegistration.robot
Resource        ../vars/users.resource
Force Tags      CreateAccount

*** Test Cases ***
Create an account
    [Documentation]         Create an account
    Clear Database
    Create User             ${USER_1.name}
    Empty Dev Mailbox

Account not active
    Depends on test                     Create an account
    [Documentation]         Non activated accounts could not be used to login
    Go To Url                           ${PAGE_HOME_URL}
    Sign In User                        ${USER_1.name}
    Page Should Contain                 Your account is not yet active.

Confirmation mail sent again
    Depends on test                     Account not active
    Go To Url                           ${PAGE_DEV_MAILBOX_URL}
    ${rowCount}=                        Get Element Count     ${DEV_MAILBOX_MAILS_TABLE_ROWS}
    Should Be Equal As Integers         1   ${rowCount}

Validated account can login
    Depends on test                     Confirmation mail sent again
    Activate user account

    Go To Url                           ${PAGE_HOME_URL}
    Sign In User                        ${USER_1.name}
    Page Should Contain                 Welcome on board
