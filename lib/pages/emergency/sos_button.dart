import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';

class SosButton extends StatelessWidget {
  final onTap;

  const SosButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(500))),
      onTap: onTap,
      child: Container(
        width: ScreenUtil().setWidth(850),
        height: ScreenUtil().setWidth(850),
        decoration: BoxDecoration(
          border: Border.all(
              width: 22.0, color: Colors.redAccent.shade100.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(450)),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                width: 21.0, color: Colors.redAccent.withOpacity(0.6)),
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(450)),
          ),
          child: Container(
            decoration: BoxDecoration(
              border:
                  Border.all(width: 20.0, color: Colors.red.withOpacity(0.8)),
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(450)),
            ),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.redAccent.shade700,
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(450)),
              ),
              child: Text(
                AppLocalizations.of(context)!.translate('sos_lbl'),
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(130),
                  fontWeight: FontWeight.w900,
                  color: Colors.grey.shade200,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
