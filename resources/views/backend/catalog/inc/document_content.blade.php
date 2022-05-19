<?php

use App\Common\Models\Catalog\CatalogDocumentContent;


/* @var $model CatalogDocumentContent
 * @var
 */

$uuid = _uniq_id();

if ($model->catalog_product_id){
    $productOption = '<option value="'.$model->catalog_product_id.'" selected>'.$model->product_title.'</option>';
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
                data-js-document-content-value-id="<?= $model->id ?? null ?>"
                data-js-document-content-array-id=""
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
                            data-validator="document.<?= $uuid ?>.catalog_product_id"
                            name="document[<?= $uuid ?>][catalog_product_id]">
                            <option></option>
                            <?= $productOption ?? null ?>
                        </select>
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
                            name="document[<?= $uuid ?>][catalog_storage_id]">
                            <option></option>
                        </select>
                    </label>
                    <div class="invalid-feedback"></div>
                </div>
                <?php } ?>
                <div class="form-group price-product small">
                    <?php if($model->id){ ?>
                    <input type="hidden"
                           name="document[<?= $uuid ?>][catalog_document_content_id]"
                           value="<?= $model->id ?>">
                    <?php } ?>
                        <label>
                            Стоимость
                            <input
                                type="text"
                                value="<?= $model->price ?? null ?>"
                                name="document[<?= $uuid ?>][price]"
                                class="form-control form-shadow"
                                data-validator-required
                                data-validator="document.<?= $uuid ?>.price"
                                placeholder="Стоимость">
                        </label>
                </div>
                <div class="form-group stock small">
                    <?php if($model->in_stock){ ?>
                        <label>
                            На складе
                            <input
                                type="text"
                                value="<?= $model->in_stock ?>"
                                class="form-control form-shadow" disabled>
                        </label>
                        <?php } ?>
                    <?php if($model->in_reserve){ ?>
                        <label>
                            В резерве
                            <input
                                type="text"
                                value="<?= $model->in_reserve ?>"
                                class="form-control form-shadow" disabled>
                        </label>
                    <?php } ?>
                    <?php if($model->reserve_expired_at){ ?>
                        <label>
                            В резерве до
                            <input
                                type="text"
                                value="<?= _unix_to_string_moscow($model->reserve_expired_at) ?>"
                                class="form-control form-shadow" disabled>
                        </label>
                    <?php } ?>

                </div>
            </div>
        </div>
    </div>
</div>
