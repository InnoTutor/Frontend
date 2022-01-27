import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/constants/style.dart' as style;
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/request_models/request_model.dart';
import 'package:inno_tutor/models/request_models/student_request.dart';
import 'package:inno_tutor/models/request_models/tutor.dart';
import 'package:inno_tutor/services/database.dart';
import 'package:inno_tutor/ui_widgets/check_box_row.dart';
import 'package:inno_tutor/ui_widgets/search_card_widgets/search_student_card_widget.dart';
import 'package:inno_tutor/ui_widgets/search_card_widgets/search_tutor_card_widget.dart';
import 'package:inno_tutor/widgets/custom_dropdown_button.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import 'package:inno_tutor/widgets/page_cap.dart';
import 'package:inno_tutor/globals.dart' as globals;


// ignore: must_be_immutable
class SearchPage extends StatefulWidget {
  bool searchStudents;
  bool searchTutors;
  SearchPage({this.searchStudents = false, this.searchTutors = false, Key key }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> subjects;
  bool subjects_fetched = false; 
  Card newCard = Card(0, 0, "", 0, "", [], [], false, 0);
  List<RequestModel> users;

  @override
  initState() {
    super.initState();
    fetch_subjects();
  }

  Future<void> fetch_subjects() async {
    users = [];
    subjects = await Services().getSubjects();

    if (widget.searchTutors) {
      await SearchServices().getTutors("", null, null, null);
      for (Tutor t in globals.allTutors)
        users.add(t);
    }
    else if (widget.searchStudents){
      await SearchServices().getStudents("", [], []);
      for (StudentRequest sq in globals.allStudents)
      users.add(sq);
    }

    setState(() {
      subjects_fetched = true;
    });
  }

  bool updated = true;
  Future<void> updateResults(Card updatedCard) async{
    users = [];

    if (widget.searchTutors){
      await SearchServices().getTutors(updatedCard.subject, updatedCard.sessionFormat, updatedCard.sessionType, null);
    }
    else if (widget.searchStudents){
      await SearchServices().getStudents(updatedCard.subject, updatedCard.sessionFormat, updatedCard.sessionType);
    }
    
    setState(() {
      updated = false;
    });

    if (widget.searchTutors) {
      for (Tutor t in globals.filteredTutors)
        users.add(t);
    }
    else if (widget.searchStudents){
      for (StudentRequest sq in globals.filteredStudents)
        users.add(sq);
    }

    setState(() {
      updated = true;
    });
  }
  
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          PageCap(text: widget.searchTutors ? "Need Help" : (widget.searchStudents ? "Offer Help" : "")),
          subjects_fetched ? Container(
            padding: EdgeInsets.only(top: 10, left: 15, right: 15),
            alignment: Alignment.topLeft,
            child: CustomDropDownButton(locations: subjects, card: newCard, width: 700, updateResults: updateResults)
          ) : Wrap(),
          subjects_fetched ? Container(
            width: 610,
            padding: EdgeInsets.only(top: 10),
            child: CheckBoxRow(card: newCard, color: style.darkGrey, themeColor: style.darkGrey, updateResults: updateResults, radio: true)
          ) : Wrap(),
          subjects_fetched ? Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 15, top: 10),
            child: CustomText(
              text: "Results:",
              color: style.darkGrey,
              size: 18,
              weight: FontWeight.bold,
            )
          ) : Wrap(),
          subjects_fetched && updated ? Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
              child: users != [] ? Column(
                mainAxisSize: MainAxisSize.min,
                children: 
                users.map((item) => 
                  widget.searchTutors ? SearchTutorCardWidget(tutor: item) :
                  widget.searchStudents ? SearchStudentCardWidget(studentRequest: item) : Wrap()).toList()
              ) : 
              Container(
              padding: EdgeInsets.all(10),
              child: CircularProgressIndicator(
                  backgroundColor: style.grey,
                  valueColor: new AlwaysStoppedAnimation<Color>(style.lightGrey),
                ),
            ),
          ) : Container(
            padding: EdgeInsets.all(10),
            child: CircularProgressIndicator(
                backgroundColor: style.grey,
                valueColor: new AlwaysStoppedAnimation<Color>(style.lightGrey),
              ),
          ),
          Container(
            height: 10,
          )
        ],
      )
    );
  }
}