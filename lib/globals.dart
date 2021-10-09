import 'package:flutter/material.dart' hide Card;

import 'models/card.dart';
import 'models/user.dart';

User user;

List<Card> myCards ;
Map <int , Icon> icons = {0:Icon(Icons.done, color: Colors.white) , 1 : Icon(Icons.create_rounded, color: Colors.white)};
List<String>formats=[];
List<String>types=[];