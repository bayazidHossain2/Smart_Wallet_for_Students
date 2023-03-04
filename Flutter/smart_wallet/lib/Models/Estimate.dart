final String etableName = 'estimate';

class EstimateFields {
  static final List<String> values = [
    id,
    type,
    time,
    amount,
    description,
    market_id
  ];
  static final String id = '_id';
  static final String type = 'type';
  static final String time = 'time';
  static final String amount = 'amount';
  static final String description = 'description';
  static final String market_id = 'market_id';
}

class Estimate {
  final int? id;
  final String type;
  final DateTime time;
  final int amount;
  final String description;
  final int market_id;
  const Estimate({
    this.id,
    required this.type,
    required this.time,
    required this.amount,
    required this.description,
    required this.market_id,
  });

  Estimate copy({
    int? id,
    String? type,
    DateTime? time,
    int? amount,
    String? description,
    int? market_id,
  }) =>
      Estimate(
          id: id ?? this.id,
          type: type ?? this.type,
          time: time ?? this.time,
          amount: amount ?? this.amount,
          description: description ?? this.description,
          market_id: market_id ?? this.market_id);

  static Estimate fromJson(Map<String, Object?> json) => Estimate(
        id: json[EstimateFields.id] as int?,
        type: json[EstimateFields.type] as String,
        time: DateTime.parse(json[EstimateFields.time] as String),
        amount: json[EstimateFields.amount] as int,
        description: json[EstimateFields.description] as String,
        market_id: json[EstimateFields.market_id] as int,
      );
  
  Map<String, Object?> toJson() => {
    EstimateFields.id : id,
    EstimateFields.type : type,
    EstimateFields.time : time.toString(),
    EstimateFields.amount : amount,
    EstimateFields.description : description,
    EstimateFields.market_id : market_id,
  };
}
