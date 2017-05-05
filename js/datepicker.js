/*$(function () {
    $( "#datepicker" ).datepicker({
        showOn: "button",
        buttonImage: "../images/calendar-icon.png",
        buttonImageOnly: true,
        buttonText: "Selecione uma data"
    });
  });*/
  $( function() {
    var dateFormat = "dd/mm/yyyy",
      from = $( "#datepicker-from" )
        .datepicker({
          defaultDate: "+1w",
          changeMonth: true,
          numberOfMonths: 3
        })
        .on( "change", function() {
          to.datepicker( "option", "minDate", getDate( this ) );
        }),
      to = $( "#datepicker-to" ).datepicker({
        defaultDate: "+1w",
        changeMonth: true,
        numberOfMonths: 3
      })
      .on( "change", function() {
        from.datepicker( "option", "maxDate", getDate( this ) );
      });

    function getDate( element ) {
      var date;
      try {
        date = $.datepicker.parseDate( dateFormat, element.value );
      } catch( error ) {
        date = null;
      }

      return date;
    }
  } );
