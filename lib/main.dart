import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Button Chase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Offset _noButtonPosition = const Offset(0, 0);
  bool _isNoButtonHovered = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenSize = MediaQuery.of(context).size;
      setState(() {
        _noButtonPosition = Offset(
          (screenSize.width - 100) / 2 + 70, // Center horizontally
          (screenSize.height - 50) / 2, // Center vertically
        );
      });
    });
  }

  void _updateNoButtonPosition() {
    final screenSize = MediaQuery.of(context).size;

    setState(
      () {
        _noButtonPosition = Offset(
          (_noButtonPosition.dx + 100) % (screenSize.width - 100),
          (_noButtonPosition.dy + 50) % (screenSize.height - 100),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: (screenSize.height - 50) / 2 - 60,
            child: const Center(
              child: Text(
                'Do you want to proceed to payment?',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            left: (screenSize.width - 100) / 2 - 70,
            top: (screenSize.height - 50) / 2,
            child: InkWell(
              onTap: () {},
              child: _buttonWidget('Yes', Colors.green),
            ),
          ),
          Positioned(
            left: _noButtonPosition.dx,
            top: _noButtonPosition.dy,
            child: MouseRegion(
              onHover: (event) {
                _updateNoButtonPosition();
                setState(() {
                  _isNoButtonHovered = true;
                });
              },
              onExit: (event) {
                setState(() {
                  _isNoButtonHovered = false;
                });
              },
              child: InkWell(
                onTap: _isNoButtonHovered ? null : () {},
                child: _buttonWidget('No', Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonWidget(String text, Color color) {
    return Container(
      height: 35,
      width: 70,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
