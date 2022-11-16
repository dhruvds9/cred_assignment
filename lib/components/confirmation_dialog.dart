import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../services/repository.dart';
import '../utils/consts.dart';

class ConfirmationDialog extends StatelessWidget {
  final int index;
  const ConfirmationDialog({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Consumer(
      builder: (context, watch, Widget? child) {
        final reservationWatcher = context.watch<ReservationRepo>();
        return Dialog(
          insetAnimationCurve: Curves.easeInOutCubic,
          insetAnimationDuration: Duration(seconds: 2),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          elevation: 10,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: screenWidth * 0.85,
              maxHeight: screenHeight * 0.5,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              color: darkColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Text(
                    "Reserved!",
                    style: GoogleFonts.montserrat(
                      textStyle: montserratStyle.copyWith(
                          fontSize: 36, color: platinumWhiteColor),
                    ),
                  ),
                ),
                Center(
                  child: CircleAvatar(
                    backgroundColor: darkGreenColor,
                    radius: 40,
                    child: Icon(
                      Icons.check_rounded,
                      color: platinumWhiteColor,
                      size: 60,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    "Pizzeria $index will be expecting ${reservationWatcher.reservationGuests} guests, including ${reservationWatcher.reservationName}, at ${reservationWatcher.reservationHours}:${reservationWatcher.reservationMinutes} on ${DateFormat('dd MMM').format((reservationWatcher.reservationDate.toLocal()))}",
                    style: GoogleFonts.montserrat(
                      textStyle: montserratStyle.copyWith(
                          fontSize: 24, color: platinumWhiteColor),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        color: orangeColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Got it",
                              style: GoogleFonts.montserrat(
                                textStyle: montserratStyle.copyWith(
                                  fontSize: 32,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
