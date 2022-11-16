import 'package:cred_assignment/components/main_card.dart';
import 'package:cred_assignment/utils/consts.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.text = "Pizzeria";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkColor,
        body: SingleChildScrollView(
          // shrinkWrap: true,
          // children: [
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Card(
                  elevation: 10,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: TextFormField(
                    controller: searchController,
                    style:
                        montserratStyle.copyWith(fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        isDense: true,
                        suffixIcon:
                            Icon(Icons.search, size: 22, color: darkColor),
                        fillColor: platinumWhiteColor,
                        filled: true,
                        hintText: "Search",
                        hintStyle: montserratStyle.copyWith(
                            fontWeight: FontWeight.w500),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Here are some restaurants we found",
                  style: montserratStyle.copyWith(
                    fontSize: 28,
                    color: platinumWhiteColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 25.0,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index) {
                      return MainCard(
                        index: index,
                      );
                    }),
              ),
            ],
          ),
          // ],
        ),
      ),
    );
  }
}
