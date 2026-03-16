import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventController extends GetxController{
  // Event Controllers
  final TextEditingController eventName = TextEditingController();
  final TextEditingController eventDate = TextEditingController();
  final TextEditingController eventTime = TextEditingController();
  final TextEditingController eventType = TextEditingController();
  final TextEditingController eventLocation = TextEditingController();
  final TextEditingController inviteMsg = TextEditingController();
  final TextEditingController parkingDetails = TextEditingController();
  final TextEditingController addNote = TextEditingController();
  final TextEditingController eventReminder = TextEditingController();
}