*** Settings ***
Library         SeleniumLibrary  timeout=10  implicit_wait=0
Library         RobotEyes
Resource        ../functions/FunctionsGlobal.robot
Resource        ../functions/Images.robot
Resource        ../vars/users.resource
Force Tags      Users Details    Pictures

*** Test Cases ***

Seed
    Clear DB And Seed 2 users

Anonymous should not see draggable
    Go To Url                                       ${PAGE_USER_1_PROFILE_URL}
    Page Should Not Contain Element                 ${USER_PROFILE_DROPZONE}

User himself should see draggable
    Sign In ${USER_1.name} Fast
    Go To Url                                       ${PAGE_USER_1_PROFILE_URL}
    Page Should Contain Element                     ${USER_PROFILE_DROPZONE}

Authenticated should not see draggable for other users
    Sign In ${USER_1.name} Fast
    Go To Url                                       ${PAGE_USER_2_PROFILE_URL}
    Page Should Not Contain Element                 ${USER_PROFILE_DROPZONE}
