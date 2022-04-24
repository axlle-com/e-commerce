imageArray = {};
propertyTypeArray = {
    value_int: 'number',
    value_varchar: 'text',
    value_decimal: 'number',
    value_text: 'text',
};
sparePartArray = [];
const ERROR_MESSAGE = 'Произошла ошибка, попробуйте позднее!'
const uuid = function () {
    return Date.now().toString(36) + Math.random().toString(36).substr(2);
}
const notyError = function (message = 'Произошла ошибка!') {
    new Noty({
        type: 'error', text: '<h5>Внимание</h5>' + message, timeout: 4000
    }).show()
}
const notySuccess = function (message = 'Все прошло успешно!') {
    new Noty({
        type: 'success', text: '<h5>Внимание</h5>' + message, timeout: 4000
    }).show()
}
const notyInfo = function (message = 'Обратите внимание!') {
    new Noty({
        type: 'info', text: '<h5>Внимание</h5>' + message, timeout: 4000
    }).show()
}
const setLocation = function (curLoc) {
    try {
        history.pushState(null, null, curLoc);
        return;
    } catch (e) {
    }
    location.hash = '#' + curLoc;
}
const errorResponse = function (response, form = null) {
    let json;
    if (response && (json = response.responseJSON)) {
        let message = json.message;
        if (json.status_code === 400) {
            let error = json.error;
            if (error && Object.keys(error).length) {
                for (let key in error) {
                    let selector = `[data-validator="${key}"]`;
                    if (form) {
                        $(form).find(selector).addClass('is-invalid');
                    } else {
                        $(selector).addClass('is-invalid');
                    }
                }
            }
        }
        notyError(message ? message : ERROR_MESSAGE);
    }
}
const validationControl = function () {
    $('body').on('blur', '[data-validator-required]', function (evt) {
        let field = $(this);
        validationChange(field);
    })
}
const validationChange = function (field) {
    let err = false;
    if (field.val()) {
        field.removeClass('is-invalid');
    } else {
        field.addClass('is-invalid');
        err = true;
    }
    return err;
}
function MyCookie(name, value, options) {
    this.name = name;
    this.value = value;
    this.options = options;
}
MyCookie.prototype.getCookie = function () {
    let matches = document.cookie.match(new RegExp(
        "(?:^|; )" + this.name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
    ));
    return matches ? decodeURIComponent(matches[1]) : undefined;
};
MyCookie.prototype.setCookie = function () {
    this.options = this.options || {};
    let expires = this.options.expires;
    if (typeof expires == "number" && expires) {
        let d = new Date();
        d.setDate(d.getDate() + expires);
        expires = this.options.expires = d;
    }
    if (expires && expires.toUTCString) {
        this.options.expires = expires.toUTCString();
    }
    this.value = encodeURIComponent(this.value);
    let updatedCookie = this.name + "=" + this.value;
    for (let propName in this.options) {
        updatedCookie += "; " + propName;
        let propValue = this.options[propName];
        if (propValue !== true) {
            updatedCookie += "=" + propValue;
        }
    }
    document.cookie = updatedCookie;
};
const setMapsValue = () => {
    let cookie = new MyCookie('_maps_');
    if (!cookie.getCookie()) {
        cookie.options = {expires: '', path: '/'};
        cookie.setCookie();
    }
}
const globSendObject = (obj, url, callback) => {
    $.ajax({
        url: url,
        headers: {'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')},
        type: 'POST',
        dataType: 'json',
        data: obj,
        beforeSend: function () {
        },
        success: function (response) {
            callback(response);
        },
        error: function (response) {
            errorResponse(response);
        },
        complete: function () {
        }
    });
}
const globSendForm = (form, callback) => {
    let path = form.attr('action')
    let data = new FormData(form[0]);
    $.ajax({
        url: path,
        headers: {'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')},
        type: 'POST',
        dataType: 'json',
        data: data,
        processData: false,
        contentType: false,
        beforeSend: function () {
        },
        success: function (response) {
            callback(response);
        },
        error: function (response) {
            errorResponse(response, form);
        },
        complete: function () {
        }
    });
}
const inputMask = function () {
    Inputmask().mask(document.querySelectorAll('.inputmask'));

}
const fancybox = function () {
    Fancybox.bind('[data-fancybox]', {});
}
const dateRangePicker = function () {
    flatpickr('.daterangepicker', {
        mode: 'range',
        'locale': 'ru',
        dateFormat: 'd.m.Y',
    });
    flatpickr('.datepicker-wrap', {
        allowInput: true,
        clickOpens: false,
        wrap: true,
        'locale': 'ru',
        dateFormat: 'd.m.Y',
    })
}
/********** #start sendForm **********/

