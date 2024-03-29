<?php
    /** @var $post array */
?>
<!doctype html>
<html lang="ru">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="csrf-token" content="{{ csrf_token() }}"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Play:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/backend/css/main.css">
    <link rel="stylesheet" href="/backend/css/common.css">
    <title><?= config('app.company_name') ?> | Авторизация</title>
</head>

<body class="login-page">
<div class="container pt-5">
    <div class="row justify-content-center align-content-center">
        <div class="col-md-auto d-flex justify-content-center">
            <div class="card shadow">
                <div class="card-header bg-primary text-white flex-column">
                    <h4 class="text-center mb-0">Вход</h4>
                    <div class="text-center opacity-50 font-italic">в ваш аккаунт</div>
                    </div>
                    <div class="card-body p-4">
                        <form action="/registration" method="post">
                            {{ csrf_field() }}
                            <div class="form-group">
                                <div class="floating-label input-icon">
                                    <i class="material-icons">person_outline</i>
                                    <input type="text" class="form-control form-shadow" placeholder="name" name="name" value="<?= $post['name'] ?? null ?>">
                                    <label for="username">name</label>
                                    <div class="invalid-feedback"></div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="floating-label input-icon">
                                    <i class="material-icons">person_outline</i>
                                    <input type="text" class="form-control form-shadow" placeholder="last_name" name="last_name" value="<?= $post['last_name'] ?? null ?>">
                                    <label for="username">last_name</label>
                                    <div class="invalid-feedback"></div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="floating-label input-icon">
                                    <i class="material-icons">person_outline</i>
                                    <input type="text" class="form-control form-shadow" placeholder="email" name="email" value="<?= $post['email'] ?? null ?>">
                                    <label for="username">email</label>
                                    <div class="invalid-feedback"></div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="floating-label input-icon">
                                    <i class="material-icons">lock_open</i>
                                    <input type="password" class="form-control form-shadow" placeholder="Пароль" name="password">
                                    <label for="password">Пароль</label>
                                    <div class="invalid-feedback"></div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="floating-label input-icon">
                                    <i class="material-icons">lock_open</i>
                                    <input type="password" class="form-control form-shadow" placeholder="password_confirmation" name="password_confirmation">
                                    <label for="password">password_confirmation</label>
                                    <div class="invalid-feedback"></div>
                                </div>
                            </div>
                            <div class="form-group d-flex justify-content-between align-items-center">
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="remember">
                                    <label class="custom-control-label" for="remember">Запомнить</label>
                                    <div class="invalid-feedback"></div>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary btn-block">Войти</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
