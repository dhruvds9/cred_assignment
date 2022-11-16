import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

import '../services/repository.dart';
import '../utils/consts.dart';

class DateAndTimeLayer extends StatefulWidget {
  const DateAndTimeLayer({Key? key}) : super(key: key);

  @override
  State<DateAndTimeLayer> createState() => _DateAndTimeLayerState();
}

class _DateAndTimeLayerState extends State<DateAndTimeLayer> {
  int hourValue = 12;
  int minuteValue = 30;
  DateTime dateValue = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hourValue = DateTime.now().hour;
    minuteValue = DateTime.now().minute;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Consumer(builder: (context, watch, Widget? child) {
      final reservationWatcher = context.watch<ReservationRepo>();
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedContainer(
            padding: const EdgeInsets.all(25.0),
            width: screenWidth,
            height: reservationWatcher.stage > 0 ? screenHeight * 0.85 : 0.0,
            decoration: const BoxDecoration(
                color: orangeColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0))),
            alignment: Alignment.topCenter,
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOutCubic,
            child: reservationWatcher.stage <= 1
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Let's pick a date",
                          style: GoogleFonts.montserrat(
                            textStyle: montserratStyle.copyWith(fontSize: 36),
                          ),
                        ),
                      ),
                      DatePicker(
                        DateTime.now(),
                        height: screenHeight * 0.2,
                        width: screenWidth * 0.25,
                        dateTextStyle: GoogleFonts.montserrat(
                          textStyle: montserratStyle.copyWith(fontSize: 42),
                        ),
                        monthTextStyle: GoogleFonts.montserrat(
                          textStyle: montserratStyle.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        dayTextStyle: GoogleFonts.montserrat(
                          textStyle: montserratStyle.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        initialSelectedDate: DateTime.now(),
                        selectionColor: darkColor,
                        selectedTextColor: platinumWhiteColor,
                        onDateChange: (date) {
                          // New date selected
                          setState(() {
                            dateValue = date;
                            reservationWatcher.saveDate(date);
                          });
                        },
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "And time as well",
                          style: GoogleFonts.montserrat(
                            textStyle: montserratStyle.copyWith(
                              fontSize: 36,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 150),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            NumberPicker(
                              minValue: 00,
                              maxValue: 23,
                              zeroPad: true,
                              value: hourValue,
                              infiniteLoop: true,
                              textStyle: GoogleFonts.montserrat(
                                textStyle: montserratStyle.copyWith(
                                    fontSize: 42, fontWeight: FontWeight.w500),
                              ),
                              selectedTextStyle: GoogleFonts.montserrat(
                                textStyle: montserratStyle.copyWith(
                                  fontSize: 42,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  hourValue = value;
                                  reservationWatcher.saveHours(value);
                                });
                              },
                            ),
                            Text(
                              ":",
                              style: GoogleFonts.montserrat(
                                  textStyle: montserratStyle),
                            ),
                            NumberPicker(
                              minValue: 00,
                              maxValue: 59,
                              zeroPad: true,
                              value: minuteValue,
                              infiniteLoop: true,
                              textStyle: GoogleFonts.montserrat(
                                textStyle: montserratStyle.copyWith(
                                    fontSize: 42, fontWeight: FontWeight.w500),
                              ),
                              selectedTextStyle: GoogleFonts.montserrat(
                                textStyle:
                                    montserratStyle.copyWith(fontSize: 42),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  minuteValue = value;
                                  reservationWatcher.saveMinutes(value);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              DateFormat('dd MMM yyyy').format(
                                  (reservationWatcher.reservationDate
                                      .toLocal())),
                              style: GoogleFonts.montserrat(
                                textStyle: montserratStyle.copyWith(
                                  fontSize: 36,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${reservationWatcher.reservationHours} : ${reservationWatcher.reservationMinutes}",
                              style: GoogleFonts.montserrat(
                                textStyle: montserratStyle.copyWith(
                                  fontSize: 36,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Ink(
                          decoration: ShapeDecoration(
                            color: darkColor.withOpacity(0.5),
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                              onPressed: () {
                                reservationWatcher.stageBackward();
                                reservationWatcher.negateErrorFlag();
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: darkColor,
                              )),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      );
    });
  }
}
