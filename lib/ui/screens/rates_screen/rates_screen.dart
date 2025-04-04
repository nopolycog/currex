import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:currex/ui/common/mixins.dart';
import 'package:currex/ui/common/sizes.dart';
import 'package:currex/ui/global_providers/auth_provider.dart';
import 'package:currex/ui/screens/rates_screen/rates_provider.dart';
import 'package:currex/ui/screens/rates_screen/rates_state.dart';
import 'package:currex/ui/theme/text_styles.dart';
import 'package:currex/ui/widgets/rate_image.dart';
import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class RatesScreen extends ConsumerStatefulWidget {
  const RatesScreen({super.key});

  @override
  ConsumerState<RatesScreen> createState() => _RatesScreenState();
}

class _RatesScreenState extends ConsumerState<RatesScreen> with PriceMixin {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (shouldLoadMore()) {
        ref.watch(ratesProvider.notifier).loadMoreRates();
      }
    });
  }

  bool shouldLoadMore() {
    if (ref.watch(ratesProvider).isLoading || !ref.watch(ratesProvider).hasMore) return false;
    final position = scrollController.position;
    return position.pixels > position.maxScrollExtent * 0.7;
  }

  Future<void> onRefresh() async => await ref.watch(ratesProvider.notifier).refresh();

  Future<void> onUpdate() async => await ref.watch(ratesProvider.notifier).update();

  void onTapSignOut() {
    ref.watch(authProvider.notifier).logout();
    context.router.replacePath('/sign_in');
  }

  @override
  Widget build(BuildContext context) {
    final RatesState state = ref.watch(ratesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Rates', style: AppTextStyles().bodyMedium),
        centerTitle: true,
        leading:
            state.isUpdating
                ? const CupertinoActivityIndicator()
                : IconButton(onPressed: onUpdate, icon: const Icon(Icons.refresh_rounded)),
        actions: <Widget>[IconButton(onPressed: onTapSignOut, icon: const Icon(Icons.logout_rounded))],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child:
            state.isLoading
                ? const Center(child: CupertinoActivityIndicator())
                : state.hasError
                ? Center(
                  child: Text('Error: ${state.error?.type.name ?? 'Unknown error'}', style: AppTextStyles().bodyMedium),
                )
                : RefreshIndicator.adaptive(
                  onRefresh: onRefresh,
                  child: ListView.separated(
                    controller: scrollController,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemCount: state.rates?.length ?? 0,
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.size4x),
                    itemBuilder:
                        (BuildContext context, int index) => ListTile(
                          title: Text(
                            '${state.rates?[index].symbol}',
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles().bodyMedium,
                          ),
                          trailing: Text(
                            '\$${trimDecimal(state.rates?[index].priceUsd ?? '')} ',
                            style: AppTextStyles().subheadRegular,
                            overflow: TextOverflow.ellipsis,
                          ),
                          leading: AppRateImage(path: state.rates?[index].symbol ?? ''),
                          contentPadding: EdgeInsets.zero,
                        ),
                  ),
                ),
      ),
    );
  }
}
