import 'package:currex/common/configs/dio.dart';
import 'package:currex/data/repos/auth/auth_repo_impl.dart';
import 'package:currex/data/repos/rates/rates_repo_impl.dart';
import 'package:currex/data/sources/local/local_secured_source.dart';
import 'package:currex/data/sources/remote/remote_source.dart';
import 'package:currex/logic/repos/auth/auth_repo.dart';
import 'package:currex/logic/repos/rates/rates_repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt.registerLazySingleton<AppLocalSecuredSource>(() => AppLocalSecuredSource(const FlutterSecureStorage()));
  getIt.registerLazySingleton<AppRemoteSource>(() => AppRemoteSource(dio));
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(getIt<AppLocalSecuredSource>()));
  getIt.registerLazySingleton<RatesRepo>(() => RatesRepoImpl(getIt<AppRemoteSource>()));
}
