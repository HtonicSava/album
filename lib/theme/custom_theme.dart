import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme with ChangeNotifier{
  static bool _isDarkTheme = false;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static Color? get tapBarIndicatorColor {
    return const Color(0xFFDB8677);
  }
  static ThemeData get lightTheme {
    return ThemeData(
        // canvasColor: Colors.transparent,
        buttonTheme: ButtonThemeData(

        ),
        indicatorColor: const Color(0xFFDB8677),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedIconTheme: IconThemeData(
              color: Color(0xFFBBAFA6)

          ),
          selectedIconTheme: IconThemeData(
              color: Color(0xFFDB8677)
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFFFAE4D4)
        ),
        //secondary устанавливает цвет эффекта окончания скрола
        colorScheme:  const ColorScheme.light(primary: Color(0xFFFFF5EE),secondary: Color(0xFFDB8677), secondaryVariant: Color(0xFFFAE4D4)),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          foregroundColor: Color(0xFFBBAFA6),
        // backgroundColor: Color(0xFFFDF0E7),
      ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(primary: Colors.black)
        ),
        inputDecorationTheme: const InputDecorationTheme(
            suffixStyle: TextStyle(
              color: Color(0xFFBBAFA6),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color(0xFFFAE4D4)
              ),
            )
        ),

        textTheme: GoogleFonts.montserratTextTheme(

        ),
        tabBarTheme: TabBarTheme(
          labelStyle: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF303030)
          ),
            unselectedLabelStyle: GoogleFonts.montserrat()
        ),


    );
  }
  // static ThemeData get darkTheme {
  //   return ThemeData(
  //
  //     indicatorColor: const Color(0xFFC4A4DE),
  //     bottomNavigationBarTheme: const BottomNavigationBarThemeData(
  //
  //       showSelectedLabels: false,
  //       showUnselectedLabels: false,
  //       unselectedIconTheme: IconThemeData(
  //           color: Color(0xFFCECDEF)
  //
  //       ),
  //       selectedIconTheme: IconThemeData(
  //           color: Color(0xFFA7A5DF)
  //       ),
  //     ),
  //     iconTheme: const IconThemeData(
  //         color: Color(0xFFDFDFF4)
  //     ),
  //     //secondary устанавливает цвет эффекта окончания скрола
  //     colorScheme:  const ColorScheme.light(primary: Color(0xFFF2F2FA),secondary: Color(0xFFC4A4DE), secondaryVariant: Color(0xFFDEA4D0)),
  //     appBarTheme: const AppBarTheme(
  //       elevation: 0,
  //       foregroundColor: Color(0xFFBBAFA6),
  //       // backgroundColor: Color(0xFFFDF0E7),
  //     ),
  //     textButtonTheme: TextButtonThemeData(
  //         style: TextButton.styleFrom(primary: Colors.black)
  //     ),
  //     inputDecorationTheme: const InputDecorationTheme(
  //         suffixStyle: TextStyle(
  //           color: Color(0xFFCECDEF),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderSide: BorderSide(
  //               color: Color(0xFFA7A5DF)
  //           ),
  //         )
  //     ),
  //
  //     textTheme: GoogleFonts.montserratTextTheme(
  //
  //     ),
  //     tabBarTheme: TabBarTheme(
  //         labelStyle: GoogleFonts.montserrat(
  //             fontSize: 18,
  //             fontWeight: FontWeight.w400,
  //             color: const Color(0xFF303030)
  //         ),
  //         unselectedLabelStyle: GoogleFonts.montserrat()
  //     ),
  //
  //
  //   );
  // }
  static ThemeData get darkTheme {
    return ThemeData(

      indicatorColor: const Color(0xFFEDC68B),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(

        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedIconTheme: IconThemeData(
            color: Color(0xFFF6DFBD)

        ),
        selectedIconTheme: IconThemeData(
            color: Color(0xFFEDC68B)
        ),
      ),
      iconTheme: const IconThemeData(
          color: Color(0xFFF9E7CD)
      ),
      //secondary устанавливает цвет эффекта окончания скрола
      //secondaryVariant - левая часть кнопки
      colorScheme:  const ColorScheme.light(primary: Color(0xFFFAEFE0),secondary: Color(0xFFEDC68B), secondaryVariant: Color(
          0xFFF5E9D4)),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        foregroundColor: Color(0xFFBBAFA6),
        // backgroundColor: Color(0xFFFDF0E7),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(primary: Colors.black)
      ),
      inputDecorationTheme: const InputDecorationTheme(
          suffixStyle: TextStyle(
            color: Color(0xFFBBAFA6),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color(0xFFEDC68B)
            ),
          )
      ),

      textTheme: GoogleFonts.montserratTextTheme(

      ),
      tabBarTheme: TabBarTheme(
          labelStyle: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF303030)
          ),
          unselectedLabelStyle: GoogleFonts.montserrat()
      ),


    );
  }

}

