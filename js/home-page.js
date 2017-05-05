const bands = [];
const events = [];

(() => $.getJSON("/db-docs/temp-json-db/db-general.json", function(data) {
		$.each(data, function(key, val) {
			(key == 'bands' && val.forEach(band => bands.push(band)));
			(key == 'events' && val.forEach(band => events.push(band)));
		});
	})
)();

$(document).ready(function () {
	$('.carousel-content').slick({
		autoplay: true,
		arrows: true,
		dots: true,
		fade: true,
		prevArrow:"<img class='a-left control-c prev slick-prev' src='images/palheta.png'>",
		nextArrow:"<img class='a-right control-c next slick-next' src='images/palheta.png'>"
	});
});

$(".event-search").click(doSearch());

const doSearch = () => {
	let bandName = $(".bane-name").val().trim().toLowerCase(),
		addressFragments = formatAddressFromInput($(".address").val()),
		dateFrom = $(".date-from").val(),
		dateTo $(".date-to").val(),
		eventsFound = events.filter(event =>
			((event.start_date < dateTo && event.start_date > dateFrom) ||
			(event.end_date < dateTo && event.end_date > dateFrom) ||
			addressFragments.some(fragment => event.address.indexOf(fragment) != -1) ||
			events.bands.some(bandId => bands.some(band => band.id == bandId && band.name == bandName)))
		);
}

const formatAddressFromInput = string =>
	string.trim().toLowerCase()
		.replace('rua', '')
		.replace('bairro', '')
		.replace('cidade', '')
		.replace('estado', '')
		.replace('nº', '')
		.replace('número', '')
		.replace('numero', '')
		.split(' ');