import 'package:flutter/material.dart';

import 'strings/strings.dart';

class R {
  static Translations string = PtBr();

  static void load(Locale locale) {
    switch (locale.languageCode) {
      // case 'en_US':
      //   strings = EnUs();
      //   break;
      case 'pt_BR':
        string = PtBr();
        break;
      default:
        string = PtBr();
        break;
    }
  }
}
