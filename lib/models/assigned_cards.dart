import 'package:inno_tutor/models/enrollment.dart';
import 'package:inno_tutor/models/sessions_list.dart';
import 'package:inno_tutor/models/user.dart';
import "package:json_annotation/json_annotation.dart";

part 'assigned_cards.g.dart';

@JsonSerializable()
class AssignedCards{
  AssignedCards(this.waitingList, this.acceptedList);

  List<Enrollment> waitingList;
  List<Enrollment> acceptedList;

  factory AssignedCards.fromJson(Map<String, dynamic> json) => _$AssignedCardsFromJson(json);

  Map<String, dynamic> toJson() => _$AssignedCardsToJson(this);
}
