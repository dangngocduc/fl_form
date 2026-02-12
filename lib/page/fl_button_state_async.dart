import 'package:async/async.dart' as async;
import 'package:flutter/material.dart';

typedef FlButtonStateBuilder = Widget Function(
    BuildContext context, FlButtonState state);

/// A widget that manages the state of a button based on an asynchronous operation.
///
/// The [FlButtonStateAsync] widget takes a [Future] and a [builder] function.
/// The [builder] is called with the current [FlButtonState], which can be used
/// to display different UI for each state (e.g., a loading indicator).
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

/// An enum representing the possible states of a button.
///
/// - [disable]: The button is disabled and cannot be interacted with.
/// - [enable]: The button is enabled and can be tapped.
/// - [loading]: The button is in a loading state, typically showing a progress indicator.
enum FlButtonState {
  disable,
  enable,
  loading,
}
