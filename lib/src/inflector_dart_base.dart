class Inflector {
  static final List<String> _uncountableWords = [
    'equipment',
    'information',
    'rice',
    'money',
    'species',
    'series',
    'fish',
    'sheep',
    'moose',
    'deer',
    'news',
  ];

  static final List<List<dynamic>> _pluralRules = [
    [RegExp(r'(m)an$', caseSensitive: false), r'$1en'],
    [RegExp(r'(pe)rson$', caseSensitive: false), r'$1ople'],
    [RegExp(r'(child)$', caseSensitive: false), r'$1ren'],
    [RegExp(r'^(ox)$', caseSensitive: false), r'$1en'],
    [RegExp(r'(ax|test)is$', caseSensitive: false), r'$1es'],
    [RegExp(r'(octop|vir)us$', caseSensitive: false), r'$1i'],
    [RegExp(r'(alias|status)$', caseSensitive: false), r'$1es'],
    [RegExp(r'(bu)s$', caseSensitive: false), r'$1ses'],
    [RegExp(r'(buffal|tomat|potat)o$', caseSensitive: false), r'$1oes'],
    [RegExp(r'([ti])um$', caseSensitive: false), r'$1a'],
    [RegExp(r'sis$', caseSensitive: false), 'ses'],
    [RegExp(r'(?:([^f])fe|([lr])f)$', caseSensitive: false), r'$1$2ves'],
    [RegExp(r'(hive)$', caseSensitive: false), r'$1s'],
    [RegExp(r'([^aeiouy]|qu)y$', caseSensitive: false), r'$1ies'],
    [RegExp(r'(x|ch|ss|sh)$', caseSensitive: false), r'$1es'],
    [RegExp(r'(matr|vert|ind)ix|ex$', caseSensitive: false), r'$1ices'],
    [RegExp(r'([m|l])ouse$', caseSensitive: false), r'$1ice'],
    [RegExp(r'(quiz)$', caseSensitive: false), r'$1zes'],
    [RegExp(r's$', caseSensitive: false), 's'],
    [RegExp(r'$', caseSensitive: false), 's'],
  ];

  static final List<List<dynamic>> _singularRules = [
    [RegExp(r'(m)en$', caseSensitive: false), r'$1an'],
    [RegExp(r'(pe)ople$', caseSensitive: false), r'$1rson'],
    [RegExp(r'(child)ren$', caseSensitive: false), r'$1'],
    [RegExp(r'([ti])a$', caseSensitive: false), r'$1um'],
    [
      RegExp(
        r'((a)naly|(b)a|(d)iagno|(p)arenthe|(p)rogno|(s)ynop|(t)he)ses$',
        caseSensitive: false,
      ),
      r'$1$2sis',
    ],
    [RegExp(r'(hive)s$', caseSensitive: false), r'$1'],
    [RegExp(r'(tive)s$', caseSensitive: false), r'$1'],
    [RegExp(r'(curve)s$', caseSensitive: false), r'$1'],
    [RegExp(r'([lr])ves$', caseSensitive: false), r'$1f'],
    [RegExp(r'([^fo])ves$', caseSensitive: false), r'$1fe'],
    [RegExp(r'([^aeiouy]|qu)ies$', caseSensitive: false), r'$1y'],
    [RegExp(r'(s)eries$', caseSensitive: false), r'$1eries'],
    [RegExp(r'(m)ovies$', caseSensitive: false), r'$1ovie'],
    [RegExp(r'(x|ch|ss|sh)es$', caseSensitive: false), r'$1'],
    [RegExp(r'([m|l])ice$', caseSensitive: false), r'$1ouse'],
    [RegExp(r'(bus)es$', caseSensitive: false), r'$1'],
    [RegExp(r'(o)es$', caseSensitive: false), r'$1'],
    [RegExp(r'(shoe)s$', caseSensitive: false), r'$1'],
    [RegExp(r'(cris|ax|test)es$', caseSensitive: false), r'$1is'],
    [RegExp(r'(octop|vir)i$', caseSensitive: false), r'$1us'],
    [RegExp(r'(alias|status)es$', caseSensitive: false), r'$1'],
    [RegExp(r'^(ox)en', caseSensitive: false), r'$1'],
    [RegExp(r'(vert|ind)ices$', caseSensitive: false), r'$1ex'],
    [RegExp(r'(matr)ices$', caseSensitive: false), r'$1ix'],
    [RegExp(r'(quiz)zes$', caseSensitive: false), r'$1'],
    [RegExp(r's$', caseSensitive: false), ''],
  ];

  static final List<String> nonTitlecasedWords = [
    'and',
    'or',
    'nor',
    'a',
    'an',
    'the',
    'so',
    'but',
    'to',
    'of',
    'at',
    'by',
    'from',
    'into',
    'on',
    'onto',
    'off',
    'out',
    'in',
    'over',
    'with',
    'for',
  ];

  static final RegExp _idSuffix = RegExp(r'(_ids|_id)$');
  static final RegExp _underbar = RegExp(r'_');
  static final RegExp _spaceOrUnderbar = RegExp(r'[ _]');

  // Apply rules (core)
  static String _applyRules(
    String str,
    List<List<dynamic>> rules,
    List<String> skip, [
    String? override,
  ]) {
    if (override != null) {
      return override;
    }

    if (skip.contains(str.toLowerCase())) {
      return str;
    }

    for (var rule in rules) {
      RegExp pattern = rule[0];
      String replacement = rule[1];

      if (pattern.hasMatch(str)) {
        str = str.replaceAllMapped(pattern, (match) {
          // Ganti $1, $2 dst. dengan group capture dari match
          String result = replacement;
          for (int i = 1; i <= match.groupCount; i++) {
            result = result.replaceAll('\$${i}', match.group(i)!);
          }
          return result;
        });
        break;
      }
    }

    return str;
  }

  /// Returns the plural form of [str].
  ///
  /// If [plural] is provided, it will be used as the plural form.
  ///
  /// Otherwise, the plural form will be determined by the rules in [_pluralRules].
  ///
  /// If [str] is in [_uncountableWords], it will not be pluralized.
  ///
  /// If [str] is empty, an empty string will be returned.
  ///
  /// Examples:
  /// ````dart
  /// Inflector.pluralize('person') => 'people'
  /// Inflector.pluralize('person', 'persons') => 'persons'
  /// Inflector.pluralize('octopus') => 'octopi'
  /// Inflector.pluralize('Hat') => 'Hats'
  /// Inflector.pluralize('person', 'guy') => 'guys'
  /// ```
  static String pluralize(String str, [String? plural]) {
    return _applyRules(str, _pluralRules, _uncountableWords, plural);
  }

  /// Returns the singular form of [str].
  ///
  /// If [singular] is provided, it will be used as the singular form.
  ///
  /// Otherwise, the singular form will be determined by the rules in [_singularRules].
  ///
  /// If [str] is in [_uncountableWords], it will not be singularized.
  ///
  /// If [str] is empty, an empty string will be returned.
  ///
  /// Examples:
  /// ````dart
  /// Inflector.singularize('person') => 'person'
  /// Inflector.singularize('octopi') => 'octopus'
  /// Inflector.singularize('Hats') => 'Hat'
  /// Inflector.singularize('guys', 'person') => 'person'
  /// ````
  static String singularize(String str, [String? singular]) {
    return _applyRules(str, _singularRules, _uncountableWords, singular);
  }

  /// Returns a camelized version of [str].
  ///
  /// If [lowFirstLetter] is true, the first letter of the resulting string will be lower case.
  ///
  /// If [str] is empty, an empty string will be returned.
  /// If [str] contains spaces, they will be replaced with underscores.
  ///
  /// The resulting string will contain double colons "::" between each component.
  ///
  /// Examples:
  /// ````dart
  /// Inflector.camelize('message_properties') => 'MessageProperties'
  /// Inflector.camelize('message_properties', lowFirstLetter: true) => 'messageProperties'
  /// ```
  ///
  static String camelize(String str, {bool lowFirstLetter = false}) {
    str = str.replaceAll(RegExp(r'\s+'), '_');
    var strPath = str.split('/');
    for (int i = 0; i < strPath.length; i++) {
      var strArr = strPath[i].split('_');
      int start = lowFirstLetter && i + 1 == strPath.length ? 1 : 0;
      for (int x = start; x < strArr.length; x++) {
        strArr[x] = strArr[x][0].toUpperCase() + strArr[x].substring(1);
      }
      strPath[i] = strArr.join('');
    }
    str = strPath.join('::');
    if (lowFirstLetter) {
      str = str[0].toLowerCase() + str.substring(1);
    }
    return str;
  }

  /// Return the underscored form of a string.
  ///
  /// Examples:
  /// ```dart
  /// Inflector.underscore('MessageProperties') => 'message_properties'
  /// Inflector.underscore('messageProperties') => 'message_properties'
  /// ```
  static String underscore(String str) {
    var withSpaces =
        str
            .replaceAllMapped(
              RegExp(r'([a-z])([A-Z])'),
              (m) => '${m[1]} ${m[2]}',
            )
            .toLowerCase();
    var cleaned = withSpaces.replaceAll(RegExp(r'[^0-9a-zA-Z]'), ' ');
    return cleaned.trim().replaceAll(RegExp(r'\s+'), '_');
  }

  /// Converts a string to a human-readable format.
  ///
  /// If [lowFirstLetter] is true, the first letter of the resulting string will be lower case.
  ///
  /// If [str] is empty, an empty string will be returned.
  ///
  /// Examples:
  /// ```dart
  /// Inflector.humanize('message_properties') => 'Message Properties'
  /// Inflector.humanize('message_properties', lowFirstLetter: true) => 'message properties'
  /// ```
  static String humanize(String str, {bool lowFirstLetter = false}) {
    str = underscore(
      str,
    ); // <-- tambahkan ini, untuk convert camelCase ke underscore
    str = str.replaceAll(_idSuffix, '');
    str = str.replaceAll(_underbar, ' ');

    if (!lowFirstLetter) {
      str = capitalize(str);
    } else if (str.isNotEmpty) {
      // pastikan huruf pertama tetap lowercase
      str = str[0].toLowerCase() + str.substring(1);
    }

    return str;
  }

  /// Capitalizes the first letter of a string, converting the rest to lowercase.
  ///
  /// If [str] is empty, an empty string will be returned.
  ///
  /// Examples:
  /// ```dart
  /// Inflector.capitalize('message_properties') => 'Message_properties'
  /// Inflector.capitalize('message properties') => 'Message properties'
  /// ```
  static String capitalize(String str) {
    if (str.isEmpty) return str;
    str = str.toLowerCase();
    return str[0].toUpperCase() + str.substring(1);
  }

  /// Replaces spaces or underscores in a string with dashes.
  ///
  /// If [str] is empty, an empty string will be returned.
  ///
  /// Examples:
  /// ```dart
  /// Inflector.dasherize('message_properties') => 'message-properties'
  /// Inflector.dasherize('message properties') => 'message-properties'
  /// ```
  static String dasherize(String str) {
    return str.replaceAll(_spaceOrUnderbar, '-');
  }

  /// Converts a camelCase or snake_case string to a space-separated string with title-case words.
  ///
  /// If [allFirstUpper] is true, the first letter of each word will be upper case.
  /// Otherwise, the first letter of each word will be lower case, unless it is a word
  /// that is not typically title-cased (see [nonTitlecasedWords]).
  ///
  /// Examples:
  /// ```dart
  /// Inflector.camelize('message_properties') => 'Message properties'
  /// Inflector.camelize('message_properties', allFirstUpper: true) => 'Message Properties'
  /// Inflector.camelize('message_propertiesId') => 'Message properties id'
  /// ```
  static String camel2words(String str, {bool allFirstUpper = false}) {
    if (allFirstUpper) {
      str = camelize(str);
      str = underscore(str);
    } else {
      str = str.toLowerCase();
    }

    str = str.replaceAll(_underbar, ' ');
    var strArr = str.split(' ');

    for (int x = 0; x < strArr.length; x++) {
      var d = strArr[x].split('-');
      for (int i = 0; i < d.length; i++) {
        if (!nonTitlecasedWords.contains(d[i].toLowerCase())) {
          d[i] = capitalize(d[i]);
        }
      }
      strArr[x] = d.join('-');
    }

    str = strArr.join(' ');

    if (str.isNotEmpty) {
      str = str[0].toUpperCase() + str.substring(1);
    }

    return str;
  }

  /// Removes the module part of a qualified name.
  ///
  /// If [str] does not contain '::', the original string will be returned.
  ///
  /// Examples:
  /// ```dart
  /// Inflector.demodulize('Message::Bus::Properties') => 'Properties'
  /// ```
  static String demodulize(String str) {
    var parts = str.split('::');
    return parts.isNotEmpty ? parts.last : str;
  }

  /// Converts a string to its table name form by underscoring and pluralizing it.
  ///
  /// This is useful for generating table names from class names.
  ///
  /// Examples:
  /// ```dart
  /// Inflector.tableize('MessageBusProperty') => 'message_bus_properties'
  /// ```
  static String tableize(String str) {
    return pluralize(underscore(str));
  }

  /// Converts a string to its camelCase form and then singularizes it.
  ///
  /// Examples:
  /// ```dart
  /// Inflector.classify('message_bus_properties') => 'MessageBusProperty'
  /// ```
  static String classify(String str) {
    return singularize(camelize(str));
  }

  /// Converts a class name to its foreign key form.
  ///
  /// The foreign key name is constructed by taking the demodulized
  /// class name and appending '_id' to it. If [dropIdUbar] is true,
  /// the underscore will not be appended.
  ///
  /// Examples:
  /// ```dart
  /// Inflector.foreignKey('MessageBusProperty') => 'message_bus_properties_id'
  /// Inflector.foreignKey('MessageBusProperty', dropIdUbar: true) => 'message_bus_properties'
  /// ```
  static String foreignKey(String str, {bool dropIdUbar = false}) {
    return underscore(demodulize(str)) + (dropIdUbar ? '' : '_') + 'id';
  }

  /// Ordinalizes a string by replacing numbers with their ordinal suffixes.
  ///
  /// Examples:
  /// ```dart
  /// Inflector.ordinalize('the 1 pitch') => 'the 1st pitch
  /// Inflector.ordinalize('1') => '1st'
  /// Inflector.ordinalize('2') => '2nd'
  /// Inflector.ordinalize('3') => '3rd'
  /// Inflector.ordinalize('4') => '4th'
  /// Inflector.ordinalize('11') => '11th'
  /// Inflector.ordinalize('12') => '12th'
  /// ```
  static String ordinalize(String str) {
    var parts = str.split(' ');
    for (int i = 0; i < parts.length; i++) {
      var n = int.tryParse(parts[i]);
      if (n != null) {
        var ltd =
            parts[i].length >= 2 ? parts[i].substring(parts[i].length - 2) : '';
        var ld = parts[i].substring(parts[i].length - 1);
        var suf = 'th';
        if (ltd != '11' && ltd != '12' && ltd != '13') {
          if (ld == '1')
            suf = 'st';
          else if (ld == '2')
            suf = 'nd';
          else if (ld == '3')
            suf = 'rd';
        }
        parts[i] = parts[i] + suf;
      }
    }
    return parts.join(' ');
  }
}

