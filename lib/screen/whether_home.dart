import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherHomeScreen extends StatefulWidget {
  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  late String _name;
  late String _weatherInfo;
  late String _image;
  late String _humidity;
  // Size size = MediaQuery.of(context);
  bool _isAlwaysShown = false;

  bool _showTrackOnHover = true;
  final List<Map<String, String>> data = [
    {
      'icon': '☁️',
      'name': 'Today',
      'description': 'Thunderstorm',
    },
    {
      'icon': '🌤️',
      'name': 'Tomorrow',
      'description': 'Thunderstorm',
    },
    {
      'icon': '🌦️',
      'name': 'Fri',
      'description': 'Cloudy',
    },
    {
      'icon': '⛈️',
      'name': 'Sat',
      'description': 'Rain',
    },
    {
      'icon': '☁️',
      'name': 'Today',
      'description': 'Thunderstorm',
    },
    {
      'icon': '🌤️',
      'name': 'Tomorrow',
      'description': 'Thunderstorm',
    },
    {
      'icon': '🌦️',
      'name': 'Fri',
      'description': 'Cloudy',
    },
    {
      'icon': '⛈️',
      'name': 'Sat',
      'description': 'Rain',
    },
  ];

  Future _refresh() {
    return Future.delayed(Duration(seconds: 2));
  }

//func()

// adding whether api and checking its connection.
  late String _location;
  late Future<Map<String, dynamic>> _weatherData;

  @override
  void initState() {
    super.initState();
    _location = 'kathmandu';
    _weatherData = fetchWeatherData(_location);
  }

//yo chai fetch garna vanda aagadi future ra data chai dynamic garna ko lagi map ma haleko.
  Future<Map<String, dynamic>> fetchWeatherData(String location) async {
    final apiKey = '3a94de4ee7cb4a73b5f105107232103';
    final apiUrl =
        'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$location&aqi=yes';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final current = data['current'];
      final tempC = current['temp_c'];
      final condition = current['condition']['text'];
      final image = "https:${current['condition']['icon']}";
      final windKph = current['wind_kph'];
      final humidity = current['humidity'];

      setState(() {
        _weatherInfo = '$tempC °C\n';
        _name = '$condition';
        _image = '$image';
      });
      return jsonDecode(response.body);
    } else {
      throw Exception("Give Proper Name To Display Data");
    }
  }

  // void setLocation() {
  //   _location = name.toString();
  // }

//   //yo chai location ko lagi ho.
//   void _onLocationChanged(String value) {
//     setState(() {

//       _location = name.toString();
//     });
//   }

