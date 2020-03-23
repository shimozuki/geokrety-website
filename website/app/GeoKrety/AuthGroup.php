<?php

namespace GeoKrety;

class AuthGroup extends \Auth {
    const AUTH_LEVEL_ANONYMOUS = 0;
    const AUTH_LEVEL_AUTHENTICATED = 1;
    const AUTH_LEVEL_ADMINISTRATORS = 90;
    const AUTH_LEVEL_SUPER_ADMINISTRATORS = 99;

    const AUTH_GROUP_ANONYMOUS = [
        self::AUTH_LEVEL_ANONYMOUS,
    ];

    const AUTH_GROUP_AUTHENTICATED = [
        self::AUTH_LEVEL_AUTHENTICATED,
        self::AUTH_LEVEL_ADMINISTRATORS,
        self::AUTH_LEVEL_SUPER_ADMINISTRATORS,
    ];

    const AUTH_GROUP_ADMINISTRATORS = [
        self::AUTH_LEVEL_ADMINISTRATORS,
        self::AUTH_LEVEL_SUPER_ADMINISTRATORS,
    ];

    const AUTH_GROUP_SUPER_ADMINISTRATORS = [
        self::AUTH_LEVEL_SUPER_ADMINISTRATORS,
    ];
}