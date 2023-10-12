import 'dart:convert';
import 'dart:io';

import 'package:epandu/common_library/services/model/auth_model.dart';
import 'package:epandu/common_library/services/model/provider_model.dart';
import 'package:epandu/common_library/services/repository/epandu_repository.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:epandu/common_library/utils/loading_model.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:auto_route/auto_route.dart';
import '../../router.gr.dart';

@RoutePage(name: 'Scan')
class Scan extends StatefulWidget {
  final getDiProfile;
  final getActiveFeed;

  const Scan({
    this.getActiveFeed,
    this.getDiProfile,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final epanduRepo = EpanduRepo();
  final customDialog = CustomDialog();
  final localStorage = LocalStorage();

  bool _isLoading = false;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR'),
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(child: _buildQrView(context)),
            ],
          ),
          LoadingModel(
            isVisible: _isLoading,
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 500.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  Future<void> _onQRViewCreated(QRViewController controller) async {
    setState(() {
      this.controller = controller;
    });
    await controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) async {
      await controller.pauseCamera();
      String? merchantNo = await localStorage.getMerchantDbCode();

      try {
        CheckInScanResponse checkInScanResponse =
            CheckInScanResponse.fromJson(jsonDecode(scanData.code!));

        print(jsonDecode(scanData.code!)['QRCode'][0]['merchant_no']);

        if (jsonDecode(scanData.code!).containsKey('QRCode')) {
          if (!context.mounted) return;
          context.router
              .replace(
            RegisterUserToDi(
              barcode: scanData.code,
            ),
          )
              .then((value) {
            widget.getActiveFeed();
            widget.getDiProfile();
          });
        } else {
          if (merchantNo ==
              jsonDecode(scanData.code!)['QRCode'][0]['merchant_no']) {
            _scanResult(
                checkInScanResponse: checkInScanResponse, scanData: scanData);
          } else {
            invalidQr(type: 'MISMATCH');
          }
        }
      } catch (e) {
        invalidQr();
      }
    });
  }

// {"QRCode":[{"appId": "ePandu.MID", "merchantDbCode": "P1001", "merchantName":"IDI"}]}

  Future _scanResult(
      {required CheckInScanResponse checkInScanResponse,
      required Barcode scanData}) async {
    switch (checkInScanResponse.table1![0].action) {
      case 'JPJ_PART2_CHECK_IN':
        Provider.of<HomeLoadingModel>(context, listen: false)
            .loadingStatus(true);

        String? icNo = await localStorage.getStudentIc();

        if (icNo != null && icNo.isNotEmpty) {
          setState(() {
            _isLoading = true;
          });
          if (!context.mounted) return;
          final result = await epanduRepo.verifyScanCode(
            context: context,
            qrcodeJson: scanData.code,
            icNo: icNo,
          );

          if (result.isSuccess) {
            /* customDialog.show(
                  context: context,
                  title: Text(
                    '${AppLocalizations.of(context).translate('checked_in_on')}: ' +
                        '${result.data[0].regDate.substring(0, 10)}:' +
                        '${result.data[0].regDate.substring(11, 20)}',
                    style: TextStyle(
                      color: Colors.green[800],
                    ),
                  ),
                  content: AppLocalizations.of(context)
                          .translate('check_in_successful') +
                      '${result.data[0].queueNo}' +
                      '\n' +
                      AppLocalizations.of(context).translate('name_lbl') +
                      ': ${result.data[0].fullname}' +
                      '\nNRIC: ${result.data[0].nricNo}' +
                      '\n' +
                      AppLocalizations.of(context).translate('group_id') +
                      ': ${result.data[0].groupId}',
                  customActions: [
                    TextButton(
                      child: Text(
                          AppLocalizations.of(context).translate('ok_btn')),
                      onPressed: () => ExtendedNavigator.of(context).pop(),
                    ),
                  ],
                  type: DialogType.GENERAL,
                ); */
            if (!context.mounted) return;
            context.router.replace(
              QueueNumber(data: result.data),
            );
          } else {
            if (!context.mounted) return;
            customDialog.show(
              context: context,
              barrierDismissable: false,
              content: result.message!,
              onPressed: () {
                context.router.pop();

                controller!.resumeCamera();
              },
              type: DialogType.info,
            );

            setState(() {
              _isLoading = false;
            });
          }
        } else {
          if (!context.mounted) return;
          customDialog.show(
            context: context,
            barrierDismissable: false,
            content: AppLocalizations.of(context)!
                .translate('complete_your_profile'),
            customActions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.translate('ok_btn')),
                onPressed: () => context.router.push(
                  const UpdateProfile(),
                ),
              ),
            ],
            type: DialogType.general,
          );
        }

        Provider.of<HomeLoadingModel>(context, listen: false)
            .loadingStatus(false);

        break;
      default:
        context.router
            .replace(
          RegisterUserToDi(
            barcode: scanData.code,
          ),
        )
            .then((value) {
          widget.getActiveFeed();
          widget.getDiProfile();
        });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  invalidQr({String? type}) {
    if (type == 'MISMATCH') {
      return customDialog.show(
        barrierDismissable: false,
        context: context,
        content: AppLocalizations.of(context)!.translate('mismatch_di'),
        title: Icon(Icons.warning, size: 120, color: Colors.yellow[700]),
        customActions: [
          TextButton(
            onPressed: () {
              context.router.pop();

              controller!.resumeCamera();
            },
            child: const Text('Ok'),
          ),
        ],
        type: DialogType.general,
      );
    }
    return customDialog.show(
      barrierDismissable: false,
      context: context,
      content: AppLocalizations.of(context)!.translate('invalid_qr'),
      title: Icon(Icons.warning, size: 120, color: Colors.red[700]),
      customActions: [
        TextButton(
          onPressed: () {
            context.router.pop();

            controller!.resumeCamera();
          },
          child: const Text('Ok'),
        ),
      ],
      type: DialogType.general,
    );
  }
}
