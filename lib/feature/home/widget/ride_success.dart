import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../configs/app_startup.dart';
import '../../../shared/navigation/navigation_service.dart';
import '../../../shared/utils/colors.dart';
import '../../../shared/utils/custom_styles.dart';
import '../../auth/sign_up/model/user.dart';
import '../../auth/widget/custom_bottom_button.dart';
import '../cubits/trip_cubit.dart';
import '../model/payloads/rating_payload.dart';
import '../route/routes.dart';

class RideSuccessful extends StatefulWidget {
  final DriverInfo? driverInfo;
  const RideSuccessful({Key? key, this.driverInfo}) : super(key: key);

  @override
  State<RideSuccessful> createState() => _RideSuccessfulState();
}

class _RideSuccessfulState extends State<RideSuccessful> {
  double? ratings;

  User user = getIt<User>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomButton(
        onPressed: () {
          getIt<NavigationService>().clearAllTo(routeName: HomeRoutes.home);
        },
        textStyle: AppStyles.largeText.copyWith(fontSize: 16.sp),
        text: "Submit rating",
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Rony Brown",
            style: AppStyles.largeText.copyWith(fontSize: 16.sp),
          ),
          SizedBox(height: 50.h),
          Divider(
            color: AppColors.cabyGrey,
            height: 20.h,
          ),
          Text(
            "\$ 1,000",
            style: AppStyles.largeText.copyWith(fontSize: 46.sp),
          ),
          Divider(
            color: AppColors.cabyGrey,
            height: 20.h,
          ),
          SizedBox(height: 50.h),
          Text(
            "Rate your trip",
            style: AppStyles.smallText,
          ),
          SizedBox(height: 10.h),
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rat) {
              ratings = rat;
            },
          )
        ],
      )),
    );
  }

  rating() {
    late RatingPayload payload;
    payload = RatingPayload(
        ratedFor: widget.driverInfo!.drivers![0],
        ratedBy: user.userId,
        reason: "",
        tripId: widget.driverInfo!.id,
        value: ratings);

    getIt<TripCubit>().rating(payload);
  }
}
