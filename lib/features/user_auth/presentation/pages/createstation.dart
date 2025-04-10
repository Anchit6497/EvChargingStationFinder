import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/custom_textfield.dart';
import 'package:flutter_application_1/features/controllers/station_creation_controller.dart';
import 'package:get/get.dart';

class CreateStation extends StatefulWidget {
  const CreateStation({super.key});

  @override
  State<CreateStation> createState() => _CreateStationState();
}

class _CreateStationState extends State<CreateStation> {
  var stationCreationController = Get.put(StationCreationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 600), // Set a max width for larger screens
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assests/peakpx.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50), // Add some top spacing
                  Text("Enter Station Details",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  SizedBox(height: 30),
                  CustomTextfield(
                    hint: "Station Name",
                    textController: stationCreationController.nameController,
                  ),
                  SizedBox(height: 30),
                  CustomTextfield(
                    hint: "Station Address",
                    textController: stationCreationController.stationaddressController,
                  ),
                  SizedBox(height: 30),
                  CustomTextfield(
                    hint: "Station Phone No.",
                    textController: stationCreationController.phoneController,
                  ),
                  SizedBox(height: 30),
                  CustomTextfield(
                    hint: "Description",
                    textController: stationCreationController.aboutController,
                  ),
                  SizedBox(height: 30),
                  CustomTextfield(
                    hint: "Station Rating",
                    textController: stationCreationController.ratingController,
                  ),
                  SizedBox(height: 30),
                  CustomTextfield(
                    hint: "Opening Time",
                    textController: stationCreationController.timingController,
                  ),
                  SizedBox(height: 30),
                  CustomTextfield(
                    hint: "Enter Station Latitude",
                    textController: stationCreationController.latitudeController,
                  ),
                  SizedBox(height: 30),
                  CustomTextfield(
                    hint: "Enter Station Longitude",
                    textController: stationCreationController.longitudeController,
                  ),
                  SizedBox(height: 50), // Add bottom spacing

                  GestureDetector(
                    onTap: () async {
                    await stationCreationController.CreateStation(context);
                    },
              
                    child: Container(
                      width: 110,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Add Station",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50), // Add more bottom spacing to avoid overflow
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
