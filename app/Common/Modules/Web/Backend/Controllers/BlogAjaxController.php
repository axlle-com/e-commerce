<?php

namespace App\Common\Modules\Web\Backend\Controllers;

use App\Common\Http\Controllers\WebController;
use App\Common\Models\Blog\Post;
use App\Common\Models\Blog\PostCategory;
use App\Common\Models\User\UserWeb;
use Illuminate\Http\JsonResponse;

class BlogAjaxController extends WebController
{
    public function saveCategory(): JsonResponse
    {
        if ($post = $this->validation(PostCategory::rules())) {
            $model = PostCategory::createOrUpdate($post);
            if ($errors = $model->getErrors()) {
                $this->setErrors($errors);
                return $this->badRequest()->error();
            }
            $view = view('backend.blog.category_update', [
                'errors' => $this->getErrors(),
                'breadcrumb' => (new PostCategory)->breadcrumbAdmin(),
                'title' => 'Категория ' . $model->title,
                'model' => $model,
                'post' => $this->request(),
            ])->renderSections()['content'];
            $data = [
                'view' => $view,
                'url' => '/admin/blog/category-update/' . $model->id,
            ];
            return $this->setData($data)->response();
        }
        return $this->error();
    }

    public function indexuCategory(int $id = null)
    {
        $title = 'Новая категория';
        $model = new PostCategory();
        /* @var $model PostCategory */
        if ($id && $model = PostCategory::query()->where('id', $id)->first()) {
            $title = 'Категория ' . $model->title;
        }
        return view('backend.blog.category_update', [
            'errors' => $this->getErrors(),
            'breadcrumb' => (new PostCategory)->breadcrumbAdmin(),
            'title' => $title,
            'model' => $model,
            'post' => $this->request(),
        ]);
    }

    public function savePost(): JsonResponse
    {
        if ($post = $this->validation(Post::rules())) {
            $post['user_id'] = UserWeb::auth()->id;
            $model = Post::createOrUpdate($post);
            if ($errors = $model->getErrors()) {
                $this->setErrors($errors);
                return $this->badRequest()->error();
            }
            $view = view('backend.blog.post_update', [
                'errors' => $this->getErrors(),
                'breadcrumb' => (new Post)->breadcrumbAdmin(),
                'title' => 'Категория ' . $model->title,
                'model' => $model,
                'post' => $this->request(),
            ])->renderSections()['content'];
            $data = [
                'view' => $view,
                'url' => '/admin/blog/post-update/' . $model->id,
            ];
            return $this->setData($data)->response();
        }
        return $this->error();
    }

    public function indexPost(int $id = null)
    {
        $title = 'Статья';
        $model = new Post();
        /* @var $model Post */
        if ($id && $model = Post::query()->where('id', $id)->first()) {
            $title .= ' ' . $model->title;
        }
        return view('backend.blog.post_update', [
            'errors' => $this->getErrors(),
            'breadcrumb' => (new Post)->breadcrumbAdmin(),
            'title' => $title,
            'model' => $model,
            'post' => $this->request(),
        ]);
    }
}