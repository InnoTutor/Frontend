import 'package:flutter/material.dart';
import 'package:inno_tutor/pages/offer_help/offer_help_large.dart';
import '../../services/global_funtions.dart';
import '../../elements/drawer.dart';
import '../../helpers/responsiveness.dart';
import '../../helpers/responsiveness.dart';
import '../../pages/profile/my_profile_large.dart';
import '../../widgets/custom_text.dart';
import '../../constants/style.dart' as style;

class OfferHelp extends StatefulWidget {
  @override
  _OfferHelpState createState() => _OfferHelpState();
}

class _OfferHelpState extends State<OfferHelp> {

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async{
        final arguments = ModalRoute.of(context).settings.arguments;
        List<String>list = handle_arguments(arguments);
        Navigator.pushReplacementNamed(context,'/'+list[0] , arguments: {'route':list[1]} );

        return true;
      },
      child: !ResponsiveWidget.isSmallScreen(context) ?
        OfferHelpLargePage() :
        Center(
        child: CustomText(
          selectable: true,
          text: "Offer Help",
          size: 24,
          weight: FontWeight.w900,
          color: style.darkGrey
        )
      )
    );
  }
}
