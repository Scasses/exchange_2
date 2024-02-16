import 'package:flutter/cupertino.dart';
import '../models/category_model.dart';





List<CategoryModel> getCategories() {

  List<CategoryModel> category = <CategoryModel>[];

  CategoryModel business = CategoryModel();
  business.categoryName = 'Bussiness';
  business.image = const AssetImage('images/Esymbol3.jpg');
  category.add(business);

  CategoryModel entertainment = CategoryModel();
  entertainment.categoryName = 'Entertainment';
  entertainment.image = const AssetImage('images/Esymbol3.jpg');
  category.add(entertainment);

  CategoryModel general = CategoryModel();
  general.categoryName = 'General';
  general.image = const AssetImage('images/Esymbol3.jpg');
  category.add(general);

  CategoryModel health = CategoryModel();
  health.categoryName = 'Health';
  health.image = const AssetImage('images/Esymbol3.jpg');
  category.add(health);

  CategoryModel science = CategoryModel();
  science.categoryName = 'Science';
  science.image = const AssetImage('images/Esymbol3.jpg');
  category.add(science);

  CategoryModel sports = CategoryModel();
  sports.categoryName = 'Sports';
  sports.image = const AssetImage('images/Esymbol3.jpg');
  category.add(sports);

  CategoryModel technology = CategoryModel();
  technology.categoryName = 'Technology';
  technology.image = const AssetImage('images/Esymbol3.jpg');
  category.add(technology);

  return category;

}