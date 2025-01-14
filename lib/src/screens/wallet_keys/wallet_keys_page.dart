import 'package:auto_size_text/auto_size_text.dart';
import 'package:cake_wallet/utils/show_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:cake_wallet/generated/i18n.dart';
import 'package:cake_wallet/src/screens/base_page.dart';
import 'package:cake_wallet/src/widgets/standart_list_row.dart';
import 'package:cake_wallet/view_model/wallet_keys_view_model.dart';

class WalletKeysPage extends BasePage {
  WalletKeysPage(this.walletKeysViewModel);

  @override
  String get title => walletKeysViewModel.title;

  final WalletKeysViewModel walletKeysViewModel;

  @override
  Widget body(BuildContext context) {
    return Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  color: Theme.of(context).accentTextTheme!.caption!.color!,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutoSizeText(
                        S.of(context).do_not_share_warning_text.toUpperCase(),
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(
                          fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.red)),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
          child: Container(
        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: Observer(
          builder: (_) {
            return ListView.separated(
                separatorBuilder: (context, index) => Container(
                      height: 1,
                      padding: EdgeInsets.only(left: 24),
                      color: Theme.of(context).accentTextTheme!.headline6!.backgroundColor!,
                      child: Container(
                        height: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                itemCount: walletKeysViewModel.items.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = walletKeysViewModel.items[index];

                  return GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: item.value));
                      showBar<void>(context, S.of(context).copied_key_to_clipboard(item.title));
                    },
                    child: StandartListRow(
                      title: item.title + ':',
                      value: item.value,
                    ),
                  );
                });
          },
        )))]);
  }
}
