import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_caby_rider/shared/utils/colors.dart';

import '../../../../configs/app_startup.dart';
import '../../../../shared/navigation/navigation_service.dart';
import '../../../../shared/utils/asset_images.dart';
import '../../../home/route/routes.dart';
import '../../widget/auth_welcome.dart';

class RegistrationSuccess extends StatefulWidget {
  const RegistrationSuccess({Key? key}) : super(key: key);

  @override
  State<RegistrationSuccess> createState() => _RegistrationSuccessState();
}

class _RegistrationSuccessState extends State<RegistrationSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AssetResources.THANKYOU),
            const AuthWelcome(
              boldText: "Account Verified",
              smallText: 'Thank you and welcome to the gocaby family',
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    getIt<NavigationService>()
                        .pushReplace(routeName: HomeRoutes.home);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 20.w),
                    width: 100.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.h),
                      color: AppColors.cabyYellow,
                    ),
                    padding: EdgeInsets.all(10.h),
                    child: Row(
                      children: [Text("Proceed"), Icon(Icons.arrow_right_alt)],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
