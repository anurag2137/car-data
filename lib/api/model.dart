import 'package:car_data/home.dart';

class CarData {
  final String id;
  final String car_name;
  final String car_version;
  final String car_model;

  CarData({
    required this.id,
    required this.car_name,
    required this.car_version,
    required this.car_model,
  });

  factory CarData.fromJson(Map<String, dynamic> data) {
    return CarData(
      id: data['id'].toString(),
      car_name: data['car_name'].toString(),
      car_version: data['car_version'].toString(),
      car_model: data['car_model'].toString(),
    );
  }
}
