import 'package:expense_tracker/models/bar.model.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
    required this.satAmount,
  });

  List<Bar> barData = [];

  void initializeBarData() {
    barData = [
      // sun
      Bar(0, sunAmount),
      // mon
      Bar(1, monAmount),
      // tue
      Bar(2, tueAmount),
      // wed
      Bar(3, wedAmount),
      // thu
      Bar(4, thuAmount),
      // fri
      Bar(5, friAmount),
      // sat
      Bar(6, satAmount),
    ];
  }
}
