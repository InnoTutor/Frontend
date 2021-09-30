class Urls {
  String get_session_format = 'http://localhost:8080/session/session-formats';
  String get_session_type = 'http://localhost:8080/session/session-types';
  String get_sessions = 'http://localhost:8080/session/subjects';
  String get_tutors = 'http://localhost:8080/tutors-list?subject=&format=&type=';



  String delete_tutors = 'http://localhost:8080/tutors-list?subject=&format=&type=';
  String request_card = 'http://localhost:8080/card/request-card';
  String cv_card = 'http://localhost:8080/card/cv-card';

}