import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../services/repository.dart';
import '../utils/consts.dart';

class RestaurantDataLayer extends StatefulWidget {
  final int index;

  const RestaurantDataLayer({Key? key, required this.index}) : super(key: key);

  @override
  State<RestaurantDataLayer> createState() => _RestaurantDataLayerState();
}

class _RestaurantDataLayerState extends State<RestaurantDataLayer>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Consumer(
      builder: (context, watch, Widget? child) {
        final reservationWatcher = context.watch<ReservationRepo>();
        return ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Ink(
                    decoration: ShapeDecoration(
                      color: platinumWhiteColor.withOpacity(0.2),
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                        onPressed: () {
                          reservationWatcher.stageReset();
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: platinumWhiteColor,
                        )),
                  ),
                  Hero(
                    tag: 'name${widget.index}',
                    child: Text(
                      "Pizzeria ${widget.index}",
                      style: GoogleFonts.montserrat(
                        textStyle: montserratStyle.copyWith(
                          color: platinumWhiteColor,
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      enableFeedback: false,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.transparent,
                      )),
                ],
              ),
            ),
            if (reservationWatcher.stage == 0)
              Column(
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width,
                      maxHeight: MediaQuery.of(context).size.height * 0.5,
                    ),
                    child: Hero(
                      tag: 'carousel${widget.index}',
                      child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                        ),
                        items: imgList
                            .map((item) => Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Center(
                                      child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    child: Image.network(
                                      item,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hero(
                                tag: 'distance${widget.index}',
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Distance from location : ",
                                      style: GoogleFonts.montserrat(
                                        textStyle: montserratStyle.copyWith(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: platinumWhiteColor),
                                      ),
                                    ),
                                    Text(
                                      "2.3 km",
                                      style: GoogleFonts.montserrat(
                                        textStyle: montserratStyle.copyWith(
                                            fontSize: 20,
                                            color: platinumWhiteColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Hero(
                                tag: 'cost${widget.index}',
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Cost for two : ",
                                      style: GoogleFonts.montserrat(
                                        textStyle: montserratStyle.copyWith(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: platinumWhiteColor),
                                      ),
                                    ),
                                    Text(
                                      "₹ 2,400",
                                      style: GoogleFonts.montserrat(
                                        textStyle: montserratStyle.copyWith(
                                            fontSize: 20,
                                            color: platinumWhiteColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Hero(
                          tag: 'rating${widget.index}',
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.green[900],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            child: Column(
                              children: [
                                Text(
                                  "4.3",
                                  style: GoogleFonts.montserrat(
                                    textStyle: montserratStyle.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white.withOpacity(0.8)),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  color: Colors.white.withOpacity(0.8),
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    controller: tabController,
                    labelStyle: GoogleFonts.montserrat(
                      textStyle: montserratStyle.copyWith(
                          fontWeight: FontWeight.w800, color: orangeColor),
                    ),
                    labelColor: orangeColor,
                    unselectedLabelStyle:
                        GoogleFonts.montserrat(textStyle: montserratStyle),
                    unselectedLabelColor: platinumWhiteColor,
                    indicatorColor: orangeColor,
                    tabs: const <Widget>[
                      Tab(
                        text: "Menu",
                      ),
                      Tab(
                        text: "Reviews",
                      ),
                      Tab(
                        text: "About",
                      ),
                    ],
                  )
                ],
              ),
          ],
        );
      },
    );
  }
}
