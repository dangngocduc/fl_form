import 'package:async/async.dart' as async;
import 'package:flutter/material.dart';

import 'fl_button_state_async.dart';

/// A widget that manages the state of a form body during an asynchronous operation.
///
/// The [FlFormBodyStateAsync] widget takes a [Future] and a [builder] function.
/// While the [Future] is in progress, the form body is disabled to prevent user
/// interaction. Once the [Future] completes, the form body is re-enabled.
class FlFormBodyStateAsync extends StatefulWidget {
  final Future? future;
  final WidgetBuilder builder;
  const FlFormBodyStateAsync({
    Key? key,
    required this.future,
    required this.builder,
  }) : super(key: key);

  @override
  State<FlFormBodyStateAsync> createState() => _FlFormBodyStateAsyncState();
}

class _FlFormBodyStateAsyncState extends State<FlFormBodyStateAsync> {
  FlButtonState state = FlButtonState.enable;

  async.CancelableOperation? cancelableCompleter;

  @override
  void initState() {
    super.initState();
    startListent();
  }

  void startListent() {
    if (widget.future != null) {
      state = FlButtonState.loading;
      cancelableCompleter =
          async.CancelableOperation.fromFuture(widget.future!.whenComplete(() {
        setState(() {
          state = FlButtonState.enable;
        });
      }));
    } else {
      state = FlButtonState.enable;
    }
  }

  @override
  void didUpdateWidget(covariant FlFormBodyStateAsync oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (cancelableCompleter != null && !cancelableCompleter!.isCompleted) {
      cancelableCompleter?.cancel();
    }
    startListent();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: state == FlButtonState.loading,
      child: widget.builder(context),
    );
  }
}
