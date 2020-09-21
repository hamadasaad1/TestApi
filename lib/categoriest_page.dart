import 'package:flutter/material.dart';
import './provider/categroies.dart';
import 'package:provider/provider.dart';
import './model/categories_model.dart';
import './utils/size_config.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  

  @override
  Widget build(BuildContext context) {
    //for call provider with api
    final categoriesData =
        Provider.of<CategoriesProvider>(context, listen: false);
    categoriesData.callAPIForCategoriesData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Categoriest'),
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Container(child: Consumer<CategoriesProvider>(
      builder: (_, pragma, __) {
        Widget content = Center(
            child: Text(pragma.errorMessage != null
                ? pragma.errorMessage
                : "No Data for you"));
        if (!pragma.isLoading) {
          content = _buildList(pragma.getCategoriesModelData);
        } else if (!pragma.isLoading &&
            pragma.getCategoriesModelData.categories == null) {
          content = Center(
              child: Text(pragma.errorMessage != null
                  ? pragma.errorMessage
                  : "No Data for you"));
        } else
          content = Center(child: CircularProgressIndicator());

        return content;
      },
    ));
  }



  Widget _buildList(CategoriesModel list) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _buildItem(list.categories[index]);
      },
      itemCount: list.categories.length,
    );
  }

  Widget _buildItem(Categories categoryModel) {
    print("asd  " + categoryModel.name);
    return Container(
      child: Column(
        children: <Widget>[
          Text(categoryModel.name),
          Image.network(
              categoryModel.image??"",
              // width: SizeConfig.heightMultiplier * 6,
               //height: SizeConfig.heightMultiplier * 6,
               fit: BoxFit.cover,
             ),
        ],
      )
    );
    // return Container(
    //  // width: SizeConfig.heightMultiplier/4,
    //   height: SizeConfig.heightScreenSize/4,
    //   padding: EdgeInsets.all(SizeConfig.heightMultiplier * .5),
    //   margin: EdgeInsets.all(SizeConfig.heightMultiplier * .5),
    //   decoration: BoxDecoration(
    //     border: Border.all(width: 2.0, color: Colors.grey[200]),
    //     borderRadius:
    //         BorderRadius.all(Radius.circular(2 * SizeConfig.heightMultiplier)),
    //   ),
    //   child: Column(
    //     children: <Widget>[
    //       Container(
    //         child: Image.network(
    //           categoryModel.image,
    //           width: SizeConfig.heightMultiplier * 6,
    //           height: SizeConfig.heightMultiplier * 6,
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //       Container(
    //         child: Center(
    //           child: Text(categoryModel.name),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
