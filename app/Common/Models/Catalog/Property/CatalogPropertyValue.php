<?php

namespace App\Common\Models\Catalog\Property;

use App\Common\Models\Main\BaseModel;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

/**
 * This is the model class for table "ax_catalog_property_value".
 *
 * @property int $id
 * @property int $property_id
 * @property int|null $catalog_property_unit_id
 * @property string $value
 * @property int|null $created_at
 * @property int|null $updated_at
 * @property int|null $deleted_at
 *
 * @property CatalogProperty $property
 * @property CatalogPropertyUnit $catalogPropertyUnit
 */
class CatalogPropertyValue extends BaseModel
{
    protected $table = 'ax_catalog_property_value';

    public function property(): BelongsTo
    {
        return $this->belongsTo(CatalogProperty::class, 'property_id', 'id');
    }
}
