import 'package:flutter/material.dart';

abstract class DataManager<T> extends ChangeNotifier {
  final Future<List<T>> Function() fetchData;
  String searchQuery = '';

  List<T>? _data;
  String? _error;
  bool _isLoading = true;

  DataManager({required this.fetchData});

  List<T>? get data => _data;
  String? get error => _error;
  bool get isLoading => _isLoading;

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();
    try {
      _data = await fetchData();
      _error = null;
    } catch (e) {
      _data = null;
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<T> get filteredData {
    if (_data == null) return [];
    return _data!.where(matchesSearchQuery).toList();
  }

  bool matchesSearchQuery(T item); 

  void updateSearchQuery(String query) {
    searchQuery = query;
    notifyListeners();
  }
}
