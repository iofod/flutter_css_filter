import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:css_filter/src/util.dart';
import 'package:flutter/foundation.dart';
import 'package:css_filter/css_filter.dart';

void main() {
  group('[util Tests]', () {
    test('baseMatrix', () {
      expect(baseMatrix().length, 25);
    });

    test('isNotNegative', () {
      expect(isNotNegative(-double.infinity), false);
      expect(isNotNegative(-1.0), false);
      expect(isNotNegative(0.0), false);
      expect(isNotNegative(1.0), true);
      expect(isNotNegative(double.infinity), true);
    });

    test('isNotDefault', () {
      expect(isNotNegative(-double.infinity), false);
      expect(isNotDefault(-1.0), false);
      expect(isNotDefault(0.0), true);
      expect(isNotDefault(0.5), true);
      expect(isNotDefault(1.0), false);
      expect(isNotDefault(1.5), true);
      expect(isNotDefault(double.maxFinite), true);
    });

    test('execFilterSample and toColorFilterMatrix', () {
      final matrix = baseMatrix();

      expect(execFilterSample(matrix, const Text('foo')) is ColorFiltered, true);
    });

    test('multiplyMatrix5', () {
      final matrix = baseMatrix();
      final matrix1 = baseMatrix();
      final matrix2 = baseMatrix();
      final matrix3 = baseMatrix();

      matrix3.add(0.0);

      expect(() => multiplyMatrix5(matrix1, matrix3), throwsFlutterError);
      expect(() => multiplyMatrix5(matrix3, matrix1), throwsFlutterError);
      expect(listEquals(multiplyMatrix5(matrix1, matrix2), matrix), true);
    });
  });

  group('[FilterMatrix Tests]', () {
    final matrix = baseMatrix();
    final matrix1 = baseMatrix();
    test('FilterMatrix.contrast', () {
      List<double> contrast1 = FilterMatrix.contrast(matrix: matrix, value: 2.0);
      List<double> contrast2 = FilterMatrix.contrast(matrix: contrast1, value: 0.5);

      expect(listEquals(contrast2, matrix), true);
    });

    test('FilterMatrix.grayscale', () {
      List<double> grayscale1 = FilterMatrix.grayscale(matrix: matrix, value: 0.0);

      expect(listEquals(grayscale1, matrix), true);
    });

    test('FilterMatrix.sepia', () {
      List<double> sepia1 = FilterMatrix.sepia(matrix: matrix, value: 0.0);

      expect(listEquals(sepia1, matrix), true);
    });

    test('FilterMatrix.invert', () {
      List<double> invert1 = FilterMatrix.invert(matrix: matrix, value: 1.0);
      List<double> invert2 = FilterMatrix.invert(matrix: invert1, value: 1.0);

      expect(listEquals(invert2, matrix), true);
    });

    test('FilterMatrix.hue', () {
      final sum = matrix1.reduce((a, b) => a + b);

      List<double> hue1 = FilterMatrix.hue(matrix: matrix, value: 360.0);

      expect(sum == hue1.reduce((a, b) => a + b), true);

      List<double> hue2 = FilterMatrix.hue(matrix: matrix, value: 90.0);
      List<double> hue3 = FilterMatrix.hue(matrix: hue2, value: -90.0);

      expect(sum == hue3.reduce((a, b) => a + b), true);

      List<double> hue4 = FilterMatrix.hue(matrix: matrix, value: 0.0);

      expect(listEquals(hue4, matrix), true);
    });

    test('FilterMatrix.brightness', () {
      List<double> saturate1 = FilterMatrix.saturate(matrix: matrix, value: 1.0);

      expect(listEquals(saturate1, matrix), true);
    });

    test('FilterMatrix.saturate', () {
      List<double> saturate1 = FilterMatrix.saturate(matrix: matrix, value: 1.0);

      expect(listEquals(saturate1, matrix), true);
    });

    test('FilterMatrix.opacity', () {
      List<double> opacity1 = FilterMatrix.opacity(matrix: matrix, value: 1.0);

      expect(listEquals(opacity1, matrix), true);
    });

  });

  group('[CSSFilter Tests]', () {
    Widget testWidget = const Text('Hello world');
    test('baseMatrix', () {
      expect(baseMatrix().length, 25);
    });

    test('CSSFilter.contrast', () {
      Widget contrast1 = CSSFilter.contrast(child: testWidget, value: 1.0);
      
      expect(contrast1, testWidget);

      Widget contrast2 = CSSFilter.contrast(child: testWidget, value: -1.0);

      expect(contrast2, testWidget);

      Widget contrast3 = CSSFilter.contrast(child: testWidget, value: 2.0);

      expect(contrast3 is ColorFiltered, true);
    });

    test('CSSFilter.grayscale', () {
      Widget grayscale1 = CSSFilter.grayscale(child: testWidget, value: 0.0);
      
      expect(grayscale1, testWidget);

      Widget grayscale2 = CSSFilter.grayscale(child: testWidget, value: -1.0);

      expect(grayscale2, testWidget);

      Widget grayscale3 = CSSFilter.grayscale(child: testWidget, value: 1.0);

      expect(grayscale3 is ColorFiltered, true);
    });

    test('CSSFilter.sepia', () {
      Widget sepia1 = CSSFilter.sepia(child: testWidget, value: 0.0);
      
      expect(sepia1, testWidget);

      Widget sepia2 = CSSFilter.sepia(child: testWidget, value: -1.0);

      expect(sepia2, testWidget);

      Widget sepia3 = CSSFilter.sepia(child: testWidget, value: 1.0);

      expect(sepia3 is ColorFiltered, true);
    });

    test('CSSFilter.hueRotate', () {
      Widget hueRotate1 = CSSFilter.hueRotate(child: testWidget, value: 0.0);
      
      expect(hueRotate1, testWidget);

      Widget sepia2 = CSSFilter.hueRotate(child: testWidget, value: 90.0);

      expect(sepia2 is ColorFiltered, true);
    });

    test('CSSFilter.brightness', () {
      Widget brightness1 = CSSFilter.brightness(child: testWidget, value: 1.0);
      
      expect(brightness1, testWidget);

      Widget brightness2 = CSSFilter.brightness(child: testWidget, value: -1.0);

      expect(brightness2, testWidget);

      Widget brightness3 = CSSFilter.brightness(child: testWidget, value: 2.0);

      expect(brightness3 is ColorFiltered, true);
    });

    test('CSSFilter.saturate', () {
      Widget saturate1 = CSSFilter.saturate(child: testWidget, value: 1.0);
      
      expect(saturate1, testWidget);

      Widget saturate2 = CSSFilter.saturate(child: testWidget, value: -1.0);

      expect(saturate2, testWidget);

      Widget saturate3 = CSSFilter.saturate(child: testWidget, value: 2.0);

      expect(saturate3 is ColorFiltered, true);
    });

    test('CSSFilter.invert', () {
      Widget invert1 = CSSFilter.invert(child: testWidget, value: 0.0);
      
      expect(invert1, testWidget);

      Widget invert2 = CSSFilter.invert(child: testWidget, value: -1.0);

      expect(invert2, testWidget);

      Widget invert3 = CSSFilter.invert(child: testWidget, value: 1.0);

      expect(invert3 is ColorFiltered, true);
    });

    test('CSSFilter.blur', () {
      Widget blur1 = CSSFilter.blur(child: testWidget, value: 0.0);
      
      expect(blur1, testWidget);

      Widget blur2 = CSSFilter.blur(child: testWidget, value: -1.0);

      expect(blur2, testWidget);

      Widget blur3 = CSSFilter.blur(child: testWidget, value: 1.0);

      expect(blur3 is ImageFiltered, true);
    });

    test('CSSFilter.opacity', () {
      Widget opacity1 = CSSFilter.opacity(child: testWidget, value: 1.0);
      
      expect(opacity1, testWidget);

      Widget opacity2 = CSSFilter.opacity(child: testWidget, value: -1.0);

      expect(opacity2, testWidget);

      Widget opacity3 = CSSFilter.opacity(child: testWidget, value: 0.5);

      expect(opacity3 is ColorFiltered, true);
    });
    
    test('CSSFilter.apply use default values', () {
      final matrix = baseMatrix();

      Widget origin = ColorFiltered(
        colorFilter: toColorFilterMatrix(matrix),
        child: testWidget,
      );

      Widget apply1 = CSSFilter.apply(child: testWidget);

      expect(origin.toString(), apply1.toString());
    });

    test('CSSFilter.apply use independently', () {
      Widget contrast = CSSFilter.contrast(child: testWidget, value: 2.0);
      Widget applyContrast = CSSFilter.apply(child: testWidget, contrast: 2.0);

      expect(contrast.toString(), applyContrast.toString());

      Widget grayscale = CSSFilter.grayscale(child: testWidget, value: 1.0);
      Widget applyGrayscale = CSSFilter.apply(child: testWidget, grayscale: 1.0);

      expect(grayscale.toString(), applyGrayscale.toString());

      Widget sepia = CSSFilter.sepia(child: testWidget, value: 1.0);
      Widget applySepia = CSSFilter.apply(child: testWidget, sepia: 1.0);

      expect(sepia.toString(), applySepia.toString());

      Widget hueRotate = CSSFilter.hueRotate(child: testWidget, value: 90.0);
      Widget applyHueRotate = CSSFilter.apply(child: testWidget, hueRotate: 90.0);

      expect(hueRotate.toString(), applyHueRotate.toString());

      Widget brightness = CSSFilter.brightness(child: testWidget, value: 2.0);
      Widget applyBrightness = CSSFilter.apply(child: testWidget, brightness: 2.0);

      expect(brightness.toString(), applyBrightness.toString());

      Widget saturate = CSSFilter.saturate(child: testWidget, value: 2.0);
      Widget applySaturate = CSSFilter.apply(child: testWidget, saturate: 2.0);

      expect(saturate.toString(), applySaturate.toString());

      Widget invert = CSSFilter.invert(child: testWidget, value: 1.0);
      Widget applyInvert = CSSFilter.apply(child: testWidget, invert: 1.0);

      expect(invert.toString(), applyInvert.toString());

      Widget blur = CSSFilter.blur(child: testWidget, value: 1.0);
      Widget applyBlur = CSSFilter.apply(child: testWidget, blur: 1.0);

      expect(blur.toString(), applyBlur.toString());
    });

    test('CSSFilter.apply use in combination', () {
      Widget invert = CSSFilter.invert(child: testWidget, value: 1.0);
      Widget blurPlusInvert = CSSFilter.blur(child: invert, value: 1.0);
      Widget applyBlur = CSSFilter.apply(child: invert, blur: 1.0);

      expect(blurPlusInvert.toString(), applyBlur.toString());

      Widget applyBlurPlusInvert = CSSFilter.apply(child: testWidget, invert: 1.0, blur: 1.0);

      expect(blurPlusInvert.toString(), applyBlurPlusInvert.toString());
    });
  });
}
