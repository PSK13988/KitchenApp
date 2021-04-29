import 'dart:async';
import 'dart:convert';

import 'package:flutterrestaurant/api/common/ps_api_reponse.dart';
import 'package:flutterrestaurant/api/common/ps_resource.dart';
import 'package:flutterrestaurant/api/ps_url.dart';
import 'package:flutterrestaurant/config/ps_colors.dart';
import 'package:flutterrestaurant/config/ps_config.dart';
import 'package:flutterrestaurant/constant/ps_dimens.dart';
import 'package:flutterrestaurant/provider/transaction/transaction_header_provider.dart';
import 'package:flutterrestaurant/repository/transaction_header_repository.dart';
import 'package:flutterrestaurant/ui/common/dialog/error_dialog.dart';
import 'package:flutterrestaurant/utils/ps_progress_dialog.dart';
import 'package:flutterrestaurant/utils/utils.dart';
import 'package:flutterrestaurant/viewobject/common/ps_value_holder.dart';
import 'package:flutterrestaurant/viewobject/transaction_header.dart';
import 'package:flutterrestaurant/ui/common/dialog/warning_dialog_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class TransactionListItem extends StatefulWidget {
  const TransactionListItem({
    Key key,
    @required this.transaction,
    this.animationController,
    this.animation,
    this.onTap,
    this.onCancelTap,
    @required this.scaffoldKey,
  }) : super(key: key);

  final TransactionHeader transaction;
  final Function onTap;
  final Function onCancelTap;
  final AnimationController animationController;
  final Animation<double> animation;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  _TransactionListItemState createState() => _TransactionListItemState();
}

class _TransactionListItemState extends State<TransactionListItem> {
  @override
  Widget build(BuildContext context) {
    widget.animationController.forward();
    if (widget.transaction != null && widget.transaction.transCode != null) {
      return AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: widget.animation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 100 * (1.0 - widget.animation.value), 0.0),
                child: GestureDetector(
                  onTap: widget.onTap,
                  child: Container(
                    color: PsColors.backgroundColor,
                    margin: const EdgeInsets.only(top: PsDimens.space8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _TransactionNoWidget(
                          transaction: widget.transaction,
                          scaffoldKey: widget.scaffoldKey,
                        ),
                        const Divider(
                          height: PsDimens.space1,
                        ),
                        _TransactionTextWidget(
                          transaction: widget.transaction,
                          onCancelPressed: widget.onCancelTap,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    } else {
      return Container();
    }
  }
}

class _TransactionNoWidget extends StatelessWidget {
  const _TransactionNoWidget({
    Key key,
    @required this.transaction,
    @required this.scaffoldKey,
  }) : super(key: key);

  final TransactionHeader transaction;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final Widget _textWidget = Text(
      '${Utils.getString(context, 'transaction_detail__trans_no')} : ${transaction.transCode}' ??
          '-',
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.subtitle2,
    );

    return Padding(
      padding: const EdgeInsets.only(
          left: PsDimens.space12,
          right: PsDimens.space4,
          top: PsDimens.space4,
          bottom: PsDimens.space4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Icon(
                Icons.offline_pin,
                size: PsDimens.space24,
              ),
              const SizedBox(
                width: PsDimens.space8,
              ),
              _textWidget,
            ],
          ),
          IconButton(
            icon: const Icon(Icons.content_copy),
            iconSize: 24,
            onPressed: () {
              Clipboard.setData(ClipboardData(text: transaction.transCode));
              scaffoldKey.currentState.showSnackBar(SnackBar(
                backgroundColor: Theme.of(context).iconTheme.color,
                content: Tooltip(
                  message: Utils.getString(context, 'transaction_detail__copy'),
                  child: Text(
                    Utils.getString(context, 'transaction_detail__copied_data'),
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: PsColors.mainColor),
                  ),
                  showDuration: const Duration(seconds: 5),
                ),
              ));
            },
          ),
        ],
      ),
    );
  }
}

class _TransactionTextWidget extends StatefulWidget {
  const _TransactionTextWidget({
    Key key,
    @required this.transaction,
    @required this.onCancelPressed,
  }) : super(key: key);

  final TransactionHeader transaction;
  final Function onCancelPressed;

  @override
  __TransactionTextWidgetState createState() => __TransactionTextWidgetState(onCancelPressed);
}

