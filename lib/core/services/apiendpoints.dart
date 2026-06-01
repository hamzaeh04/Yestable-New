class ApiEndPoints{
  // Auth
  static const String login = '/auth/login';
  static const String googleLogin = '/auth/google';
  static const String verifyOtp = '/auth/verify';
  static const String setupProfile = '/users/profile/setup';
  static const String updateAllergensPlate = '/users/profile/allergens-plate';
  static const String updateYumYuck = '/users/profile/yum-yuck';
  static const String seatingAssistance = '/users/profile/seating-assistance';
  static const String getMyProfile = '/users/profile';
  static const String addMember = '/users/members';
  static const String addMenu = '/menus';
  static const String getMenus = '/menus';
  static const String createEvent = '/events';
  static const String editProfile = '/users/profile/update';
  static const String getAllNotifications = '/notifications';
  static const String notificationSetting = '/users/profile/notification-settings';
  static const String registerFcm = '/notifications/register';

  static String updateMemberAllergensPlate(String memberId){
    return '/users/members/${memberId}/allergens-plate';
  }

  static String updateMemberYumYuck(String memberId){
    return '/users/members/${memberId}/yum-yuck';
  }

  static String updateMemberSeating(String memberId){
    return '/users/members/${memberId}/seating-assistance';
  }

  static String deleteMember(String memberId){
    return '/users/members/$memberId';
  }
  static String updateEventComfort(String eventId){
    return '/events/$eventId/comfort';
  }
  
  static String updatedGuestAware(String eventId) {
    return '/events/$eventId/guest-aware';
  }

  static String eventReview(String eventId) {
    return '/events/${eventId}/review';
  }

  static String publishEvent(String eventId) {
    return '/events/${eventId}/publish';
  }

  static String getAllEvent(int page) {
    return '/events/upcoming?page=${page}&limit=10';
  }

  static String editEvent(String eventId) {
    return '/events/${eventId}';
  }

  static String myEvents(int page) {
    return '/events/my-events?page=${page}&limit=10';
  }
  static String joinEvent(String eventId) {
    return '/events/${eventId}/join';
  }
}
