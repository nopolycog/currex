import 'package:auto_route/auto_route.dart';
import 'package:currex/ui/common/extensions.dart';
import 'package:currex/ui/common/gaps.dart';
import 'package:currex/ui/common/mixins.dart';
import 'package:currex/ui/common/sizes.dart';
import 'package:currex/ui/global_providers/auth_provider.dart';
import 'package:currex/ui/screens/convert_screen/convert_provider.dart';
import 'package:currex/ui/screens/convert_screen/convert_state.dart';
import 'package:currex/ui/screens/rates_screen/rates_provider.dart';
import 'package:currex/ui/screens/rates_screen/rates_state.dart';
import 'package:currex/ui/theme/text_styles.dart';
import 'package:currex/ui/widgets/item_selector.dart';
import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ConvertScreen extends ConsumerStatefulWidget {
  const ConvertScreen({super.key});

  @override
  ConsumerState<ConvertScreen> createState() => _ConvertScreenState();
}

class _ConvertScreenState extends ConsumerState<ConvertScreen> with PriceMixin {
  late TextEditingController amountController;

  double calculateAmount() {
    final ConvertState convertState = ref.watch(convertProvider);
    return convertState.amount *
        (double.tryParse(convertState.from?.rateUsd ?? '') ?? 0) *
        (double.tryParse(convertState.to?.rateUsd ?? '') ?? 0);
  }

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
  }

  void onTapSignOut() {
    ref.watch(authProvider.notifier).logout();
    ref.invalidate(ratesProvider);
    ref.invalidate(convertProvider);
    context.router.replacePath('/sign_in');
  }

  @override
  Widget build(BuildContext context) {
    final ConvertState convertState = ref.watch(convertProvider);
    final RatesState ratesState = ref.watch(ratesProvider);
    return Scaffold(
      key: const ValueKey('convertScreen'),
      appBar: AppBar(
        title: Text('Convert', style: AppTextStyles().bodyMedium),
        actions: <Widget>[IconButton(onPressed: onTapSignOut, icon: const Icon(Icons.logout_rounded))],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child:
            ratesState.isLoading
                ? const Center(child: CupertinoActivityIndicator())
                : ratesState.hasError
                ? Center(
                  child: Text(
                    'Error: ${ratesState.error?.type.name ?? 'Unknown error'}',
                    style: AppTextStyles().bodyMedium,
                  ),
                )
                : ListView(
                  padding: const EdgeInsets.all(AppSizes.size4x),
                  children: [
                    AppGaps.size4x,
                    Text('From', style: AppTextStyles().subheadMedium),
                    AppGaps.size2x,
                    AppItemSelector(
                      items: ratesState.ratesCrypto ?? [],
                      selectedItem: convertState.from,
                      onSelectedItemChanged: ref.read(convertProvider.notifier).onSelectedFrom,
                    ),
                    AppGaps.size4x,
                    Text('To', style: AppTextStyles().subheadMedium),
                    AppGaps.size2x,
                    AppItemSelector(
                      items: ratesState.ratesFiat ?? [],
                      selectedItem: convertState.to,
                      onSelectedItemChanged: ref.read(convertProvider.notifier).onSelectedTo,
                    ),
                    AppGaps.size4x,
                    const Divider(height: 1),
                    AppGaps.size4x,
                    Text('Amount', style: AppTextStyles().subheadMedium),
                    AppGaps.size2x,
                    TextField(
                      controller: amountController,
                      decoration: const InputDecoration(hintText: '0.00'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))],
                      onChanged: ref.read(convertProvider.notifier).onChangedAmount,
                    ),
                    AppGaps.size4x,
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: context.colorScheme.secondary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppSizes.size1x),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSizes.size4x, vertical: AppSizes.size6x),
                        child: Column(
                          children: [
                            FittedBox(
                              child: Text(
                                '${trimDecimal(convertState.amount.toString())} ${convertState.from?.symbol}',
                                style: AppTextStyles().title1Medium,
                              ),
                            ),
                            AppGaps.size2x,
                            Icon(Icons.swap_horiz_rounded, color: context.colorScheme.secondary.withValues(alpha: 0.5)),
                            AppGaps.size2x,
                            FittedBox(
                              child: Text(
                                '${trimDecimal((calculateAmount() * 1.03).toString(), maxLength: 2)} ${convertState.to?.symbol}',
                                style: AppTextStyles().title1Medium.copyWith(color: context.colorScheme.primary),
                              ),
                            ),
                            AppGaps.size1x,
                            FittedBox(
                              child: Text(
                                '(${trimDecimal(calculateAmount().toString(), maxLength: 2)} ${convertState.to?.symbol} + 3%)',
                                style: AppTextStyles().subheadRegular,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
