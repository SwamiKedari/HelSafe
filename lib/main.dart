import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterapp1/notification_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'firebase_options.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'notification_api.dart';
import 'dart:async';

import 'dart:convert';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
}
var alertdetails=[];
var phonedetails=[];
var hospitaldetails=[];

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    //otifications.showNotifications('swami','nishant is tp');
    return MaterialApp(
      title: "Mine-Map",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          foregroundColor: Colors.black, //<-- SEE HERE
        ),
      ),

      //home: MyStatefulWidget(),
      home: MyHomePage(),

    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                MyStatefulWidget()
            )
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child:Card(child: SizedBox(height: 500, child: Image.asset('assets/Hel.png'))),
    );
  }
}


class MapScreen extends StatefulWidget{
  @override
  mapscreenstate createState() => mapscreenstate();
}
class mapscreenstate extends State<MapScreen>{
  static const _initialCameraPosition = CameraPosition(target: LatLng(11.6113629,79.4985301),
    zoom: 11.5, );

  late GoogleMapController gmapcont;
  late Marker origin=Marker(
    markerId: const MarkerId('mine01'),
    infoWindow: const InfoWindow(title: 'mine01'),
    icon:
    BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    position: LatLng(11.6113629,79.4995301)

  );
  late Marker destination=Marker(
    markerId: const MarkerId('destination'),
    infoWindow: const InfoWindow(title: 'Destination'),
    icon:
    BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: LatLng(11.6113629,79.499091)

  );
  late Marker mine1=Marker(
      markerId: const MarkerId('mine02'),
      infoWindow: const InfoWindow(title: 'mine02'),
      icon:
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: LatLng(11.6113629,79.49854030)

  );

  late Marker mine2=Marker(
      markerId: const MarkerId('mine1'),
      infoWindow: const InfoWindow(title: 'mine1'),
      icon:
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: LatLng(11.6113629,79.49579292)

  );

  late Marker mine3=Marker(
      markerId: const MarkerId('mine2'),
      infoWindow: const InfoWindow(title: 'mine2'),
      icon:
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: LatLng(11.6113629,79.4931003)

  );

  late Marker mine4=Marker(
      markerId: const MarkerId('mine4'),
      infoWindow: const InfoWindow(title: 'mine4'),
      icon:
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: LatLng(11.6113629,79.4937302)

  );



  void dispose(){
    gmapcont.dispose();
    super.dispose();
  }
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Mine Map'),

        //actions: [TextButton(onPressed: ()=> gmapcont.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: origin.position, zoom: 14.5,tilt: 50.0,))), style: TextButton.styleFrom(primary: Colors.black, textStyle: const TextStyle(fontWeight: FontWeight.w600)),child: const Text('ORIGIN')),TextButton(onPressed: ()=> gmapcont.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: destination.position, zoom: 14.5,tilt: 50.0,))), style: TextButton.styleFrom(primary: Colors.black, textStyle: const TextStyle(fontWeight: FontWeight.w600)),child: const Text('DESTINATION'))],
      ),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller)=> gmapcont=controller,
        markers: {
          if(origin!=null)origin,
          if(destination!=null)destination,
          if(mine1!=null)mine1,
          if(mine2!=null)mine2,
          if(mine3!=null)mine3,
          if(mine4!=null)mine4,

        },
        //onTap: addMarker,

      ),



      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: ()=>gmapcont.animateCamera(CameraUpdate.newCameraPosition(_initialCameraPosition)),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  void addMarker(LatLng pos){
    if(origin.position.latitude==0 && origin.position.longitude==0){
      setState(() {
        origin=Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,

        );

      });
    }
    else if(destination.position.latitude==0 && destination.position.longitude==0){
    setState(() {
      destination=Marker(
        markerId: const MarkerId('destination'),
        infoWindow: const InfoWindow(title: 'Destination'),
        icon:
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: pos,

      );

    });
  }}
}
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => alerts();
}

