import 'package:account/app/component/myshimmer.dart';
import 'package:account/app/component/mytopbar.dart';
import 'package:account/app/modules/table_analyse/table_analyse_logic.dart';
import 'package:account/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;
import '../../../res/assets_res.dart';
import '../../component/mydatepicker.dart';
import '../../component/myiconbtn.dart';
import '../../component/myshowbottomsheet.dart';
import '../../component/picchoicebtn.dart';
import '../../data/entity/consume.dart';
import '../../data/net/api_consume.dart';
import '../../theme/app_text_theme.dart';
import '../../utils/date_util.dart';
import '../../utils/save_file_mobile.dart';

class TableAnalysePage extends StatefulWidget {
  const TableAnalysePage({super.key});

  @override
  State<TableAnalysePage> createState() => _TableAnalysePageState();
}

class _TableAnalysePageState extends State<TableAnalysePage> {
  final logic = Get.find<TableAnalyseLogic>();
  final state = Get.find<TableAnalyseLogic>().state;
  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _exportDataGridToExcel() async {
    final Workbook workbook = _key.currentState!.exportToExcelWorkbook();
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    await saveAndLaunchFile(bytes, 'DataGrid.xlsx');
  }

  // Future<void> _exportDataGridToPdf() async {
  //   final PdfDocument document =
  //       _key.currentState!.exportToPdfDocument(fitAllColumnsInOnePage: true);
  //   final List<int> bytes = document.saveSync();
  //   await saveAndLaunchFile(bytes, 'DataGrid.pdf');
  //   document.dispose();
  // }

  late String date = state.date ?? DateUtil.getNowFormattedDate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTopBar(
        backgroundColor: AppColors.color_list[1],
        middle: GestureDetector(
          onTap: () {
            myShowBottomSheet(
              context: context,
              builder: (context) {
                return MyDatePicker(
                  isSingleMonth: true,
                  changeTime: (start_, end_, isMonth_) {
                    logic.clear();
                    setState(
                      () {
                        date = "$start_-01";
                      },
                    );
                  },
                );
              },
            );
          },
          child: Text(
            "${date.split("-")[0]}年${date.split("-")[1]}月\n表格详细报告",
            style: AppTS.normal,
            textAlign: TextAlign.center,
          ),
        ),
        trailing: MyIconBtn(
          onPressed: () async {
            _exportDataGridToExcel();
          },
          imgPath: AssetsRes.EXPORT,
          color: AppColors.color_list[5],
        ),
      ),
      body: FutureBuilder(
        future: logic.getRecord(date),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return SfDataGrid(
              key: _key,
              source: DataSource(data: snapshot.data!),
              columnWidthMode: ColumnWidthMode.fitByColumnName,
              allowSorting: true,
              selectionMode: SelectionMode.single,
              columns: <GridColumn>[
                GridColumn(
                  columnName: '时间',
                  width: 110,
                  label: Container(
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    child: Text(
                      '时间',
                      style: AppTS.small,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: '金额',
                  label: Container(
                    width: 110,
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    child: Text(
                      '金额',
                      style: AppTS.small,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: '物品',
                  width: 130,
                  label: Container(
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    child: Text(
                      '物品',
                      style: AppTS.small,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: '地点',
                  label: Container(
                    width: 130,
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    child: Text(
                      '地点',
                      style: AppTS.small,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return ShimmerEffect(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
              ),
            );
          }
        },
      ),
    );
  }

// void _getExportChoice() {
//   myShowBottomSheet(
//     context: context,
//     builder: (context) => Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         SizedBox(height: 20.h),
//         PicChoiceBtn(
//           title: "Excel",
//           onPressed: () {
//             _exportDataGridToExcel();
//           },
//         ),
//         SizedBox(height: 10.h),
//         PicChoiceBtn(
//           title: "Pdf",
//           onPressed: () {
//             _exportDataGridToPdf();
//           },
//         ),
//         SizedBox(height: 20.h),
//       ],
//     ),
//   );
// }
}

class DataSource extends DataGridSource {
  List<DataGridRow> _data = [];

  DataSource({required List<ConsumeData> data}) {
    _data = data
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell<String>(columnName: "时间", value: e.consumeDate),
              DataGridCell<double>(columnName: "金额", value: e.amount),
              DataGridCell<String>(columnName: "物品", value: e.consumptionName),
              DataGridCell<String>(columnName: "地点", value: e.store),
            ],
          ),
        )
        .toList();
  }

  @override
  List<DataGridRow> get rows => _data;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Text(dataGridCell.value.toString(),
            maxLines: 1,
            style: TextStyle(fontSize: 12.sp, color: const Color(0xff3D3D3D))),
      );
    }).toList());
  }
}
