<?php

use App\Common\Models\Catalog\Product\CatalogProduct;

/**
 * @var $model CatalogProduct
 * @var $coming bool
 */

$uuid = _uniq_id();

if($model->id) {
    $productOption = '<option value="' . $model->id . '" selected>' . $model->title . '</option>';
}
?>
<div class="mb-3 document-content js-catalog-document-content sort-handle">
    <div class="card h-100">
        <div class="card-header">
            Строка
            <div class="btn-group btn-group-sm ml-auto" role="group">
                <button type="button" class="btn btn-light btn-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                         fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                         stroke-linejoin="round" class="feather feather-plus">
                        <line x1="12" y1="5" x2="12" y2="19"></line>
                        <line x1="5" y1="12" x2="19" y2="12"></line>
                    </svg>
                </button>
                <button
                    type="button"
                    class="btn btn-light btn-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                         stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                         class="feather feather-edit">
                        <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                        <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                    </svg>
                </button>
                <button type="button" class="btn btn-light btn-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                         stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                         class="feather feather-trash">
                        <polyline points="3 6 5 6 21 6"></polyline>
                        <path
                            d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                    </svg>
                </button>
            </div>
            <div class="dropdown ml-1">
                <button class="btn btn-sm btn-light btn-icon dropdown-toggle no-caret" type="button"
                        id="dropdownMenuButton2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="material-icons">arrow_drop_down</i>
                </button>
                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuButton2" style="">
                    <button class="dropdown-item" type="button">Action</button>
                    <button class="dropdown-item" type="button">Another action</button>
                    <button class="dropdown-item" type="button">Something else here</button>
                </div>
            </div>
            <button
                type="button"
                data-js-document-content-value-id=""
                data-js-document-content-array-id="<?= $uuid ?>"
                class="ml-1 btn btn-sm btn-light btn-icon">
                <i class="material-icons">close</i>
            </button>
        </div>
        <div class="card-body">
            <div class="input-group">
                <div class="form-group product small">
                    <label>
                        Продукт
                        <select
                            class="form-control select2 js-document-get-product"
                            data-placeholder="Продукт"
                            data-select2-search="true"
                            data-validator-required
                            data-validator="contents.<?= $uuid ?>.catalog_product_id"
                            name="contents[<?= $uuid ?>][catalog_product_id]">
                            <option></option>
                            <?= $productOption ?? null ?>
                        </select>
                    </label>
                    <div class="invalid-feedback"></div>
                </div>
                <div class="form-group quantity-product small">
                    <label>
                        Кол.
                        <input
                            type="number"
                            value="1"
                            name="contents[<?= $uuid ?>][quantity]"
                            class="form-control form-shadow quantity"
                            data-validator-required
                            data-validator="contents.<?= $uuid ?>.quantity"
                            placeholder="Количество">
                    </label>
                    <div class="invalid-feedback"></div>
                </div>
                <?php if(0){ ?>
                <div class="form-group storage small">
                    <label>
                        Склад
                        <select
                            class="form-control select2 js-document-content-storage"
                            data-placeholder="Склад"
                            data-allow-clear="true"
                            data-select2-search="true"
                            name="contents[<?= $uuid ?>][catalog_storage_id]">
                            <option></option>
                        </select>
                    </label>
                    <div class="invalid-feedback"></div>
                </div>
                <?php } ?>
                <?php if($coming ?? false){ ?>
                <div class="form-group price-product small">
                    <label>
                        Цена поступление
                        <input
                            type="number"
                            value="<?= $model->price_in ?? null ?>"
                            name="contents[<?= $uuid ?>][price]"
                            class="form-control form-shadow price_in"
                            data-validator="contents.<?= $uuid ?>.price"
                            placeholder="Цена">
                    </label>
                </div>
                <div class="form-group price-product small">
                    <label>
                        Цена продажи
                        <input
                            type="number"
                            value="<?= $model->price ?? $model->product_price ?? null ?>"
                            name="contents[<?= $uuid ?>][price_out]"
                            class="form-control form-shadow price_in"
                            data-validator="contents.<?= $uuid ?>.price_out"
                            placeholder="Цена продажи">
                    </label>
                </div>
                <?php } else { ?>
                <div class="form-group price-product small">
                    <label>
                        Цена
                        <input
                            type="number"
                            value="<?= $model->price ?? null ?>"
                            name="contents[<?= $uuid ?>][price]"
                            class="form-control form-shadow price_in"
                            data-validator="contents.<?= $uuid ?>.price"
                            placeholder="Цена">
                    </label>
                </div>
                <?php } ?>
                <div class="form-group stock-product small">
                    <label>
                        На складе
                        <input
                            type="text"
                            value="<?= $model->in_stock ?>"
                            class="form-control form-shadow in_stock" disabled>
                    </label>
                    <label>
                        Резерв
                        <input
                            type="text"
                            value="<?= $model->in_reserve ?>"
                            class="form-control form-shadow in_reserve" disabled>
                    </label>
                    <label>
                        До
                        <input
                            type="text"
                            value="<?= $model->reserve_expired_at ? _unix_to_string_moscow($model->reserve_expired_at) : null ?>"
                            class="form-control form-shadow reserve_expired_at" disabled>
                    </label>
                </div>
            </div>
        </div>
    </div>
</div>

