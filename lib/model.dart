// models/chemical_element_model.dart

class ChemicalElement {
  final String? name;
  final String? symbol;
  final int? number;
  final String? category;
  final String? group;
  final String? period;

  ChemicalElement({
    this.name,
    this.symbol,
    this.number,
    this.category,
    this.group,
    this.period,
  });

  factory ChemicalElement.fromJson(Map<String, dynamic> json) {
    return ChemicalElement(
      name: json['name'] as String?,
      symbol: json['symbol'] as String?,
      number: json['number'] as int?,
      category: json['category'] as String?,
      group: json['group']?.toString(),  // Ensure group is parsed as a string
      period: json['period']?.toString(), // Ensure period is parsed as a string
    );
  }
}
