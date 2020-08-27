*** Settings ***
Library         SeleniumLibrary  timeout=10  implicit_wait=0
Resource        ../functions/FunctionsGlobal.robot
Resource        ../vars/users.resource
Force Tags      News    News Details    News Subscription
Test Setup      Seed

*** Test Cases ***


Click Should Show Subscribe Confirmation
    Sign In ${USER_1.name} Fast
    Go To Url                                       ${PAGE_NEWS_URL}                newsid=1
    Click Button                                    ${NEWS_SUBSCRIPTION_BUTTON}
    Wait Until Modal                                Subscribe to this news?

User Can Subscribe
    Sign In ${USER_1.name} Fast
    Go To Url                                       ${PAGE_NEWS_URL}                newsid=1
    Click Button                                    ${NEWS_SUBSCRIPTION_BUTTON}
    Wait Until Modal                                Subscribe to this news?
    Click Button                                    ${MODAL_DIALOG_SUBMIT_BUTTON}
    Flash message shown                             You will now receive updates on new comments.
    Element Attribute Should Be                     ${NEWS_SUBSCRIPTION_BUTTON}     data-subscribed         1

User Can Unsubscribe
    Sign In ${USER_1.name} Fast
    Go To Url                                       ${PAGE_NEWS_URL}                newsid=1
    Click Button                                    ${NEWS_SUBSCRIPTION_BUTTON}
    Wait Until Modal                                Subscribe to this news?
    Click Button                                    ${MODAL_DIALOG_SUBMIT_BUTTON}

    Go To Url                                       ${PAGE_NEWS_URL}                newsid=1
    Click Button                                    ${NEWS_SUBSCRIPTION_BUTTON}
    Wait Until Modal                                Do you really want to unsubscribe from this news?
    Click Button                                    ${MODAL_DIALOG_SUBMIT_BUTTON}
    Flash message shown                             You will not receive updates anymore.
    Element Attribute Should Be                     ${NEWS_SUBSCRIPTION_BUTTON}     data-subscribed         0



*** Keywords ***

Seed
    Clear DB And Seed 1 users
    Go To Url                                       ${PAGE_SEED_NEWS}/2
    Sign Out Fast
