import 'package:flutter/material.dart';
import 'api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String baseCurrency = 'EUR';
  final String targetCurrency = 'USD';
  double eurToUsdExchangeRate = 1.92;
  double usdToEurExchangeRate = 1.0;
  final TextEditingController _amountController = TextEditingController(text: '0.0');
  late ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
    _fetchExchangeRates();
  }

  Future<void> _fetchExchangeRates() async {
    try {
      final Map<String, dynamic> exchangeRates = await _apiService.fetchExchangeRates();
      eurToUsdExchangeRate = exchangeRates['rates']['USD'];
      usdToEurExchangeRate = 1 / eurToUsdExchangeRate;
      setState(() {}); // Update the UI with new exchange rates
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Currency Exchange')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Enter amount',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _convertCurrency(eurToUsdExchangeRate, baseCurrency, targetCurrency),
                  child: Text('Convert to $targetCurrency'),
                ),
                ElevatedButton(
                  onPressed: () => _convertCurrency(usdToEurExchangeRate, targetCurrency, baseCurrency),
                  child: Text('Convert to $baseCurrency'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _convertCurrency(double exchangeRate, String fromCurrency, String toCurrency) {
    final double amount = double.tryParse(_amountController.text.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
    if (amount <= 0) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Please enter a valid amount.'),
          );
        },
      );
      return;
    }

    double convertedAmount = amount * exchangeRate;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('$amount $fromCurrency = ${convertedAmount.toStringAsFixed(2)} $toCurrency'),
        );
      },
    );
  }
}
