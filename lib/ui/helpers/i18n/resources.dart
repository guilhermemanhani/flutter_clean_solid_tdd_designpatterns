import 'package:flutter/material.dart';

import 'strings/strings.dart';

class R {
  static Translations strings = PtBr();

  static void load(Locale locale) {
    switch (locale.languageCode) {
      // case 'en_US':
      //   strings = EnUs();
      //   break;
      case 'pt_BR':
        strings = PtBr();
        break;
      default:
        strings = PtBr();
        break;
    }
  }
}
