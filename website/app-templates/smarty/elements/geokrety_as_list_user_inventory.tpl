<tr class="{if $geokret->missing}danger{/if}">
    <td>
        {$geokret|posicon nofilter}
    </td>
    <td>
        {$geokret|gklink nofilter} {$geokret|gkavatar nofilter}<br />
        <small>{$geokret->gkid}</small>
    </td>
    <td class="text-center">
        {$geokret->owner|userlink nofilter}
    </td>
    <td class="text-center" nowrap>
        {if !is_null($geokret->last_log)}
        {$geokret->last_log|logicon:true nofilter}
        {$geokret->last_log->moved_on_datetime|print_date nofilter}
        <br />
        <small>{$geokret->last_log->author|userlink:$geokret->last_log->username nofilter}</small>
        {else}
        {$geokret->created_on_datetime|print_date nofilter}
        {/if}
    </td>
    <td class="text-right">
        {$geokret->distance|distance}
    </td>
    <td class="text-right">
        {$geokret->caches_count}
    </td>
    <td class="text-right">
        {if $geokret->isHolder()}
        <a class="btn btn-default btn-xs" href="{'move_create'|alias}?tracking_code={$geokret->tracking_code}" title="{t}Move this GeoKret{/t}">🛩️</a>
        {/if}
    </td>
</tr>
