import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import  'dart:convert' as convert;
void main() => runApp(MyApp());
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {

    super.initState();
  const oneSec = const Duration(seconds:6);
  new Timer.periodic(oneSec, (Timer t) => getLocationWeather());

    
  }
  
   Future<dynamic> getLocationWeather() async {
    Location loc = new Location();
    await loc.getCurrentLocation();
    var lat = loc.latitude;
    var long = loc.longitude;
    var ms = (new DateTime.now()).millisecondsSinceEpoch;
    var name = '$getvalue';
    // print(lat);
    // print(long);
    // print((ms/ 1000).round());
    // print(name);
    print("reached");
    final url = 'http://10.0.2.2:8000/';
   final fin_response = await http.post(url,body: convert.jsonEncode({"name":name,"long":long,"latti":lat,"date":ms}));
    //,"long":long,"latti":lat,"date":ms
  }
  TextEditingController inputcontroller= new TextEditingController();
  static String getvalue;
  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: ThemeData(primaryColor: Colors.blue[900]),
      home: Builder(
          builder: (context) => Scaffold(
              appBar: AppBar(title: Text('Human Contact Tracing'),
              centerTitle: true,),
              body:SingleChildScrollView( 
                  padding: const EdgeInsets.all(6.1),
                  child: Column(children: [
                    SizedBox(height: 1.1),
                    Text(
                      "Welcome to CovidTrack",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 26),
                    Image.asset('assets/images/main.png', height: 244),
                    SizedBox(height: 26),
                    TextField(
                      controller: inputcontroller,
                        decoration: InputDecoration(
                            hintText: "Enter your username",
                            labelText: "Username",
                            hintStyle:
                                TextStyle(fontSize: 15, color: Colors.grey),
                            labelStyle:
                                TextStyle(fontSize: 22, color: Colors.black),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person)),
                        maxLength: 10),
                    SizedBox(
                        width: 161,
                        height: 46,
                        child: RaisedButton(
                          padding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                          onPressed: () {
                            setState(() {
                              getvalue=inputcontroller.text;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Page2(value: inputcontroller.text)),
                            );
                          },
                          color: Colors.blue[900],
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(21))),
                          child: Text("Submit",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        )),
                       // Text('$getvalue'),
                       
                  ])))),
    );
  }
}

//click if positive wala page
class Page2 extends StatefulWidget {
  final String value;
 Page2({Key key, this.value}) : super(key: key);
  @override
  _ApState createState() => _ApState();
}

class _ApState extends State<Page2> {
  void initState() {

    super.initState();
  const oneSec = const Duration(seconds:6);
  new Timer.periodic(oneSec, (Timer t) => getLocationWeather());

    
  }
  
   Future<dynamic> getLocationWeather() async {
    Location loc = new Location();
    await loc.getCurrentLocation();
      // var ms = (new DateTime.now()).millisecondsSinceEpoch;
    // var hi= ${widget.value};
    print("bye" + "${widget.value}");
  
  
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Human Contact Tracing'),
              centerTitle: true,),
        body: SingleChildScrollView( 
                  padding: const EdgeInsets.all(46.1),
                  child: Column(children: [
            // Text("${widget.value}"),
              SizedBox(height: 31.1),
          SizedBox(
              width: 221,
              height: 221,
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
             
                onPressed: () async{
                  var ms = (new DateTime.now()).millisecondsSinceEpoch;
                  final url = 'http://10.0.2.2:8000/predict';
                  final fin_response = await http.post(url,body: convert.jsonEncode({"name":widget.value,"date":ms}));
                  var x = convert.jsonDecode(fin_response.body);
                  print(x);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Page3(value: x)),
                  );
                },
                color: Colors.teal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(111))),
                child: Text("  Click here, if you are tested positive",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              )),
          SizedBox(height: 25.1),
          Text(
            "Monitoring your location in background",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
         
          
          SizedBox(height: 26),
          
                     
              
        ])));
  }
}
//thank you for informing wala page
class Page3 extends StatefulWidget {
  final List value;
  Page3({Key key, this.value}) : super(key: key);
  @override
  _Appstate createState() => _Appstate();
}

class _Appstate extends State<Page3> {
  void initState() {

    super.initState();
  const oneSec = const Duration(seconds:6);
  new Timer.periodic(oneSec, (Timer t) => getLocationWeather());

    
  }
  
   Future<dynamic> getLocationWeather() async {
    Location loc = new Location();
    await loc.getCurrentLocation();
    // var ms = (new DateTime.now()).millisecondsSinceEpoch;
    // var name = MyApp.'$getvalue';
    // print(lat);
    // print(long);
    // print((ms/ 1000).round());
    // print(name);

    // final url = 'http://10.0.2.2:8000/predict';
    // final fin_response = await http.post(url,body: json.encode({"date":ms}));
    //,"long":long,"latti":lat,"date":ms
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Human Contact Tracing'),
              centerTitle: true,),
        body: SingleChildScrollView( 
            padding: const EdgeInsets.all(16.1),
            child: Column(children: [
          SizedBox(height: 6.1),
          Image.asset('assets/images/tick.jpg', height: 244),
          SizedBox(height: 25.1),
          Text(
            "Thank you for informing.",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            "People who came near you have been informed",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          
    SizedBox(height: 25.1),
          SizedBox(
                        width: 161,
                        height: 46,
                        child: RaisedButton(
                          padding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                          onPressed: () {
                           
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Page4(value: widget.value)),
                            );
                          },
                          color: Colors.blue[900],
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(21))),
                          child: Text("View Traces",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        )),
        ])));
  }
}
class Page4 extends StatefulWidget {
   final List value;
  Page4({Key key, this.value}) : super(key: key);
  @override
  _Page4 createState() => _Page4();
}

class _Page4 extends State<Page4> {
      var _items = List<ListItem>();
       @override
  void initState() {

    super.initState();
     for (var i=0; i<widget.value.length; i++) {
    
    _items.add(ListItem(widget.value[i]));
    

     }
   
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.green,
        appBar: AppBar(title: Text('Human Contact Tracing'),
              centerTitle: true,),
        body: 
            Center(
             
                child:         
                 ListView(
          children: [
           for (var value in _items)
           
             listItem(value.title)
           
          ],
        )));
  }
  Widget listItem(String message) {
    return Card(
      child: SizedBox(height: 66,child: Center(child: Text(message))),
    );
  }
}  
class ListItem {
  String title;
  ListItem(this.title);
}
  
 //location 
class Location {
  double latitude;
  double longitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position =
           await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
