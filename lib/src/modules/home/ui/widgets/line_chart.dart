import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/application/entities/stock_indicator_list.dart';

class _LineChart extends StatelessWidget {
  const _LineChart({
    required this.colorScheme,
    required this.isShowingMainData,
    required this.stockData,
  });

  final StockIndicatorList stockData;
  final bool isShowingMainData;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData2,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData2 => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: lineBarsData2,
        minX: 0,
        maxX: 29,
        maxY: stockData.openValueList.max,
        minY: stockData.openValueList.min,
      );

  LineTouchData get lineTouchData2 => const LineTouchData(
        enabled: false,
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData2 => [
        lineChartBarData2_2,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text = value.toInt().toString();

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: .6,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    DateFormat df = DateFormat('dd/MM/yy');

    var date = stockData.dateList[value.toInt()];
    Widget text = Text(df.format(date), style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 10,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom:
              BorderSide(color: colorScheme.primary.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData2_2 => LineChartBarData(
      isCurved: true,
      color: colorScheme.tertiary.withOpacity(0.5),
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        color: colorScheme.tertiary.withOpacity(0.2),
      ),
      spots: stockData.openValueList
          .mapIndexed((index, e) => FlSpot(index.toDouble(), e))
          .toList()
      //  const [
      //   FlSpot(1, 1),
      //   FlSpot(3, 2.8),
      //   FlSpot(7, 1.2),
      //   FlSpot(10, 2.8),
      //   FlSpot(12, 2.6),
      //   FlSpot(13, 3.9),
      // ],
      );
}

class CustomLineChart extends StatefulWidget {
  final StockIndicatorList stockData;
  const CustomLineChart({super.key, required this.stockData});

  @override
  State<StatefulWidget> createState() => CustomLineChartState();
}

class CustomLineChartState extends State<CustomLineChart> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = false;
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return AspectRatio(
      aspectRatio: 1.23,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 37,
              ),
              Text(
                'Variação 30 dias',
                style: TextStyle(
                  color: colorScheme.primary,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 37,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 6),
                  child: _LineChart(
                    colorScheme: colorScheme,
                    isShowingMainData: isShowingMainData,
                    stockData: widget.stockData,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
