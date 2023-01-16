import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_caby_rider/shared/widgets/zepta_app_bar.dart';

import '../../../shared/utils/colors.dart';
import '../../../shared/utils/custom_styles.dart';
import '../../../shared/widgets/button.dart';
import '../../../shared/widgets/form/custom_text_field.dart';

class LostAnItem extends StatefulWidget {
  const LostAnItem({Key? key}) : super(key: key);

  @override
  State<LostAnItem> createState() => _LostAnItemState();
}

class _LostAnItemState extends State<LostAnItem> {
  String? itemName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Text(
              "Lost an item",
              style: AppStyles.largeText.copyWith(fontSize: 16.sp),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50.h),
                    CustomTextField(
                      type: FieldType.text,
                      // textEditingController: phn,

                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Field is Required";
                        }
                        itemName = v;
                        return null;
                      },
                      header: "Item name",
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      type: FieldType.text,
                      minLines: 7,
                      maxLength: 7,
                      maxLines: 10,
                      alignLabelWithHint: true,
                      // textEditingController: phn,

                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Field is Required";
                        }
                        itemName = v;
                        return null;
                      },
                      header: "Item description",
                    ),
                    SizedBox(height: 30.h),
                    Center(
                        child: AppButton(
                            text: "Report lost item", onPressed: () {})),
                    SizedBox(height: 30.h),
                    Text(
                      "Please be informed that this would be sent to both the driver and our customer service to help make the process faster",
                      textAlign: TextAlign.center,
                      style: AppStyles.smallText
                          .copyWith(color: AppColors.cabyGrey, fontSize: 12.sp),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "You can also try contacting the driver directly to help locate the item",
                      textAlign: TextAlign.center,
                      style: AppStyles.smallText
                          .copyWith(color: AppColors.cabyGrey, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
