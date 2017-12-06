var app = window.app = {};

app.Books = function() {
    this._input = $('#books-search-txt');
    this._initAutocomplete();
};

app.Books.prototype = {
    _initAutocomplete: function() {
        this._input
            .autocomplete({
                source: '/productos',
                appendTo: '#products-search-results',
                select: $.proxy(this._select, this)
            })
            .autocomplete('instance')._renderItem = $.proxy(this._render, this);
    },

    _select: function(e, ui) {
        this._input.val(ui.item.title + ' - ' + ui.item.author);
        return false;
    },

    _render: function(ul, item) {
        var markup = [
            '<span class="img">',
            '<img src="' + item.image_url + '" />',
            '</span>',
            '<span class="title">' + item.title + '</span>',
            '<span class="author">' + item.author + '</span>',
            '<span class="price">' + item.price + '</span>'
        ];
        return $('<li>')
            .append(markup.join(''))
            .appendTo(ul);
    }
};

