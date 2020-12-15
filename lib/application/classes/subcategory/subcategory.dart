class SubCategory
{
  String id;
  String subCategoryName;
  SubCategory.fromJson(Map<String,dynamic> jsonMap):
        id =  jsonMap['identifier'].toString(),
        subCategoryName =  jsonMap['title'];
}