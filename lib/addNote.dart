import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import './Model/note.dart';
import 'package:http/http.dart' as http;
import './main.dart';

class AddNote extends StatelessWidget {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Email Field
    final email = new TextFormField(
        controller: _titleController,
        style: TextStyle(
          color: Colors.black,
        ),
        cursorColor: const Color(0xFF00D5A5),
        decoration: new InputDecoration(
          hintStyle: TextStyle(color: Colors.grey),
          labelStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          ),
          // focusColor: const Color(0xFF00D5A5),
          focusedBorder: const OutlineInputBorder(
            borderSide:
                const BorderSide(color: const Color(0xFF00D5A5), width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          labelText: "Title",
        ));

    final desc = new TextFormField(
        controller: _descController,
        style: TextStyle(
          color: Colors.black,
        ),
        cursorColor: const Color(0xFF00D5A5),
        decoration: new InputDecoration(
          hintStyle: TextStyle(color: Colors.grey),
          labelStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          ),
          // focusColor: const Color(0xFF00D5A5),
          focusedBorder: const OutlineInputBorder(
            borderSide:
                const BorderSide(color: const Color(0xFF00D5A5), width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          labelText: "Desc",
        ));

    return Scaffold(
        appBar: AppBar(
            title: Text('Add Note'),
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyNotes()),
              ),
            )),
        body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                email,
                SizedBox(height: 20.0),
                desc,
                SizedBox(height: 20.0),
                new RaisedButton(
                  onPressed: () {
                    _btnClick(context);
                  },
                  textColor: Colors.white,
                  color: Colors.blue,
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "Save",
                  ),
                ),
              ],
            )));
  }

  void _btnClick(BuildContext context) {
    String titleText = _titleController.text;
    String descText = _descController.text;
    String url;
    Map map;

    url = 'http://192.168.0.115:3000/notes';
    map = {
      'title': titleText,
      'content': descText,
    };

    apiRequest(url, map, context);
  }

  Future<void> apiRequest(String url, Map jsonMap, BuildContext context) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    print(reply);
    httpClient.close();
    return Future.delayed(
        Duration(seconds: 0),
        () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyNotes()),
              )
            });
  }
}
