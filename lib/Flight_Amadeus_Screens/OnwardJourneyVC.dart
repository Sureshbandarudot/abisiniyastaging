
import 'package:flutter/material.dart';
//import 'package:tourstravels/ApartVC/Add_Apartment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:tourstravels/Auth/Login.dart';
import 'dart:convert';
import 'package:tourstravels/ApartVC/Addaprtment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourstravels/UserDashboard_Screens/Apartbooking_Model.dart';
import 'package:tourstravels/UserDashboard_Screens/PivoteVC.dart';
import 'package:tourstravels/UserDashboard_Screens/newDashboard.dart';
import 'package:tourstravels/tabbar.dart';
import 'package:tourstravels/My_Apartments/My_AprtmetsVC.dart';
import 'package:tourstravels/My_Apartments/ViewApartmentVC.dart';

import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';
class FlightOnWardJourney extends StatefulWidget {
  const FlightOnWardJourney({super.key});

  @override
  State<FlightOnWardJourney> createState() => _userDashboardState();
}

class _userDashboardState extends State<FlightOnWardJourney> {
  final baseDioSingleton = BaseSingleton();

  int bookingID = 0;
  var API = '';
  String status = '';
  int _counter = 0;
  int idnum = 0;
  String Date = '';
  int selectedIndex = 0;
  int imageID = 0;
  String citystr = '';
  String RetrivedPwd = '';
  String RetrivedEmail = '';
  String RetrivedBearertoekn = '';
  String Bookingsts = 'Not booked yet!';
  String Statusstr = '';
  String stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
  String stsId = '';
  int VehicleId = 0;
  var controller = ScrollController();
  late Future<List<DashboardApart>> BookingDashboardUsers ;
  int count = 15;
  String flightTokenstr = '';
  String carrierCodestr = '';
  String Airlinecodestr = '';
  String Airlinenamestr = '';
  String Airlinelogostr = '';
  String Retrived_Oneway_iatacodestr = '';
  String Retrived_Oneway_Citynamestr = '';
  String RetrivedOneway_Oneway_Destinationiatacodestr = '';
  String RetrivedOnew_Oneway_DestinationCitynamestr = '';
  var OnwardJourneylist = [];
  var OnwardJourney_depiataCodelist = [];
  var OnwardJourney_arrivaliataCodelist = [];
  var OnwardJourney_DeptimeArray = [];
  var OnwardJourney_ArrivaltimeArray = [];
  var OnwardJourney_dateArray = [];
  var OnwardJourney_durationArray = [];
  var OnwardJourney_carrierCodeArray = [];
  var OnwardJourney_airlineCodeArray = [];
  var OnwardJourney_airlineNameArray = [];
  var OnwardJourney_airlineLogoArray = [];

  //List<Map<String, dynamic>> mapList = [];
  Map<String, dynamic> travellers = {};




  String sourcevalue = '';
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // RetrivedEmail = prefs.getString('emailkey') ?? "";
      // RetrivedPwd = prefs.getString('passwordkey') ?? "";
      // RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
      // VehicleId = prefs.getInt('userbookingId') ?? 0;
      flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
      print('Onward journey token...');
      print(flightTokenstr);

      Retrived_Oneway_iatacodestr = prefs.getString('Oneway_iatacodekey') ?? '';
      Retrived_Oneway_Citynamestr = prefs.getString('Oneway_Citynamekey') ?? '';
      print('received values in onward...');
      print(Retrived_Oneway_iatacodestr);
      print(Retrived_Oneway_Citynamestr);

  RetrivedOneway_Oneway_Destinationiatacodestr = prefs.getString('Oneway_Destinationiatacodekey') ?? '';
  RetrivedOnew_Oneway_DestinationCitynamestr = prefs.getString('Oneway_DestinationCitynamekey') ?? '';

      print('received values in dest onward...');
      print(RetrivedOneway_Oneway_Destinationiatacodestr);
      print(RetrivedOnew_Oneway_DestinationCitynamestr);



  });
  }
