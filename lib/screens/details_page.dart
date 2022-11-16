import 'package:cred_assignment/components/date_and_time_layer.dart';
import 'package:cred_assignment/components/details_layer.dart';
import 'package:cred_assignment/components/guests_layer.dart';
import 'package:cred_assignment/services/repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/floating_button.dart';
import '../components/restaurant_data_layer.dart';
import '../utils/consts.dart';

class DetailsPage extends StatefulWidget {
  final int index;
  const DetailsPage({Key? key, required this.index}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer(builder: (context, watch, Widget? child) {
        final reservationWatcher = context.watch<ReservationRepo>();
        return WillPopScope(
          onWillPop: reservationWatcher.stage == 0
              ? () async {
                  return true;
                }
              : () async {
                  reservationWatcher.stageBackward();
                  return false;
                },
          child: Scaffold(
            backgroundColor:
                // reservationWatcher.stage == 0 ? platinumWhiteColor :
                darkColor,
            body: Stack(
              children: [
                RestaurantDataLayer(
                  index: widget.index,
                ),
                DateAndTimeLayer(),
                DetailsLayer(),
                GuestsLayer(),
                FloatingButton(index: widget.index),
              ],
            ),
          ),
        );
      }),
    );
  }
}
