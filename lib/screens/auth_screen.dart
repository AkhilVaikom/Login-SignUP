
import 'dart:math';

import 'package:asha/screens/home.dart';
import 'package:asha/utilities/constants.dart';
import 'package:asha/utilities/login_form.dart';
import 'package:asha/utilities/sign_up_form.dart';
import 'package:asha/utilities/socal_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  bool _isShowSignup = false;
  late AnimationController _animationController;
  late Animation<double>  _animationTextRotate;

  void setUpAnimation(){
    _animationController=AnimationController(vsync: this,duration: defaultDuration);
    _animationTextRotate =Tween<double>(begin: 0,end: 90).animate(_animationController);
  }

  void updateView(){
    setState(() {
      _isShowSignup = !_isShowSignup;
    });
    _isShowSignup ? _animationController.forward() : _animationController.reverse();
  }
  void callHome(){
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
    });
  }
  // void signUpButton(){
  //   setState(() {
  //     Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginForm()));
  //   });
  // }

  @override
  void initState(){
    setUpAnimation();
    super.initState();
  }

  //void loginButton()

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          return Stack(
            children: [
              //Login
              AnimatedPositioned(
                duration: defaultDuration,
                width: _size.width * 0.88,
                height: _size.height,
                left: _isShowSignup ? -_size.width * 0.76 : 0,
                child: Container(
                  color: loginBg,
                  child: const LoginForm(),
                ),
              ),

              //SignUp
              Positioned(
                height: _size.height,
                width: _size.width,
                left: _isShowSignup ? _size.width * 0.12 : _size.width * 0.88,
                child: Container(
                  color: signupBg,
                  child: const SignUpForm(),
                ),
              ),
              //Logo
              AnimatedPositioned(
                duration: defaultDuration,
                top: _size.height * 0.1,
                left: 0,
                right: _isShowSignup ? -_size.width * .06 : _size.width * 0.06,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: _isShowSignup ? loginBg : signupBg,
                  child: _isShowSignup
                      ? SvgPicture.asset(
                          "assets/Asha-Workers-Logo.svg",
                          // alignment: Alignment.center,
                           fit: BoxFit.contain,
                          color: signupBg,
                        )
                      : SvgPicture.asset(
                          "assets/Asha-Workers-Logo.svg",
                          color: loginBg,
                        ),
                  //backgroundColor: Colors.white60,
                ),
              ),
              //Social Button
              AnimatedPositioned(
                duration: defaultDuration,
                width: _size.width,
                bottom: _size.height * 0.1,
                right: _isShowSignup ? -_size.width * .06 : _size.width * 0.06,
                child: const SocalButtns(),
              ),

              //Login Text
              AnimatedPositioned(
                duration: defaultDuration,
                bottom: _isShowSignup ? _size.height / 2 - 80 : _size.height * .3,
                left: _isShowSignup ? 0 : _size.width*0.28 - 0.80,
                child: AnimatedDefaultTextStyle(
                  duration: defaultDuration,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: _isShowSignup ? 20 : 32.0, fontWeight: FontWeight.bold,color: _isShowSignup ? Colors.white70 : Colors.white),
                  child: Transform.rotate(
                    angle: -_animationTextRotate.value * pi / 180,
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: _isShowSignup ? updateView : callHome,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: defpaultPadding * 0.75),
                        width: 160,
                        child: Text(
                          "Login".toUpperCase(),

                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //Signup Text
              AnimatedPositioned(
                duration: defaultDuration,
                bottom: !_isShowSignup ? _size.height / 2 - 80 : _size.height * .3,
                right: _isShowSignup ? _size.width*0.28 - 0.80 : 0,
                child: AnimatedDefaultTextStyle(
                  duration: defaultDuration,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: !_isShowSignup ? 20 : 32.0, fontWeight: FontWeight.bold,color: _isShowSignup ? Colors.white : Colors.white70),
                  child: Transform.rotate(
                    angle: (90 - _animationTextRotate.value) * pi / 180,
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: _isShowSignup ? callHome : updateView,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: defpaultPadding * 0.75),
                        width: 160,
                        child: Text(
                          "Sign up".toUpperCase(),

                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
