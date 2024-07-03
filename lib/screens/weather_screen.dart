import 'package:flutter/material.dart';
import 'package:go_india_stocks_task/models/weather_model.dart';
import 'package:go_india_stocks_task/widgets/gradient_container.dart';
import 'package:provider/provider.dart';
import 'package:go_india_stocks_task/providers/weather_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../utils/general_utils.dart';

class WeatherScreen extends StatefulWidget {
  final String city;
  const WeatherScreen({super.key, required this.city});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    _fetchWeather();
    super.initState();
  }

  //Method to fetch weather data from the weather provider
  void _fetchWeather() {
    context.read<WeatherProvider>().fetchWeather(widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            //Back Button
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            Text(
              "Weather",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const Spacer(),
            //Refresh Button
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _fetchWeather,
              color: Colors.white,
            ),
          ],
        ),
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, provider, child) {
          //If the provider state is loading
          if (provider.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          //If the provider state has error
          if (provider.error != null) {
            return const Center(child: Text("Please try again"));
          }
          //If the provider state has data
          if (provider.weather != null) {
            return WeatherInfo(
              weather: provider.weather!,
              city: capitalizeWord(widget.city),
            );
          }
          return const Center(
              child: Text('Enter correct city to get weather information'));
        },
      ),
    );
  }
}

class WeatherInfo extends StatelessWidget {
  final WeatherModel weather;
  final String city;
  const WeatherInfo({super.key, required this.weather, required this.city});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.sp, vertical: 20.sp),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                city,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 10.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40.sp,
                    width: 40.sp,
                    child: Image.network(
                        'https://openweathermap.org/img/wn/${weather.weather?.first.icon}@2x.png'),
                  ),
                  Text(weather.weather?.first.description ?? 'N/A'),
                ],
              ),
              Text(
                '${weather.main?.temp ?? 'N/A'} \u2103',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black,
                    ),
              ),
              SizedBox(height: 30.sp),

              //Gridview for displaying weather information
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 20.sp,
                mainAxisSpacing: 20.sp,
                children: [
                  GradientContainer(
                    title: "Maximum",
                    value: '${weather.main?.tempMax ?? 'N/A'} \u2103',
                  ),
                  GradientContainer(
                    title: "Minimum",
                    value: '${weather.main?.tempMin ?? 'N/A'} \u2103',
                  ),
                  GradientContainer(
                      title: "Humidity",
                      value: '${weather.main?.humidity ?? 'N/A'} %'),
                  GradientContainer(
                      title: "Wind Speed",
                      value: '${weather.wind?.speed ?? 'N/A'} m/s'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
