import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'FlightSearchVC.dart';
import 'OriginDesmodelVC.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SourceDestinationCityVC extends StatefulWidget {
  // HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<SourceDestinationCityVC> {
  List<UserDetails> _searchResult = [];
  List<UserDetails> _userDetails = [];
  TextEditingController controller = new TextEditingController();
  String OnewayDeparturestr = '';
  String OnewayArrivalstr = '';
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      OnewayDeparturestr = prefs.getString('OnewayDeparturekey') ?? "";
      OnewayArrivalstr = prefs.getString('OnewayArrivalkey') ?? "";
      print('Oneway source and desti');
      print(OnewayDeparturestr);
      print(OnewayArrivalstr);
    });
  }


      // Get json result and convert it to model. Then add
  Future<Null> getUserDetails() async {
    print('calling....');
    // final response = await http.get(url as Uri);
    // final responseJson = json.decode(response.body);
    // print('response data...');
    // print(responseJson);
    //final String url = 'https://jsonplaceholder.typicode.com/users';


    String baseUrl = 'https://staging.abisiniya.com/api/v1/amadeus/airportlist';
    http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<String> items = [];
      var jsonData = json.decode(response.body);
      print('Airport list.....');
      print(jsonData.toString());
      setState(() {
        for (Map user in jsonData) {
          _userDetails.add(UserDetails.fromJson(user as Map<String, dynamic>));
        }
      }
      );
    }
  }

  @override
  void initState() {
    super.initState();

    getUserDetails();
    _retrieveValues();
  }

  Widget _buildUsersList() {
    return new ListView.builder(
      itemCount: _userDetails.length,
      itemBuilder: (context, index) {
        return new Card(
          child: new ListTile(
            // leading: new CircleAvatar(
            //   // backgroundImage: new NetworkImage(
            //   //   _userDetails[index].profileUrl,
            //   // ),
            // ),
            //title: new Text(_userDetails[index].Name),

              leading: Icon(Icons.flight),
              title: new Text(_userDetails[index].Name +
                  '  - ' +
                  _userDetails[index].iata),
              onTap: () async{

                print('selected value....');
                print((_userDetails[index].Name +
                    '  - ' +
                    _userDetails[index].iata));
                controller.text = _userDetails[index].Name + '  - ' + _userDetails[index].iata;
                print('selected ind v');
                if (OnewayDeparturestr == "OnewayDeparture"){
                  print('departurar....');
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString('sourcekey', controller.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FlightSearchVC()),
                  );
                }
                if(OnewayArrivalstr == 'OnewayArrival') {
                  print('arrival....');
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString('destinationkey', controller.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FlightSearchVC()),
                  );
                }





              }
          ),


          margin: const EdgeInsets.all(0.0),
        );
      },
    );
  }

  Widget _buildSearchResults() {
    return new ListView.builder(
      itemCount: _searchResult.length,
      itemBuilder: (context, index) {
        return new Card(
          child: new ListTile(
              leading: Icon(Icons.flight),

              // leading: new CircleAvatar(
              //   // backgroundImage: new NetworkImage(
              //   //   _searchResult[i].profileUrl,
              //   // ),
              // ),
              // title: new Text(
              //     _searchResult[i].firstName),

              title: new Text(
                  _searchResult[index].Name + '   -' +(_searchResult[index].iata)),
              onTap: () async{
                print('filter....');
                print(controller.text = _searchResult[index].Name + '  - ' + _searchResult[index].iata);
                controller.text = _searchResult[index].Name + '  - ' + _searchResult[index].iata;

                // if (OnewayDeparturestr == "OnewayDeparture"){
                //   SharedPreferences prefs = await SharedPreferences.getInstance();
                //   prefs.setString('sourcekey', controller.text);
                // } else if(OnewayArrivalstr == 'OnewayArrival') {
                //   SharedPreferences prefs = await SharedPreferences.getInstance();
                //   prefs.setString('destinationkey', controller.text);
                // }
                // SharedPreferences prefs = await SharedPreferences.getInstance();
                // prefs.setString('SourceDestinationkey', controller.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FlightSearchVC()),
                );
              }
          ),


          margin: const EdgeInsets.all(0.0),
        );
      },
    );
  }

  Widget _buildSearchBox() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Card(
        child: new ListTile(
          leading: new Icon(Icons.search),
          title: new TextField(
            controller: controller,
            decoration: new InputDecoration(
                hintText: 'Search', border: InputBorder.none),
            onChanged: onSearchTextChanged,
          ),
          trailing: new IconButton(
            icon: new Icon(Icons.cancel),
            onPressed: () {
              controller.clear();
              onSearchTextChanged('');
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return new Column(
      children: <Widget>[
        new Container(
            color: Theme.of(context).primaryColor,

            child: _buildSearchBox()),
        new Expanded(
            child: _searchResult.length != 0 || controller.text.isNotEmpty
                ? _buildSearchResults()
                : _buildUsersList()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

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
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.white
        ),

        title: const Text('Airport',
            textAlign: TextAlign.center,
            style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
      ),
      // appBar: new AppBar(
      //   title: new Text('Home'),
      //   elevation: 0.0,
      // ),
      body: _buildBody(),
      // resizeToAvoidBottomPadding: true,
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (userDetail.Name.contains(text) ||
          userDetail.iata.contains(text)) _searchResult.add(userDetail);
    }


    );

    setState(() {});
  }
}