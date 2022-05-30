/// CSS filter for flutter
/// Author: qkorbit
/// Released under BSD-3-Clause License.
library css_filter;

import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import './css_filter_util.dart';

class FilterMatrix {
  /// Check: https://developer.mozilla.org/en-US/docs/Web/CSS/filter-function/contrast()
  static contrast({ required List<double> matrix, required double value }) {
    double v = value;
    double b = (1.0 - value) * 0.5 * 255.0; // 0.5*255 => 127

    return multiplyMatrix5(matrix, <double>[
      v, 0, 0, 0, b,
      0, v, 0, 0, b,
      0, 0, v, 0, b,
      0, 0, 0, 1, 0,
      0, 0, 0, 0, 1
    ]);
  }
  /// Formula from: https://www.w3.org/TR/filter-effects-1/#grayscaleEquivalent
  static grayscale({ required List<double> matrix, required double value }) {
    double v = 1.0 - value;
    double lumR = 0.2126;
    double lumG = 0.7152;
    double lumB = 0.0722;

    return multiplyMatrix5(matrix, <double>[
      (lumR + (1 - lumR) * v), (lumG - lumG * v), (lumB - lumB * v), 0, 0,
      (lumR - lumR * v), (lumG + (1 - lumG) * v), (lumB - lumB * v), 0, 0,
      (lumR - lumR * v), (lumG - lumG * v), (lumB + (1 - lumB) * v), 0, 0,
      0, 0, 0, 1, 0,
      0, 0, 0, 0, 1
    ]);
  }
  /// Formula from: https://www.w3.org/TR/filter-effects-1/#sepiaEquivalent
  static sepia({ required List<double> matrix, required double value }) {
    double v = 1.0 - value;

    return multiplyMatrix5(matrix, <double>[
      (0.393 + 0.607 * v), (0.769 - 0.769 * v), (0.189 - 0.189 * v), 0, 0,
      (0.349 - 0.349 * v), (0.686 + 0.314 * v), (0.168 - 0.168 * v), 0, 0,
      (0.272 - 0.272 * v), (0.534 - 0.534 * v), (0.131 + 0.869 * v), 0, 0,
      0, 0, 0, 1, 0,
      0, 0, 0, 0, 1
    ]);
  }
  /// Check: https://www.geeksforgeeks.org/css-invert-function/
  static invert({ required List<double> matrix, required double value }) {
    // v * (255 - n) + (1 - v) * n => (1 - 2v) * n + 255 * v
    double v = value * 255.0;
    double k = 1.0 - 2.0 * value;

    // The fifth column n is 255.
    return multiplyMatrix5(matrix, <double>[
      k, 0, 0, 0, v,
      0, k, 0, 0, v,
      0, 0, k, 0, v,
      0, 0, 0, 1, 0,
      0, 0, 0, 0, 1
    ]);
  }
  /// Check: https://stackoverflow.com/questions/64639589/how-to-adjust-hue-saturation-and-brightness-of-an-image-in-flutter
  static hue({ required List<double> matrix, required double value }) {
    double v = math.pi * (value / 180.0);
    double cosVal = math.cos(v);
    double sinVal = math.sin(v);
    double lumR = 0.213;
    double lumG = 0.715;
    double lumB = 0.072;

    return multiplyMatrix5(matrix, <double>[
      (lumR + (cosVal * (1 - lumR))) + (sinVal * (-lumR)), (lumG + (cosVal * (-lumG))) + (sinVal * (-lumG)), (lumB + (cosVal * (-lumB))) + (sinVal * (1 - lumB)), 0, 0,
      (lumR + (cosVal * (-lumR))) + (sinVal * 0.143), (lumG + (cosVal * (1 - lumG))) + (sinVal * 0.14), (lumB + (cosVal * (-lumB))) + (sinVal * (-0.283)), 0, 0,
      (lumR + (cosVal * (-lumR))) + (sinVal * (-(1 - lumR))), (lumG + (cosVal * (-lumG))) + (sinVal * lumG), (lumB + (cosVal * (1 - lumB))) + (sinVal * lumB), 0, 0,
      0, 0, 0, 1, 0,
      0, 0, 0, 0, 1
    ]);
  }
  static brightness({ required List<double> matrix, required double value }) {
    // The calculation of web brightness is slightly different.
    double v = value > 1.0 ? (1.0 + (value - 1.0) * (1.0 + 100.0 / 255.0)) : value;

    return multiplyMatrix5(matrix, <double>[
      v, 0, 0, 0, 0,
      0, v, 0, 0, 0,
      0, 0, v, 0, 0,
      0, 0, 0, 1, 0,
      0, 0, 0, 0, 1
    ]);
  }
  /// Check: https://docs.rainmeter.net/tips/colormatrix-guide/
  static saturate({ required List<double> matrix, required double value }) {
    return FilterMatrix.grayscale(matrix: matrix, value: 1.0 - value);
  }
}

