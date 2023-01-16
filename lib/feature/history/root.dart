import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_caby_rider/feature/history/widget/history_widget.dart';
import 'package:go_caby_rider/shared/utils/colors.dart';

import '../../configs/app_startup.dart';
import '../../shared/utils/custom_styles.dart';
import '../../shared/widgets/zepta_app_bar.dart';
import '../home/cubits/trip_cubit.dart';
import '../home/model/trip_history_model.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<TripHistoryModel> allHistory = [];

  @override
  void initState() {
    getIt<TripCubit>().getTripHistory();
    super.initState();
  }

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "History",
                    style: AppStyles.largeText.copyWith(fontSize: 26.sp),
                  ),
                  Text(
                    "Your trips",
                    style: AppStyles.smallText
                        .copyWith(fontSize: 14.sp, color: AppColors.cabyGrey),
                  )
                ],
              ),
            ),
            SizedBox(height: 40.h),
            Expanded(
                child: BlocConsumer(
              bloc: getIt<TripCubit>(),
              listener: (context, state) {
                if (state is TripHistoryLoading) {}
                if (state is TripHistorySuccess) {
                  allHistory = state.trips!;
                  // setState(() {});
                }
                if (state is TripHistoryError) {}
              },
              builder: (context, state) {
                if (state is TripHistoryLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return HistoryWidget(
                        tripHistoryModel: allHistory[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            SizedBox(height: 10.h),
                            const Divider(
                              color: AppColors.cabyGrey,
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      );
                    },
                    itemCount: allHistory.length);
              },
            ))
          ],
        ),
      ),
    );
  }
}
