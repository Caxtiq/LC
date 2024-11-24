import 'package:flutter/material.dart';

class Page {
  final String id;
  final String name;

  Page({required this.id, required this.name});
}

class PageState extends ChangeNotifier {
  List<Page> _pages = [
    Page(id: 'home', name: 'Home'),
    Page(id: 'about', name: 'About'),
    Page(id: 'contact', name: 'Contact'),
  ];

  String _currentPageId = 'home';

  List<Page> get pages => _pages;
  String get currentPageId => _currentPageId;

  void setCurrentPage(String pageId) {
    print('Attempting to set current page to: $pageId');
    if (_pages.any((page) => page.id == pageId)) {
      _currentPageId = pageId;
      print('Current page set to: $_currentPageId');
      notifyListeners();
    } else {
      print('Error: Page with id $pageId not found');
    }
  }

  void addPage(String name) {
    final newId = 'page_${_pages.length + 1}';
    _pages.add(Page(id: newId, name: name));
    notifyListeners();
  }

  void removePage(String id) {
    _pages.removeWhere((page) => page.id == id);
    if (_currentPageId == id) {
      _currentPageId = _pages.isNotEmpty ? _pages.first.id : '';
    }
    notifyListeners();
  }
}