const confirmSave = (saveButton) => {
    Swal.fire({
        icon: 'warning',
        title: 'Вы уверены что хотите сохранить все изменения?',
        text: 'Изменения нельзя будет отменить',
        showDenyButton: true,
        confirmButtonText: 'Сохранить',
        denyButtonText: 'Отменить',
    }).then((result) => {
        if (result.isConfirmed) {
            saveForm(saveButton);
        } else if (result.isDenied) {
            Swal.fire('Изменения не сохранены', '', 'info')
        }
    })
}

const sendForm = () => {
    $('.a-shop .a-shop-block').on('click', '.js-save-button', function (e) {
        confirmSave($(this));
    });
}

const saveForm = (saveButton) => {
    let form = saveButton.closest('#global-form');
    let path = form.attr('action')
    let data = new FormData(form[0]);
    if (Object.keys(imageArray).length) {
        for (key_1 in imageArray) {
            data.append('images[' + key_1 + '][file]', imageArray[key_1]['file']);
        }
    }
    $.ajax({
        url: path,
        headers: {'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')},
        type: 'POST',
        dataType: 'json',
        data: data,
        processData: false,
        contentType: false,
        beforeSend: function () {
        },
        success: function (response) {
            if (response.status) {
                imageArray = {};
                let block = $('.a-shop-block');
                let html = $(response.data.view);
                block.html(html);
                App.select2();
                fancybox();
                $('.summernote-500').summernote({
                    height: 500
                });
                $('.summernote').summernote({
                    height: 150
                });
                flatpickr('.datetimepicker-inline', {
                    enableTime: true,
                    inline: true
                });
                Swal.fire('Сохранено', '', 'success');
                if (response.data.url) {
                    setLocation(response.data.url);
                }
            }
        },
        error: function (response) {
            errorResponse(response);
        },
        complete: function () {
        }
    });
}

/********** #end sendForm **********/
/********** #start images **********/

const confirmImage = (obj, image) => {
    Swal.fire({
        icon: 'warning',
        title: 'Вы уверены что хотите удалить изображение?',
        text: 'Изменения нельзя будет отменить',
        showDenyButton: true,
        confirmButtonText: 'Удалить',
        denyButtonText: 'Отменить',
    }).then((result) => {
        if (result.isConfirmed) {
            imageDelete(obj, image);
        } else if (result.isDenied) {
            Swal.fire('Изображение не удалено', '', 'info')
        }
    })
}

const imageAdd = () => {
    $('.a-shop').on('change', '.js-image-upload', function () {
        let input = $(this);
        let div = $(this).closest('fieldset');
        let image = div.find('.js-image-block');
        let file = window.URL.createObjectURL(input[0].files[0]);
        $('.js-image-block-remove').slideDown();
        if (image.length) {
            $(image).html(`<img data-fancybox src="${file}">`);
            fancybox();
        }
        notySuccess('Нажните сохранить, что бы загрузить изображение')
    });
}

const imageDelete = (obj, image) => {
    $.ajax({
        url: '/admin/blog/ajax/delete-image',
        headers: {'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')},
        type: 'POST',
        dataType: 'json',
        data: obj,
        beforeSend: function () {
        },
        success: function (response) {
            if (response.status) {
                image.remove();
                notySuccess('Изображение удалено', '', 'success')
            }
        },
        error: function (response) {
            errorResponse(response);
        },
        complete: function () {
        }
    });
}

