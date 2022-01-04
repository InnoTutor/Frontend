class Urls {
  static const String url = 'https://innotutor.herokuapp.com/';
  static String get_tutors = url +'tutors-list' ;
  static String get_students = url + 'students-list';
  static String get_user = url+'user/';

  static String services = url+'services';
  static String get_user_services = services+'/user/';
  static String services_subjects = services+'/subjects';

  static String my_students = url+'my-students';
  static String del_my_student = my_students+'/remove/';
  static String accept_student = my_students+'/accept/';
  static String get_card = url+'card/';

  static String enroll = url+'enroll';
  static String unenroll = url+'unenroll/';
  static String profile = url+'profile';
  static String requests = url+'requests';
  static String get_user_requests = requests+'/user/';
  static String requests_subjects = requests+'/subjects';

  static String session = url+'session';
  static String session_subjects = session+'/subjects';
  static String session_formats = session+'/formats';
  static String session_types = session+'/types';
  static String session_students = session+'/students';
}