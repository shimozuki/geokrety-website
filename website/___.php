<?php

require_once '__sentry.php';

use Gkm\Gkm;
use Gkm\GkmClient;
use Gkm\Domain\GeokretyNotFoundException;

use Consistency\GkmConsistencyCheck;

$cgeoProbeGeokretyId = 46464;
$anotherGeokretyId = 69469;
$unknownGeokretyId = 145454545454545;

$gkmClient = new GkmClient();
$gkm = new Gkm();

$geokrets = [$anotherGeokretyId, $unknownGeokretyId];
$geokrets = [$cgeoProbeGeokretyId, $unknownGeokretyId];


function objectToHtml($var) {
   $rep = print_r($var, true);
   return '<pre>' . htmlentities($rep) . '</pre>';
}

?>
<div style="float:right">
 <a href="#Todo">Todo</a> - <a href="#GkmClient">GkmClient</a>  - <a href="#Gkm">Gkm</a>
</div>

<h2>Done tasks</h2>
<ul>
 <li>initiate GkmClient into a create dedicated repository : https://github.com/GeoKretyMap/php-client</li>
 <li>create unit tests (mock http client?)</li>
</ul>

<h2>Todo or pending tasks</h2>
<ul>
 <li>WIP - specifications, cf wiki page <a href="https://github.com/geokrety/geokrety-website/wiki/Study-GKMConsistencyDesign">Study-GKMConsistencyDesign</a></li>
 <li>first version that compare geokrety sync</li>
 <li>use home-made template to define fields to use as comparator</li>
</ul>



<h2>GKMConsistencyCheck</h2>
<?php


$gkmConfig = [];
// $gkmConfig[GkmConsistencyCheck::CONFIG_API_ENDPOINT] = 'https://api.geokretymap.org';

$consistencyCheck = new GkmConsistencyCheck($gkmConfig);
$runResult = $consistencyCheck->run();

echo objectToHtml($runResult);


?>
<h2>GkmClient</h2>
<?php

foreach ($geokrets as &$geokretyId) {
    $action = "<h4>getBasicGeokretyById($geokretyId)</h6>";
    try {
        $response = $gkmClient->getBasicGeokretyById($geokretyId);
        echo $gkmClient->debugShowResponse($action, $response);
    } catch (GeokretyNotFoundException $notFoundException) {
        echo "$action: not found";
    } catch (ClientException $clientException) {
        echo $gkmClient->debugShowExceptionResponse($action, $clientException);
    }
    $action = "<h4>getFullGeokretyById($geokretyId)</h6>";
    try {
        $response = $gkmClient->getFullGeokretyById($geokretyId);
        echo $gkmClient->debugShowResponse($action, $response);
    } catch (GuzzleHttp\Exception\ClientException $clientException) {
        echo $gkmClient->debugShowExceptionResponse($action, $clientException);
    }
}

?>

<h2>Gkm</h2>
<?php

foreach ($geokrets as &$geokretyId) {
    echo "<h4>getGeokretyById($geokretyId)</h4>";
    try {
        $geokrety = $gkm->getGeokretyById($geokretyId);
        echo objectToHtml($geokrety);
    } catch (GeokretyNotFoundException $notFoundException) {
        echo "geokrety not found";
    }
}
