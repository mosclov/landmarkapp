$(document).ready(function(){
  handler = Gmaps.build('Google');
  handler.buildMap({
      provider: {},
      internal: {id: "map"}
    },
    function(){

    markers = handler.addMarkers([
      {
        "lat": 32.7475811,
        "lng": -117.1311596,
        "picture": {
          "url": "http://people.mozilla.com/~faaborg/files/shiretoko/firefoxIcon/firefox-32.png",

          "width":  32,
          "height": 32
        },
        "infowindow": "hello!"
      }

    ]);
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
    handler.getMap().setZoom(10);
  });
});
