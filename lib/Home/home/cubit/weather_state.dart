part of 'weather_cubit.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

class FetchWeather extends WeatherState {
  final ApiModel data;
  FetchWeather({required this.data});
}
