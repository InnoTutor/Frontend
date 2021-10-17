import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:inno_tutor/constants/controllers.dart';
import 'package:inno_tutor/constants/ui_constants.dart';
import 'package:inno_tutor/elements/side_menu.dart';
import 'package:inno_tutor/globals.dart';
import 'package:inno_tutor/pages/need_help/need_help.dart';
import 'package:inno_tutor/pages/offer_help/offer_help.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import '../constants/style.dart' as style;
import '../helpers/responsiveness.dart';
import '../layout.dart';
import 'package:inno_tutor/models/card.dart';

// ignore: must_be_immutable
class LargeScreen extends StatefulWidget {
  Widget page;
  bool login = false;
  SiteLayout layout;
  Function updPage;
  void Function() onTap;
  final Function() notifyParent;
  bool clicked=false;

  LargeScreen(
      {Key key,
      this.onTap,
      @required this.notifyParent,
      this.page,
      this.login,
      this.layout,
      this.updPage}
  ) : super(key: key);

  @override
  _LargeScreenState createState() => _LargeScreenState();
}

class _LargeScreenState extends State<LargeScreen> {
  void updatePage(Widget nextPage) {
    if (mounted) {
      setState(() {
        widget.page = nextPage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: style.lightGrey,
                      child: Container(
                        width: 700,
                        color: style.lightGrey,
                        alignment: Alignment.topRight,
                        child: Container(
                          child: Container(
                            width: 230,
                            height: ResponsiveWidget.isCustomSize(context) ? 620 : 360,
                            margin: const EdgeInsets.only(right: 5, left: 10, top: 10),
                            decoration: commonBoxDecoration,
                            child: SideMenu(updPage: updatePage,)
                          )
                        )
                      )
                    )
                  ),
                  Container(
                    color: style.lightGrey,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                          width: 700,
                          color: style.lightGrey,
                          alignment: Alignment.center,
                          child: SizedBox(
                            child: Container(
                              margin: const EdgeInsets.only(right: 5, left: 5, top: 10),
                              decoration: commonBoxDecoration,
                              child:  widget.page
                            )
                          )
                        ),Expanded(
                          child: Container(
                              height: 50,
                              width: 700,
                              color: style.lightGrey)
                          )
                      ],
                    )
                  ),
                  Expanded(
                    child: Container(
                    color: style.lightGrey,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        LayoutButton(
                          text: "Need Help",
                          updPage: updatePage,
                        ),
                        LayoutButton(
                          text: "Offer Help",
                          updPage: updatePage,
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

// ignore: must_be_immutable
class LayoutButton extends StatelessWidget {
  String text;
  Function updPage;
  LayoutButton({Key key, this.text, this.updPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 5, right: 10),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
            backgroundColor: MaterialStateProperty.all(style.darkGreen),
          ),
          onPressed: () {
            for (Card card in myCards) {
              card.setEditable(false);
            }
            if (!menuController.isActive(text)) {
              menuController.changeActiveItemTo(text);
              updPage(text == "Need Help" ? NeedHelp() : OfferHelp());
              if (ResponsiveWidget.isSmallScreen(context)) Get.back();
            }
          },
          child: CustomText(
            text: text,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
