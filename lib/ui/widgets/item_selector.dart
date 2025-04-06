import 'package:currex/logic/entities/rate_model.dart';
import 'package:currex/ui/common/extensions.dart';
import 'package:currex/ui/common/sizes.dart';
import 'package:currex/ui/theme/text_styles.dart';
import 'package:currex/ui/widgets/selection_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppItemSelector extends StatefulWidget {
  const AppItemSelector({super.key, required this.selectedItem, required this.items, this.onSelectedItemChanged});

  final RateModel? selectedItem;
  final List<RateModel>? items;
  final void Function(int)? onSelectedItemChanged;

  @override
  State<AppItemSelector> createState() => _AppItemSelectorState();
}

class _AppItemSelectorState extends State<AppItemSelector> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppSizes.size1x),
      onTap:
          () => showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(),
            builder:
                (_) => SizedBox(
                  height: 270,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.close_rounded,
                              color: context.colorScheme.secondary.withValues(alpha: 0.5),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 1),
                      Expanded(
                        child: CupertinoPicker(
                          scrollController: FixedExtentScrollController(
                            initialItem: widget.items?.indexOf(widget.selectedItem!) ?? 0,
                          ),
                          itemExtent: 50,
                          selectionOverlay: const AppSelectionOverlay(),
                          onSelectedItemChanged: widget.onSelectedItemChanged,
                          children:
                              widget.items
                                  ?.map(
                                    (rate) => Center(child: Text(rate.symbol ?? '', style: AppTextStyles().bodyMedium)),
                                  )
                                  .toList() ??
                              [],
                        ),
                      ),
                    ],
                  ),
                ),
          ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.secondary.withValues(alpha: 0.2)),
          borderRadius: BorderRadius.circular(AppSizes.size1x),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.size3x, vertical: AppSizes.size2x),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.selectedItem?.symbol ?? '', style: AppTextStyles().calloutMedium),
              Icon(Icons.keyboard_arrow_down_rounded, color: context.colorScheme.secondary.withValues(alpha: 0.5)),
            ],
          ),
        ),
      ),
    );
  }
}