// //yo chai search ko lagi detch gareko
//   void _onSearchPressed() {
//     setState(() {
//       _weatherData = fetchWeatherData(_location);
//     });
//   }

  // TextEditingController name = TextEditingController();
  // String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 51, 98, 181),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          title: Center(child: Text('Today')),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          //main screen
          child: Stack(children: [
            //background
            Image.asset(
              "assets/images/bg.jpg",
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                      ),

                      Column(
                        children: [
                          TextField(
                            autofocus: true,
                            autocorrect: true,
                            style: TextStyle(color: Colors.white),
                            onChanged: (value) {
                              setState(() {
                                _location = value;
                              });
                            },
                            decoration: InputDecoration(
                                hintText: "Enter any text to search",
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 72, 232, 144))),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      //temperature field
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _weatherInfo,
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _name,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                Image.network(_image),
                              ],
                            ),
                          )
                        ],
                      ),
                      //name and icon

                      SizedBox(
                        height: 50,
                      ),
                      // Container(
                      //   // color: Colors.white,

                      //   // decoration: BoxDecoration(
                      //   //   borderRadius: BorderRadius.circular(16.0),
                      //   //   border: Border.all(color: Colors.grey),
                      //   // ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: [
                      //         Icon(Icons.home),
                      //         SizedBox(
                      //           width: 10,
                      //         ),
                      //         Text("Kathmandu,Nepal"),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 30,
                      ),
                      //add icon and text
                      Row(
                        children: [
                          Container(
                            height: 20,
                            child: Image.asset(
                              'assets/images/flag.png',
                              scale: 1,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Kathmandu,Nepal',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.calendar_month,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Next Forecast",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),

                      //heading and icon

                      SizedBox(
                        height: 10,
                      ),
                      // main data set
                      Expanded(
                          child: Scrollbar(
                        radius: Radius.circular(10),
                        thickness: 8,
                        isAlwaysShown: _isAlwaysShown,
                        showTrackOnHover: _showTrackOnHover,
                        child: RefreshIndicator(
                          onRefresh: _refresh,
                          // child: FutureBuilder<Map<String, dynamic>>(
                          //   future: _weatherData,
                          //   builder: (context, snapshot) {
                          //     if (snapshot.hasData) {
                          //       final weather = snapshot.data!;
                          //       return Column(
                          //         children: [
                          //           Text(weather['location']['name']),
                          //           Text('${weather['current']['temp_c']}°C'),
                          //           Text(weather['current']['condition']['text']),
                          //         ],
                          //       );
                          //     } else if (snapshot.hasError) {
                          //       return Text('Error: ${snapshot.error}');
                          //     } else {
                          //       return CircularProgressIndicator();
                          //     }
                          //   },
                          // ),

                          // ListView.builder(
                          //     itemCount: data.length,
                          //     itemBuilder: (BuildContext context, int index) {
                          //       return ClipRect(
                          //         child: Card(
                          //           child: ListTile(
                          //             title: Text(data[index]['name']!),
                          //             subtitle:
                          //                 Text(data[index]['description']!),
                          //             leading: Text(
                          //               data[index]['icon']!,
                          //               style: TextStyle(fontSize: 24),
                          //             ),
                          //             trailing: Text('32\u00B0 C'),
                          //           ),
                          //         ),
                          //       );
                          //     }),
                          child: FutureBuilder<Map<String, dynamic>>(
                            future: fetchWeatherData(_location),
                            builder: (BuildContext context,
                                AsyncSnapshot<Map<String, dynamic>> snapshot) {
                              if (snapshot.hasData) {
                                final location = snapshot.data!['location'];
                                final current = snapshot.data!['current'];
                                return ListView(
                                  children: [
                                    Card(
                                      child: ListTile(
                                        title: Text(location['name']),
                                        subtitle: Text(
                                            current['temp_c'].toString() +
                                                '\u00B0 C'),
                                        leading: Image.network(_image),
                                        trailing: Icon(Icons.arrow_forward_ios),
                                        onTap: () {},
                                      ),
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text(
                                  "Enter the valid address",
                                  style: TextStyle(color: Colors.white),
                                ));
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ),
                      )),
                    ]))
          ]),
        ));
  }
}

//       // child: Card(
//       //   child: Container(
//       //     height: 200,
//       //     decoration: BoxDecoration(
//       //       borderRadius: BorderRadius.circular(10),
//       //       gradient: LinearGradient(
//       //         begin: Alignment.topCenter,
//       //         end: Alignment.bottomCenter,
//       //         colors: [
//       //           Color.fromARGB(255, 205, 7, 7)
//       //               .withOpacity(0.2),
//       //           Color.fromARGB(255, 115, 255, 22)
//       //               .withOpacity(0.5),
//       //         ],
//       //       ),
//       //     ),
//       //     child: Column(
//       //       mainAxisAlignment: MainAxisAlignment.center,
//       //       children: [
//       //         Text(
//       //           'Glass Effect Card',
//       //           style: TextStyle(fontSize: 24),
//       //         ),
//       //         SizedBox(height: 20),
//       //         Text(
//       //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sagittis euismod risus, nec vulputate dolor feugiat vel. Nullam sed ultrices est.',
//       //           textAlign: TextAlign.center,
//       //         ),
//       //       ],
//       //     ),
//       //   ),
//       // ),
//     );
//   },
// ),
