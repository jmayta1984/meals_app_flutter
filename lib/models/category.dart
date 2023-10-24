class Category {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  const Category(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl});

  Category.fromJson(Map<String, dynamic> json)
      : id = json['idCategory'],
        name = json['strCategory'],
        description = json['strCategoryDescription'],
        imageUrl = json['strCategoryThumb'];
}
