import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map finalR = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JSON ONLINE API CALL"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                String baseUrl = "https://jsonplaceholder.typicode.com";
                String endPoint = "/posts/8";

                String api = baseUrl + endPoint;

                Response res =
                    await get(Uri.parse(api)); // online calling mate main line

                if (res.statusCode == 200) {
                  Map decodedData = jsonDecode(res.body);

                  setState(() {
                    finalR = decodedData;
                  });
                } else {
                  setState(() {
                    finalR = {};
                  });
                }
              },
              icon: Icon(Icons.save_alt)),
        ],
      ),
      body: (finalR.isNotEmpty) ? Card(
        elevation: 5,
        child: ListTile(
          leading: Text("${finalR['id']}"),
          title: Text("${finalR['title']}"),
          subtitle: Text("${finalR['body']}"),
          trailing: Text("${finalR['userId']}"),
        ),
      ) : Container(),
    );
  }
}
