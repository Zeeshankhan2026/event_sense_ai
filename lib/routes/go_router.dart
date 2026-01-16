import 'package:event_sense_ai/features/auth_screens/forget_password_screen.dart';
import 'package:event_sense_ai/features/auth_screens/signup_screen.dart';
import 'package:event_sense_ai/features/auth_screens/splash_screen.dart';
import 'package:event_sense_ai/features/home_screen/Bottom_Nav.dart';
import 'package:event_sense_ai/features/home_screen/generate_ai_screen.dart';
import 'package:event_sense_ai/features/home_screen/home_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth_screens/login_screen.dart';
import '../features/auth_screens/otp_screen.dart';
import '../features/auth_screens/profile_screen.dart';
import '../features/home_screen/budget_breakdown.dart';
import '../features/home_screen/create_event_screen.dart';
import '../features/home_screen/event_details_screen.dart';
import '../features/home_screen/event_screen.dart';
import '../features/home_screen/message_screen.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splashPath,
  routes: [

    /// SPLASH
    GoRoute(
      path: AppRoutes.splashPath,
      name: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),

    /// AUTH FLOW
    GoRoute(
      path: AppRoutes.loginPath,
      name: AppRoutes.login,
      builder: (context, state) => LoginScreen(),
      routes: [
        GoRoute(
          path: 'signup',
          name: AppRoutes.signup,
          builder: (context, state) => SignUpScreen(),
        ),
        GoRoute(
          path: 'forgot-password',
          name: AppRoutes.forgotPassword,
          builder: (context, state) => ForgetPasswordScreen(),
        ),
        GoRoute(
          path: 'otp',
          name: AppRoutes.otp,
          builder: (context, state) => OtpScreen(),
        ),
        /// HOME
        GoRoute(
          path: "main",
          name: AppRoutes.main,
          builder: (context, state) => BottomNav(),
        ),

        /// EVENTS
        GoRoute(
          path: "events",
          name: AppRoutes.events,
          builder: (context, state) => const EventScreen(),
          routes: [
            GoRoute(
              path: 'eventDetails',
              name: AppRoutes.eventDetails,
              builder: (context, state) {
                return EventDetailsScreen();
              },
            ),
            GoRoute(
              path: 'createEvent',
              name: AppRoutes.createEvent,
              builder: (context, state) => CreateEventScreen(),
            ),
            GoRoute(
              path: 'generateAiScreen',
              name: AppRoutes.generateAiScreen,
              builder: (context, state) => GenerateAiScreen(),
            ),
            GoRoute(
              path: 'BudgetBreakdown',
              name: AppRoutes.BudgetBreakdown,
              builder: (context, state) => BudgetBreakdown(),
            ),
          ],
        ),


        /// MESSAGES
        GoRoute(
          path: "messages",
          name: AppRoutes.messages,
          builder: (context, state) => const MessageScreen(),
        ),

        /// PROFILE
        GoRoute(
          path:"profile",
          name: AppRoutes.profile,
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),

  ],
);
