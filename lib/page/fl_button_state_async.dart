import 'package:async/async.dart' as async;
import 'package:flutter/material.dart';

typedef FlButtonStateBuilder = Widget Function(
    BuildContext context, FlButtonState state);

class FlButtonStateAsync extends StatefulWidget {
  final Future? future;
  final FlButtonStateBuilder builder;
  final FlButtonState state;
  const FlButtonStateAsync({
    Key? key,
    required this.future,
    required this.builder,
    this.state = FlButtonState.disable,
  }) : super(key: key);

  @override
  State<FlButtonStateAsync> createState() => _FlButtonStateAsyncState();
}

class _FlButtonStateAsyncState extends State<FlButtonStateAsync> {
  late FlButtonState state;

  async.CancelableOperation? cancelableCompleter;

  @override
  void initState() {
    super.initState();
    state = widget.state;
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
      state = widget.state;
    }
  }

  @override
  void didUpdateWidget(covariant FlButtonStateAsync oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (cancelableCompleter != null && !cancelableCompleter!.isCompleted) {
      cancelableCompleter?.cancel();
    }
    startListent();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, state);
  }
}

enum FlButtonState {
  disable,
  enable,
  loading,
}
