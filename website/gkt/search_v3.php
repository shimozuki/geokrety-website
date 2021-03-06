<?php

require_once '../__sentry.php';

// export data via JSON śćńółżź

require '../templates/konfig.php';     // config

require_once '../longin_chceck.php';
$longin_status = longin_chceck();
$user = $longin_status['userid'];

//file_put_contents('debug.log', "---------------------\n", FILE_APPEND);
//file_put_contents('debug.log', $user."\n", FILE_APPEND);

// echo $user;

$g_lat = $_GET['lat'];
// autopoprawione...
$g_lon = $_GET['lon'];
// autopoprawione...
$g_mode = $_GET['mode'];
// autopoprawione...
$g_userid = $_GET['userid'];
// autopoprawione...import_request_variables('g', 'g_');

// function czysc_dane($link, $in){
    // return mysqli_real_escape_string($link, strip_tags($in));
// }

//$g_userid = czysc_dane($link, $g_userid);
// $g_lat = czysc_dane($link, $g_lat);
// $g_lon = czysc_dane($link, $g_lon);

//$g_lat = 60.63142;
//$g_lon = 124.85338;

$arr = array();

if (($g_mode == 'latlon') and is_numeric($g_lat) and is_numeric($g_lon)) {
    $latNE = $g_lat + 0.0001;
    $lonNE = $g_lon + 0.0001;
    $latSW = $g_lat - 0.0001;
    $lonSW = $g_lon - 0.0001;

    $link = DBConnect();

    //$now = date("Y-m-d H:i:s");

    // $sql = "SELECT gk.id, gk.nazwa, gk.opis, gk.owner as id_owner, us.user as owner, gk.data as data_utw, gk.droga, o.plik
    // FROM `gk-geokrety` AS gk
    // LEFT JOIN `gk-users` AS us ON (gk.owner = us.userid)
    // LEFT JOIN (SELECT id_kreta, plik FROM `gk-obrazki` GROUP BY id_kreta) AS o ON (o.id_kreta = gk.id)
    // LEFT JOIN (
    // SELECT x.*, y.lat, y.lon, y.waypoint, y.logtype
    // FROM (
    // SELECT id, max( DATA ) AS data_ost
    // FROM `gk-ruchy`
    // WHERE logtype !='2'
    // GROUP BY id) AS x
    // LEFT JOIN `gk-ruchy` AS y ON (x.id = y.id)
    // WHERE data_ost = y.data ) AS c ON (gk.id = c.id)
    // WHERE c.lat <= '$latNE' AND c.lon <= '$lonNE' AND c.lat >= '$latSW' AND c.lon >= '$lonSW' AND logtype !='4' ";

    $sql = "SELECT gk.id, gk.nazwa, ru.logtype
	FROM `gk-geokrety` AS gk
	LEFT JOIN `gk-ruchy` AS ru ON (gk.ost_pozycja_id = ru.ruch_id)
	WHERE (ru.logtype IN ('0','3')) AND (missing='0') AND (gk.typ != '2') AND (ru.lat <= '$latNE') AND (ru.lon <= '$lonNE') AND (ru.lat >= '$latSW') AND (ru.lon >= '$lonSW') ";

    //echo $sql;

    $result = mysqli_query($link, $sql);
    $i = 0;

    while ($row = mysqli_fetch_array($result)) {
        $arr[$i]['id'] = $row['id'];
        $arr[$i]['n'] = $row['nazwa'];
        ++$i;
    }
    mysqli_free_result($result);
    //header("Access-Control-Allow-Origin: http://www.geocaching.com");
    $http_origin = $_SERVER['HTTP_ORIGIN'];
    if ($http_origin == 'http://www.geocaching.com' || $http_origin == 'https://www.geocaching.com') {
        header("Access-Control-Allow-Origin: $http_origin");
    }
    header('Cache-Control: no-cache, must-revalidate');
    header('Pragma: no-cache');

    $OUTPUT = json_encode($arr);
}

// ----------------------------- OUT ------------------------------//

header('Content-Type: text/plain');
echo $OUTPUT;

// -- Piwik Tracking API init --
if (PIWIK_URL !== '') {
    require_once '../templates/piwik-php-tracker/PiwikTracker.php';
    PiwikTracker::$URL = PIWIK_URL;
    $piwikTracker = new PiwikTracker($idSite = PIWIK_SITE_ID);
    // $piwikTracker->enableBulkTracking();
    $piwikTracker->setTokenAuth(PIWIK_TOKEN);
    $piwikTracker->setUrl($config['adres'].'/export2.php');
    $piwikTracker->setIp($_SERVER['HTTP_X_FORWARDED_FOR']);
    $piwikTracker->setUserAgent($_SERVER['HTTP_USER_AGENT']);
    $piwikTracker->setLatitude($g_lat);
    $piwikTracker->setLongitude($g_lon);
    $piwikTracker->setBrowserLanguage($lang);
    $piwikTracker->doTrackPageView('GKT');
    // $piwikTracker->doBulkTrack();
}
// -- Piwik Tracking API end --
