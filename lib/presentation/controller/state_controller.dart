import 'package:flutter/material.dart';

class StateController<T> extends ChangeNotifier {
  final Future<T> Function() _fetchData;
  T? _data;
  Object? _error;
  bool _isLoading = true;

  StateController(this._fetchData) {
    _fetchDataAndUpdateState();
  }

  T? get data => _data;
  Object? get error => _error;
  bool get isLoading => _isLoading;

  Future<void> _fetchDataAndUpdateState() async {
    try {
      _data = await _fetchData();
      _isLoading = false;
    } catch (e) {
      _error = e;
      _isLoading = false;
    } finally {
      notifyListeners();
    }
  }
}
