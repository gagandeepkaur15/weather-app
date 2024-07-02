import 'package:flutter/material.dart';
import 'package:go_india_stocks_task/models/weather_model.dart';
import 'package:provider/provider.dart';
import 'package:go_india_stocks_task/providers/weather_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WeatherScreen extends StatefulWidget {
  final String city;
  const WeatherScreen({super.key, required this.city});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    context.read<WeatherProvider>().fetchWeather(widget.city);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
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
              "Weather in ${widget.city}",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.sp, vertical: 20.sp),
        child: Consumer<WeatherProvider>(
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
              return WeatherInfo(weather: provider.weather!);
            }
            return const Center(
                child: Text('Enter correct city to get weather information'));
          },
        ),
      ),
    );
  }
}

class WeatherInfo extends StatelessWidget {
  final WeatherModel weather;
  const WeatherInfo({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('Temperature: ${weather.main?.temp ?? 'N/A'}'),
        Text('Feels Like: ${weather.main?.feelsLike ?? 'N/A'}'),
        Text('Minimum Temperature: ${weather.main?.tempMin ?? 'N/A'}'),
        Text('Maximum Temperature: ${weather.main?.tempMax ?? 'N/A'}'),
        Text('Pressure: ${weather.main?.pressure ?? 'N/A'}'),
        Text('Humidity: ${weather.main?.humidity ?? 'N/A'}'),
        Text('Wind Speed: ${weather.wind?.speed ?? 'N/A'}'),
        Text('Wind Degree: ${weather.wind?.deg ?? 'N/A'}'),
        Text('Wind Gust: ${weather.wind?.gust ?? 'N/A'}'),
        Text('Cloudiness: ${weather.clouds?.all ?? 'N/A'}'),
        Text('Rain (1h): ${weather.rain?.d1h ?? 'N/A'}'),
      ],
    );
  }
}