/// Returns the plural form of [str].
///
/// If [plural] is provided, it will be used as the plural form.
///
/// Otherwise, the plural form will be determined by the rules in [_pluralRules].
///
/// If [str] is in [_uncountableWords], it will not be pluralized.
///
/// If [str] is empty, an empty string will be returned.
///
/// Examples:
/// ````dart
/// Inflector.pluralize('person') => 'people'
/// Inflector.pluralize('person', 'persons') => 'persons'
/// Inflector.pluralize('octopus') => 'octopi'
/// Inflector.pluralize('Hat') => 'Hats'
/// Inflector.pluralize('person', 'guy') => 'guys'
/// ```
String pluralize(String str, [String? plural]) =>
    Inflector.pluralize(str, plural);

/// Returns the singular form of [str].
///
/// If [singular] is provided, it will be used as the singular form.
///
/// Otherwise, the singular form will be determined by the rules in [_singularRules].
///
/// If [str] is in [_uncountableWords], it will not be singularized.
///
/// If [str] is empty, an empty string will be returned.
///
/// Examples:
/// ````dart
/// Inflector.singularize('person') => 'person'
/// Inflector.singularize('octopi') => 'octopus'
/// Inflector.singularize('Hats') => 'Hat'
/// Inflector.singularize('guys', 'person') => 'person'
/// ````
String singularize(String str, [String? singular]) =>
    Inflector.singularize(str, singular);

