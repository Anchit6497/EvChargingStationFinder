import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/components/custom_button.dart';
import 'package:flutter_application_1/features/controllers/appointment_controller.dart';
import 'package:get/get.dart';

class BookAppointment extends StatefulWidget {
  final String docId;
  final String docName;

  const BookAppointment({Key? key, required this.docId, required this.docName}) : super(key: key);

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedFinishTime = TimeOfDay.now();

  var controller = Get.put(AppointmentController());

  @override
  void initState() {
    super.initState();
    initializeBooking(widget.docName); // Initialize the station name when the widget is created
  }

  void initializeBooking(String stationName) {
    controller.stationName.value = stationName;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        controller.appointmentDate.text = selectedDate.toLocal().toString().split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime ? selectedStartTime : selectedFinishTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child ?? Container(),
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          selectedStartTime = pickedTime;
          controller.appointmentStartTime.text = selectedStartTime.format(context);
          if (_isTimeEarlier(selectedFinishTime, selectedStartTime)) {
            selectedFinishTime = selectedStartTime;
            controller.appointmentEndTime.text = selectedFinishTime.format(context);
          }
        } else {
          selectedFinishTime = pickedTime;
          controller.appointmentEndTime.text = selectedFinishTime.format(context);
          if (_isTimeEarlier(pickedTime, selectedStartTime)) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Invalid Time'),
                content: Text('Finish time cannot be earlier than start time.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          }
        }
      });
    }
  }

  bool _isTimeEarlier(TimeOfDay time1, TimeOfDay time2) {
    return time1.hour < time2.hour || (time1.hour == time2.hour && time1.minute < time2.minute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text('Book Appointment'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Image.asset('assests/booking.jpg', height: 250),
                      Text(
                        'Select Date',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "${selectedDate.toLocal()}".split(' ')[0],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: const Text('Select date'),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Select Time:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Start Time:',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                selectedStartTime.format(context),
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () => _selectTime(context, true),
                                child: Text('Select start time'),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Finish Time:',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                selectedFinishTime.format(context),
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () => _selectTime(context, false),
                                child: Text('Select finish time'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: CustomButton(
          buttonText: "Confirm Booking",
          onTap: () async {
            await controller.bookAppointment(widget.docId, context);
          },
        ),
      ),
    );
  }
}
