import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YesGptController extends GetxController{
  var isMsgSend = false.obs;
  var hostMsg = "".obs;
  var aiResponseOne = "Got it 👍 To design a menu of 5 dishes for 35 guests (including 5 kids), I’ll balance taste, dietary needs, and variety. Since you mentioned preferences and allergies but didn’t specify them yet, I’ll create a safe, general menu that avoids the most common allergens (nuts, shellfish, excessive spice) and offers options for kids, vegetarians, and meat lovers.".obs;
  var aiResponseTwo = """
🍽️ Suggested Menu (5 Dishes)

1. Grilled Lemon Herb Chicken (Gluten-free, nut-free)  
   • Lightly marinated chicken breasts with lemon, herbs, and olive oil.  
   • Easy for adults and kids, mild seasoning.  

2. Baked Macaroni & Cheese (Kid-Friendly Option)  
   • Creamy baked mac and cheese with optional breadcrumb topping.  
   • Portion can be separated for kids (without strong seasoning).  

3. Vegetable & Chickpea Curry (Vegan/Gluten-Free)  
   • Mild curry with coconut milk, chickpeas, and seasonal veggies.  
   • Served with steamed rice for a hearty vegetarian/vegan option.  

4. Mediterranean Salad Bowl  
   • Cucumber, tomato, lettuce, olives, and feta (cheese optional).  
   • Dressing served on the side so guests can choose.  

5. Mini Fruit & Dessert Cups  
   • Fresh fruit cups + small portion of chocolate mousse (in separate cups).  
   • Kids love fruit, and adults get a sweet bite without it being too heavy.  
""".obs;

  var showFirst = true.obs;
  var showSecond = false.obs;
  TextEditingController msgController = TextEditingController();
  void toggleMsgSend() {
    hostMsg.value = msgController.text; // 👈 jab send karo, update ho jaye
    isMsgSend.value = true;
  }

  final List<String> yesGptOptions = [
    "📜 Menu Suggestion",
    "😷 Allergy Precautions",
    "⛅ Weather suited cuisine",
    "👶🏻 Kids Entertainment",
    "🍰 Deserts menu",
    "More",
  ];
}
