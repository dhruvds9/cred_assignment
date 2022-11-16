import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../services/repository.dart';
import '../utils/consts.dart';
import 'confirmation_dialog.dart';

class FloatingButton extends StatefulWidget {
  final int index;
  const FloatingButton({Key? key, required this.index}) : super(key: key);

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Consumer(
      builder: (context, watch, Widget? child) {
        final reservationWatcher = context.watch<ReservationRepo>();
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: screenWidth * 0.85,
                  child: ElevatedButton.icon(
                      onPressed: reservationWatcher.stage == 3
                          ? () async {
                              setState(() {
                                isLoading = true;
                              });
                              await Future.delayed(Duration(seconds: 2))
                                  .then((value) {
                                setState(() {
                                  isLoading = false;
                                });
                                reservationWatcher.stageReset();
                                showDialog(
                                    context: context,
                                    builder: (context) => ConfirmationDialog(
                                        index: widget.index));
                              });
                            }
                          : () {
                              reservationWatcher.stageForward();
                            },
                      style: ElevatedButton.styleFrom(
                          textStyle: GoogleFonts.montserrat(
                              textStyle: montserratStyle),
                          padding: EdgeInsets.all(25.0),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          primary: reservationWatcher.stage == 0
                              ? orangeColor
                              : darkColor,
                          onPrimary: reservationWatcher.stage == 0
                              ? darkColor
                              : platinumWhiteColor),
                      icon: isLoading == true
                          ? SizedBox(
                              width: 0.0,
                            )
                          : Icon(reservationWatcher.stage == 0
                              ? Icons.event_rounded
                              : reservationWatcher.stage == 1
                                  ? Icons.person_rounded
                                  : reservationWatcher.stage == 2
                                      ? Icons.people_rounded
                                      : Icons.table_restaurant_rounded),
                      label: isLoading == true
                          ? Center(
                              child: SpinKitThreeInOut(
                                color: platinumWhiteColor,
                                size: 26,
                              ),
                            )
                          : Text(reservationWatcher.stage == 0
                              ? "Reserve a table"
                              : reservationWatcher.stage == 1
                                  ? "Proceed to details"
                                  : reservationWatcher.stage == 2
                                      ? "Proceed to confirm seating"
                                      : "Book my table")),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
