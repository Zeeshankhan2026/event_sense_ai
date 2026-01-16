import 'package:event_sense_ai/routes/app_routes.dart';
import 'package:event_sense_ai/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2) ,(){
      context.goNamed(AppRoutes.login);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: AppText("Splash Screen"),)
        ],
      ),
    );
  }
}
