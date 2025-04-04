import 'package:auto_route/auto_route.dart';
import 'package:currex/ui/common/extensions.dart';
import 'package:currex/ui/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ConvertScreen extends ConsumerStatefulWidget {
  const ConvertScreen({super.key});

  @override
  ConsumerState<ConvertScreen> createState() => _ConvertScreenState();
}

class _ConvertScreenState extends ConsumerState<ConvertScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Convert', style: AppTextStyles().bodyMedium),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.logout_rounded, color: context.colorScheme.primary))],
      ),
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Text('Convert')])),
    );
  }
}
