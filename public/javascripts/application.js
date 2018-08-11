(function() {
  $('.datetime').daterangepicker({
      timePicker: true,
      timePickerIncrement: 30,
      singleDatePicker: true,
      locale: {
          format: 'DD/MM/YYYY h:mm A'
      }
  });
}).call(this)
