import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/constants/constants_widgets.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/controllers/profile_controller.dart';

import '../../../utils/utility.dart';
import '../../../widget/loading_step_indicator.dart';
import '../../../widget/privacy_dialog.dart';

class ProfileEditScreen extends StatelessWidget {
  ProfileEditScreen({super.key});
  final NavigationController navigationController = Get.find<NavigationController>();
  final ProfileController controller = Get.find<ProfileController>();
  // final List<Map<String, String>> users = [
  //   {
  //     'title' : 'Name'
  //   },
  //   {
  //     'title' : 'Username'
  //   },
  //   {
  //     'title' : 'Emails'
  //   },
  //   {
  //     'title' : 'Pronouns'
  //   },
  //   {
  //     'title' : 'Location'
  //   },
  //   {
  //     'title' : 'Bio'
  //   }
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor,
      body: Column(
        children: [
          SafeArea(
            child: navigationController.isUser.value == true ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Get.toNamed("bottomnavigationbar");
                    },
                    child: customText(
                      text: "Cancel",
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: whiteColor
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Column(
                    children: [
                      customText(
                        text: "Set Your Table",
                        fontWeight: FontWeight.w700,
                        fontSize: 20.sp,
                        fontFamily: "CormorantGaramond",
                          color: whiteColor
                      ),
                      customText(
                        text: "Your seat at the table starts here!",
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                          color: whiteColor
                      ),
                    ],
                  ),
                  SizedBox(width: 1.w),
                  InkWell(
                    onTap: (){
                      controller.isPreferences.value = false;
                      print(controller.isPreferences.value);
                      Get.toNamed('allergiesdietryscreen');
                    },
                    child: customText(
                        text: "Continue",
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: whiteColor
                    ),
                  ),

                ],
              ),
            ):Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Get.toNamed("bottomnavigationbar");
                    },
                    child: customText(
                        text: "Cancel",
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: whiteColor
                    ),
                  ),
                  SizedBox(width: 6.w),
                  customText(
                      text: "Edit Profile",
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                      fontFamily: "CormorantGaramond",
                      color: whiteColor
                  ),
                  SizedBox(width: 1.w),
                  InkWell(
                    onTap: (){
                      Get.toNamed('bottomnavigationbar');
                    },
                    child: customText(
                        text: "Continue",
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: whiteColor
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.sp),
                  topRight: Radius.circular(30.sp),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
                      child: navigationController.isUser.value == true ? loadingStepIndicator("1/6", 0.08):loadingStepIndicator("2/3", 0.3),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.sp), // Apply the same border radius here
                      child: Container(
                        height: 13.h,
                        width: 26.w,
                        child: Image.asset("assets/png/girl_profile.png", fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    customText(
                        text: "Polish Your Profile",
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                        color: blueColor
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align columns to the top
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 7.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ListView.builder(
                              //     itemCount: users.length,
                              //     itemBuilder: (context,index){
                              //       final user = users[index];
                              //       return customText(
                              //         text: user['title'],
                              //         fontWeight: FontWeight.w500,
                              //         fontSize: 15.sp,
                              //       );
                              //     }
                              // ),
                              customText(
                                text: "Name",
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                              ),
                              SizedBox(height: 1.8.h),
                              customText(
                                text: "Username",
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                              ),
                              SizedBox(height: 1.8.h),
                              customText(
                                text: "Emails",
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                              ),
                              SizedBox(height: 1.9.h),
                              customText(
                                text: "Pronouns",
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                              ),
                              SizedBox(height: 14.3.h),
                              customText(
                                text: "Location",
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                              ),
                              SizedBox(height: 2.h),
                              customText(
                                text: "Bio",
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText(
                                text: "Sarah Scarnio!",
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                              ),
                              const Divider(),
                              customText(
                                text: "Sarah_scarnio01",
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                              ),
                              const Divider(),
                              customText(
                                text: "Sarahscarnio@gmail.com",
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                              ),
                              const Divider(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // customText(
                                  //   text: "He, She, They, Them, Him, Her",
                                  //   fontWeight: FontWeight.w400,
                                  //   fontSize: 15.sp,
                                  //   color: Colors.grey,
                                  // ),
                                  SizedBox(height: 0.5.h,),
                                  pronounList(),
                                  SizedBox(height: 0.8.h,),
                                  const Divider(height: 0,),
                                  SizedBox(height: 0.2.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      customText(
                                        text: "Show This on My Profile",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp,
                                      ),
                                      Transform.scale(
                                        scale: 7.w / 50,
                                        child: Obx(() => CupertinoSwitch(
                                          activeTrackColor: blackColor,
                                          value: controller.switchValue.value,
                                          onChanged: (val) => controller.toggleSwitch(val),
                                        )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 0.2.h,),

                                  const Divider(
                                    height: 0,
                                  ),
                                ],
                              ),
                              SizedBox(height: 0.8.h,),

                              customText(
                                text: "📍   New York",
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                              ),
                              const Divider(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText(
                                    text: "✏️   ",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.sp,
                                  ),
                                  Expanded(
                                    child: customText(
                                      text: "Dog mom, dairy-free diva,\nalways RSVPs yes.",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // Padding(
                        //   padding: EdgeInsets.only(left: 5.w),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       customText(
                        //         text: "Set a Place for Someone Else",
                        //         fontWeight: FontWeight.w500,
                        //         fontSize: 17.sp,
                        //         color: greenColor
                        //       ),
                        //       Container(
                        //         //padding: EdgeInsets.symmetric(vertical: 0.2.h, horizontal: 0.2.h),
                        //         margin: EdgeInsets.only(right: 4.w),
                        //         height: 3.h,
                        //         width: 6.5.w,
                        //         decoration: BoxDecoration(
                        //           color: Colors.black,
                        //           shape: BoxShape.circle
                        //         ),
                        //         child: Icon(Icons.add, color: Colors.white, size: 17.sp,),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        Obx(() =>
                          navigationController.isUser.value == true ?
                          Column(
                            children: [
                              Divider(),
                              SizedBox(height: 0.7.h),
                              Padding(
                                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                                child: Column(
                                  children: [

                                    /// ================= HEADER =================
                                    Obx(() => Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        customText(
                                          text: "Set a Place for Someone Else",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17.sp,
                                          color: greenColor,
                                        ),

                                        InkWell(
                                          onTap: () => controller.isPlaceExpanded.toggle(),
                                          child: Container(
                                            height: 3.h,
                                            width: 6.5.w,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              controller.isPlaceExpanded.value
                                                  ? Icons.remove
                                                  : Icons.add,
                                              color: Colors.white,
                                              size: 17.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),

                                    /// ================= EXPANDABLE CONTENT =================
                                    Obx(() => AnimatedCrossFade(
                                      firstChild: SizedBox.shrink(),
                                      secondChild: Padding(
                                        padding: EdgeInsets.only(top: 1.h),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            /// 🔹 MULTIPLE SET PLACE FORMS
                                            Obx(() => Column(
                                              children: [
                                                // Pehla form hamesha show
                                                setPlace(0),

                                                // Second form tabhi show jab pehla complete ho
                                                if (controller.places.length > 1 && controller.placeCompleted[0])
                                                  setPlace(1),

                                                // Third form tabhi show jab second complete ho
                                                if (controller.places.length > 2 && controller.placeCompleted[1])
                                                  setPlace(2),

                                                // Fourth form tabhi show jab third complete ho
                                                if (controller.places.length > 3 && controller.placeCompleted[2])
                                                  setPlace(3),
                                              ],
                                            )),

                                            SizedBox(height: 1.5.h),

                                            /// 🔹 ADD MORE BUTTON
                                            if (controller.places.length < 4)
                                              InkWell(
                                                onTap: () {
                                                  int lastIndex = controller.places.length - 1;

                                                  // Check if previous form is completed
                                                  if (!controller.placeCompleted[lastIndex]) {
                                                    Utils.showToast("Please complete previous form first", false);
                                                    return;
                                                  }

                                                  // Add new form
                                                  controller.places.add(controller.places.length);
                                                  controller.placeCompleted.add(false); // new form initially not completed
                                                },
                                                child: Row(
                                                  children: [
                                                    SizedBox(width: 23.w),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: greenColor,
                                                      ),
                                                      padding: EdgeInsets.all(0.5.w),
                                                      child: Icon(
                                                        Icons.add,
                                                        size: 14.sp,
                                                        color: whiteColor,
                                                      ),
                                                    ),
                                                    SizedBox(width: 2.w),
                                                    customText(
                                                      text: 'Add more',
                                                      fontSize: 15.5.sp,
                                                      fontWeight: FontWeight.w500,
                                                      color: greenColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      crossFadeState: controller.isPlaceExpanded.value
                                          ? CrossFadeState.showSecond
                                          : CrossFadeState.showFirst,
                                      duration: Duration(milliseconds: 300),
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ): SizedBox.shrink(),
                        ),





                        SizedBox(height: 0.7.h),
                        navigationController.isUser.value == true ? SizedBox.shrink():
                        Column(
                          children: [
                            Divider(),
                            Padding(
                              padding: EdgeInsets.only(left: 5.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  customText(
                                      text: "I'm Hosting!",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17.sp,
                                      color: greenColor
                                  ),
                                  Transform.scale(
                                    scale: 7.w / 50,
                                    child: Obx(() => CupertinoSwitch(
                                      activeTrackColor: blackColor,
                                      value: controller.switchValue2.value,
                                      onChanged: (val) => controller.toggleSwitch2(val),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        SizedBox(height: 0.7.h),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: customText(
                              text: "More About You",
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                              color: greenColor
                          ),
                        ),
                        SizedBox(height: 0.7.h),
                        Divider(),
                        SizedBox(height: 0.7.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 6.w,),
                            Obx(() =>
                                InkWell(
                                  onTap: (){
                                    if (!controller.isSelected.value) {
                                      privacyDialog(context);
                                    } else {
                                      // Checkbox is TRUE → just uncheck
                                      controller.checkBox();
                                    }
                                  },
                                  child: Container(
                                    height: 3.h,
                                    width: 4.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: controller.isSelected == false ? Colors.white : radioButtonBlueColor,
                                    ),
                                    child: Icon(Icons.check, size: 14.sp, color: Colors.white,),
                                  ),
                                ),
                            ),

                            SizedBox(width: 2.w),
                            customText(
                              text: 'I Agree To All',
                              fontSize: 14.sp,
                            ),
                            SizedBox(width: 1.w),
                            // Policy text with underline
                            InkWell(
                              onTap: () {
                                // handle Policy click
                              },
                              child: customText(
                                text: 'Policy',
                                fontSize: 14.sp,
                                  txtDecoration: TextDecoration.underline,
                                height: 0.1.h,
                              ),
                            ),
                            SizedBox(width: 1.w),
                            customText(
                              text: '&',
                              fontSize: 14.sp,
                            ),
                            SizedBox(width: 1.w),
                            // Terms of Condition text with underline
                            InkWell(
                              onTap: () {
                                // handle Terms click
                              },
                              child: customText(
                                text: 'Terms Of Condition',
                                fontSize: 14.sp,
                                txtDecoration: TextDecoration.underline,
                                height: 0.1.h,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 6.h),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// List of pronouns
final List<String> pronouns = ['He/Him', 'She/Her', 'They/Them', 'Custom'];

// Widget
Widget pronounList() {
  return ListView.builder(
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: pronouns.length,
    itemBuilder: (context, index) {
      return Column(
        children: [
          pronounItem(pronouns[index], index),
          SizedBox(height: 0.4.h),
        ],
      );
    },
  );
}

// Pronoun item with selection logic
Widget pronounItem(String title, int index){
  ProfileController controller = Get.find<ProfileController>();
  return Obx(() => InkWell(
    onTap: () => controller.updatePronounIsSelected(index),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(0.6.w),
          height: 1.8.h,
          width: 4.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: controller.pronounIsSelected.value == index
                  ? radioButtonBlueColor
                  : Colors.white, // border grey if not selected
              width: 1.5, // optional border width
            ),
          ),
          child: controller.pronounIsSelected.value == index
              ? Container(
            height: 1.h,
            width: 1.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: radioButtonBlueColor,
            ),
          )
              : SizedBox.shrink(),
        ),
        SizedBox(width: 1.5.w),
        customText(
          text: title,
        ),
      ],
    ),
  ));
}
Widget setPlace(int index,{String? title}) {
  final ProfileController controller = Get.find<ProfileController>();
  return Padding(
    padding: EdgeInsets.only(bottom: 1.5.h),
    child: Column(
      children: [

        /// 🔹 Divider & spacing ONLY for 2nd+ forms
        if (index > 0) ...[
          SizedBox(height: 1.h),
          Divider(thickness: 0.4),
          SizedBox(height: 1.h),
        ],

        /// ================= NAME =================
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customText(
              text: 'Name',
              fontSize: 15.5.sp,
            ),
            SizedBox(width: 13.w),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Robert Elbert',
                  hintStyle: TextStyle(
                    fontFamily: 'CormorantGaramond',
                    fontSize: 15.sp,
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 1.3.h),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.6),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.6),
                  ),
                  suffixIcon: index == 0
                      ? null // first item cannot be deleted
                      : InkWell(
                    onTap: () {
                      controller.places.removeAt(index);
                    },
                    child: Icon(
                      Icons.delete,
                      size: 18.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 0.8.h),

        /// ================= RELATION (Plain TextField, no dropdown) =================
        Row(
          children: [
            customText(
              text: 'Relation',
              fontSize: 15.5.sp,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Son',
                  hintStyle: TextStyle(
                    fontFamily: 'CormorantGaramond',
                    fontSize: 15.sp,
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 1.2.h),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.6),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.6),
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 0.8.h),

        /// ================= AGE =================
        Row(
          children: [
            customText(
              text: 'Age',
              fontSize: 15.5.sp,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '15',
                  hintStyle: TextStyle(
                    fontFamily: 'CormorantGaramond',
                    fontSize: 15.sp,
                    height: 1.8,
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 0.8.h),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.6),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.6),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        InkWell(
          onTap: (){
            controller.setData(
            index: index,
            screenTitle: title ?? "Robert",
            );
            controller.isPreferences.value = true;
            print(controller.isPreferences.value);
            Get.toNamed('allergiesdietryscreen',);
  },

          child: Container(
            decoration: BoxDecoration(
              color: greenColor,
              borderRadius: BorderRadius.circular(20.sp),
              border: Border.all(
                width: 0.1.w,
                color: greenColor
              )
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.5.w,vertical: 0.3.h),
              child: customText(
                text: "Set Preferences",
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: whiteColor
              ),
            ),
          ),
        ),

      ],
    ),
  );
}



