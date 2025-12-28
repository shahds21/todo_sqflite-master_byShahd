class Category {
  int? id;
  String name;

  Category({this.id, required this.name});

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
