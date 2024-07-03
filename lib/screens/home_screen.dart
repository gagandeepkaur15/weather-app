import 'package:flutter/material.dart';
import 'package:go_india_stocks_task/screens/weather_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController cityController;
  String? lastSearchedCity;

  //Fetch the last searched city
  void _loadLastSearchedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lastSearchedCity = prefs.getString('lastSearchedCity');
    });
  }

  //To save the last searched city using shared preferences
  void saveLastSearchedCity(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lastSearchedCity', city);
  }

  @override
  void initState() {
    super.initState();
    cityController = TextEditingController();
    _loadLastSearchedCity();
  }

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        child: ListView(
          children: [
            //Lottie Animation
            SizedBox(
              height: 70.sp,
              width: 70.sp,
              child: Lottie.asset('assets/weather.json'),
            ),
            SizedBox(height: 10.sp),
            Center(
              child: Text(
                'Weather',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Center(
              child: Text(
                'Forecast',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            SizedBox(height: 20.sp),
            TextField(
              controller: cityController,
              style: Theme.of(context).textTheme.bodySmall,
              decoration: const InputDecoration(
                hintText: "Enter city",
              ),
            ),
            SizedBox(height: 15.sp),
            if (lastSearchedCity != null)
              Row(
                children: [
                  Text('Last searched: ',
                      style: Theme.of(context).textTheme.bodySmall),
                  InkWell(
                    onTap: () {
                      //Setting the value in the text field to last searched city
                      setState(() {
                        cityController.text = lastSearchedCity.toString();
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.sp,
                        horizontal: 12.sp,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: Text(
                        lastSearchedCity.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            SizedBox(height: 30.sp),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    //If the textfield is not empty then navigate to next page
                    if (cityController.text.isNotEmpty) {
                      //Saving the last searchedd city
                      saveLastSearchedCity(cityController.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WeatherScreen(
                            city: cityController.text,
                          ),
                        ),
                      ).then((_) {
                        //So that the last searched city is updated when navigating back to this screen
                        _loadLastSearchedCity();
                      });
                    }
                  },
                  child: Text(
                    "Get Weather",
                    style: Theme.of(context).textTheme.labelSmall,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
