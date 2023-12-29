import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChooseAccountTypePage extends StatelessWidget {
  const ChooseAccountTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Create an account'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'I am a ...',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              OptionCard(label: 'Parent', svgAsset: 'assets/images/parents.svg'),
              OptionCard(label: 'Child', svgAsset: 'assets/images/children.svg'),
            ],
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset('assets/images/family_together.svg'), // Replace with your asset image
            ),
          ),
        ],
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  final String label;
  final String svgAsset;

  const OptionCard({Key? key, required this.label, required this.svgAsset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tap
      },
      child: Card(
        child: Container(
          width: 120, // Define a fixed width for the card
          height: 120, // Define a fixed height for the card
          padding: const EdgeInsets.all(8), // Add some padding inside the card
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                svgAsset,
                height: 48, // Specify the height of the SVG
                width: 48, // Specify the width of the SVG
              ),
              const SizedBox(height: 10), // Spacing between icon and text
              Text(label), // Text label for the card
            ],
          ),
        ),
      ),
    );
  }
}
