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

Widget pic(name) {
  int i = 0;

  return Container(
      padding:
          const EdgeInsets.only(top: 0.0, right: 0.0, bottom: 20.0, left: 0.0),
      child: Stack(
        children: [
          const Positioned(
              child: Image(
            image: NetworkImage(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
            width: 160.0,
          )),
          ...(name ?? '').split(',').map((str) {
            double top = i * 30.0;

            i++;

            return Positioned(
                top: top,
                child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(66, 61, 61, 61)),
                    padding: const EdgeInsets.all(6.0),
                    child: Text(str,
                        style: const TextStyle(
                            fontSize: 12.0, color: Color(0xFFFFFFFF)))));
          }).toList(),
        ],
      ));
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: CSSFilter.saturate(value: 1.2, child: Container(
              padding: const EdgeInsets.all(16.0),
              width: MediaQuery.of(context).size.width,
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                runAlignment: WrapAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  pic('Original image'),
                  CSSFilter.contrast(child: pic('contrast(1.3)'), value: 1.3),
                  CSSFilter.grayscale(child: pic('grayscale(0.5)'), value: 0.5),
                  CSSFilter.sepia(child: pic('sepia(0.5)'), value: 0.5),
                  CSSFilter.hueRotate(
                      child: pic('hueRotate(60.0)'), value: 60.0),
                  CSSFilter.brightness(
                      child: pic('brightness(1.3)'), value: 1.3),
                  CSSFilter.saturate(child: pic('saturate(2.0)'), value: 2.0),
                  CSSFilter.invert(child: pic('invert(0.9)'), value: 0.9),
                  CSSFilter.blur(child: pic('blur(1.5)'), value: 1.5),
                  CSSFilter.opacity(child: pic('opacity(0.5)'), value: 0.5),
                  CSSFilter.apply(
                      child: pic('contrast(1.5),sepia(0.2)'),
                      contrast: 1.3,
                      sepia: 0.2),
                  CSSFilter.apply(
                      child: pic('hueRotate(60.0),grayscale(0.5)'),
                      hueRotate: 60.0,
                      grayscale: 0.5),
                  CSSFilter.apply(
                      child:
                          pic('brightness(1.2),saturate(0.8),hueRotate(20.0)'),
                      brightness: 1.2,
                      saturate: 0.8,
                      hueRotate: 20.0),
                  CSSFilter.apply(
                      child: pic(
                          'contrast(1.2),sepia(0.8),hueRotate(90.0),invert(0.9),opacity(0.9)'),
                      contrast: 1.2,
                      sepia: 0.8,
                      hueRotate: 90.0,
                      invert: 0.9,
                      opacity: 0.9),
                ],
              )))),
    );
  }
}
