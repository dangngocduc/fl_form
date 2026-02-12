# Fl Form

A collection of Flutter FormField widgets to easily create beautiful and customizable forms.

<p align="center">
  <a href="https://pub.dartlang.org/packages/fl_form">
    <img alt="Pub Package" src="https://img.shields.io/pub/v/fl_form.svg">
  </a>
  <a href="https://github.com/dangngocduc/fl_form">
    <img src="https://img.shields.io/github/stars/dangngocduc/fl_form.svg?style=flat&logo=github&colorB=deeppink&label=stars" alt="Star on GitHub">
  </a>
  <a href="https://github.com/tenhobi/effective_dart">
    <img alt="style: effective dart" src="https://img.shields.io/badge/style-effective_dart-40c4ff.svg">
  </a>
  <a href="https://opensource.org/licenses/MIT">
    <img alt="MIT License" src="https://img.shields.io/badge/License-MIT-blue.svg">
  </a>
</p>

---

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Available Form Fields](#available-form-fields)
- [Contributing](#contributing)
- [License](#license)

---
## Features

<img src="https://raw.githubusercontent.com/dangngocduc/fl_form/master/images/COVER.png" width="100%" />


<table width="100%">
  <tr>
    <td><img src="https://raw.githubusercontent.com/dangngocduc/fl_form/master/images/single_item_picker_form_field.png" /></td>
    <td><img src="https://raw.githubusercontent.com/dangngocduc/fl_form/master/images/multiple_item_picker_form_field.png" /></td>
  </tr>
  <tr>
    <td><img src="https://raw.githubusercontent.com/dangngocduc/fl_form/master/images/textfield_guide.png" /></td>
    <td><img src="https://raw.githubusercontent.com/dangngocduc/fl_form/master/images/date_time_form_field_guide.png" /></td>
  </tr>
  <tr>
    <td><img src="https://raw.githubusercontent.com/dangngocduc/fl_form/master/images/fl_radio_button_form_field.png" /></td>
    <td><img src="https://raw.githubusercontent.com/dangngocduc/fl_form/master/images/fl_checkbox_group_form_field.png" /></td>
  </tr>
  <tr>
    <td><img src="https://raw.githubusercontent.com/dangngocduc/fl_form/master/images/bool_form_field.png" /></td>
    <td><img src="https://raw.githubusercontent.com/dangngocduc/fl_form/master/images/date_time_form_field_guide.png" /></td>
  </tr>
</table>



This package provides a set of pre-built `FormField` widgets that integrate seamlessly with Flutter's `Form` widget. It helps you create forms with various data types quickly and with a consistent look and feel.

- Text Input
- Integer or Double Input
- Avatar
- Date, Time, Duration
- Single Item Picker
- Multiple Item Picker
- Switch (Boolean)
- Radio Button
- CheckBox Group

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  fl_form: ^latest_version
```

Then, run `flutter pub get` in your terminal.

## Usage

For enhanced styling, you need to add the `FlFormFieldTheme` to your `MaterialApp`'s theme extensions.

Configuration via default themes:

```flutter
  static TextStyle fontStyle = GoogleFonts.birthstone();

  ThemeData.light().copyWith(
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Color(0xff999999)).merge(fontStyle),
      floatingLabelStyle: TextStyle().merge(fontStyle),
      border: OutlineInputBorder(),
      fillColor: Color(0xffffffff),
      filled: true,
    ),
  );
```

Enhanced styling options:

```flutter
    MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(
        useMaterial3: true,
        ).copyWith(extensions: [
        FlFormFieldTheme.dark(context),
        ]),
        home: const MainExample(),
    );
```

and the FlFormFieldTheme

```flutter
...
  final TextStyle labelStyle;
  final InputDecorationTheme inputDecorationTheme;
  final TextStyle style;
  final TextStyle errorStyle;
  final TextStyle placeHolderStyle;

  FlFormFieldTheme({
    required this.labelStyle,
    required this.inputDecorationTheme,
    required this.style,
    required this.errorStyle,
    required this.placeHolderStyle,
  });

