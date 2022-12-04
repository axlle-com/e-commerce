/********** #start menu **********/
const _menu = {
    _block: {},
    click: function () {
        const self = this;
        const request = new _glob.request();
        $('body').on('click', '.js-spa-link', function (event) {
            event.preventDefault();
            const li = $(this);
            let page = '';
            try {
                page = $(this).find('a').attr('href').replace(/\//, '');
            } catch (e) {
                _glob.console.error(e.message);
            }
            request.setObject({'action': '/ajax/tokyo/route', page}).send((response) => {
                if (response.status && request.view) {
                    const wrapper = jQuery('.tokyo_tm_all_wrap');
                    const enter = wrapper.data('enter');
                    const exit = wrapper.data('exit');
                    const block = $(request.view);
                    block.removeClass('active');
                    block.removeClass('animated ' + exit);
                    self._block.html(block);
                    block.addClass('active');
                    block.addClass('animated ' + exit);
                    $('.active.js-spa-link').removeClass('active');
                    li.addClass('active');
                }
            });
        });
    },
    run: function (block) {
        const self = this;
        self._block = $(block);
        if (self._block.length) {
            this.click();
        }
    }
}
/********** #start load **********/
$(document).ready(function () {
    _glob.run();
    _menu.run('.rightpart_in');
})
