final String dtableName = 'details';

class DetailsFields {
  static final List<String> values = [id, short, long, important];

  static final String id = '_id';
  static final String short = 'short';
  static final String long = 'long';
  static final String important = 'important';
}

class Details {
  final int? id;
  final String short;
  final String long;
  final int important;

  const Details({
    this.id,
    required this.short,
    required this.long,
    required this.important
  });

  Details copy({
    int? id,
    String? sort,
    String? long,
    int? important,
  }) =>
      Details(
        id: id ?? this.id,
        short: short,
        long: long ?? this.long,
        important: important ?? this.important,
      );

  static Details fromJson(Map<String, Object?> json) => Details(
        id: json[DetailsFields.id] as int?,
        short: json[DetailsFields.short] as String,
        long: json[DetailsFields.long]as String,
        important: json[DetailsFields.important] as int,
      );

  Map<String,Object?> toJson() => {
    DetailsFields.id: id,
    DetailsFields.short: short,
    DetailsFields.long: long,
    DetailsFields.important: important,
  };
}
