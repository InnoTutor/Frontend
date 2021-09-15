import 'package:flutter/material.dart';


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
