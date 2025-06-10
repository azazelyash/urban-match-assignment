class Endpoints {
  Endpoints._();

  /* -------------------------------- Base URLs ------------------------------- */
  static const String baseUrl = 'https://dmfgr3y72e.ap-south-1.awsapprunner.com/api/v1';

  /* -------------------------------- Auth URL -------------------------------- */
  static const String loginUrl = '$baseUrl/auth/signin';
  static const String getUserDetails = "$baseUrl/user/getBasicUserDetails";

  /* -------------------------------------------------------------------------- */
  /*                                  User URL                                  */
  /* -------------------------------------------------------------------------- */

  static const String addImage = "$baseUrl/user/addImage";
  static const String startTrip = "$baseUrl/user/startTrip";
  static const String getPastTrips = "$baseUrl/user/getPastTrips";
  static const String getDropdowns = "$baseUrl/common/getDropdowns";
  static const String getAgentDetails = "$baseUrl/user/getAgentDetails";
  static const String getAssignedTrip = "$baseUrl/user/getAssignedTrip";
  static const String requestStopTrip = "$baseUrl/user/requestStopTrip";
  static const String requestSkipOrder = "$baseUrl/user/requestSkipOrder";
  static const String scanOrderToComplete = "$baseUrl/user/scanOrderToComplete";
  static const String completeTripOnWarehouseReturn = "$baseUrl/user/completeTripOnWarehouseReturn";

  /* -------------------------------------------------------------------------- */
  /*                                 Google Maps                                */
  /* -------------------------------------------------------------------------- */

  static const String googleMapRedirect = "https://www.google.com/maps/dir/?api=1&travelmode=driving&destination=";
}
