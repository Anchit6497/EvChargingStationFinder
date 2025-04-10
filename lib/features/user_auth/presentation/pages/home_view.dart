import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/station_view.dart';
import 'package:flutter_application_1/map_page.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/features/controllers/home_controller.dart'; // Adjust import according to your project structure

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 220, 220, 202),
        title: Row(
          children: [
            Text("Welcome"),
            SizedBox(width: 10),
            Text("User"),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Popular Stations",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<QuerySnapshot>(
                future: controller.getStationList(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    var data = snapshot.data?.docs;

                    return ListView.builder(
                      itemCount: data?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => StationView(doc: data[index])));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            height: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color.fromARGB(255, 220, 220, 202),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assests/station.png', 
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data![index]['stationName'],  
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        data[index]['stationaddress'], 
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => MapPage(doc: data[index])),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assests/viewmap.png',  // Corrected path
                                        width: 30,
                                        height: 30,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "View Map",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

