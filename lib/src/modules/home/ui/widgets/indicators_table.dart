import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/application/entities/stock_indicator_list.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/mixins/diff_percent_calculation_mixin.dart';
import 'package:variacao_ativo_flutter/src/shared/utils/currency_util.dart';

class IndicatorsTable extends StatelessWidget with DiffPercentCalcMixin {
  final StockIndicatorList data;
  const IndicatorsTable({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final DateFormat df = DateFormat('dd/MM/yy');
    var isLandscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;
    var size = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        dataRowMinHeight: 20,
        dataRowMaxHeight: 30,
        columnSpacing: isLandscape || size.width > 600 ? null : 16,
        columns: const [
          DataColumn(label: Text('Dia')),
          DataColumn(label: Text('Data')),
          DataColumn(label: Text('Valor')),
          DataColumn(label: Text('Variação D-1')),
          DataColumn(label: Text('Variação a primeira data')),
        ],
        rows: data.dateList
            .mapIndexed(
              (index, e) => DataRow(
                cells: [
                  DataCell(Text('${index + 1}')),
                  DataCell(Text(df.format(e))),
                  DataCell(
                      Text(CurrencyUtil.toCurrency(data.openValueList[index]))),
                  DataCell(Text(
                    calulateDayDiff(
                      data.openValueList[index],
                      index == 0 ? null : data.openValueList[index - 1],
                    ),
                  )),
                  DataCell(Text(calulateDayDiff(
                    data.openValueList[index],
                    index == 0 ? null : data.openValueList.first,
                  ))),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