class MyStatefulWidget1 extends StatefulWidget {
  const MyStatefulWidget1({super.key});

  @override
  State<MyStatefulWidget1> createState() => safety();
}

class alerts extends State<MyStatefulWidget> {

    //alerts({super.key});


    final List<String> entries = <String>['A', 'B', 'C'];
    final url="gotestback-env-1.eba-wqwxujev.us-west-2.elasticbeanstalk.com/contacts/";

    // final url ="http://localhost:4000/contacts";
    var _postsJson=[] ;
    void fetchPosts() async{
      try {
        final response = await http.get(Uri.parse(url));
        final jsonData = jsonDecode(response.body) as List;
        setState(() {
          _postsJson=jsonData;
          alertdetails=jsonData;
        });
      }
      catch(err){
        final snackBar = SnackBar(
          content: const Text('nishants aws is not working !'),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }



    void initState(){
      super.initState();
      //fetchPosts();

    }

  @override
  Widget build(BuildContext context) {
     // fetchPosts();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Alerts'),),

      body: ListView(
        children: <Widget>[
          Card(child: SizedBox(height: 100, child: Image.asset('assets/img_5.png'))),
           Card(color: Colors.white,
              child:
          ExpansionTile(
            leading: Icon(Icons.people),
            title: Text('Person Alerts',style: TextStyle(fontSize: 16.0, fontWeight:FontWeight.w500,color: Colors.black)),

            children: <Widget>[
              /*SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _postsJson.length,
                    itemBuilder: (context,i){
                      final post=_postsJson[i];
                      return Card(
                          color: Colors.white,

                          child: ListTile(
                        leading: const Icon(Icons.warning_rounded),

                        title: Text("${post["title"]}"),
                        subtitle: Text('${post["body"]}'),
                        onTap: () {

                          Navigator.of(context).push(_createRoute3());},
                      ));}
              ),)
        */
              ListTile(
                leading: const Icon(Icons.warning),
                title: const Text('Person fainted'),
                subtitle: const Text('Temperature increased suddenly.'),
                onTap: () {

                  Navigator.of(context).push(_createRoute3());},
              ),



            ]

          )),
          Card(color: Colors.white,
              child: ExpansionTile(
            leading: const Icon(Icons.water),
            title: const Text('Place Alerts',style: TextStyle(fontSize: 16.0, fontWeight:FontWeight.w500,color: Colors.black)),


              children: <Widget>[
                /*SizedBox(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _postsJson.length,
                    itemBuilder: (context,i){
                      final post=_postsJson[i];
                      return Card(
                          color: Colors.white,
                         
                            child: ListTile(
                       leading: const Icon(Icons.warning_rounded),

                      title: Text("${post["title"]}",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w300, color: Colors.black)),
                      subtitle: Text('${post["body"]}'),
                      onTap: () {

                        Navigator.of(context).push(_createRoute3());},
                    ));}
                  ),)*/
                ListTile(
                  leading: const Icon(Icons.warning),
                  title: const Text('Mine got filled with water'),
                  subtitle: const Text('over-flooded'),
                  onTap: () {

                    Navigator.of(context).push(_createRoute3());},
                ),
              ]




          )),

        ],
      ),






      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
          decoration: BoxDecoration(
            color: Color.fromRGBO(250, 250, 250, 0),
          image: DecorationImage(
          fit: BoxFit.scaleDown,
          image: AssetImage("./assets/Hel.png"),
        ),
        ),
        child: SizedBox.shrink(),
           ),
            Card(
                child: ListTile(
              title: const Text('Alerts',style: TextStyle(fontSize: 16.0)),

              onTap: () {
                Navigator.of(context).push(_createRoute1());},
              leading: const Icon(
                Icons.warning,
              ),
            )),
            Card(

                child: ListTile(
              title: const Text('Locations',style: TextStyle(fontSize: 16.0)),
              onTap: () {

                Navigator.of(context).push(_createRoute());
              },
              leading: const Icon(
                Icons.map,
              ),
            )),
            Card(
                child: ListTile(
              title: const Text('Safety Numbers',style: TextStyle(fontSize: 16.0)),
              onTap: () {

              Navigator.of(context).push(_createRoute2());},
              leading: const Icon(
                Icons.health_and_safety,
              ),
            )),
            Card(
                child: ListTile(
              title: const Text('About Us',style: TextStyle(fontSize: 16.0)),
              onTap: () {

                Navigator.of(context).push(_createRoute5());},

               // Navigator.of(context).push(_createRoute2());},
              leading: const Icon(
                Icons.person,
              ),
            )),
            Card(
                child: ListTile(
              title: const Text('Help',style: TextStyle(fontSize: 16.0)),
              onTap: () {

                Navigator.of(context).push(_createRoute4());},
              leading: const Icon(
                Icons.help,
              ),
            )),
          ],
        ),
      ),
    );
  }
}