class __TransactionTextWidgetState extends State<_TransactionTextWidget> {
  __TransactionTextWidgetState(this.onCancelPressed);
  Function onCancelPressed;
  int _difference;
  @override
  Widget build(BuildContext context) {

    const EdgeInsets _paddingEdgeInsetWidget = EdgeInsets.only(
      left: PsDimens.space16,
      right: PsDimens.space16,
      top: PsDimens.space8,
    );

    final Widget _totalAmountTextWidget = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          Utils.getString(context, 'transaction_list__total_amount'),
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(fontWeight: FontWeight.normal),
        ),
        Text(
          '${widget.transaction.currencySymbol} ${Utils.getPriceFormat(widget.transaction.balanceAmount)}' ??
              '-',
          style: Theme.of(context).textTheme.bodyText2.copyWith(
              color: PsColors.mainColor, fontWeight: FontWeight.normal),
        )
      ],
    );

    final Widget _statusTextWidget = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          Utils.getString(context, 'transaction_detail__status'),
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(fontWeight: FontWeight.normal),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(
              top: PsDimens.space4,
              bottom: PsDimens.space4,
              right: PsDimens.space12,
              left: PsDimens.space12),
          decoration: BoxDecoration(
              color: Utils.hexToColor(widget.transaction.transStatus.colorValue),
              // border: Border.all(color: PsColors.mainLightShadowColor),
              borderRadius:
                  const BorderRadius.all(Radius.circular(PsDimens.space8))),
          child: Text(
            widget.transaction.transStatus.title ?? '-',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: PsColors.black),
          ),
        )
      ],
    );

    final Widget _viewDetailTextWidget = Text(
      Utils.getString(context, 'transaction_detail__view_details'),
      style: Theme.of(context).textTheme.caption.copyWith(
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.underline,
          ),
    );

    final Widget _cancelOrderTextWidget = RaisedButton(child:Text(
      Utils.getString(context, 'transaction_detail__cancel_order'),
      style: Theme.of(context).textTheme.subtitle1.copyWith(
        fontWeight: FontWeight.normal,
      ),
    ),onPressed: widget.onCancelPressed,);

    final Widget _cancelOrderNotWorkingTextWidget = RaisedButton(child:Text(
      Utils.getString(context, 'transaction_detail__cancel_order'),
      style: Theme.of(context).textTheme.subtitle1.copyWith(
        fontWeight: FontWeight.normal,
      ),
    ),onPressed: () {
      callWarningDialog(context,
          Utils.getString(context, 'warning_dialog__cancel_order_message'));
    },);

    if (widget.transaction != null && widget.transaction.transCode != null) {
      final DateTime date = DateTime.parse(widget.transaction.addedDate);
      final DateTime date2 = DateTime.now();
      _difference = date2.difference(date).inMinutes;
      final _2hourDifference = date2.difference(date).inHours;
      if(widget.transaction.transStatus.title != 'Order Accepted' && widget.transaction.transStatus.title != 'Order Cancelled' &&
          _difference < 1) {
        print('Cancel order ${widget.transaction.addedDate} ${widget.transaction
            .addedDate} Total: ${widget.transaction.balanceAmount}: $_difference');
        // ignore: always_specify_types
        Future.delayed(const Duration(minutes: 1), () {
          print('Psk timeout');
          if (mounted) {
            setState(() {
              _difference = 9999999;
            });
          }
          print('Psk timeout $_difference');
        });
      }
      // else
      //   print('Order to older to show Cancel order: $_difference');



      return Column(
        children: <Widget>[
          Padding(
            padding: _paddingEdgeInsetWidget,
            child: _totalAmountTextWidget,
          ),
          Padding(
            padding: _paddingEdgeInsetWidget,
            child: _statusTextWidget,
          ),
          Padding(
            padding: _paddingEdgeInsetWidget,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _viewDetailTextWidget,
              ],
            ),
          ),
          Padding(
            padding: _paddingEdgeInsetWidget,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (widget.transaction.transStatus.title != 'Order Accepted'
                    && widget.transaction.transStatus.title != 'Order Cancelled')
                  if(_difference < 1)
                   _cancelOrderTextWidget
                  else if(_2hourDifference < 2)_cancelOrderNotWorkingTextWidget
              ],
            ),
          ),
          const SizedBox(
            height: PsDimens.space8,
          )
        ],
      );
    } else {
      return Container();
    }
  }

  void oneMinuteTime(){
    callWarningDialog(context,
        Utils.getString(context, 'warning_dialog__cancel_order_message'));
  }

  dynamic callWarningDialog(BuildContext context, String text) {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return WarningDialog(
            message: Utils.getString(context, text),
          );
        });
  }

}
