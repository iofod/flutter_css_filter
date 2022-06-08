import 'dart:math' as math;
import '../css_filter.dart';
import 'utils.dart';

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
    double v = value;

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
  static opacity({ required List<double> matrix, required double value }) {
    return multiplyMatrix5(matrix, <double>[
      1, 0, 0, 0, 0,
      0, 1, 0, 0, 0,
      0, 0, 1, 0, 0,
      0, 0, 0, value, 0,
      0, 0, 0, 0, 1
    ]);
  }
}

// Allows matrix multiplication.
final filterTypeMap = {
  'contrast': FilterMatrix.contrast,
  'grayscale': FilterMatrix.grayscale,
  'hueRotate': FilterMatrix.hue,
  'brightness': FilterMatrix.brightness,
  'saturate': FilterMatrix.saturate,
  'opacity': FilterMatrix.opacity,
};

// Not superimposed on the original matrix.
final filterAloneMap = {
  'sepia': CSSFilter.sepia,
  'invert': CSSFilter.invert,
  'blur': CSSFilter.blur
};