const imagesArrayDraw = (array) => {
    if (Object.keys(array).length) {
        let block = $('.js-gallery-block');
        for (key in array) {
            let imageUrl = URL.createObjectURL(array[key]);
            let image = `<div class="md-block-5 js-gallery-item">
                            <div class="img rounded">
                                <img src="${imageUrl}" alt="Image">
                                <div class="overlay-content text-center justify-content-end">
                                    <div class="btn-group mb-1" role="group">
                                        <a data-fancybox="gallery" href="${imageUrl}">
                                            <button type="button" class="btn btn-link btn-icon text-danger">
                                                <i class="material-icons">zoom_in</i>
                                            </button>
                                        </a>
                                        <button type="button" class="btn btn-link btn-icon text-danger" data-js-image-array-id="${key}">
                                            <i class="material-icons">delete</i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div>
                                <div class="form-group small">
                                    <input class="form-control form-shadow" placeholder="Заголовок" name="images[${key}][sort]" value="">
                                    <div class="invalid-feedback"></div>
                                </div>
                                <div class="form-group small">
                                    <input class="form-control form-shadow" placeholder="Описание" name="images[${key}][title]" value="">
                                    <div class="invalid-feedback"></div>
                                </div>
                                <div class="form-group small">
                                    <input class="form-control form-shadow" placeholder="Сортировка" name="images[${key}][description]" value="">
                                    <div class="invalid-feedback"></div>
                                </div>
                            </div>
                        </div>`;
            block.append(image);
        }
        notyInfo('Нажмите "Сохранить", что бы загрузить изображение');
        fancybox();
    }
}

const imagesArrayAdd = () => {
    $('.a-shop').on('change', '#js-gallery-input', function (evt) {
        let array = {};
        let files = evt.target.files; // FileList object
        let fileArray = Array.from(files);
        $(this)[0].value = '';
        for (let i = 0, l = fileArray.length; i < l; i++) {
            let id = uuid();
            imageArray[id] = {};
            imageArray[id]['file'] = fileArray[i];
            array[id] = fileArray[i];
        }
        imagesArrayDraw(array);
    });
}

const imagesArrayDelete = () => {
    $('.a-shop').on('click', '[data-js-image-array-id]', function (evt) {
        let image = $(this).closest('.js-gallery-item');
        if (!image.length) {
            image = $(this).closest('.js-image-block').find('img');
            if (!image.length) {
                return;
            }
        }
        let id = $(this).attr('data-js-image-array-id');
        let idBd = $(this).attr('data-js-image-id');
        let model = $(this).attr('data-js-image-model');
        if (idBd && model) {
            confirmImage({'id': idBd, 'model': model}, image)
        } else {
            delete imageArray[id];
            image.remove();
        }
    });
}

/********** #end images **********/
/********** #start Currency **********/

const currencyShow = (obj, call) => {
    $.ajax({
        url: '/admin/catalog/ajax/show-rate-currency',
        headers: {'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')},
        type: 'POST',
        dataType: 'json',
        data: obj,
        beforeSend: function () {
        },
        success: function (response) {
            if (response.status) {
                call(response);
                notySuccess('Валюты загружены')
            }
        },
        error: function (response) {
            errorResponse(response);
        },
        complete: function () {
        }
    });
}

/********** #end Currency **********/
/********** #start catalog **********/

