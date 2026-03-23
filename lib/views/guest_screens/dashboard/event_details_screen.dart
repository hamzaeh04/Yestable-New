import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/widget/foodpreference_yesno_widget.dart';
import 'package:yestable/widget/home_screen_widget.dart';
import '../../../constants/constants_widgets.dart';
import '../../../widget/event_accesibility_widget.dart';

class EventDetailsScreen extends StatelessWidget {
  EventDetailsScreen({super.key});
final NavigationController controller = Get.find<NavigationController>();


  final List<Map<String, String>> eventMenu = [
    {"name": "Vegetarian", "imgPath": "assets/png/event_food_image/brocolli.png"},
    {"name": "Contain Dairy", "imgPath": "assets/png/event_food_image/milk.png"},
    {"name": "Gluten-Free", "imgPath": "assets/png/event_food_image/glutenfree.png"},
    {"name": "Shelfish", "imgPath": "assets/png/event_food_image/shell.png"},
    {"name": "Vegan", "imgPath": "assets/png/event_food_image/shell.png"},
    {"name": "Nut-Free", "imgPath": "assets/png/event_food_image/nutfree.png"},
  ];

  final List<String> notAllowedItem = ["Bubble gum", "Drug"];
  final List<String> eventMenuList = ["Vegetarian", "Contain Dairy","Gluten-Free","Shelfish","Vegan","Nut-Free"];
  List<String> eventAccesibilityList = [];
  @override
  Widget build(BuildContext context) {
    if (controller.isUser.value == false) {
      eventAccesibilityList = [
        "Quiet Space Available",
        "Larger Seating",
        "Wheelchair Accessible",
        "ASL Interpreter",
        "Vegan Option",
        "Halal",
        "Kosher",
        "Keto",
        "Family Restroom",
        "Pets Allowed",
        "Gluten-Free",
        "Smoke Present",
        "There Are Steps To Climb",
        "Swimming Pool Is Present",
        "Firearms Are Present",
        "Shellfish Will Be Served",
        "Peanuts Present",
        "Event Ends At A Time",
      ];
    } else {
      eventAccesibilityList = [
        "Quiet Space Available",
        "Larger Seating",
        "Wheelchair Accessible",
        "ASL Interpreter",
        "Vegan Option",
        "Halal",
        "Kosher",
        "Keto",
        "Family Restroom",
        "Pets Allowed",
        "Gluten-Free",
        "Smoke Present",
        "There Are Steps To Climb",
        "Swimming Pool Is Present",
        "Firearms Are Present",
        "Peanuts Present",
      ];
    }
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/png/event_screen_banner.png',
                  height: 35.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: "Gizelle Dinner Event",
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: "CormorantGaramond",
                        color: blackColor,
                      ),

