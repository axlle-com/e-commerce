<?php

namespace App\Common\Models\Catalog\Property;

use App\Common\Models\Catalog\Product\CatalogProduct;
use App\Common\Models\Main\BaseModel;

/**
 * This is the model class for table "ax_catalog_product_has_value_int".
 *
 * @property int $id
 * @property int $catalog_product_id
 * @property int $catalog_property_id
 * @property int|null $catalog_property_unit_id
 * @property int $value
 * @property int|null $sort
 * @property int|null $created_at
 * @property int|null $updated_at
 * @property int|null $deleted_at
 *
 * @property \App\Common\Models\Catalog\Product\CatalogProduct $catalogProduct
 * @property CatalogProperty $catalogProperty
 * @property CatalogPropertyUnit $catalogPropertyUnit
 */
class CatalogProductHasValueInt extends BaseModel
{
    protected $table = 'ax_catalog_product_has_value_int';

    public static function rules(string $type = 'create'): array
    {
        return [][$type] ?? [];
    }

    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'catalog_product_id' => 'Catalog Product ID',
            'catalog_property_id' => 'Catalog Property ID',
            'catalog_property_unit_id' => 'Catalog Property Unit ID',
            'value' => 'Value',
            'created_at' => 'Created At',
            'updated_at' => 'Updated At',
            'deleted_at' => 'Deleted At',
        ];
    }

    public function getCatalogProduct()
    {
        return $this->hasOne(CatalogProduct::class, ['id' => 'catalog_product_id']);
    }

    public function getCatalogProperty()
    {
        return $this->hasOne(CatalogProperty::class, ['id' => 'catalog_property_id']);
    }

    public function getCatalogPropertyUnit()
    {
        return $this->hasOne(CatalogPropertyUnit::class, ['id' => 'catalog_property_unit_id']);
    }
}
