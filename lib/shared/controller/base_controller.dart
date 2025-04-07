import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_task/l10n/app_localizations.dart';
import 'package:flutter_task/shared/helpers/modal_view.dart';
import 'package:flutter_task/shared/widget/app_modal_alert.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

part 'notifications.dart';

class BaseController extends ChangeNotifier with _NotificationsNotifier {
  BaseController();

  @protected
  @visibleForOverriding
  @mustBeOverridden
  String get name => 'BaseController';

  @protected
  Logger get logger => Logger(name);

  @override
  void dispose() {
    _notificationController.close();
    super.dispose();
  }

  void addError(Object error, [StackTrace? stackTrace]) {
    logger.severe(error, stackTrace);
  }

  @override
  void showError(String message) {
    logger.warning(message);
    super.showError(message);
  }

  void init(BuildContext context) {
    onNotification(context);
  }

  String? validateEmpty(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.loc.validateEmpty;
    } else {
      return null;
    }
  }

  String? validatePassword(String? value, BuildContext context) {
    final List<String> errors = [];

    if (value == null) {
      return context.loc.emptyPassword;
    }

    if (value.length < 8) {
      errors.add(context.loc.minEightCharacters);
    }

    if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
      errors.add(context.loc.labelUpper);
    }

    if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
      errors.add(context.loc.labelLower);
    }

    if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
      errors.add(context.loc.anyNumber);
    }

    if (!RegExp(r'^(?=.*[@$!%*?&])').hasMatch(value)) {
      errors.add(context.loc.specialCharacter);
    }

    if (errors.isEmpty) {
      return null;
    }

    return '${context.loc.invalidPassword}:\n${errors.join('.\n')}';
  }

  String? validateList(List<dynamic> value, BuildContext context) {
    if (value.isEmpty) {
      return context.loc.validateList;
    } else {
      return null;
    }
  }

  String? validateEmail(String value, BuildContext context) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return context.loc.validateEmail;
    }
    return null;
  }
}

// extension LocalizationExtension on BuildContext {
//   AppLocalizations get loc => AppLocalizations.of(this);

//   String tr(String key) => AppLocalizations.of(this).translate(key);
// }
extension LocalizationExtension on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;
}
