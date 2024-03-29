const mix = require('laravel-mix');
const frontend = {
    path: 'public/frontend/fursie',
    css: [
        'resources/font/montserrat/montserrat.css',
        'resources/plugins/bootstrap-4-6-1/css/bootstrap.css',
        'resources/plugins/fontawesome-free/css/all.min.css',
        'resources/plugins/select2/css/select2.min.css',
        'resources/plugins/fancybox/fancybox.css',
        'resources/plugins/sweetalert2/sweetalert2.min.css',
        'resources/plugins/noty/noty.css',
        'resources/plugins/noty/themes/relax.css',
        'storage/template/css/my-bootstrap.css',
        'storage/template/css/header.css',
        'storage/template/css/footer.css',
        'storage/template/css/history.css',
        'storage/template/css/blog.css',
        'storage/template/css/article.css',
        'storage/template/css/style.css',
        'storage/template/css/modals.css',
    ],
    js: [
        'resources/plugins/jquery-3-6-0/jquery.min.js',
        'resources/plugins/bootstrap-4-6-1/js/bootstrap.js',
        'resources/plugins/select2/js/select2.full.js',
        'resources/plugins/select2/js/i18n/ru.js',
        'resources/plugins/fancybox/fancybox.umd.js',
        'resources/plugins/sweetalert2/sweetalert2.all.min.js',
        'resources/plugins/noty/noty.js',
        'resources/plugins/inputmask/jquery.inputmask.js',
    ],
    img: [
        'storage/template/assets/img',
        'storage/template/assets/icons',
    ],
    error404: function () {
        let _404Css = Array.from(this.css);
        _404Css.push('resources/backend/css/404.css');
        mix.styles(_404Css, this.path + '/css/_error.css');
        mix.styles(_404Css, this.path + '/css/error.css');
    },
    catalog: function () {
        let catalogJs = Array.from(this.js);
        /***** dev *****/
        catalogJs.push(
            'resources/plugins/isotope/isotope.pkgd.min.js',
            'resources/plugins/isotope/imagesloaded.pkgd.min.js',
            'resources/plugins/isotope/isotope_init.js',
        );
        mix.styles(this.css, this.path + '/css/_catalog.css');
        mix.scripts(catalogJs, this.path + '/js/_catalog.js');
        /***** prod *****/
        catalogJs.push(
            'public/main/js/glob.js',
            this.path + '/js/common.js',
        );
        mix.styles(this.css, this.path + '/css/catalog.css');
        mix.scripts(catalogJs, this.path + '/js/catalog.js');
    },
    product: function () {
        let productCss = Array.from(this.css);
        let productJs = Array.from(this.js);
        /***** #dev *****/
        productCss.push(
            'resources/plugins/fotorama/fotorama.css',
            'storage/template/css/product_card.css',
            'resources/plugins/swiffy/style.css',
        );
        productJs.push(
            'resources/plugins/isotope/imagesloaded.pkgd.min.js',
            'resources/plugins/fotorama/fotorama.js',
            'resources/plugins/swiffy/script.js',
        );
        mix.styles(productCss, this.path + '/css/_product.css');
        mix.scripts(productJs, this.path + '/js/_product.js');
        /***** prod *****/
        productCss.push(
            this.path + '/css/common.css'
        );
        productJs.push(
            'public/main/js/glob.js',
            this.path + '/js/common.js',
        );
        mix.styles(productCss, this.path + '/css/product.css');
        mix.scripts(productJs, this.path + '/js/product.js');
    },
    copy: function () {
        mix.copy(this.img, this.path + '/assets/img');
        mix.copy('resources/plugins/fontawesome-free/webfonts', 'public/frontend/webfonts');
    },
    main: function () {
        /***** #dev *****/
        mix.styles(this.css, this.path + '/css/_main.css');
        mix.scripts(this.js, this.path + '/js/_main.js');
        /***** #prod *****/
        this.css.push(this.path + '/css/common.css');
        this.js.push('public/main/js/glob.js', this.path + '/js/common.js');
        mix.styles(this.css, this.path + '/css/main.css');
        mix.scripts(this.js, this.path + '/js/main.js');
    }
}
const frontendTokyo = {
    path: 'public/frontend/tokyo',
    css: [
        'resources/font/montserrat/montserrat.css',
        'resources/plugins/bootstrap-4-6-1/css/bootstrap.css',
        'resources/plugins/fontawesome-free/css/all.min.css',
        'resources/plugins/select2/css/select2.min.css',
        'resources/plugins/fancybox/fancybox.css',
        'resources/plugins/sweetalert2/sweetalert2.min.css',
        'resources/plugins/noty/noty.css',
        'resources/plugins/noty/themes/relax.css',
        'storage/template/tokyo/css/plugins.css',
        'storage/template/tokyo/css/dark.css',
        'storage/template/tokyo/css/style.css',
    ],
    js: [
        'resources/plugins/jquery-3-6-0/jquery.min.js',
        'resources/plugins/bootstrap-4-6-1/js/bootstrap.js',
        'resources/plugins/select2/js/select2.full.js',
        'resources/plugins/select2/js/i18n/ru.js',
        'resources/plugins/fancybox/fancybox.umd.js',
        'resources/plugins/sweetalert2/sweetalert2.all.min.js',
        'resources/plugins/noty/noty.js',
        'resources/plugins/inputmask/jquery.inputmask.js',
        'storage/template/tokyo/js/plugins.js',
        'storage/template/tokyo/js/init.js',
    ],
    img: [
        'storage/template/tokyo/img',
    ],
    error404: function () {
        let _404Css = Array.from(this.css);
        _404Css.push('resources/backend/css/404.css');
        mix.styles(_404Css, this.path + '/css/_error.css');
        mix.styles(_404Css, this.path + '/css/error.css');
    },
    catalog: function () {
        let catalogJs = Array.from(this.js);
        /***** dev *****/
        catalogJs.push(
            'resources/plugins/isotope/isotope.pkgd.min.js',
            'resources/plugins/isotope/imagesloaded.pkgd.min.js',
            'resources/plugins/isotope/isotope_init.js',
        );
        mix.scripts(catalogJs, this.path + '/js/_catalog.js');
        /***** prod *****/
        catalogJs.push(
            'public/main/js/glob.js',
            this.path + '/js/common.js',
        );
        mix.scripts(catalogJs, this.path + '/js/catalog.js');

    },
    product: function () {
        let productCss = Array.from(this.css);
        let productJs = Array.from(this.js);
        /***** #dev *****/
        productCss.push(
            'resources/plugins/fotorama/fotorama.css',
            'storage/template/css/product_card.css',
            'resources/plugins/swiffy/style.css',
        );
        productJs.push(
            'resources/plugins/isotope/imagesloaded.pkgd.min.js',
            'resources/plugins/fotorama/fotorama.js',
            'resources/plugins/swiffy/script.js',
        );
        mix.styles(productCss, this.path + '/css/_product.css');
        mix.scripts(productJs, this.path + '/js/_product.js');
        /***** prod *****/
        productCss.push(
            this.path + '/css/common.css'
        );
        productJs.push(
            'public/main/js/glob.js',
            this.path + '/js/common.js',
        );
        mix.styles(productCss, this.path + '/css/product.css');
        mix.scripts(productJs, this.path + '/js/product.js');
    },
    copy: function () {
        mix.copy(this.img, this.path + '/assets/img');
        mix.copy('storage/template/tokyo/css/font', this.path + '/css/font');
    },
    main: function () {
        /***** #dev *****/
        mix.styles(this.css, this.path + '/css/_main.css');
        mix.scripts(this.js, this.path + '/js/_main.js');
        /***** #prod *****/
        this.css.push(this.path + '/css/common.css');
        this.js.push('public/main/js/glob.js', this.path + '/js/common.js');
        mix.styles(this.css, this.path + '/css/main.css');
        mix.scripts(this.js, this.path + '/js/main.js');
    }
}
const frontendLinoor = {
    path: 'public/frontend/linoor',
    css: [
        'resources/font/montserrat/montserrat.css',
        'resources/plugins/bootstrap-4-6-1/css/bootstrap.css',
        'resources/plugins/select2/css/select2.min.css',
        'resources/plugins/sweetalert2/sweetalert2.min.css',
        'resources/plugins/noty/noty.css',
        'resources/plugins/noty/themes/relax.css',
        'storage/template/linoor/css/fontawesome-all.css',
        'storage/template/linoor/css/owl.css',
        'storage/template/linoor/css/flaticon.css',
        'storage/template/linoor/css/linoor-icons-2.css',
        'storage/template/linoor/css/animate.css',
        'storage/template/linoor/css/jquery-ui.css',
        'storage/template/linoor/css/jquery.fancybox.min.css',
        'storage/template/linoor/css/hover.css',
        'storage/template/linoor/css/custom-animate.css',
        'storage/template/linoor/css/style.css',
        'storage/template/linoor/css/rtl.css',
        'storage/template/linoor/css/responsive.css',
        'storage/template/linoor/css/colors/color-default.css',
    ],
    js: [
        'resources/plugins/jquery-3-6-0/jquery.min.js',
        'resources/plugins/bootstrap-4-6-1/js/bootstrap.js',
        'resources/plugins/select2/js/select2.full.js',
        'resources/plugins/select2/js/i18n/ru.js',
        'resources/plugins/sweetalert2/sweetalert2.all.min.js',
        'resources/plugins/noty/noty.js',
        'resources/plugins/inputmask/jquery.inputmask.js',
        'storage/template/linoor/js/TweenMax.js',
        'storage/template/linoor/js/jquery-ui.js',
        'storage/template/linoor/js/jquery.fancybox.js',
        'storage/template/linoor/js/owl.js',
        'storage/template/linoor/js/mixitup.js',
        'storage/template/linoor/js/knob.js',
        'storage/template/linoor/js/appear.js',
        'storage/template/linoor/js/wow.js',
        'storage/template/linoor/js/jQuery.style.switcher.min.js',
        'storage/template/linoor/js/jquery.easing.min.js',
        'storage/template/linoor/js/custom-script.js',
    ],
    img: [
        'storage/template/linoor/images',
    ],
    error404: function () {
        let _404Css = Array.from(this.css);
        _404Css.push('resources/backend/css/404.css');
        mix.styles(_404Css, this.path + '/css/_error.css');
        mix.styles(_404Css, this.path + '/css/error.css');
    },
    copy: function () {
        mix.copy(this.img, this.path + '/assets/img');
        mix.copy('storage/template/linoor/fonts', this.path + '/fonts');
    },
    main: function () {
        /***** #dev *****/
        mix.styles(this.css, this.path + '/css/_main.css');
        mix.scripts(this.js, this.path + '/js/_main.js');
        /***** #prod *****/
        this.css.push(this.path + '/css/common.css');
        this.js.push('public/main/js/glob.js', this.path + '/js/common.js');
        mix.styles(this.css, this.path + '/css/main.css');
        mix.scripts(this.js, this.path + '/js/main.js');
    }
}
/** ### backend ### */
mix.styles([
    // 'resources/plugins/bootstrap-4-6-1/css/bootstrap.css',
    'resources/font/inter/inter.min.css',
    'resources/font/play/play.css',
    'resources/plugins/material-design-icons-iconfont/material-design-icons.min.css',
    'resources/plugins/fontawesome-free/css/all.min.css',
    'resources/plugins/simplebar/simplebar.min.css',
    'resources/plugins/summernote/summernote-bs4.css',
    'resources/plugins/select2/css/select2.min.css',
    'resources/plugins/flatpickr/flatpickr.min.css',
    'resources/plugins/noty/noty.css',
    'resources/plugins/noty/themes/relax.css',
    'resources/plugins/fancybox/fancybox.css',
    'resources/backend/css/style.css',
    'resources/backend/css/sidebar-dark.min.css',
    'resources/plugins/sweetalert2/sweetalert2.min.css',
], 'public/backend/mimity/css/main.css');
mix.scripts([
    'resources/plugins/jquery-3-6-0/jquery.min.js',
    'resources/backend/js/bootstrap.bundle.min.js',
    'resources/plugins/simplebar/simplebar.min.js',
    'resources/plugins/feather-icons/feather.min.js',
    'resources/plugins/summernote/summernote-bs4.min.js',
    'resources/plugins/select2/js/select2.full.js',
    'resources/plugins/select2/js/i18n/ru.js',
    'resources/plugins/flatpickr/flatpickr.js',
    'resources/plugins/flatpickr/l10n/ru.js',
    'resources/plugins/noty/noty.js',
    'resources/plugins/inputmask/jquery.inputmask.js',
    'resources/plugins/fancybox/fancybox.umd.js',
    'resources/plugins/sweetalert2/sweetalert2.all.min.js',
    'resources/plugins/sortablejs/Sortable.min.js',
    'resources/backend/js/script.min.js',
    'resources/plugins/date-format/date-format.js',
], 'public/backend/mimity/js/main.js');
mix.copy('resources/backend/img', 'public/img');
mix.copy([
    'resources/plugins/material-design-icons-iconfont/fonts',
    'resources/plugins/summernote/font'
], 'public/backend/css/fonts');
mix.copy('resources/plugins/fontawesome-free/webfonts', 'public/backend/webfonts');
mix.copy('resources/font/montserrat/font', 'public/font');
mix.copy('resources/font/play/font', 'public/font');

