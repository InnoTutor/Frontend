import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/models/request_models/student_request.dart';
import 'package:inno_tutor/ui_widgets/search_card_widgets/search_card.dart';


// ignore: must_be_immutable
class SearchStudentCardWidget extends StatefulWidget{
  StudentRequest studentRequest;
  SearchStudentCardWidget({ Key key, this.studentRequest}) : super(key: key);

  @override
  _SearchStudentCardWidgetState createState() => _SearchStudentCardWidgetState();
}

class _SearchStudentCardWidgetState extends State<SearchStudentCardWidget>{

  @override
  Widget build(BuildContext context) {
    return SearchCard(
      user: widget.studentRequest,
    );
  }
}

