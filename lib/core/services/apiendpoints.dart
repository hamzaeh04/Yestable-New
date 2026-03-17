class ApiEndPoints{
  // Auth
  static const String login = '/auth/login';
  static const String verifyOtp = '/auth/verify';
  static const String setupProfile = '/users/profile/setup';
  static const String updateAllergensPlate = '/users/profile/allergens-plate';
  static const String updateYumYuck = '/users/profile/yum-yuck';
  static const String seatingAssistance = '/users/profile/seating-assistance';
  static const String getMyProfile = '/users/profile';
  static const String addMember = '/users/members';

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
}
