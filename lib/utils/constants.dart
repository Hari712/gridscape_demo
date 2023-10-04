import 'package:flutter/material.dart';

class AppColors {
  static final primary = Color(0xFF17AB2B);
  static final secondary = Color(0xFF994C29);
  static final dark = Color(0xFF432A1E);
  static final gray = Color(0xFF6e6e6e);
}

class ErrorMessages {
  static final networkFail = "Unable to retrieve details\nPlease check your internet connection.";
  static final serverFail = "Exception from Remote Server";
  static final internalFail = "Unexpected error occurred.";
  static final somethingWrong = "Something went wrong";
  static final dataFail = "Data not in Correct Format";
  static final tokenExpiry = "Your session is expired, please login again.";
  static final noToken = "Your session is expired, please login again.";
  static final timeOut = "Couldn't connect to server. \nServer Timeout";
  static final support =
      "Please contact your database coordinator for more information or report this error at $supportUrl";
  static final supportUrl = "https://baps.sl/helpdesk";
}

class ModuleText {
  static final map = 'Map';
  static final favourite = 'Favourite';
  static final transactions = 'Transactions';
  static final more = 'More';
}

class LogConstants {
  //print which api is called
  static final api = true; // default : true
  //print header(including token) with api. has no effect if api == false
  static final header = false; // default : false
  //print data fetched from local storage
  static final cacheData = false; // default : false
  //print response fetching time for all api
  static final apiCallTime = true; // default : true
  //print specific module response fetching time
  static final specificCallTime = true; // default : false
  //print api response data (after converted by chopper)
  static final responseData = false; // default : true
  //prints very first as response arrives (use when chopper fails to convert response as per required dart object)
  static final rawResponseData = false; // default : false
  //print expiry time for token everytime when token expiry time is checked in app.
  static final tokenExpiry = false; //default : false
  //print remote config data
  static final remoteConfig = false; //default : false
}
