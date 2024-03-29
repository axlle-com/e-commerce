<?php

namespace App\Common\Models\Widgets;

use App\Common\Models\Main\BaseModel;

/**
 * This is the model class for table "ax_widgets_has_value_int".
 *
 * @property int $id
 * @property int $widgets_id
 * @property int $widgets_property_id
 * @property int $value
 * @property int|null $sort
 * @property int|null $created_at
 * @property int|null $updated_at
 * @property int|null $deleted_at
 *
 * @property WidgetsProperty $widgetsProperty
 * @property Widgets $widgets
 */
class WidgetsHasValueInt extends BaseModel
{
    protected $table = 'ax_widgets_has_value_int';

    public function getWidgetsProperty()
    {
        return $this->hasOne(WidgetsProperty::class, ['id' => 'widgets_property_id']);
    }

    public function getWidgets()
    {
        return $this->hasOne(Widgets::class, ['id' => 'widgets_id']);
    }
}
