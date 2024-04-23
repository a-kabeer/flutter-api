import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeApi extends StatefulWidget {
  const HomeApi({Key? key}) : super(key: key);

  @override
  _HomeApiState createState() => _HomeApiState();
}

class _HomeApiState extends State<HomeApi> {
  List<dynamic> responseBody = [];
  String error = '';

  jsonData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        responseBody = jsonDecode(response.body);
      });
    } else {
      setState(() {
        error = 'No Data found';
      });

      // Handle error or show a message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                jsonData();
                // Fetch data on button click
              },
              child: const Text('Fetch Data')),
          Expanded(
            child: ListView.builder(
              itemCount: responseBody.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(responseBody[index]['title']),
                  subtitle: Text(responseBody[index]
                      ['body']), // Assuming JSON objects have a 'title' field
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
