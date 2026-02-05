
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:event_sense_ai/core/bindings/globalBindings.dart';
import 'package:event_sense_ai/core/routes/app_routes.dart';
import 'package:event_sense_ai/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'core/routes/go_router.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'application_status',
        channelName: 'Application Status',
        channelDescription: 'Application accept/reject notifications',
        importance: NotificationImportance.High,
      ),
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType){
        return  GetMaterialApp(

          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
            initialRoute : AppRoutes.splash,
          getPages:  go_routes.routes,
          initialBinding: EventBindings(),
        );
      },

    );
  }
}

