import 'package:flutter/material.dart';

import 'filter.dart';
import 'utils.dart';

/// Added more preset filter effects to CSSFilter.
/// The current version adds instagram filter package, the values mainly refer to [CSSgram](https://github.com/una/CSSgram), partly refer to [instagram.css](https://github.com/picturepan2/instagram.css).
/// 
/// Example:
/// 
/// ```dart
/// CSSFilterPresets.insAshby(child: const Text('foo'));
/// CSSFilterPresets.insHelena(child: const Text('bar'));
/// ```
/// 
/// Support effects:
/// * ins1977()
/// * ins1977V2()
/// * insAden()
/// * insAmaro()
/// * insAshby()
/// * insBrannan()
/// * insBrooklyn()
/// * insClarendon()
/// * insDogpatch()
/// * insEarlybird()
/// * insGingham()
/// * insHelena()
/// * insHudson()
/// * insInkwell()
/// * insInkwellV2()
/// * insJuno()
/// * insKelvin()
/// * insLark()
/// * insLofi()
/// * insLudwig()
/// * insMaven()
/// * insMayfair()
/// * insMoon()
/// * insMoonV2()
/// * insNashville()
/// * insNashvilleV2()
/// * insPerpetua()
/// * insPoprocket()
/// * insReyes()
/// * insRise()
/// * insSierra()
/// * insSkyline()
/// * insSlumber()
/// * insStinson()
/// * insSutro()
/// * insToaster()
/// * insToasterV2()
/// * insValencia()
/// * insVesper()
/// * insWalden()
/// * insWaldenV2()
/// * insWillow()
/// * insXpro2()
/// 
class CSSFilterPresets {
  /// A quick and efficient way to apply preset effects to the input widget.
  /// You can even adjust the intensity of the preset effects.
  /// 
  /// Example:
  /// 
  /// ```dart
  /// CSSFilterPresets.apply(
  ///   child: const Text('foo'),
  ///   value: CSSFilterPresets.insMaven, 
  ///   strength: 0.6
  /// );
  /// ```
  /// 
  /// If the input widget is transparent, then the `alphaBlending` parameter should be set to adjust the [Alpha Compositing](https://ciechanow.ski/alpha-compositing/) to avoid gross overlay of transparency.
  /// In general, `alphaBlending` is set to the same opacity value as the input widget. If the opacity of the input widget is unknown, the `alphaBlending` value is set according to the actual situation.
  /// 
  static Widget apply({ required Widget child, required Function value, double strength = 1.0, double alphaBlending = 1.0}) {
    if (strength <= 0.0) return child;
    if (strength >= 1.0) strength = 1.0;

    Widget filtered = value(child: child);

    if (strength == 1.0) return filtered;
    if (alphaBlending > 1.0) alphaBlending = 1.0;
    if (alphaBlending < 0.0) alphaBlending = 0.0;

    Widget tree = Stack(children: [
      Positioned(child: child),
      Positioned(child: IgnorePointer(
        child: Opacity(opacity: strength, child: filtered)
      ))
    ]);

    if (alphaBlending == 1.0) return tree;

    return Opacity(opacity: 1.0 - (1.0 - alphaBlending) * strength, child: tree);
  }
  static Widget origin({ required Widget child }) {
    return child;
  }
  static Widget ins1977({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderDirectSample(const Color.fromRGBO(243, 106, 188, 0.3)),
      blendMode: BlendMode.screen,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().contrast(1.1).brightness(1.1).saturate(1.3)
      ),
    );
  }
  static Widget ins1977V2({ required Widget child }) {
    return CSSFilter.apply(
      child: child, 
      value: CSSFilterMatrix().sepia(0.5).hueRotate(-30.0).saturate(1.4)
    );
  }
  static Widget insAden({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderLinearSample([const Color.fromRGBO(66, 10, 14, 0.2), const Color.fromRGBO(0, 0, 0, 0.0)], Alignment.centerRight),
      blendMode: BlendMode.darken,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().hueRotate(-20.0).contrast(0.9).saturate(0.85).brightness(1.2)
      ),
    );
  }
  static Widget insAmaro({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderDirectSample(const Color.fromRGBO(125, 105, 24, 0.2)),
      blendMode: BlendMode.overlay,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().sepia(0.35).contrast(1.1).brightness(1.2).saturate(1.3)
      ),
    );
  }
  static Widget insAshby({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderDirectSample(const Color.fromRGBO(125, 105, 24, 0.35)),
      blendMode: BlendMode.lighten,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().sepia(0.5).contrast(1.2).saturate(1.8)
      ),
    );
  }
  static Widget insBrannan({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderDirectSample(const Color.fromRGBO(161, 44, 199, 0.31)),
      blendMode: BlendMode.lighten,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().sepia(0.5).contrast(1.4)
      ),
    );
  }
  static Widget insBrooklyn({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderRadialSample([const Color.fromRGBO(168, 223, 193, 0.4), const Color.fromRGBO(196, 183, 200, 1.0)], [0.0, 0.7]),
      blendMode: BlendMode.overlay,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().contrast(0.9).brightness(1.1)
      ),
    );
  }
  static Widget insClarendon({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderDirectSample(const Color.fromRGBO(127, 187, 227, 0.2)),
      blendMode: BlendMode.overlay,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().contrast(1.2).saturate(1.35)
      ),
    );
  }
  static Widget insDogpatch({ required Widget child }) {
    return CSSFilter.apply(
      child: child, 
      value: CSSFilterMatrix().sepia(0.35).saturate(1.1).contrast(1.5)
    );
  }
  static Widget insEarlybird({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderRadialSample([const Color.fromRGBO(208, 186, 142, 1.0), const Color.fromRGBO(54, 3, 9, 1.0), const Color.fromRGBO(29, 2, 16, 1.0)], [0.2, 0.85, 1.0]),
      blendMode: BlendMode.overlay,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().contrast(0.9).sepia(0.2)
      ),
    );
  }
  static Widget insGingham({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderDirectSample(const Color.fromRGBO(230, 230, 250, 1.0)),
      blendMode: BlendMode.softLight,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().brightness(1.05).hueRotate(-10.0)
      ),
    );
  }
  static Widget insHelena({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderDirectSample(const Color.fromRGBO(158, 175, 30, 0.25)),
      blendMode: BlendMode.overlay,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().sepia(0.5).contrast(1.05).brightness(1.05).saturate(1.35)
      ),
    );
  }
  static Widget insHudson({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderRadialSample([const Color.fromRGBO(166, 177, 255, 0.5), const Color.fromRGBO(52, 33, 52, 0.5)], [0.5, 1.0]),
      blendMode: BlendMode.multiply,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().brightness(1.2).contrast(0.9).saturate(1.1)
      ),
    );
  }
  static Widget insInkwell({ required Widget child }) {
    return CSSFilter.apply(
      child: child, 
      value: CSSFilterMatrix().sepia(0.3).contrast(1.1).brightness(1.1).grayscale(1.0)
    );
  }
  static Widget insInkwellV2({ required Widget child }) {
    return CSSFilter.apply(
      child: child, 
      value: CSSFilterMatrix().brightness(1.25).contrast(0.85).grayscale(1.0)
    );
  }
  static Widget insJuno({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderDirectSample(const Color.fromRGBO(127, 187, 227, 0.2)),
      blendMode: BlendMode.overlay,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().sepia(0.35).contrast(1.15).brightness(1.15).saturate(1.8)
      ),
    );
  }
  static Widget insKelvin({ required Widget child }) {
    Widget sub = ShaderMask(
      shaderCallback: execShaderDirectSample(const Color.fromRGBO(56, 44, 52, 1.0)),
      blendMode: BlendMode.colorDodge,
      child: child
    );

    return ShaderMask(
      shaderCallback: execShaderDirectSample(const Color.fromRGBO(183, 125, 33, 1.0)),
      blendMode: BlendMode.overlay,
      child: sub,
    );
  }
  static Widget insLark({ required Widget child }) {
    return CSSFilter.apply(
      child: child, 
      value: CSSFilterMatrix().sepia(0.25).contrast(1.2).brightness(1.3).saturate(1.25)
    );
  }
  static Widget insLofi({ required Widget child }) {
    return CSSFilter.apply(
      child: child, 
      value: CSSFilterMatrix().saturate(1.1).contrast(1.5)
    );
  }
  static Widget insLudwig({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderDirectSample(const Color.fromRGBO(125, 105, 24, 0.1)),
      blendMode: BlendMode.overlay,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().sepia(0.25).contrast(1.05).brightness(1.05).saturate(2.0)
      ),
    );
  }
  static Widget insMaven({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderDirectSample(const Color.fromRGBO(3, 230, 26, 0.2)),
      blendMode: BlendMode.hue,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().contrast(0.95).brightness(0.95).saturate(1.5).sepia(0.25)
      ),
    );
  }
  static Widget insMayfair({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderRadialSample([const Color.fromRGBO(255, 255, 255, 0.32), const Color.fromRGBO(255, 200, 200, 0.24), const Color.fromRGBO(17, 17, 17, 0.4)], const [0.0, 0.0, 0.6]),
      blendMode: BlendMode.overlay,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().contrast(1.1).saturate(1.1)
      ),
    );
  }
  static Widget insMoon({ required Widget child }) {
    Widget sub = ShaderMask(
      shaderCallback: execShaderDirectSample(const Color.fromRGBO(160, 160, 160, 1.0)),
      blendMode: BlendMode.softLight,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().grayscale(1).contrast(1.1).brightness(1.1)
      ),
    );

    return ShaderMask(
      shaderCallback: execShaderDirectSample(const Color.fromRGBO(56, 56, 56, 1.0)),
      blendMode: BlendMode.lighten,
      child: sub,
    );
  }
  static Widget insMoonV2({ required Widget child }) {
    return CSSFilter.apply(
      child: child, 
      value: CSSFilterMatrix().brightness(1.4).contrast(0.95).saturate(0.0).sepia(0.35)
    );
  }
  static Widget insNashville({ required Widget child }) {
    Widget sub = ShaderMask(
      shaderCallback: execShaderDirectSample(const Color.fromRGBO(247, 176, 153, 0.56)),
      blendMode: BlendMode.darken,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().sepia(0.2).contrast(1.2).brightness(1.05).saturate(1.2)
      ),
    );

    return ShaderMask(
      shaderCallback: execShaderDirectSample(const Color.fromRGBO(0, 70, 150, 0.4)),
      blendMode: BlendMode.lighten,
      child: sub,
    );
  }
  static Widget insNashvilleV2({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderRadialSample([const Color.fromRGBO(128, 78, 15, 0.5), const Color.fromRGBO(128, 78, 15, 0.65)]),
      blendMode: BlendMode.screen,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().sepia(0.25).contrast(1.5).brightness(0.9).hueRotate(-15.0)
      ),
    );
  }
  static Widget insPerpetua({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderLinearSample([const Color.fromRGBO(0, 91, 154, 0.5), const Color.fromRGBO(230, 193, 61, 0.5)], Alignment.bottomCenter),
      blendMode: BlendMode.softLight,
      child: child,
    );
  }
  static Widget insPoprocket({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderRadialSample([const Color.fromRGBO(206, 39, 70, 0.75), const Color.fromRGBO(0, 0, 0, 1.0)], const [0.4, 0.8]),
      blendMode: BlendMode.screen,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().sepia(0.15).brightness(1.2)
      ),
    );
  }
  static Widget insReyes({ required Widget child }) {
    return CSSFilter.apply(
      child: child, 
      value: CSSFilterMatrix().sepia(0.75).contrast(0.75).brightness(1.25).saturate(1.4)
    );
  }
  static Widget insRise({ required Widget child }) {
    Widget sub = ShaderMask(
      shaderCallback: execShaderRadialSample([const Color.fromRGBO(236, 205, 169, 0.15), const Color.fromRGBO(50, 30, 7, 0.4)], [0.55, 1.0]),
      blendMode: BlendMode.multiply,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().brightness(1.05).sepia(0.2).contrast(0.9).saturate(0.9)
      ),
    );

    return ShaderMask(
      shaderCallback: execShaderRadialSample([const Color.fromRGBO(232, 197, 152, 0.48), const Color.fromRGBO(0, 0, 0, 0.0)], [0.0, 0.9]),
      blendMode: BlendMode.overlay,
      child: sub,
    );
  }
  static Widget insSierra({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderRadialSample([const Color.fromRGBO(128, 78, 15, 0.5), const Color.fromRGBO(0, 0, 0, 0.65)]),
      blendMode: BlendMode.screen,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().sepia(0.25).contrast(1.5).brightness(0.9).hueRotate(-15.0)
      ),
    );
  }
  static Widget insSkyline({ required Widget child }) {
    return CSSFilter.apply(
      child: child, 
      value: CSSFilterMatrix().sepia(0.15).contrast(1.25).brightness(1.25).saturate(1.2)
    );
  }
  static Widget insSlumber({ required Widget child }) {
    Widget sub = ShaderMask(
      shaderCallback: execShaderDirectSample(const Color.fromRGBO(69, 41, 12, 0.4)),
      blendMode: BlendMode.lighten,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().saturate(0.66).brightness(1.05)
      ),
    );

    return ShaderMask(
      shaderCallback: execShaderDirectSample(const Color.fromRGBO(125, 105, 24, 0.5)),
      blendMode: BlendMode.softLight,
      child: sub
    );
  }
  static Widget insStinson({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderDirectSample(const Color.fromRGBO(240, 149, 128, 0.2)),
      blendMode: BlendMode.softLight,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().contrast(0.75).saturate(0.85).brightness(1.15)
      ),
    );
  }
  static Widget insSutro({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderRadialSample([const Color.fromRGBO(0, 0, 0, 0.0), const Color.fromRGBO(0, 0, 0, 0.5)], const [0.5, 0.9]),
      blendMode: BlendMode.darken,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().sepia(0.4).contrast(1.2).brightness(0.9).saturate(1.4).hueRotate(-10.0)
      ),
    );
  }
  static Widget insToaster({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderRadialSample([const Color.fromRGBO(128, 78, 15, 1.0), const Color.fromRGBO(59, 0, 59, 1.0)]),
      blendMode: BlendMode.screen,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().contrast(1.3).brightness(0.9)
      ),
    );
  }
  static Widget insToasterV2({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderRadialSample([const Color.fromRGBO(128, 78, 15, 1.0), const Color.fromRGBO(0, 0, 0, 0.25)]),
      blendMode: BlendMode.screen,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().sepia(0.25).contrast(1.5).brightness(0.95).hueRotate(-15.0)
      ),
    );
  }
  static Widget insValencia({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderDirectSample(const Color.fromRGBO(58, 3, 57, 0.5)),
      blendMode: BlendMode.exclusion,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().contrast(1.08).brightness(1.08).sepia(0.08)
      ),
    );
  }
  static Widget insVesper({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderDirectSample(const Color.fromRGBO(125, 105, 24, 0.25)),
      blendMode: BlendMode.overlay,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().sepia(0.35).contrast(1.15).brightness(1.2).saturate(1.3)
      ),
    );
  }
  static Widget insWalden({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderDirectSample(const Color.fromRGBO(0, 68, 204, 0.3)),
      blendMode: BlendMode.screen,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().brightness(1.1).hueRotate(-10.0).sepia(0.3).saturate(1.6)
      ),
    );
  }
  static Widget insWaldenV2({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderDirectSample(const Color.fromRGBO(229, 240, 128, 0.5)),
      blendMode: BlendMode.darken,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().sepia(0.35).contrast(0.8).brightness(1.25).saturate(1.4)
      ),
    );
  }
  static Widget insWillow({ required Widget child }) {
    return CSSFilter.apply(
      child: child, 
      value: CSSFilterMatrix().brightness(1.2).contrast(0.85).saturate(0.05).sepia(0.2)
    );
  }
  static Widget insXpro2({ required Widget child }) {
    return ShaderMask(
      shaderCallback: execShaderRadialSample([const Color.fromRGBO(230, 231, 224, 1.0), const Color.fromRGBO(43, 42, 161, 0.6)], [0.4, 1.1]),
      blendMode: BlendMode.colorBurn,
      child: CSSFilter.apply(
        child: child, 
        value: CSSFilterMatrix().sepia(0.3)
      ),
    );
  }
}