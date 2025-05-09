import 'package:auto_route/auto_route.dart';
import 'package:currex/ui/common/gaps.dart';
import 'package:currex/ui/common/sizes.dart';
import 'package:currex/ui/global_providers/auth_provider.dart';
import 'package:currex/ui/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  late TextEditingController loginController;
  late TextEditingController passController;
  late AuthStatus status;

  @override
  void initState() {
    super.initState();
    loginController = TextEditingController();
    passController = TextEditingController();
    ref.listenManual(authProvider, (previous, next) => status = next);
  }

  Future<void> onTapSignIn() async {
    await ref.read(authProvider.notifier).login('${loginController.text.trim()}.${passController.text.trim()}');
    if (mounted) {
      status == AuthStatus.auth
          ? context.router.replacePath('/rates')
          : ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(key: ValueKey('errorSnackbar'), content: Text('Wrong login or password!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const ValueKey('signInScreen'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.size4x),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome back!', style: AppTextStyles().title1Bold),
            AppGaps.size12x,
            Text('Login', style: AppTextStyles().subheadMedium),
            AppGaps.size2x,
            TextField(key: const ValueKey('loginField'), controller: loginController),
            AppGaps.size4x,
            Text('Password', style: AppTextStyles().subheadMedium),
            AppGaps.size2x,
            TextField(key: const ValueKey('passwordField'), controller: passController),
            AppGaps.size4x,
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                key: const ValueKey('signInButton'),
                onPressed: onTapSignIn,
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.size1x)),
                  ),
                ),
                child: const Text('Sign In'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
