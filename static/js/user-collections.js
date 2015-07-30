$(function() {
    function dataFromEl(el) {
        var data = {};
        var eventID = $(el).data('event');
        var groupID = $(el).data('group');
        var collectionID = $(el).data('collection');
        if (eventID) { data.event = eventID; }
        if (groupID) { data.group = groupID; }
        if (collectionID) { data.collection = collectionID; }
        return data;
    }
    var csrftoken = $.cookie('csrftoken');
    $('.js-add-to-collection').click( function(ev) {
        var data = dataFromEl(ev.target);
        $.ajax({
            type: 'POST',
            url: document.collectionConfig.saveItemDefault,
            data: JSON.stringify(data),
            headers: {
                "X-CSRFToken": csrftoken,
            },
            contentType: "application/json; charset=utf-8",
            dataType: 'json',
            success: function(response) {
                // Hide the <a>
                $(ev.target).addClass('hidden');
                $(ev.target.nextElementSibling).removeClass('hidden');
                $('#add-to-collection-alert-container').html('<div class="alert alert-success alert-dismissible" role="alert">' +
                        'Talk has been added to the list' +
                    '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span>' +
                    '</button></div>');
                window.setTimeout(function() {
                        $("#add-to-collection-alert-container div.alert").fadeTo(500, 0).slideUp(500, function(){
                            $(this).remove();
                        });}, 2000);

            },
            error: function(err) {
                console.log(err);
                $('#add-to-collection-alert-container').html('<div class="alert alert-warning alert-dismissible" role="alert">' +
                    err +
                    '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span>' +
                    '</button></div>');
            },
        });
    });

    $('.js-remove-from-collection').click( function(ev) {
        var data = dataFromEl(ev.target);
        $.ajax({
            type: 'POST',
            url: document.collectionConfig.removeItemDefault,
            data: JSON.stringify(data),
            headers: {
                "X-CSRFToken": csrftoken,
            },
            contentType: "application/json; charset=utf-8",
            dataType: 'json',
            success: function(response) {
                $(ev.target).addClass('hidden');
                $(ev.target.previousElementSibling).removeClass('hidden');
                $('#add-to-collection-alert-container').html('<div class="alert alert-success alert-dismissible" role="alert">' +
                        'Talk has been removed from the list' +
                    '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span>' +
                    '</button></div>');
                window.setTimeout(function() {
                        $("#add-to-collection-alert-container div.alert").fadeTo(500, 0).slideUp(500, function(){
                            $(this).remove();
                        });}, 2000);

            },
            error: function(err) {
                console.log(err);
                $('#add-to-collection-alert-container').html('<div class="alert alert-warning alert-dismissible" role="alert">' +
                        err +
                    '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span>' +
                    '</button></div>');
            },
        });
    });
});
