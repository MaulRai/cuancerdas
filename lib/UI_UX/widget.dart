import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget simpleText(String text, [double size = 12, Color color = Colors.white]) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      textStyle: TextStyle(
        color: color,
        fontSize: size,
        // fontWeight: FontWeight.w500, // Medium weight for a cool look
        letterSpacing: 1.2, // Slight letter spacing for modern touch
      ),
    ),
  );
}
Widget simpleTextField(TextEditingController ctrl, String hint) {
  return TextField(
    style: TextStyle(color: Colors.white),
    controller: ctrl,
    decoration: InputDecoration(
      filled: true,
      fillColor: Color.fromARGB(255, 54, 66, 80),
      hintText: hint,
      hintStyle: TextStyle(color: Color.fromARGB(255, 162, 162, 162)),
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
    ),
  );
}

Widget aButton({required onPressed, required child, double? width, bool tight = false}){
  return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 22, 66, 143),
              Color.fromARGB(255, 7, 102, 146),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 10),
              blurRadius: 20,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            splashColor: Colors.white.withOpacity(0.3),
            onTap: onPressed,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: tight ? 4 : 12, horizontal: tight ? 8 : 24),
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
}

Widget simpleDropDown(TextEditingController ctrl, List<DropdownMenuEntry<String>> lst ) {
  return SizedBox(
    child: DropdownMenu<String>(
      textStyle: TextStyle(color: Colors.white),
      trailingIcon: Icon(Icons.keyboard_arrow_down),
      menuHeight: 250,
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Color.fromARGB(255, 54, 66, 80),
        isDense: true,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
        constraints: BoxConstraints.tight(const 
             Size.fromHeight(40)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
      ),
      controller: ctrl,
      dropdownMenuEntries: lst,
    ),
  );
}

Widget appTextField({
  TextEditingController? controller,
  String text = "",
  Widget icon = const Icon(Icons.person),
  String hintText = "Type here",
  bool obscureText = false,
}) {
  return Container(
    padding: EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        Container(
          width: 325,
          height: 50,
          decoration: boxDecoration(),
          child: Row(
            children: [
              Container(margin: EdgeInsets.only(left: 12), child: icon),
              Container(
                width: 270,
                height: 45,
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  onChanged: (value) {},
                  maxLines: 1,
                  autocorrect: false,
                  obscureText: obscureText,
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget textUnderLine(String text) {
  return GestureDetector(
    onTap: () {},
    child: Text(text,
        style: TextStyle(fontSize: 12, decoration: TextDecoration.underline)),
  );
}

BoxDecoration boxDecoration() {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.grey));
}

Text warningText(String text) {
  return Text(
    text,
    style: TextStyle(color: Colors.red),
  );
}
