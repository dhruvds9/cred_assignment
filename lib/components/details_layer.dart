import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../services/repository.dart';
import '../utils/consts.dart';

class DetailsLayer extends StatefulWidget {
  const DetailsLayer({Key? key}) : super(key: key);

  @override
  State<DetailsLayer> createState() => _DetailsLayerState();
}

class _DetailsLayerState extends State<DetailsLayer> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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
              height: reservationWatcher.stage > 1 ? screenHeight * 0.7 : 0.0,
              color: orangeColor,
              alignment: Alignment.topCenter,
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOutCubic,
              child: reservationWatcher.stage <= 2
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 150.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Who do we reserve the table for?",
                                style: GoogleFonts.montserrat(
                                  textStyle: montserratStyle.copyWith(
                                    fontSize: 36,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Card(
                                elevation: 10,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: TextFormField(
                                  controller: nameController,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    reservationWatcher.saveName(value);
                                  },
                                  style: GoogleFonts.montserrat(
                                    textStyle: montserratStyle.copyWith(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  decoration: InputDecoration(
                                      isDense: true,
                                      fillColor: platinumWhiteColor,
                                      filled: true,
                                      hintText:
                                          reservationWatcher.errorFlag == true
                                              ? "Full Name Required"
                                              : "Full Name",
                                      hintStyle: GoogleFonts.montserrat(
                                        textStyle: montserratStyle.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color:
                                                reservationWatcher.errorFlag ==
                                                        true
                                                    ? darkErrorColor
                                                    : darkColor),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide.none)),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Card(
                                elevation: 10,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: TextFormField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  onChanged: (value) {
                                    reservationWatcher.saveNumber(value);
                                  },
                                  style: GoogleFonts.montserrat(
                                    textStyle: montserratStyle.copyWith(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  decoration: InputDecoration(
                                      isDense: true,
                                      fillColor: platinumWhiteColor,
                                      filled: true,
                                      hintText:
                                          reservationWatcher.errorFlag == true
                                              ? "Phone Number Required"
                                              : "Phone Number",
                                      hintStyle: GoogleFonts.montserrat(
                                        textStyle: montserratStyle.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color:
                                                reservationWatcher.errorFlag ==
                                                        true
                                                    ? darkErrorColor
                                                    : darkColor),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide.none)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                                nameController.text,
                                style: GoogleFonts.montserrat(
                                  textStyle:
                                      montserratStyle.copyWith(fontSize: 36),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "+91 ${phoneController.text}",
                                style: GoogleFonts.montserrat(
                                  textStyle:
                                      montserratStyle.copyWith(fontSize: 36),
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
      },
    );
  }
}
