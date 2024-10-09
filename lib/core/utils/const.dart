// ignore_for_file: constant_identifier_names

// import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const kCarBox = 'car_box';
// final ZoomDrawerController zoomDrawerController = ZoomDrawerController();
const String baseUrl = "https://bus.onclick-eg.com/api/";
const String REGISTER_PARENT = "parents";
const String REGISTER_STUDENT = "parents/addStudents";
const LatLng initialLatLong = LatLng(30.57499500, 31.50368170);
const googleMapsApiKey = "AIzaSyCX3JeW9bpasQrhBXDubyI68AmV-uEhS0o";

const String LOGIN = "auth/login";
const String PARENT_REGISTER = "parents";
const String GET_SCHOOLS = "schools";
const String GET_GRADES = "grades";
const String GET_LIVE_LOCATION = "liveLocation";
const String GET_STUDENTS = "parents/getParentStudents";
const String ADD_PARENT_CHILD = "parents/createStudent";
const String GET_TRIPS_FOR_SUPERVISOR = "trips/getSupervisorTripDay";
const String GET_TRIP_DAY = "trips/getStudentsTripDay";
const String CHANGE_STUDENT_ATTENDANCE = "parents/attendStudentByParent";
const String SEND_LIVE_LOCATION = "liveLocation";

const String uploadPath = "https://bus.onclick-eg.com/storage/";
const String uploadPathPdf = "https://unidye.onclick-eg.com/pdfs/";
const String GET_CATEGORY_WITH_SERVICE = "getCategory/with/services";
const String GET_WHO_ARE_WE= "getWhoAreWe";
const String GET_SLIDER = "getSlider";
const String GET_USER_DATA = "user-profile";
const String GET_SERVICE = "fields";
const String LOG_OUT = "logout";
const String GET_CONVERSATION = "getConversation/";
const String GET_CHATS = "getConversationsForUser";
const String CHANGE_PASSWORD = "change/password";
const String DELETE_ACCOUNT = "delete/account";
const String ATTEND_STUDENTS_IN_TRIP_DAY =
    "supervisors/attendStudentBySupervisor";
const String CHECK_STUDENT_IN_TRIP_DAY = "trips/checkStudentInTrip";

abstract class Constants {
  static const spaceSmall = 5.0;
  static const spaceMedium = 10.0;
  static const spaceLarge = 15.0;
  static const spaceLarge2 = 20.0;
  static const spaceExtraLarge = 25.0;
}
