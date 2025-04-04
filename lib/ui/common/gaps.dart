import 'package:currex/ui/common/sizes.dart';
import 'package:gap/gap.dart';

class AppGaps {
  // Custom size(px)
  static Gap custom({required double size}) => Gap(size);

  /// Size: 1px
  static const Gap line = Gap(1);

  /// Size: 4.5px
  static const Gap size1x = Gap(AppSizes.size1x);

  /// Size: 9px
  static const Gap size2x = Gap(AppSizes.size2x);

  /// Size: 13.5px
  static const Gap size3x = Gap(AppSizes.size3x);

  /// Size: 18px
  static const Gap size4x = Gap(AppSizes.size4x);

  /// Size: 22.5px
  static const Gap size5x = Gap(AppSizes.size5x);

  /// Size: 27px
  static const Gap size6x = Gap(AppSizes.size6x);

  /// Size: 36px
  static const Gap size8x = Gap(AppSizes.size8x);

  /// Size: 54px
  static const Gap size12x = Gap(AppSizes.size12x);

  /// Size: 72px
  static const Gap size16x = Gap(AppSizes.size16x);
}
