import 'package:car_data/api/function.dart';

import 'package:flutter/material.dart';

import 'api/model.dart';
import 'home.dart';

void main() {
  runApp(const CarDataApp());
}

class CarDataApp extends StatelessWidget {
  const CarDataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Data App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CarGridScreen(),
    );
  }
}

class CarGridScreen extends StatefulWidget {
  const CarGridScreen({super.key});

  @override
  State<CarGridScreen> createState() => _CarGridScreenState();
}

class _CarGridScreenState extends State<CarGridScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                highlightColor: Colors.redAccent,
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostDataForm()),
                  );
                },
              ),
            )
          ],
          title: const Text(
            'CAR-DATA',
            style: TextStyle(color: Colors.white70),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/download.jpeg'),
                  fit: BoxFit.cover)),
          child: FutureBuilder<List<CarData>>(
            future: getData(),
            builder: (context, AsyncSnapshot<List<CarData>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data![index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          maxRadius: 40,
                          child: Text(
                            data.car_model,
                            style: TextStyle(color: Colors.grey[50]),
                          ),
                        ),
                        title: (Text(data.car_name)),
                        subtitle: Row(
                          children: [
                            Text(
                              data.car_version,
                              style: TextStyle(
                                color: Colors.grey[50],
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          color: Colors.white,
                          onPressed: ()  {
                            deleteDataFromApi(id: data.id);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      );
                    });
              }
            },
          ),
        )
        //Stack(fit: StackFit.expand, children: [
        //   SizedBox(
        //    child: Image.asset(
        //       carImageAssets.first,
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        //   Container(
        //   color: Colors.black.withOpacity(0.3), // Adjust opacity as needed
        //  ),],
        );
  }
}
