class ModelPersonagensMarvel {
  final int code;
  final String status;
  final CharacterDataContainer data;

  ModelPersonagensMarvel({
    required this.code,
    required this.status,
    required this.data,
  });

  factory ModelPersonagensMarvel.fromJson(Map<String, dynamic> json) {
    return ModelPersonagensMarvel(
      code: json['code'],
      status: json['status'],
      data: CharacterDataContainer.fromJson(json['data']),
    );
  }
}

class CharacterDataContainer {
  final int offset;
  final int limit;
  final int total;
  final int count;
  final List<Character> results;

  CharacterDataContainer({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.results,
  });

  factory CharacterDataContainer.fromJson(Map<String, dynamic> json) {
    final results = (json['results'] as List)
        .map((character) => Character.fromJson(character))
        .toList();
    return CharacterDataContainer(
      offset: json['offset'],
      limit: json['limit'],
      total: json['total'],
      count: json['count'],
      results: results,
    );
  }
}

class Character {
  final int id;
  final String name;
  final String description;
  final String thumbnailUrl;

  Character({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnailUrl,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    final thumbnail = json['thumbnail'];
    final thumbnailUrl = '${thumbnail['path']}.${thumbnail['extension']}';
    return Character(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      thumbnailUrl: thumbnailUrl,
    );
  }
}
