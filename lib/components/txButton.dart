import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settpay_sdk/utils/i18n.dart';
import 'package:settpay_ui/components/roundedButton.dart';
import 'package:settpay_ui/pages/txConfirmPage.dart';
import 'package:settpay_ui/utils/i18n.dart';

class TxConfirmParams {
  TxConfirmParams({
    this.module,
    this.call,
    this.txDisplay,
    this.params,
    this.rawParams,
    this.isUnsigned,
    this.txTitle,
    this.txName,
  });
  final String module;
  final String call;
  final List params;
  final String rawParams;
  final bool isUnsigned;
  final Map txDisplay;
  final String txTitle;
  final String txName;
}

class TxButton extends StatelessWidget {
  TxButton({
    this.text,
    this.getTxParams,
    this.onFinish,
    this.icon,
    this.color,
  });

  final String text;
  final Future<TxConfirmParams> Function() getTxParams;
  final Function(Map) onFinish;
  final Widget icon;
  final Color color;

  Future<void> _onPressed(BuildContext context) async {
    final params = await getTxParams();
    if (params != null) {
      final res = await Navigator.of(context)
          .pushNamed(TxConfirmPage.route, arguments: params);
      onFinish(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      text: text ??
          I18n.of(context).getDic(i18n_full_dic_ui, 'common')['tx.submit'],
      icon: icon,
      color: color,
      onPressed: () {
        _onPressed(context);
      },
    );
  }
}
