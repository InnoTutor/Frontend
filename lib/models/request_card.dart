import 'package:inno_tutor/models/sessions_list.dart';
import 'package:inno_tutor/models/user.dart';
import "package:json_annotation/json_annotation.dart";

part 'request_card.g.dart';

@JsonSerializable()
class RequestCard {
  RequestCard(this.respondedTutors, this.tutor);

  List<User> respondedTutors;
  User tutor;

  factory RequestCard.fromJson(Map<String, dynamic> json) => _$RequestCardFromJson(json);

  Map<String, dynamic> toJson() => _$RequestCardToJson(this);
}
