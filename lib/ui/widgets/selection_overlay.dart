import 'package:currex/ui/common/extensions.dart';
import 'package:flutter/material.dart';

class AppSelectionOverlay extends StatelessWidget {
  const AppSelectionOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: context.colorScheme.secondary.withValues(alpha: 0.2))),
      ),
    );
  }
}
