<?php

namespace App\Common\Models;

use App\Common\Models\Blog\Post;
use App\Common\Models\Blog\PostCategory;
use App\Common\Models\Catalog\Category\CatalogCategory;
use App\Common\Models\Catalog\Product\CatalogProduct;
use App\Common\Models\Catalog\Product\CatalogProductWidgets;
use App\Common\Models\History\HasHistory;
use App\Common\Models\Main\BaseModel;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * This is the model class for table "{{%render}}".
 *
 * @property int $id
 * @property string $title
 * @property string $name
 * @property string|null $resource
 * @property int|null $created_at
 * @property int|null $updated_at
 * @property int|null $deleted_at
 *
 * @property CatalogCategory[] $catalogCategories
 * @property CatalogProduct[] $catalogProducts
 * @property CatalogProductWidgets[] $catalogProductWidgets
 * @property Post[] $posts
 * @property PostCategory[] $postCategories
 */
class Render extends BaseModel
{
    use HasHistory;

    protected $table = 'ax_render';

    public static function rules(string $type = 'create'): array
    {
        return ['create' => [],][$type] ?? [];
    }

    public static function byType(Model $model): Collection
    {
        return static::query()->where('resource', $model->getTable())->get();
    }
}
