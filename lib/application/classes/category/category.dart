import 'package:provider/application/classes/subcategory/subcategory.dart';

class Category {
  String id;
  String categoryName;
  String categoryImage;
  List<SubCategory> subCategory;

  Category.fromJson(Map<String, dynamic> jsonMap)
      :
        id = jsonMap['identifier'].toString(),
        categoryName = jsonMap['title'],
        categoryImage = jsonMap['image'],
        subCategory = _getSubCategories(jsonMap['subCategory']);

  static _getSubCategories(List<dynamic> subCategories) {
    if (subCategories == null) return List<SubCategory>();
    return subCategories.map((subcategory) => SubCategory.fromJson(subcategory)).toList();
  }
}