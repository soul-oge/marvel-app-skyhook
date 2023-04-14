class Heros {
  late int id;
  late String name;
  late String thumbnailUrl;
  late String description;
  Heros(
      {required this.id,
      required this.name,
      required this.thumbnailUrl,
      required this.description});

  Heros.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnailUrl =
        json['thumbnail']['path'] + '.' + json['thumbnail']['extension'];
    description = json['description'];
  }
}
