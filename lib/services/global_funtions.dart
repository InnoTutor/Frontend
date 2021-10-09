import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/enrollment.dart';


List<String> handle_arguments(var argument)  {
  final arguments = argument;
  String route = '/';
  if (arguments != null) {
    route = arguments['route'];
    print(arguments['route'] + ' profilee');
  }
  List<String> routes = route.split('/');
  if (routes.length != 0) {
    print(routes);
    routes.remove(routes[0]);

    route = routes.join('/');
    print('shit after joining ' + route);
  }
  else {
    routes = [''];
  }

  return [routes[0],route];

}

String removeExtraParametersCard(Card card){
  final data = card.toJson();
  data.remove('cardId');
  data.remove('hidden');
  data.remove('height');
  data.remove('rating');
  data.remove('creatorId');
  data.remove('countVoted');
  data.remove('editable');
  data.remove('currentIcon');
  return jsonEncode(data);
}
String removeExtraParametersEnroll(Enrollment card){
  final data = card.toJson();
  data.remove('enrollmentId');
  return jsonEncode(data);
}
String searchUrl(String URLL, String subject, String format, String type, String sorting){
  String url = URLL;
  bool previous = false;
  if(subject!=null){
    url+=('?subject='+subject);
    previous = true;
  }
  if(format != null){
    url+=((previous?"&":"?") + ("format="+format));
    previous=true;
  }if(type!=null){
    url+=((previous?"&":"?") + ("type="+type));
    previous = true;
  }
  if(sorting!=null){
    url+=((previous?"&":"?") + ("sorting="+sorting));
  }
  return url;
}