const catalogProductWidgetConfirm = (obj, image) => {
    Swal.fire({
        icon: 'warning',
        title: 'Вы уверены что хотите удалить виджет?',
        text: 'Изменения нельзя будет отменить',
        showDenyButton: true,
        confirmButtonText: 'Удалить',
        denyButtonText: 'Отменить',
    }).then((result) => {
        if (result.isConfirmed) {
            catalogProductWidgetDelete(obj, image);
        } else if (result.isDenied) {
            Swal.fire('Виджет не удален', '', 'info')
        }
    })
}
const catalogProductWidgetAdd = () => {
    $('.a-shop .a-shop-block').on('click', '.js-widgets-button-add', function (evt) {
        let formGroup = $(this).closest('.catalog-tabs').find('.widget-tabs-block');
        let uu = uuid();
        let widget = `<div class="col-sm-12 widget-tabs mb-4">
                        <div class="card h-100">
                            <div class="card-header">
                                Widget Tabs
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
                                    data-js-widget-model=""
                                    data-js-widget-id=""
                                    data-js-widget-array-id="${uu}"
                                    class="ml-1 btn btn-sm btn-light btn-icon">
                                    <i class="material-icons">close</i>
                                </button>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-sm-8 widgets-tabs js-widgets-tabs">
                                        <div>
                                            <fieldset class="form-block">
                                                <legend>Наполнение</legend>
                                                <div class="form-group small">
                                                    <input
                                                        class="form-control form-shadow"
                                                        placeholder="Заголовок"
                                                        name="tabs[${uu}][title]"
                                                        value="">
                                                    <div class="invalid-feedback"></div>
                                                </div>
                                                <div class="form-group small">
                                                    <input
                                                        class="form-control form-shadow"
                                                        placeholder="Заголовок короткий"
                                                        name="tabs[${uu}][title_short]"
                                                        value="">
                                                    <div class="invalid-feedback"></div>
                                                </div>
                                                <div class="form-group small">
                                                    <input
                                                        class="form-control form-shadow"
                                                        placeholder="Сортировка"
                                                        name="tabs[${uu}][sort]"
                                                        value="">
                                                    <div class="invalid-feedback"></div>
                                                </div>
                                                <div class="form-group small">
                                                <textarea
                                                    id="description"
                                                    name="tabs[${uu}][description]"
                                                    class="form-control summernote"></textarea>
                                                </div>
                                            </fieldset>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <fieldset class="form-block">
                                            <legend>Изображение</legend>
                                            <div class="block-image js-image-block"></div>
                                            <div class="form-group">
                                                <label class="control-label button-100" for="js-widgets-image-upload-${uu}">
                                                    <a type="button" class="btn btn-primary button-image">Загрузить
                                                        фото</a>
                                                </label>
                                                <input
                                                    type="file"
                                                    data-widgets-uuid="${uu}"
                                                    id="js-widgets-image-upload-${uu}"
                                                    class="custom-input-file js-image-upload"
                                                    name="tabs[${uu}][image]"
                                                    accept="image/*">
                                                <div class="invalid-feedback"></div>
                                            </div>
                                        </fieldset>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>`;
        formGroup.append(widget);
        $('.summernote').summernote({
            height: 150
        });
    });
}
const catalogProductWidgetArrayDelete = () => {
    $('.a-shop').on('click', '[data-js-widget-array-id]', function (evt) {
        let widget = $(this).closest('.widget-tabs');
        if (!widget.length) {
            return;
        }
        let idBd = $(this).attr('data-js-widget-id');
        let model = $(this).attr('data-js-widget-model');
        if (idBd && model) {
            catalogProductWidgetConfirm({'id': idBd, 'model': model}, widget);
        } else {
            widget.remove();
        }
    });
}
const catalogProductWidgetDelete = (obj, widget) => {
    $.ajax({
        url: '/admin/blog/ajax/delete-widget',
        headers: {'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')},
        type: 'POST',
        dataType: 'json',
        data: obj,
        beforeSend: function () {
        },
        success: function (response) {
            if (response.status) {
                notySuccess('Все изменения сохранены');
                widget.remove();
            }
        },
        error: function (response) {
            errorResponse(response);
        },
        complete: function () {
        }
    });
}
const catalogProductPropertyTypeChange = () => {
    $('.a-shop .a-shop-block').on('change', '.js-property-type', function (evt) {
        let block = $(this).closest('.js-catalog-property-widget');
        let typeArr = [], type, input, units;
        try {
            typeArr = $(this).find(':selected').attr('data-js-property-type').split('_has_');
            type = propertyTypeArray[typeArr[typeArr.length - 1]];
            let un = JSON.parse($(this).find(':selected').attr('data-js-property-units'));
            units = un[0] ? un[0] : 0;
        } catch (exception) {
            console.log(exception.message);
        }
        if (type) {
            input = block.find('.js-property-value');
            input.prop('type', type);
        }
        if (units) {
            $('.js-property-unit').val(units).trigger('change');
        } else {
            $('.js-property-unit').val(null).trigger('change');
        }
    });
}
const catalogProductPropertyAdd = () => {
    $('.a-shop .a-shop-block').on('click', '.js-catalog-property-add', function (evt) {
        let formGroup = $(this).closest('.catalog-tabs').find('.catalog-property-block');
        $.ajax({
            url: '/admin/catalog/ajax/add-property',
            headers: {'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')},
            type: 'POST',
            dataType: 'json',
            beforeSend: function () {
            },
            success: function (response) {
                if (response.status) {
                    let widget;
                    if (response.data && (widget = response.data.view)) {
                        formGroup.append(widget);
                        App.select2();
                    }
                }
            },
            error: function (response) {
                errorResponse(response);
            },
            complete: function () {
            }
        });
    });
}
const catalogProductPropertyArrayDelete = () => {
    $('.a-shop').on('click', '[data-js-property-array-id]', function (evt) {
        let widget = $(this).closest('.js-catalog-property-widget');
        if (!widget.length) {
            return;
        }
        let idBd = $(this).attr('data-js-property-id');
        let model = $(this).attr('data-js-property-model');
        if (idBd && model) {
            catalogProductPropertyConfirm({'id': idBd, 'model': model}, widget);
        } else {
            widget.remove();
        }
    });
}
const catalogProductPropertyConfirm = (obj, widget) => {
    Swal.fire({
        icon: 'warning',
        title: 'Вы уверены что хотите удалить виджет?',
        text: 'Изменения нельзя будет отменить',
        showDenyButton: true,
        confirmButtonText: 'Удалить',
        denyButtonText: 'Отменить',
    }).then((result) => {
        if (result.isConfirmed) {
            catalogProductPropertyDelete(obj, widget);
        } else if (result.isDenied) {
            Swal.fire('Виджет не удален', '', 'info')
        }
    })
}
const catalogProductPropertyDelete = (obj, widget) => {
    $.ajax({
        url: '/admin/blog/ajax/delete-property',
        headers: {'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')},
        type: 'POST',
        dataType: 'json',
        data: obj,
        beforeSend: function () {
        },
        success: function (response) {
            if (response.status) {
                notySuccess('Все изменения сохранены');
                widget.remove();
            }
        },
        error: function (response) {
            errorResponse(response);
        },
        complete: function () {
        }
    });
}
const catalogProductShowCurrency = () => {
    $('.a-shop').on('change', '[name="price[810]"].js-action', function (evt) {
        let input = $(this);
        let block = $(this).closest('.js-currency-block');
        let currencyGroup = block.find('[data-currency-code]');
        let currencyArray = [];
        let formatter = new Intl.NumberFormat('en-US', {
            maximumSignificantDigits: 2
        });
        currencyGroup.each(function (i) {
            currencyArray.push($(this).attr('data-currency-code'));
        });
        currencyShow({'currency': currencyArray}, (response) => {
            $.each(response.data, function (i, value) {
                let curr = i.replace('__', '');
                let selector = `[data-currency-code="${curr}"]`;
                block.find(selector).val(formatter.format(input.val() * (1 / value)));
            });
        })
    });
}

