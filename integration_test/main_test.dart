import 'package:currex/logic/repos/auth/auth_repo.dart';
import 'package:currex/ui/app.dart';
import 'package:currex/ui/di/di.dart';
import 'package:flutter/material.dart' show WidgetsFlutterBinding;
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

void main() {
  patrolTest('test successfuly auth', ($) async {
    WidgetsFlutterBinding.ensureInitialized();
    configureDependencies();
    getIt<AuthRepo>().put('demo.demo');

    await $.pumpWidget(const App());

    await $(#loginField).enterText('demo');
    await $(#passwordField).enterText('demo');
    await $(#signInButton).tap();

    expect($(#ratesScreen).visible, isTrue);
  });

  patrolTest('test auth error', ($) async {
    WidgetsFlutterBinding.ensureInitialized();
    configureDependencies();
    getIt<AuthRepo>().put('demo.demo');

    await $.pumpWidget(const App());

    await $(#loginField).enterText('login');
    await $(#passwordField).enterText('pass');
    await $(#signInButton).tap();

    expect($(#errorSnackbar).visible, isTrue);
  });

  patrolTest('rates loading', ($) async {
    WidgetsFlutterBinding.ensureInitialized();
    configureDependencies();
    getIt<AuthRepo>().put('demo.demo');

    await $.pumpWidget(const App());

    await $(#loginField).enterText('demo');
    await $(#passwordField).enterText('demo');
    await $(#signInButton).tap();

    expect($(#ratesScreen).visible, isTrue);
    $(#ratesList).waitUntilVisible(timeout: const Duration(seconds: 10));
  });
}
