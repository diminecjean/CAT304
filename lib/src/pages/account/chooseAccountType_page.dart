import 'package:express_all/src/config/style/constants.dart';
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
          const SizedBox(height: 70),
          const Text(
            'I am a ...',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor), //
          ),
          const SizedBox(height: 40),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              OptionCard(
                label: 'Parent',
                imagePath: 'assets/images/parents.png',
                routeName: '/ParentSignUp',
              ),
              OptionCard(
                  label: 'Child',
                  imagePath: 'assets/images/children.png',
                  routeName: '/ChildSignUp'),
            ],
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                  'assets/images/svg/family_together.svg'), // Replace with your asset image
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
  final String routeName;

  const OptionCard(
      {Key? key,
      required this.label,
      required this.imagePath,
      required this.routeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context,
              routeName); // TODO: Here should separate difference account type signup, currently both are the same signup page
        },
        splashColor: Theme.of(context).splashColor, // Default splash color
        child: Container(
          width: 150, // Define a fixed width for the card
          height: 180, // Define a fixed height for the card
          padding: const EdgeInsets.all(8), // Add some padding inside the card
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(imagePath,
                  width: 70, height: 70), // Display the image
              const SizedBox(height: 10), // Spacing between image and text
              Text(
                label,
                style: const TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ), // Text label for the card
            ],
          ),
        ),
      ),
    );
  }
}
