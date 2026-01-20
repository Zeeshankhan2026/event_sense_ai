
import 'package:go_router/go_router.dart';
import '../../features/auth/users_auth_screens/confrim_locations.dart';
import '../../features/auth/users_auth_screens/forget_password_screen.dart';
import '../../features/auth/users_auth_screens/login_screen.dart';
import '../../features/auth/users_auth_screens/otp_screen.dart';
import '../../features/auth/users_auth_screens/profile_screen.dart';
import '../../features/auth/users_auth_screens/set_location.dart';
import '../../features/auth/users_auth_screens/signup_screen.dart';
import '../../features/auth/users_auth_screens/welcome_screen.dart';
import '../../features/auth/vendor_auth_screen/confirm_location.dart';
import '../../features/auth/vendor_auth_screen/registration.dart';
import '../../features/auth/vendor_auth_screen/vendor_portfolio.dart';
import '../../features/auth/vendor_auth_screen/vendor_set_location.dart';
import '../../features/auth/vendor_auth_screen/vendor_welcome_screen.dart';
import '../../features/user_home_screen/Add_Guest.dart';
import '../../features/user_home_screen/Invite_guest.dart';
import '../../features/user_home_screen/bottom_nav/Bottom_Nav.dart';
import '../../features/user_home_screen/bottom_nav/event_screen.dart';
import '../../features/user_home_screen/budget_breakdown.dart';
import '../../features/user_home_screen/check_budget.dart';
import '../../features/user_home_screen/create_event_screen.dart';
import '../../features/user_home_screen/create_invitaion_card_design.dart';
import '../../features/user_home_screen/event_details_screen.dart';
import '../../features/user_home_screen/generate_ai_screen.dart';
import '../../features/user_home_screen/guest_list.dart';
import '../../features/user_home_screen/message_screen.dart';
import '../../features/user_home_screen/notification_screen.dart';
import '../../features/user_home_screen/proposal_aproval_screen.dart';
import '../../features/user_home_screen/update_acount_screen.dart';
import '../../features/user_home_screen/user_add_post_screen.dart';
import '../../features/user_home_screen/user_review_screen.dart';
import '../../features/user_home_screen/venders_management.dart';
import '../../features/user_home_screen/view_application_screen.dart';
import '../../features/vendor_home_screen/active_event.dart';
import '../../features/vendor_home_screen/find_new_oppurtunities.dart';
import '../../features/vendor_home_screen/finish_active_events.dart';
import '../../features/vendor_home_screen/new_request_details.dart';
import '../../features/vendor_home_screen/submit_application.dart';
import '../../features/vendor_home_screen/vendor_account_screen.dart';
import '../../features/vendor_home_screen/vendor_home_screen.dart';
import '../../features/vendor_home_screen/vendor_message_screen.dart';
import '../../features/vendor_home_screen/vendor_notification_screen.dart';
import '../../features/vendor_home_screen/vendor_profile_screeen.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splashPath,
  routes: [

    /// SPLASH
    GoRoute(
      path: AppRoutes.splashPath,
      name: AppRoutes.splash,
      builder: (context, state) => const WelcomeScreen(),
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
              path: 'guestList',
              name: AppRoutes.guestList,
              builder: (context, state) => GuestList(),
            ),
            GoRoute(
              path: 'AddGuest',
              name: AppRoutes.AddGuest,
              builder: (context, state) => AddGuest(),
            ),
            GoRoute(
              path: 'VendersManagement',
              name: AppRoutes.VendersManagement,
              builder: (context, state) => VendersManagement(),
            ),
            GoRoute(
              path: 'CheckBudget',
              name: AppRoutes.CheckBudget,
              builder: (context, state) => CheckBudget(),
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
            GoRoute(
              path: 'InviteGuest',
              name: AppRoutes.InviteGuest,
              builder: (context, state) => InviteGuest(),
            ),
            GoRoute(
              path: 'JoinAsVendorScreen',
              name: AppRoutes.JoinAsVendorScreen,
              builder: (context, state) => JoinAsVendorScreen(),
            ),
            GoRoute(
              path: 'Vendor_profile_screen',
              name: AppRoutes.Vendor_profile_screen,
              builder: (context, state) => VendorRegistrationScreen(),
            ),
            GoRoute(
              path: 'VendorSetLocation',
              name: AppRoutes.VendorSetLocation,
              builder: (context, state) => VendorSetLocation(),
            ),
            GoRoute(
              path: 'VendorConfirmLocation',
              name: AppRoutes.VendorConfirmLocation,
              builder: (context, state) => VendorConfirmLocation(),
            ),
            GoRoute(
              path: 'VendorHomeScreen',
              name: AppRoutes.VendorHomeScreen,
              builder: (context, state) => VendorHomeScreen(),
            ),
            GoRoute(
              path: 'FindNewOppurtunities',
              name: AppRoutes.FindNewOppurtunities,
              builder: (context, state) => FindNewOppurtunities(),
            ),
            GoRoute(
              path: 'SubmitApplication',
              name: AppRoutes.SubmitApplications,
              builder: (context, state) => SubmitApplication(),
            ),
            GoRoute(
              path: 'ActiveEvent',
              name: AppRoutes.ActiveEvent,
              builder: (context, state) => ActiveEvent(),
            ),
            GoRoute(
              path: 'FinishActiveEvents',
              name: AppRoutes.FinishActiveEvents,
              builder: (context, state) => FinishActiveEvents(),
            ),
            GoRoute(
              path: 'NewRequestDetails',
              name: AppRoutes.NewRequestDetails,
              builder: (context, state) => NewRequestDetails(),
            ),
            GoRoute(
              path: 'VendorProfileScreeen',
              name: AppRoutes.VendorProfileScreeen,
              builder: (context, state) => VendorProfileScreeen(),
            ),
            GoRoute(
              path: 'EditAccountScreen',
              name: AppRoutes.EditAccountScreen,
              builder: (context, state) => EditAccountScreen(),
            ),
            GoRoute(
              path: 'NotificationScreen',
              name: AppRoutes.NotificationScreen,
              builder: (context, state) => NotificationScreen(),
            ),
            GoRoute(
              path: 'UserPostJobScreen',
              name: AppRoutes.UserPostJobScreen,
              builder: (context, state) => UserPostJobScreen(),
            ),
            GoRoute(
              path: 'ViewApplicationScreen',
              name: AppRoutes.ViewApplicationScreen,
              builder: (context, state) => ViewApplicationScreen(),
            ),
            GoRoute(
              path: 'ProposalAprovalScreen',
              name: AppRoutes.ProposalAprovalScreen,
              builder: (context, state) => ProposalApprovalScreen(),
            ),
            GoRoute(
              path: 'UserReviewScreen',
              name: AppRoutes.UserReviewScreen,
              builder: (context, state) => UserReviewScreen(),
            ),
            GoRoute(
              path: 'UserSetLocation',
              name: AppRoutes.UserSetLocation,
              builder: (context, state) => UserSetLocation(),
            ),
            GoRoute(
              path: 'UserConfirmLocation',
              name: AppRoutes.UserConfirmLocation,
              builder: (context, state) => UserConfirmLocation(),
            ),
          ],
        ),
        GoRoute(
          path: 'VendorNotificationScreen',
          name: AppRoutes.VendorNotificationScreen,
          builder: (context, state) => VendorNotificationScreen(),
        ),
        GoRoute(
          path: 'VendorAccountScreen',
          name: AppRoutes.VendorAccountScreen,
          builder: (context, state) => VendorAccountScreen(),
        ),
        GoRoute(
          path: 'VendorMessageScreen',
          name: AppRoutes.VendorMessageScreen,
          builder: (context, state) => VendorMessageScreen(),
        ),
        GoRoute(
          path: "CreateInvitaionCardDesign",
          name: AppRoutes.CreateInvitaionCardDesign,
          builder: (context, state) =>  CreateInvitaionCardDesign(),
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
        GoRoute(
          path:"vendorPortfolio",
          name: AppRoutes.vendorPortfolio,
          builder: (context, state) =>  vendorPortfolio(),
        ),
      ],
    );

