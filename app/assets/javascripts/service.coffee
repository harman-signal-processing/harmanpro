
jQuery ($) ->

  setupDatepicker = () -> $('.ui-datepicker-past-only').datepicker
    inline: true
    numberOfMonths: 1
    showButtonPanel: true
    dateFormat: "DD, MM d, yy"
    constrainInput: true
    maxDate: 0

  $('.trigger-datepicker').click -> setupDatepicker()

