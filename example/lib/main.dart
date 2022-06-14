import 'package:flutter/material.dart';
import 'package:css_filter/css_filter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'CSS Filter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

double width = 360.0;

Widget pic(name) {
  int i = 0;

  return Container(
      padding:
          const EdgeInsets.only(top: 10.0, right: 0.0, bottom: 10.0, left: 0.0),
      child: Stack(
        children: [
          Positioned(
              child: Image(
            image: const NetworkImage(
                'https://static.iofod.com/common/buildings/1621839293951_castle_1280x852.jpg'),
            width: width / 2.5,
          )),
          ...(name ?? '').split(',').map((str) {
            double top = i * 30.0;

            i++;

            return Positioned(
                top: top,
                child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(151, 61, 61, 61)),
                    padding: const EdgeInsets.all(6.0),
                    child: Text(str,
                        style: const TextStyle(
                            fontSize: 12.0,
                            color: Color.fromARGB(255, 251, 255, 9)))));
          }).toList(),
        ],
      ));
}

Widget customPreset({required Widget child}) {
  return CSSFilter.apply(
      child: child,
      value: CSSFilterMatrix().sepia(0.5).hueRotate(-30.0).saturate(1.4));
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: CSSFilter.blur(
              value: 0.0,
              child: Container(
                  padding: const EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width,
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    runAlignment: WrapAlignment.spaceEvenly,
                    children: [
                      pic('Original image'),

                      CSSFilter.contrast(
                          child: pic('contrast(1.3)'), value: 1.3),
                      CSSFilter.grayscale(
                          child: pic('grayscale(0.5)'), value: 0.5),
                      CSSFilter.sepia(child: pic('sepia(0.5)'), value: 0.5),
                      CSSFilter.hueRotate(
                          child: pic('hueRotate(60.0)'), value: 60.0),
                      CSSFilter.brightness(
                          child: pic('brightness(1.3)'), value: 1.3),
                      CSSFilter.saturate(
                          child: pic('saturate(2.0)'), value: 2.0),
                      CSSFilter.invert(child: pic('invert(0.9)'), value: 0.9),

                      ClipRect(
                        child:
                            CSSFilter.blur(child: pic('blur(1.5)'), value: 1.5),
                      ),

                      CSSFilter.opacity(child: pic('opacity(0.5)'), value: 0.5),

                      CSSFilter.apply(
                          child: pic('contrast(1.5),sepia(0.2)'),
                          value: CSSFilterMatrix().contrast(1.3).sepia(0.2)),
                      CSSFilter.apply(
                          child: pic('hueRotate(60.0),grayscale(0.5)'),
                          value:
                              CSSFilterMatrix().hueRotate(60.0).grayscale(0.5)),
                      // CSSFilter.apply(
                      //     child: pic('brightness(1.2),saturate(0.8),hueRotate(20.0)'),
                      //     value: CSSFilterMatrix().brightness(1.2).saturate(0.8).hueRotate(20.0)),
                      CSSFilter.apply(
                          child: pic(
                              'contrast(1.2),sepia(0.8),hueRotate(90.0),invert(0.9),opacity(0.9)'),
                          value: CSSFilterMatrix()
                              .contrast(1.2)
                              .sepia(0.8)
                              .hueRotate(90.0)
                              .invert(0.9)
                              .opacity(0.9)),

                      CSSFilterPresets.ins1977(child: pic('ins1977')),
                      CSSFilterPresets.ins1977V2(child: pic('ins1977V2')),
                      CSSFilterPresets.apply(
                          child: pic('ins1977V2 customPreset'),
                          value: customPreset,
                          strength: 0.9),
                      CSSFilterPresets.insAden(child: pic('insAden')),
                      CSSFilterPresets.insAmaro(child: pic('insAmaro')),
                      CSSFilterPresets.insAshby(child: pic('insAshby')),
                      CSSFilterPresets.insBrannan(child: pic('insBrannan')),
                      CSSFilterPresets.insBrooklyn(child: pic('insBrooklyn')),
                      CSSFilterPresets.insClarendon(child: pic('insClarendon')),
                      CSSFilterPresets.insDogpatch(child: pic('insDogpatch')),
                      CSSFilterPresets.insEarlybird(child: pic('insEarlybird')),
                      CSSFilterPresets.insGingham(child: pic('insGingham')),
                      CSSFilterPresets.insHelena(child: pic('insHelena')),
                      CSSFilterPresets.insHudson(child: pic('insHudson')),
                      CSSFilterPresets.insInkwell(child: pic('insInkwell')),
                      CSSFilterPresets.insInkwellV2(child: pic('insInkwell')),
                      CSSFilterPresets.insJuno(child: pic('insJuno')),
                      CSSFilterPresets.insKelvin(child: pic('insKelvin')),
                      CSSFilterPresets.insLark(child: pic('insLark')),
                      CSSFilterPresets.insLofi(child: pic('insLofi')),
                      CSSFilterPresets.insLudwig(child: pic('insLudwig')),
                      CSSFilterPresets.insMaven(child: pic('insMaven')),
                      CSSFilterPresets.insMayfair(child: pic('insMayfair')),
                      CSSFilterPresets.insMoon(child: pic('insMoon')),
                      CSSFilterPresets.insMoonV2(child: pic('insMoonV2')),
                      CSSFilterPresets.insNashville(child: pic('insNashville')),
                      CSSFilterPresets.insNashvilleV2(
                          child: pic('insNashvilleV2')),
                      CSSFilterPresets.insPerpetua(child: pic('insPerpetua')),
                      CSSFilterPresets.insPoprocket(child: pic('insPoprocket')),
                      CSSFilterPresets.insReyes(child: pic('insReyes')),
                      CSSFilterPresets.insRise(child: pic('insRise')),
                      CSSFilterPresets.insSierra(child: pic('insSierra')),
                      CSSFilterPresets.insSkyline(child: pic('insSkyline')),
                      CSSFilterPresets.insSlumber(child: pic('insSlumber')),
                      CSSFilterPresets.insStinson(child: pic('insStinson')),
                      CSSFilterPresets.insSutro(child: pic('insSutro')),
                      CSSFilterPresets.insToaster(child: pic('insToaster')),
                      CSSFilterPresets.insToasterV2(child: pic('insToasterV2')),
                      CSSFilterPresets.insValencia(child: pic('insValencia')),
                      CSSFilterPresets.insVesper(child: pic('insVesper')),
                      CSSFilterPresets.insWalden(child: pic('insWalden')),
                      CSSFilterPresets.insWaldenV2(child: pic('insWaldenV2')),
                      CSSFilterPresets.insWillow(child: pic('insWillow')),
                      CSSFilterPresets.insXpro2(child: pic('insXpro2')),

                      CSSFilterPresets.apply(
                          child: pic('apply insToaster strength'),
                          value: CSSFilterPresets.insToaster,
                          strength: 0.7),

                      CSSFilterPresets.apply(
                          child: Opacity(
                              opacity: 0.7,
                              child: pic('apply ins1977 alphaBlending')),
                          value: CSSFilterPresets.ins1977,
                          strength: 0.8,
                          alphaBlending: 0.7),

                      pic('Original image')
                    ],
                  )))),
    );
  }
}
