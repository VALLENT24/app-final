import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/item_model.dart';

class ItemProvider with ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => _items;

  final _db = FirebaseFirestore.instance.collection('items');

  Future<void> fetchItems() async {
    final snapshot = await _db.get();
    _items.clear();
    for (var doc in snapshot.docs) {
      _items.add(Item.fromJson(doc.data(), doc.id));
    }
    notifyListeners();
  }

  Future<void> addItem(String name) async {
    final docRef = await _db.add({'name': name});
    _items.add(Item(id: docRef.id, name: name));
    notifyListeners();
  }

  Future<void> deleteItem(String id) async {
    await _db.doc(id).delete();
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}