import 'package:flutter/material.dart';
import 'package:pocket_pos/utils/images.dart';

import '../../model/country_model.dart';

class CountryNotifier extends ChangeNotifier {

  Map<String, String> countryToCurrency = {
    'India': '\u{20B9}',
    'UAE': '\u{062F}.\u{002E}\u{0625}',
    'KSA': '\u{0631}.\u{002E}\u{0633}',
    'Bahrain': '\u{062F}.\u{002E}',
    'Qatar': '\u{0631}.\u{002E}\u{0642}',
  };
  Map<String, String> countryToFlag = {
    'India': india,
    'UAE': uae,
    'KSA': ksa,
    'Bahrain': baharain,
    'Qatar': qatar,
  };

  Map<String, String> countryToCountry = {
    'India': 'India',
    'UAE': 'UAE',
    'KSA': 'KSA',
    'Bahrain': 'Bahrain',
    'Qatar': 'Qatar',
  };

  String _selectedCountry='Select a country';

  String get selectedCountry => _selectedCountry;

  set selectedCountry(String country,) {
    _selectedCountry = country;
    notifyListeners();
  }

  String get selectedCountries {
    return countryToCountry[_selectedCountry] ?? '';
  }

  String get selectedCurrency {
    return countryToCurrency[_selectedCountry] ?? '';
  }

}