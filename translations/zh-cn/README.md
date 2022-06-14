# CSS Filter for Flutter

在 Flutter 上使用 CSS 滤镜效果。

[![Version](https://img.shields.io/github/v/release/iofod/flutter_css_filter?label=version)](https://pub.dev/packages/css_filter)
[![Build Status](https://github.com/iofod/flutter_css_filter/workflows/build/badge.svg)](https://github.com/iofod/flutter_css_filter/actions)

[IFstruct parser](https://github.com/iofod/IFstruct-parser) 支持从 [iofod](https://www.iofod.com/) 可视化编辑的项目生成 Flutter 代码。我们将其滤镜模块代码分离，并添加了许多预设效果，形成了现在的工具库，方便了所有 Flutter 项目使用 Web 的优秀设计：[CSS 滤镜](https://developer.mozilla.org/zh-CN/docs/Web/CSS/filter)。

## 特色

- 简洁高效的 API
- 支持多滤镜叠加
- 丰富的预设
- 全平台支持
- 自定义效果
- Null-safety

## 起步

导入依赖后，可以通过`CSSFilter`使用基本滤镜。

```dart
import 'package:css_filter/css_filter.dart';

CSSFilter.contrast(child: const Text('foo'), value: 1.2);
```

支持的基础滤镜如下：

- contrast()
- grayscale()
- sepia()
- hueRotate()
- brightness()
- saturate()
- invert()
- blur()
- opacity()

你可以像使用 CSS 滤镜一样在 Flutter 中组合叠加使用这些滤镜。将 `CSSFilter.apply` 与 `CSSFilterMatrix()` 结合使用。如：

```dart
CSSFilter.apply(
  child: const Text('bar'),
  value: CSSFilterMatrix().contrast(1.2).sepia(0.8).hueRotate(90.0).invert(0.9).opacity(0.9)
);
```

**注意：** 链式调用的顺序代表了滤镜的应用顺序，应用顺序会影响最终的结果。

## 使用预设

[CSSgram](https://github.com/una/CSSgram) 项目十分牛逼，给 CSS 世界带来了类 Instagram 滤镜，[instagram.css](https://github.com/picturepan2/instagram.css) 对其补充了更多滤镜效果。我们将这两个库结合起来封装了一系列预设，可以通过 `CSSFilterPresets` 调用。

支持的预设效果和预览：

| 预设 | 预览 | 示例代码 |
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

与 `CSSFilter` 类似，我们为 `CSSFilterPresets` 提供了 `apply` 方法来统一调用预设，apply 还支持设置滤镜的强度。比如：

```dart
/// 可以将 value 参数替换为任何支持的效果。
CSSFilterPresets.apply(
  child: YourWidget,
  value: CSSFilterPresets.insNashville, 
  strength: 0.7
);
```

## 自定义滤镜预设

`CSSFilter`提供了最基本的滤镜，`CSSFilterPresets`收集了常用的滤镜组合作为预设，也就是说你也可以根据基本滤镜来自定义滤镜预设。

```dart

customPreset({ required Widget child }) {
  return CSSFilter.apply(
    child: child, 
    value: CSSFilterMatrix().sepia(0.2).saturate(1.4)
  );
}

/// 利用 CSSFilterPresets 设置效果的强度。
CSSFilterPresets.apply(
  child: YourWidget,
  value: customPreset,
  strength: 0.9
);

/// 也支持直接调用。
customPreset(child: YourWidget);
```

## 更多示例

更多使用示例，请查看 [example](https://github.com/iofod/flutter_css_filter/tree/main/example)
