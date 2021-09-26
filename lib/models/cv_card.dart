import 'package:inno_tutor/models/sessions_list.dart';
import 'package:inno_tutor/models/user.dart';
import "package:json_annotation/json_annotation.dart";

part 'cv_card.g.dart';

@JsonSerializable()
class CvCard {
  CvCard(this.newStudents, this.acceptedStudents, this.rating);

  List<User>newStudents;
  List<User>acceptedStudents;
  int rating;
  factory CvCard.fromJson(Map<String, dynamic> json) => _$CvCardFromJson(json);

  Map<String, dynamic> toJson() => _$CvCardToJson(this);
}
