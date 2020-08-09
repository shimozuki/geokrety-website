*** Settings ***
Library         SeleniumLibrary  timeout=10  implicit_wait=0
Resource        ../functions/PageHome.robot
Force Tags      Movement

*** Variables ***
${TEST_GEOKRET_REF}     GK10BCD
${TEST_GEOKRET_CODE}    673CI2

*** Test Cases ***
Welcome: (EN) input geokret code
  [Documentation]    Tracking code should redirect to moves
  !Go To GeoKrety
  !V2 Enter TrackingCode            ${TEST_GEOKRET_CODE}
  !V2 Click On FoundGeokretLogIt
  Location Should Be                ${GK_URL}en/moves?tracking_code=${TEST_GEOKRET_CODE}
