import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import './Model/note.dart';
import './Model/note.dart';
import 'package:http/http.dart' as http;
import './main.dart';

class UpdateNote extends StatelessWidget {
  final Notes articles;

  UpdateNote(this.articles);

  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String helloTitle = articles.title;
    String helloDesc = articles.content;
    final usernameController = TextEditingController(text: helloTitle);
    final usernameController1 = TextEditingController(text: helloDesc);
    // Email Field
    final email = new TextFormField(
        controller: usernameController,
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
        controller: usernameController1,
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
            title: Text('Update Note'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _delete(context);
                },
              )
            ],
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
                    _update(context, usernameController.text,
                        usernameController1.text);
                  },
                  textColor: Colors.white,
                  color: Colors.blue,
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "Update",
                  ),
                ),
              ],
            )));
  }

/**
 * 
 * Update Code
 * 
 */
  void _update(BuildContext context, String title, String desc) {
    String url;
    Map map;

    url = 'http://192.168.0.115:3000/notes/${articles.id}';
    map = {
      'title': title,
      'content': desc,
    };

    apiRequest(url, map, context);
  }

  Future<void> apiRequest(String url, Map jsonMap, BuildContext context) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.putUrl(Uri.parse(url));
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

  /**
 * 
 * Delete Code
 * 
 */

  void _delete(BuildContext context) {
    String url;

    url = 'http://192.168.0.115:3000/notes/${articles.id}';

    apiRequestDelete(url, context);
  }

  Future<void> apiRequestDelete(String url, BuildContext context) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.deleteUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    HttpClientResponse response = await request.close();
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
