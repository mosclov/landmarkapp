function searchCreateGmap(dataFromServer) {
  handler = Gmaps.build('Google');
  handler.buildMap({
      provider: {},
      internal: {id: 'map3'}
    },
    function() {
      markers = handler.addMarkers(dataFromServer);
      handler.bounds.extendWith(markers);
      handler.fitMapToBounds();
      handler.getMap().setZoom(12);
    }
  );
};


function loadAndCreateSearchGmap() {
  // Only load map data if we have a map on the page
  if ($('#map3').length > 0) {
    // Access the data-apartment-id attribute on the map element
    var map = $('#map3');
    //save the zipcode entered by user in this variable
    var landmarkZipCode = map.attr("data-landmark-zipcode")

    $.ajax({
      dataType: 'json',
      url: '/landmarks/map_locations?zipcode=' + landmarkZipCode,
      method: 'get',
      success: function(dataFromServer) {
        searchCreateGmap(dataFromServer);

      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert("Getting map data failed: " + errorThrown);
      }
    });
  }
};

// Create the map when the page loads the first time
$(document).on('ready', loadAndCreateSearchGmap);
// Create the map when the contents is loaded using turbolinks
// To be 'turbolinks:load' in Rails 5
$(document).on('page:load', loadAndCreateSearchGmap);
// To be 'turbolinks:load' in Rails 4
$(document).on('turbolinks:load', loadAndCreateSearchGmap);
