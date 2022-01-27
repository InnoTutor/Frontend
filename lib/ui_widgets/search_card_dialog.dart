import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/constants/style.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/enrollment.dart';
import 'package:inno_tutor/models/request_models/request_model.dart';
import 'package:inno_tutor/services/database.dart';
import 'package:inno_tutor/ui_widgets/check_box_row.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import 'package:inno_tutor/widgets/page_cap.dart';

// ignore: must_be_immutable
class SearchCardDialog<User> extends StatefulWidget {
  RequestModel user;
  Function updateStatus;
  SearchCardDialog({
    this.user,
    this.updateStatus,
    Key key}) : super(key: key);

  @override
  _SearchCardDialogState<User> createState() => _SearchCardDialogState<User>();
}

class _SearchCardDialogState<User> extends State<SearchCardDialog<User>> {
  Enrollment enrollment = Enrollment(-1, "", [], []);
  Card newCard = Card(0, 0, "", 0, "", [], [], false, 0);
  String warning = "";

  void updateDialog(){
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    enrollment.cardId = widget.user.cardId;
    newCard.subject = widget.user.subject;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: lightGrey,
      content: SizedBox(
        height: 310,
        child: Column(
          children: [
            Container(
              width: 610,
              child: PageCap(text: "Confirm your request", padding: 0, color: grey)
            ),
            Container(
              width: 610,
              padding: EdgeInsets.only(top: 10),
              child: CheckBoxRow(card: newCard, color: darkGrey, themeColor: darkGrey,
                availableSessionFormats: widget.user.sessionFormat, availableSessionTypes: widget.user.sessionType,
                updateDialog: updateDialog,)
            ),
            Container(height: 10, child: Wrap()),
            Container(
              width: 600,
              height: 150,
              decoration: BoxDecoration(
                color: grey,
                borderRadius:  BorderRadius.all(Radius.circular(10)),
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.bottomLeft,
                child: 
                  TextFormField (
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    style: TextStyle(fontFamily: 'SourceSans', color: almostDarkGrey, fontWeight: FontWeight.w600),
                    cursorColor: almostDarkGrey,
                      decoration: InputDecoration(
                      hintText: "Add comments...",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: almostDarkGrey)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: almostDarkGrey),
                      ),
                      fillColor: Colors.white.withOpacity(0.5),
                      filled: true
                    ),
                    onChanged: (text) {
                      newCard.description = text;
                    },
                  )
                )
            ),
            Container(
              padding: EdgeInsets.only(top:10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: darkGreen),
                onPressed: 
                  widget.user.sessionFormat.length == 1 && widget.user.sessionType.length == 1 ||
                  !(newCard.sessionFormat.isEmpty || newCard.sessionType.isEmpty) ? () async{
                    enrollment.description = newCard.description;
                    enrollment.sessionFormat = newCard.sessionFormat;
                    enrollment.sessionType = newCard.sessionType;

                    CardServices().createEnroll(enrollment);
                                 
                    widget.updateStatus();
                    Navigator.of(context).pop();
                  } : null,
                child: CustomText(
                  text: "Send Request",
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}