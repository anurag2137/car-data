import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api/function.dart';

class PostDataForm extends StatefulWidget {
  const PostDataForm({super.key});

  @override
  _PostDataFormState createState() => _PostDataFormState();
}

class _PostDataFormState extends State<PostDataForm> {
  final TextEditingController _carNameController = TextEditingController();
  final TextEditingController _carVersionController = TextEditingController();
  final TextEditingController _carModelController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Data Form'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please Enter some Text';
                    }
                    return null;
                  },
                  controller: _carNameController,
                  decoration: InputDecoration(
                    labelText: 'Car Name',
                  )),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please Enter some text';
                  }
                  return null;
                },
                controller: _carVersionController,
                decoration: InputDecoration(
                  labelText: 'Car Version',
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please Enter some text';
                  }
                  return null;
                },
                controller: _carModelController,
                decoration: InputDecoration(
                  labelText: 'Car Model',
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.green),
                child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          final result = await postData(
                              carName: _carNameController.text,
                              carVersion: _carVersionController.text,
                              carModel: _carModelController.text);
                          if (result) {
                            // show popup sucess
                          }
                        } on Exception catch (exp) {
                          print(exp.toString());
                          // show popup with error
                        }
                      }
                    },
                    child: Text('Submit')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
