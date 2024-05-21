// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> generateCenteredText({required PdfModel pdfModel}) async {
    final pdf = pw.Document();
    final imageBytes =
        await rootBundle.load("assets/images/pdf_weight_icon.png");
    final pdfStartWeight =
        await rootBundle.load("assets/images/pdf_start_weight.png");
    final pdfCurrentWeight =
        await rootBundle.load("assets/images/pdg_current_weight.png");
    final pdfGoalWeight =
        await rootBundle.load("assets/images/pdf_goal_weight.png");
    final pdfSleep = await rootBundle.load("assets/images/anasleep.png");
    final pdfExercise = await rootBundle.load("assets/images/anaexercise.png");

    pdf.addPage(
      Page(
        pageTheme: PageTheme(buildBackground: (context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(29),
              border: Border.all(
                width: 1,
                color: PdfColor.fromHex("#146C94"),
              ),
            ),
          );
        }),
        build: (context) {
          return Column(
            children: [
              SizedBox(
                height: 22,
              ),
              Center(
                child: SizedBox(
                  width: 117,
                  height: 21,
                  child: Image(
                    MemoryImage(
                      imageBytes.buffer.asUint8List(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 29,
              ),
              Text(
                pdfModel.name,
                style: TextStyle(
                  color: PdfColor.fromHex("#146C94"),
                  fontSize: 27,
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                'Age: ${pdfModel.age} Years',
                style: const TextStyle(
                  color: PdfColors.black,
                  fontSize: 19,
                ),
              ),
              SizedBox(
                height: 41,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    height: 122,
                    decoration: BoxDecoration(
                      color: PdfColors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: PdfColor.fromHex("#CACACA"),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Starting Weight',
                          style: TextStyle(
                            color: PdfColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Image(
                                pw.MemoryImage(
                                  pdfStartWeight.buffer.asUint8List(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 18,
                            ),
                            Text(
                              '${pdfModel.startingweight} ${pdfModel.weightUnit}',
                              style: TextStyle(
                                color: PdfColor.fromHex("#146C94"),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 0,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Taken Date:',
                              style: TextStyle(
                                color: PdfColors.black,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                height: 0,
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              pdfModel.startingDate,
                              style: const TextStyle(
                                color: PdfColors.black,
                                fontSize: 8,
                                height: 0,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 122,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: PdfColors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: PdfColor.fromHex("#CACACA"),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Current Weight',
                          style: TextStyle(
                            color: PdfColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Image(
                                pw.MemoryImage(
                                  pdfCurrentWeight.buffer.asUint8List(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 18,
                            ),
                            Text(
                              '${pdfModel.currentweight} ${pdfModel.weightUnit}',
                              style: TextStyle(
                                color: PdfColor.fromHex("#146C94"),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 0,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Taken Date:',
                              style: TextStyle(
                                color: PdfColors.black,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                height: 0,
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              pdfModel.currentDate,
                              style: const TextStyle(
                                color: PdfColors.black,
                                fontSize: 8,
                                height: 0,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 122,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: PdfColors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: PdfColor.fromHex("#CACACA"),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Goal Weight',
                          style: TextStyle(
                            color: PdfColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Image(
                                pw.MemoryImage(
                                  pdfGoalWeight.buffer.asUint8List(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 18,
                            ),
                            Text(
                              '${pdfModel.goalweight} ${pdfModel.weightUnit}',
                              style: TextStyle(
                                color: PdfColor.fromHex("#146C94"),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 0,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Taken Date:',
                              style: TextStyle(
                                color: PdfColors.black,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                height: 0,
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              pdfModel.goalDate,
                              style: const TextStyle(
                                color: PdfColors.black,
                                fontSize: 8,
                                height: 0,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 46,
              ),
              Center(
                child: Container(
                  width: 437,
                  height: 176,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: PdfColors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: PdfColor.fromHex("#CACACA"),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Avg.',
                            style: TextStyle(
                              color: PdfColor.fromHex("#146C94"),
                              fontSize: 12,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${pdfModel.totalAvg.toPrecision(2)} ',
                                  style: TextStyle(
                                    color: PdfColor.fromHex("#146C94"),
                                    fontSize: 18,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: 'cal',
                                  style: TextStyle(
                                    color: PdfColor.fromHex("#909090"),
                                    fontSize: 18,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MyCustomPdfWidget(
                            progressColor: PdfColor.fromHex("#CE7575"),
                            quantity: pdfModel.carbs,
                            title: "Carbs",
                            progressValue: pdfModel.carbs,
                            totalValue: pdfModel.goalCarbs,
                          ),
                          MyCustomPdfWidget(
                            progressColor: PdfColor.fromHex("#D9AF89"),
                            quantity: pdfModel.fat,
                            title: "Fat",
                            progressValue: pdfModel.fat,
                            totalValue: pdfModel.goalFat,
                          ),
                          MyCustomPdfWidget(
                            progressColor: PdfColor.fromHex("#83AC83"),
                            quantity: pdfModel.protien,
                            title: "Protien",
                            progressValue: pdfModel.protien,
                            totalValue: pdfModel.goalProtien,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 46,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 73,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: PdfColors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: PdfColor.fromHex("#CACACA"),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: Image(
                                    MemoryImage(
                                      pdfSleep.buffer.asUint8List(),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'Average\nSleep',
                                  style: TextStyle(
                                    color: PdfColors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    height: 0,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              pdfModel.aveSleep,
                              style: TextStyle(
                                color: PdfColor.fromHex("#146C94"),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                height: 0,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Container(
                        height: 73,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: PdfColors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: PdfColor.fromHex("#CACACA"),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: Image(
                                    MemoryImage(
                                      pdfExercise.buffer.asUint8List(),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'Average\nExercise',
                                  style: TextStyle(
                                    color: PdfColors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    height: 0,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${pdfModel.aveExercise.toPrecision(2)} kcal',
                              style: TextStyle(
                                color: PdfColor.fromHex("#146C94"),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                height: 0,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              UrlLink(
                  child: Text(
                    'www.weightloser.com',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: PdfColor.fromHex("#146C94"),
                      fontSize: 14,
                      decoration: pw.TextDecoration.underline,
                      height: 0.09,
                    ),
                  ),
                  destination: "www.weightloser.com")
            ],
          );
        },
      ),
    );

    // passing the pdf and name of the docoment to make a direcotory in  the internal storage
    return saveDocument(name: 'progress_report.pdf', pdf: pdf);
  }

  // it will make a named dircotory in the internal storage and then return to its call
  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    // pdf save to the variable called bytes
    final bytes = await pdf.save();

    // here a beautiful pakage  path provider helps us and take dircotory and name of the file  and made a proper file in internal storage
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    return await file.writeAsBytes(bytes);

    // reterning the file to the top most method which is generate centered text.
  }
}

class MyCustomPdfWidget extends StatelessWidget {
  MyCustomPdfWidget({
    required this.progressColor,
    required this.title,
    required this.quantity,
    required this.progressValue,
    required this.totalValue,
  });
  final PdfColor progressColor;
  final String title;
  final double quantity;
  final double progressValue;
  final double totalValue;
  @override
  Widget build(Context context) {
    // Compose the widget using pdfx's widgets and styling
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 85,
          height: 85,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19),
              border: Border.all(
                color: PdfColor.fromHex("#AFD3E2"),
              )),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 65,
                width: 65,
                child: CircularProgressIndicator(
                  value: progressValue == 0.0
                      ? 0
                      : (progressValue / 7) / totalValue > 1
                          ? 1
                          : (progressValue / 7) / totalValue,
                  strokeWidth: 6,
                  backgroundColor: PdfColor.fromHex("#E9E9E9"),
                  color: progressColor,
                ),
              ),
              Text(
                '${(quantity / 7).toPrecision(1)} g',
                style: const TextStyle(
                  color: PdfColors.black,
                  fontSize: 13,
                  height: 0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          title,
          style: TextStyle(
            color: PdfColor.fromHex("#454545"),
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class PdfModel {
  String name;
  int age;
  String weightUnit;
  int startingweight;
  String startingDate;
  int currentweight;
  String currentDate;
  int goalweight;
  String goalDate;
  double totalAvg;
  double carbs;
  double fat;
  double protien;
  double goalCarbs;
  double goalFat;
  double goalProtien;
  String aveSleep;
  double aveExercise;
  PdfModel({
    required this.name,
    required this.age,
    required this.weightUnit,
    required this.startingweight,
    required this.startingDate,
    required this.currentweight,
    required this.currentDate,
    required this.goalweight,
    required this.goalDate,
    required this.totalAvg,
    required this.carbs,
    required this.fat,
    required this.protien,
    required this.goalCarbs,
    required this.goalFat,
    required this.goalProtien,
    required this.aveSleep,
    required this.aveExercise,
  });
}
