{include file='macros/paginate.tpl'}

<a class="anchor" id="inventory"></a>
<h2>{t}Inventory{/t}</h2>

{if $geokrety}
{call pagination total=$geokretyTotal perpage=$geokretyPerPage anchor='inventory'}
<div class="table-responsive">
  <table class="table table-striped">
    <thead>
      <tr>
        <th></th>
        <th>{t}ID{/t} {sort column='id' type='numeric' anchor='inventory'}</th>
        <th class="text-center">{t}Owner{/t} {sort column='owner' type='alpha' anchor='inventory'}</th>
        <th class="text-center">{t}Last move{/t} {sort column='ru.data' type='amount' anchor='inventory'}</th>
        <th class="text-right"><img src="{$imagesUrl}/log-icons/dist.gif" title="{t}Distance{/t}" /> {sort column='droga' type='numeric' anchor='inventory'}</th>
        <th class="text-right"><img src="{$imagesUrl}/log-icons/2caches.png" title="{t}Caches count{/t}" /> {sort column='skrzynki' type='numeric' anchor='inventory'}</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
      {foreach from=$geokrety item=geokret}
      <tr class="{if $geokret->missing}danger{/if}">
        <td>
          {posicon gk=$geokret}
        </td>
        <td>
          {gklink gk=$geokret} {gkavatar gk=$geokret}<br />
          <small><span title="{$geokret->name}">{$geokret->name|truncate:30:"…"}</span></small>
        </td>
        <td class="text-center">
          {userlink user=$geokret->owner()}
        </td>
        <td class="text-center" nowrap>
          {logicon gk=$geokret}
          {if $geokret->lastLog->ruchData}
          {print_date date=$geokret->lastLog->ruchData}
          {else}
          {print_date date=$geokret->datePublished}
          {/if}
          <br />
          <small>{userlink user=$geokret->lastLog->author()}</small>
        </td>
        <td class="text-right">
          {$geokret->distance}
        </td>
        <td class="text-right">
          {$geokret->cachesCount}
        </td>
        <td>
          {if $geokret->isOwner()}
          <a class="btn btn-warning btn-xs" href="/edit.php?co=geokret&id={$geokret->id}" title="{t}Edit GeoKret{/t}">
            {fa icon="pencil"}
          </a>
          {/if}
          {if $geokret->hasCurrentUserSeenGeokretId()}
          {fa icon="smile-o"}
          {/if}
        </td>
      </tr>
      {/foreach}
    </tbody>
  </table>
</div>
{call pagination total=$geokretyTotal perpage=$geokretyPerPage anchor='inventory'}
{else}
  {if $user->isCurrentUser()}
    <em>{t escape=no}Your inventory is empty. Check <a href="/gkmap.php">the map</a> to find GeoKrety near you!{/t}</em>
  {else}
    <em>{t escape=no username=$user->username}%1's inventory is currently empty.{/t}</em>
  {/if}
{/if}
