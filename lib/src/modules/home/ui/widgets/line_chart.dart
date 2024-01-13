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
      lineData,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get lineData => LineChartData(
        lineTouchData: lineTouchData,
        gridData: gridData,
        titlesData: titlesData,
        borderData: borderData,
        lineBarsData: lineBarsData,
        minX: 0,
        maxX: (stockData.dateList.length - 1).toDouble(),
        maxY: stockData.openValueList.max.ceilToDouble(),
        minY: stockData.openValueList.min.floorToDouble(),
      );

  LineTouchData get lineTouchData => LineTouchData(
      enabled: true,
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: colorScheme.primary,
        getTooltipItems: (touchedSpots) => touchedSpots
            .map((e) => LineTooltipItem(e.y.toStringAsFixed(2),
                TextStyle(color: colorScheme.onPrimary)))
            .toList(),
      ));

  FlTitlesData get titlesData => FlTitlesData(
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

  List<LineChartBarData> get lineBarsData => [
        lineChartBarData,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text = value.toInt().toString();

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() {
    var diff = (stockData.openValueList.max - stockData.openValueList.min) / 3;

    return SideTitles(
      getTitlesWidget: leftTitleWidgets,
      showTitles: true,
      reservedSize: 40,
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
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

  LineChartBarData get lineChartBarData => LineChartBarData(
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
            .toList(),
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
    var isLandscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;
    var size = MediaQuery.sizeOf(context);

    return AspectRatio(
      aspectRatio: isLandscape || size.width > 600 ? 1.8 : 1.23,
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