/// Returns a camelized version of [str].
///
/// If [lowFirstLetter] is true, the first letter of the resulting string will be lower case.
///
/// If [str] is empty, an empty string will be returned.
/// If [str] contains spaces, they will be replaced with underscores.
///
/// The resulting string will contain double colons "::" between each component.
///
/// Examples:
/// ````dart
/// Inflector.camelize('message_properties') => 'MessageProperties'
/// Inflector.camelize('message_properties', lowFirstLetter: true) => 'messageProperties'
/// ```
///
String camelize(String str, {bool lowFirstLetter = false}) =>
    Inflector.camelize(str, lowFirstLetter: lowFirstLetter);

/// Return the underscored form of a string.
///
/// Examples:
/// ```dart
/// Inflector.underscore('MessageProperties') => 'message_properties'
/// Inflector.underscore('messageProperties') => 'message_properties'
/// ```
String underscore(String str) => Inflector.underscore(str);

/// Converts a string to a human-readable format.
///
/// If [lowFirstLetter] is true, the first letter of the resulting string will be lower case.
///
/// If [str] is empty, an empty string will be returned.
///
/// Examples:
/// ```dart
/// Inflector.humanize('message_properties') => 'Message Properties'
/// Inflector.humanize('message_properties', lowFirstLetter: true) => 'message properties'
/// ```
String humanize(String str, {bool lowFirstLetter = false}) =>
    Inflector.humanize(str, lowFirstLetter: lowFirstLetter);

