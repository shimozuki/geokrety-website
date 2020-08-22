*** Settings ***
Library 	   OperatingSystem
Resource       FunctionsGlobal.robot

*** Keywords ***

Upload user avatar via button
    [Arguments]    ${user_profile_url}    ${file}    ${count}=1
    Go To                                   ${user_profile_url}
    Wait Until Page Contains Element        ${USER_PROFILE_DROPZONE_PICTURE_UPLOAD_BUTTON}    timeout=30
    Choose File    	                        //*[@type="file"]    ${file}
    Run Keyword And Continue On Failure     Wait Until Page Contains Element        ${USER_PROFILE_DROPZONE_IMAGE}\[${count}]${USER_PROFILE_DROPZONE_PROCESSING_SUFFIX}    timeout=30
    Wait Until Page Contains Element        ${USER_PROFILE_DROPZONE_IMAGE}\[${count}]${USER_PROFILE_DROPZONE_PROCESSED_SUFFIX}     timeout=30

Upload user avatar via Drag/Drop - same page
    [Arguments]    ${user_profile_url}    ${source}    ${count}=1
    Go To                                   ${user_profile_url}
    Wait Until Page Contains Element        ${USER_PROFILE_DROPZONE_PICTURE_UPLOAD_BUTTON}    timeout=30
    Drag And Drop                           ${source}    ${USER_PROFILE_DROPZONE}
    Run Keyword And Continue On Failure     Wait Until Page Contains Element        ${USER_PROFILE_DROPZONE_IMAGE}\[${count}]${USER_PROFILE_DROPZONE_PROCESSING_SUFFIX}    timeout=30
    Wait Until Page Contains Element        ${USER_PROFILE_DROPZONE_IMAGE}\[${count}]${USER_PROFILE_DROPZONE_PROCESSED_SUFFIX}     timeout=30

Click Picture Action
    [Arguments]    ${image}    ${button}
    Wait Until Page Contains Element        ${image}//${PICTURE_PULLER}
    Scroll Into View                        ${image}//${PICTURE_PULLER}
    Mouse Over                              ${image}//${PICTURE_PULLER}
    Mouse Over                              ${image}//${button}
    Click Button                            ${image}//${button}

*** Keywords ***

Drag And Drop
    [Arguments]     ${src}    ${tgt}
    ${js}        Get File              acceptance/functions/drag-n-drop.js
    ${result}    Execute Javascript    ${js}; return DragNDrop('${src}', '${tgt}');
