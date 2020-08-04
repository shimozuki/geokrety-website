# GeoKrety labels

Our label templates are stored internally in [`.svg`](https://en.wikipedia.org/wiki/Scalable_Vector_Graphics) and not
`php` code allowing everyone to contribute to our label templates.

We recommend usage of [Inkscape](https://inkscape.org/) (preferably version >= v1.0) which is available on GNU/Linux,
Windows and macOS as it's what's used in the backed to render label pictures.

# Rules
We expect new labels templates to respect some rules
* If `user manual` is provided, the English version must be hardcoded. Use the text `User's manual: 1. Take this GeoKret. Please note down his Tracking Code. 2. Hide in another cache. 3. Register the trip at https://geokrety.org`
as it's the one that's available in other languages.
* Files are rendered using the `svg` dimensions (ratio of `1:1`), so take care to fit in normal paper size.
* We support dynamic generation of QRCodes containing direct link to the logging page including `Tracking Code`.
For this, the template must include a specific placeholder. See [Adding QRCode](#adding-qrcode) section.
* We do not yet support GeoKrety avatars inclusion (PR are welcome!)
* You accept publishing your design under the [Creative Commons BY-NC-SA](https://creativecommons.org/licenses/by-nc-sa/4.0)
license.
* Try to keep in mind that some fields have variable length (GeoKrety name, Owner names), so leave the enough place in
your design. If necessary use clipping to truncate text when it'll too long.

# Technical details
As said before, the `svg` label templates are internally converted to `png` files using [Inkscape](https://inkscape.org/). It's an
automated process.

* The `svg` has to embed all necessary data such as the GeoKrety logo or background images.
* The GeoKret details (name, owner, reference number, tracking code, mission…) must not be hardcoded in the label
but use specific placeholder tags.
* In fact `svg` files are preprocessed by the [smarty template engine](https://www.smarty.net/)
which permit to use any GeoKrety (or linked) attribute value (it's php code ;). It also permit to eventually add some
logic behind the scene.
* We support [Emojis](https://en.wikipedia.org/wiki/Emoji) thanks to the [Twitter Color Emoji Font](https://github.com/eosrei/twemoji-color-font)
* All text are vectorized during process, please do not vectorize them in the template, so it can be edited later.
* Except [Twitter Color Emoji Font](https://github.com/eosrei/twemoji-color-font) we use fonts available in
standard Ubuntu distribution. If you need another one, please use a font with an open license and ask us to integrate it
in our docker [geokrety-svg-to-png](https://github.com/geokrety/geokrety-svg-to-png) image.

## Available tag placeholders
Here are the commonly used tags:
* `{$geokret->name}`: The GeoKret name
* `{$georket->gkid}`: The GeoKret `reference number` (ex: `GK1234`)
* `{$georket->tracking_code}`: The GeoKret `Tracking Code` (ex: `DQ9H4B`)
* `{$georket->mission}`: The GeoKret specific mission   
* `{$georket->owner->username}`: The GeoKret owner username
* `{$georket->type}`: The GeoKret `type` (ex: Traditional, Coin, Book…)  

Please refer to source code, especially the `Model` classes.

## <a name="adding-QRCode"></a>Adding QRCode
QRCodes are special parts, they are not generated by `php` code (`smarty`), but generated on the fly by an Inkscape plugin.
in order to have it well placed on the label template, we need to use placeholder. A placeholder is simply a rectangle
having the fixed id `placeholderQR`. During the label rendering, the placeholder will be replaced by the QRCode image.
Please take care to have it in a "good size" to have it scanned by most devices.

 Check other templates at https://github.com/geokrety/geokrety-website/tree/picture-s3-wip/website/app-templates/smarty/labels/
 to find examples.
 
 The simplest way is to copy/paste the placeholder from one of the other templates.
 
 ## Caveats
 As `svg` files are internally `xml`, the tag placeholders must be html encoded (the character `>` have to be replaced
 later by it's escaped equivalent `&gt;`). So we save the original file as `my_template.svg` and it will be automatically
 converted during the merge process as the filename `my_templace.tpl.svg`.