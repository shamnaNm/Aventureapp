import 'package:aventure/models/category_model.dart';
import 'package:aventure/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../models/activity_model.dart';
import '../../widgets/activitytimelist.dart';
import '../../widgets/timepicker.dart';
import 'medinfo.dart';
// class ActivityBooking extends StatefulWidget {
//   const ActivityBooking({super.key, required this.activity, });
//   final ActivityModel activity;
//   @override
//   State<ActivityBooking> createState() => _ActivityBookingState();
//   double get totalAmount => totalAmount;
// }
// class _ActivityBookingState extends State<ActivityBooking> {
//   int _ticketsSelected = 0;
//   double _totalAmount = 0;
//   void _calculateTotalAmount() {
//     _totalAmount = _ticketsSelected * widget.activity.price!.toDouble();
//   }
//   void _incrementTickets() {
//     setState(() {
//       _ticketsSelected++;
//       _calculateTotalAmount();
//     });
//   }
//   void _decrementTickets() {
//     setState(() {
//       if (_ticketsSelected > 0) {
//         _ticketsSelected--;
//         _calculateTotalAmount();
//       }
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.orange.withOpacity(0.1),
//           title: Text("Booking", style: TextStyle(color: Colors.black)),
//           centerTitle: true,
//         ),
//         body: CustomScrollView(
//           slivers: [
//             SliverFillRemaining(
//               hasScrollBody: true,
//               child: SingleChildScrollView(
//                 child: Container(
//                   color: Colors.orange.withOpacity(0.1),
//                   padding: EdgeInsets.all(10),
//                   width: double.infinity,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         height: 100,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(5),
//                           border: Border.all(
//                             color: Colors.grey,
//                             width: 0.2,
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               width: MediaQuery.of(context).size.width / 3,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                               padding: EdgeInsets.all(8),
//                               child: Container(
//                                 height: 300, // Fixed height for the image container
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   image: DecorationImage(
//                                     image: NetworkImage(widget.activity.image!),
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Column(
//                               children: [
//                                 Text(
//                                   widget.activity.title!,
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Text("Activity", style: TextStyle(color: Colors.grey)),
//                                 Text(
//                                   "${widget.activity.eventer} Eventers",
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.normal,
//                                     fontStyle: FontStyle.normal,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             //Second and third column widgets can be added here
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         "Pick a Date",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       Container(
//                         child: DatePickerWidget(),
//                       ),
//                       SizedBox(height: 20),
//                       Text(
//                         "Pick a Time",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       ActivityListWidget(),
//                       SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Tickets",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           SizedBox(width: 150),
//                           FloatingActionButton(
//                             heroTag: 'decrement_button',
//                             backgroundColor: Colors.orange,
//                             onPressed: _decrementTickets,
//                             tooltip: 'Reduce tickets',
//                             child: Icon(Icons.remove),
//                           ),
//                           SizedBox(width: 16.0),
//                           Text('$_ticketsSelected'),
//                           SizedBox(width: 16.0),
//                           FloatingActionButton(
//                             heroTag: 'increment_button',
//                             backgroundColor: Colors.orange,
//                             onPressed: _incrementTickets,
//                             tooltip: 'Add tickets',
//                             child: Icon(Icons.add),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         bottomNavigationBar: Container(
//           padding: EdgeInsets.all(10),
//           height: 100,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//             ),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//           Column(
//           children: [
//           Text(
//           'Total',
//             style: TextStyle(color: Colors.black),
//           ),
//           Text(
//             '₹${_totalAmount.toStringAsFixed(2)}',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           ],
//         ),
//         ElevatedButton(
//         onPressed: () {
//
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => MedicalInfoPage(),
//               settings: RouteSettings(arguments: {'totalAmount': _totalAmount,
//               }),
//             ),
//           );
//
//
//       // Get.to(() => MedInfoPage(), arguments: {'totalAmount': _totalAmount});
//     },
//     style: ElevatedButton.styleFrom(
//     backgroundColor: Colors.orange,
//     padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//     ),
//           child: Text(
//             'Next',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//             ],
//           ),
//         ),
//     );
//   }
// }

//
// class ActivityBooking extends StatefulWidget {
//   const ActivityBooking({super.key, required this.activity});
//   final ActivityModel activity;
//
//   @override
//   State<ActivityBooking> createState() => _ActivityBookingState();
// }
//
// class _ActivityBookingState extends State<ActivityBooking> {
//   int _ticketsSelected = 0;
//   double _totalAmount = 0;
//   DateTime? _selectedDate;
//   String? _selectedTime;
//
//   void _calculateTotalAmount() {
//     _totalAmount = _ticketsSelected * widget.activity.price!.toDouble();
//   }
//
//   void _incrementTickets() {
//     setState(() {
//       _ticketsSelected++;
//       _calculateTotalAmount();
//     });
//   }
//
//   void _decrementTickets() {
//     setState(() {
//       if (_ticketsSelected > 0) {
//         _ticketsSelected--;
//         _calculateTotalAmount();
//       }
//     });
//   }
//
//   void _SelectedDate(DateTime date) {
//     setState(() {
//       _selectedDate = date;
//     });
//   }
//
//   void _onTimeSelected(String time) {
//     setState(() {
//       _selectedTime = time;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.orange.withOpacity(0.1),
//         title: Text("Booking", style: TextStyle(color: Colors.black)),
//         centerTitle: true,
//       ),
//       body: CustomScrollView(
//         slivers: [
//           SliverFillRemaining(
//             hasScrollBody: true,
//             child: SingleChildScrollView(
//               child: Container(
//                 color: Colors.orange.withOpacity(0.1),
//                 padding: EdgeInsets.all(10),
//                 width: double.infinity,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       height: 100,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(5),
//                         border: Border.all(
//                           color: Colors.grey,
//                           width: 0.2,
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width / 3,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             padding: EdgeInsets.all(8),
//                             child: Container(
//                               height: 300,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 image: DecorationImage(
//                                   image: NetworkImage(widget.activity.image!),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Column(
//                             children: [
//                               Text(
//                                 widget.activity.title!,
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text("Activity", style: TextStyle(color: Colors.grey)),
//                               Text(
//                                 "${widget.activity.eventer} Eventers",
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.normal,
//                                   fontStyle: FontStyle.normal,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       "Pick a Date",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     Container(
//                      child: DatePickerWidget(),
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       "Pick a Time",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                    ActivityListWidget(),
//                     SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Tickets",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         SizedBox(width: 150),
//                         FloatingActionButton(
//                           heroTag: 'decrement_button',
//                           backgroundColor: Colors.orange,
//                           onPressed: _decrementTickets,
//                           tooltip: 'Reduce tickets',
//                           child: Icon(Icons.remove),
//                         ),
//                         SizedBox(width: 16.0),
//                         Text('$_ticketsSelected'),
//                         SizedBox(width: 16.0),
//                         FloatingActionButton(
//                           heroTag: 'increment_button',
//                           backgroundColor: Colors.orange,
//                           onPressed: _incrementTickets,
//                           tooltip: 'Add tickets',
//                           child: Icon(Icons.add),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Container(
//         padding: EdgeInsets.all(10),
//         height: 100,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               children: [
//                 Text(
//                   'Total',
//                   style: TextStyle(color: Colors.black),
//                 ),
//                 Text(
//                   '₹${_totalAmount.toStringAsFixed(2)}',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => MedicalInfoPage(),
//                     settings: RouteSettings(arguments: {
//                       'activity': widget.activity,
//                       'selectedDate': _selectedDate,
//                       'selectedTime': _selectedTime,
//                       'ticketsSelected': _ticketsSelected,
//                       'totalAmount': _totalAmount,
//                     }),
//                   ),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.orange,
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               child: Text(
//                 'Next',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class ActivityBooking extends StatefulWidget {
  const ActivityBooking({super.key, required this.activity,});
  final ActivityModel activity;


  @override
  State<ActivityBooking> createState() => _ActivityBookingState();
}

class _ActivityBookingState extends State<ActivityBooking> {
  int _ticketsSelected = 0;
  double _totalAmount = 0;
  DateTime? _selectedDate;
  String? _selectedTime;

  void _calculateTotalAmount() {
    _totalAmount = _ticketsSelected * widget.activity.price!.toDouble();
  }

  void _incrementTickets() {
    setState(() {
      _ticketsSelected++;
      _calculateTotalAmount();
    });
  }

  void _decrementTickets() {
    setState(() {
      if (_ticketsSelected > 0) {
        _ticketsSelected--;
        _calculateTotalAmount();
      }
    });
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _onTimeSelected(String time) {
    setState(() {
      _selectedTime = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange.withOpacity(0.1),
        title: Text("Booking", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: true,
            child: SingleChildScrollView(
              child: Container(
                color: Colors.orange.withOpacity(0.1),
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.all(8),
                            child: Container(
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  image: NetworkImage(widget.activity.image!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                widget.activity.title!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("Activity", style: TextStyle(color: Colors.grey)),
                              Text(
                                "${widget.activity.eventer} Eventers",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Pick a Date",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      child: DatePickerWidget(
                        onDateSelected: _onDateSelected,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Pick a Time",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    ActivityListWidget(
                      activity: widget.activity,
                      onTimeSelected: _onTimeSelected,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Tickets",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 150),
                        FloatingActionButton(
                          heroTag: 'decrement_button',
                          backgroundColor: Colors.orange,
                          onPressed: _decrementTickets,
                          tooltip: 'Reduce tickets',
                          child: Icon(Icons.remove),
                        ),
                        SizedBox(width: 16.0),
                        Text('$_ticketsSelected'),
                        SizedBox(width: 16.0),
                        FloatingActionButton(
                          heroTag: 'increment_button',
                          backgroundColor: Colors.orange,
                          onPressed: _incrementTickets,
                          tooltip: 'Add tickets',
                          child: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'Total',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  '₹${_totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedicalInfoPage(),
                    settings: RouteSettings(arguments: {

                      'activity': widget.activity,
                      'selectedDate': _selectedDate,
                      'selectedTime': _selectedTime,
                      'ticketsSelected': _ticketsSelected,
                      'totalAmount': _totalAmount,
                    }),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Next',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
