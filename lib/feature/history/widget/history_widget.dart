import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../configs/app_startup.dart';
import '../../../shared/navigation/navigation_service.dart';
import '../../../shared/utils/colors.dart';
import '../../home/model/trip_history_model.dart';
import '../route/routes.dart';

class HistoryWidget extends StatelessWidget {
  TripHistoryModel? tripHistoryModel;
  HistoryWidget({Key? key, this.tripHistoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        getIt<NavigationService>().toWithParameters(
            routeName: HistoryRoutes.historyDetails,
            args: {"tripHistoryModel": tripHistoryModel});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tripHistoryModel?.fromLocName ?? "",
                style: GoogleFonts.poppins(
                    fontSize: 16.sp, fontWeight: FontWeight.w500)),
            Text(tripHistoryModel?.totalTimeTaken ?? "",
                style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.cabyGrey)),
            Text('FINISHED',
                style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.cabyGreen)),
          ],
        ),
      ),
    );
  }
}
