<?php

namespace App\Common\Models\Catalog\Document;

use App\Common\Models\Catalog\Product\CatalogProduct;
use App\Common\Models\Catalog\Storage\CatalogStorage;
use App\Common\Models\Catalog\Storage\CatalogStoragePlace;
use App\Common\Models\Errors\_Errors;
use App\Common\Models\History\HasHistory;
use App\Common\Models\Main\BaseModel;
use App\Common\Models\Main\Status;

/**
 * This is the model class for storage.
 *
 * @property int $id
 * @property int $document_id
 * @property int $catalog_product_id
 * @property int $catalog_storage_id
 * @property int|null $price
 * @property int $quantity
 *
 * @property string|null $product_title
 *
 * @property CatalogStoragePlace $catalogStoragePlace
 * @property DocumentBase $document
 * @property CatalogProduct $catalogProduct
 */
class DocumentContentBase extends BaseModel
{
    use HasHistory;

    public ?DocumentBase $documentClass;

    public static function deleteContent(int $id): bool
    {
        $model = static::query()->select([static::table('*')])->join(static::documentTable(), static function($join) {
            $join->on(static::documentTable('id'), '=', static::table('document_id'))
                ->where(static::documentTable('status'), '!=', Status::STATUS_POST);
        })->find($id);
        return $model && $model->delete();
    }

    public static function documentTable(string $column = '')
    {
        $pos = strpos(static::class, 'Content');
        $string = substr(static::class, 0, $pos);
        $column = $column ? '.' . trim($column, '.') : '';
        return (new $string())->getTable($column);
    }

    protected static function boot()
    {
        parent::boot();
        static::created(static function($model) {
            $model->setHistory('created');
        });
        static::updated(static function($model) {
            $model->setHistory('updated');
        });
        static::deleted(static function($model) {
            $model->setHistory('deleted');
        });
    }

    public function posting(): static
    {
        $storage = CatalogStorage::_createOrUpdate(Document::document($this));
        if($errors = $storage->getErrors()) {
            return $this->setErrors($errors);
        }
        if(!empty($storage->id)) {
            $this->catalog_storage_id = $storage->id;
            $product = CatalogProduct::postingById($this->catalog_product_id);
            if($err = $product->getErrors()) {
                return $this->setErrors($err);
            }
            $this->safe('product_title');
            return $this;
        }
        return $this->setErrors(_Errors::error(['catalog_storage_id' => 'Должна быть принадлежность к складу'], $this));
    }

    public static function createOrUpdate(array $post, bool $isHistory = true): static
    {
        if(empty($post['document_content_id']) || !$model = self::query()->find($post['document_content_id'])) {
            $model = new static;
            $model->document_id = $post['document_id'];
        }
        $model->isHistory = $isHistory;
        $model->quantity = $post['quantity'] ?? 1;
        $model->catalog_product_id = $post['catalog_product_id'];
        if(defined('IS_MIGRATION')) {
            $model->created_at = $post['created_at'] ?? time();
            $model->updated_at = $post['updated_at'] ?? time();
            $model->price = $post['price_out'] ?? 0.0;
        }
        $model->setPrice($post);
        $model->safe();
        $model->product_title = CatalogProduct::query()->find($model->catalog_product_id)->title ?? '';
        return $model;
    }

    public function setPrice($post): static
    {
        $this->price = $post['price'] ?? 0.0;
        return $this;
    }
}
