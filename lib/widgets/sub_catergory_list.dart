import 'package:flutter/material.dart';
import '../state/sub_category_state.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

// ignore: must_be_immutable
class SubCategoriesList extends StatefulWidget {
  String id;
  SubCategoriesList(this.id);
  @override
  _SubCategoriesListState createState() => _SubCategoriesListState();
}

class _SubCategoriesListState extends State<SubCategoriesList>
    with AutomaticKeepAliveClientMixin {
  final _subCategoriesStateRM = RM.get<SubCategoryState>();

  @override
  void initState() {
    _subCategoriesStateRM.setState(
        (categoryState) => categoryState.getAllSubCategories(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: StateBuilder<SubCategoryState>(
        observe: () => _subCategoriesStateRM,
        builder: (context, model) {
          return ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              ...model.state.subCategories.map(
                (subCategory) => Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10.0),
                      height: 70,
                      child: Card(
                        margin: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 5.0),
                        elevation: 0.5,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 29.0,
                            child: ClipRRect(
                              child: SizedBox(
                                width: 100.0,
                                height: 100.0,
                                child: Image.asset(
                                  "${subCategory.subCategoryImage}",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            "${subCategory.subCategoryName}",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
