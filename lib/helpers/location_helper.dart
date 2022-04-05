const MAPQUEST_API_KEY =
    'pk.eyJ1IjoiZGlzdGlycSIsImEiOiJjbDFrenJjMDEwMDJtM2lwbWlqdTgzeTJ6In0.WjEAZ0MsWr9bPUDZ_oaR_A';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double? latitude, double? longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,14.25,0,0/600x300?access_token=$MAPQUEST_API_KEY';
  }
}