class safety extends State<MyStatefulWidget1>  {

   //safety({super.key});


   void initState(){
     super.initState();
     //fetchPosts1();

   }


  @override
  Widget build(BuildContext context) {
    print(phonedetails.length);
    return Scaffold(
      appBar: AppBar(title: const Text('Safety Numbers'),),
      body: ListView(
        children: <Widget>[
          Card(child: SizedBox(height: 100, child: Image.asset('assets/img_11.png'))),
          Card(

              child: ExpansionTile(

                leading: const Icon(Icons.people),
                title: const Text('Contacts',style: TextStyle(fontSize: 16.0, fontWeight:FontWeight.w500,color: Colors.black)),
                children: <Widget>[

                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('7492983200'),
                    subtitle: const Text('Ambulance, Wada'),
                    onTap: () async {
                      final call = Uri.parse('tel:+91 7492983200');
                      if (await canLaunchUrl(call)) {
                        launchUrl(call);
                      } else {
                        throw 'Could not launch $call';
                      }
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('7372829392'),
                    subtitle: const Text('Ambulance , Khed'),
                    onTap: () async {
                      final call = Uri.parse('tel:+91 7372829392');
                      if (await canLaunchUrl(call)) {
                        launchUrl(call);
                      } else {
                        throw 'Could not launch $call';
                      }
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('7492983100'),
                    subtitle: const Text('Ambulance 3'),
                    onTap: () async {
                      final call = Uri.parse('tel:+91 7492983100');
                      if (await canLaunchUrl(call)) {
                        launchUrl(call);
                      } else {
                        throw 'Could not launch $call';
                      }
                    },
                  ),
                ],

              )),

          Card(
              /*shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.deepPurpleAccent, //<-- SEE HERE
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),*/
              child: ExpansionTile(

            leading: const Icon(Icons.local_hospital),
            title: const Text('Hospitals',style: TextStyle(fontSize: 16.0, fontWeight:FontWeight.w500,color: Colors.black)),
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Krishna Super Speciality Hospital'),
                subtitle: const Text('Kanpur, 363, near Tatmil Chauraha, Harris Ganj, Kanpur, Uttar Pradesh 208004'),
                onTap: () async {
                  final sms = Uri.parse('sms:5550103920');
                  if (await canLaunchUrl(sms)) {
                    launchUrl(sms);
                  } else {
                    throw 'Could not launch $sms';
                  }
                },
              ),

              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Amravati hospital'),
                subtitle: const Text('Kanpur, 16/17, Block K, Govind Nagar, Kanpur, Uttar Pradesh 208006'),
                onTap: () async {
                  final sms = Uri.parse('sms:5550101234');
                  if (await canLaunchUrl(sms)) {
                    launchUrl(sms);
                  } else {
                    throw 'Could not launch $sms';
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Chandni Hospital'),
                subtitle: const Text('9/60, Arya Nagar Rd, Khalasi Line, Arya Nagar, Kanpur, Uttar Pradesh 208002'),
                onTap: () async {
                  final sms = Uri.parse('sms:5550101234');
                  if (await canLaunchUrl(sms)) {
                    launchUrl(sms);
                  } else {
                    throw 'Could not launch $sms';
                  }
                },
              ),
            ],

          )),

        ],
      ),

    );
  }
}


Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>  MapScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}


