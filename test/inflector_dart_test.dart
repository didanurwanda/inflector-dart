import 'package:inflector_dart/inflector_dart.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('Test pluralize', () {
      print(
        'Inflector.pluralize("person") -> ${Inflector.pluralize("person")}',
      );
      expect(Inflector.pluralize("person"), "people");

      print('Inflector.pluralize("Hat") -> ${Inflector.pluralize("Hat")}');
      expect(Inflector.pluralize("person", "persons"), "persons");

      print('Inflector.pluralize("Hat") -> ${Inflector.pluralize("Hat")}');
      expect(Inflector.pluralize("Hat"), "Hats");

      print(
        'Inflector.pluralize("person", "guys") -> ${Inflector.pluralize("person", "guys")}',
      );
      expect(Inflector.pluralize("person", "guys"), "guys");
    });

    test('Test singularize', () {
      print(
        'Inflector.singularize("person") -> ${Inflector.singularize("person")}',
      );
      expect(Inflector.singularize("person"), "person");

      print(
        'Inflector.singularize("octopi") -> ${Inflector.singularize("octopi")}',
      );
      expect(Inflector.singularize("octopi"), "octopus");

      print(
        'Inflector.singularize("hats") -> ${Inflector.singularize("hats")}',
      );
      expect(Inflector.singularize("hats"), "hat");

      print(
        'Inflector.singularize("guys", "person") -> ${Inflector.singularize("guys", "person")}',
      );
      expect(Inflector.singularize("guys", "person"), "person");
    });

    test('Test camelize', () {
      print(
        'Inflector.camelize("message_properties") -> ${Inflector.camelize("message_properties")}',
      );
      expect(Inflector.camelize("message_properties"), "MessageProperties");

      print(
        'Inflector.camelize("message_properties", lowFirstLetter: true) -> ${Inflector.camelize("message_properties", lowFirstLetter: true)}',
      );
      expect(
        Inflector.camelize("message_properties", lowFirstLetter: true),
        "messageProperties",
      );
    });

    test('Test underscore', () {
      print(
        'Inflector.underscore("MessageProperties") -> ${Inflector.underscore("MessageProperties")}',
      );
      expect(Inflector.underscore("MessageProperties"), "message_properties");

      print(
        'Inflector.underscore("messageProperties") -> ${Inflector.underscore("messageProperties")}',
      );
      expect(Inflector.underscore("messageProperties"), "message_properties");
    });

    test('Test humanize', () {
      print(
        'Inflector.humanize("message_properties") -> ${Inflector.humanize("message_properties")}',
      );
      expect(Inflector.humanize("message_properties"), "Message properties");

      print(
        'Inflector.humanize("messageProperties", lowFirstLetter: true) -> ${Inflector.humanize("messageProperties", lowFirstLetter: true)}',
      );
      expect(
        Inflector.humanize("messageProperties", lowFirstLetter: true),
        "message properties",
      );
    });

    test('Test capitalize', () {
      print(
        'Inflector.capitalize("message_properties") -> ${Inflector.capitalize("message_properties")}',
      );
      expect(Inflector.capitalize("message_properties"), "Message_properties");

      print(
        'Inflector.capitalize("message properties") -> ${Inflector.capitalize("message properties")}',
      );
      expect(Inflector.capitalize("message properties"), "Message properties");
    });

    test('Test dasherize', () {
      print(
        'Inflector.dasherize("message_properties") -> ${Inflector.dasherize("message_properties")}',
      );
      expect(Inflector.dasherize("message_properties"), "message-properties");

      print(
        'Inflector.dasherize("message properties") -> ${Inflector.dasherize("message properties")}',
      );
      expect(Inflector.dasherize("message properties"), "message-properties");
    });

    test('Test camel2words', () {
      print(
        'Inflector.camel2words("message_properties") -> ${Inflector.camel2words("message_properties")}',
      );
      expect(Inflector.camel2words("message_properties"), "Message Properties");

      print(
        'Inflector.camel2words("message properties") -> ${Inflector.camel2words("message properties")}',
      );
      expect(Inflector.camel2words("message properties"), "Message Properties");

      print(
        'Inflector.camel2words("Message_propertyId", allFirstUpper: true) -> ${Inflector.camel2words("Message_propertyId", allFirstUpper: true)}',
      );
      expect(
        Inflector.camel2words("Message_propertyId", allFirstUpper: true),
        "Message Property Id",
      );
    });

    test('Test demodulize', () {
      print(
        'Inflector.demodulize("Message::Bus::Properties") -> ${Inflector.demodulize("Message::Bus::Properties")}',
      );
      expect(Inflector.demodulize("Message::Bus::Properties"), "Properties");
    });

    test('Test tableize', () {
      print(
        'Inflector.tableize("MessageBusProperty") -> ${Inflector.tableize("MessageBusProperty")}',
      );
      expect(
        Inflector.tableize("MessageBusProperty"),
        "message_bus_properties",
      );
    });

    test('Test classify', () {
      print(
        'Inflector.classify("message_bus_properties") -> ${Inflector.classify("message_bus_properties")}',
      );
      expect(
        Inflector.classify("message_bus_properties"),
        "MessageBusProperty",
      );
    });

    test('Test foreignKey', () {
      print(
        'Inflector.foreignKey("MessageBusProperty") -> ${Inflector.foreignKey("MessageBusProperty")}',
      );
      expect(
        Inflector.foreignKey("MessageBusProperty"),
        "message_bus_property_id",
      );

      print(
        'Inflector.foreignKey("MessageBusProperty", dropIdUbar: true) -> ${Inflector.foreignKey("MessageBusProperty", dropIdUbar: true)}',
      );
      expect(
        Inflector.foreignKey("MessageBusProperty", dropIdUbar: true),
        "message_bus_propertyid",
      );
    });

    test('Test ordinalize', () {
      print(
        'Inflector.ordinalize("the 1 pitch") -> ${Inflector.ordinalize('the 1 pitch')}',
      );
      expect(Inflector.ordinalize('the 1 pitch'), "the 1st pitch");

      print('Inflector.ordinalize("1") -> ${Inflector.ordinalize('1')}');
      expect(Inflector.ordinalize('1'), "1st");

      print('Inflector.ordinalize("2") -> ${Inflector.ordinalize('2')}');
      expect(Inflector.ordinalize('2'), "2nd");

      print('Inflector.ordinalize("3") -> ${Inflector.ordinalize('3')}');
      expect(Inflector.ordinalize('3'), "3rd");

      print('Inflector.ordinalize("4") -> ${Inflector.ordinalize('4')}');
      expect(Inflector.ordinalize('4'), "4th");
    });
  });
}
