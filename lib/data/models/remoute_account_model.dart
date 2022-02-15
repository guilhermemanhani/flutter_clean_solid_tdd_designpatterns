import '../../domain/entities/account_entity.dart';
import '../http/http.dart';

class RemouteAccountModel {
  final String accessToken;

  RemouteAccountModel(this.accessToken);

  factory RemouteAccountModel.fromJson(Map json) {
    if (!json.containsKey('accessToken')) {
      throw HttpError.invalidData;
    }
    return RemouteAccountModel(json['accessToken']);
  }

  AccountEntity toEntity() => AccountEntity(accessToken);
}
