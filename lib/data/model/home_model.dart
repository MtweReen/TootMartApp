class HomeModel {
  int? code;
  bool? status;

  Body? body;

  HomeModel({
    this.code,
    this.status,
    this.body,
  });

  HomeModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];

    body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }
}

class Body {
  List<String>? images;
  List<CategoriesMostSales>? categoriesMostSales;
  List<CategoriesParents>? categoriesParents;

  Body({this.images, this.categoriesMostSales, this.categoriesParents});

  Body.fromJson(Map<String, dynamic> json) {
    images = json['images'] != null ? json['images'].cast<String>() : [];
    if (json['categories_mostSales'] != null) {
      categoriesMostSales = <CategoriesMostSales>[];
      json['categories_mostSales'].forEach((v) {
        categoriesMostSales!.add(CategoriesMostSales.fromJson(v));
      });
    }
    if (json['categories_parents'] != null) {
      categoriesParents = <CategoriesParents>[];
      json['categories_parents'].forEach((v) {
        categoriesParents!.add(CategoriesParents.fromJson(v));
      });
    }
  }
}

class CategoriesMostSales {
  int? id;
  String? title;
  String? image;

  CategoriesMostSales({this.id, this.title, this.image});

  CategoriesMostSales.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }
}

class CategoriesParents {
  int? id;
  String? title;
  String? image;

  CategoriesParents({this.id, this.title, this.image});

  CategoriesParents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }
}
