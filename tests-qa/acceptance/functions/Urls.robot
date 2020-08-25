
*** Variables ***
${PAGE_SEED_USER}                       ${GK_URL}/devel/db/users/seed
${PAGE_SEED_GEOKRETY}                   ${GK_URL}/devel/db/geokrety/seed
${PAGE_SEED_GEOKRETY_OWNED_BY_USER_1}   ${GK_URL}/devel/db/users/1/geokrety/seed
${PAGE_SEED_GEOKRETY_OWNED_BY_USER_2}   ${GK_URL}/devel/db/users/2/geokrety/seed
${PAGE_SEED_WAYPOINT_OC}                ${GK_URL}/devel/db/waypoint/oc
${PAGE_SEED_WAYPOINT_GC}                ${GK_URL}/devel/db/waypoint/gc

${PAGE_LOGIN_USER}                      ${GK_URL}/devel/users/\${params.username}/login

${PAGE_DEV_MAILBOX_URL}                 ${GK_URL}/devel/mail
${PAGE_DEV_MAILBOX_FIRST_MAIL_URL}      ${GK_URL}/devel/mail/0
${PAGE_DEV_MAILBOX_SECOND_MAIL_URL}     ${GK_URL}/devel/mail/1
${PAGE_DEV_MAILBOX_THIRD_MAIL_URL}      ${GK_URL}/devel/mail/2
${PAGE_DEV_MAILBOX_FOURTH_MAIL_URL}     ${GK_URL}/devel/mail/3
${PAGE_DEV_RESET_DB_URL}                ${GK_URL}/devel/db/reset

${PAGE_HOME_URL}                        ${GK_URL}/en
${PAGE_HOME_URL_FR}                     ${GK_URL}/fr
${PAGE_TERMS_OF_USE_URL}                ${GK_URL}/en/terms-of-use
${PAGE_REGISTER_URL}                    ${GK_URL}/en/registration
${PAGE_SIGN_IN_URL}                     ${GK_URL}/en/login
${PAGE_SIGN_OUT_URL}                    ${GK_URL}/en/logout
${PAGE_NEWS_URL}                        ${GK_URL}/en/news
${PAGE_MOVES_URL}                       ${GK_URL}/en/moves

${PAGE_MOVES_EDIT_URL}                  ${GK_URL}/en/moves/\${params.moveid}/edit
${PAGE_MOVES_COMMENT_URL}               ${GK_URL}/en/moves/\${params.moveid}/comment
${PAGE_MOVES_DELETE_URL}                ${GK_URL}/en/moves/\${params.moveid}/delete

${PAGE_USER_1_PROFILE_URL}              ${GK_URL}/en/users/1
${PAGE_USER_2_PROFILE_URL}              ${GK_URL}/en/users/2
${PAGE_USER_1_PROFILE_URL_FR}           ${GK_URL}/fr/users/1

${PAGE_USER_RECENT_MOVES_URL}           ${GK_URL}/en/users/\${params.userid}/recent-moves
${PAGE_USER_INVENTORY_URL}              ${GK_URL}/en/users/\${params.userid}/inventory
${PAGE_USER_OWNED_GEOKRETY_URL}         ${GK_URL}/en/users/\${params.userid}/owned-geokrety
${PAGE_USER_OWNED_GEOKRETY_RECENT_MOVES_URL}    ${GK_URL}/en/users/\${params.userid}/owned/recent-moves

${PAGE_USER_1_BANER_TEMPLATE_URL}       ${GK_URL}/en/users/1/choose-statpic-template
${PAGE_USER_1_OBSERVATION_AREA_URL}     ${GK_URL}/en/users/1/observation-area
${PAGE_USER_CHANGE_PASSWORD_URL}        ${GK_URL}/en/user/update-password
${PAGE_USER_CHANGE_LANGUAGE_URL}        ${GK_URL}/en/user/preferred-language
${PAGE_USER_REFRESH_SECID_URL}          ${GK_URL}/en/user/refresh-secid
${PAGE_USER_CHANGE_EMAIL_URL}           ${GK_URL}/en/user/update-email

${PAGE_GEOKRETY_CREATE_URL}             ${GK_URL}/en/geokrety/create

${PAGE_GEOKRETY_1_DETAILS_URL}          ${GK_URL}/en/geokrety/GK0001
${PAGE_GEOKRETY_2_DETAILS_URL}          ${GK_URL}/en/geokrety/GK0002
${PAGE_GEOKRETY_3_DETAILS_URL}          ${GK_URL}/en/geokrety/GK0003

${PAGE_USER_EMAIL_CHANGE_VALIDATE_URL}  ${GK_URL}/en/user/email-change/validate
