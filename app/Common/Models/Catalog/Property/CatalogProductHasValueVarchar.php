<?php

namespace App\Common\Models\Catalog\Property;

use App\Common\Models\Main\BaseModel;
use App\Common\Models\Catalog\Product\CatalogProduct;

/**
 * This is the model class for table "ax_catalog_product_has_value_varchar".
 *
 * @property int $id
 * @property int $catalog_product_id
 * @property int $catalog_property_id
 * @property int|null $catalog_property_unit_id
 * @property string $value
 * @property int|null $sort
 * @property int|null $created_at
 * @property int|null $updated_at
 * @property int|null $deleted_at
 *
 * @property CatalogProduct $catalogProduct
 * @property CatalogProperty $catalogProperty
 * @property CatalogPropertyUnit $catalogPropertyUnit
 */
class CatalogProductHasValueVarchar extends BaseModel
{
    protected $table = 'ax_catalog_product_has_value_varchar';

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
