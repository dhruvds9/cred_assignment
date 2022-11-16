import 'package:carousel_slider/carousel_slider.dart';
import 'package:cred_assignment/screens/details_page.dart';
import 'package:cred_assignment/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainCard extends StatefulWidget {
  final int index;
  const MainCard({Key? key, required this.index}) : super(key: key);

  @override
  State<MainCard> createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailsPage(
                  index: widget.index,
                )));
      },
      child: Card(
        elevation: 10,
        color: platinumWhiteColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: screenHeight * 45,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Hero(
                  tag: 'carousel${widget.index}',
                  child: CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 2.0,
                      height: screenHeight * 0.3,
                      autoPlay: true,
                    ),
                    items: imgList
                        .map((item) => Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Center(
                                  child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                child: Image.network(
                                  item,
                                  fit: BoxFit.cover,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                ),
                              )),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Hero(
                          tag: 'name${widget.index}',
                          child: Text(
                            "Pizzeria ${widget.index}",
                            style: GoogleFonts.montserrat(
                              textStyle: montserratStyle,
                            ),
                          ),
                        ),
                        Hero(
                          tag: 'rating${widget.index}',
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.green[900],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Text(
                                  "4.3",
                                  style: GoogleFonts.montserrat(
                                    textStyle: montserratStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white.withOpacity(0.8)),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  color: Colors.white.withOpacity(0.8),
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Hero(
                      tag: 'distance${widget.index}',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Distance from location : ",
                            style: GoogleFonts.montserrat(
                              textStyle: montserratStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(
                            "2.3 km",
                            style: GoogleFonts.montserrat(
                              textStyle: montserratStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Hero(
                      tag: 'cost${widget.index}',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cost for two : ",
                            style: GoogleFonts.montserrat(
                              textStyle: montserratStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(
                            "₹ 2,400",
                            style: GoogleFonts.montserrat(
                              textStyle: montserratStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
