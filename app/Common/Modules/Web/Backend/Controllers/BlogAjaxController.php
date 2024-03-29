<?php

namespace Web\Backend\Controllers;

use App\Common\Http\Controllers\BackendController;
use App\Common\Http\Requests\PostRequest;
use App\Common\Models\Blog\Post;
use App\Common\Models\Blog\PostCategory;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;
use Throwable;

class BlogAjaxController extends BackendController
{
    public function saveCategory(): Response|JsonResponse
    {
        if($post = $this->validation(PostCategory::rules())) {
            if($user = $this->getUser()) {
                $arr['user'] = $this->getUser();
                $arr['user_id'] = $user->id;
                $arr['ip'] = $this->getIp();
                $post = array_merge($arr, $post);
            }
            $model = PostCategory::createOrUpdate($post);
            if($errors = $model->getErrors()) {
                $this->setErrors($errors);

                return $this->badRequest()
                    ->error();
            }
            $view = $this->view('backend.blog.category_update', [
                'errors' => $this->getErrors(),
                'breadcrumb' => (new PostCategory)->breadcrumbAdmin(),
                'title' => 'Категория ' . $model->title,
                'model' => $model,
                'post' => $post,
            ])
                ->renderSections()['content'];
            $data = [
                'view' => _clear_soft_data($view),
                'url' => '/admin/blog/category-update/' . $model->id,
            ];

            return $this->setData($data)
                ->response();
        }

        return $this->error();
    }

    public function indexCategory(int $id = null)
    {
        $title = 'Новая категория';
        $model = new PostCategory();
        /** @var $model PostCategory */
        if($id && $model = PostCategory::query()
                ->where('id', $id)
                ->first()) {
            $title = 'Категория ' . $model->title;
        }

        return $this->view('backend.blog.category_update', [
            'errors' => $this->getErrors(),
            'breadcrumb' => (new PostCategory)->breadcrumbAdmin(),
            'title' => $title,
            'model' => $model,
            'post' => $this->request(),
        ]);
    }

    /**
     * @throws Throwable
     */
    public function savePost(PostRequest $request): Response|JsonResponse
    {
        $post = $request->all();
        if($user = $this->getUser()) {
            $post['user'] = $this->getUser();
            $post['user_id'] = $user->id;
            $post['ip'] = $this->getIp();
        }
        $model = Post::createOrUpdate($post);
        if($errors = $model->getErrors()) {
            return $this->setErrors($errors)
                ->badRequest()
                ->error();
        }
        $view = $this->view('backend.blog.post_update', [
            'errors' => $this->getErrors(),
            'breadcrumb' => (new Post)->breadcrumbAdmin(),
            'title' => 'Категория ' . $model->title,
            'model' => $model,
            'post' => $post,
        ])
            ->renderSections()['content'];
        $data = [
            'view' => _clear_soft_data($view),
            'url' => '/admin/blog/post-update/' . $model->id,
        ];

        return $this->setData($data)
            ->response();
    }

    public function indexPost(int $id = null)
    {
        $title = 'Статья';
        $model = new Post();
        /** @var $model Post */
        if($id && $model = Post::query()
                ->where('id', $id)
                ->first()) {
            $title .= ' ' . $model->title;
        }

        return $this->view('backend.blog.post_update', [
            'errors' => $this->getErrors(),
            'breadcrumb' => (new Post)->breadcrumbAdmin(),
            'title' => $title,
            'model' => $model,
            'post' => $this->request(),
        ]);
    }
}
