<?php

namespace GeoKrety\Controller\Devel;

use GeoKrety\GeokretyType;
use GeoKrety\Model\Geokret;
use GeoKrety\Model\User;
use GeoKrety\Model\WaypointGC;
use GeoKrety\Model\WaypointOC;

/**
 * Class DatabaseSeed.
 */
class DatabaseSeed extends Base {
    public function users_no_terms_of_use(\Base $f3) {
        $this->users($f3, $terms_of_use = false);
    }

    public function users(\Base $f3, $terms_of_use = true) {
        header('Content-Type: text');
        for ($i = 1; $i <= $f3->get('PARAMS.count'); ++$i) {
            $user = new User();
            $user->username = sprintf('username%d', $i);
            $user->password = 'password';
            $user->_email = sprintf('username%d+qa@geokrety.org', $i);
            $user->preferred_language = 'en';
            $user->account_valid = User::USER_ACCOUNT_VALID;
            if ($terms_of_use) {
                $user->touch('terms_of_use_datetime');
            }
            if ($user->validate()) {
                $user->save();
                echo sprintf("Create user: %s\n", $user->username);
            } else {
                echo sprintf("Error creating user: %s\n", $user->username);
                foreach (\Flash::instance()->getMessages() as $msg) {
                    echo sprintf("Reason: %s\n\n", $msg['text']);
                }
            }
        }

        echo "==========\n";
        echo 'done!';
    }

    public function geokrety(\Base $f3) {
        header('Content-Type: text');
        for ($i = 1; $i <= $f3->get('PARAMS.count'); ++$i) {
            $geokret = new Geokret();
            $geokret->name = 'geokrety%02d';
            $geokret->type = GeokretyType::GEOKRETY_TYPE_TRADITIONAL;
            if ($f3->exists('PARAMS.userid')) {
                $geokret->owner = $f3->get('PARAMS.userid');
            }
            if ($geokret->validate()) {
                $geokret->save();
                // Change info after initial saving
                $geokret->name = sprintf('geokrety%02d', $geokret->id);
                $geokret->tracking_code = sprintf('TC%04X', $geokret->id);
                $geokret->save();
                echo sprintf("Create GeoKret: %s %s\n", $geokret->gkid, $geokret->tracking_code);
            } else {
                echo sprintf("Error creating GeoKret: %s\n", $geokret->name);
                foreach (\Flash::instance()->getMessages() as $msg) {
                    echo sprintf("Reason: %s\n\n", $msg['text']);
                }
            }
        }

        echo 'OK';
    }

    public function waypointOC(\Base $f3) {
        header('Content-Type: text');
        for ($i = 1; $i <= $f3->get('PARAMS.count'); ++$i) {
            $wpt = new WaypointOC();
            $wpt->waypoint = 'OC%04d';
            $wpt->lat = 43.69365;
            $wpt->lon = 6.86097 + $i - 1;
            if ($wpt->validate()) {
                $wpt->save();
                $wpt->waypoint = sprintf('OC%04d', $wpt->id);
                $wpt->name = sprintf('OC Waypoint %04d', $wpt->id);
                $wpt->save();
                echo sprintf("Create OC wpt id:%s name:%s\n", $wpt->waypoint, $wpt->name);
            } else {
                echo sprintf("Error creating OC wpt: %s\n", $wpt->name);
                foreach (\Flash::instance()->getMessages() as $msg) {
                    echo sprintf("Reason: %s\n\n", $msg['text']);
                }
            }
        }

        echo 'OK';
    }

    public function waypointGC(\Base $f3) {
        header('Content-Type: text');
        for ($i = 1; $i <= $f3->get('PARAMS.count'); ++$i) {
            $wpt = new WaypointGC();
            $wpt->waypoint = 'GC%04d';
            $wpt->lat = 43.00000;
            $wpt->lon = 7.00000 + ($i - 1)/100;
            if ($wpt->validate()) {
                $wpt->save();
                $wpt->waypoint = sprintf('GC%04d', $wpt->id);
                $wpt->save();
                echo sprintf("Create GC wpt id:%s name:%s\n", $wpt->waypoint, $wpt->name);
            } else {
                echo sprintf("Error creating GC wpt: %s\n", $wpt->name);
                foreach (\Flash::instance()->getMessages() as $msg) {
                    echo sprintf("Reason: %s\n\n", $msg['text']);
                }
            }
        }

        echo 'OK';
    }
}