/********** #end catalog **********/
/********** #start postCategory **********/

const postCategorySendForm = () => {
}

/********** #end postCategory **********/
const config = () => {
    $('.summernote-500').summernote({
        height: 500
    });
    $('.summernote').summernote({
        height: 150
    });
    flatpickr('.datetimepicker-inline', {
        enableTime: true,
        inline: true
    });
    dateRangePicker();
    App.select2();
    inputMask();
    fancybox();
    $('#document-catalog-modal').on('hidden.bs.modal', function (e) {
        sparePartArray = [];
        let button = $('.js-document-catalog-modal-credit-spare-part-add');
        let span = button.find('span');
        span.html('');
        button.hide();
    });
}
const sort = () => {
    // create from all .sortable classes
    document.querySelectorAll('.sortable').forEach(function (el) {
        const swap = el.classList.contains('swap')
        Sortable.create(el, {
            swap: swap,
            animation: 150,
            handle: '.sort-handle',
            filter: '.remove-handle',
            onFilter: function (evt) {
                evt.item.parentNode.removeChild(evt.item)
            }
        })
    })

    // Shared lists
    Sortable.create(document.getElementById('left'), {
        animation: 150,
        group: 'shared', // set both lists to same group
        handle: '.sort-handle'
    })
    Sortable.create(document.getElementById('right'), {
        animation: 150,
        group: 'shared',
        handle: '.sort-handle'
    })

    // Cloning
    Sortable.create(document.getElementById('left-cloneable'), {
        animation: 150,
        group: {
            name: 'cloning',
            pull: 'clone' // To clone: set pull to 'clone'
        },
        handle: '.sort-handle'
    })
    Sortable.create(document.getElementById('right-cloneable'), {
        animation: 150,
        group: {
            name: 'cloning',
            pull: 'clone'
        },
        handle: '.sort-handle'
    })
}
$(document).ready(function () {
    config();
    setMapsValue();
    imageAdd();
    imagesArrayAdd();
    imagesArrayDelete();
    sendForm();
    catalogProductWidgetAdd();
    catalogProductWidgetArrayDelete();
    catalogProductShowCurrency();
    catalogProductPropertyAdd();
    catalogProductPropertyArrayDelete();
    catalogProductPropertyTypeChange();
})
