*** Settings ***
Library         SeleniumLibrary  timeout=10  implicit_wait=0
Resource        ../functions/PageRegistration.robot
Resource        ../vars/users.resource
Force Tags      CreateAccount

*** Test Cases ***

Seed
    Clear Database
    Seed 1 users

Redirects to last page
    [Documentation]                     Redirect back on news page
    Go To Url                           ${PAGE_NEWS_URL}
    Sign In User                        ${USER_1.name}
    Location Should Be                  ${PAGE_NEWS_URL}
    Sign Out User

No redirect urls
    [Documentation]                     Redirect back on home page
    [Template]    Redirect to home
    ${PAGE_SIGN_IN_URL}
    # ${PAGE_SIGN_OUT_URL}     ### DISABLED WHILE IT DOESN'T SHOW A NICE PAGE
    ${PAGE_REGISTER_URL}
    ${GK_URL}en/registration/fake_token/activate

*** Keywords ***
Redirect to home
    [Arguments]    ${url}
    Go To Url                           ${url}
    Sign In User                        ${USER_1.name}
    Location Should Be                  ${PAGE_HOME_URL}
    Sign Out User
