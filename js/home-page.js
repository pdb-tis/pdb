const bands = [];
const events = [];

(() => $.getJSON("../db-docs/temp-json-db/db-general.json", function(data) {
		$.each(data, function(key, val) {
			(key == 'bands' && val.forEach(band => bands.push(band)));
			(key == 'events' && val.forEach(band => events.push(band)));
		});
	})
)();

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

const buildResults = eventsFound => {
	let mainSection = $(".main-content");
	mainSection.children().hide();
	mainSection.css('overflow', 'scroll');
	mainSection.append(eventsFound.reduce((htmlString, event) => {
		htmlString += '<div class="search-results ' + event.id + '">';
		htmlString += '<h1> Eventos Encontrados </h1>';
		htmlString += '<img src="' + event.picture + '" alt="Imagem do Evento">';
		htmlString += '<h2>' + event.name + '</h2>';
		htmlString += '<p>' + event.description + '<br><br>';
		htmlString += 'De ' + event.start_date + ' a ' + event.end_date + '<br><br>';
		htmlString += 'Endereço: ' + event.address + '<br><br>';
		htmlString += 'Classificação: ' + event.age_rating + ' anos</p><br>';
		htmlString += '<div class="band-results">';
		htmlString += '<h3> Bandas participantes </h3>';
		htmlString += event.bands.map(bandId => bands.find(band => band.id == bandId))
						.reduce((string, band) => {
							string += '<div class="band-result">';
							string += '<img src="' + band.picture + '" alt="Imagem do Banda">';
							string += '<h3>' + band.name + '</h3>';
							string += '<p>' + band.description + '<br><br>';
							string += 'Maiores informações, clique <a href="' + band.web_site + '">aqui</a>!<br><br>';
							string += 'Contato: ' + band.phone + ' ou ' + band.email + '</p>';
							string += '</div>';
							return string;
						}, "");
		htmlString += '</div>';
		htmlString += '<p>Maiores informações, clique <a href="' + event.external_link + '">aqui</a>!</p>';
		htmlString += '<hr>';
		htmlString += '</div>';
		return htmlString;
	}, '<div class="results-container">') + '</div>');
};

const doSearch = () => {
	let bandName = $(".band-name").val().trim().toLowerCase(),
		addressFragments = formatAddressFromInput($(".address").val()),
		dateFrom = $(".date-from").val(),
		dateTo = $(".date-to").val(),
		eventsFound = events.filter(event =>
			((event.start_date < dateTo && event.start_date > dateFrom) ||
			(event.end_date < dateTo && event.end_date > dateFrom) ||
			addressFragments.some(fragment => event.address.indexOf(fragment) != -1) ||
			events.bands.some(bandId => bands.some(band => band.id == bandId && band.name == bandName)))
		);
	buildResults(eventsFound);
}

$(document).ready(function () {
	$('.carousel-content').slick({
		autoplay: true,
		arrows: true,
		dots: true,
		fade: true,
		prevArrow:"<img class='a-left control-c prev slick-prev' src='images/palheta.png'>",
		nextArrow:"<img class='a-right control-c next slick-next' src='images/palheta.png'>"
	});
	$(".event-search").click(doSearch);
	$("header h1").click(() => {
		$(".main-content").children(".carousel-content").show();
		$(".main-content").children(".results-container").remove();
	});
});



