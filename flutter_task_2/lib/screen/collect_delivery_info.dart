import 'package:flutter/material.dart';
import 'package:flutter_task_2/controller/datetime_controller.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class DateTimeSelectionPage extends StatelessWidget {
  final DateTimeController controller = Get.put(DateTimeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Date and Time')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Collection Date'),
              const SizedBox(height: 15,),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.optionselected(true, true, false, false);
                          String formattedDate =
                              DateFormat('dd MMM').format(DateTime.now());
                          controller.selectedCollectionDate.value =
                              "Today\n$formattedDate";
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: controller.todayselectedcollection.value
                                ? Color.fromRGBO(74, 128, 223, 1)
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Column(
                            children: [
                              Text(
                                controller
                                    .generateDateOptions(true)[0]
                                    .split('\n')
                                    .first,
                                style: TextStyle(
                                  color: controller.todayselectedcollection.value
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                controller
                                    .generateDateOptions(true)[0]
                                    .split('\n')
                                    .last,
                                style: TextStyle(
                                  color: controller.todayselectedcollection.value
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.optionselected(true, false, true, false);
                          String formattedDate = DateFormat('dd MMM')
                              .format(DateTime.now().add(Duration(days: 1)));
                          controller.selectedCollectionDate.value =
                              "Today\n$formattedDate";
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: controller.tomorrowselectedcollection.value
                                ? Color.fromRGBO(74, 128, 223, 1)
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Column(
                            children: [
                              Text(
                                controller
                                    .generateDateOptions(true)[1]
                                    .split('\n')
                                    .first,
                                style: TextStyle(
                                  color:
                                      controller.tomorrowselectedcollection.value
                                          ? Colors.white
                                          : Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                controller
                                    .generateDateOptions(true)[1]
                                    .split('\n')
                                    .last,
                                style: TextStyle(
                                  color:
                                      controller.tomorrowselectedcollection.value
                                          ? Colors.white
                                          : Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.selectDate(context, true);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: controller.selecteddateselctedcollection.value
                                ? Color.fromRGBO(74, 128, 223, 1)
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Column(
                            children: [
                              Text(
                                controller
                                    .generateDateOptions(true)[2]
                                    .split('\n')
                                    .first,
                                style: TextStyle(
                                  color: controller
                                          .selecteddateselctedcollection.value
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                controller
                                    .generateDateOptions(true)[2]
                                    .split('\n')
                                    .last,
                                style: TextStyle(
                                  color: controller
                                          .selecteddateselctedcollection.value
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            const SizedBox(height: 15,),
              Text('Collection Time'),
              Obx(() => Row(
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                          hint: Text('Morning'),
                          value: controller
                                  .selectedCollectionTimeMorning.value.isNotEmpty
                              ? controller.selectedCollectionTimeMorning.value
                              : null,
                          items: controller
                              .getTimeOptionsMorning()
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            controller.selectedCollectionTimeMorning.value =
                                newValue ?? '';
                            controller.selectedCollectionTimeAfternoon.value = '';
                            controller.morningSelectedCollection.value = true;
                          },
                        ),
                      ),
                    
                      Expanded(
                        child: DropdownButton<String>(
                          hint: Text('Afternoon'),
                          value: controller.selectedCollectionTimeAfternoon.value
                                      .isNotEmpty &&
                                  controller.getTimeOptionsAfternoon().contains(
                                      controller
                                          .selectedCollectionTimeAfternoon.value)
                              ? controller.selectedCollectionTimeAfternoon.value
                              : null,
                          items: controller
                              .getTimeOptionsAfternoon()
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            controller.selectedCollectionTimeMorning.value = '';
                            controller.selectedCollectionTimeAfternoon.value =
                                newValue ?? '';
                            controller.morningSelectedCollection.value = false;
                          },
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 15),
              Text('Delivery Date'),
               SizedBox(height: 20),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.optionselected(false, true, false, false);
                          String formattedDate =
                              DateFormat('dd MMM').format(DateTime.now());
                          controller.selectedDeliveryDate.value =
                              "Today\n$formattedDate";
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: controller.todayselecteddelivery.value
                                ? Color.fromRGBO(74, 128, 223, 1)
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Column(
                            children: [
                              Text(
                                controller
                                    .generateDateOptions(false)[0]
                                    .split('\n')
                                    .first,
                                style: TextStyle(
                                  color: controller.todayselecteddelivery.value
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                controller
                                    .generateDateOptions(false)[0]
                                    .split('\n')
                                    .last,
                                style: TextStyle(
                                  color: controller.todayselecteddelivery.value
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.optionselected(false, false, true, false);
                          String formattedDate = DateFormat('dd MMM')
                              .format(DateTime.now().add(Duration(days: 1)));
                          controller.selectedDeliveryDate.value =
                              "Today\n$formattedDate";
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: controller.tomorrowselecteddelivery.value
                                ? Color.fromRGBO(74, 128, 223, 1)
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Column(
                            children: [
                              Text(
                                controller
                                    .generateDateOptions(false)[1]
                                    .split('\n')
                                    .first,
                                style: TextStyle(
                                  color: controller.tomorrowselecteddelivery.value
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                controller
                                    .generateDateOptions(false)[1]
                                    .split('\n')
                                    .last,
                                style: TextStyle(
                                  color: controller.tomorrowselecteddelivery.value
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.selectDate(context, false);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: controller.selecteddateselcteddelivery.value
                                ? Color.fromRGBO(74, 128, 223, 1)
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Column(
                            children: [
                              Text(
                                controller
                                    .generateDateOptions(false)[2]
                                    .split('\n')
                                    .first,
                                style: TextStyle(
                                  color:
                                      controller.selecteddateselcteddelivery.value
                                          ? Colors.white
                                          : Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                controller
                                    .generateDateOptions(false)[2]
                                    .split('\n')
                                    .last,
                                style: TextStyle(
                                  color:
                                      controller.selecteddateselcteddelivery.value
                                          ? Colors.white
                                          : Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 10),
              Text('Delivery Time'),
              SizedBox(height: 20),
              Obx(() => Row(
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                          hint: Text('Morning'),
                          value: controller
                                  .selectedDeliveryTimeMorning.value.isNotEmpty
                              ? controller.selectedDeliveryTimeMorning.value
                              : null,
                          items: controller
                              .getTimeOptionsMorning()
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            controller.selectedDeliveryTimeMorning.value =
                                newValue ?? '';
                            controller.selectedDeliveryTimeAfternoon.value = '';
                            controller.morningSelectedDelivery.value = true;
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: DropdownButton<String>(
                          hint: Text('Afternoon'),
                          value: controller.selectedDeliveryTimeAfternoon.value
                                      .isNotEmpty &&
                                  controller.getTimeOptionsAfternoon().contains(
                                      controller
                                          .selectedDeliveryTimeAfternoon.value)
                              ? controller.selectedDeliveryTimeAfternoon.value
                              : null,
                          items: controller
                              .getTimeOptionsAfternoon()
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            controller.selectedDeliveryTimeAfternoon.value =
                                newValue ?? '';
                            controller.selectedDeliveryTimeMorning.value = '';
                            controller.morningSelectedDelivery.value = false;
                          },
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 20),
              Obx(() => Text(
                    controller.errorMessage.value,
                    style: TextStyle(color: Colors.red),
                  )),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style:ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(74, 128, 223, 1)
                  ),
                  onPressed: () {
                    if (controller.validateDates()) {
                      Get.snackbar("Success", "Dates are valid");
                    }
                  },
                  child: Text('Continue',style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}