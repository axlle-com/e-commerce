<?php

namespace Web\Backend\Controllers;

use App\Common\Http\Controllers\BackendController;
use App\Common\Models\Catalog\Storage\CatalogStorage;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;

class StorageAjaxController extends BackendController
{
    public function storageUpdatePriceOut(): Response|JsonResponse
    {
        if ($post = $this->validation()) {
            $model = CatalogStorage::updateCondition($post);
            if ($errors = $model->getErrors()) {
                $this->setErrors($errors);

                return $this->badRequest()->error();
            }

            return $this->setMessage('Все строки сохранены')->response();
        }

        return $this->error();
    }
}
