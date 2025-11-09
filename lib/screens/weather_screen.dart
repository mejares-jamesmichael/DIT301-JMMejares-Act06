import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apiconnectapp/viewmodels/weather_viewmodel.dart';
import 'package:apiconnectapp/widgets/weather_display.dart';
import 'package:apiconnectapp/utils/snackbar_helper.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherViewModel = Provider.of<WeatherViewModel>(context);

    // Show snackbar when there's an error
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (weatherViewModel.errorMessage != null) {
        SnackbarHelper.showError(context, weatherViewModel.errorMessage!);
      }
    });

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Enter City',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                weatherViewModel.fetchWeather(_controller.text);
              }
            },
            child: const Text('Get Weather'),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Consumer<WeatherViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (viewModel.weather != null) {
                  return WeatherDisplay(weather: viewModel.weather!);
                }
                return const Center(child: Text('Please enter a city'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
