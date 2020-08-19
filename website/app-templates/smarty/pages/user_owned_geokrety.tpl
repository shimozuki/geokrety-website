{extends file='base.tpl'}

{block name=content}
{include file='macros/pagination.tpl'}
<a class="anchor" id="owned"></a>

<h2>🧺 {t}Owned GeoKrety{/t}</h2>
<div class="row">
    <div class="col-xs-12 col-md-9">

        {if $geokrety.subset}
        {call pagination pg=$pg anchor='owned'}
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th></th>
                        <th>{t}ID{/t}</th>
                        <th class="text-center">{t}Spotted in{/t}</th>
                        <th class="text-center">{t}Last move{/t}</th>
                        <th class="text-right">📏 {t}Distance{/t}</th>
                        <th class="text-right"><img src="{GK_CDN_IMAGES_URL}/log-icons/2caches.png" title="{t}Caches visited count{/t}" /></th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$geokrety.subset item=item}
                    {include file='elements/geokrety_as_list_user_owned_geokrety.tpl' geokret=$item}
                    {/foreach}
                </tbody>
            </table>
        </div>
        {call pagination pg=$pg anchor='owned'}
        {else}

        {if $user->isCurrentUser()}
        <em>{t escape=no url_map={'geokrety_map'|alias} url_create={'geokret_create'|alias}}You did not created any GeoKrety yet. Don't hesitate to <a href="%2">create your own GeoKrety</a> for free!{/t}</em>
        {else}
        <em>{t escape=no username=$user->username}%1 doesn't own any GeoKrety yet.{/t}</em>
        {/if}

        {/if}

    </div>
    <div class="col-xs-12 col-md-3">
        {include file='blocks/user/actions.tpl'}
    </div>
</div>

{/block}
