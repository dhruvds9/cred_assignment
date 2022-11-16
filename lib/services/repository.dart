import 'package:flutter/material.dart';

class ReservationRepo extends ChangeNotifier {
  int stage = 0;
  DateTime reservationDate = DateTime.now();
  int reservationHours = DateTime.now().hour;
  int reservationMinutes = DateTime.now().minute;
  String reservationName = "";
  String reservationNumber = "";
  late int reservationGuests;
  bool errorFlag = false;

  void stageForward() {
    if (stage == 2) {
      if (reservationName.isEmpty ||
          reservationName.trim() == "" ||
          reservationNumber.isEmpty ||
          reservationNumber.trim() == "") {
        errorFlag = true;
      } else {
        errorFlag = false;
      }
    }
    if (errorFlag == false) {
      stage = stage + 1;
    }
    notifyListeners();
  }

  void stageBackward() {
    stage = stage - 1;
    notifyListeners();
  }

  void stageReset() {
    stage = 0;
    reservationName = "";
    reservationNumber = "";
    notifyListeners();
  }

  void saveDate(DateTime date) {
    reservationDate = date;
    notifyListeners();
  }

  void saveHours(int hours) {
    reservationHours = hours;
    notifyListeners();
  }

  void saveMinutes(int minutes) {
    reservationMinutes = minutes;
    notifyListeners();
  }

  void saveName(String name) {
    reservationName = name;
    notifyListeners();
  }

  void saveNumber(String number) {
    reservationNumber = number;
    notifyListeners();
  }

  void saveGuests(int guests) {
    reservationGuests = guests;
    notifyListeners();
  }

  void negateErrorFlag() {
    errorFlag = false;
    notifyListeners();
  }
}
