import 'package:event_sense_ai/core/bindings/globalBindings.dart';
import 'package:event_sense_ai/core/routes/app_routes.dart';
import 'package:event_sense_ai/features/auth/users_auth_screens/splash_screen.dart';
import 'package:event_sense_ai/features/auth/vendor_auth_screen/vendor_loginscreen.dart';
import 'package:event_sense_ai/features/user_home_screen/create_invitaion_card_design.dart';
import 'package:event_sense_ai/features/user_home_screen/guest_management_screen.dart';
import 'package:event_sense_ai/features/user_home_screen/message_details_screen.dart';
import 'package:event_sense_ai/features/user_home_screen/proposal_details.dart';
import 'package:get/get.dart';

// AUTH
import '../../features/auth/users_auth_screens/welcome_screen.dart';
import '../../features/auth/users_auth_screens/login_screen.dart';
import '../../features/auth/users_auth_screens/signup_screen.dart';
import '../../features/auth/users_auth_screens/forget_password_screen.dart';
import '../../features/auth/users_auth_screens/otp_screen.dart';
import '../../features/auth/users_auth_screens/profile_screen.dart';
import '../../features/auth/users_auth_screens/set_location.dart';
import '../../features/auth/users_auth_screens/confrim_locations.dart';

// USER HOME
import '../../features/user_home_screen/bottom_nav/Bottom_Nav.dart';
import '../../features/user_home_screen/bottom_nav/event_screen.dart';
import '../../features/user_home_screen/event_details_screen.dart';
import '../../features/user_home_screen/create_event_screen.dart';
import '../../features/user_home_screen/guest_list.dart';
import '../../features/user_home_screen/Add_Guest.dart';
import '../../features/user_home_screen/venders_management.dart';
import '../../features/user_home_screen/check_budget.dart';
import '../../features/user_home_screen/generate_ai_screen.dart';
import '../../features/user_home_screen/budget_breakdown.dart';
import '../../features/user_home_screen/Invite_guest.dart';
import '../../features/user_home_screen/notification_screen.dart';
import '../../features/user_home_screen/user_add_post_screen.dart';
import '../../features/user_home_screen/view_application_screen.dart';
import '../../features/user_home_screen/proposal_aproval_screen.dart';
import '../../features/user_home_screen/user_review_screen.dart';
import '../../features/user_home_screen/update_acount_screen.dart';

// VENDOR AUTH
import '../../features/auth/vendor_auth_screen/registration.dart';
import '../../features/auth/vendor_auth_screen/vendor_set_location.dart';
import '../../features/auth/vendor_auth_screen/confirm_location.dart';
import '../../features/auth/vendor_auth_screen/vendor_welcome_screen.dart';
import '../../features/auth/vendor_auth_screen/vendor_portfolio.dart';

// VENDOR HOME
import '../../features/vendor_home_screen/eventDayProgress.dart';
import '../../features/vendor_home_screen/notification_details_screen.dart';
import '../../features/vendor_home_screen/vendor_home_screen.dart';
import '../../features/vendor_home_screen/find_new_oppurtunities.dart';
import '../../features/vendor_home_screen/submit_application.dart';
import '../../features/vendor_home_screen/active_event.dart';
import '../../features/vendor_home_screen/finish_active_events.dart';
import '../../features/vendor_home_screen/new_request_details.dart';
import '../../features/vendor_home_screen/vendor_profile_screeen.dart';
import '../../features/vendor_home_screen/vendor_message_screen.dart';
import '../../features/vendor_home_screen/vendor_notification_screen.dart';
import '../../features/vendor_home_screen/edit_vendor_profile_screen.dart';
import '../controller/vendor_controller.dart';

class go_routes {
  static final routes = [

    /// SPLASH / WELCOME
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.welcome_screen,
      page: () => WelcomeScreen(),
    ),