/** ### frontend ### */
frontend.copy();
frontend.catalog();
frontend.product();
frontend.main();
frontend.error404();
/** ### frontend Tokyo ### */
frontendTokyo.copy();
frontendTokyo.catalog();
frontendTokyo.product();
frontendTokyo.main();
frontendTokyo.error404();
/** ### frontend ### */
frontendLinoor.copy();
frontendLinoor.main();
frontendLinoor.error404();

/** ### backend v2 ### */
mix.styles([
    'resources/plugins/vuexy/css/vendors.min.css',
    'resources/plugins/vuexy/css/bootstrap.css',
    'resources/plugins/vuexy/css/bootstrap-extended.css',
    'resources/plugins/vuexy/css/colors.css',
    'resources/plugins/vuexy/css/components.css',
    'resources/plugins/vuexy/css/semi-dark-layout.css',
    'resources/plugins/vuexy/css/vertical-menu.css',
    'resources/plugins/vuexy/css/style.css',
    // 'resources/plugins/vuexy/css/common.css',
], 'public/backend/v2/css/main.css');
mix.scripts([
    'resources/plugins/vuexy/js/vendors.min.js',
    'resources/plugins/vuexy/js/app-menu.js',
    'resources/plugins/vuexy/js/app.js',
], 'public/backend/v2/js/main.js');
mix.copy([
    'resources/plugins/material-design-icons-iconfont/fonts',
    'resources/plugins/summernote/font'
], 'public/backend/css/fonts');
mix.copy('resources/plugins/fontawesome-free/webfonts', 'public/backend/webfonts');
mix.copy('resources/font/montserrat/font', 'public/font');
mix.copy('resources/font/play/font', 'public/font');
