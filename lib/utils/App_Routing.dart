import 'package:get/get.dart';
import 'package:yestable/views/guest_screens/auth_screens/verification_code_screen.dart';
import 'package:yestable/views/guest_screens/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:yestable/views/guest_screens/chat_screens/chat_message_screen.dart';
import 'package:yestable/views/guest_screens/chat_screens/yes_gpt_screen.dart';
import 'package:yestable/views/guest_screens/dashboard/add_freind_screen.dart';
import 'package:yestable/views/guest_screens/dashboard/event_details_screen.dart';
import 'package:yestable/views/guest_screens/dashboard/my_profile_screen.dart';
import 'package:yestable/views/guest_screens/dashboard/search_screen.dart';
import 'package:yestable/views/guest_screens/welcome_screens/splash_screen.dart';
import 'package:yestable/views/guest_screens/welcome_screens/splash_two.dart';
import 'package:yestable/views/host_screens/events_screens/create_new_event_screen.dart';

import '../views/guest_screens/chat_screens/chat_group_setting.dart';
import '../views/guest_screens/chat_screens/new_message_screen.dart';
import '../views/guest_screens/chat_screens/profile_chat_message.dart';
import '../views/guest_screens/dashboard/my_notification_screen.dart';
import '../views/guest_screens/profile_setup_screens/add_profile_picture.dart';
import '../views/guest_screens/auth_screens/signup_screen.dart';
import '../views/guest_screens/profile_setup_screens/allergies_dietry_screen.dart';
import '../views/guest_screens/profile_setup_screens/allow_notification_screen.dart';
import '../views/guest_screens/profile_setup_screens/community_profile.dart';
import '../views/guest_screens/profile_setup_screens/disclamer_screen.dart';
import '../views/guest_screens/profile_setup_screens/food_preferences_one.dart';
import '../views/guest_screens/profile_setup_screens/food_preferences_two.dart';
import '../views/guest_screens/profile_setup_screens/host_profile_screen.dart';
import '../views/guest_screens/profile_setup_screens/profile_complete_screen.dart';
import '../views/guest_screens/profile_setup_screens/profile_edit_screen.dart';
import '../views/guest_screens/welcome_screens/get_started_screen.dart';
import '../views/host_screens/dashboard/guest_list_screen.dart';
import '../views/host_screens/events_screens/event_comfort_one.dart';
import '../views/host_screens/events_screens/event_comfort_three.dart';
import '../views/host_screens/events_screens/event_comfort_two.dart';
import '../views/host_screens/dashboard/new_guest_list_screen.dart';
import '../views/host_screens/events_screens/event_publish_screen.dart';
import '../views/host_screens/events_screens/food_menu_screen.dart';
import '../views/host_screens/host_profile_setup_screens/add_host_profile_picture.dart';
import '../views/host_screens/host_profile_setup_screens/allergies_host_screen.dart';
import '../views/host_screens/host_profile_setup_screens/allow_host_notification_screen.dart';
import '../views/host_screens/host_profile_setup_screens/host_edit_profile_screen.dart';
import '../views/host_screens/host_profile_setup_screens/host_food_preference_one.dart';
class AppRoutes {
  static List<GetPage<dynamic>> routes = [
    GetPage(name: '/', page: () => SplashScreen()),
    GetPage(name: '/splashtwo', page: () => SplashTwo()),
    GetPage(name: '/getstarted', page: () => GetStartedScreen()),
    GetPage(name: '/signupscreen', page: () => SignupScreen()),
    GetPage(name: '/verificationcodescreen', page: () => VerificationCodeScreen()),
    GetPage(name: '/addprofilepicture', page: () => AddProfilePicture()),
    GetPage(name: '/allownotificationscreen', page: () => AllowNotificationScreen()),
    GetPage(name: '/profilecompletescreen', page: () => ProfileCompleteScreen()),
    GetPage(name: '/profileeditscreen', page: () => ProfileEditScreen()),
    GetPage(name: '/foodpreferencestwo', page: () => FoodPreferencesTwo()),
    GetPage(name: '/allergiesdietryscreen', page: () => AllergiesDietryScreen()),
    GetPage(name: '/foodpreferencesone', page: () => FoodPreferencesOne()),
    GetPage(name: '/bottomnavigationbar', page: () => CustomBottomNavBar()),
    GetPage(name: '/eventdetailsscreen', page: () => EventDetailsScreen()),
    GetPage(name: '/chatmessagescreen', page: () => ChatMessageScreen()),
    GetPage(name: '/chatgroupsetting', page: () => ChatGroupSetting()),
    GetPage(name: '/newmessagescreen', page: () => NewMessageScreen()),
    GetPage(name: '/profilechatmessage', page: () => ProfileChatMessage()),
    GetPage(name: '/addfriendscreen', page: () => AddFreindScreen()),
    GetPage(name: '/searchscreen', page: () => SearchScreen()),
    GetPage(name: '/myprofilescreen', page: () => MyProfileScreen()),
    GetPage(name: '/mynotificationscreen', page: () => MyNotificationScreen()),
    GetPage(name: '/hostprofilepcreen', page: () => HostProfileScreen()),
    GetPage(name: '/communityprofile', page: () => CommunityProfile()),
    GetPage(name: '/createneweventscreen', page: () => CreateNewEventScreen()),
    GetPage(name: '/eventpublishscreen', page: () => EventPublishScreen()),
    GetPage(name: '/newguestlistscreen', page: () => NewGuestListScreen()),
    GetPage(name: '/guestlistscreen', page: () => GuestListScreen()),
    GetPage(name: '/eventcomfortone', page: () => EventComfortOne()),
    GetPage(name: '/eventcomforttwo', page: () => EventComfortTwo()),
    GetPage(name: '/eventcomfortthree', page: () => EventComfortThree()),
    GetPage(name: '/foodmenuscreen', page: () => FoodMenuScreen()),
    GetPage(name: '/addhostprofilepicture', page: () => AddHostProfilePicture()),
    GetPage(name: '/hosteditprofilescreen', page: () => HostEditProfileScreen()),
    GetPage(name: '/allowhostnotificationscreen', page: () => AllowHostNotificationScreen()),
    GetPage(name: '/allergieshostscreen', page: () => AllergiesHostScreen()),
    GetPage(name: '/disclaimerscreen', page: () => DisclaimerScreen()),
    GetPage(name: '/yesgptscreen', page: () => YesGptScreen()),

  ];
}