                      SizedBox(height: 0.5.h),
                      customText(
                        text:
                            "Lorem ipsum dolor sit amet consectetur. Viverra tellus\neget magna sapien. Faucibus nibh mauris mattis aliquam\nproin pellentesque sed done.",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: darkGreyColor,
                      ),
                      SizedBox(height: 1.h),
                    ],
                  ),
                ),

                Divider(),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: "Invitation Message",
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: "CormorantGaramond",
                        color: blackColor,
                      ),

                      SizedBox(height: 0.5.h),
                      customText(
                        text:
                        "With hearts full of joy, we invite you to join us in celebrating the first birthday of our beloved [Baby’s Name]. This special milestone means so much to us, and your presence will make the day even more memorable.",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: darkGreyColor,
                      ),
                      SizedBox(height: 1.h),
                    ],
                  ),
                ),
                Divider(),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      childrenPadding: EdgeInsets.only(bottom: 1.h),
                      dense: true,
                      title: Row(
                        children: [
                          Expanded(
                            child: customText(
                              text: "Event Comfort & Accessibility",
                              fontSize: 18.5.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "CormorantGaramond",
                              color: blackColor,
                              maxLines: 1,
                              overFlow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      children: [
                        // Event Accessibility List
                        Wrap(
                          spacing: 5,
                          runSpacing: 1,
                          children: List.generate(
                            eventAccesibilityList.length,
                                (index) => eventAccesibillityWidget(
                              eventAccesibilityList[index],
                            ),
                          ),
                        ),

                        Divider(),

                        // Items Are Not Allowed Section
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText(
                                    text: "Items Are Not Allowed",
                                    fontSize: 18.5.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "CormorantGaramond",
                                    color: blackColor,
                                    maxLines: 1,
                                    overFlow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 1.h),
                                  Wrap(
                                    spacing: 5,
                                    runSpacing: 1,
                                    alignment: WrapAlignment.start,
                                    children: List.generate(
                                      notAllowedItem.length,
                                          (index) => eventAccesibillityWidget(
                                        notAllowedItem[index],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),


                Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: InkWell(
                    onTap: (){
                      Get.toNamed("hostprofilepcreen");
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/png/chat_images/user1.png",
                          height: 9.h,
                          width: 14.w,
                        ),
                        SizedBox(width: 3.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText(
                              text: "Gizelle Jekronia",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: blackColor,
                            ),
                            SizedBox(height: 0.1.h),
                            customText(
                              text: "Event Host",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: blackColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 0.9.h),
                        child: Image.asset(
                          "assets/png/icons/round_watch.png",
                          height: 2.h,
                          width: 4.w,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        customText(
                          text: "May 02, 2025",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: blackColor,
                          height: 0.1.h,
                        ),
                            SizedBox(height: 0.5.h),
                        customText(
                          text: "7:30 PM - 9:00 PM",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: darkGreyColor,
                        ),
                      ]),
                    ],
                  ),
                ),
                SizedBox(height: 1.5.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/png/icons/map_location_icon.png",
                        height: 2.h,
                        width: 4.w,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            customText(
                              text: "IN HOUSES",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: blackColor,
                              height: 0.1.h,
                            ),
                            SizedBox(height: 0.5.h),
                            customText(
                              text: "New York, USA",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: darkGreyColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  width: double.infinity,
                  color: eventDinnerBrownColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                          text: "25 People Are Coming",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: blackColor,
                          fontFamily: "CormorantGaramond",
                        ),
                        SizedBox(height: 1.h),
                        SizedBox(
                          height: 4.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 9,
                            separatorBuilder: (_, __) => SizedBox(width: 2.w),
                            itemBuilder: (_, index) {
                              final image = Image.asset(
                                'assets/png/chat_images/user${(index%5) + 1}.png',
                                width: 3.8.h,
                                height: 4.h,
                                fit: BoxFit.cover,
                              );

                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10.sp),
                                child: Stack(
                                  children: [
                                    image,
                                    if (index == 8)
                                      Positioned.fill(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(0.4),
                                          ),
                                          child: Center(
                                            child: customText(
                                                text: "10+",
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: whiteColor,
                                                fontFamily: "WorkSans2"
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: "Where You’ll Be",
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: "CormorantGaramond",
                        color: blackColor,
                      ),
                      customText(
                        text: "132 My Street, Kingston, New York 12486.",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: darkGreyColor,
                      ),
                      SizedBox(height: 1.h),
                      Container(
                        child: Image.asset("assets/png/event_detail_img/event_detial_map.png"),
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/png/icons/round_watch.png", width: 3.w,),
                          SizedBox(width: 1.w,),
                          Column(
                            children: [
                              customText(
                                text: 'Parking Details',
                                fontSize: 18.sp,
                                fontFamily: 'CormorantGaramond'
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 4.w,),
                          customText(
                            text: 'Street parking after 6pm; lot behind venue.',
                            fontSize: 14.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.h),
                Divider(),
                SizedBox(height: 1.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: "Event Menu",
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: "CormorantGaramond",
                        color: blackColor,
                      ),
                      customText(
                        text: "See dishes made for you - no stress, just great food",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: darkGreyColor,
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText(
                            text: "Your Dietry Compactibility Score",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: greenColor,
                          ),
                          customText(
                            text: "95%",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: greenColor,
                          ),
                        ],
                      ),

                      SizedBox(height: 1.h),
                      LinearProgressIndicator(
                        backgroundColor: whiteColor, // Track color
                        color: greenColor,            // Progress color
                        value: 0.95,
                        minHeight: 0.7.h,
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      SizedBox(height: 1.5.h),
                      controller.isUser.value ?
                      Wrap(
                        spacing: 4,
                        runSpacing: 0,
                        children: List.generate(
                          eventMenu.length,
                              (index) => foodPreferencesOne(
                            index + 1, // Serial number
                            eventMenu[index]['name'] ?? '', // Name
                            imgpath: eventMenu[index]['imgPath'] ?? '', // Optional image path
                          ),
                        ),
                      )
                          :
                      DefaultTabController(
                        length: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TabBar(
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: Colors.black,
                              indicatorWeight: 2,
                              tabs: const [
                                Tab(text: "Appetizers"),
                                Tab(text: "Main Course"),
                                Tab(text: "Drinks"),
                              ],
                            ),
                            SizedBox(height: 1.h),
                            Column(
                              children: [
                            menuItem(
                            title: "Caprese Skewers",
                              subtitle: "Cherry Tomatoes, Fresh Mozzarella,Basil, Balsamic Glaze",
                              imagePath: "assets/png/event_detail_img/event1.png", // apna image path set karo// Even indexes will show edit icon
                              text1: "Vegetarian",
                              text2: "Containt Dairy",
                                boximg1: "assets/png/event_food_image/brocolli.png",
                                boximg2: "assets/png/event_food_image/milk.png",
                                containerColor: backgroundColor
                            ),
                                Divider(),
                                menuItem(
                                  title: "Avocado Shrimp Ceviche",
                                  subtitle: "Shrimp, Avocado, Lime, Red Onion,Cilantro, Tomato",
                                  imagePath: "assets/png/event_detail_img/event2.png", // apna image path set karo// Even indexes will show edit icon
                                    text1: "Gluten Free",
                                    text2: "Shellfish",
                                  boximg1: "assets/png/event_food_image/glutenfree.png",
                                  boximg2: "assets/png/event_food_image/shell.png",
                                  containerColor: backgroundColor
                                ),
                                Divider(),
                                menuItem(
                                  title: "Spiced Chickpea Falafel",
                                  subtitle: "Chickpeas, Garlic, Cumin, Parsley,Tahini Dip",
                                  imagePath: "assets/png/event_detail_img/event3.png", // apna image path set karo// Even indexes will show edit icon
                                    text1: "Vegen",
                                    text2: "Nut Free",
                                    boximg1: "assets/png/event_food_image/vegan.png",
                                    boximg2: "assets/png/event_food_image/nutfree.png",
                                    containerColor: backgroundColor
                                ),
                                Divider(),
                                menuItem(
                                  title: "Stuffed Mushrooms",
                                  subtitle: "Cremini Mushrooms, Cream Cheese,Garlic, Breadcrumbs",
                                  imagePath: "assets/png/event_detail_img/event1.png", // apna image path set karo// Even indexes will show edit icon
                                    text1: "Vegetarian",
                                    text2: "Containt Dairy",
                                    boximg1: "assets/png/event_food_image/glutenfree.png",
                                    boximg2: "assets/png/event_food_image/milk.png",
                                    containerColor: backgroundColor
                                ),
                                Divider(),
                                menuItem(
                                  title: "Mango Salsa & Chips",
                                  subtitle: "Mango, Red Bell Pepper, Jalapeño, Lime,Corn Tortilla Chips",
                                  imagePath: "assets/png/event_detail_img/event2.png", // apna image path set karo// Even indexes will show edit icon
                                    text1: "Gluten Free",
                                    text2: "Shellfish",
                                    boximg1: "assets/png/event_food_image/vegan.png",
                                    boximg2: "assets/png/event_food_image/milk.png",
                                    containerColor: backgroundColor
                                ),
                                Divider(),
                              ]
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
              ],
            ),
          ),

          Positioned(
            top: 7.h,
            left: 5.w,
            child: homeIconWidget(
              icon: Icons.arrow_back_ios_new,
              iconsize: 16.sp,
              color: lightgreenColor.withAlpha(250),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    // ✅ Reactive FloatingActionButton
    floatingActionButton: Obx(() => controller.isUser.value == false
    ? FloatingActionButton(
    backgroundColor: blueColor,
    onPressed: () {
    Get.toNamed("createneweventscreen");
    },
    child: Image.asset("assets/png/icons/event_floating_icon.png",height: 17.sp),
    )
        : SizedBox.shrink(), // 👈 returns nothing if false
    ));
  }
}
Widget reveiwWidget(BuildContext context) {
  return GestureDetector(
    onTap: (){
    },
    child: Container(
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(
          color: Colors.grey.shade300, // Slight grey border
          width: 1,                     // Thin border
        ),
        borderRadius: BorderRadius.circular(15.sp), // Optional: rounded corners
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                RatingBarIndicator(
                  rating: 4.7,
                  itemCount: 5,
                  itemSize: 18.sp,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
                SizedBox(width: 2.w),
                customText(
                  text: "2 week ago",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: darkGreyColor,
                ),
              ],
            ),
            SizedBox(height: 1.h),
            customText(
              text: "The host swapped nut for seeds in desserts.\nloved it!",
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: darkGreyColor,
            ),
            SizedBox(height: 1.h),
            Row(
              children: [
                CircleAvatar(
                  radius: 18.sp, // Adjust size as needed
                  backgroundImage: AssetImage('assets/png/chat_images/user1.png'), // Replace with your image path
                  backgroundColor: Colors.grey[200], // Optional: fallback color
                ),
                SizedBox(width: 2.w),
                customText(
                  text: "Sarah Jhonson",
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "CormorantGaramond",
                  color: blackColor,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget menuItem({
  required String title,
  required String subtitle,
  required String imagePath,
  required String text1,
  required String text2,
  required String boximg1,
  required String boximg2,
  bool? cheaque,
  Color? containerColor,
  VoidCallback? ontap,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 0.5.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 0.8.h,),
              customText(
                text: title,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                fontFamily: "CormorantGaramond",
                color: blackColor,
              ),
              SizedBox(height: 0.h),
              customText(
                text: subtitle,
                fontSize: 14.sp,
                color: darkGreyColor,
              ),
              SizedBox(height: 1.5.h),
              Row(
                children: [
                  if (text1.isNotEmpty) foodPreferenceBox(text: text1, imgPath: boximg1, bgColor: containerColor),
                  if (text1.isNotEmpty && text2.isNotEmpty) SizedBox(width: 3.w),
                  if (text2.isNotEmpty) foodPreferenceBox(text: text2, imgPath: boximg2, bgColor: containerColor),
                ],
              )
            ],
          ),
        ),
        SizedBox(width: 3.w),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(2.w),
              child: imagePath.startsWith('http')
                  ? Image.network(
                      imagePath,
                      height: 13.h,
                      width: 12.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 13.h, width: 12.h, color: Colors.grey[200], child: Icon(Icons.error)
                      ),
                    )
                  : Image.asset(
                      imagePath.isNotEmpty ? imagePath : 'assets/png/event_detail_img/event1.png',
                      height: 13.h,
                      width: 12.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 13.h, width: 12.h, color: Colors.grey[200], child: Icon(Icons.error)
                      ),
                    ),
            ),
            if (cheaque == true)
              Positioned(
                bottom: 1.h,
                right: 1.w,
                child: Container(
                  height: 3.h,
                  width: 3.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                      )
                    ],
                  ),
                  child: Icon(
                    Icons.remove,
                    size: 2.h,
                    color: Colors.black,
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );
}
Widget foodPreferenceBox({
  required String text,
  required String imgPath,
  Color? bgColor,
}) {
  return InkWell(
    onTap: (){
      print(bgColor);
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.8.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30.w),
        border: Border.all(
          color: Colors.grey, // 👈 Grey border color
          width: 0.1.w,
        )
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (imgPath.isNotEmpty)
            Image.asset(
              imgPath,
              height: 16.sp,
              width: 16.sp,
              fit: BoxFit.contain,
            ),
          if (imgPath.isNotEmpty) SizedBox(width: 2.w),
          Flexible(
            child: customText(
              text: text,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              overFlow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}

