import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../flyScreens/Flights.dart';
import '../flyScreens/airlineVC.dart';
import 'OneWay_DestinationSelection/Oneway-DestinationJsonVC.dart';
import 'OnwardJourneyVC.dart';
import 'OriginDestSelectionVC.dart';
import 'ReturnJourney/Roundtrip_Destinationscreens/Rndtrp_DestinationJsonVC.dart';
import 'ReturnJourney/Roundtrip_OriginScreens/Rndtrp_OriginJsonVC.dart';
import 'ReturnJourney_flightsearch/forwardJourneyVC.dart';
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
  String flightTokenstr = '';
 // int selectedindex = 0;
  int currentpage = 0;
  String OrginAirportcitystr = '';
  String DestinationAirportcitystr = '';
  String Retrived_Oneway_iatacodestr = '';
  String Retrived_Oneway_Citynamestr = '';
  String RetrivedOneway_Oneway_Destinationiatacodestr = '';
  String RetrivedOnew_Oneway_DestinationCitynamestr = '';

  String RndOriginAirportcitystr = '';
  String Retrived_Rndtrp_iatacodestr = '';
  String Retrived_Rndtrp_Citynamestr = '';

  String RndDestinationAirportcitystr = '';
  String Retrived_Rndtrp_Destination_iatacodestr = '';
  String Retrived_Rndtrp_Destination_Citynamestr = '';





  //TabController _tabController;
  late TabController _tabController;



  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      classstr = prefs.getString('classkey') ?? "";
      passengerliststr = prefs.getString('passengerlistkey') ?? "";
      currentpage = prefs.getInt('Roundtripindexkey') ?? 0;
      flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
      //Onwway values
      OrginAirportcitystr = prefs.getString('sourcekey') ?? '';
      DestinationAirportcitystr = prefs.getString('destinationkey') ?? '';
  Retrived_Oneway_iatacodestr = prefs.getString('Oneway_iatacodekey') ?? '';
  Retrived_Oneway_Citynamestr = prefs.getString('Oneway_Citynamekey') ?? '';

  //Roundtrip values

      RndOriginAirportcitystr = prefs.getString('Rndtrp_origincitykey') ?? '';
      Retrived_Rndtrp_iatacodestr = prefs.getString('Rndtrp_originiatacodekey') ?? '';
      Retrived_Rndtrp_Citynamestr = prefs.getString('Rndtrp_originCitynamekey') ?? '';
      //Roundtrip Destination city values
      RndDestinationAirportcitystr = prefs.getString('Rndtrp_Destinationcitykey') ?? '';
      Retrived_Rndtrp_Destination_iatacodestr = prefs.getString('Rndtrp_Destinationiatacodekey') ?? '';
      Retrived_Rndtrp_Destination_Citynamestr = prefs.getString('Rndtrp_DestinationCitynamekey') ?? '';

      RetrivedOneway_Oneway_Destinationiatacodestr = prefs.getString('Oneway_Destinationiatacodekey') ?? '';
      RetrivedOnew_Oneway_DestinationCitynamestr = prefs.getString('Oneway_DestinationCitynamekey') ?? '';
      print('flight token received...');
      print(flightTokenstr);
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
   //Oneway fields:-
    TextEditingController OriginAirportCityController = TextEditingController();
    TextEditingController DestinationAirportCityController = TextEditingController();
    //OriginAirportCityController.text = OrginAirportcitystr;
    DestinationAirportCityController.text = RetrivedOneway_Oneway_Destinationiatacodestr;
    OriginAirportCityController.text =     Retrived_Oneway_iatacodestr;


    //Roundtrip fields:-
    TextEditingController Rnd_OriginAirportCityController = TextEditingController();
    TextEditingController Rnd_DestinationAirportCityController = TextEditingController();
    Rnd_OriginAirportCityController.text = RndOriginAirportcitystr;
    Rnd_DestinationAirportCityController.text = RndDestinationAirportcitystr;
    //DestinationAirportCityController.text = DestinationAirportcitystr;


    passengerController.text = passengerliststr + " ," + classstr;
    bool first = false;
    String returnfromDatestr = '';
    String toDatestr = '';
    return DefaultTabController(
      length: 2,
      initialIndex: currentpage,
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
                        controller: OriginAirportCityController,
                        readOnly: true,
                        style: TextStyle(fontSize: 12),

                        onTap: () async{
                          print('One way source clicked...');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SourceDestinationCityVC()),
                          );
                          print('selected ind v');
                          print(selectedindex);
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setInt('selectedIndexkey', selectedindex);
                          prefs.setString("OnewayDeparturekey", 'OnewayDeparture');
                          prefs.setString("Oneway_iatacodekey", Retrived_Oneway_iatacodestr);
                          prefs.setString("Oneway_Citynamekey", Retrived_Oneway_Citynamestr);
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
                          controller: DestinationAirportCityController,
                          readOnly: true,
                          style: TextStyle(fontSize: 12),

                          onTap: () async{
                            print('One way destination clicked...');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OnewwayDestinationCityVC()),
                            );
                            print('selected ind v');
                            print(selectedindex);
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setInt('selectedIndexkey', selectedindex);
                            prefs.setString("OnewayArrivalkey", 'OnewayArrival');
                            prefs.setString("Oneway_Destinationiatacodekey", RetrivedOneway_Oneway_Destinationiatacodestr);
                            prefs.setString("Oneway_DestinationCitynamekey", RetrivedOnew_Oneway_DestinationCitynamestr);

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

                  InkWell(
                    child: Container(
                    height: 50,
                    width: 300,
                     color: Colors.deepPurple,

                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                              "Search",
                              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800,color: Colors.white),
                              textAlign: TextAlign.center
                          ),
                        )

                    ),
                    onTap: () async {
                      print("tapped on container");
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                  flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                                  print('tap..');
                                   print(flightTokenstr);
                                  flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                                  prefs.setString("flightTokenstrKey", flightTokenstr);
                      prefs.setString("from_Datekey", FromdateInputController.text);

                      print('Tapped onward....');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FlightOnWardJourney()),
                                  );
                    },
                  )



                    // Container(
                    //     height: 50,
                    //     width: 300,
                    //     color: Colors.deepPurple,
                    //     child: Align(
                    //         alignment: Alignment.center,
                    //         child: GestureDetector(
                    //           onTap: () async{
                    //             SharedPreferences prefs = await SharedPreferences.getInstance();
                    //             flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                    //             print('tap..');
                    //              print(flightTokenstr);
                    //             flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                    //             prefs.setString("flightTokenstrKey", flightTokenstr);
                    //
                    //
                    //
                    //             print('Tapped onward....');
                    //             Navigator.push(
                    //               context,
                    //               MaterialPageRoute(
                    //                   builder: (context) => FlightOnWardJourney()),
                    //             );
                    //
                    //           },
                    //           child: Text('Search1',
                    //               style: TextStyle(
                    //                 height: 1.2,
                    //                 fontFamily: 'Dubai',
                    //                 fontSize: 20,
                    //                 color: Colors.white,
                    //                 fontWeight: FontWeight.w800,
                    //               )),
                    //         )
                    //     )
                    // ),
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
                          controller: Rnd_OriginAirportCityController,
                          readOnly: true,
                          style: TextStyle(fontSize: 16),

                          onTap: () async{
                            print('Economy class clicked...');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RndtrpOriginCityVC()),
                            );
                            print('Rnd trip departure....');
                            print(selectedindex);
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setInt('selectedIndexkey', selectedindex);
                            prefs.setString("RndtrpDeparturekey", 'RndtrpDeparture');
                            prefs.setString("Rndtrp_originiatacodekey", Retrived_Rndtrp_iatacodestr);
                            prefs.setString("Rndtrp_originCitynamekey", Retrived_Rndtrp_Citynamestr);
                            //
                            // RndOriginAirportcitystr = prefs.getString('Rndtrp_origincitykey') ?? '';
                            // Retrived_Rndtrp_iatacodestr = prefs.getString('Rndtrp_originiatacodekey') ?? '';
                            // Retrived_Rndtrp_Citynamestr = prefs.getString('Rndtrp_originCitynamekey') ?? '';


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
                          controller: Rnd_DestinationAirportCityController,
                          style: TextStyle(fontSize: 16),

                          onTap: () async{
                            print('Economy class clicked...');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RndtrpDestinationCityVC()),
                            );
                            print('Rnd trip departure....');
                            print(selectedindex);
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setInt('selectedIndexkey', selectedindex);
                            prefs.setString("RndtrpDestinationkey", 'RndtrpDestination');
                            prefs.setString("Rndtrp_Destinationiatacodekey", Retrived_Rndtrp_Destination_iatacodestr);
                            prefs.setString("Rndtrp_DestinationCitynamekey", Retrived_Rndtrp_Destination_Citynamestr);

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
                    InkWell(
                      child: Container(
                          height: 50,
                          width: 300,
                          color: Colors.deepPurple,

                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                                "Search",
                                style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800,color: Colors.white),
                                textAlign: TextAlign.center
                            ),
                          )

                      ),
                      onTap: () async {
                        print("tapped on container");
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                        print('tap..');
                        print(flightTokenstr);
                        flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                        prefs.setString("flightTokenstrKey", flightTokenstr);
                        print('Tapped onward....');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FlightforwarWardJourney()),
                        );
                      },
                    )
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


