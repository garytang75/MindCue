import 'package:flutter/material.dart';
import 'package:flutter_auth2/page/journal_page.dart';
import 'circular_button.dart';
import '../page/textinput_page.dart';
import 'package:flutter_auth2/main.dart';
import '../page/questionnaires_page.dart';
import 'image_button.dart';

class CircularAnimation extends StatefulWidget {
  @override
  _CircularAnimationState createState() => _CircularAnimationState();
}

class _CircularAnimationState extends State<CircularAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  Animation rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

//it holds all the animation value
//DegoneTranslationAnmiation - DegThreeTranslationAnimation
//rotationTranslation
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));

    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);

    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController);

    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(animationController);

    rotationAnimation = Tween<double>(begin: 180, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, .92),
      child: Container(
        //CircularButton Stack
        child: Stack(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                IgnorePointer(
                  child: Container(
                    color: Colors.transparent,
                    height: 150,
                    width: 200,
                  ),
                ),
                Transform.translate(
                  offset: Offset.fromDirection(getRadiansFromDegree(270),
                      degTwoTranslationAnimation.value * 100),
                  child: Transform(
                    transform: Matrix4.rotationZ(
                        getRadiansFromDegree(rotationAnimation.value))
                      ..scale(degTwoTranslationAnimation.value),
                    alignment: Alignment.center,
                    child: CircularButton(
                      color: Color(0xFF8FC2E1),
                      width: 60,
                      height: 60,
                      icon: Icon(Icons.mic_none_sharp, color: Colors.white),
                      onClick: () {
                        print('voice input');
                      },
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset.fromDirection(getRadiansFromDegree(200),
                      degThreeTranslationAnimation.value * 100),
                  child: Transform(
                    transform: Matrix4.rotationZ(
                        getRadiansFromDegree(rotationAnimation.value))
                      ..scale(degThreeTranslationAnimation.value),
                    alignment: Alignment.center,
                    child: CircularButton(
                      color: Color(0xFFF19679),
                      width: 60,
                      height: 60,
                      icon: Icon(
                        Icons.sentiment_neutral_outlined,
                        color: Colors.white,
                      ),
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Questionnaires()),
                        );
                      },
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset.fromDirection(getRadiansFromDegree(340),
                      degOneTranslationAnimation.value * 100),
                  child: Transform(
                    transform: Matrix4.rotationZ(
                        getRadiansFromDegree(rotationAnimation.value))
                      ..scale(degOneTranslationAnimation.value),
                    alignment: Alignment.center,
                    child: CircularButton(
                      color: Color(0xFFA7D466),
                      width: 60,
                      height: 60,
                      icon: Icon(
                        Icons.note_add_outlined,
                        color: Colors.white,
                      ),
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TextInput()),
                        );
                      },
                    ),
                  ),
                ),
                Transform(
                  transform: Matrix4.rotationZ(
                      getRadiansFromDegree(rotationAnimation.value)),
                  alignment: Alignment.center,
                  child: CircularButton(
                    color: Color(0xFFFDBC59),
                    width: 60,
                    height: 60,
                    icon: Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.black,
                    ),
                    onClick: () {
                      if (animationController.isCompleted) {
                        animationController.reverse();
                      } else {
                        animationController.forward();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
