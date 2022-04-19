import 'package:flutter_clean_solid_tdd_designpatterns/data/usecases/load_current_account/local_load_current_account.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/main/factories/cache/cache.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

LoadCurrentAccount makeLocalLoadCurrentAccount() =>
    LocalLoadCurrentAccount(fetchSecureCacheStorage: makeLocalStorageAdapter());
