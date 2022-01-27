import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/models/request_models/tutor.dart';
import 'package:inno_tutor/ui_widgets/search_card_widgets/search_card.dart';

// ignore: must_be_immutable
class SearchTutorCardWidget extends StatefulWidget{
  Tutor tutor;
  SearchTutorCardWidget({ Key key, this.tutor}) : super(key: key);

  @override
  _SearchTutorCardWidgetState createState() => _SearchTutorCardWidgetState();
}

class _SearchTutorCardWidgetState extends State<SearchTutorCardWidget>{
  @override
  Widget build(BuildContext context) {
    return SearchCard(
      user: widget.tutor,
    );
  }
}
