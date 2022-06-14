import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:css_filter/src/utils.dart';
import 'package:css_filter/css_filter.dart';

void main() {
  group('[utils Tests]', () {
    Rect rect1 = const Rect.fromLTWH(0.0, 0.0, 1.0, 1.0);

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

      expect(
          execFilterSample(matrix, const Text('foo')) is ColorFiltered, true);
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

    test('execShaderDirectSample', () {
      final shaderCallback =
          execShaderDirectSample(Colors.black, Alignment.center);
      final shader = shaderCallback(rect1);

      expect(shaderCallback is Function, true);
      expect(shader is Shader, true);
    });

    test('execShaderLinearSample', () {
      final shaderCallback = execShaderLinearSample(
          [Colors.black, Colors.black], Alignment.center, [0.1, 0.9]);
      final shader = shaderCallback(rect1);

      expect(shaderCallback is Function, true);
      expect(shader is Shader, true);
    });

    test('execShaderRadialSample', () {
      final shaderCallback =
          execShaderRadialSample([Colors.black, Colors.black], [0.1, 0.9], 0.5);
      final shader = shaderCallback(rect1);

      expect(shaderCallback is Function, true);
      expect(shader is Shader, true);
    });
  });

  group('[CSSFilterMatrix Tests]', () {
    test('CSSFilterMatrix base', () {
      final eg = CSSFilterMatrix().contrast(1.0);

      expect(eg.conf['contrast'], 1.0);
    });

    test('CSSFilterMatrix this', () {
      final eg = CSSFilterMatrix()
          .contrast()
          .grayscale()
          .sepia()
          .hueRotate()
          .brightness()
          .saturate()
          .invert()
          .blur()
          .opacity();

      expect(eg is CSSFilterMatrix, true);
    });

    test('CSSFilterMatrix chain calls', () {
      final eg = CSSFilterMatrix().contrast(1.0).grayscale(1.0);

      expect(eg.conf['contrast'], 1.0);
      expect(eg.conf['grayscale'], 1.0);
    });
  });

  group('[FilterMatrix Tests]', () {
    final matrix = baseMatrix();
    final matrix1 = baseMatrix();
    test('FilterMatrix.contrast', () {
      List<double> contrast1 =
          FilterMatrix.contrast(matrix: matrix, value: 2.0);
      List<double> contrast2 =
          FilterMatrix.contrast(matrix: contrast1, value: 0.5);

      expect(listEquals(contrast2, matrix), true);
    });

    test('FilterMatrix.grayscale', () {
      List<double> grayscale1 =
          FilterMatrix.grayscale(matrix: matrix, value: 0.0);

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
      List<double> saturate1 =
          FilterMatrix.saturate(matrix: matrix, value: 1.0);

      expect(listEquals(saturate1, matrix), true);
    });

    test('FilterMatrix.saturate', () {
      List<double> saturate1 =
          FilterMatrix.saturate(matrix: matrix, value: 1.0);

      expect(listEquals(saturate1, matrix), true);
    });

    test('FilterMatrix.opacity', () {
      List<double> opacity1 = FilterMatrix.opacity(matrix: matrix, value: 1.0);

      expect(listEquals(opacity1, matrix), true);
    });
  });

  group('[CSSFilter Tests]', () {
    Widget testWidget = const Text('foo');

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
      Widget origin = testWidget;
      Widget apply1 =
          CSSFilter.apply(child: testWidget, value: CSSFilterMatrix());

      expect(origin.toString(), apply1.toString());
    });

    test('CSSFilter.apply use independently', () {
      Widget contrast = CSSFilter.contrast(child: testWidget, value: 2.0);
      Widget applyContrast = CSSFilter.apply(
          child: testWidget, value: CSSFilterMatrix().contrast(2.0));

      expect(contrast.toString(), applyContrast.toString());

      Widget grayscale = CSSFilter.grayscale(child: testWidget, value: 1.0);
      Widget applyGrayscale = CSSFilter.apply(
          child: testWidget, value: CSSFilterMatrix().grayscale(1.0));

      expect(grayscale.toString(), applyGrayscale.toString());

      Widget sepia = CSSFilter.sepia(child: testWidget, value: 1.0);
      Widget applySepia = CSSFilter.apply(
          child: testWidget, value: CSSFilterMatrix().sepia(1.0));

      expect(sepia.toString(), applySepia.toString());

      Widget hueRotate = CSSFilter.hueRotate(child: testWidget, value: 90.0);
      Widget applyHueRotate = CSSFilter.apply(
          child: testWidget, value: CSSFilterMatrix().hueRotate(90.0));

      expect(hueRotate.toString(), applyHueRotate.toString());

      Widget brightness = CSSFilter.brightness(child: testWidget, value: 2.0);
      Widget applyBrightness = CSSFilter.apply(
          child: testWidget, value: CSSFilterMatrix().brightness(2.0));

      expect(brightness.toString(), applyBrightness.toString());

      Widget saturate = CSSFilter.saturate(child: testWidget, value: 2.0);
      Widget applySaturate = CSSFilter.apply(
          child: testWidget, value: CSSFilterMatrix().saturate(2.0));

      expect(saturate.toString(), applySaturate.toString());

      Widget invert = CSSFilter.invert(child: testWidget, value: 1.0);
      Widget applyInvert = CSSFilter.apply(
          child: testWidget, value: CSSFilterMatrix().invert(1.0));

      expect(invert.toString(), applyInvert.toString());

      Widget blur = CSSFilter.blur(child: testWidget, value: 1.0);
      Widget applyBlur = CSSFilter.apply(
          child: testWidget, value: CSSFilterMatrix().blur(1.0));

      expect(blur.toString(), applyBlur.toString());
    });

    test('CSSFilter.apply use in combination', () {
      Widget invert = CSSFilter.invert(child: testWidget, value: 1.0);
      Widget blurPlusInvert = CSSFilter.blur(child: invert, value: 1.0);
      Widget applyBlur =
          CSSFilter.apply(child: invert, value: CSSFilterMatrix().blur(1.0));

      expect(blurPlusInvert.toString(), applyBlur.toString());

      Widget applyBlurPlusInvert = CSSFilter.apply(
          child: testWidget, value: CSSFilterMatrix().invert(1.0).blur(1.0));

      expect(blurPlusInvert.toString(), applyBlurPlusInvert.toString());
    });
  });

  group('[CSSFilterPresets Tests]', () {
    Widget testWidget = const Text('bar');

    test('Presets Tests', () {
      Widget origin = CSSFilterPresets.origin(child: testWidget);

      expect(origin, testWidget);

      Widget ins1977 = CSSFilterPresets.ins1977(child: testWidget);

      expect(ins1977 is ShaderMask, true);

      Widget ins1977V2 = CSSFilterPresets.ins1977V2(child: testWidget);

      expect(ins1977V2 is ColorFiltered, true);

      Widget insAden = CSSFilterPresets.insAden(child: testWidget);

      expect(insAden is ShaderMask, true);

      Widget insAmaro = CSSFilterPresets.insAmaro(child: testWidget);

      expect(insAmaro is ShaderMask, true);

      Widget insAshby = CSSFilterPresets.insAshby(child: testWidget);

      expect(insAshby is ShaderMask, true);

      Widget insBrannan = CSSFilterPresets.insBrannan(child: testWidget);

      expect(insBrannan is ShaderMask, true);

      Widget insBrooklyn = CSSFilterPresets.insBrooklyn(child: testWidget);

      expect(insBrooklyn is ShaderMask, true);

      Widget insClarendon = CSSFilterPresets.insClarendon(child: testWidget);

      expect(insClarendon is ShaderMask, true);

      Widget insDogpatch = CSSFilterPresets.insDogpatch(child: testWidget);

      expect(insDogpatch is ColorFiltered, true);

      Widget insEarlybird = CSSFilterPresets.insEarlybird(child: testWidget);

      expect(insEarlybird is ShaderMask, true);

      Widget insGingham = CSSFilterPresets.insGingham(child: testWidget);

      expect(insGingham is ShaderMask, true);

      Widget insHelena = CSSFilterPresets.insHelena(child: testWidget);

      expect(insHelena is ShaderMask, true);

      Widget insHudson = CSSFilterPresets.insHudson(child: testWidget);

      expect(insHudson is ShaderMask, true);

      Widget insInkwell = CSSFilterPresets.insInkwell(child: testWidget);

      expect(insInkwell is ColorFiltered, true);

      Widget insInkwellV2 = CSSFilterPresets.insInkwellV2(child: testWidget);

      expect(insInkwellV2 is ColorFiltered, true);

      Widget insJuno = CSSFilterPresets.insJuno(child: testWidget);

      expect(insJuno is ShaderMask, true);

      Widget insKelvin = CSSFilterPresets.insKelvin(child: testWidget);

      expect(insKelvin is ShaderMask, true);

      Widget insLark = CSSFilterPresets.insLark(child: testWidget);

      expect(insLark is ColorFiltered, true);

      Widget insLofi = CSSFilterPresets.insLofi(child: testWidget);

      expect(insLofi is ColorFiltered, true);

      Widget insLudwig = CSSFilterPresets.insLudwig(child: testWidget);

      expect(insLudwig is ShaderMask, true);

      Widget insMaven = CSSFilterPresets.insMaven(child: testWidget);

      expect(insMaven is ShaderMask, true);

      Widget insMayfair = CSSFilterPresets.insMayfair(child: testWidget);

      expect(insMayfair is ShaderMask, true);

      Widget insMoon = CSSFilterPresets.insMoon(child: testWidget);

      expect(insMoon is ShaderMask, true);

      Widget insMoonV2 = CSSFilterPresets.insMoonV2(child: testWidget);

      expect(insMoonV2 is ColorFiltered, true);

      Widget insNashville = CSSFilterPresets.insNashville(child: testWidget);

      expect(insNashville is ShaderMask, true);

      Widget insNashvilleV2 =
          CSSFilterPresets.insNashvilleV2(child: testWidget);

      expect(insNashvilleV2 is ShaderMask, true);

      Widget insPerpetua = CSSFilterPresets.insPerpetua(child: testWidget);

      expect(insPerpetua is ShaderMask, true);

      Widget insPoprocket = CSSFilterPresets.insPoprocket(child: testWidget);

      expect(insPoprocket is ShaderMask, true);

      Widget insReyes = CSSFilterPresets.insReyes(child: testWidget);

      expect(insReyes is ColorFiltered, true);

      Widget insRise = CSSFilterPresets.insRise(child: testWidget);

      expect(insRise is ShaderMask, true);

      Widget insSierra = CSSFilterPresets.insSierra(child: testWidget);

      expect(insSierra is ShaderMask, true);

      Widget insSkyline = CSSFilterPresets.insSkyline(child: testWidget);

      expect(insSkyline is ColorFiltered, true);

      Widget insSlumber = CSSFilterPresets.insSlumber(child: testWidget);

      expect(insSlumber is ShaderMask, true);

      Widget insStinson = CSSFilterPresets.insStinson(child: testWidget);

      expect(insStinson is ShaderMask, true);

      Widget insSutro = CSSFilterPresets.insSutro(child: testWidget);

      expect(insSutro is ShaderMask, true);

      Widget insToaster = CSSFilterPresets.insToaster(child: testWidget);

      expect(insToaster is ShaderMask, true);

      Widget insToasterV2 = CSSFilterPresets.insToasterV2(child: testWidget);

      expect(insToasterV2 is ShaderMask, true);

      Widget insValencia = CSSFilterPresets.insValencia(child: testWidget);

      expect(insValencia is ShaderMask, true);

      Widget insVesper = CSSFilterPresets.insVesper(child: testWidget);

      expect(insVesper is ShaderMask, true);

      Widget insWalden = CSSFilterPresets.insWalden(child: testWidget);

      expect(insWalden is ShaderMask, true);

      Widget insWaldenV2 = CSSFilterPresets.insWaldenV2(child: testWidget);

      expect(insWaldenV2 is ShaderMask, true);

      Widget insWillow = CSSFilterPresets.insWillow(child: testWidget);

      expect(insWillow is ColorFiltered, true);

      Widget insXpro2 = CSSFilterPresets.insXpro2(child: testWidget);

      expect(insXpro2 is ShaderMask, true);
    });

    test('CSSFilterPresets.apply use outliers', () {
      Widget apply1 = CSSFilterPresets.apply(
          child: testWidget, value: CSSFilterPresets.ins1977, strength: 0.0);

      expect(apply1, testWidget);

      Widget apply2 = CSSFilterPresets.apply(
          child: testWidget,
          value: CSSFilterPresets.ins1977,
          strength: 0.5,
          alphaBlending: 2.0);

      expect(apply2 is Stack, true);

      Widget apply3 = CSSFilterPresets.apply(
          child: testWidget,
          value: CSSFilterPresets.ins1977,
          strength: 0.5,
          alphaBlending: -1.0);

      expect(apply3 is Opacity, true);

      Widget apply4 = CSSFilterPresets.apply(
          child: testWidget, value: CSSFilterPresets.ins1977V2, strength: 4.0);

      expect(apply4 is ColorFiltered, true);
    });

    test('CSSFilterPresets.apply base usage', () {
      Widget origin = CSSFilterPresets.ins1977V2(child: testWidget);
      Widget apply1 = CSSFilterPresets.apply(
          child: testWidget, value: CSSFilterPresets.ins1977V2);

      expect(origin.toString(), apply1.toString());
    });

    test('CSSFilterPresets.apply use strength', () {
      Widget apply1 = CSSFilterPresets.apply(
          child: testWidget, value: CSSFilterPresets.ins1977V2, strength: 0.6);

      expect(apply1 is Stack, true);
    });

    test('CSSFilterPresets.apply use alphaBlending', () {
      Widget apply1 = CSSFilterPresets.apply(
          child: testWidget,
          value: CSSFilterPresets.ins1977,
          strength: 0.5,
          alphaBlending: 0.5);

      expect(apply1 is Opacity, true);
    });

    test('CSSFilterPresets.apply use customPreset', () {
      Widget apply1 = CSSFilterPresets.apply(
          child: testWidget,
          value: ({required Widget child}) {
            return CSSFilter.apply(
                child: child,
                value: CSSFilterMatrix().sepia(0.2).saturate(1.4));
          });

      expect(apply1 is ColorFiltered, true);
    });
  });
}
