class Urls {
  static const String cors = "https://cors-anywhere.herokuapp.com/";
  static const String url = 'https://innotutor.herokuapp.com/';
  static String get_tutors = url +'tutors-list' ;
  static String get_students = url + 'students-list';
  static String get_user = url+'user/';
  static String delete_tutors =  get_tutors+'delete';
  static String request_card = url+'card/request-card';
  static String my_cvcard = url+'services';
  static String del_student = url+'my-students/remove/';
  static String get_card = url+'card/';
  static String enroll = url+'enroll';
  static String profile = url+'profile';
  static String subjects = url+'session/subjects';
  static String formats = url+'session/formats';
  static String types = url+'session/types';
}