```


## Available Form Fields

### FlTextFormField

<img src="https://raw.githubusercontent.com/dangngocduc/fl_form/master/images/textfield_guide.png" width="100%"/>


Example Simple Text

``` dart
    FlTextFormField(
        label: 'Email',
        isRequired: true,
        autovalidateMode: AutovalidateMode.always,
        validator: (value) {
        return 'Email invalid';
        },
        placeholderText: 'Type your email',
    ),
```

### FlPasswordFormField

```dart
    FlPasswordFormField(
        prefixIcon: const Icon(Icons.lock),
        label: 'Password',
        placeholderText: '* * * * * *',
        isRequired: true,
    ),
```

Example Area Text

``` dart
    FlTextFormField(
        maxLines: 4,
        label: 'Description',
        autovalidateMode: AutovalidateMode.always,
        placeholderText: 'Type your description',
        validator: (value) {
        return 'Description invalid';
        },
    ),
```

### FlMoneyFormField

```dart
    FlMoneyFormField(
        label: 'Amount',
        currency: 'USD',
        initialValue: 1000.00,
    ),
```

### FlDateFormField

<img src="https://raw.githubusercontent.com/dangngocduc/fl_form/master/images/date_form_field_guide.png" width="100%"/>


``` dart
    FlDateFormField(
        autovalidateMode: AutovalidateMode.always,
        prefixIcon: const Icon(Icons.date_range),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 100)),
        label: 'Date of birth',
        placeholderText: 'dd/MM/yyyy',
        validator: (value) {
        return 'Date invalid';
        },
    ),
```

### FlTimeFormField

```flutter
    FlTimeFormField(
        label: 'Time Start',
        placeholderText: 'HH:MM',
        autovalidateMode: AutovalidateMode.always,
        validator: (value) {
        return 'Time invalid';
        },
        prefixIcon: Icon(Icons.alarm),
    ),
```

### FlDateAndTimeFormField

<img src="https://raw.githubusercontent.com/dangngocduc/fl_form/master/images/date_time_form_field_guide.png" width="100%"/>

```flutter
    FlDateAndTimeFormField(
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 100)),
        label: 'Date of birth',
        placeholderText: 'dd/MM/yyyy',
        autovalidateMode: AutovalidateMode.always,
        validator: (value) => 'Date invalid',
    ),
```

### FlDurationFormField

```flutter
    FlDurationFormField(
        prefixIcon: Icon(Icons.date_range),
        label: 'Select Duration',
        placeholderText: 'hh : mm',
    ),
```

### FlAvatarFormField

#### Default Avatar FormField

```flutter
    FlAvatarFormField(
    radius: 64,
    autovalidateMode: AutovalidateMode.always,
    validator: (value) {
        if (value == null) {
        return 'Need update your avatar';
        }
    },
    ),
```

#### Custom Avatar FormField

```flutter
    Center(
    child: FlRawAvatarFormField(
        builder: (
            {required context, data, required didChange, error}) {
        if (data == null) {
            return GestureDetector(
            onTap: () {
                FlRawAvatarFormField.pickFile().then((value) {
                if (value != null) {
                    didChange(value);
                }
                });
            },
            child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12),
                ),
            ),
            );
        } else {
            if (data.file != null) {
            return Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(data.file!))),
            );
            } else {
            return Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(data.link!))),
            );
            }
        }
        },
    ),
    ),
```

### FlSwitchFormField


#### Default Switch FormField

```flutter
    FlSwitchFormField(
        label: 'Select All',
    )
