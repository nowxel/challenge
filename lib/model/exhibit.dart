class Exhibit {
  final String title;
  final List<dynamic> images;

  Exhibit({required this.title, required this.images});

  static Exhibit fromJson(json) =>
      Exhibit(title: json["title"], images: json["images"]);
}
