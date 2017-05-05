$(document).ready(function() {
	var dateFormat = "dd/mm/yyyy",
		from = $(".search-form .date-from")
			.datepicker({
				defaultDate: "+1w",
				changeMonth: true,
				numberOfMonths: 1,
				showButtonPanel: true
			})
			.on("change", function () {
				to.datepicker("option", "minDate", getDate(this));
			}),
		to = $(".search-form .date-to").datepicker({
				defaultDate: "+1w",
				changeMonth: true,
				numberOfMonths: 1,
				showButtonPanel: true
			})
			.on("change", function() {
				from.datepicker("option", "maxDate", getDate(this));
			});

	function getDate(element) {
		return $.datepicker.parseDate(dateFormat, element.value);
	}
});
