class ProdSubCategory {
  ProdSubCategory({
    required this.subCatID,
    required this.title,
    this.status = true,
  });

  final String subCatID;
  final String title;
  final bool status;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sub_cat_id': subCatID,
      'title': title,
      'status': status,
    };
  }

  // ignore: sort_constructors_first
  factory ProdSubCategory.fromMap(Map<String, dynamic> map) {
    return ProdSubCategory(
      subCatID: map['sub_cat_id']?.toString().trim() ?? '',
      title: map['title']?.toString().trim() ?? '',
      status: map['status'] ?? true,
    );
  }
}
