{extends file='base.tpl'}

{block name=content}
    <div class="row">
        <div class="col-md-3">
            <div class="panel panel-default">
                <div class="panel-heading">Database</div>
                <div class="panel-body">
                    <ul>
                        <li>
                            <a href="{'devel_database_reset'|alias}">Clear database</a>
                        </li>
                        <li>
                            <a href="{'devel_seed_users'|alias:sprintf('@count=%d', 1)}">Seed "1" user</a>
                            <ul>
                                <li>
                                    <a href="{'devel_seed_users_no_terms_of_use'|alias:sprintf('@count=%d', 1)}">Seed "1" user without terms of use</a>
                                </li>
                                <li>
                                    <a href="{'devel_seed_geokrety_user'|alias:sprintf('@count=%d,userid=%d', 1, 1)}">Seed "1" GeoKret</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="{'devel_seed_geokrety'|alias:sprintf('@count=%d', 1)}">Seed "1" GeoKret</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="panel panel-default">
                <div class="panel-heading">Generated</div>
                <div class="panel-body">
                    <ul>
                        <li>
                            <a href="{'devel_rebuild_templates'|alias}">Rebuild all templates</a>
                        </li>
                        <li>
                            <a href="{'devel_rebuild_translation'|alias}">Rebuild gettext files</a>
                        </li>
                        <li>
                            <a href="{'devel_assets_clear'|alias}">Clear assets</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="panel panel-default">
                <div class="panel-heading">…</div>
                <div class="panel-body">
                    <ul>
                        <li>
                            …
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="panel panel-default">
                <div class="panel-heading">…</div>
                <div class="panel-body">
                    <ul>
                        <li>
                            …
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
{/block}
