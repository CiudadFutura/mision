$('#search').bind('autocompleteselect', function(event, ui) {
    $('#addItem').removeClass('disabled');
});