    /// AUTH
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => SignUpScreen(),
      binding: GlobalBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => ForgetPasswordScreen(),
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => OtpScreen(),
    ),

    /// MAIN / DASHBOARD
    GetPage(
      name: AppRoutes.main,
      page: () => BottomNav(),
    ),

    /// EVENTS
    GetPage(
      name: AppRoutes.events,
      page: () => const EventScreen(),
    ),
    GetPage(
      name: AppRoutes.eventDetails,
      page: () => EventDetailsScreen(),
    ),
    GetPage(
      name: AppRoutes.createEvent,
      page: () => CreateEventScreen(),
    ),
    GetPage(
      name: AppRoutes.guestList,
      page: () => GuestList(),
    ),
    GetPage(
      name: AppRoutes.addGuest,
      page: () => AddGuest(),
    ),
    GetPage(
      name: AppRoutes.vendersManagement,
      page: () => VendersManagement(),
    ),
    GetPage(
      name: AppRoutes.checkBudget,
      page: () => CheckBudget(),
    ),
    GetPage(
      name: AppRoutes.generateAiScreen,
      page: () => GenerateAiScreen(),
    ),
    GetPage(
      name: AppRoutes.budgetBreakdown,
      page: () => BudgetBreakdown(),
    ),
    GetPage(
      name: AppRoutes.inviteGuest,
      page: () => InviteGuest(),
    ),

    /// USER
    GetPage(
      name: AppRoutes.userSetLocation,
      page: () => UserSetLocation(),
    ),
    GetPage(
      name: AppRoutes.GuestManagementScreen,
      page: () => GuestManagementScreen(),
    ),
    GetPage(
      name: AppRoutes.userConfirmLocation,
      page: () => UserConfirmLocation(),
    ),
    GetPage(
      name: AppRoutes.notificationScreen,
      page: () => PlannerNotificationScreen(),
    ),
    GetPage(
      name: AppRoutes.userPostJobScreen,
      page: () => UserPostJobScreen(),
      binding: PlannerCategoryControllerBinding()
    ),
    GetPage(
      name: AppRoutes.createInvitaionCardDesign,
      page: () => CreateInvitaionCardDesign(),
      binding: InvitaioncardBindings(),
    ),
    GetPage(
      name: AppRoutes.viewApplicationScreen,
      page: () => ViewApplicationScreen(),
      binding: SubmitApplicationBinding()
    ),
    GetPage(
      name: AppRoutes.proposalAprovalScreen,
      page: () => ProposalApprovalScreen(),
    ),
    GetPage(
      name: AppRoutes.userReviewScreen,
      page: () => UserReviewScreen(),
    ),
    GetPage(
      name: AppRoutes.editAccountScreen,
      page: () => EditAccountScreen(),
    ),

    GetPage(
      name: AppRoutes.proposalDetails,
      page: () => ProposalDetails(),
      binding: SubmitApplicationBinding(),
    ),
    /// PROFILE
    GetPage(
      name: AppRoutes.profile,
      page: () =>  ProfileScreen(),
    ),

    /// VENDOR AUTH
    GetPage(
      name: AppRoutes.vendorRegistration_screen,
      page: () => VendorRegistrationScreen(),
    ),
    GetPage(
      name: AppRoutes.vendorSetLocation,
      page: () => VendorSetLocation(),
    ),
    GetPage(
      name: AppRoutes.vendorConfirmLocation,
      page: () => VendorConfirmLocation(),
    ),
    GetPage(
      name: AppRoutes.joinAsVendorScreen,
      page: () => JoinAsVendorScreen(),
    ),
    GetPage(
      name: AppRoutes.vendorPortfolio,
      page: () => vendorPortfolio(),
    ),

    /// VENDOR HOME
    GetPage(
      name: AppRoutes.vendorHomeScreen,
      page: () => VendorHomeScreen(),
      binding: VendorJobBinding()
    ),
    /// VENDOR Login
    GetPage(
      name: AppRoutes.VendorLoginScreen,
      page: () => VendorLoginScreen(),
    ),
    GetPage(
      name: AppRoutes.findNewOppurtunities,
      page: () => FindNewOppurtunities(),
    ),
    GetPage(
      name: AppRoutes.submitApplications,
      page: () => SubmitApplication(),
      binding: SubmitApplicationBinding(),
    ),
    GetPage(
      name: AppRoutes.activeEvent,
      page: () => ActiveEvent(),
    ),
    GetPage(
      name: AppRoutes.finishActiveEvents,
      page: () => FinishActiveEvents(),
    ),
    GetPage(
      name: AppRoutes.newRequestDetails,
      page: () => NewRequestDetails(),
    ),
    GetPage(
      name: AppRoutes.vendorProfileScreeen,
      page: () => VendorProfileScreeen(),
    ),
    GetPage(
      name: AppRoutes.vendorMessageScreen,
      page: () => VendorMessageScreen(),
    ),
    GetPage(
      name: AppRoutes.vendorNotificationScreen,
      page: () => VendorNotificationScreen(),
      binding: SubmitApplicationBinding()
    ),
    GetPage(
      name: AppRoutes.vendorAccountScreen,
      page: () => EditVendorAccountScreen(),
    ),
    GetPage(
      name: AppRoutes.NotificationDetailsScreen,
      page: () => NotificationDetailsScreen(),
    ),
    GetPage(
      name: AppRoutes.EventDayProgress,
      page: () => EventDayProgress(),
      binding: GlobalBinding(),
    ),
    GetPage(
      name: AppRoutes.chatDetailsScreen,
      page: () => MessageDetailsScreen(),
      binding: ChatBinding(),
    ),
  ];
}
