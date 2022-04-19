<?php

/* @var $title string
 * @var $models array
 * @var $post array
 */
$quantity = $models['quantity'] ?? 0
?>
<a href="/catalog/basket" class="header__cart-link">
    <svg class="header__cart-icon" viewBox="0 0 37 40">
        <path
            d="M36.5 34.8L33.3 8h-5.9C26.7 3.9 23 .8 18.5.8S10.3 3.9 9.6 8H3.7L.5 34.8c-.2 1.5.4 2.4.9 3 .5.5 1.4 1.2 3.1 1.2h28c1.3 0 2.4-.4 3.1-1.3.7-.7 1-1.8.9-2.9zm-18-30c2.2 0 4.1 1.4 4.7 3.2h-9.5c.7-1.9 2.6-3.2 4.8-3.2zM4.5 35l2.8-23h2.2v3c0 1.1.9 2 2 2s2-.9 2-2v-3h10v3c0 1.1.9 2 2 2s2-.9 2-2v-3h2.2l2.8 23h-28z">
        </path>
    </svg>
    <div
        class="header__cart-counter"
        data-cart-count-bubble=""
        style="display: <?= $quantity ? 'flex' : 'none' ?>">
        <?= $quantity ?>
    </div>
</a>
<?php if(isset($models['items']) && count($models['items'])){ ?>
<div class="toolbar-dropdown cart-dropdown js-widget-cart">
    <?php foreach ($models['items'] as $model){ ?>
    <div class="entry">
        <div class="entry-thumb">
            <a href="/catalog/<?= $model['alias'] ?>">
                <img src="<?= $model['image'] ?>" alt="<?= $model['title'] ?>">
            </a>
        </div>
        <div class="entry-content">
            <h4 class="entry-title">
                <a href="/catalog/<?= $model['alias'] ?>"><?= $model['title'] ?></a>
            </h4><span class="entry-meta">1 x <?= $model['price'] ?></span>
        </div>
        <div class="entry-delete"><i class="icon-x"></i></div>
    </div>
    <?php } ?>
    <div class="text-right">
        <p class="text-gray-dark py-2 mb-0"><span class="text-muted">Итого:</span> &nbsp;<?= $models['sum'] ?></p>
    </div>
    <div class="d-flex">
        <div class="pr-2 w-50">
            <a class="btn btn-outline-secondary btn-sm btn-block mb-0" href="">Очистить</a>
        </div>
        <div class="pl-2 w-50">
            <a class="btn btn-outline-primary btn-sm btn-block mb-0" href="/catalog/basket">Оформить</a>
        </div>
    </div>
</div>
<?php }?>