```



### FlSingleItemPickerFormField

<img src="https://raw.githubusercontent.com/dangngocduc/fl_form/master/images/single_item_picker_form_field.png" width="100%"/>



```flutter
    SingleItemPickerFormField<SimpleData>(
        label: 'Select Item customize',
        placeholderText: 'Select Item',
        itemListBuilder: (context, data, isSelected) {
        return Container(
            padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
            ),
            child: Row(
            children: [
                const CircleAvatar(
                radius: 24,
                ),
                const SizedBox(
                width: 12,
                ),
                Expanded(
                    child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(
                    data.title,
                    style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                    height: 2,
                    ),
                    Text(
                    data.subTitle,
                    style: Theme.of(context).textTheme.labelMedium,
                    ),
                ],
                )),
                if (isSelected) const Icon(Icons.done)
            ],
            ),
        );
        },
        contentSelectedBuilder: (data, context) => Container(
        child: Row(
            children: [
            const CircleAvatar(
                radius: 16,
            ),
            const SizedBox(
                width: 12,
            ),
            Expanded(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(
                    data.title,
                    style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                    height: 2,
                ),
                Text(
                    data.subTitle,
                    style: Theme.of(context).textTheme.labelMedium,
                ),
                ],
            ))
            ],
        ),
        ),
        options: [
        SimpleData(title: 'Title 1', subTitle: 'Sub title 1'),
        SimpleData(title: 'Title 2', subTitle: 'Sub title 2'),
        SimpleData(title: 'Title 3', subTitle: 'Sub title 3'),
        SimpleData(title: 'Title 4', subTitle: 'Sub title 4'),
        SimpleData(title: 'Title 5', subTitle: 'Sub title 5'),
        SimpleData(title: 'Title 6', subTitle: 'Sub title 6'),
        SimpleData(title: 'Title 7', subTitle: 'Sub title 7'),
        SimpleData(title: 'Title 8', subTitle: 'Sub title 8'),
        ],
    )
```

### FlMultipleItemPickerFormField

<img src="https://raw.githubusercontent.com/dangngocduc/fl_form/master/images/multiple_item_picker_form_field.png" width="100%"/>

```flutter
    MultipleItemPickerFormField<SimpleData>(
        label: 'Select Items customize',
        placeholderText: 'Select Items',
        autovalidateMode: AutovalidateMode.always,
        validator: (value) {
        return 'Data Invalid';
        },
        itemListBuilder: (context, data, isSelected) {
        return Container(
            padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
            ),
            child: Row(
            children: [
                const CircleAvatar(
                radius: 24,
                ),
                const SizedBox(
                width: 12,
                ),
                Expanded(
                    child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(
                    data.title,
                    style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                    height: 2,
                    ),
                    Text(
                    data.subTitle,
                    style: Theme.of(context).textTheme.labelMedium,
                    ),
                ],
                )),
                if (isSelected) const Icon(Icons.done)
            ],
            ),
        );
        },
        contentSelectedBuilder: (data, context) => Container(
        child: Wrap(
            spacing: 8,
            children: [
            ...data
                    ?.map((e) => Chip(
                            label: Text(e.title),
                        ))
                    .toList() ??
                []
            ],
        ),
        ),
        options: [
        SimpleData(title: 'Title 1', subTitle: 'Sub title 1'),
        SimpleData(title: 'Title 2', subTitle: 'Sub title 2'),
        SimpleData(title: 'Title 3', subTitle: 'Sub title 3'),
        SimpleData(title: 'Title 4', subTitle: 'Sub title 4'),
        SimpleData(title: 'Title 5', subTitle: 'Sub title 5'),
        SimpleData(title: 'Title 6', subTitle: 'Sub title 6'),
        SimpleData(title: 'Title 7', subTitle: 'Sub title 7'),
        SimpleData(title: 'Title 8', subTitle: 'Sub title 8'),
        ],
    )
```

### FlRadioButtonGroupFormField

<img src="https://raw.githubusercontent.com/dangngocduc/fl_form/master/images/fl_radio_button_form_field.png" width="100%"/>

```flutter
    FlRadioButtonFormField(
        isRequired: true,
        autovalidateMode: AutovalidateMode.always,
        validator: (value) {
        if (value == null) return 'Data invalid';
        return null;
        },
        label: 'Select Item',
        options: const [
        'Option 1',
        'Option 2',
        'Option 3',
        ],
    )
```

### FlCheckboxGroupFormField

<img src="https://raw.githubusercontent.com/dangngocduc/fl_form/master/images/fl_checkbox_group_form_field.png" width="100%"/>

```flutter
    FlCheckboxGroupFormField(
        isRequired: true,
        autovalidateMode: AutovalidateMode.always,
        validator: (value) {
        if (value == null || value.isEmpty) return 'Data invalid';
        return null;
        },
        label: 'Select Item',
        options: const [
        'Item 1',
        'Item 2',
        'Item 3',
        'Item 4',
        'Item 5',
        'Item 6',
        ],
    )
```

---

## Contributing

Contributions are welcome! If you have any ideas, suggestions, or bug reports, please open an issue or create a pull request on GitHub.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
