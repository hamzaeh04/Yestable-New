class ApiEndPoints{
  // Auth
  static const String login = '/auth/login';
  static const String googleLogin = '/auth/google/firebase';
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

  static String aiMenu(String id){
    return "/events/$id/menu-suggestions";
  }

  static String getProfileById(String userId){
    return "/users/profile/$userId";
  }

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

  static String deleteMenu(String menuId){
    return '/menus/$menuId';
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

  static String getEventById(String eventId) {
    return '/events/${eventId}';
  }

  static String myEvents(int page) {
    return '/events/my-events?page=${page}&limit=10';
  }
  static String joinEvent(String eventId) {
    return '/events/${eventId}/join';
  }

  static String ignoreEventLink(String eventId) {
    return '/events/${eventId}/ignore-link';
  }

  static String pendingInvitations() {
    return '/invitations/my/pending';
  }

  static String respondToInvitation(String invitationId) {
    return '/invitations/${invitationId}/respond';
  }

  static String getAllergenList(String eventId){
    return "/events/${eventId}/allergen-counts";
  }

  static String getEventAllergens(String eventId) {
    return "/events/${eventId}/allergens";
  }
}
