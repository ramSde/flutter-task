import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class DateTimeController extends GetxController {
  var selectedCollectionDate = ''.obs;
  var selectedCollectionTimeMorning = ''.obs;
  var selectedCollectionTimeAfternoon = ''.obs;
  var selectedDeliveryDate = ''.obs;
  var selectedDeliveryTimeMorning = ''.obs;
  var selectedDeliveryTimeAfternoon = ''.obs;
  var errorMessage = ''.obs;
  var anotherselecteddatecollection = ''.obs;
  var anotherselecteddatedelivery = ''.obs;
  var todayselecteddelivery = true.obs;
  var tomorrowselecteddelivery = false.obs;
  var selecteddateselcteddelivery = false.obs;
  var todayselectedcollection = true.obs;
  var tomorrowselectedcollection = false.obs;
  var selecteddateselctedcollection = false.obs;
  var morningSelectedDelivery = true.obs; // Flag to track morning selected for delivery
  var morningSelectedCollection = true.obs; // Flag to track morning selected for collection

  DateTime now = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    selectedCollectionDate.value = collectionDates.first;
    selectedDeliveryDate.value = deliveryDates.first;
    anotherselecteddatecollection.value = DateFormat('dd MMM').format(now.add(Duration(days: 2)));
    anotherselecteddatedelivery.value = DateFormat('dd MMM').format(now.add(Duration(days: 2)));
    // Initialize the time values
    selectedCollectionTimeMorning.value = getTimeOptionsMorning().first;
    selectedCollectionTimeAfternoon.value = '';
    selectedDeliveryTimeMorning.value = getTimeOptionsMorning().first;
    selectedDeliveryTimeAfternoon.value = '';
  }

  List<String> get collectionDates => generateDateOptions(true);
  List<String> get deliveryDates => generateDateOptions(false);

  List<String> generateDateOptions(bool isCollection) {
    List<String> dates = [
      "Today\n${DateFormat('dd MMM').format(now)}",
      "Tomorrow\n${DateFormat('dd MMM').format(now.add(Duration(days: 1)))}",
      "Select Date\n${isCollection ? anotherselecteddatecollection.value : anotherselecteddatedelivery.value}",
    ];
    return dates;
  }

  void optionselected(bool isCollection, bool one, bool two, bool three) {
    if (!isCollection) {
      if (one) {
        todayselecteddelivery.value = true;
        tomorrowselecteddelivery.value = false;
        selecteddateselcteddelivery.value = false;
      } else if (two) {
        todayselecteddelivery.value = false;
        tomorrowselecteddelivery.value = true;
        selecteddateselcteddelivery.value = false;
      } else {
        todayselecteddelivery.value = false;
        tomorrowselecteddelivery.value = false;
        selecteddateselcteddelivery.value = true;
      }
    } else {
      if (one) {
        todayselectedcollection.value = true;
        tomorrowselectedcollection.value = false;
        selecteddateselctedcollection.value = false;
      } else if (two) {
        todayselectedcollection.value = false;
        tomorrowselectedcollection.value = true;
        selecteddateselctedcollection.value = false;
      } else {
        todayselectedcollection.value = false;
        tomorrowselectedcollection.value = false;
        selecteddateselctedcollection.value = true;
      }
    }
  }

  bool validateDates() {
    
if (selectedCollectionDate.value == selectedDeliveryDate.value) {
      errorMessage.value = 'Collection and Delivery dates cannot be the same.';
      return false;
    }

    try {
      DateTime collectionDateTime = DateFormat('dd MMM hh:mm a').parse(
          "${selectedCollectionDate.value.split('\n').last} ${getSelectedCollectionTime()}");
      DateTime deliveryDateTime = DateFormat('dd MMM hh:mm a').parse(
          "${selectedDeliveryDate.value.split('\n').last} ${getSelectedDeliveryTime()}");

      if (deliveryDateTime.isBefore(collectionDateTime)) {
        errorMessage.value = 'Delivery date must be after the collection date.';
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Invalid date format: $e';
      print(errorMessage.value);
      return false;
    }

    errorMessage.value = '';
    return true;
  }

  Future<void> selectDate(BuildContext context, bool isCollection) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add((Duration(days: 2))),
      firstDate: DateTime.now().add((Duration(days: 2))),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      String formattedDate = DateFormat('dd MMM').format(picked);
      if (isCollection) {
        optionselected(true, false, false, true);
        anotherselecteddatecollection.value = formattedDate;
        selectedCollectionDate.value = "Select Date\n$formattedDate";
      } else {
        optionselected(false, false, false, true);
        anotherselecteddatedelivery.value = formattedDate;
        selectedDeliveryDate.value = "Select Date\n$formattedDate";
      }
    }
  }

  List<String> getTimeOptionsMorning() {
    return ["7:00 AM - 8:00 AM", "8:00 AM - 9:00 AM", "9:00 AM - 10:00 AM"];
  }

  List<String> getTimeOptionsAfternoon() {
    return [
  // Remaining code for getTimeOptionsAfternoon()
  "12:00 PM - 1:00 PM", "1:00 PM - 2:00 PM", "2:00 PM - 3:00 PM"];
}

String getSelectedCollectionTime() {
  return morningSelectedCollection.value 
      ? selectedCollectionTimeMorning.value
      : selectedCollectionTimeAfternoon.value;
}

String getSelectedDeliveryTime() {
  return morningSelectedDelivery.value
      ? selectedDeliveryTimeMorning.value
      : selectedDeliveryTimeAfternoon.value;
}
}
