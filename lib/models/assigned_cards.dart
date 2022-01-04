import 'package:inno_tutor/models/my_student.dart';
import "package:json_annotation/json_annotation.dart";

part 'assigned_cards.g.dart';

@JsonSerializable()
class AssignedCards{
  AssignedCards(this.waitingList, this.acceptedList);

  List<MyStudent> waitingList;
  List<MyStudent> acceptedList;

  factory AssignedCards.fromJson(Map<String, dynamic> json) => _$AssignedCardsFromJson(json);

  Map<String, dynamic> toJson() => _$AssignedCardsToJson(this);
}
