import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/models/card.dart';

// List<Card> myCards = [
//     Card(0,0, 0, "Meth Analysis", 4.7, "Love doing Meth Love doing Meth Love doing Meth Love doing Meth Love doing Meth Love doing Meth Love doing Meth Love doing Meth Love doing Meth Love doing Meth Love doing Meth Love doing Meth Love doing Meth Love doing Meth ", ["offline", "online"], ["private"], false, 5),
//     Card(1,0, 0, "DNP", 2.0, "Why not\nWhy not\nWhy not", ["offline"], ["private"], false, 6),
//     Card(2,0, 0, "Descrete Meth", 5.0, "This is what i love the most", ["online"], ["public"], false, 7)
// ];
Map <int , Icon> icons = {0:Icon(Icons.done, color: Colors.white) , 1 : Icon(Icons.create_rounded, color: Colors.white)};