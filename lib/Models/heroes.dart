class Heroe {
  final String id;
  final String name;
  final String imageUrl;

  Heroe({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory Heroe.fromJson(Map<String, dynamic> json) => Heroe(
        id: json["id"],
        name: json["name"],
        imageUrl: json["image"]["url"],
      );
}

class HeroeDatos {
  final String fullName;
  final String alterEgos;
  final List<String> aliases;
  final String placeOfBirth;
  final String firstAppearance;
  final String publisher;
  final String alignment;
  final String imageUrl;

  HeroeDatos({
    required this.fullName,
    required this.alterEgos,
    required this.aliases,
    required this.placeOfBirth,
    required this.firstAppearance,
    required this.publisher,
    required this.alignment,
    required this.imageUrl,
  });

  factory HeroeDatos.fromJson(Map<String, dynamic> json) {
    final List<String> aliases =
        json["aliases"] != null ? List<String>.from(json["aliases"]) : [];

    return HeroeDatos(
      fullName: json["full-name"],
      alterEgos: json["alter-egos"],
      aliases: aliases,
      placeOfBirth: json["place-of-birth"],
      firstAppearance: json["first-appearance"],
      publisher: json["publisher"],
      alignment: json["alignment"],
      imageUrl: json["image"]["url"],
    );
  }
}
