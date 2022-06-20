<?php

namespace App\Common\Models\Catalog\Document\Main;

use App\Common\Models\Catalog\Document\DocumentComing;
use App\Common\Models\Catalog\Document\DocumentWriteOff;
use App\Common\Models\Catalog\Storage\CatalogStoragePlace;
use App\Common\Models\Main\BaseModel;
use App\Common\Models\Main\EventSetter;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Support\Facades\DB;

/**
 * This is the model class for storage.
 *
 * @property int $id
 * @property int $counterparty_id
 * @property string|null $document
 * @property int|null $document_id
 * @property int $fin_transaction_type_id
 * @property int $catalog_storage_place_id
 * @property int|null $currency_id
 * @property int|null $status
 *
 * @property int|null $user_first_name
 * @property int|null $user_last_name
 * @property int|null $ip
 * @property int|null $fin_name
 * @property int|null $fin_title
 *
 * @property DocumentContentBase[] $contents
 */
class DocumentBase extends BaseModel
{
    use EventSetter;

    public static array $types = [
        DocumentComing::class => [
            'key' => 'coming',
            'title' => 'Поступление',
        ],
        DocumentWriteOff::class => [
            'key' => 'write_off',
            'title' => 'Списание',
        ],
    ];

    public ?DocumentContentBase $contentClass;

    public static function contentTable(string $column = '')
    {
        $string = (static::class) . 'Content';
        $column = $column ? '.' . trim($column, '.') : '';
        return (new $string())->getTable($column);
    }

    public static function createOrUpdate(array $post): static
    {
        if (
            empty($post['id'])
            || !$model = static::filter()
                ->where(static::table('id'), $post['id'])
                ->first()) {
            $model = new static();
            $model->status = static::STATUS_NEW;
        }
        $model->counterparty_id = $post['counterparty_id'] ?? 1; # TODO: remake
        $model->fin_transaction_type_id = $post['fin_transaction_type_id'];
        $model->catalog_storage_place_id = $post['catalog_storage_place_id']
            ?? CatalogStoragePlace::query()
                ->where('is_place', 1)
                ->first()->id;
        $model->setDocument($post['document'] ?? null);
        $model->setContent($post['contents'] ?? null);
        return $model;
    }

    public function getContentClass(): DocumentContentBase
    {
        if (empty($this->contentClass)) {
            $this->setContentClass();
        }
        return $this->contentClass;
    }

    public function setContentClass(): static
    {
        $string = (static::class) . 'Content';
        $this->contentClass = new $string();
        return $this;
    }

    public function setContent(?array $post): static
    {
        if (empty($post)) {
            return $this->setErrors(['content' => 'Документ не может быть пустым']);
        }
        if ($this->isDirty()) {
            $this->safe();
        }
        if ($this->getErrors()) {
            return $this;
        }
        $cont = [];
        foreach ($post as $value) {
            $value['catalog_document_id'] = $this->id;
            $value['type'] = $this->subject->type_name ?? null;
            $value['subject'] = $this->key ?? null;
            $content = $this->getContentClass()::createOrUpdate($value);
            if ($err = $content->getErrors()) {
                $cont[] = null;
                $this->setErrors($err);
            } else {
                $cont[] = $content;
            }
        }
        if (!in_array(null, $cont, true)) {
            $this->setContents(new Collection($cont));
        } else {
            $this->setErrors(['content' => 'Произошли ошибки при записи']);
        }
        return $this;
    }

    public function setContents(Collection $contents): static
    {
        $this->contents = $contents;
        return $this;
    }

    public function setDocument(?string $json): static
    {
        if (!empty($json)) {
            $document = json_decode($json, false);
            if ($document && !empty($document['model']) && !empty($document['model_id'])) {
                $this->document = $document['model'];
                $this->document_id = $document['model_id'];
            } else {
                $this->setErrors(['document' => 'Не удалось распознать документ основание']);
            }
        }
        return $this;
    }

    public function contents(): HasMany
    {
        return $this->hasMany($this->getContentClass()::class, 'document_id', 'id')
            ->select([
                static::contentTable('*'),
                'product.title as product_title',
            ])
            ->join('ax_catalog_product as product', 'product.id', '=', static::contentTable('catalog_product_id'))
            ->orderBy(static::contentTable('created_at'));
    }

    public function posting(): static
    {
        DB::beginTransaction();
        $errors = [];
        if ($this->getErrors()) {
            return $this;
        }
        if (($contents = $this->contents) && count($contents)) {
            foreach ($contents as $content) {
                if ($error = $content->posting()->getErrors()) {
                    $errors[] = true;
                    $this->setErrors($error);
                }
            }
        }
        if ($errors) {
            DB::rollBack();
            return $this;
        }
        $this->status = static::STATUS_POST;
        if ($this->safe()->getErrors()) {
            DB::rollBack();
        } else {
            DB::commit();
        }
        return $this;
    }

    public static function deleteById(int $id)
    {
        $item = static::query()
            ->where('id', $id)
            ->where('status', '!=', static::STATUS_POST)
            ->first();
        if ($item) {
            return $item->delete();
        }
        return false;
    }

    # TODO: remake it, when it starts to slows down
    public static function allDocument(): array|Collection
    {
        $arr = [];
        foreach (self::$types as $class => $prop) {
            $arr[$prop['key']] = $class::filter();
        }
        $all = $arr['coming']
            ->union($arr['write_off'])
            ->get();
        return count($all) ? $all : [];
    }
}