//@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();
    _postData();
    getUserDetails();
    Map<String, dynamic> _portaInfoMap = {
      "name": "Vitalflux.com",
      "domains": ["Data Science", "Mobile", "Web"],
      "noOfArticles": [
        {"type": "data science", "count": 50},
        {"type": "web", "count": 75}
      ]
    };
    print('mapping...');
    print(_portaInfoMap);

    travellers = {
      "travelers": [
        {
          "id": "1",
          "travelerType": "ADULT",
          "fareOptions": [
            "STANDARD"
          ]
        }
      ],
    };

    for (var i = 0; i < 5; i = i + 1) {
      // code here

    }



    // "travelers": [
    // {
    // "id": "1",
    // "travelerType": "ADULT",
    // "fareOptions": [
    // "STANDARD"
    // ]
    // }
    // ],

  }
  Future<dynamic> _postData() async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
        print('Onward journey token1...');
        print(flightTokenstr);
      final response = await http.post(
        Uri.parse('https://test.travel.api.amadeus.com/v2/shopping/flight-offers'),
        headers: <String, String>{
          // 'Content-Type': 'application/json; charset=UTF-8',
          "Content-Type": "application/json",
          "Accept": "application/json",
          //"Authorization": "Bearer ${flightTokenstr}",
          "Authorization": "Bearer $flightTokenstr",

        },
        body: jsonEncode(<String, dynamic>{
          //   "currencyCode": "USD",
          //   "originDestinations": [
          //     {
          //       "id": "1",
          //       "originLocationCode": "RIO",
          //       "destinationLocationCode": "MAD",
          //       "departureDateTimeRange": {
          //         "date": "2024-09-12"
          //       }
          //     },
          //     {
          //       "id": "2",
          //       "originLocationCode": "MAD",
          //       "destinationLocationCode": "RIO",
          //       "departureDateTimeRange": {
          //         "date": "2024-09-17"
          //       }
          //     }
          //   ],
          //   "travelers": [
          //     {
          //       "id": "1",
          //       "travelerType": "ADULT",
          //       "fareOptions": [
          //         "STANDARD"
          //       ]
          //     }
          //   ],
          //   "sources": [
          //     "GDS"
          //   ],
          //   "searchCriteria": {
          //     "additionalInformation": {
          //       "chargeableCheckedBags": false,
          //       "brandedFares": false
          //     },
          //     "pricingOptions": {
          //       "fareType": [
          //         "PUBLISHED",
          //         "NEGOTIATED"
          //       ],
          //       "includedCheckedBagsOnly": false
          //     },
          //     "flightFilters": {
          //       "carrierRestrictions": {
          //         "includedCarrierCodes": [
          //           "AA"
          //         ]
          //       }
          //     }
          //   }
          // }
          "currencyCode": "ZAR",
          "originDestinations": [
            {
              "id": "1",
              "originLocationCode": Retrived_Oneway_iatacodestr,
              "destinationLocationCode": RetrivedOneway_Oneway_Destinationiatacodestr,
              "departureDateTimeRange": {
                "date": "2024-09-12"
              }
            },
            // {
            //   "id": "2",
            //   "originLocationCode": "WAW",
            //   "destinationLocationCode": "CDG",
            //   "departureDateTimeRange": {
            //     "date": "2024-09-17"
            //   }
            // }
          ],
          "travelers": [
            {
              "id": "1",
              "travelerType": "ADULT",
              "fareOptions": [
                "STANDARD"
              ]
            }
          ],
          "sources": [
            "GDS"
          ],
          "searchCriteria": {
            "additionalInformation": {
              "chargeableCheckedBags": false,
              "brandedFares": false
            },
            "pricingOptions": {
              "fareType": [
                "PUBLISHED",
                "NEGOTIATED"
              ],
              "includedCheckedBagsOnly": false
            },
            "flightFilters": {
              "carrierRestrictions": {
                "includedCarrierCodes": [
                  "LO"
                ]
              }
            }
          }
          }
        ),
      );

      print('Flight search API response.......');

      print(response.statusCode);
      if (response.statusCode == 200) {
        // Successful POST request, handle the response here
        final responseData = jsonDecode(response.body);
        print('flight response data...');
        var flightData = responseData['data'];
        print(flightData);
        for (var flightdataArray in flightData) {
          sourcevalue = flightdataArray['source'];
          print(sourcevalue);
          OnwardJourneylist.add(sourcevalue);
          var itinerariesArray = flightdataArray['itineraries'];
          print(itinerariesArray);
          for(var Durationstrv in itinerariesArray){
            String duration = Durationstrv['duration'];
            // String duration = itinerariesArray['segments'];
            print('durationval...');
            print(duration);
            String trimedDuration = duration.substring(2);
            OnwardJourney_durationArray.add(trimedDuration.toLowerCase());
            for (var SegmentArray in itinerariesArray){
              var segmentValuesAray = SegmentArray['segments'];
              print('segmentValuesAray...');
              print(segmentValuesAray);
              for(var DeparturArray in segmentValuesAray){
                var carrierCodestr = DeparturArray['carrierCode'];
                print('carrierCode...');
                print(carrierCodestr);
                OnwardJourney_carrierCodeArray.add(carrierCodestr);
                var Dep = DeparturArray['departure'];
                print('Departure....');
                print(Dep);
                var depiataCode = Dep['iataCode'];
                print('depiataCode...');
                print(depiataCode);
                OnwardJourney_depiataCodelist.add(depiataCode);
                var departuretime = Dep['at'];
                print('departure time..');
                print(departuretime);
                var Deptimeconvert = (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                var Datestr = (new DateFormat.yMd().format(DateTime.parse(departuretime)));
                print('date.');
                print(Datestr);
                OnwardJourney_dateArray.add(Datestr);
                print('time conversion...');
                print(Deptimeconvert);
                OnwardJourney_DeptimeArray.add(Deptimeconvert);
                var arrival = DeparturArray['arrival'];
                print('arrival....');
                print(arrival);
                var arrivalcode = arrival['iataCode'];
                print('arrivalcode...');
                print(arrivalcode);
                OnwardJourney_arrivaliataCodelist.add(arrivalcode);
                var arrivaltime = arrival['at'];
                print('arrivaltime...');
                print(arrivaltime);
                var Arrivaltimeconvert = (new DateFormat.Hm().format(DateTime.parse(arrivaltime)));
                print('time arrivaltime...');
                print(Arrivaltimeconvert);
                OnwardJourney_ArrivaltimeArray.add(Arrivaltimeconvert);
              }
            }
          }
        }
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to post data');
      }
    } catch (e) {
      setState(() {
        //result = 'Error: $e';
      });
    }
  }
  Future<dynamic> getUserDetails() async {

  //Future<Null> getUserDetails() async {
    print('calling....');
    String baseUrl = 'https://staging.abisiniya.com/api/v1/amadeus/airlinelist';
    http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      print('s call load...');
      List<String> items = [];
      var jsonData = json.decode(response.body);
      print('Airport list.....');
      print(jsonData.toString());
      for (var AirlineArray in jsonData) {
         Airlinecodestr = AirlineArray['code'];
        OnwardJourney_airlineCodeArray.add(Airlinecodestr);
        print(OnwardJourney_carrierCodeArray.toList());
         List<Map<String, dynamic>> mapList = [];
         OnwardJourney_carrierCodeArray.forEach((e) {
           Map<String, dynamic> item = {"name": e, "selected": false};
           mapList.add(item);
         });
         for (var nameArray in mapList){
           var Countrycode = nameArray['name'];
           if(Airlinecodestr == Countrycode){
             print('success..');
             Airlinenamestr = AirlineArray['name'];
             print(Airlinenamestr);
             OnwardJourney_airlineNameArray.add(Airlinenamestr);
             Airlinelogostr = AirlineArray['logo'];
             print('logo..');
             print(Airlinelogostr);
             OnwardJourney_airlineLogoArray.add(Airlinelogostr);
             print('calling carrier code...');
           }
         }
        print(carrierCodestr);
      }
    }
  }
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        home: Scaffold(
          appBar: AppBar(

            backgroundColor: Colors.pinkAccent,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[Colors.white, Colors.pinkAccent]),
              ),
            ),
            actions: <Widget>[
            ],
            centerTitle: true,
            iconTheme: IconThemeData(
                color: Colors.white
            ),
            title: Text('Flight Search', textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white,
                    fontFamily: 'Baloo',
                    fontWeight: FontWeight.w900,
                    fontSize: 20)),
          ),


          body: FutureBuilder<dynamic>(

            //future: BookingDashboardUsers,
              future: getUserDetails(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text('');
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  case ConnectionState.active:
                    print('imagename......');
                    return Text('');
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Text(
                        '${snapshot.error}',
                        style: TextStyle(color: Colors.white),
                      );
                    } else {
                      return Column(
                        children: <Widget>[
                          //Container(color: Colors.red, height: 50),
                      new Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),


                        child:Container(
                            width: 400,
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 50.0,
                              child: Image.asset(
                                  "images/aeroplane_image.png",
                                  height: 125.0,
                                  width: 400.0,
                                  fit: BoxFit.fill
                              ),
                            )
                        ),
                      ),
                          Expanded(
                            child: Container(
                             // color: Colors.pinkAccent,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: <Color>[Colors.white, Colors.pinkAccent]),
                                ),

                              child: LayoutBuilder(
                                builder: (context, constraint) {
                                  var Departuretextstr = 'Departure To ' + ' '+  RetrivedOneway_Oneway_Destinationiatacodestr;
                                  return SingleChildScrollView(
                                    physics: ScrollPhysics(),
                                    child: Column(
                                      children: <Widget>[
                                        //Text('Your Apartments'),
                                        Container(
                                          height: 70,
                                          width: 380,
                                          child: Column(
                                          children: [

                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                Departuretextstr,
                                                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Price per passenger, taxes and fees included',
                                                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                                            ),

                                          ],
                                          ),
                                        ),

                                        ListView.separated(

                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            // itemCount: snapshot.data['data'].length ?? '',
                                            itemCount: OnwardJourney_dateArray.length,
                                            separatorBuilder: (BuildContext context, int index) => const Divider(),
                                            itemBuilder: (BuildContext context, int index) {
                                            // print('loading data from api.......');
                                            // print(OnwardJourney_airlineNameArray[index].toString());

                                              return Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Card(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Column(
                                                        children: [
                                                          Column(


                                                            children: [

                                                              SizedBox(
                                                                height: 5,
                                                              ),

                                                              Text(OnwardJourney_dateArray[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black45
                                                              ),),
                                                              Text(OnwardJourney_DeptimeArray[index].toString() + '-----------------> ' + OnwardJourney_ArrivaltimeArray[index],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.black45
                                                              ),),

                                                              Text(OnwardJourney_durationArray[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black45
                                                              ),),
                                                              SizedBox(),
                                                              Text(OnwardJourney_depiataCodelist[index].toString() + '                                          ' + OnwardJourney_arrivaliataCodelist[index].toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black45
                                                              ),),
                                                              Container(
                                                                height: 80,
                                                                width: 360,
                                                                color: Colors.transparent,
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),

                                                                    Container(
                                                                      height: 70,
                                                                      width: 70,
                                                                      //color: Colors.green,

                                                                      // } else if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                                      //     : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Checked Out'){

                                                                      decoration: BoxDecoration(
                                                                        // image: DecorationImage(image: NetworkImage(snapshot.data["data"][index]['pictures'][0
                                                                        // ]['imageUrl']),
                                                                          image: DecorationImage(image: NetworkImage(OnwardJourney_airlineLogoArray[index].toString()),
                                                                              fit: BoxFit.cover)
                                                                      ),
                                                                    ),

                                                                    Container(
                                                                      height: 45,
                                                                      width: 200,
                                                                      color: Colors.transparent,
                                                                      child: Column(
                                                                        children: [
                                                                          SizedBox(height: 20,),
                                                                          Text(OnwardJourney_airlineNameArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black45
                                                                          ),),
                                                                        ],
                                                                      ),

                                                                    ),
                                                                  ],
                                                                ),
                                                              ),



                                                              ExpansionTile(

                                                                title: Container(
                                                                  //width: 100,
                                                                  //transform: Matrix4.translationValues(20, 0, 0),
                                                                  color: Colors.transparent,
                                                                  child:     Align(
                                                                    alignment: Alignment.centerRight,
                                                                    child: Text('Detailes')
                                                                  ),

                                                                ),
                                                                leading: const SizedBox(width: 0.00,),
                                                                children: [
                                                                  Container(
                                                                    height: 170,
                                                                    width: 360,
                                                                    color: Colors.transparent,
                                                                    child: Row(
                                                                      children: [
                                                                        Container(
                                                                          margin: const EdgeInsets.only(left: 10.0, right: 0.0),

                                                                          height: 160,
                                                                          width: 80,
                                                                          color: Colors.transparent,
                                                                          child: Column(
                                                                            children: [
                                                                              Text(OnwardJourney_DeptimeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black45
                                                                              ),),
                                                                              SizedBox(height: 40,),
                                                                              Text(OnwardJourney_dateArray[index].toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.black45
                                                                              ),),

                                                                              SizedBox(height: 50,),
                                                                              Text(OnwardJourney_ArrivaltimeArray[index].toString() ,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black45
                                                                              ),),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          margin: const EdgeInsets.only(left: 0.0, right: 0.0),

                                                                          height: 160,
                                                                          width: 30,
                                                                          color: Colors.transparent,
                                                                                  child:Container(
                                                                                      width: 20,
                                                                                      child: CircleAvatar(
                                                                                        backgroundColor: Colors.transparent,
                                                                                        radius: 50.0,
                                                                                        child: Image.asset(
                                                                                            "images/flight-path-icon.png",
                                                                                            height: 150.0,
                                                                                            width: 200.0,
                                                                                            fit: BoxFit.fill
                                                                                        ),
                                                                                      )
                                                                                  ),
                                                                        ),
                                                                        Container(
                                                                          margin: const EdgeInsets.only(left: 0.0, right: 0.0),

                                                                          height: 160,
                                                                          width: 240,
                                                                          color: Colors.transparent,
                                                                          child: Column(
                                                                            children: [

                                                                              // Text(OnwardJourney_depiataCodelist[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black45
                                                                              // ),),
                                                                              // Text(Retrived_Oneway_Citynamestr,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black45
                                                                              // ),),

                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  OnwardJourney_depiataCodelist[index].toString(),
                                                                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  Retrived_Oneway_Citynamestr,
                                                                                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                                                                              ),

                                                                              Container(
                                                                                height: 50,
                                                                                width: 360,
                                                                                color: Colors.transparent,
                                                                                child: Row(
                                                                                  children: [


                                                                                    Container(
                                                                                      height: 40,
                                                                                      width: 40,
                                                                                      //color: Colors.green,

                                                                                      // } else if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                                                      //     : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Checked Out'){

                                                                                      decoration: BoxDecoration(
                                                                                        // image: DecorationImage(image: NetworkImage(snapshot.data["data"][index]['pictures'][0
                                                                                        // ]['imageUrl']),
                                                                                          image: DecorationImage(image: NetworkImage(OnwardJourney_airlineLogoArray[index].toString()),
                                                                                              fit: BoxFit.cover)
                                                                                      ),
                                                                                    ),

                                                                                    Container(
                                                                                      height: 25,
                                                                                      width: 200,
                                                                                      color: Colors.transparent,
                                                                                      child: Column(
                                                                                        children: [
                                                                                         // SizedBox(height: 20,),
                                                                                          Text(OnwardJourney_airlineNameArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black45
                                                                                          ),),
                                                                                        ],
                                                                                      ),

                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              // Text(OnwardJourney_arrivaliataCodelist[index].toString() ,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black45
                                                                              // ),),
                                                                              // Text(RetrivedOnew_Oneway_DestinationCitynamestr,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black45
                                                                              // ),),

                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  OnwardJourney_arrivaliataCodelist[index].toString(),
                                                                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  RetrivedOnew_Oneway_DestinationCitynamestr,
                                                                                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                                                                              ),


                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height: 50,
                                                                    width: 360,
                                                                    color: Colors.transparent,
                                                                    child: Container(
                                                                      height: 45,
                                                                      width: 250,
                                                                      margin: const EdgeInsets.only(left: 125.0, right: 0.0),
                                                                      child: Row(
                                                                        children: [
                                                                          InkWell(
                                                                            child: Container(
                                                                                height: 35,
                                                                                width: 100,
                                                                                color: Colors.pink,
                                                                                child: Align(
                                                                                  alignment: Alignment.center,
                                                                                  child: Text(
                                                                                      "Add Cart",
                                                                                      style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w800,color: Colors.white),
                                                                                      textAlign: TextAlign.center
                                                                                  ),
                                                                                )

                                                                            ),
                                                                            onTap: () async {


                                                                              print('Tapped onward....');

                                                                            },
                                                                          ),
                                                                          SizedBox(
                                                                            width: 20,
                                                                          ),
                                                                          InkWell(
                                                                            child: Container(
                                                                                height: 35,
                                                                                width: 100,
                                                                                color: Colors.pink,
                                                                                child: Align(
                                                                                  alignment: Alignment.center,
                                                                                  child: Text(
                                                                                      "Book",
                                                                                      style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w800,color: Colors.white),
                                                                                      textAlign: TextAlign.center
                                                                                  ),
                                                                                )

                                                                            ),
                                                                            onTap: () async {


                                                                              print('Tapped onward....');

                                                                            },
                                                                          )
                                                                        ],
                                                                      ),



                                                                    ),
                                                                  )
                                                                ],

                                                                //title: Text('Details'),
                                                                //subtitle: Text('Expand this tile to see its contents'),
                                                                // onExpansionChanged: (newExpanded) {
                                                                //   setState(() {
                                                                //     expanded = newExpanded;
                                                                //   });
                                                                // },
                                                                // Contents
                                                                //children: [],
                                                              )
                                                              // Container(
                                                              //   height: 180,
                                                              //   width: 320,
                                                              //   // color: Colors.cyan,
                                                              //   child: Column(
                                                              //     children: [
                                                              //       // SizedBox(
                                                              //       //   height: 5,
                                                              //       // ),
                                                              //       //
                                                              //       // Text(OnwardJourney_dateArray[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.deepPurple
                                                              //       // ),),
                                                              //       // Text(OnwardJourney_DeptimeArray[index].toString() + '-----------------> ' + OnwardJourney_ArrivaltimeArray[index],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.deepPurple
                                                              //       // ),),
                                                              //       //
                                                              //       // Text(OnwardJourney_durationArray[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.deepPurple
                                                              //       // ),),
                                                              //       // SizedBox(),
                                                              //       // Text(OnwardJourney_depiataCodelist[index].toString() + '                                          ' + OnwardJourney_arrivaliataCodelist[index].toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.deepPurple
                                                              //       // ),),
                                                              //       // Container(
                                                              //       //   height: 80,
                                                              //       //   width: 360,
                                                              //       //   color: Colors.transparent,
                                                              //       //   child: Row(
                                                              //       //     children: [
                                                              //       //       SizedBox(
                                                              //       //         width: 10,
                                                              //       //       ),
                                                              //       //
                                                              //       //       Container(
                                                              //       //         height: 70,
                                                              //       //         width: 70,
                                                              //       //         //color: Colors.green,
                                                              //       //
                                                              //       //         // } else if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                              //       //         //     : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Checked Out'){
                                                              //       //
                                                              //       //         decoration: BoxDecoration(
                                                              //       //           // image: DecorationImage(image: NetworkImage(snapshot.data["data"][index]['pictures'][0
                                                              //       //           // ]['imageUrl']),
                                                              //       //             image: DecorationImage(image: NetworkImage(OnwardJourney_airlineLogoArray[index].toString()),
                                                              //       //                 fit: BoxFit.cover)
                                                              //       //         ),
                                                              //       //       ),
                                                              //       //
                                                              //       //       Container(
                                                              //       //         height: 45,
                                                              //       //         width: 200,
                                                              //       //         color: Colors.transparent,
                                                              //       //         child: Column(
                                                              //       //           children: [
                                                              //       //             SizedBox(height: 20,),
                                                              //       //             Text(OnwardJourney_airlineNameArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.deepPurple
                                                              //       //             ),),
                                                              //       //           ],
                                                              //       //         ),
                                                              //       //
                                                              //       //       ),
                                                              //             ExpansionTile(
                                                              //               title: Text('Colors'),
                                                              //               subtitle: Text('Expand this tile to see its contents'),
                                                              //               // onExpansionChanged: (newExpanded) {
                                                              //               //   setState(() {
                                                              //               //     expanded = newExpanded;
                                                              //               //   });
                                                              //               // },
                                                              //               // Contents
                                                              //               children: [],
                                                              //             ),
                                                              //           //],
                                                              //         //),
                                                              //       //),
                                                              //       // Text(OnwardJourney_airlineNameArray[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.deepPurple
                                                              //       // ),),
                                                              //     ],
                                                              //   ),
                                                              // ),
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                              // return Container(
                                              //   height: 225,
                                              //   width: 100,
                                              //   alignment: Alignment.center,
                                              //   color: Colors.white,
                                              //   child: InkWell(
                                              //
                                              //
                                              //     onTap: () async{
                                              //
                                              //     },
                                              //   ),
                                              // );
                                              //return  Text('Some text');
                                            }),

                                        Column(
                                          children:<Widget>[
                                            //Text('second test'),
                                            ListView.builder(
                                                physics: NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: 1,
                                                itemBuilder: (context,index){
                                                  return  Text('',style: TextStyle(fontSize: 22),);
                                                }),

                                          ],
                                        )
                                      ],

                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      );
                    }
                }
              }
          ),





















  //           body: isLoading
  //               ? Center(
  //             child: CircularProgressIndicator(),
  //           )
  //               : new Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.max,
  //       children: <Widget>[
  //
  //       new Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
  //
  //
  //         child:Container(
  //             width: 400,
  //             child: CircleAvatar(
  //               backgroundColor: Colors.transparent,
  //               radius: 50.0,
  //               child: Image.asset(
  //                   "images/aeroplane_image.png",
  //                   height: 125.0,
  //                   width: 400.0,
  //                   fit: BoxFit.fill
  //               ),
  //             )
  //         ),
  //
  //   ),
  //   // Expanded(child: _isLoading
  //   //       ? CircularProgressIndicator()
  //   //       : ListView.builder(
  //
  // //       return ListView.builder(
  // //   shrinkWrap: true,
  // //   scrollDirection: Axis.vertical,
  // //   itemBuilder: (context, pos) {
  // //     return snapshot.data![pos];
  // //   },
  // //   );
  // // }
  // // case ConnectionState.waiting:
  // // return Center(
  // // child: CircularProgressIndicator(),
  // // );
  //
  //
  //         Expanded(child: ListView.builder(
  //
  //
  //
  //         itemCount: OnwardJourney_airlineNameArray.length,
  //
  //
  //       itemBuilder: (context, index) {
  //         // print('c  calling....');
  //         //   isLoading = true;
  //         //   _postData();
  //         //   getUserDetails();
  //         //   print(' c stoping....');
  //         //   isLoading = false;
  //
  //         // setState(() {
  //         //   print('c  calling....');
  //         //   isLoading = true;
  //         //   _postData();
  //         //   getUserDetails();
  //         //   print(' c stoping....');
  //         //   isLoading = false;
  //         // });
  //         // print('calling....');
  //         // print(OnwardJourney_carrierCodeArray[index].toString());
  //         // print(OnwardJourney_airlineCodeArray[index].toString());
  //         // if(((OnwardJourney_carrierCodeArray[index].toString()) == OnwardJourney_airlineCodeArray[index].toString())){
  //         //
  //         //   print('calling Airline names');
  //         //   print(OnwardJourney_airlineNameArray[index].toString());
  //         // }
  //         return Padding(
  //           padding: const EdgeInsets.all(1.0),
  //           child: Card(
  //             child: Column(
  //               children: <Widget>[
  //
  //
  //
  //
  //                 // insert your tree accordingly
  //
  //
  //
  //                 Column(
  //                   children: [
  //                     Column(
  //
  //                       children: [
  //                         Container(
  //                           height: 160,
  //                           width: 320,
  //                          // color: Colors.cyan,
  //                           child: Column(
  //
  //
  //                             children: [
  //
  //
  //                               SizedBox(
  //                                 height: 5,
  //                               ),
  //
  //
  //                               Text(OnwardJourney_dateArray[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.deepPurple
  //                               ),),
  //                               Text(OnwardJourney_DeptimeArray[index].toString() + '-----------------> ' + OnwardJourney_ArrivaltimeArray[index],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.deepPurple
  //                               ),),
  //
  //                               Text(OnwardJourney_durationArray[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.deepPurple
  //                               ),),
  //                               SizedBox(),
  //                               Text(OnwardJourney_depiataCodelist[index].toString() + '                                          ' + OnwardJourney_arrivaliataCodelist[index].toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.deepPurple
  //                               ),),
  //                               Container(
  //                                 height: 50,
  //                                 width: 360,
  //                                 color: Colors.transparent,
  //                                 child: Row(
  //                                   children: [
  //                                     SizedBox(
  //                                       width: 10,
  //                                     ),
  //                                     Container(
  //                                       height: 45,
  //                                       width: 45,
  //                                       color: Colors.transparent,
  //                                         child: CircleAvatar(
  //                                           backgroundColor: Colors.transparent,
  //                                           radius: 50.0,
  //                                           child: Image.asset(
  //                                               "images/airplane.png",
  //                                               height: 40.0,
  //                                               width: 40.0,
  //                                               fit: BoxFit.fill
  //                                           ),
  //                                         )
  //                                     ),
  //                                     Container(
  //                                       height: 45,
  //                                       width: 200,
  //                                       color: Colors.transparent,
  //                                       child: Column(
  //                                         children: [
  //                                           SizedBox(height: 10,),
  //                                           Text(OnwardJourney_airlineNameArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.deepPurple
  //                                           ),),
  //                                         ],
  //                                       ),
  //
  //                                       // child: Text(OnwardJourney_airlineNameArray[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.deepPurple
  //                                        //),),
  //                                     )
  //
  //                                   ],
  //                                 ),
  //
  //                               ),
  //
  //
  //                               // Text(OnwardJourney_airlineNameArray[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.deepPurple
  //                               // ),),
  //
  //
  //
  //                             ],
  //                           ),
  //                         ),
  //
  //                       ],
  //                     )
  //                   ],
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //
  //
  //       },
  //     ),
  //   )
  //
  //   ],
  //
  //
  //   ),



          // body: _isLoading
          //     ? CircularProgressIndicator()
          //     : ListView.builder(
          //   itemCount: OnwardJourney_depiataCodelist.length,
          //   itemBuilder: (context, index) {
          //     return Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Card(
          //         child: Column(
          //           children: <Widget>[
          //             // insert your tree accordingly
          //
          //             Column(
          //               children: [
          //                 Row(
          //
          //                   children: [
          //                     Text(''),
          //                     Text(OnwardJourney_depiataCodelist[index].toString() + ' --------------------------> ' + OnwardJourney_arrivaliataCodelist[index].toString()),
          //                     Text(''),
          //
          //                   ],
          //                 )
          //               ],
          //             )
          //
          //
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ));
  }
}
