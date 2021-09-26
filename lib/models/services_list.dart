import 'package:inno_tutor/models/request_card.dart';
import "package:json_annotation/json_annotation.dart";

import 'card.dart';
import 'cv_card.dart';
import 'session.dart';

part 'services_list.g.dart';


@JsonSerializable()
class ServicesList {
  ServicesList(this.cvCardsList);

  List<CvCard>cvCardsList;


  factory ServicesList.fromJson(Map<String, dynamic> json) => _$ServicesListFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesListToJson(this);
}