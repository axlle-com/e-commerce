<?php

use App\Common\Models\Catalog\Property\CatalogProperty;
use App\Common\Models\Catalog\Property\CatalogPropertyUnit;

/* @var $models CatalogProperty[]
 * @var $property CatalogProperty
 * @var $units CatalogPropertyUnit[]
 * @var
 */

$uuid = _uniq_id();

?>
<?php if(isset($models) && count($models)){ ?>
<div class="col-md-12 mb-3 js-catalog-property-widget">
    <div class="card h-100">
        <div class="card-header">
            Свойство
            <div class="btn-group btn-group-sm ml-auto" role="group">
                <button type="button" class="btn btn-light btn-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                         fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                         stroke-linejoin="round" class="feather feather-plus">
                        <line x1="12" y1="5" x2="12" y2="19"></line>
                        <line x1="5" y1="12" x2="19" y2="12"></line>
                    </svg>
                </button>
                <button type="button" class="btn btn-light btn-icon">
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
                data-action="close"
                data-js-property-model=""
                data-js-property-id=""
                data-js-property-array-id="${uu}"
                class="ml-1 btn btn-sm btn-light btn-icon">
                <i class="material-icons">close</i>
            </button>
        </div>
        <div class="card-body">
            <div class="input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text">Свойство</span>
                </div>
                <div class="form-group prop small">
                    <select
                        class="form-control select2 js-property-type"
                        data-placeholder="Свойство"
                        data-select2-search="true"
                        name="property[<?= $uuid ?>][property_id]"
                        data-validator="property_id">
                        <option></option>
                        <?php foreach ($models as $model){ ?>
                            <?php
                                $type = $model->propertyType->resource ?? null;
                                $unis = $model->units ?? [];
                                $unisArr = [];
                                foreach ($unis as $uni){
                                    $unisArr[] = $uni->id;
                                }
                            ?>
                        <option
                            data-js-property-type="<?= $type ?>"
                            data-js-property-units="<?= json_encode($unisArr) ?>"
                            value="<?= $model['id'] ?>" <?= ($model['id'] == ($property->id ?? null)) ? 'selected' : ''?>>
                            <?= $model['title'] ?>
                        </option>
                        <?php } ?>
                    </select>
                    <div class="invalid-feedback"></div>
                </div>
                <div class="form-group units small">
                    <select
                        class="form-control select2 js-property-unit"
                        data-placeholder="Единицы"
                        data-select2-search="true"
                        name="property[<?= $uuid ?>][property_unit_id]"
                        data-validator="property_unit_id">
                        <option></option>
                        <?php foreach ($units as $unit){ ?>
                        <option
                            value="<?= $unit['id'] ?>" <?= ($unit['id'] == ($property->id ?? null)) ? 'selected' : ''?>>
                            <?= $unit['title'] ?>
                        </option>
                        <?php } ?>
                    </select>
                    <div class="invalid-feedback"></div>
                </div>
                <div class="form-group sort small">
                    <input
                        type="number"
                        name="property[<?= $uuid ?>][property_value_sort]"
                        class="form-control form-shadow"
                        placeholder="Сортировка">
                </div>
                <div class="form-group value small">
                    <input
                        type="hidden"
                        name="property[<?= $uuid ?>][property_value_id]">
                    <input
                        type="text"
                        name="property[<?= $uuid ?>][property_value]"
                        class="form-control form-shadow js-property-value"
                        placeholder="Значение">
                </div>
            </div>
        </div>
    </div>
</div>
<?php } ?>

