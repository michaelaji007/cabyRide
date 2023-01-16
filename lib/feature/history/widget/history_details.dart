import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_caby_rider/shared/utils/asset_images.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../configs/app_startup.dart';
import '../../../shared/navigation/navigation_service.dart';
import '../../../shared/utils/colors.dart';
import '../../../shared/utils/display_utils.dart';
import '../../../shared/widgets/zepta_app_bar.dart';
import '../../home/model/trip_history_model.dart';
import '../../home/widget/color_points.dart';
import '../../profile/route/routes.dart';

class HistoryDetails extends StatefulWidget {
  final TripHistoryModel? tripHistoryModel;
  const HistoryDetails({Key? key, this.tripHistoryModel}) : super(key: key);

  @override
  State<HistoryDetails> createState() => _HistoryDetailsState();
}

class _HistoryDetailsState extends State<HistoryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const Header(
              text: "History details",
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 270.h,
                          width: double.infinity,
                          color: AppColors.darkBlue,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: <Widget>[
                                        PointsWithColor(
                                          colour: AppColors.cabyGrey,
                                          margin: EdgeInsets.only(
                                              left: 3.w, top: 20.h),
                                        ),
                                        const Points(),
                                        const Points(),
                                        const Points(),
                                        const Points(),
                                        PointsWithColor(
                                          colour: AppColors.cabyLightBlue,
                                          margin: EdgeInsets.only(
                                              left: 3.w,
                                              top: 10.h,
                                              bottom: 40.h),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Column(
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Pickup',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12.0,
                                                    color: Colors.grey),
                                              ),
                                              // SizedBox(height: 10.h),
                                              SizedBox(
                                                height: 25,
                                                child: TextField(
                                                  // enabled: false,
                                                  controller:
                                                      TextEditingController(
                                                          text: widget
                                                              .tripHistoryModel
                                                              ?.fromLocName),
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    disabledBorder:
                                                        InputBorder.none,
                                                  ),
                                                  onTap: () {
                                                    //Navigator.pop(context);
                                                  },
                                                  keyboardType:
                                                      TextInputType.text,
                                                  onSubmitted: (value) {
                                                    value = value;
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                          // Divider(),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Destination',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12.0,
                                                    color: Colors.grey),
                                              ),
                                              // SizedBox(height: 10.h),
                                              SizedBox(
                                                height: 25,
                                                child: TextField(
                                                  enabled: false,
                                                  controller:
                                                      TextEditingController(
                                                          text: widget
                                                              .tripHistoryModel
                                                              ?.toLocName),
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    disabledBorder:
                                                        InputBorder.none,
                                                  ),
                                                  onTap: () {
                                                    //Navigator.pop(context);
                                                  },
                                                  keyboardType:
                                                      TextInputType.text,
                                                  onSubmitted: (value) {
                                                    value = value;
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 27.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'Your ride with ',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.sp,
                                          color: AppColors.darkBlue),
                                      children: [
                                        TextSpan(
                                          text: widget
                                              .tripHistoryModel?.driverName,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Oct 16, 2019",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.sp,
                                        color: AppColors.cabyGrey),
                                  )
                                ]),
                          ),
                          Divider(
                            height: 40.h,
                            color: AppColors.cabyGrey,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Payment",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11.sp,
                                      color: AppColors.cabyGrey),
                                ),
                                SizedBox(
                                  height: 10.w,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            AssetResources.MASTERCARD),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          "****",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.sp,
                                              color: AppColors.darkBlue),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          "0000",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.sp,
                                              color: AppColors.darkBlue),
                                        ),
                                      ],
                                    ),
                                    Row(children: [
                                      Text(
                                        "\$ ${DisplayUtils.formatAmount(widget.tripHistoryModel!.amountPaid!.toInt())}",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20.sp,
                                            color: AppColors.darkBlue),
                                      ),
                                    ])
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  "12/12",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11.sp,
                                      color: AppColors.cabyGrey),
                                ),
                              ]),
                          Divider(
                            height: 50.h,
                            color: AppColors.cabyGrey,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Need help?",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11.sp,
                                      color: AppColors.cabyGrey),
                                ),
                                SizedBox(
                                  height: 10.w,
                                ),
                                NeedHelp(
                                  text: "Resend receipt",
                                  onTap: () {},
                                ),
                                NeedHelp(
                                  text: "Lost an item",
                                  onTap: () {
                                    getIt<NavigationService>().to(
                                        routeName: ProfileRoutes.lostAnItem);
                                  },
                                ),
                                NeedHelp(
                                  text: "Report misconduct",
                                  onTap: () {
                                    getIt<NavigationService>().to(
                                        routeName:
                                            ProfileRoutes.reportMisconduct);
                                  },
                                )
                              ]),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NeedHelp extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const NeedHelp({Key? key, required this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: AppColors.darkBlue),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14.sp,
            )
          ],
        ),
      ),
    );
  }
}
