*** Settings ***
Library         SeleniumLibrary  timeout=10  implicit_wait=0
Resource        ../functions/FunctionsGlobal.robot
Resource        ../functions/PageMoves.robot
Resource        ../vars/moves.resource
Resource        ../vars/users.resource
Resource        ../vars/geokrety.resource
Force Tags      Moves    GeoKret Details    Move Comment    Missing
Test Setup      Seed

*** Variables ***
${COMMENT_1} =        Some comment !
${COMMENT_2} =        Another one

*** Test Cases ***

# Only One Missing Button Can Be Shown
# Missing Button Only For Some Types
# Multiple Missing Report Allowed
# Anonymous Cannot Report Missing
# Authenticated Can Report Missing
# Comment Is Mandatory
# Missing Can Be Deleted By It's Author
# Other Users Cannot Delete Missing Reports
# Recent Logs With Missing Should Be Shown Red On Homepage
# Recent GeoKrety With Missing Should Be Shown Red On Homepage
# GeoKrety With Missing Should Be Shown Red On Recently Posted Moves Page
# GeoKrety With Missing Should Be Shown Red On Owned GeoKrety Moves Page
# A New Log Position Reset The Missing Status



# Comment Is Shown In Modal
#     Sign In ${USER_1.name} Fast
#     Go To Url                               ${PAGE_GEOKRETY_1_DETAILS_URL}
#     Set Test Variable                       ${commentid}    ${1}
#     Click Element With Param                ${GEOKRET_DETAILS_MOVES_COMMENTS_DELETE_BUTTON}
#     Wait Until Modal                        Do you really want to delete this move comment?
#     Check Move Comment                      ${MODAL_DIALOG}${GEOKRET_DETAILS_MOVES_COMMENTS_ITEMS}
#
# Author Can Delete Comment
#     Sign In ${USER_1.name} Fast
#     Post Move Comment                       comment=${COMMENT_2}
#     Go To Url                               ${PAGE_GEOKRETY_1_DETAILS_URL}
#     Set Test Variable                       ${commentid}    ${1}
#     Click Element With Param                ${GEOKRET_DETAILS_MOVES_COMMENTS_DELETE_BUTTON}
#     Wait Until Modal                        Do you really want to delete this move comment?
#     Click Button                            ${MODAL_DIALOG_SUBMIT_BUTTON}
#     Page Should Not Contain Element         ${GEOKRET_DETAILS_MOVES_COMMENTS_FIRST_ITEM}
#     Set Test Variable                       ${commentid}    ${2}
#     Check Move Comment                      ${GEOKRET_DETAILS_MOVES_COMMENTS_SECOND_ITEM}    comment=${COMMENT_2}


*** Keywords ***

Seed
    Clear DB And Seed 2 users
    Seed 1 geokrety owned by 2
    Sign In ${USER_1.name} Fast
    Post Move                               ${MOVE_1}
    Sign Out Fast
