import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:share/share.dart';
import 'package:printing/printing.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

@RoutePage(name: 'ViewPdf')
class ViewPdf extends StatefulWidget {
  final String? title;
  final String? pdfLink;

  const ViewPdf({super.key, required this.title, required this.pdfLink});

  @override
  _ViewPdfState createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  final primaryColor = ColorConstant.primaryColor;
  final customDialog = CustomDialog();
  late var pdfController;

  // String? _pdfName;
  late Uint8List _pdfByte;
  String _pathPdf = '';

  @override
  void initState() {
    super.initState();

    _viewPdf(widget.pdfLink);
  }

  Future<void> _viewPdf(pdfLink) async {
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();

    final filename = pdfLink.substring(pdfLink.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(pdfLink));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = appDocumentDir.path;
    File file = File('$dir/$filename');
    await file.writeAsBytes(bytes);

    setState(() {
      // _pdfName = filename;
      _pdfByte = bytes;
      _pathPdf = file.path;
      pdfController = PdfController(
        // document: PdfDocument.openAsset(file.path),
        document: PdfDocument.openFile(file.path),
      );
    });

    // return file;
  }

  _sharePdf() async {
    try {
      await Share.shareFiles([_pathPdf], text: widget.title);
    } catch (e) {
      print('error $e');
      if (!context.mounted) return;
      customDialog.show(
        context: context,
        content: 'Failed to share pdf file. Please try again.',
        type: DialogType.ERROR,
      );
    }
  }

  _printPdf() async {
    await Printing.layoutPdf(onLayout: (_) => _pdfByte);
  }

  Widget pdfView() {
    if (_pathPdf.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("PDF"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.print),
              onPressed: _printPdf,
            ),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: _sharePdf,
            ),
          ],
        ),
        body: PdfView(
          controller: pdfController,
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: SpinKitFoldingCube(color: primaryColor)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return pdfView();
  }
}
