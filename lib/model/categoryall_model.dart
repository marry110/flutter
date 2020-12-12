class CategoryBigModel {
  String mallCategoryId;
  String mallCategoryName;
  String image;
  Null comments;
  List<dynamic> bxMallSubDto;
  CategoryBigModel({
    this.mallCategoryId,
    this.mallCategoryName,
    this.comments,
    this.image,
    this.bxMallSubDto,
  });

  factory CategoryBigModel.formJson(dynamic json) {
    return CategoryBigModel(
      mallCategoryId: json['mallCategoryId'],
      mallCategoryName: json['mallCategoryName'],
      comments: json['comments'],
      image: json['image'],
      bxMallSubDto: json['bxMallSubDto'],
    );
  }
}

class CategoryBigListModel {
  List<CategoryBigModel> data;
  CategoryBigListModel(this.data);
  factory CategoryBigListModel.fromJson(List json) {
    return CategoryBigListModel(
        json.map((i) => CategoryBigModel.formJson(i)).toList());
  }
}