/// Capitalizes the first letter of a string, converting the rest to lowercase.
///
/// If [str] is empty, an empty string will be returned.
///
/// Examples:
/// ```dart
/// Inflector.capitalize('message_properties') => 'Message_properties'
/// Inflector.capitalize('message properties') => 'Message properties'
/// ```
String capitalize(String str) => Inflector.capitalize(str);

/// Replaces spaces or underscores in a string with dashes.
///
/// If [str] is empty, an empty string will be returned.
///
/// Examples:
/// ```dart
/// Inflector.dasherize('message_properties') => 'message-properties'
/// Inflector.dasherize('message properties') => 'message-properties'
/// ```
String dasherize(String str) => Inflector.dasherize(str);

/// Converts a camelCase or snake_case string to a space-separated string with title-case words.
///
/// If [allFirstUpper] is true, the first letter of each word will be upper case.
/// Otherwise, the first letter of each word will be lower case, unless it is a word
/// that is not typically title-cased (see [nonTitlecasedWords]).
///
/// Examples:
/// ```dart
/// Inflector.camelize('message_properties') => 'Message properties'
/// Inflector.camelize('message_properties', allFirstUpper: true) => 'Message Properties'
/// Inflector.camelize('message_propertiesId') => 'Message properties id'
/// ```
String camel2words(String str, {bool allFirstUpper = false}) =>
    Inflector.camel2words(str, allFirstUpper: allFirstUpper);

