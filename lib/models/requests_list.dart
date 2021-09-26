import 'package:inno_tutor/models/cv_card.dart';
import "package:json_annotation/json_annotation.dart";

import 'card.dart';
import 'request_card.dart';
import 'session.dart';

part 'requests_list.g.dart';


@JsonSerializable()
class RequestsList {
  RequestsList(this.helpCardsLists, this.cvCardsList);

  List<RequestCard>helpCardsLists;
  List<CvCard>cvCardsList;


  factory RequestsList.fromJson(Map<String, dynamic> json) => _$RequestsListFromJson(json);

  Map<String, dynamic> toJson() => _$RequestsListToJson(this);
}