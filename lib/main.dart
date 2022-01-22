import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notifications',
      debugShowCheckedModeBanner: false,
      home:HomePage()
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late FlutterLocalNotificationsPlugin fltrNotification;
  
  @override
  void initState() {
    super.initState();
    var androidInitilize = new AndroidInitializationSettings('pay_pal');
    var initilizationsSettings =new InitializationSettings(android: androidInitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification:notificationSelected);

    
  }
  
  Future _showNotification() async {
   var androidDetails = new AndroidNotificationDetails(
       "Channel ID", "Desi programmer",
       importance: Importance.max);
   var generalNotificationDetails =
       new NotificationDetails(android:androidDetails);
    var scheduledTime;
    if(_selectedParam=='Hours')
    {
      scheduledTime=DateTime.now().add(Duration(hours: val));
    }else if(_selectedParam=='Minutes')
    {
      scheduledTime=DateTime.now().add(Duration(minutes: val));
    }else 
    {
      scheduledTime=DateTime.now().add(Duration(seconds: val));
    }

     fltrNotification.schedule(1, "Times Uppp", task, 
     scheduledTime, generalNotificationDetails);
 }


  late String task;
  late int val=1;
  late String? _selectedParam="Hours";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:
              Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(border: OutlineInputBorder()),
                onChanged: (_val){
                  task=_val;
                },
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:[
                DropdownButton<String>(
                  value: _selectedParam,
                  items: [
                    DropdownMenuItem<String>(
                      child: Text("Seconds"),
                      value: "Seconds"
                    ),
                    DropdownMenuItem<String>(
                      child: Text("Minutes"),
                      value: "Minutes"
                    ),
                    DropdownMenuItem<String>(
                      child: Text("Hours"),
                      value: "Hours"
                    ),
                    DropdownMenuItem<String>(
                      child: Text("Days"),
                      value: "Days"
                    )
                  ], 
                  hint: Text(
                    "Select Your Field",
                    style: TextStyle(
                      color:Colors.black
                    )
                  ),
                  onChanged: (_val){
                    setState(() {
                      _selectedParam= _val;
                    });
                  },
                  
                ),
          DropdownButton<int>(
            value:val,
            items: [
              DropdownMenuItem(
                child: Text("1"),
                value:1
                ),
              DropdownMenuItem(
                child: Text("2"),
                value:2
                ),
              DropdownMenuItem(
                child: Text("3"),
                value:3
                ),
              DropdownMenuItem(
                child: Text("4"),
                value:4
                ),
              DropdownMenuItem(
                child: Text("5"),
                value:5
                ),
            ], 
            hint:Text(
              "Select Value",
               style: TextStyle(
                      color:Colors.black
                    )
            ),
            onChanged: (_val){
              setState((){
                val=_val!;
              });
            }
            )
              ]),
            ElevatedButton(
              onPressed: _showNotification,
              child:Text('Flutter Notifications')
            )
          ]
        )
      )
    );
  }

  void notificationSelected(String? payload) async{
   showDialog(
     context: context,
     builder: (context) => AlertDialog(
       content: Text("Notification clicked $payload"),
     ),
   );
 }
}
