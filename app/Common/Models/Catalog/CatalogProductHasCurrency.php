<?php

namespace App\Common\Models\Catalog;

use App\Common\Console\Commands\Currency;
use App\Common\Models\BaseModel;

/**
 * This is the model class for table "{{%catalog_product_has_currency}}".
 *
 * @property int $catalog_product_id
 * @property int $currency_id
 * @property float $amount
 * @property int $date_rate
 *
 * @property CatalogProduct $catalogProduct
 * @property Currency $currency
 */
class CatalogProductHasCurrency extends BaseModel
{
    protected $table = ';catalog_product_has_currency';

    public static function rules(string $type = 'create'): array
    {
        return [][$type] ?? [];
    }

    public function attributeLabels()
    {
        return [
            'catalog_product_id' => 'Catalog Product ID',
            'currency_id' => 'Currency ID',
            'amount' => 'Amount',
            'date_rate' => 'Date Rate',
        ];
    }

    public function getCatalogProduct()
    {
        return $this->hasOne(CatalogProduct::className(), ['id' => 'catalog_product_id']);
    }

    public function getCurrency()
    {
        return $this->hasOne(Currency::className(), ['id' => 'currency_id']);
    }
}