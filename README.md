# Inflector Dart API Documentation

A lightweight Dart utility for smart word transformations – from singular to plural, snake_case to camelCase, and everything in between. All methods are `static` and can be called directly on the `Inflector` class, and can also be invoked directly

> **Note:**  
> This library is a Dart port of the popular JavaScript library [inflector-js](https://www.npmjs.com/package/inflector-js), bringing similar functionality for smart word transformations such as singular/plural conversion and case formatting.

---

## How to Use

```dart
print(Inflector.camelize('message_properties'))

/// or

print(camelize('message_properties'))
```

---

## API

### `pluralize`

```
String pluralize(String str, [String? plural])
```

Returns the plural form of a string.

**Parameters:**

- `str`: The string to pluralize.
- `plural` (optional): Overrides the plural form if provided.

**Example:**

```
pluralize('person'); // returns 'people'
pluralize('Hat'); // returns 'Hats'
pluralize('person', 'persons'); // returns 'persons'
pluralize('person', 'guys'); // returns 'guys'
```

---

### `singularize`

```
String singularize(String str, [String? singular])
```

Returns the singular form of a string.

**Parameters:**

- `str`: The string to singularize.
- `singular` (optional): Overrides the singular form if provided.

**Example:**

```
singularize('people'); // returns 'person'
singularize('octopi'); // returns 'octopus'
singularize('hats'); // returns 'hat'
singularize('guys', 'person'); // returns 'person'
```

---

### `camelize`

```
String camelize(String str, {bool lowFirstLetter = false})
```

Converts a string to CamelCase.

**Parameters:**

- `str`: The string to convert.
- `lowFirstLetter`: If true, the first letter will be lowercase.

**Example:**

```
camelize('message_properties'); // 'MessageProperties'
camelize('message_properties', lowFirstLetter: true); // 'messageProperties'
```

---

### `underscore`

```
String underscore(String str)
```

Converts CamelCase to snake_case.

**Example:**

```
underscore('MessageProperties'); // 'message_properties'
underscore('messageProperties'); // 'message_properties'
```

---

### `humanize`

```
String humanize(String str, {bool lowFirstLetter = false})
```

Converts a string to a human-readable format with spaces.

**Example:**

```
humanize('message_properties'); // 'Message properties'
humanize('messageProperties', lowFirstLetter: true); // 'message properties'
```

---

### `capitalize`

```
String capitalize(String str)
```

Capitalizes the first letter of a string.

**Example:**

```
capitalize('message properties'); // 'Message properties'
capitalize('message_properties'); // 'Message_properties'
```

---

### `dasherize`

```
String dasherize(String str)
```

Replaces spaces or underscores with dashes.

**Example:**

```
dasherize('message properties'); // 'message-properties'
dasherize('message_properties'); // 'message-properties'
```

---

### `camel2words`

```
String camel2words(String str, {bool allFirstUpper = false})
```

Converts camelCase or snake_case to space-separated words with optional capitalization.

**Example:**

```
camel2words('message_properties'); // 'Message Properties'
camel2words('message properties'); // 'Message Properties'
camel2words('Message_propertyId', allFirstUpper: true); // 'Message Property Id'
```

---

### `demodulize`

```
String demodulize(String str)
```

Removes module namespace from a string.

**Example:**

```
demodulize('Message::Bus::Properties'); // 'Properties'
```

---

### `tableize`

```
String tableize(String str)
```

Converts a class name to its corresponding table name (snake_case and pluralized).

**Example:**

```
tableize('MessageBusProperty'); // 'message_bus_properties'
```

---

### `classify`

```
String classify(String str)
```

Converts a table name to its corresponding class name (CamelCase and singularized).

**Example:**

```
classify('message_bus_properties'); // 'MessageBusProperty'
```

---

### `foreignKey`

```
String foreignKey(String str, {bool dropIdUbar = false})
```

Converts a class name to its foreign key form.

**Example:**

```
foreignKey('MessageBusProperty'); // 'message_bus_property_id'
foreignKey('MessageBusProperty', dropIdUbar: true); // 'message_bus_propertyid'
```

---

### `ordinalize`

```
String ordinalize(String str)
```

Converts numbers in a string to their ordinal form.

**Example:**

```
ordinalize('the 1 pitch'); // 'the 1st pitch'
ordinalize('1'); // '1st'
ordinalize('2'); // '2nd'
ordinalize('3'); // '3rd'
ordinalize('4'); // '4th'
```

---

## Author

Created and maintained by **Dida Nurwanda**  
[didanurwanda@gmail.com](mailto:didanurwanda@gmail.com)

---

## License

This project is licensed under the **MIT**. See the [LICENSE](./LICENSE) file for more details.
