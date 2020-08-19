<div class="panel panel-default" id="userAwardsPanel">
  <div class="panel-heading">
    {t}Awards{/t}
  </div>
  <div class="panel-body">

    <p class="geokrety-created">
      {t escape=no user=$user->username|escape count=$geokretyOwned.count distance=$geokretyOwned.distance}%1 has created <strong>%2</strong> GeoKrety, which travelled <strong>%3</strong> km.{/t}
    </p>
    <span class="created-awards">
    {foreach $awardsGeoKretyOwned as $gkCount => $filename}
    {$filename|award:$gkCount nofilter}
    {/foreach}
    </span>

    <p class="geokrety-moved">
      {t escape=no user=$user->username|escape count=$geokretyMoved.count distance=$geokretyMoved.distance}%1 has moved <strong>%2</strong> GeoKrety on a total distance of <strong>%3</strong> km.{/t}
    </p>
    <span class="move-awards">
    {foreach $awardsGeoKretyMoved as $gkCount => $filename}
    {$filename|award:$gkCount nofilter}
    {/foreach}
    </span>

  </div>
</div>
