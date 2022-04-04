const MAPQUEST_API_KEY =
    'pk.eyJ1IjoiZGlzdGlycSIsImEiOiJjbDFrenh4bmgwNDlrM2pvYjl0bG5xZTBkIn0.kUKpEAkYRQa1uL_b-_MMkg';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double? latitude, double? longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,14.25,0,0/600x300?access_token=$MAPQUEST_API_KEY';
  }
}


//https://www.mapquestapi.com/staticmap/v5/map?key=KEY&center=New+York&size=1100,500@2x