/// Removes the module part of a qualified name.
///
/// If [str] does not contain '::', the original string will be returned.
///
/// Examples:
/// ```dart
/// Inflector.demodulize('Message::Bus::Properties') => 'Properties'
/// ```
String demodulize(String str) => Inflector.demodulize(str);

/// Converts a string to its table name form by underscoring and pluralizing it.
///
/// This is useful for generating table names from class names.
///
/// Examples:
/// ```dart
/// Inflector.tableize('MessageBusProperty') => 'message_bus_properties'
/// ```
String tableize(String str) => Inflector.tableize(str);

/// Converts a string to its camelCase form and then singularizes it.
///
/// Examples:
/// ```dart
/// Inflector.classify('message_bus_properties') => 'MessageBusProperty'
/// ```
String classify(String str) => Inflector.classify(str);

/// Converts a class name to its foreign key form.
///
/// The foreign key name is constructed by taking the demodulized
/// class name and appending '_id' to it. If [dropIdUbar] is true,
/// the underscore will not be appended.
///
/// Examples:
/// ```dart
/// Inflector.foreignKey('MessageBusProperty') => 'message_bus_properties_id'
/// Inflector.foreignKey('MessageBusProperty', dropIdUbar: true) => 'message_bus_properties'
/// ```
String foreignKey(String str, {bool dropIdUbar = false}) =>
    Inflector.foreignKey(str, dropIdUbar: dropIdUbar);

/// Ordinalizes a string by replacing numbers with their ordinal suffixes.
///
/// Examples:
/// ```dart
/// Inflector.ordinalize('the 1 pitch') => 'the 1st pitch
/// Inflector.ordinalize('1') => '1st'
/// Inflector.ordinalize('2') => '2nd'
/// Inflector.ordinalize('3') => '3rd'
/// Inflector.ordinalize('4') => '4th'
/// Inflector.ordinalize('11') => '11th'
/// Inflector.ordinalize('12') => '12th'
/// ```
String ordinalize(String str) => Inflector.ordinalize(str);
