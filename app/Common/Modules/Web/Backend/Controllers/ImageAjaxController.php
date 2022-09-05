<?php

namespace Web\Backend\Controllers;

use Illuminate\Http\Response;
use Illuminate\Http\JsonResponse;
use App\Common\Models\Gallery\GalleryImage;
use App\Common\Http\Controllers\WebController;

class ImageAjaxController extends WebController
{
    public function deleteImage(): Response|JsonResponse
    {
        if ($post = $this->validation(GalleryImage::rules('delete'))) {
            $model = GalleryImage::deleteAnyImage($post);
            if ($model->getErrors()) {
                return $this->setErrors($model->getErrors())->badRequest()->error();
            }
            return $this->response();
        }
        return $this->error();
    }
}
