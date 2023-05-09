import 'dart:convert';

import 'package:challenge/model/exhibit.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class ExhibitsLoader with ChangeNotifier {
  List<Exhibit> _list = [];
  bool _error = false;
  String _errorMessage = "";
  String baseUrl = "https://my-json-server.typicode.com/Reyst/exhibit_db/list";

  List<Exhibit> get list => _list;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  Future<void> get fetchData async {
    final response = await get(Uri.parse(baseUrl));
    final body = json.decode(response.body);
    if (response.statusCode == 200) {
      try {
        _list = body.map<Exhibit>(Exhibit.fromJson).toList();
        _error = false;
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _list = [];
      }
    } else {
      _error = true;
      _errorMessage = "Error: It could be your internet connection?";
      _list = [];
    }
    notifyListeners();
  }
}
