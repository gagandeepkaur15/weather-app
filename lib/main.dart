import 'package:flutter/material.dart';
import 'package:go_india_stocks_task/providers/weather_provider.dart';
import 'package:go_india_stocks_task/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Responsive sizer to make the app responsive
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: ResponsiveSizer(builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'Weather App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
            primarySwatch: Colors.lightBlue,
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
            //Theme of the app
            textTheme: TextTheme(
                labelLarge:
                    GoogleFonts.lato(color: Colors.white, fontSize: 19.sp),
                labelMedium: GoogleFonts.lato(color: Colors.white),
                labelSmall: GoogleFonts.lato(color: Colors.black),
                bodyLarge: GoogleFonts.lato(color: Colors.black),
                bodyMedium:
                    GoogleFonts.lato(color: Colors.black, fontSize: 16.sp),
                bodySmall: GoogleFonts.lato(color: Colors.black)),
          ),
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        );
      }),
    );
  }
}
