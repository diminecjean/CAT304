import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

import '../components/onboarding_text.dart';
import '../config/style/constants.dart';
// import 'package:flutter/services.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      controllerColor: primaryColor,
      finishButtonText: 'Login',
      onFinish: () {
        Navigator.pushNamed(context, "/Login");
      },
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      trailing: Text(
        'Sign Up',
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailingFunction: () {
        Navigator.pushNamed(context, "/ChooseAccountType");
      },
      skipTextButton: Text(
        'Skip',
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      pageBackgroundColor: const Color.fromARGB(255, 245, 241, 233),
      headerBackgroundColor: const Color.fromARGB(255, 245, 241, 233),
      background: [
        Image.asset(
          'assets/images/onboarding-1.png',
          height: 350,
        ),
        Image.asset(
          'assets/images/onboarding-2.png',
          height: 350,
        ),
        Image.asset(
          'assets/images/onboarding-3.png',
          height: 350,
        ),
        Image.asset(
          'assets/images/onboarding-4.png',
          height: 350,
        ),
        Image.asset(
          'assets/images/onboarding-5.png',
          height: 350,
        ),
      ],
      centerBackground: true,
      totalPage: 5,
      speed: 1.8,
      pageBodies: [
        // Page 1
        Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: <Widget>[
              const SizedBox(
                height: 360,
              ),
              OnboardingText(
                  inputTextTitle: 'Welcome to Express All',
                  inputTextContent:
                      'Start your journey with Express All, a tailored learning platform designed for autistic children. ')
            ])),
        // Page 2
        Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: <Widget>[
              const SizedBox(
                height: 360,
              ),
              OnboardingText(
                  inputTextTitle: 'Understanding Emotions',
                  inputTextContent:
                      'Dive into the basics of emotional intelligence through interactive lessons.')
            ])),
        // Page 3
        Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: <Widget>[
              const SizedBox(
                height: 360,
              ),
              OnboardingText(
                  inputTextTitle: 'Task Management Mastery',
                  inputTextContent:
                      'Develop essential task management skills crucial for academic and career success.')
            ])),
        // Page 4
        Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: <Widget>[
              const SizedBox(
                height: 360,
              ),
              OnboardingText(
                  inputTextTitle: 'Progress Tracking',
                  inputTextContent:
                      "Gain valuable insights into your child's growth with Express All’s progress tracking features and celebrate achievements together.")
            ])),
        // Page 5
        Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: <Widget>[
              const SizedBox(
                height: 360,
              ),
              OnboardingText(
                  inputTextTitle: ' Your Journey Begins!',
                  inputTextContent:
                      'Embrace the possibilities ahead as you embark on a transformative journey with Express All.')
            ])),
      ],
    );
  }
}