Route _createRoute4() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>  helpdetails(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRoute5() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>  aboutusdetails(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
Route _createRoute1() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>  MyStatefulWidget(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRoute2() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>  MyStatefulWidget1(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRoute3() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>  alertsdetails(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}





class alertsdetails extends StatelessWidget {

  const alertsdetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alert Detail Page'),),
      /*body: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 6,
          itemBuilder: (context,i){
            //final post=_postsJson[i];
            return const Card(
                color: Colors.white,

                child: ListTile(
                  leading: Icon(Icons.health_and_safety),

                  title: Text("data point"),
                  subtitle: Text("body"),

                ));}
      )*/
      body: ListView(children: <Widget>[
        Card(child: SizedBox(height: 100, child: Image.asset('assets/img_18.png'))),
        const Card(
          child: ListTile(
            leading: Icon(Icons.local_fire_department_rounded),
            title: Text('Temperature'),
            subtitle: Text('98'),

          ),
        ),
        const Card(
          child: ListTile(
            leading: Icon(Icons.monitor_heart),
            title: Text('Heart Rate'),
            subtitle: Text('80'),

          ),
        ),

        const Card(
          child: ListTile(
            leading: Icon(Icons.heart_broken),
            title: Text('SpO2'),
            subtitle: Text('98'),

          ),
        ),

        const Card(
          child: ListTile(
            leading: Icon(Icons.gas_meter),
            title: Text('Gas Level'),
            subtitle: Text('2ppm'),

          ),
        ),

   
        ])


    );
  }
}


class aboutusdetails extends StatelessWidget {

  const aboutusdetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('About Us Details'),),
        body: ListView(
            children: <Widget>[
              Card(color: Colors.white,shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
                child: SizedBox(height: 250, child: Image.asset('assets/Heledited.png'))),
              Card(
                  color: Colors.white,

                  child: ListTile(
                    leading: const Icon(Icons.person),

                    title: const Text("Nishant P",style: TextStyle(fontSize: 16.0, fontWeight:FontWeight.w500,color: Colors.black)),
                    subtitle: const Text('Server developer'),
                    onTap: () {}

                    //  Navigator.of(context).push(_createRoute3());},
                  )),
              Card(
                  color: Colors.white,

                  child: ListTile(
                    leading: const Icon(Icons.person),

                    title: const Text("Swami Kedari",style: TextStyle(fontSize: 16.0, fontWeight:FontWeight.w500,color: Colors.black)),
                    subtitle: const Text('Software developer'),
                    onTap: () {}

                    //  Navigator.of(context).push(_createRoute3());},
                  )),

            ])

    );
  }
}



class helpdetails extends StatelessWidget {

