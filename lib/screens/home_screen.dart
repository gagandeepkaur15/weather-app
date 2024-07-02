import 'package:flutter/material.dart';
import 'package:go_india_stocks_task/screens/weather_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController cityController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Weather App",
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.sp, vertical: 20.sp),
        child: Column(
          children: [
            SizedBox(height: 20.sp),
            TextField(
              controller: cityController,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: const InputDecoration(
                hintText: "Enter city",
              ),
            ),
            SizedBox(height: 20.sp),
            ElevatedButton(
                onPressed: () {
                  //If the textfield is not empty then navigate to next page
                  if (cityController.text.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WeatherScreen(
                          city: cityController.text,
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  "Get Weather",
                  style: Theme.of(context).textTheme.labelSmall,
                ))
          ],
        ),
      ),
    );
  }
}
