import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_caby_rider/configs/app_startup.dart';
import 'package:go_caby_rider/shared/widgets/cached_image.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/navigation/navigation_service.dart';
import '../../../shared/utils/asset_images.dart';
import '../../../shared/utils/colors.dart';
import '../../history/route/routes.dart';
import '../../payment/route/routes.dart';
import '../../profile/route/routes.dart';
import 'drawer.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cabyYellow,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width - 100,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 70.h,
            ),
            Container(
              padding: EdgeInsets.all(10.h),
              color: AppColors.darkBlue,
              height: 160.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Spacer(),
                  Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          getIt<NavigationService>()
                              .to(routeName: ProfileRoutes.profile);

                          // Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen()));
                        },
                        child: CabyCacheImage(
                          borderRadius: 30.r,
                          imgUrl:
                              'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "John Doe",
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  InkWell(
                    onTap: () {
                      getIt<NavigationService>()
                          .to(routeName: ProfileRoutes.profile);
                    },
                    child: Text(
                      "View profile",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            DrawerMenu(
              icon: AssetResources.HISTORY,
              title: "Trips History",
              onPressed: () {
                Navigator.pop(context);
                getIt<NavigationService>().to(routeName: HistoryRoutes.history);
              },
            ),
            // DrawerMenu(icon: 'corporate',title: 'Corporate',),
            DrawerMenu(
              icon: AssetResources.ABOUT,
              title: 'About',
              onPressed: () {
                Navigator.pop(context);
                // Navigator.push(context, MaterialPageRoute(builder: (_) => TripsHistoryScreen()));
              },
            ),

            DrawerMenu(
              icon: AssetResources.PAYMENT,
              title: 'Payments',
              onPressed: () {
                Navigator.pop(context);
                getIt<NavigationService>()
                    .to(routeName: PaymentRoutes.paymentMethod);
              },
            ),
            DrawerMenu(
              icon: AssetResources.FREE_RIDE,
              title: 'Free Rides',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            DrawerMenu(
              icon: AssetResources.SUPPORT,
              title: 'Support',
              onPressed: () {
                Navigator.pop(context);

                getIt<NavigationService>()
                    .to(routeName: ProfileRoutes.lostAnItem);

                // Navigator.push(context, MaterialPageRoute(builder: (_) => HelpScreen()));
              },
            ),
            DrawerMenu(
              icon: AssetResources.PRIVACY,
              title: 'Privacy',
              onPressed: () {
                Navigator.pop(context);
                // Navigator.push(context, MaterialPageRoute(builder: (_) => HelpScreen()));
              },
            ),
            SizedBox(
              height: 40.h,
            ),
//          DrawerMenu(icon: 'logout',title: 'Log Out',onPressed: (){
//
//          },),
            SizedBox(
              height: 60.h,
            )
          ],
        ),
      ),
    );
  }
}
