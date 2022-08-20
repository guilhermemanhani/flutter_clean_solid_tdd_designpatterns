import 'package:get/get.dart';

import '../../domain/usecases/usecases.dart';
import '../../ui/pages/pages.dart';

class GetxSplashPresenter extends SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;
  GetxSplashPresenter({required this.loadCurrentAccount});
  var _navigateTo = RxString('');

  @override
  Future<void> checkAccount({int durationInSeconds = 2}) async {
    await Future.delayed(Duration(seconds: durationInSeconds));
    try {
      final account = await loadCurrentAccount.load();
      _navigateTo.value = account.token.isEmpty ? '/login' : '/surveys';
    } catch (error) {
      _navigateTo.value = '/login';
    }
  }

  @override
  Stream<String> get navigateToStream => _navigateTo.stream;
}
