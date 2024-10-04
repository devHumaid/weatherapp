import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/Home/aoimodel.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/Home/apikey.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.context) : super(WeatherInitial()) {
    fetchData("London");
  }
  BuildContext context;
  TextEditingController searchcontroller = TextEditingController();
  Future<ApiModel?>? futureData;
  fetchData(String location) async {
    const baseurl = "https://api.openweathermap.org/data/3.0/onecall";

    final apiUrl =
        "https://api.openweathermap.org/data/2.5/weather?q=${location}&appid=${apikey}&units=metric";
    final uri = Uri.parse(apiUrl);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final res = jsonDecode(response.body);
      final data = ApiModel.fromJson(res);
      emit(FetchWeather(data: data));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  void searchCity() {
    String city = searchcontroller.text.trim();
    if (city.isNotEmpty) {
      futureData = fetchData(city);
    }
  }
}
