*** Settings ***
Library         SeleniumLibrary  timeout=10  implicit_wait=0
Library         DependencyLibrary
Resource        ../functions/PageGeoKretyCreate.robot
Resource        ../vars/users.resource
Resource        ../vars/geokrety.resource
Force Tags      Users Details

*** Test Cases ***

Seed
    Clear Database
    Seed 2 users

Public Information Visible - anonymous
    Sign Out Fast
    Has Public Information Visible - all users

Private Information Not Visible - anonymous
    Sign Out Fast
    Has Not Private Information Visible - all users

Public Information Visible - authenticated
    Sign In ${USER_1.name} Fast
    Has Public Information Visible - all users

Private Information Visible - authenticated - himself
    Sign In ${USER_1.name} Fast
    Has Private Information             ${PAGE_USER_1_PROFILE_URL}              ${USER_1}

Private Information Not Visible - authenticated - someone else
    Sign In ${USER_1.name} Fast
    Has Not Private Information         ${PAGE_USER_2_PROFILE_URL}


*** Keywords ***

Has Public Information Visible - all users
    Has Public Information              ${PAGE_USER_1_PROFILE_URL}              ${USER_1}
    Has Public Information              ${PAGE_USER_2_PROFILE_URL}              ${USER_2}

Has Not Private Information Visible - all users
    Has Not Private Information          ${PAGE_USER_1_PROFILE_URL}
    Has Not Private Information          ${PAGE_USER_2_PROFILE_URL}

Has Public Information
    [Arguments]             ${url}      ${user}
    Go To Url                           ${url}
    Element Should Contain              ${USER_PROFILE_USERNAME}                ${user.name}
    Page Should Contain Element         ${USER_PROFILE_JOIN_TIME_LABEL}
    Element Should Contain              ${USER_PROFILE_JOIN_TIME}               ago
    Page Should Contain Element         ${USER_PROFILE_LANGUAGE_LABEL}
    Element Should Contain              ${USER_PROFILE_LANGUAGE}                English

Has Private Information
    [Arguments]             ${url}      ${user}
    Go To Url                           ${url}
    Page Should Contain Element         ${USER_PROFILE_EMAIL_LABEL}
    Element Should Contain              ${USER_PROFILE_EMAIL}                   ${user.email}
    Page Should Contain Element         ${USER_PROFILE_SECID_LABEL}
    Textfield Should Not Contain        ${USER_PROFILE_SECID}                   ${EMPTY}
    Page Should Contain                 To change your username or remove your account?

Has Not Private Information
    [Arguments]             ${url}
    Go To Url                           ${url}
    Page Should Not Contain Element     ${USER_PROFILE_EMAIL_LABEL}
    Page Should Not Contain Element     ${USER_PROFILE_EMAIL}
    Page Should Not Contain Element     ${USER_PROFILE_SECID_LABEL}
    Page Should Not Contain Element     ${USER_PROFILE_SECID}
    Page Should Not Contain             To change your username or remove your account?
