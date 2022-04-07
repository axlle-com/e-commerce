<?php

namespace App\Common\Models\Catalog;

use App\Common\Models\BaseModel;

/**
 * This is the model class for table "{{%catalog_property_value}}".
 *
 * @property int $id
 * @property int $property_id
 * @property string $value
 * @property int|null $created_at
 * @property int|null $updated_at
 * @property int|null $deleted_at
 *
 * @property CatalogProperty $property
 */
class CatalogPropertyValue extends BaseModel
{
    protected $table = ';catalog_property_value';

    public static function rules(string $type = 'create'): array
    {
        return [][$type] ?? [];
    }

    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'property_id' => 'Property ID',
            'value' => 'Value',
            'created_at' => 'Created At',
            'updated_at' => 'Updated At',
            'deleted_at' => 'Deleted At',
        ];
    }

    public function getProperty()
    {
        return $this->hasOne(CatalogProperty::className(), ['id' => 'property_id']);
    }
}