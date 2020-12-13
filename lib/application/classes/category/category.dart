import 'package:provider/application/classes/subcategory/subcategory.dart';

class Category {
  String id;
  String categoryName;
  List<SubCategory> subCategory;

  Category.fromJson(Map<String, dynamic> jsonMap)
      :
        id = jsonMap['identifier'].toString(),
        categoryName = jsonMap['title'],
        subCategory = _getCarts(jsonMap['subCategory']);

  static _getCarts(List<dynamic> subCategories) {
    if (subCategories == null) return List<SubCategory>();
    return subCategories.map((cart) => SubCategory.fromJson(cart)).toList();
  }
}