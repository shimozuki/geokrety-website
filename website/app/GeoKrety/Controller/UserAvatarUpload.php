<?php

namespace GeoKrety\Controller;

use GeoKrety\Model\Picture;
use GeoKrety\PictureType;

class UserAvatarUpload extends AbstractPictureUpload {
    use \UserLoader;

    protected function generateKey(): string {
        return uniqid(sprintf('US%06d_', $this->user->id), true);
    }

    public function getBucket(): string {
        return GK_BUCKET_NAME_USERS_AVATARS;
    }

    public function getPictureType(): int {
        return PictureType::PICTURE_USER_AVATAR;
    }

    public function getEventNameBase(): string {
        return 'geokret.avatar';
    }

    public function setRelationships(Picture $picture): void {
        $picture->user = $this->user;
    }
}