class Urls {
  static const String cors = "https://cors-anywhere.herokuapp.com/";
  static const String url = 'https://innotutor.herokuapp.com/';
  static String get_tutors = url +'tutors-list' ;
  static String get_students = url + 'students-list';

  static String delete_tutors =  get_tutors+'delete';
  static String request_card = 'http://localhost:8080/card/request-card';
  static String cv_card = 'http://localhost:8080/card/cv-card';

}