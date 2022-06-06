import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  Future<Map<String, dynamic>> ambilData() async {
    try {
      var hasilGet = await http.get(Uri.parse('https://reqres.in/api/users/2'));
      if (hasilGet.statusCode >= 200 && hasilGet.statusCode < 300) {
        var data = json.decode(hasilGet.body)['data'] as Map<String, dynamic>;
        print(data);
        return data;
      } else {
        throw (hasilGet.statusCode);
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Future Builder'),
      ),
      body: FutureBuilder(
        future: ambilData(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.error != null) {
            return Center(
                child: Column(
              children: [
                Icon(Icons.error),
              ],
            ));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Text(snapshot.data);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ambilData(),
      ),
    );
  }
}
