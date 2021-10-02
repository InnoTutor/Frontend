import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


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

