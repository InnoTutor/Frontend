import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inno_tutor/elements/routes.dart';
import '../../constants/style.dart' as style;

class MenuController extends GetxController{
  static MenuController instance = Get.find();
  var activeItem = MyProfilePageRout.obs;
  var hoverItem = "".obs;

  changeActiveItemTo(String itemName){
    activeItem.value = itemName;
  }

  onHover(String itemName){
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;
  isHovering(String itemName) => hoverItem.value == itemName;

  Widget returnIconFor(String itemName){
    switch(itemName){
      case MyProfilePageRout:
        return _customIcon(Icons.person_outline, itemName);
      case MyStudentsPageRout:
        return _customIcon(Icons.groups_outlined, itemName);
      case MyTutorsPageRout:
        return _customIcon(Icons.school_outlined, itemName);
      case MySchedulePageRout:
        return _customIcon(Icons.calendar_today_outlined, itemName);
      case MyRequestsPageRout:
        return _customIcon(Icons.call_made, itemName);
      case MyServicesPageRout:
        return _customIcon(Icons.volunteer_activism_outlined, itemName);
    }
    return _customIcon(Icons.exit_to_app, itemName);
  }

  Widget _customIcon(IconData icon, String itemName){
    if (isActive(itemName)) return Icon(icon, size: 26, color: style.darkGrey);

    return Icon(icon, color: isHovering(itemName) ? style.darkGrey : style.darkGrey.withOpacity(0.6));
  }
}