  const helpdetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Help'),),
        body: ListView(
            children: <Widget>[
              Card(child: SizedBox(height: 100, child: Image.asset('assets/img_10.png'))),
              Card(
                color: Colors.white,

                child: ListTile(
                  leading: const Icon(Icons.phone),

                  title: const Text("7057970431",style: TextStyle(fontSize: 16.0, fontWeight:FontWeight.w500,color: Colors.black)),
                  subtitle: const Text('Devansh Verma, Software Team'),
                  onTap: () async {
                    final call = Uri.parse('tel:+91 7057970431');
                    if (await canLaunchUrl(call)) {
                      launchUrl(call);
                    } else {
                      throw 'Could not launch $call';
                    }
                  },
                )),
        Card(
            color: Colors.white,

            child: ListTile(
              leading: const Icon(Icons.phone),

              title: const Text("7057382929",style: TextStyle(fontSize: 16.0, fontWeight:FontWeight.w500,color: Colors.black)),
              subtitle: const Text('Sidhant Hanwate, Server team'),
              onTap: () async {
                final call = Uri.parse('tel:+91 7057382929');
                if (await canLaunchUrl(call)) {
                  launchUrl(call);
                } else {
                  throw 'Could not launch $call';
                }
              },
            )),
        Card(
            color: Colors.white,

            child: ListTile(
              leading: const Icon(Icons.phone),

              title: const Text("7053728911",style: TextStyle(fontSize: 16.0, fontWeight:FontWeight.w500,color: Colors.black)),
              subtitle: const Text('Venky Sharma, Hardware Expert'),
              onTap: () async {
                final call = Uri.parse('tel:+91 7053728911');
                if (await canLaunchUrl(call)) {
                  launchUrl(call);
                } else {
                  throw 'Could not launch $call';
                }
              },

                //Navigator.of(context).push(_createRoute3());},
            )),
              Card(
                  color: Colors.white,

                  child: ListTile(
                    leading: const Icon(Icons.phone),

                    title: const Text("7057970412",style: TextStyle(fontSize: 16.0, fontWeight:FontWeight.w500,color: Colors.black)),
                    subtitle: const Text('Sanket Wadore, Hardware team'),
                    onTap: () async {
                      final call = Uri.parse('tel:+91 7057970412');
                      if (await canLaunchUrl(call)) {
                        launchUrl(call);
                      } else {
                        throw 'Could not launch $call';
                      }
                    },

                      //Navigator.of(context).push(_createRoute3());},
                  )),
              Card(
                  color: Colors.white,

                  child: ListTile(
                    leading: const Icon(Icons.phone),

                    title: const Text("7057170421",style: TextStyle(fontSize: 16.0, fontWeight:FontWeight.w500,color: Colors.black)),
                    subtitle: const Text('Swami Ked, Hardware team'),
                    onTap: () async {
                      final call = Uri.parse('tel:+91 7057170421');
                      if (await canLaunchUrl(call)) {
                        launchUrl(call);
                      } else {
                        throw 'Could not launch $call';
                      }
                    },

                     // Navigator.of(context).push(_createRoute3());},
                  )),
        ])

    );
  }
}

class util {

  final contactsurl="http://localhost:4000/contacts/";

   void fetchContacts(context) async{
    try {
      final response = await http.get(Uri.parse(contactsurl));
      final jsonData = jsonDecode(response.body) as List;

    }
    catch(err){
      final snackBar = SnackBar(
        content: const Text('Check your internet connection , not able to fetch the contacts!'),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  final dangerurl="http://localhost:4000/danger/";

  void fetchdanger(context) async{
    try {
      final response = await http.get(Uri.parse(dangerurl));
      final jsonData = jsonDecode(response.body) as List;

    }
    catch(err){
      final snackBar = SnackBar(
        content: const Text('Check your internet connection , not able to fetch the contacts!'),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  final hospitalurl="http://localhost:4000/hospitals/";

  void fetchHospitals(context) async{
    try {
      final response = await http.get(Uri.parse(hospitalurl));
      final jsonData = jsonDecode(response.body) as List;

    }
    catch(err){
      final snackBar = SnackBar(
        content: const Text('Check your internet connection , not able to fetch the contacts!'),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  final userinfourl="http://localhost:4000/userinfo/";

  void fetchUser(context) async{
    try {
      final response = await http.get(Uri.parse(userinfourl));
      final jsonData = jsonDecode(response.body) as List;

    }
    catch(err){
      final snackBar = SnackBar(
        content: const Text('Check your internet connection , not able to fetch the contacts!'),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  final abouturl="http://localhost:4000/about/";

  void fetchAbout(context) async{
    try {
      final response = await http.get(Uri.parse(abouturl));
      final jsonData = jsonDecode(response.body) as List;

    }
    catch(err){
      final snackBar = SnackBar(
        content: const Text('Check your internet connection , not able to fetch the contacts!'),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

 


}

