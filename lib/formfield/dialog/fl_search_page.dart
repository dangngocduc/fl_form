import 'dart:async';

import 'package:fl_form/fl_form.dart';
import 'package:fl_form/formfield/widget/default_error_builder.dart';
import 'package:flutter/material.dart';
import 'package:stream_transform/stream_transform.dart';

import '../fl_form_field_theme.dart';

typedef OnSearch<T> = Future<List<T>> Function(String keyword);

class FlSearchPage<T> extends StatefulWidget {
  final OnSearch<T> onSearch;
  final FormFieldWidgetBuilder builder;
  final WidgetBuilder? loadingBuilder;
  final ErrorWidgetBuilder? errorWidgetBuilder;
  final String? searchPlaceholder;
  const FlSearchPage({super.key, required this.onSearch, required this.builder, this.errorWidgetBuilder, this.loadingBuilder, this.searchPlaceholder});

  @override
  State<FlSearchPage<T>> createState() => _FlSearchPageState<T>();
}

//////////////////////////////////////////////////////////////////////////////

class _FlSearchPageState<T> extends State<FlSearchPage<T>> {
  final TextEditingController controller = TextEditingController();

  final StreamController<String> _searchStream = StreamController.broadcast();

  late final Stream<List<T>> _searchResults;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _searchResults = _searchStream.stream.debounce(const Duration(milliseconds: 700)).asyncMap((String event) async {
      if (mounted) {
        setState(() {
          _loading = true;
        });
      }
      List<T> results = await widget.onSearch(event);
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
      return results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // let the background shine through
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Theme.of(context).scaffoldBackgroundColor, Colors.transparent],
        ),
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor.withAlpha(200),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(border: Border(bottom: Divider.createBorderSide(context))),
              child: Container(
                decoration: BoxDecoration(color: Theme.of(context).inputDecorationTheme.fillColor),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: TextField(
                          key: Key("search_field"),
                          cursorWidth: 1,
                          onChanged: (value) {
                            _searchStream.sink.add(value);
                          },
                          controller: controller,
                          autofocus: true,
                          style: Theme.of(context).extension<FlFormFieldTheme>()?.style,
                          decoration: InputDecoration(
                            hintStyle: Theme.of(context).extension<FlFormFieldTheme>()?.placeHolderStyle,
                            hintText: widget.searchPlaceholder ?? 'Type Something...',
                            contentPadding: const EdgeInsets.only(left: 8, top: 4),
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.clear();
                        _searchStream.sink.add('');
                      },
                      icon: const Icon(Icons.clear_rounded),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            StreamBuilder(
              stream: _searchResults,
              builder: (BuildContext context, AsyncSnapshot<List<T>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.requireData.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pop(context, snapshot.requireData[index]);
                        },
                        child: widget.builder.buildForList(context, FormFieldOption(value: snapshot.requireData[index]!), false),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return defaultErrorBuilder(context, snapshot.error.toString());
                } else {
                  return Container();
                }
              },
            ),
            if (widget.loadingBuilder != null && _loading) Center(child: widget.loadingBuilder!(context)),
          ],
        ),
      ),
    );
  }
}
