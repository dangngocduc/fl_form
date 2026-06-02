import 'package:flutter/material.dart';

/// Resolves [TextField.onTapOutside].
///
/// When [onTapOutside] is null, returns null so [TextField] uses its default
/// tap-outside behavior.
TapRegionCallback? resolveTextFieldOnTapOutside(
  TapRegionCallback? onTapOutside,
) {
  return onTapOutside;
}
