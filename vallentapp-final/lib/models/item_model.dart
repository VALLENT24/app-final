class Item {
  String id;
  String name;

  Item({required this.id, required this.name});

  factory Item.fromJson(Map<String, dynamic> json, String id) {
    return Item(id: id, name: json['name']);
  }

  Map<String, dynamic> toJson() => {'name': name};
}