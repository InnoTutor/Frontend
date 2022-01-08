
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class RequestModel{
  RequestModel({
    this.id,
    this.name,
    this.surname,
    this.cardId,
    this.description,

    this.subject,
    this.sessionFormat,
    this.sessionType,
    this.requested
  });

  int id;
  String name;
  String surname;
  int cardId;
  String description;

  String subject;
  List<String> sessionFormat;
  List<String> sessionType;
  bool requested;

  int height = 100;
  void initializeCard(){
      this.height = 100;
  }
}