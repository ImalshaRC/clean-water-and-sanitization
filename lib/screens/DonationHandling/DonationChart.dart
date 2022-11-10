import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class DonationChart extends StatefulWidget {
  const DonationChart({Key? key}) : super(key: key);

  @override
  State<DonationChart> createState() => _DonationChartState();
}

class _DonationChartState extends State<DonationChart> {

  Map<String, double> dataMap = {
    "Dry Food": 5,
    "Water": 7,
    "Money": 2
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation Pie Chart'),
      ),
      body: ListView(
        children: [
          const Image(
              image: AssetImage(
                'assets/donation1.png'
              )
          ),
          const SizedBox(height: 80),
          Center(
            child: PieChart(
              dataMap: dataMap,
              animationDuration: const Duration(milliseconds: 800),
              chartLegendSpacing: 32,
              chartRadius: MediaQuery.of(context).size.width / 2.5,
              initialAngleInDegree: 0,
              chartType: ChartType.ring,
              ringStrokeWidth: 40,
              centerText: "Donations",
              legendOptions: const LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.right,
                showLegends: true,
                // legendShape: _BoxShape.circle,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: true,
                showChartValues: true,
                showChartValuesInPercentage: false,
                showChartValuesOutside: false,
                decimalPlaces: 1,
              ),
              // gradientList: ---To add gradient colors---
              // emptyColorGradient: ---Empty Color gradient---
            ) ,
          )
        ],
      )
    );
  }
}
