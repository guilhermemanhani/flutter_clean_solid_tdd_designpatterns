import 'package:flutter_clean_solid_tdd_designpatterns/domain/entities/account_entity.dart';

class RemouteAccountModel {
  final String accessToken;

  RemouteAccountModel(this.accessToken);

  factory RemouteAccountModel.fromJson(Map json) =>
      RemouteAccountModel(json['accessToken']);

  AccountEntity toEntity() => AccountEntity(accessToken);
}
