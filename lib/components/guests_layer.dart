import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

import '../services/repository.dart';
import '../utils/consts.dart';

class GuestsLayer extends StatefulWidget {
  const GuestsLayer({Key? key}) : super(key: key);

  @override
  State<GuestsLayer> createState() => _GuestsLayerState();
}

class _GuestsLayerState extends State<GuestsLayer> {
  int guestsValue = 1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Consumer(
      builder: (context, watch, Widget? child) {
        final reservationWatcher = context.watch<ReservationRepo>();
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedContainer(
              padding: EdgeInsets.all(25.0),
              width: screenWidth,
              height: reservationWatcher.stage > 2 ? screenHeight * 0.55 : 0.0,
              color: orangeColor,
              alignment: Alignment.topCenter,
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOutCubic,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "How many guests should we expect?",
                      style: GoogleFonts.montserrat(
                        textStyle: montserratStyle.copyWith(
                          fontSize: 36,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 150),
                    child: NumberPicker(
                      minValue: 1,
                      maxValue: 15,
                      zeroPad: true,
                      value: guestsValue,
                      infiniteLoop: false,
                      itemHeight: 100,
                      axis: Axis.horizontal,
                      textStyle: GoogleFonts.montserrat(
                        textStyle: montserratStyle.copyWith(
                          fontSize: 64,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      selectedTextStyle: GoogleFonts.montserrat(
                        textStyle: montserratStyle.copyWith(
                          fontSize: 72,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          guestsValue = value;
                          reservationWatcher.saveGuests(value);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
