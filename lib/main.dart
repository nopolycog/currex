import 'package:currex/logic/repos/auth/auth_repo.dart';
import 'package:currex/ui/app.dart';
import 'package:currex/ui/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  getIt<AuthRepo>().put('demo.demo');

  runApp(const ProviderScope(child: App()));
}
