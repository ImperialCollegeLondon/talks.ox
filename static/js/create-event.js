$(function() {
    // Register event to show event group forms
    $('#id_event-group-enabled').on('change', function(ev) {
        if (ev.target.checked) {
            $('.event-group').slideDown(200);
        } else {
            $('.event-group').slideUp(200);
        }
    });
    // Trigger event
    $('#id_event-group-enabled').trigger('change');

    // Register event to show create event group form
    $('.event-group input:radio').on('change', function(ev) {
        var $target = $(ev.target);
        if (ev.target.value==="CRE") {
            $('.event-group-create .panel-body').slideDown(200);
            $('.event-group-create .form-control').prop("disabled", false);
        } else {
            $('.event-group-create .form-control').prop("disabled", true);
        }
    });
    // Trigger event
    $('.event-group input:radio').trigger('change');

    // Initialise datetimepicker's
    $('.js-datetimepicker').datetimepicker({
        format: 'dd/mm/yyyy hh:ii',
        autoclose: true,
    });

    // Set the default end-date to the start date when it is picked
    $('.js-datetimepicker.event-start').datetimepicker().on('changeDate', function(ev){
        $('.js-datetimepicker.event-end').datetimepicker('setDate', ev.date);
    });
});
