import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meta/meta.dart';
import 'package:user_clinic_token_app/utils/app_locator.dart';

import 'base_change_notifier.dart';

class BaseView<T extends BaseChangeNotifier> extends StatelessWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Function(T) ?onModelReady;

  final T model = locator<T>();

  BaseView({required this.builder,  this.onModelReady});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) {
        if (onModelReady != null) {
          onModelReady!(model);
        }
        return model;
      },
      child: Consumer<T>(builder: builder),
    );
  }
}
