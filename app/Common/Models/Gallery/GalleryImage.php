<?php

namespace App\Common\Models\Gallery;

use App\Common\Models\Errors\_Errors;
use App\Common\Models\Main\BaseModel;
use Exception;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Support\Str;
use Imagick;
use RuntimeException;

/**
 * This is the model class for table "{{%gallery_image}}".
 *
 * @property int $id
 * @property int $gallery_id
 * @property string $image
 * @property string|null $title
 * @property string|null $description
 * @property int|null $sort
 * @property int|null $created_at
 * @property int|null $updated_at
 * @property int|null $deleted_at
 *
 * @property Gallery $gallery
 */
class GalleryImage extends BaseModel
{
    private static array $types = [
        IMAGETYPE_GIF => 'gif',
        IMAGETYPE_JPEG => 'jpeg',
        IMAGETYPE_PNG => 'png',
        IMAGETYPE_BMP => 'bmp',
        IMAGETYPE_WBMP => 'wbmp',
        IMAGETYPE_WEBP => 'webp',
    ];
    protected $table = 'ax_gallery_image';

    protected static function boot()
    {
        self::creating(static function($model) {});
        self::created(static function($model) {});
        self::updating(static function($model) {});
        self::updated(static function($model) {});
        self::deleting(static function($model) {});
        self::deleted(static function($model) {
            /** @var self $model */
            $model->gallery->touch();
        });
        parent::boot();
    }

    public static function createOrUpdate(array $post): static
    {
        $inst = [];
        $collection = new self();
        $dir = self::createPath($post);
        foreach($post['images'] as $image) {
            /** @var $model self */
            if(($id = $image['id'] ?? null) && ($model = self::query()
                    ->where('id', $id)
                    ->first())) {
                if($image['title'] ?? null) {
                    $model->title = $image['title'];
                }
                if($image['description'] ?? null) {
                    $model->description = $image['description'];
                }
                if($image['sort'] ?? null) {
                    $model->sort = $image['sort'];
                }
                if($error = $model->safe()
                    ->getErrors()) {
                    $collection->setErrors($error);
                } else {
                    $inst[] = $model;
                }
            } else {
                if(!empty($image['file']) && file_exists($image['file'])) {
                    try {
                        $types = self::getType(exif_imagetype($image['file']));
                    } catch(Exception $e) {
                        $collection->setErrors(_Errors::exception($exception, $collection));
                    }
                    if($types) {
                        $url = Str::random(40) . '.' . $types;
                        $filename = public_path() . '/' . $dir . '/' . $url;

                        if(empty($post['images_copy'])) {
                            $suc = move_uploaded_file($image['file'], $filename);
                        } else {
                            $suc = copy($image['file'], $filename);
                        }
                        if($suc) {
                            $model = new static();
                            $model->title = $image['title'] ?? null;
                            $model->gallery_id = $post['gallery_id'];
                            $model->description = $image['description'] ?? null;
                            $model->sort = $image['sort'] ?? null;
                            $model->image = '/' . $dir . '/' . $url;
                            if($error = $model->safe()
                                ->getErrors()) {
                                $collection->setErrors($error);
                            } else {
                                $inst[] = $model;
                            }
                        }
                    }
                }
            }
        }

        return $collection->setCollection($inst);
    }

    public static function createPath(array $post): string
    {
        $dir = public_path('upload/' . $post['images_path']);
        if(!file_exists($dir) && !mkdir($dir, 0777, true) && !is_dir($dir)) {
            throw new RuntimeException(sprintf('Directory "%s" was not created', $dir));
        }

        return 'upload/' . $post['images_path'];
    }

    public static function getType(int $type): ?string
    {
        return self::$types[$type] ?? null;
    }

    public static function uploadSingleImage(array $post): ?string
    {
        $post['dir'] = self::createPath($post);

        return self::uploadImage($post);
    }

    public static function uploadImage(array $post): ?string
    {
        $has = file_exists($post['image']);
        if($has && $types = self::getType(exif_imagetype($post['image']))) {
            $url = Str::random(40) . '.' . $types;
            $filename = public_path() . '/' . $post['dir'] . '/' . $url;
            if(empty($post['images_copy'])) {
                $suc = move_uploaded_file($post['image'], $filename);
            } else {
                $suc = copy($post['image'], $filename);
            }
            if($suc) {
                return '/' . $post['dir'] . '/' . $url;
            }
        }

        return null;
    }

    public static function deleteAnyImage(array $data)
    {
        if(($model = BaseModel::className($data['model'])) && ($db = $model::find($data['id']))) {
            /** @var $db BaseModel */
            return $db->deleteImage();
        }

        return self::sendErrors();
    }

    public function deleteImage(): static
    {
        if($this->deleteImageFile()
            ->getErrors()) {
            return $this;
        }

        return $this->delete() ? $this : $this->setErrors(_Errors::error(['image' => 'не удалось удалить'], $this));
    }

    public static function rules(string $type = 'create'): array
    {
        return [
            'create' => [],
            'delete' => [
                'id' => 'required|integer',
                'model' => 'required|string',
            ],
        ][$type] ?? [];
    }

    public function gallery(): BelongsTo
    {
        return $this->belongsTo(Gallery::class, 'gallery_id', 'id');
    }

    public function webpConvert($file, $compression_quality = 80): bool
    {
        if(!file_exists($file)) {
            return false;
        }
        $file_type = exif_imagetype($file);
        $output_file = $file . '.webp';
        if(file_exists($output_file)) {
            return true;
        }
        if(function_exists('imagewebp')) {
            switch($file_type) {
                case IMAGETYPE_GIF:
                    $image = imagecreatefromgif($file);
                    break;
                case IMAGETYPE_JPEG:
                    $image = imagecreatefromjpeg($file);
                    break;
                case IMAGETYPE_PNG:
                    $image = imagecreatefrompng($file);
                    imagepalettetotruecolor($image);
                    imagealphablending($image, true);
                    imagesavealpha($image, true);
                    break;
                case IMAGETYPE_BMP:
                    $image = imagecreatefrombmp($file);
                    break;
                case IMAGETYPE_WBMP:
                    return false;
                    break;
                case IMAGETYPE_XBM:
                    $image = imagecreatefromxbm($file);
                    break;
                default:
                    return false;
            }
            $result = imagewebp($image, $output_file, $compression_quality);
            if(false === $result) {
                return false;
            }
            imagedestroy($image);

            return $output_file;
        }
        if(class_exists('Imagick')) {
            $suc = false;
            try {
                $image = new Imagick();
                $image->readImage($file);
                if($file_type === IMAGETYPE_PNG) {
                    $image->setImageFormat('webp');
                    $image->setImageCompressionQuality($compression_quality);
                    $image->setOption('webp:lossless', 'true');
                }
                $suc = $image->writeImage($output_file);
            } catch(Exception $exception) {
                $this->setErrors(_Errors::exception($exception, $this));
            }

            return $suc;
        }

        return false;
    }

    public function getImage(): string
    {
        return $this->image;
    }
}
