import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../shared/utils/asset_images.dart';
import '../../../shared/utils/colors.dart';
import '../../../shared/utils/custom_styles.dart';
import '../model/save_address_model.dart';

class SaveAddressWidget extends StatelessWidget {
  final SaveAddressModel? saveAddressModel;
  const SaveAddressWidget({Key? key, this.saveAddressModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(saveAddressModel!.image!),
            SizedBox(width: 20.w),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                saveAddressModel!.type!,
                style: AppStyles.largeText.copyWith(fontSize: 16),
              ),
              Text(
                saveAddressModel!.desc ?? "",
                style: AppStyles.smallText
                    .copyWith(fontSize: 12, color: AppColors.cabyGrey),
              ),
            ]),
            const Spacer(),
            BlueEdit()
          ],
        ),
        Divider(
          color: AppColors.cabyGrey,
          height: 50.h,
        ),
      ],
    );
  }
}

class BlueEdit extends StatelessWidget {
  final VoidCallback? onTap;
  const BlueEdit({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: AppColors.cabyLightBlue,
        ),
        child: SvgPicture.asset(AssetResources.PEN),
      ),
    );
  }
}
