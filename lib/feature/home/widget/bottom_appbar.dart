import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_caby_rider/shared/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../configs/app_startup.dart';
import '../cubits/address_cubit.dart';
import '../model/place_coordinate.dart';
import 'color_points.dart';

class BottomAppBar2 extends StatefulWidget with PreferredSizeWidget {
  final Function(String? v)? setDestinationText;
  final Function(String? v)? setPickUpText;
  final Function(FocusNode v)? pickUpNode;
  final Function(FocusNode v)? dropNode;
  final Function(PlaceCoordinate? v)? pickUpCord;
  final String? dropOffValue;
  final String? pickupValue;
  final Function(bool v)? onclearDropoff;
  BottomAppBar2(
      {Key? key,
      this.setDestinationText,
      this.setPickUpText,
      this.dropNode,
      this.dropOffValue,
      this.pickUpCord,
      this.pickupValue,
      this.onclearDropoff,
      this.pickUpNode})
      : super(key: key);

  @override
  _BottomAppBar2State createState() => _BottomAppBar2State();

  @override
  Size get preferredSize => const Size.fromHeight(130);
}

class _BottomAppBar2State extends State<BottomAppBar2> {
  TextEditingController pickController = TextEditingController();
  TextEditingController destController = TextEditingController();
  Timer? _timer;
  Timer? _timer2;
  PlaceCoordinate? pickUpCoordinate;
  Map currentAddress = {};
  FocusNode focusPickup = FocusNode();
  FocusNode focusDest = FocusNode();
  @override
  void initState() {
    getIt<AddressCubit>().findPickupCoordinateAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dropOffValue != null) {
      destController.text = widget.dropOffValue!;
    }
    if (widget.pickupValue != null) {
      pickController.text = widget.pickupValue!;
      if (destController.text.isEmpty) {
        focusDest.requestFocus();
      } else {}
    }
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            PointsWithColor(
              colour: AppColors.cabyGrey,
              margin: const EdgeInsets.only(left: 33.0, top: 00.0),
            ),
            const Points(),
            const Points(),
            const Points(),
            const Points(),
            const Points(),
            PointsWithColor(
              colour: AppColors.cabyLightBlue,
              margin:
                  const EdgeInsets.only(left: 33.0, top: 10.0, bottom: 10.0),
            )
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: BlocConsumer(
                      bloc: GetIt.I.get<AddressCubit>(),
                      listener: (context, state) {
                        if (state is FetchedPickUpCoordinate) {
                          pickController.text =
                              state.coordinate!.formattedAddress;
                          pickUpCoordinate = state.coordinate;
                          widget.pickUpCord!(state.coordinate);
                          focusDest.requestFocus();
                        }
                      },
                      builder: (context, state) {
                        return TextField(
                          focusNode: focusPickup,
                          onTap: () {
                            widget.pickUpNode!(focusPickup);
                          },
                          onChanged: (v) {
                            widget.setPickUpText!(v);
                            setState(() {});
                          },
                          controller: pickController,
                          decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.darkBlue),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.darkBlue),
                              ),
                              labelText: "Pickup",
                              labelStyle: GoogleFonts.poppins(
                                  color: AppColors.darkBlue, fontSize: 11.sp),
                              suffixIcon: IconButton(
                                icon: isFetchingCoordinate.value
                                    ? const CircularProgressIndicator()
                                    : const Icon(
                                        Icons.clear,
                                        color: AppColors.cabyGrey,
                                      ),
                                onPressed: () {
                                  pickController.clear();
                                },
                              )),
                        );
                      },
                    )),
                const SizedBox(
                  height: 10.0,
                ),
//
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: TextField(
                    focusNode: focusDest,
                    onChanged: (v) {
                      widget.setDestinationText!(v);
                      setState(() {});
                    },
                    onTap: () {
                      widget.dropNode!(focusDest);
                    },
                    controller: destController,
                    decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.darkBlue),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.darkBlue),
                        ),
                        labelText: "Destination",
                        labelStyle: GoogleFonts.poppins(
                            color: AppColors.darkBlue, fontSize: 11.sp),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            destController.clear();
                            widget.onclearDropoff!(true);
                          },
                        )),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
