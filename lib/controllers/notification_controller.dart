import 'dart:io';

import 'package:get/get.dart';
import 'package:yestable/core/services/apiendpoints.dart';
import 'package:yestable/model/notification_model.dart';
import 'package:yestable/outh_file/local_db_key.dart';
import 'package:yestable/utils/shared_prefrences_methods.dart';
import 'package:yestable/widget/custom_image_widget.dart';

import '../core/services/notification/notification_service.dart';
import '../utils/utility.dart';

class NotificationController extends GetxController{
  int currentPage = 1;
  bool isLoadingMore = false;
  RxBool isHorizontal = true.obs;
  FirebaseNotification firebaseApi = FirebaseNotification();
  final prefs = SharedPreferencesMethod.storage;
  late final fcm = prefs.getString(LocalDBKeys.FCMTOKEN);


      Rxn<GetAllNotificationsModel> getAllNotficationsModel = Rxn<GetAllNotificationsModel>();


  @override
  void onInit() {
    super.onInit();

    if(Platform.isAndroid || Platform.isIOS){
      firebaseApi.onTokenRefresh();
      firebaseApi.firebaseInIt();
    }

    // har 500ms me toggle
    ever(isHorizontal, (_) async {
      await Future.delayed(const Duration(milliseconds: 1000));
      isHorizontal.value = !isHorizontal.value;
    });

    // start animation
    isHorizontal.value = false;
  }

  // Future<void> GetAllNotifications() async{
  //   try{
  //     final response = await baseService.baseGetAPI(ApiEndPoints.getAllNotifications);
  //     print(response);
  //     if(response["success"] == true){
  //       getAllNotficationsModel.value = GetAllNotificationsModel.fromJson(response);
  //       Utils.showToast(response["message"], false);
  //     } else{
  //       Utils.showToast(response["message"], false);
  //     }
  //   } catch(e){
  //     Utils.showToast("Something went wrong. $e", true);
  //   }
  // }

  Future<void> GetAllNotifications({bool loadMore = false}) async {
    try {
      if (isLoadingMore) return;

      if (loadMore) {
        isLoadingMore = true;
        currentPage++;
      } else {
        currentPage = 1;
      }

      final response = await baseService.baseGetAPI(
        "${ApiEndPoints.getAllNotifications}?page=$currentPage&limit=10",
      );

      if (response["success"] == true) {
        final model = GetAllNotificationsModel.fromJson(response);

        if (loadMore) {
          getAllNotficationsModel.value?.data?.data?.addAll(
            model.data?.data ?? [],
          );
          getAllNotficationsModel.refresh();
        } else {
          getAllNotficationsModel.value = model;
        }
      }
    } catch (e) {
      Utils.showToast("Something went wrong. $e", true);
    } finally {
      isLoadingMore = false;
    }
  }

  String getTimeAgo(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) {
      return "";
    }

    try {
      final DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
      final Duration difference = DateTime.now().difference(dateTime);

      if (difference.inSeconds < 60) {
        return "Just now";
      } else if (difference.inMinutes < 60) {
        return "${difference.inMinutes} min${difference.inMinutes > 1 ? 's' : ''}";
      } else if (difference.inHours < 24) {
        return "${difference.inHours} hour${difference.inHours > 1 ? 's' : ''}";
      } else if (difference.inDays < 30) {
        return "${difference.inDays} day${difference.inDays > 1 ? 's' : ''}";
      } else if (difference.inDays < 365) {
        final months = (difference.inDays / 30).floor();
        return "$months month${months > 1 ? 's' : ''}";
      } else {
        final years = (difference.inDays / 365).floor();
        return "$years year${years > 1 ? 's' : ''}";
      }
    } catch (e) {
      return "";
    }
  }
  
  Future<void> enableNotification() async{
    try{
      final response = await baseService.basePatchAPI(ApiEndPoints.notificationSetting, body: {"isNotificationAllowed": true});

      print(response);
      if(response["success"] == true){
        Utils.showToast(response["message"], false);
      } else{
        Utils.showToast(response["message"], true);
      }
    } catch(e) {
      Utils.showToast("Something went wrong. $e", true);
    }
  }


  Future<void> RegisterFCM() async{
    print(fcm);
    try{
      final response = await baseService.basePatchAPI(ApiEndPoints.registerFcm, body: {"fcmToken": fcm});

      print(response);
      if(response["success"] == true){
        Utils.showToast(response["message"], false);
      } else{
        Utils.showToast(response["message"], true);
      }
    } catch(e) {
      Utils.showToast("Something went wrong. $e", true);
    }
  }
}
