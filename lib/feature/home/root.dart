import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_caby_rider/feature/home/widget/app_drawer.dart';
import 'package:go_caby_rider/feature/home/widget/map.dart';

import '../../shared/utils/storage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var key = GlobalKey<ScaffoldState>();

  Timer? timer;
  bool check = true;
  bool showFloatingBar = false;

  var status;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserTokenManager.getAccessToken().then((value) => print(value));
    return Scaffold(
      key: key,
      drawer: AppDrawer(),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: MapWidget(
              handleShowDrawer: () {
                key.currentState?.openDrawer();
              },
            ),
          ),
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: showFloatingBar == false
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: InkWell(
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (_) => ViewCurrentRideScreen(trip: _trip,)));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: Colors.black),
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "You have a ride pending",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.navigate_next,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
