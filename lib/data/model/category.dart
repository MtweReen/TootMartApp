class CategoryModel {
  int? code;
  bool? status;

  Body? body;

  CategoryModel({
    this.code,
    this.status,
    this.body,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];

    body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }
}

class Body {
  List<Categories>? categories;

  Body({this.categories});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }
}

class Categories {
  int? id;
  String? title;
  String? image;

  Categories({this.id, this.title, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }
}
