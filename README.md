## Features

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

### FlTextFormField

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

## Additional information
