import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/base_provider.dart';
import '../providers/firebase_provider.dart';
import '../res.dart';
import '../widget/button.dart';
import '../widget/loader.dart';
import '../widget/textbox.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email = "";
  String _emailError = "";
  String _password = "";
  String _passwordError = "";
  String _dbError = "";
  var keyboardVisibilityController = KeyboardVisibilityController();
  bool _keyBoardVisible = false;

  _logIn(FirebaseProvider provider) async {
    bool _validation = true;

    if (_email.isEmpty) {
      setState(() {
        _emailError = "Enter Email Address";
      });
      _validation = false;
    }
    if (_password.isEmpty) {
      setState(() {
        _passwordError = "Enter Password";
      });
      _validation = false;
    } else if (_password.length < 6) {
      setState(() {
        _passwordError = "Password should be at least 6 characters";
      });
      _validation = false;
    }
    if (_validation) {
      Provider.of<BaseProvider>(context,listen: false).setLoadingState(true);
      String? res = await provider.signIn(email: _email, password: _password);
      Provider.of<BaseProvider>(context,listen: false).setLoadingState(false);
      if (res != null) {
        setState(() {
          _dbError = res;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<BaseProvider>(context,listen: false).setLoadingState(false);
    });
    keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        _keyBoardVisible = visible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Consumer<FirebaseProvider>(builder: (context, value, child) {
      return Scaffold(
        backgroundColor: AppColors.backGroundColor,
        body: Stack(
          children: [
            SizedBox(
              height: _size.height,
              width: _size.width,
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: _size.height,
                    width: _size.width,
                    child: Image.asset(
                      "assets/image/background.png",
                      fit: BoxFit.cover,
                      color: Colors.white.withOpacity(0.4),
                      colorBlendMode: BlendMode.modulate,
                    ),
                  )
                ]),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 100.0, left: 10, right: 10),
              child: Container(
                // padding: EdgeInsets.only(top: 40),
                // decoration: const BoxDecoration(
                //   borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(10),
                //     topRight: Radius.circular(10),
                //   ),
                //   color: Colors.white,
                //   boxShadow: [
                //     BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.15)),
                //     BoxShadow(
                //       color: Color.fromRGBO(0, 0, 0, 0.15),
                //       blurRadius: 11.0,
                //       spreadRadius: 0.0,
                //       offset: Offset(
                //         0.0,
                //         3.0,
                //       ),
                //     )
                //   ],
                // ),
                height: _size.height,
                width: _size.width,
                child: SingleChildScrollView(
                  child: AnimationLimiter(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 375),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                            child: widget,
                          ),
                        ),
                        children: [
                          const SizedBox(
                            height: 40,
                          ),

                          // SizedBox(
                          //   height: 100,
                          //   child: Image.asset(
                          //     "assets/image/logo.jpeg"
                          //   ),
                          // ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomTextBox(
                              leftIcon: const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(Icons.email_outlined,
                                    color: AppColors.thirdColor),
                              ),
                              onChange: (val) {
                                _email = val;
                                if (_emailError.isNotEmpty) {
                                  setState(() {
                                    _emailError = '';
                                  });
                                }
                              },
                              errorText: _emailError,
                              // title: "E-mail",
                              textBoxHint: "Enter Your Email",
                              width: _size.width - 20),
                          CustomTextBox(
                            leftIcon: const Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(Icons.lock_outline,
                                  color: AppColors.thirdColor),
                            ),
                            onChange: (val) {
                              _password = val;
                              if (_passwordError.isNotEmpty) {
                                setState(() {
                                  _passwordError = '';
                                });
                              }
                            },
                            obscureText: true,
                            errorText: _passwordError,
                            // title: "Password",
                            width: _size.width - 20,
                            textBoxHint: "Enter Your Password",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    height: 60,
                    // color: Colors.amber,
                    child: Row(
                        // width: 200,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Image.asset("assets/image/logo.png"),
                          ),
                          Expanded(
                            child: Stack(children: [
                              Text(
                                "Senanayake",
                                style: GoogleFonts.poppins(
                                    color: AppColors.secondColor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Text(
                                  "Medicals",
                                  style: GoogleFonts.poppins(
                                      color: AppColors.secondColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ]),
                          ),
                        ]),
                  ),
                ),
              ),
            ),

            !_keyBoardVisible
                ? SafeArea(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_dbError.isNotEmpty)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                _dbError,
                                style: GoogleFonts.nunito(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20, top: 10),
                            child: CustomButton(
                                title: "Login",
                                onPress: () {
                                  _logIn(value);
                                }),
                          )
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
            // const Header(title: "Login"),
            Loader(),
          ],
        ),
      );
    });
  }
}