/// Use CSS filter effects on flutter's Widget. All CSS filters are implemented except `drop-shadow()` and `opacity()`.
/// `drop-shadow()` should be replaced by the [BoxShadow](https://api.flutter.dev/flutter/painting/BoxShadow-class.html) or [Shadow](https://api.flutter.dev/flutter/dart-ui/Shadow-class.html) widget,
///  and `opacity()` should be replaced by the [Opacity](https://api.flutter.dev/flutter/widgets/Opacity-class.html) widget.
/// 
/// Support methods:
/// * contrast()
/// * grayscale()
/// * sepia()
/// * hueRotate()
/// * brightness()
/// * saturate()
/// * invert()
/// * blur()
class CSSFilter {
  /// Adjusts the contrast of the input Widget. 
  /// A value under 1.0 decreases the contrast, while a value over 1.0 increases it. 
  /// A value of 0.0 will make it completely gray.
  /// Default value is 1.0.
  static Widget contrast({ required Widget child, required double value }) {
    if (!isNotDefault(value)) return child;

    return execFilterSample(FilterMatrix.contrast(matrix: baseMatrix(), value: value), child);
  }
  /// Converts the input Widget to grayscale.
  /// Values between 0.0 and 1.0 are linear multipliers on the effect.
  /// A value of 1.0 is completely grayscale.
  /// Default value is 0.0.
  static Widget grayscale({ required Widget child, required double value }) {
    if (!isPositive(value)) return child;

    return execFilterSample(FilterMatrix.grayscale(matrix: baseMatrix(), value: value), child);
  }
  /// Converts the input Widget to sepia, giving it a warmer, more yellow/brown appearance.
  /// Values between 0.0 and 1.0 are linear multipliers on the effect.
  /// A value of 1.0 is completely sepia.
  /// Default value is 0.0.
  static Widget sepia({ required Widget child, required double value }) {
    if (!isPositive(value)) return child;

    return execFilterSample(FilterMatrix.sepia(matrix: baseMatrix(), value: value), child);
  }
  /// Rotates the [hue](https://en.wikipedia.org/wiki/Hue) of the input Widget.
  /// A positive hue rotation increases the hue value, while a negative rotation decreases the hue value.
  /// @parmas value: A value of rotate angle.
  /// Default value is 0.0.
  static Widget hueRotate({ required Widget child, required double value }) {
    if (value == 0.0) return child;

    return execFilterSample(FilterMatrix.hue(matrix: baseMatrix(), value: value), child);
  }
  /// Apply a linear multiplier to the input Widget, making it appear brighter or darker.
  /// A value under 1.0 darkens the Widget, while a value over 1.0 brightens it.
  /// A value of 0.0 will make it completely black.
  /// Default value is 1.0.
  static Widget brightness({ required Widget child, required double value }) {
    if (!isNotDefault(value)) return child;

    return execFilterSample(FilterMatrix.brightness(matrix: baseMatrix(), value: value), child);
  }
  /// Super-saturates or desaturates the input Widget.
  /// A value under 1.0 desaturates the Widget, while a value over 1.0 super-saturates it.
  /// A value of 0.0 is completely unsaturated.
  /// Default value is 1.0.
  static Widget saturate({ required Widget child, required double value }) {
    if (!isNotDefault(value)) return child;

    return execFilterSample(FilterMatrix.saturate(matrix: baseMatrix(), value: value), child);
  }
  /// Inverts the color of input Widget.
  /// Values between 0.0 and 1.0 are linear multipliers on the effect.
  /// A value of 1.0 is completely inverted.
  /// Default value is 0.0.
  static Widget invert({ required Widget child, required double value }) {
    if (!isPositive(value)) return child;

    return execFilterSample(FilterMatrix.invert(matrix: baseMatrix(), value: value), child);
  }
  /// Apply a Gaussian blur to the input Widget.
  /// A larger value will create more blur on input Widget.
  /// @parmas value: A value of blur radius.
  /// Default value is 0.0.
  static Widget blur({ required Widget child, required double value }) {
    if (!isPositive(value)) return child;

    return ImageFiltered(imageFilter: ImageFilter.blur(sigmaX: value, sigmaY: value), child: child);
  }
  /// A quick and efficient way to apply multiple filters to the input Widget.
  /// You can use any combination of these filter effects. 
  /// 
  /// Example:
  /// 
  /// ```dart
  /// CSSFilter.apply(child: const Text('Hello World!'), contrast: 0.5, blur: 3.0);
  /// CSSFilter.apply(child: const Text('Hello World!'), invert: 0.1, brightness: 1.2, saturate: 1.5);
  /// ```
  /// 
  static Widget apply({ 
    required Widget child,
    double contrast = 1.0,
    double grayscale = 0.0,
    double sepia = 0.0,
    double hueRotate = 0.0,
    double brightness = 1.0,
    double saturate = 1.0,
    double invert = 0.0,
    double blur = 0.0
  }) {
    List<double> matrix = baseMatrix();
    
    if (isNotDefault(contrast)) matrix = FilterMatrix.contrast(matrix: matrix, value: contrast);
    if (isPositive(grayscale)) matrix = FilterMatrix.grayscale(matrix: matrix, value: grayscale);
    if (isPositive(sepia)) matrix = FilterMatrix.sepia(matrix: matrix, value: sepia);
    if (hueRotate != 0.0) matrix = FilterMatrix.hue(matrix: matrix, value: hueRotate);
    if (isNotDefault(brightness)) matrix = FilterMatrix.brightness(matrix: matrix, value: brightness);
    if (isNotDefault(saturate)) matrix = FilterMatrix.saturate(matrix: matrix, value: saturate);

    Widget tree = ColorFiltered(
      colorFilter: toColorFilterMatrix(matrix),
      child: child,
    );

    // Not superimposed on the original matrix.
    return CSSFilter.blur(child: CSSFilter.invert(child: tree, value: invert), value: blur);
  }
}