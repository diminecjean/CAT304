import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/text_bubble.dart';
import '../components/onboarding_text.dart';
// import 'package:flutter/services.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      finishButtonText: 'Login',
      onFinish: () {
        Navigator.pushNamed(context, "/login");
      },
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: Color.fromARGB(255, 143, 49, 44),
      ),
      skipTextButton: Text(
        'Skip',
        style: TextStyle(
          fontSize: 16,
          color: Color.fromARGB(255, 143, 49, 44),
          fontWeight: FontWeight.w600,
        ),
      ),
      pageBackgroundColor: Color.fromARGB(255, 245, 241, 233),
      headerBackgroundColor: Color.fromARGB(255, 245, 241, 233),
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
              SizedBox(
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
              SizedBox(
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
              SizedBox(
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
              SizedBox(
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
              SizedBox(
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
