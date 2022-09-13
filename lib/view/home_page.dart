import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pushnotification/notification_services/local_notification_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //If app is in terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message){
      print("FirebaseMessaging.instance.getInitialMessage");
      if(message != null){
        print("New notification");
      }
    });

    // If app is opened
    FirebaseMessaging.onMessage.listen((message) {
      print("FirebaseMessaging.onMessage.listen");
      if(message.notification != null){
        print(message.notification!.title);
        print(message.notification!.body);
        print("Message details ${message.data}");
        LocalNotificationServices.createanddisplaynotification(message);
      }
    });

    //If app is running in background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("FirebaseMessaging.onMessageOpenedApp.listen");
      if(message.notification != null){
        print(message.notification!.title);
        print(message.notification!.body);
        print("Message data ${message.data['_id']}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification App"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text("Push Notifications"),
      ),
    );
  }
}
