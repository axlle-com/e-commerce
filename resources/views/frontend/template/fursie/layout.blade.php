<?php

use App\Common\Assets\MainAsset;
use App\Common\Models\User\UserWeb;
use App\Common\Widgets\Analytics;
use App\Common\Widgets\Basket;

/**
 * @var UserWeb $user
 */

$page = _active_home_page();

$config = [
    'name' => config('app.company_name'),
    'title' => $title ?? '',
    'file' => $style ?? 'main',
];

?>
        <!doctype html>
<html lang="ru">

<?= MainAsset::model()
    ->load($config)
    ->head() ?>

<body class="a-shop">
<?= Analytics::widget() ?>
<header>
    <nav class="navbar navbar-expand-lg navbar-light position-relative header__navbar">
        <a class="navbar-brand position-absolute header__logo" href="/">
            <img class="logo__image" src="<?= MainAsset::img('FurSie_logo.png') ?>" alt="">
        </a>

        <button class="navbar-toggler collapsed" type="button" data-toggle="collapse"
                data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="navbar-collapse collapse header__navbar-container" id="navbarsExampleDefault" style="">
            <ul class="navbar-nav m-auto header__menu">
                <?php if(0) { ?>
                <li class="nav-item <?= $page['home'] ?? '' ?>">
                    <a class="nav-link" href="/">Главная<span class="sr-only"></span></a>
                </li>
                <li class="nav-item <?= $page['history'] ?? '' ?>">
                    <a class="nav-link" href="/history">История</a>
                </li>
                <li class="nav-item <?= $page['blog'] ?? '' ?>">
                    <a class="nav-link" href="javascript:void(0);">Блог</a>
                </li>
                <li class="nav-item <?= $page['portfolio'] ?? '' ?>">
                    <a class="nav-link" href="/portfolio">Портфолио</a>
                </li>
                <li class="nav-item <?= $page['catalog'] ?? '' ?>">
                    <a class="nav-link" href="/catalog">Магазин</a>
                </li>
                <li class="nav-item <?= $page['contact'] ?? '' ?>">
                    <a class="nav-link" href="/contact">Контакты</a>
                </li>
                <?php } else { ?>
                <li class="nav-item <?= $page['home'] ?? '' ?>">
                    <a class="nav-link" href="/">Главная<span class="sr-only"></span></a>
                </li>
               <li class="nav-item <?= $page['blog'] ?? '' ?>">
                    <a class="nav-link" href="javascript:void(0);">Блог</a>
                </li>
              <li class="nav-item <?= $page['contact'] ?? '' ?>">
                    <a class="nav-link" href="/contact">Контакты</a>
                </li>
                <?php } ?>

            </ul>
        </div>

        <div class="header__navbar_right-wrap toolbar-item">
            <?php
            if($user){ ?>
            <a href="/user/profile" class="header__login-link">
                <svg aria-hidden="true" focusable="false" class="header__login-icon" viewBox="0 0 28.33 37.68">
                    <path
                            d="M14.17 14.9a7.45 7.45 0 1 0-7.5-7.45 7.46 7.46 0 0 0 7.5 7.45zm0-10.91a3.45 3.45 0 1 1-3.5 3.46A3.46 3.46 0 0 1 14.17 4zM14.17 16.47A14.18 14.18 0 0 0 0 30.68c0 1.41.66 4 5.11 5.66a27.17 27.17 0 0 0 9.06 1.34c6.54 0 14.17-1.84 14.17-7a14.18 14.18 0 0 0-14.17-14.21zm0 17.21c-6.3 0-10.17-1.77-10.17-3a10.17 10.17 0 1 1 20.33 0c.01 1.23-3.86 3-10.16 3z">
                    </path>
                </svg>
            </a>
                <?php
            }else{ ?>
            @include($template.'inc.auth')
                <?php
            } ?>
            <?= Basket::widget() ?>
        </div>
    </nav>
</header>
@include('errors.errors')
@yield('content')
<footer>
    <div class="footer__container">
        <div class="footer__top">
            <a class="footer__logo" href="/">
                <img class="footer__logo-image" src="<?= MainAsset::img('FurSie_logo.png') ?>" alt="">
            </a>
            <div class="socials">
                <a href="https://wa.me/79284252522?text=Здравствуйте!%20У%20меня%20вопрос." target="_blank"
                   rel="noopener noreferrer">
                    <img class="alignnone size-medium wp-image-631 alignright social__img"
                         src="<?= MainAsset::img('whatsapp.svg') ?>" alt="ссылка на Whatsapp" width="30"
                         height="30">
                </a>
                <a href="https://vk.com/fur_sie_2020" target="_blank" rel="noopener noreferrer">
                    <img class="alignnone size-medium wp-image-631 alignright social__img"
                         src="<?= MainAsset::img('VK_logo.svg') ?>" alt="ссылка на VK" width="30" height="30">
                </a>
                <a href="https://t.me/FuR_SiE_2020" target="_blank" rel="noopener noreferrer">
                    <img class="alignnone size-medium wp-image-630 alignright social__img"
                         src="<?= MainAsset::img('telegram.svg') ?>" alt="ссылка на telegram" width="30"
                         height="30">
                </a>
            </div>
        </div>
        <div class="footer__menu">
            <div class="row">
                <div class="col-md-6 footer__requisites">
                    <p>ИП Семенова Ирина Владимировна</p>
                    <p>ИНН: 235207950556 ОГРН: 314234811300075</p>
                    <p>Юр. адрес/Факт. адрес: 350904, г.Краснодар.</p>
                </div>
                <div class="col-md-6">
                    <p>
                        логотип | Семенова Ирина Владимировна<br>
                        все фотографии и права защищены | Семенова Ирина Владимировна<br>
                        2022
                    </p>
                </div>
            </div>
        </div>
    </div>
</footer>
<?= MainAsset::js() ?>
</body>
</html>
