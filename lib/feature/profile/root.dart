import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../configs/app_configs.dart';
import '../../configs/app_startup.dart';
import '../../shared/navigation/navigation_service.dart';
import '../../shared/utils/asset_images.dart';
import '../../shared/utils/colors.dart';
import '../../shared/utils/storage.dart';
import '../../shared/widgets/button.dart';
import '../../shared/widgets/zepta_app_bar.dart';
import '../auth/route/routes.dart';
import '../auth/sign_up/model/user.dart';
import 'model/save_address_model.dart';
import 'widget/save_address_widget.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<SaveAddressModel> allSavedAddress = [
    SaveAddressModel(
        type: "Home",
        desc: "Area 2 section 1 Bendel street, Garki, Abuja",
        image: AssetResources.HOME),
    SaveAddressModel(
        type: "Work",
        desc: "Area 2 section 1 Bendel street, Garki, Abuja",
        image: AssetResources.WORK)
  ];

  final User user = getIt<User>();

  @override
  Widget build(BuildContext context) {
    // print(user.toJson());
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
              suffix: InkWell(
                onTap: () {
                  showLogoutBottomModal(context);
                },
                child: Container(
                    padding: EdgeInsets.only(right: 15.w),
                    child: Text("Sign out")),
              ),
            ),
            const HeaderText(
              text: "Profile",
              subText: "Your information",
            ),
            SizedBox(height: 40.h),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Personal details",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 11.sp,
                            color: AppColors.cabyGrey),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        user.phoneNumber ?? " ",
                        style: GoogleFonts.poppins(
                            fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                      Divider(
                        color: AppColors.cabyGrey,
                        height: 40.h,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                user.fullName?.split(" ")[0] ?? "",
                                style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              const VerticalDivider(
                                color: AppColors.cabyGrey,
                                thickness: 2,
                              ),
                            ],
                          ),
                          SizedBox(width: 50.w),
                          Text(
                            user.fullName?.split(" ")[1] ?? "",
                            style: GoogleFonts.poppins(
                                fontSize: 16.sp, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Divider(
                        color: AppColors.cabyGrey,
                        height: 40.h,
                      ),
                      Text(
                        user.email ?? " ",
                        style: GoogleFonts.poppins(
                            fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                      Divider(
                        color: AppColors.cabyGrey,
                        height: 40.h,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Saved Locations",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 11.sp,
                            color: AppColors.cabyGrey),
                      ),
                      SizedBox(height: 20.h),
                      Column(
                        children: allSavedAddress
                            .map((e) => SaveAddressWidget(
                                  saveAddressModel: e,
                                ))
                            .toList(),
                      )
                    ],
                  ),
                  SizedBox(height: 20.h),
                  AppButton(
                    text: "Update",
                    onPressed: () {},
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  showLogoutBottomModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 0,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        // width: 375.w,
        height: 303.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(29.r),
            topRight: Radius.circular(29.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              offset: const Offset(0, 4),
              blurRadius: 30,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 45.w,
              height: 6.h,
              margin: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.1),
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Text(
                  'Logging out?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF242F40),
                    fontSize: 18.0.sp,
                    height: 1.2,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () => getIt<NavigationService>().back(),
                    icon: const Icon(Icons.close, color: Color(0xFF50555C)),
                  ),
                ),
              ],
            ),
            Divider(
                height: 14.h, thickness: 1.2, color: const Color(0xFFF2F2F2)),
            SizedBox(height: 21.h),
            Text(
              'Are you sure you want\nlogout?',
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1.41,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF242F40),
              ),
            ),
            SizedBox(height: 51.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                modalButton(
                  buttonText: 'Cancel',
                  buttonType: ModalButtonType.outlined,
                  onPressed: () => getIt<NavigationService>().back(),
                ),
                SizedBox(width: 13.w),
                modalButton(
                  buttonText: 'Confirm',
                  buttonType: ModalButtonType.solid,
                  onPressed: () {
                    String routeName = AuthRoutes.login;
                    getIt<NavigationService>().clearAllTo(routeName: routeName);
                    Future.delayed(const Duration(seconds: 1),
                        () => UserTokenManager.deleteAccessToken());
                    getIt.unregister<User>();
                    Future.delayed(
                        const Duration(seconds: 1),
                        () =>
                            LocalStorageUtils.delete(AppConstants.userObject));
                    getIt<NavigationService>().clearAllTo(
                      routeName: AuthRoutes.login,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget modalButton({
    required String buttonText,
    required ModalButtonType buttonType,
    required VoidCallback onPressed,
  }) =>
      ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          primary: buttonType.color,
          fixedSize: Size(161.w, 50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
            side: BorderSide(color: buttonType.borderColor),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
              height: 1,
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: buttonType.textColor
              // AppColors.stoneBrandColor2,
              ),
        ),
      );
}

enum ModalButtonType { solid, outlined }

extension on ModalButtonType {
  Color get borderColor {
    switch (this) {
      case ModalButtonType.outlined:
        return AppColors.darkBlue;
      case ModalButtonType.solid:
        return AppColors.darkBlue;
    }
  }

  Color get color {
    switch (this) {
      case ModalButtonType.outlined:
        return Colors.transparent;
      case ModalButtonType.solid:
        return AppColors.darkBlue;
    }
  }

  Color get textColor {
    switch (this) {
      case ModalButtonType.outlined:
        return AppColors.darkBlue;
      case ModalButtonType.solid:
        return Colors.white;
    }
  }
}
