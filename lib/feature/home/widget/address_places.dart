import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/utils/asset_images.dart';
import '../../../shared/utils/colors.dart';
import '../model/place_coordinate.dart';
import '../model/prediction.dart';

// ignore: must_be_immutable
class AddressPlaces extends StatefulWidget {
  List<Prediction>? places;
  final ValueChanged<Prediction> onChanged;

  AddressPlaces({required this.places, required this.onChanged});

  @override
  _AddressPlacesState createState() => _AddressPlacesState();
}

class _AddressPlacesState extends State<AddressPlaces> {
  @override
  Widget build(BuildContext context) {
    return showContent();
  }

  Widget showContent() {
    if (widget.places == null) return SizedBox();
    if (widget.places!.isNotEmpty) return addressListView();

    if (widget.places!.isEmpty) return addressNotFound();
    return SizedBox();
  }

  Widget addressNotFound() {
    return Container(
      // color: Colors.green,
      padding: EdgeInsets.only(top: 47.h),
      child: Text(
        "Address Not Found",
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 14.sp,
        ),
      ),
    );
  }

  Widget addressListView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17.83.w),
      margin: EdgeInsets.only(top: 20.h),
      color: Colors.white,
      child: widget.places!.length > 0
          ? ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return PredictionTile(
                  prediction: widget.places![index],
                  onChanged: widget.onChanged,
                );
              },
              separatorBuilder: (context, index) => const Divider(
                    color: AppColors.cabyGrey,
                  ),
              itemCount: widget.places!.length)
          : SizedBox(),
    );
  }
}

class PredictionTile extends StatelessWidget {
  final Prediction prediction;
  final ValueChanged<Prediction> onChanged;
  PredictionTile({required this.prediction, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(prediction);
      },
      // splashColor: AppColors.backgroundGrey.withOpacity(0.1),
      child: Container(
        height: 54.h,
        width: double.infinity,
        child: Row(
          children: [
            SvgPicture.asset(AssetResources.LOCATION),
            SizedBox(width: 13.21.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prediction.mainText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.poppins(fontSize: 14.sp),
                  ),
                  Text(prediction.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.poppins(fontSize: 14.sp)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RecentTile extends StatelessWidget {
  final PlaceCoordinate recentLocation;
  final ValueChanged<PlaceCoordinate> onChanged;
  RecentTile({required this.recentLocation, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            onChanged(recentLocation);
          },
          // splashColor: AppColors.backgroundGrey.withOpacity(0.1),
          child: Container(
            height: 54.h,
            width: double.infinity,
            child: Row(
              children: [
                SvgPicture.asset(AssetResources.LOCATION),
                SizedBox(width: 13.21.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.poppins(fontSize: 14.sp),
                      ),
                      Text(recentLocation.formattedAddress ?? "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                              fontSize: 12.sp, color: AppColors.cabyGrey)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const Divider(
          color: AppColors.cabyGrey,
        ),
      ],
    );
  }
}
