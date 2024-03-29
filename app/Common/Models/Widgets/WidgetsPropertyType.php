<?php

namespace App\Common\Models\Widgets;

use App\Common\Models\Main\BaseModel;

/**
 * This is the model class for table "ax_widgets_property_type".
 *
 * @property int $id
 * @property string $resource Таблица в которой лежит value
 * @property string $title
 * @property string|null $description
 * @property int|null $sort
 * @property string|null $image
 * @property int|null $created_at
 * @property int|null $updated_at
 * @property int|null $deleted_at
 *
 * @property WidgetsProperty[] $widgetsProperties
 */
class WidgetsPropertyType extends BaseModel
{
    protected $table = 'ax_widgets_property_type';

    public function getWidgetsProperties()
    {
        return $this->hasMany(WidgetsProperty::className(), ['widgets_property_type_id' => 'id']);
    }
}
