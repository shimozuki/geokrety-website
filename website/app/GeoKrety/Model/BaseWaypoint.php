<?php

namespace GeoKrety\Model;

use DB\SQL\Schema;

/**
 * @property int|null id
 * @property string waypoint
 * @property int|null elevation
 * @property string|null country
 * @property string position
 * @property float lat
 * @property float lon
 */
abstract class BaseWaypoint extends Base {
    protected $db = 'DB';
    protected $ttl = GK_SITE_CACHE_TTL_WAYPOINT;
    use \Validation\Traits\CortexTrait;

    protected $fieldConf = [
        'waypoint' => [
            'type' => Schema::DT_VARCHAR128,
            'nullable' => false,
        ],
        'elevation' => [
            'type' => Schema::DT_INT2,
            'default' => '-32768',
            'nullable' => true,
        ],
        'country' => [
            'type' => Schema::DT_VARCHAR128,
            'nullable' => true,
        ],
        'position' => [
            'type' => Schema::DT_VARCHAR128,
            'nullable' => false,
        ],
        'lat' => [
            'type' => Schema::DT_DOUBLE,
            'nullable' => true,
            'validate' => 'float',
        ],
        'lon' => [
            'type' => Schema::DT_DOUBLE,
            'nullable' => true,
            'validate' => 'float',
        ],
    ];

    public function get_lat($value): string {
        return number_format(floatval($value), 5, '.', '');
    }

    public function get_lon($value): string {
        return number_format(floatval($value), 5, '.', '');
    }

    abstract public function asArray(): array;
}
