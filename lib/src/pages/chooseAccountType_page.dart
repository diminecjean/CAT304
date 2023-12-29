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
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), //
          ),
          const SizedBox(height: 30),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              OptionCard(label: 'Parent', imagePath: 'assets/images/parents.png'),
              OptionCard(label: 'Child', imagePath: 'assets/images/children.png'),
            ],
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset('assets/images/svg/family_together.svg'), // Replace with your asset image
            ),
          ),
        ],
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  final String label;
  final String imagePath;

  const OptionCard({Key? key, required this.label, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/signup");                                            // TODO: Here should separate difference account type signup, currently both are the same signup page
        },
        splashColor: Theme.of(context).splashColor, // Default splash color
        child: Container(
          width: 120, // Define a fixed width for the card
          height: 120, // Define a fixed height for the card
          padding: const EdgeInsets.all(8), // Add some padding inside the card
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(imagePath, width: 48, height: 48), // Display the image
              const SizedBox(height: 10), // Spacing between image and text
              Text(label), // Text label for the card
            ],
          ),
        ),
      ),
    );
  }
}

