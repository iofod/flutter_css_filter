# CSS Filter for Flutter

Use CSS filter effects on Flutter.

[![Version](https://img.shields.io/github/v/release/iofod/flutter_css_filter?label=version)](https://pub.dev/packages/css_filter)
[![Build Status](https://github.com/iofod/flutter_css_filter/workflows/build/badge.svg)](https://github.com/iofod/flutter_css_filter/actions)

[IFstruct parser](https://github.com/iofod/IFstruct-parser) supports generating flutter code from [iofod](https://www.iofod.com/) visually edited projects. We have separated its filter module code and added many preset effects to form the current CSS Filter for Flutter, which facilitates all flutter projects to use the excellent design of the Web: [CSS filter](https://developer.mozilla.org/en-US/docs/Web/CSS/filter).

## Features

- Simple and efficient
- Support multiple filter effects overlay
- Rich preset effects.
- Full platform support
- Customize your own effect
- Null-safety

## Getting started

After importing the dependent, you can use the basic filters through `CSSFilter`.

```dart
import 'package:css_filter/css_filter.dart';

CSSFilter.contrast(child: const Text('foo'), value: 1.2);
```

Support filters:

- contrast()
- grayscale()
- sepia()
- hueRotate()
- brightness()
- saturate()
- invert()
- blur()
- opacity()

You can combine and overlay these filters in flutter just as you would with a CSS filter. Use `CSSFilter.apply` in conjunction with `CSSFilterMatrix()`. Such as:

```dart
CSSFilter.apply(
  child: const Text('bar'),
  value: CSSFilterMatrix().contrast(1.2).sepia(0.8).hueRotate(90.0).invert(0.9).opacity(0.9)
);
```

**Note:** the order of the chain calls represents the order in which the filters are applied, and the order in which the filter effects are applied affects the final result.

## Use presets

The [CSSgram](https://github.com/una/CSSgram) project does an excellent job of providing the CSS world with Instagram-like filters, and [instagram.css](https://github.com/picturepan2/instagram.css) complements it with more types of filters. We've combined these two libraries to encapsulate several presets that can call through `CSSFilterPresets`.

```dart
import 'package:css_filter/css_filter.dart';

CSSFilterPresets.insXpro2(child: const Text('Your widget'));
```

Support effects:

| Effect name | Preview effect | Sample code |
| :----: | :----: | :----: |
| origin | ![origin](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/origin.jpg) | `CSSFilterPresets.origin(child: Image(...))` |
| ins1977 | ![ins1977](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/ins1977.jpg) | `CSSFilterPresets.ins1977(child: Image(...))` |
| ins1977V2 | ![ins1977V2](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/ins1977V2.jpg) | `CSSFilterPresets.ins1977V2(child: Image(...))` |
| insAden | ![insAden](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insAden.jpg) | `CSSFilterPresets.insAden(child: Image(...))` |
| insAmaro | ![insAmaro](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insAmaro.jpg) | `CSSFilterPresets.insAmaro(child: Image(...))` |
| insAshby | ![insAshby](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insAshby.jpg) | `CSSFilterPresets.insAshby(child: Image(...))` |
| insBrannan | ![insBrannan](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insBrannan.jpg) | `CSSFilterPresets.insBrannan(child: Image(...))` |
| insBrooklyn | ![insBrooklyn](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insBrooklyn.jpg) | `CSSFilterPresets.insBrooklyn(child: Image(...))` |
| insClarendon | ![insClarendon](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insClarendon.jpg) | `CSSFilterPresets.insClarendon(child: Image(...))` |
| insDogpatch | ![insDogpatch](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insDogpatch.jpg) | `CSSFilterPresets.insDogpatch(child: Image(...))` |
| insEarlybird | ![insEarlybird](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insEarlybird.jpg) | `CSSFilterPresets.insEarlybird(child: Image(...))` |
| insGingham | ![insGingham](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insGingham.jpg) | `CSSFilterPresets.insGingham(child: Image(...))` |
| insHelena | ![insHelena](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insHelena.jpg) | `CSSFilterPresets.insHelena(child: Image(...))` |
| insHudson | ![insHudson](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insHudson.jpg) | `CSSFilterPresets.insHudson(child: Image(...))` |
| insInkwell | ![insInkwell](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insInkwell.jpg) | `CSSFilterPresets.insInkwell(child: Image(...))` |
| insInkwellV2 | ![insInkwellV2](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insInkwellV2.jpg) | `CSSFilterPresets.insInkwellV2(child: Image(...))` |
| insJuno | ![insJuno](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insJuno.jpg) | `CSSFilterPresets.insJuno(child: Image(...))` |
| insKelvin | ![insKelvin](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insKelvin.jpg) | `CSSFilterPresets.insKelvin(child: Image(...))` |
| insLark | ![insLark](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insLark.jpg) | `CSSFilterPresets.insLark(child: Image(...))` |
| insLofi | ![insLofi](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insLofi.jpg) | `CSSFilterPresets.insLofi(child: Image(...))` |
| insLudwig | ![insLudwig](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insLudwig.jpg) | `CSSFilterPresets.insLudwig(child: Image(...))` |
| insMaven | ![insMaven](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insMaven.jpg) | `CSSFilterPresets.insMaven(child: Image(...))` |
| insMayfair | ![insMayfair](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insMayfair.jpg) | `CSSFilterPresets.insMayfair(child: Image(...))` |
| insMoon | ![insMoon](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insMoon.jpg) | `CSSFilterPresets.insMoon(child: Image(...))` |
| insMoonV2 | ![insMoonV2](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insMoonV2.jpg) | `CSSFilterPresets.insMoonV2(child: Image(...))` |
| insNashville | ![insNashville](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insNashville.jpg) | `CSSFilterPresets.insNashville(child: Image(...))` |
| insNashvilleV2 | ![insNashvilleV2](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insNashvilleV2.jpg) | `CSSFilterPresets.insNashvilleV2(child: Image(...))` |
| insPerpetua | ![insPerpetua](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insPerpetua.jpg) | `CSSFilterPresets.insPerpetua(child: Image(...))` |
| insPoprocket | ![insPoprocket](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insPoprocket.jpg) | `CSSFilterPresets.insPoprocket(child: Image(...))` |
| insReyes | ![insReyes](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insReyes.jpg) | `CSSFilterPresets.insReyes(child: Image(...))` |
| insRise | ![insRise](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insRise.jpg) | `CSSFilterPresets.insRise(child: Image(...))` |
| insSierra | ![insSierra](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insSierra.jpg) | `CSSFilterPresets.insSierra(child: Image(...))` |
| insSkyline | ![insSkyline](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insSkyline.jpg) | `CSSFilterPresets.insSkyline(child: Image(...))` |
| insSlumber | ![insSlumber](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insSlumber.jpg) | `CSSFilterPresets.insSlumber(child: Image(...))` |
| insStinson | ![insStinson](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insStinson.jpg) | `CSSFilterPresets.insStinson(child: Image(...))` |
| insSutro | ![insSutro](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insSutro.jpg) | `CSSFilterPresets.insSutro(child: Image(...))` |
| insToaster | ![insToaster](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insToaster.jpg) | `CSSFilterPresets.insToaster(child: Image(...))` |
| insToasterV2 | ![insToasterV2](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insToasterV2.jpg) | `CSSFilterPresets.insToasterV2(child: Image(...))` |
| insValencia | ![insValencia](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insValencia.jpg) | `CSSFilterPresets.insValencia(child: Image(...))` |
| insVesper | ![insVesper](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insVesper.jpg) | `CSSFilterPresets.insVesper(child: Image(...))` |
| insWalden | ![insWalden](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insWalden.jpg) | `CSSFilterPresets.insWalden(child: Image(...))` |
| insWaldenV2 | ![insWaldenV2](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insWaldenV2.jpg) | `CSSFilterPresets.insWaldenV2(child: Image(...))` |
| insWillow | ![insWillow](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insWillow.jpg) | `CSSFilterPresets.insWillow(child: Image(...))` |
| insXpro2 | ![insXpro2](https://raw.githubusercontent.com/iofod/flutter_css_filter/main/assets/insXpro2.jpg) | `CSSFilterPresets.insXpro2(child: Image(...))` |

Similar to `CSSFilter`, we provide the `apply` method for `CSSFilterPresets` to invoke presets consistently, and apply additionally supports setting the intensity of the filter effect used. To do so:

```dart
/// You can replace the value parameter with any of the supported effects.
CSSFilterPresets.apply(
  child: YourWidget,
  value: CSSFilterPresets.insNashville, 
  strength: 0.7
);
```

## Customize your own filter preset

`CSSFilter` provides the most basic filters, `CSSFilterPresets` collects the commonly used combinations of basic filters as presets, meaning you can also customize your own filter presets based on the basic filters.

```dart

customPreset({ required Widget child }) {
  return CSSFilter.apply(
    child: child, 
    value: CSSFilterMatrix().sepia(0.2).saturate(1.4)
  );
}

/// Used by CSSFilterPresets to set the intensity of the effect.
CSSFilterPresets.apply(
  child: YourWidget,
  value: customPreset,
  strength: 0.9
);

/// It also supports direct use.
customPreset(child: YourWidget);
```

## More examples

For more usage examples, please check out the [example project](https://github.com/iofod/flutter_css_filter/tree/main/example).
