import 'package:fl_form/fl_form.dart';
import 'package:fl_form/formfield/dialog/fl_search_page.dart';
import 'package:fl_form/formfield/widget/fl_readonly_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlSearchItemFormField<T> extends FormField<T> {
  final OnSearch<T> onSearch;

  FlSearchItemFormField({
    super.key,
    required String label,
    String? placeholderText,
    Widget? prefixIcon,
    FormFieldWidgetBuilder builder = const DefaultFormFieldWidgetBuilder(),
    WidgetBuilder? loadingBuilder,
    super.validator,
    super.onSaved,
    ValueChanged<T?>? onChanged,
    super.autovalidateMode,
    EdgeInsetsGeometry? contentPadding,
    super.enabled,
    super.initialValue,
    required this.onSearch,
    String? helperText,
    bool isRequired = false,
  }) : super(
         builder: (field) {
           final state = field as FlSearchItemFormFieldState<T>;
           return FlReadonlyField(
             label: label,
             isRequired: isRequired,
             enabled: enabled,
             hasError: state.hasError,
             placeholderText: placeholderText,
             onTap: enabled
                 ? () {
                     Navigator.push<T>(
                       state.context,
                       _MaterialTransparentRoute(
                         builder: (context) {
                           return FlSearchPage<T>(builder: builder, onSearch: onSearch, loadingBuilder: loadingBuilder);
                         },
                       ),
                     ).then((value) {
                       if (value != null) {
                         onChanged?.call(value);
                         state.didChange(value);
                       }
                     });
                   }
                 : null,
             helperText: helperText,
             errorText: state.errorText,
             content: state.value == null ? null : builder.buildForContent(state.context, FormFieldOption(value: state.value!)),
             suffixIcon: field.value != null && !isRequired
                 ? InkWell(
                     onTap: enabled
                         ? () {
                             onChanged?.call(null);
                             field.didChange(null);
                           }
                         : null,
                     child: const Icon(CupertinoIcons.clear_circled_solid),
                   )
                 : Icon(Icons.search),
           );
         },
       );

  @override
  FormFieldState<T> createState() {
    return FlSearchItemFormFieldState<T>();
  }
}

//////////////////////////////////////////////////////////////////////////////

class FlSearchItemFormFieldState<T> extends FormFieldState<T> {
  @override
  FlSearchItemFormField<T> get widget => super.widget as FlSearchItemFormField<T>;

  @override
  void didUpdateWidget(covariant FormField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      // when initialValue changed - maybe because you have an async call to retrieve the correct value and show the form field in the meantime with
      // a null-value, set the new initial value.
      setValue(widget.initialValue);
    }
  }
}

//////////////////////////////////////////////////////////////////////////////

class _MaterialTransparentRoute<T> extends PageRoute<T> with MaterialRouteTransitionMixin<T> {
  _MaterialTransparentRoute({required this.builder, super.settings, this.maintainState = true, super.fullscreenDialog});

  final WidgetBuilder builder;

  @override
  Widget buildContent(BuildContext context) => builder(context);

  @override
  bool get opaque => false;

  @override
  final bool maintainState;

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';
}
