<a class="anchor" id="gk-avatars-list"></a>
<div id="geokretPicturesList" class="panel panel-default{if !$avatars} hidden{/if} picturesList">
    <div class="panel-body">
        <div class="gallery">
            {if $avatars}
            {foreach from=$avatars item=picture}
                    {$picture|picture nofilter}
            {/foreach}
            {/if}
        </div>
    </div>
</div>