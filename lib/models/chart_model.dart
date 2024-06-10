class IncomeData {
  final String monthYear;
  final double amount;

  IncomeData(this.monthYear, this.amount);

  factory IncomeData.fromJson(Map<String, dynamic> json) {
    return IncomeData(
      json['monthYear'],
      json['amount'].toDouble(),
    );
  }
}

class SpendingData {
  final String monthYear;
  final double amount;

  SpendingData(this.monthYear, this.amount);

  factory SpendingData.fromJson(Map<String, dynamic> json) {
    return SpendingData(
      json['monthYear'],
      json['amount'].toDouble(),
    );
  }
}
