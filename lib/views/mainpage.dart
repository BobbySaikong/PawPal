import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// import 'package:myfuwu/models/MyPets.dart';
import 'package:pawpal/myconfig.dart';
import 'package:pawpal/views/loginpage.dart';
import 'package:pawpal/models/user.dart';
// import 'package:myfuwu/shared/mydrawer.dart';
import 'package:pawpal/views/newpet.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatefulWidget {
  final User? user;

  const MainPage({super.key, required this.user});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<MyPets> listPets = [];
  String status = "No submissions yet.";
  DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm a');
  late double screenWidth, screenHeight;
  int numofpage = 1;
  int curpage = 1;
  int numofresult = 0;
  var color;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPets('');
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    if (screenWidth > 600) {
      screenWidth = 600;
    } else {
      screenWidth = screenWidth;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {
          //     showSearchDialog();
          //   },
          // ),
          IconButton(
            onPressed: () {
              loadPets('');
            },
            icon: Icon(Icons.refresh),
          ),

          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            icon: Icon(Icons.login),
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: screenWidth,
          child: Column(
            children: [
              listPets.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.find_in_page_outlined, size: 64),
                            SizedBox(height: 12),
                            Text(
                              status,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: listPets.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // IMAGE
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      width:
                                          screenWidth * 0.28, // more responsive
                                      height:
                                          screenWidth *
                                          0.22, // balanced aspect ratio
                                      color: Colors.grey[200],
                                      child: Image.network(
                                        '${MyConfig.baseUrl}/myfuwu/assets/uploads/${listPets[index].serviceId}.png',
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return const Icon(
                                                Icons.broken_image,
                                                size: 60,
                                                color: Colors.grey,
                                              );
                                            },
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  // TEXT AREA
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // PET NAME
                                        Text(
                                          listPets[index].petName
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                        const SizedBox(height: 4),

                                        // PET TYPE
                                        Text(
                                          listPets[index].petType
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                        const SizedBox(height: 6),

                                        // PET CATEGORY TAG
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.blueGrey.withOpacity(
                                              0.15,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Text(
                                            listPets[index].petCategory
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.blueGrey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // TRAILING ARROW BUTTON
                                  // IconButton(
                                  //   onPressed: () {
                                  //     showDetailsDialog(index);
                                  //   },
                                  //   icon: const Icon(
                                  //     Icons.arrow_forward_ios,
                                  //     size: 18,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              //pagination builder
              // SizedBox(
              //   height: screenHeight * 0.05,
              //   child: ListView.builder(
              //     shrinkWrap: true,
              //     itemCount: numofpage,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (context, index) {
              //       color = (curpage - 1) == index ? Colors.red : Colors.black;
              //       return TextButton(
              //         onPressed: () {
              //           curpage = index + 1;
              //           loadPets('');
              //         },
              //         child: Text(
              //           (index + 1).toString(),
              //           style: TextStyle(color: color, fontSize: 18),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Action for the button
          if (widget.user?.userId == '0') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Please login first/or register first"),
                backgroundColor: Colors.red,
              ),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          } else {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SubmitPetScreen(user: widget.user),
              ),
            );
            loadPets('');
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void loadPets(String searchQuery) {
    // TODO: implement loadPets
    listPets.clear();
    setState(() {
      status = "Loading...";
    });
    http
        .get(
          Uri.parse(
            '${MyConfig.baseUrl}/pawpal/api/load_pet_list.php',
            // ?search=$searchQuery&curpage=$curpage
          ),
        )
        .then((response) {
          if (response.statusCode == 200) {
            var jsonResponse = jsonDecode(response.body);
            // log(jsonResponse.toString());
            if (jsonResponse['success'] == 'true' &&
                jsonResponse['data'] != null &&
                jsonResponse['data'].isNotEmpty) {
              // has data → load to list
              listPets.clear();
              for (var item in jsonResponse['data']) {
                listPets.add(MyPets.fromJson(item));
              }
              // numofpage = int.parse(jsonResponse['numofpage'].toString());
              // numofresult = int.parse(
              //   jsonResponse['numberofresult'].toString(),
              // );
              // print(numofpage);
              // print(numofresult);
              setState(() {
                status = "";
              });
            } else {
              // success but EMPTY data
              setState(() {
                listPets.clear();
                status = "No submission yet.";
              });
            }
          } else {
            // request failed
            setState(() {
              listPets.clear();
              status = "Failed to load services";
            });
          }
        });
  }

  // void showSearchDialog() {
  //   TextEditingController searchController = TextEditingController();
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Search'),
  //         content: TextField(
  //           controller: searchController,
  //           decoration: InputDecoration(hintText: 'Enter search query'),
  //         ),
  //         actions: [
  //           TextButton(
  //             child: Text('Cancel'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: Text('Search'),
  //             onPressed: () {
  //               String search = searchController.text;
  //               if (search.isEmpty) {
  //                 loadPets('');
  //               } else {
  //                 loadPets(search);
  //               }
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void showDetailsDialog(int index) {
  //   String formattedDate = formatter.format(
  //     DateTime.parse(listPets[index].serviceDate.toString()),
  //   );
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(listPets[index].petName.toString()),
  //         content: SizedBox(
  //           width: screenWidth,
  //           child: SingleChildScrollView(
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 SizedBox(
  //                   child: Image.network(
  //                     //todo : check with mypets model.
  //                     '${MyConfig.baseUrl}/pawpal/assets/uploads/${listPets[index].petName}.png',
  //                     fit: BoxFit.cover,
  //                     errorBuilder: (context, error, stackTrace) {
  //                       return const Icon(
  //                         Icons.broken_image,
  //                         size: 128,
  //                         color: Colors.grey,
  //                       );
  //                     },
  //                   ),
  //                 ),

  //                 SizedBox(height: 10),
  //                 Table(
  //                   border: TableBorder.all(
  //                     color: Colors.grey,
  //                     width: 1.0,
  //                     style: BorderStyle.solid,
  //                   ),
  //                   columnWidths: {
  //                     0: FixedColumnWidth(100.0),
  //                     1: FlexColumnWidth(),
  //                   },
  //                   children: [
  //                     TableRow(
  //                       children: [
  //                         TableCell(
  //                           // Use TableCell to apply consistent styling/padding
  //                           verticalAlignment:
  //                               TableCellVerticalAlignment.middle,
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Text('Title'),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           verticalAlignment:
  //                               TableCellVerticalAlignment.middle,
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Text(
  //                               listPets[index].serviceTitle.toString(),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     TableRow(
  //                       children: [
  //                         TableCell(
  //                           verticalAlignment:
  //                               TableCellVerticalAlignment.middle,
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Text('Description'),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           verticalAlignment:
  //                               TableCellVerticalAlignment.middle,
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Text(
  //                               listPets[index].serviceDesc.toString(),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     TableRow(
  //                       children: [
  //                         TableCell(
  //                           verticalAlignment:
  //                               TableCellVerticalAlignment.middle,
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Text('Type'),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           verticalAlignment:
  //                               TableCellVerticalAlignment.middle,
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Text(
  //                               listPets[index].serviceType.toString(),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     TableRow(
  //                       children: [
  //                         TableCell(
  //                           verticalAlignment:
  //                               TableCellVerticalAlignment.middle,
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Text('District'),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           verticalAlignment:
  //                               TableCellVerticalAlignment.middle,
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Text(
  //                               listPets[index].serviceDistrict.toString(),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     TableRow(
  //                       children: [
  //                         TableCell(
  //                           verticalAlignment:
  //                               TableCellVerticalAlignment.middle,
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Text('Rate/Hour'),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           verticalAlignment:
  //                               TableCellVerticalAlignment.middle,
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Text('RM ${listPets[index].serviceRate}'),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     TableRow(
  //                       children: [
  //                         TableCell(
  //                           verticalAlignment:
  //                               TableCellVerticalAlignment.middle,
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Text('Date'),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           verticalAlignment:
  //                               TableCellVerticalAlignment.middle,
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Text(formattedDate),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     TableRow(
  //                       children: [
  //                         TableCell(
  //                           verticalAlignment:
  //                               TableCellVerticalAlignment.middle,
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Text('Provider'),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           verticalAlignment:
  //                               TableCellVerticalAlignment.middle,
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Text(listPets[index].userName.toString()),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     TableRow(
  //                       children: [
  //                         TableCell(
  //                           verticalAlignment:
  //                               TableCellVerticalAlignment.middle,
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Text('Phone'),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           verticalAlignment:
  //                               TableCellVerticalAlignment.middle,
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Text(listPets[index].userPhone.toString()),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(height: 5),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                   children: [
  //                     IconButton(
  //                       onPressed: () async {
  //                         await launchUrl(
  //                           Uri.parse(
  //                             'tel:${listPets[index].userPhone.toString()}',
  //                           ),
  //                           mode: LaunchMode.externalApplication,
  //                         );
  //                       },
  //                       icon: Icon(Icons.call),
  //                     ),
  //                     IconButton(
  //                       onPressed: () async {
  //                         await launchUrl(
  //                           Uri.parse(
  //                             'sms:${listPets[index].userPhone.toString()}',
  //                           ),
  //                           mode: LaunchMode.externalApplication,
  //                         );
  //                       },
  //                       icon: Icon(Icons.message),
  //                     ),
  //                     IconButton(
  //                       onPressed: () async {
  //                         await launchUrl(
  //                           Uri.parse(
  //                             'mailto:${listPets[index].userEmail.toString()}',
  //                           ),
  //                           mode: LaunchMode.externalApplication,
  //                         );
  //                       },
  //                       icon: Icon(Icons.email),
  //                     ),
  //                     IconButton(
  //                       onPressed: () async {
  //                         await launchUrl(
  //                           Uri.parse(
  //                             'https://wa.me/${listPets[index].userPhone.toString()}',
  //                           ),
  //                           mode: LaunchMode.externalApplication,
  //                         );
  //                       },
  //                       icon: Icon(Icons.wechat),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             child: Text('Close'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // Future<User> getServiceOwnerDetails(int index) async {
  //   String ownerid = listPets[index].userId.toString();
  //   User owner = User();
  //   try {
  //     final response = await http.get(
  //       Uri.parse(
  //         '${MyConfig.baseUrl}/myfuwu/api/getuserdetails.php?userid=$ownerid',
  //       ),
  //     );
  //     if (response.statusCode == 200) {
  //       var jsonResponse = response.body;
  //       var resarray = jsonDecode(jsonResponse);
  //       if (resarray['status'] == 'success') {
  //         owner = User.fromJson(resarray['data'][0]);
  //       }
  //     }
  //   } catch (e) {
  //     print('Error fetching user details: $e');
  //   }
  //   return owner;
  // }
}
