import 'dart:ui';
import 'package:flutter/material.dart';
import 'utils.dart';
import 'base.dart';

/// Use CSS filter effects on flutter's Widget. All CSS filters are implemented except `drop-shadow()`.
/// `drop-shadow()` should be replaced by the [BoxShadow](https://api.flutter.dev/flutter/painting/BoxShadow-class.html) or [Shadow](https://api.flutter.dev/flutter/dart-ui/Shadow-class.html) widget.
///
/// Example:
///
/// ```dart
/// CSSFilter.contrast(child: const Text('foo'), value: 1.2);
/// ```
///
/// Support effects:
/// * contrast()
/// * grayscale()
/// * sepia()
/// * hueRotate()
/// * brightness()
/// * saturate()
/// * invert()
/// * blur()
/// * opacity()
class CSSFilter {
  /// Adjusts the contrast of the input widget.
  /// A value under 1.0 decreases the contrast, while a value over 1.0 increases it.
  /// A value of 0.0 will make it completely gray.
  /// Default value is 1.0.
  static Widget contrast({required Widget child, required double value}) {
    if (!isNotDefault(value)) return child;

    return execFilterSample(
        FilterMatrix.contrast(matrix: baseMatrix(), value: value), child);
  }

  /// Converts the input widget to grayscale.
  /// Values between 0.0 and 1.0 are linear multipliers on the effect.
  /// A value of 1.0 is completely grayscale.
  /// Default value is 0.0.
  static Widget grayscale({required Widget child, required double value}) {
    if (!isNotNegative(value)) return child;

    return execFilterSample(
        FilterMatrix.grayscale(matrix: baseMatrix(), value: value), child);
  }

  /// Converts the input widget to sepia, giving it a warmer, more yellow/brown appearance.
  /// Values between 0.0 and 1.0 are linear multipliers on the effect.
  /// A value of 1.0 is completely sepia.
  /// Default value is 0.0.
  static Widget sepia({required Widget child, required double value}) {
    if (!isNotNegative(value)) return child;

    return execFilterSample(
        FilterMatrix.sepia(matrix: baseMatrix(), value: value), child);
  }

  /// Rotates the [hue](https://en.wikipedia.org/wiki/Hue) of the input widget.
  /// A positive hue rotation increases the hue value, while a negative rotation decreases the hue value.
  /// @parmas value: A value of rotate angle.
  /// Default value is 0.0.
  static Widget hueRotate({required Widget child, required double value}) {
    if (value == 0.0) return child;

    return execFilterSample(
        FilterMatrix.hue(matrix: baseMatrix(), value: value), child);
  }

  /// Apply a linear multiplier to the input widget, making it appear brighter or darker.
  /// A value under 1.0 darkens the Widget, while a value over 1.0 brightens it.
  /// A value of 0.0 will make it completely black.
  /// Default value is 1.0.
  static Widget brightness({required Widget child, required double value}) {
    if (!isNotDefault(value)) return child;

    return execFilterSample(
        FilterMatrix.brightness(matrix: baseMatrix(), value: value), child);
  }

  /// Super-saturates or desaturates the input widget.
  /// A value under 1.0 desaturates the Widget, while a value over 1.0 super-saturates it.
  /// A value of 0.0 is completely unsaturated.
  /// Default value is 1.0.
  static Widget saturate({required Widget child, required double value}) {
    if (!isNotDefault(value)) return child;

    return execFilterSample(
        FilterMatrix.saturate(matrix: baseMatrix(), value: value), child);
  }

  /// Inverts the color of input widget.
  /// Values between 0.0 and 1.0 are linear multipliers on the effect.
  /// A value of 1.0 is completely inverted.
  /// Default value is 0.0.
  static Widget invert({required Widget child, required double value}) {
    if (!isNotNegative(value)) return child;

    return execFilterSample(
        FilterMatrix.invert(matrix: baseMatrix(), value: value), child);
  }

  /// Apply a Gaussian blur to the input widget.
  /// A larger value will create more blur on input widget.
  /// @parmas value: A value of blur radius.
  /// Default value is 0.0.
  static Widget blur({required Widget child, required double value}) {
    if (!isNotNegative(value)) return child;

    return ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: value, sigmaY: value),
        child: child);
  }

  /// Apply transparency to input widget.
  /// Values between 0.0 and 1.0 are linear multipliers on the effect.
  /// A value of 0.0 is completely transparent.
  /// Default value is 1.0.
  static Widget opacity({required Widget child, required double value}) {
    if (!isNotDefault(value)) return child;

    return execFilterSample(
        FilterMatrix.opacity(matrix: baseMatrix(), value: value), child);
  }

  /// A quick and efficient way to apply multiple filters to the input widget.
  /// You can use any combination of these filter effects.
  ///
  /// Example:
  ///
  /// ```dart
  /// CSSFilter.apply(child: const Text('Hello World!'), value: CSSFilterMatrix().contrast(0.5).blur(3.0));
  /// CSSFilter.apply(child: const Text('Hello World!'), value: CSSFilterMatrix().brightness(1.2).saturate(1.5));
  /// ```
  ///
  static Widget apply({required Widget child, required CSSFilterMatrix value}) {
    List<double> matrix = baseMatrix();
    Widget tree = child;
    bool canMerge = false;

    value.conf.forEach((K, V) {
      var fn = filterTypeMap[K];

      if (fn != null) {
        matrix = fn(matrix: matrix, value: V);
        canMerge = true;
      } else {
        // merge layers once
        if (canMerge) {
          tree = ColorFiltered(
            colorFilter: toColorFilterMatrix(matrix),
            child: tree,
          );

          canMerge = false;
        }

        var alone = filterAloneMap[K];

        tree = alone!(child: tree, value: V);
        // reset matrix
        matrix = baseMatrix();
      }
    });

    if (!canMerge) return tree;

    return ColorFiltered(
      colorFilter: toColorFilterMatrix(matrix),
      child: tree,
    );
  }
}
