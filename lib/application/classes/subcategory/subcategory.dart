class SubCategory {
  String id;
  String subCategoryName;
  bool isSelected = false;
  SubCategory.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['identifier'].toString(),
        subCategoryName = jsonMap['title'];
}
