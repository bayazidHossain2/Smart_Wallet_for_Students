final String mtableName = 'market';

class MarketFields {
  static final List<String> values = [id, name, creatingTime];

  static final String id = '_id';
  static final String name = 'name';
  static final String creatingTime = 'creatingTime';
  static final String currentMarket = 'currentMarket';
}

class Market {
  final int? id;
  final String name;
  final DateTime creatingTime;

  const Market({
    this.id,
    required this.name,
    required this.creatingTime,
  });

  Market copy({
    int? id,
    String? name,
    DateTime? creatingTime,
  }) =>
      Market(
        id: id ?? this.id,
        name: name ?? this.name,
        creatingTime: creatingTime ?? this.creatingTime,
      );

  static Market fromJson(Map<String, Object?> json) => Market(
        id: json[MarketFields.id] as int?,
        name: json[MarketFields.name] as String,
        creatingTime: DateTime.parse(json[MarketFields.creatingTime] as String),
      );

  Map<String,Object?> toJson() => {
    MarketFields.id : id,
    MarketFields.name : name,
    MarketFields.creatingTime : creatingTime.toString(),
  };
}
