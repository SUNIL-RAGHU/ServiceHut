import 'dart:ui';

class ItemModel {
  bool expanded;
  String? Title;
  String? Category;
  String? subcategory;
  String? Price;
  String? Details;

  String? discription;
  Color? colorsItem;
  String? img;

  ItemModel(
      {this.expanded: false,
      this.Title,
      this.Category,
      this.subcategory,
      this.Price,
      this.Details,
      this.discription,
      this.colorsItem,
      this.img});
}
