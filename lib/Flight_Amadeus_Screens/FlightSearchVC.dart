import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../flyScreens/Flights.dart';
import '../flyScreens/airlineVC.dart';
import 'OriginDestSelectionVC.dart';
import 'flightClasstypesVC.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FlightSearchVC extends StatefulWidget {
  String classstr = '';

  @override
  _FlightSearchVCState createState() => _FlightSearchVCState();
}

class _FlightSearchVCState extends State<FlightSearchVC> with SingleTickerProviderStateMixin {
  String classstr = '';
  String passengerliststr = '';
 // int selectedindex = 0;
  int currentpage = 0;
  //TabController _tabController;
  late TabController _tabController;



  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      classstr = prefs.getString('classkey') ?? "";
      passengerliststr = prefs.getString('passengerlistkey') ?? "";
      currentpage = prefs.getInt('Roundtripindexkey') ?? 0;
      print('current page...');
      print(currentpage );
      print('class value...');
      print(classstr);
      print(passengerliststr);
      _tabController = new TabController(vsync: this, length: 2);
      print('tab...');
      print(_tabController.index);
    });
  }

  @override
  void initState() {
    super.initState();

    _retrieveValues();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          backgroundColor: Colors.lightGreen,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.white, Colors.green]),
            ),
          ),
          actions: <Widget>[
          ],
          centerTitle: true,
          iconTheme: IconThemeData(
              color: Colors.white
          ),
          title: Text('Book a flight', textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,
                  fontFamily: 'Baloo',
                  fontWeight: FontWeight.w900,
                  fontSize: 20)),
        ),
        body: SingleChildScrollView(

          child: Column(
            children: <Widget>[

              _tabSection(context),


            ],
          ),
        ));
  }


  Widget _tabSection(BuildContext context) {

    print('calling passenger list values....');
    print(classstr);
    print(passengerliststr);
    //_tabController = new TabController(vsync: this, length: 2);
    print('tab......');
    print(_tabController.index);
    _tabController.addListener((){
      print('my index is'+ _tabController.index.toString());
    });

    int selectedindex = 0;

    String fromDate = '';
    TextEditingController FromdateInputController = TextEditingController();
    // TextEditingController TodateInputController = TextEditingController();
    // bool first = false;
    TextEditingController returnFromdateInputController = TextEditingController();
    TextEditingController TodateInputController = TextEditingController();
    TextEditingController passengerController = TextEditingController();
    passengerController.text = passengerliststr + " ," + classstr;

    bool first = false;
    String returnfromDatestr = '';
    String toDatestr = '';

    return DefaultTabController(

      length: 2,


      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.fromLTRB(30, 50, 12, 12),
            //margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            margin: EdgeInsets.only(
                left: 20.0, top: 50.0, right: 20.0, bottom: 0.0),
            //padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
            height: 50,
            width: 320,
            // color: Colors.grey,
            color: Color.fromRGBO(133, 193, 233, 0.5),

            child: TabBar(
                //controller: _tabController,
                onTap: (index) {
                  selectedindex = index;
                },
                tabs: [
              //Tab(text: "One-Way",),
              Tab(
                child: Text(
                  'One-Way',
                  style: TextStyle(
                    //fontFamily: kFontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      //color: Color(0xFF818181),
                      color: Colors.deepPurple
                  ),
                ),
              ),

              Tab(
                child: Text(
                  'Round-Trip',
                  style: TextStyle(
                    //fontFamily: kFontFamily,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    //color: Color(0xFF818181),
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ]),
          ),
          Container(
            //margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
            //padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
            height: 350,
            width: 320,
            //color: Colors.grey,
            //color: Color.fromRGBO(235, 245, 251, 0.4),
            //133, 193, 233
            color: Color.fromRGBO(133, 193, 233, 0.5),
            //Add this to give height
            // height: MediaQuery.of(context).size.height,
            child: TabBarView(
                //controller: _tabController,

                children: [
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      color: Colors.white,
                      child: TextField(
                        readOnly: true,
                        style: TextStyle(fontSize: 16),

                        onTap: () async{
                          print('Economy class clicked...');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SourceDestinationCityVC()),
                          );
                          print('selected ind v');
                          print(selectedindex);
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setInt('selectedIndexkey', selectedindex);

                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFFFFFFF),
                          prefixIcon: Icon(
                              Icons.flight, color: Colors.deepPurple),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(0),
                            ),
                          ),
                          hintText: 'Flying from',
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      color: Colors.white,
                        child: TextField(
                          readOnly: true,
                          style: TextStyle(fontSize: 16),

                          onTap: () async{
                            print('Economy class clicked...');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SourceDestinationCityVC()),
                            );
                            print('selected ind v');
                            print(selectedindex);
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setInt('selectedIndexkey', selectedindex);

                          },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFFFFFFF),
                          prefixIcon: Icon(
                              Icons.flight, color: Colors.deepPurple),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(0),
                            ),
                          ),
                          hintText: 'Flying to',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      color: Colors.white,
                      child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFFFFFFF),
                            prefixIcon: Icon(
                                Icons.calendar_month, color: Colors.deepPurple),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(0),
                              ),
                            ),

                            hintText: 'Departure',
                          ),

                          controller: FromdateInputController,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2050));
                            if (pickedDate != null) {
                              FromdateInputController.text =
                                  pickedDate.toString();
                              fromDate = DateFormat('yyyy-MM-dd').format(
                                  pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed

                              FromdateInputController.text = fromDate;
                            }
                          }
                      ),
                    ),


                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      color: Colors.white,
                      child: TextField(
                        controller: passengerController,
                        readOnly: true,
                        style: TextStyle(fontSize: 16),

                        onTap: () async{
                          print('Economy class clicked...');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => classTypesVC()),
                          );
                          print('selected ind v');
                          print(selectedindex);
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setInt('selectedIndexkey', selectedindex);

                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFFFFFFF),
                          prefixIcon: Icon(Icons.account_circle_outlined,
                              color: Colors.deepPurple),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(0),
                            ),
                          ),
                          hintText: '1 Passenger , Economy',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        height: 50,
                        width: 300,
                        color: Colors.deepPurple,
                        child: Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {


                              },
                              child: Text('Search',
                                  style: TextStyle(
                                    height: 1.2,
                                    fontFamily: 'Dubai',
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  )),
                            ))
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      color: Colors.white,
                        child: TextField(
                          readOnly: true,
                          style: TextStyle(fontSize: 16),

                          onTap: () async{
                            print('Economy class clicked...');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SourceDestinationCityVC()),
                            );
                            print('selected ind v');
                            print(selectedindex);
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setInt('selectedIndexkey', selectedindex);

                          },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFFFFFFF),
                          prefixIcon: Icon(
                              Icons.flight, color: Colors.deepPurple),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(0),
                            ),
                          ),
                          hintText: 'Flying from',
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      color: Colors.white,
                        child: TextField(
                          readOnly: true,
                          style: TextStyle(fontSize: 16),

                          onTap: () async{
                            print('Economy class clicked...');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SourceDestinationCityVC()),
                            );
                            print('selected ind v');
                            print(selectedindex);
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setInt('selectedIndexkey', selectedindex);

                          },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFFFFFFF),
                          prefixIcon: Icon(
                              Icons.flight, color: Colors.deepPurple),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(0),
                            ),
                          ),
                          hintText: 'Flying to',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 145,
                            color: Colors.red,
                            child: TextField(
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  prefixIcon: Icon(Icons.calendar_month,
                                      color: Colors.deepPurple),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                  ),
                                  hintText: 'Dep',
                                ),

                                controller: returnFromdateInputController,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2050));
                                  if (pickedDate != null) {
                                    returnFromdateInputController.text =
                                        pickedDate.toString();
                                    returnfromDatestr =
                                        DateFormat('yyyy-MM-dd').format(
                                            pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                    print('from date...');
                                    print(returnfromDatestr);
                                    returnFromdateInputController.text =
                                        returnfromDatestr;
                                  }
                                }
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 50,
                            width: 145,
                            color: Colors.red,
                            child: TextField(
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  prefixIcon: Icon(Icons.calendar_month,
                                      color: Colors.deepPurple),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                  ),

                                  hintText: 'Rerurn',
                                ),

                                controller: TodateInputController,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2050));
                                  if (pickedDate != null) {
                                    TodateInputController.text =
                                        pickedDate.toString();
                                    toDatestr = DateFormat('yyyy-MM-dd').format(
                                        pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                    TodateInputController.text = toDatestr;
                                  }
                                }
                            ),
                          )
                        ],
                      ),
                      // child: TextField(
                      //     decoration: InputDecoration(
                      //       filled: true,
                      //       fillColor: Color(0xFFFFFFFF),
                      //       prefixIcon: Icon(Icons.calendar_month, color: Colors.deepPurple),
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.all(
                      //           Radius.circular(0),
                      //         ),
                      //       ),
                      //
                      //       hintText: 'Departure',
                      //     ),
                      //
                      //     controller: FromdateInputController,
                      //     onTap: () async {
                      //       DateTime? pickedDate = await showDatePicker(
                      //           context: context,
                      //           initialDate: DateTime.now(),
                      //           firstDate: DateTime(1950),
                      //           lastDate: DateTime(2050));
                      //       if (pickedDate != null) {
                      //         FromdateInputController.text =pickedDate.toString();
                      //         fromDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                      //         FromdateInputController.text = fromDate;
                      //       }
                      //     }
                      // ),
                    ),


                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      color: Colors.white,
                      child: TextField(
                        controller: passengerController,
                        readOnly: true,
                        style: TextStyle(fontSize: 16),

                        onTap: () async {
                          print('Economy class clicked...');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => classTypesVC()),
                          );
                          print('selected ind v');
                          print(selectedindex);
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setInt('selectedIndexkey', selectedindex);
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFFFFFFF),
                          prefixIcon: Icon(Icons.account_circle_outlined,
                              color: Colors.deepPurple),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(0),
                            ),
                          ),
                          hintText: '1 Passenger , Economy',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        height: 50,
                        width: 300,
                        color: Colors.deepPurple,
                        child: Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {},
                              child: Text('Search',
                                  style: TextStyle(
                                    height: 1.2,
                                    fontFamily: 'Dubai',
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  )),
                            ))
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}


