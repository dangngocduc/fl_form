import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:stream_transform/stream_transform.dart';

import '../fl_form_field_theme.dart';

typedef OnSearch<T> = Future<List<T>> Function(String keyword);

class FlSearchPage<T> extends StatefulWidget {
  final OnSearch<T> onSearch;
  final ValueWidgetBuilder<T> itemBuilder;
  final WidgetBuilder? loadingBuilder;
  final ErrorWidgetBuilder? errorWidgetBuilder;
  final String? searchPlaceholder;
  const FlSearchPage({
    Key? key,
    required this.onSearch,
    required this.itemBuilder,
    this.errorWidgetBuilder,
    this.loadingBuilder,
    this.searchPlaceholder,
  }) : super(key: key);

  @override
  State<FlSearchPage<T>> createState() => _FlSearchPageState<T>();
}

class _FlSearchPageState<T> extends State<FlSearchPage<T>> {
  TextEditingController controller = TextEditingController();
  StreamController<String> search = StreamController.broadcast();
  late Stream<String> searchKey;
  Future<List<T>>? futureSearchResult;
  @override
  void initState() {
    super.initState();
    searchKey = search.stream.debounce(const Duration(milliseconds: 700));
    searchKey.listen((event) {
      if (event.isNotEmpty) {
        setState(() {
          futureSearchResult = widget.onSearch(event);
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: SafeArea(
            child: Container(
          decoration: BoxDecoration(
              border: Border(bottom: Divider.createBorderSide(context))),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).inputDecorationTheme.fillColor,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: TextField(
                      cursorWidth: 1,
                      onChanged: (value) {
                        search.sink.add(value);
                      },
                      controller: controller,
                      autofocus: true,
                      style: Theme.of(context)
                          .extension<FlFormFieldTheme>()!
                          .style,
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context)
                            .extension<FlFormFieldTheme>()!
                            .placeHolderStyle,
                        hintText:
                            widget.searchPlaceholder ?? 'Type Something...',
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
                  },
                  icon: const Icon(Icons.clear_rounded),
                ),
              ],
            ),
          ),
        )),
      ),
      body: FutureBuilder<List<T>>(
        initialData: [],
        key: ValueKey(futureSearchResult),
        future: futureSearchResult,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.requireData.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context, snapshot.requireData[index]);
                  },
                  child: widget.itemBuilder(
                      context, snapshot.requireData[index]!, null),
                );
              },
            );
          } else if (snapshot.hasError) {
            if (widget.errorWidgetBuilder != null) {
              return widget.errorWidgetBuilder!(
                  FlutterErrorDetails(exception: snapshot.error!));
            } else {
              return Container();
            }
          } else {
            if (widget.loadingBuilder != null) {
              return widget.loadingBuilder!(context);
            } else {
              return Container();
            }
          }
        },
      ),
    );
  }
}
