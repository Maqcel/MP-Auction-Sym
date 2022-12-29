// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Strings {
  Strings();

  static Strings? _current;

  static Strings get current {
    assert(_current != null,
        'No instance of Strings was loaded. Try to initialize the Strings delegate before accessing Strings.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Strings> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Strings();
      Strings._current = instance;

      return instance;
    });
  }

  static Strings of(BuildContext context) {
    final instance = Strings.maybeOf(context);
    assert(instance != null,
        'No instance of Strings present in the widget tree. Did you add Strings.delegate in localizationsDelegates?');
    return instance!;
  }

  static Strings? maybeOf(BuildContext context) {
    return Localizations.of<Strings>(context, Strings);
  }

  /// `MP Subject Project`
  String get titleBarText {
    return Intl.message(
      'MP Subject Project',
      name: 'titleBarText',
      desc: '',
      args: [],
    );
  }

  /// `Waiting time: {hour}:{minutes}:{seconds}`
  String timeWaitingInQueText(String hour, String minutes, String seconds) {
    return Intl.message(
      'Waiting time: $hour:$minutes:$seconds',
      name: 'timeWaitingInQueText',
      desc: '',
      args: [hour, minutes, seconds],
    );
  }

  /// `File size: {size}`
  String clientFilesSizeText(int size) {
    return Intl.message(
      'File size: $size',
      name: 'clientFilesSizeText',
      desc: '',
      args: [size],
    );
  }

  /// `Amount of files: {amount}`
  String clientFilesAmountText(int amount) {
    return Intl.message(
      'Amount of files: $amount',
      name: 'clientFilesAmountText',
      desc: '',
      args: [amount],
    );
  }

  /// `Occupied by:\n{id}`
  String auctionServerUploadingClientText(int id) {
    return Intl.message(
      'Occupied by:\n$id',
      name: 'auctionServerUploadingClientText',
      desc: '',
      args: [id],
    );
  }

  /// `Waiting...`
  String get auctionServerNoClientText {
    return Intl.message(
      'Waiting...',
      name: 'auctionServerNoClientText',
      desc: '',
      args: [],
    );
  }

  /// `Client: {id}`
  String clientTileIdText(String id) {
    return Intl.message(
      'Client: $id',
      name: 'clientTileIdText',
      desc: '',
      args: [id],
    );
  }

  /// `Add Client`
  String get titleBarActionButtonText {
    return Intl.message(
      'Add Client',
      name: 'titleBarActionButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Select Client for detailed info`
  String get sideBarClientNotSelected {
    return Intl.message(
      'Select Client for detailed info',
      name: 'sideBarClientNotSelected',
      desc: '',
      args: [],
    );
  }

  /// `All waiting Clients will be shown here!`
  String get clientsEmptyText {
    return Intl.message(
      'All waiting Clients will be shown here!',
      name: 'clientsEmptyText',
      desc: '',
      args: [],
    );
  }

  /// `Client Files:`
  String get sideBarFilesHeaderText {
    return Intl.message(
      'Client Files:',
      name: 'sideBarFilesHeaderText',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Strings> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Strings> load(Locale locale) => Strings.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
