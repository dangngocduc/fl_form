## Features

<img src="https://raw.githubusercontent.com/dangngocduc/fl_form/master/images/textfield_guide.svg" width="100%"/>

This package provide FormField for some data type on your application, it can work with Form on your application.

- Text Input
- Avatar
- Date, Time, Duration
- Single Item Picker
- Multiple Item Picker
- Bool value
- Radio Button
- CheckBox Group

## Usage

### ⚠️ ⚠️ ⚠️ Require Theme Extension ⚠️ ⚠️ ⚠️

FormFiel is required Application use ThemeExtension: **FlFormFieldTheme**

#### Configuration

```dart
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

#### FlFormFieldTheme

```dart
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

```dart

```

### 📃 1, FlTextFormField

<img src="https://raw.githubusercontent.com/dangngocduc/fl_form/master/images/textfield_guide.svg" width="100%"/>


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

Example Password Text

``` dart
    FlTextFormField(
        prefixIcon: const Icon(Icons.lock),
        label: 'Password',
        placeholderText: '* * * * * *',
        isRequired: true,
        isPassword: true,
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

### FlDateFormField

<img src="https://raw.githubusercontent.com/dangngocduc/fl_form/master/images/date_form_field_guide.svg" width="100%"/>


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

```dart
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

<img src="https://raw.githubusercontent.com/dangngocduc/fl_form/master/images/date_time_form_field_guide.svg" width="100%"/>

```dart
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

```dart
    FlDurationFormField(
        prefixIcon: Icon(Icons.date_range),
        label: 'Select Duration',
        placeholderText: 'hh : mm',
    ),
```

### AvatarFormFieldPage

#### 1, Default Avatar FormField

```dart
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

#### 2, Customize Avatar FormField

```dart
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

### Bool Value FormField

<img src="https://raw.githubusercontent.com/dangngocduc/fl_form/master/images/bool_form_field.svg" width="50%"/>

#### 1, FlBoolFormField

```dart
    FlBoolFormField(
        spacing: 16,
        title: 'Select All',
    )
```

#### 2, FlRawBoolFormField

```dart
    FlRawBoolFormField(
        title: 'Select All',
        rawBuilder: (context, data, didChange) {
        return Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
            children: [
                Checkbox(
                value: data ?? false,
                onChanged: (value) {
                    didChange(value);
                },
                ),
                const Expanded(
                child: Text('Select All'),
                )
            ],
            ),
        );
        },
    ),
```

### Single Item Picker Form Field

```dart
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

### Multiple Item Picker Form Field

```dart
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

### Radio Button Group FormField

<img src="https://raw.githubusercontent.com/dangngocduc/fl_form/master/images/fl_radio_button_form_field.svg" width="50%"/>

```dart
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