import 'dart:convert';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart'; // Import for debugPrint
import 'model.dart';
import 'package:http/http.dart' as http;

import 'url.dart';

Future<List<CarData>> getData() async {
  print('func called');
  try {
    final response = await http.get(Uri.parse(URLS.carsList)); /////
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw http.ClientException(response.reasonPhrase ?? response.body);
    }
    print(response.statusCode);
    final data = jsonDecode(response.body); /////
    List<CarData> carData = []; ////
    for (var item in data['data']) {
      ///
      carData.add(CarData.fromJson(item)); ////
    }
    return carData; ////

    // final listOfCarsData = data['data'].map((element) {
    //   return CarData.fromJson(element);
    // });
    // return listOfCarsData;
  } on Exception catch (e) {
    debugPrint(e.toString());
    rethrow;
  }
}

Future<bool> postData({
  required String carName,
  required String carVersion,
  required String carModel,
}) async {
  Map<String, String> data = {
    "car_name": carName,
    "car_version": carVersion,
    "car_model": carModel,
  };
  try {
    final jsonData = jsonEncode(data); // Convert the data map to JSON format
    final response = await http.post(
      Uri.parse(URLS.carsList), // Use the URL from URLS.carsList
      headers: {
        'Content-Type': 'application/json', // Use JSON content type
      },
      body: jsonData, // Send JSON data in the request body
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to post data: ${response.statusCode}  error is:${response.body}');
    }
    return true;
  } on Exception catch (e) {
    debugPrint('this is catch error - ${e.toString()}');
    return false;
  }
}


Future<void> deleteDataFromApi({required String id}) async {
  try {
    final response = await http.delete(
      Uri.parse(URLS.carsList), // Replace 'your_api_endpoint' with the actual endpoint
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        // Add any additional headers if required
      },
      body: jsonEncode({'id': id}), // Encode the id as JSON in the request body

    );

    if (response.statusCode == 200) {
      // Data successfully deleted
      print('Data successfully deleted');
    } else {
      // Failed to delete data
      print('Failed to delete data: ${response.statusCode}');
      print('reason for failing data:${response.reasonPhrase}');
    }
  } catch (e) {
    // Exception occurred
    print('Exception occurred while deleting data: $e');
  }
}


