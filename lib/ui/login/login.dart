// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:login_register/ui/custom_paint/flower_paint.dart';
import 'package:login_register/ui/custom_paint/page.dart';
import 'package:login_register/ui/home/home.dart';
import 'package:login_register/utlities/app_colors.dart';
import 'package:login_register/utlities/gradient_raised_button.dart';
import 'package:login_register/utlities/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final passwordController = TextEditingController();

  double screenWidth = 0.0;
  double screenheight = 0.0;
  bool isSwitched = true;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  FocusNode emailNode = FocusNode();
  FocusNode passawordNode = FocusNode();
  bool loading = false;
  late String _email;
  late String _password;
  bool isObscurePassword = true;
  bool isContainsRequiredCharacter = false;
  bool isContainsAtLeastSpecialCharacter = false;
  bool isContainsUpperCaseCharacter = false;
  bool isContainsNumber = false;
  int requiredPasswordCharacter = 8;
  int isAllValidationPassedCounter = 0;

  late AnimationController requiredcontroller;
  late AnimationController spcialcontroller;
  late AnimationController uppercontroller;
  late AnimationController numbercontroller;
  late AnimationController okButtonScalecontroller;
  late Animation<double> requiredCharacterAnimation;
  late Animation<double> spcialCharacterAnimation;
  late Animation<double> upperCharacterAnimation;
  late Animation<double> numberrAnimation;
  late Animation<double> okButtonScaleAnimation;

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();

    _init();
    _initUI();
    _initAnimation();
  }

  void _init() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _initUI() {
    passawordNode = FocusNode();
    emailNode = FocusNode();
    loading = false;
    passwordController.addListener(_onChangePassword);
  }

  void _initAnimation() {
    requiredcontroller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    spcialcontroller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    uppercontroller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    numbercontroller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    okButtonScalecontroller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);

    requiredCharacterAnimation = Tween(begin: 0.0, end: 8.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(requiredcontroller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          requiredcontroller.reverse();
        }
      });

    spcialCharacterAnimation = Tween(begin: 0.0, end: 8.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(spcialcontroller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          spcialcontroller.reverse();
        }
      });

    upperCharacterAnimation = Tween(begin: 0.0, end: 8.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(uppercontroller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          uppercontroller.reverse();
        }
      });

    numberrAnimation = Tween(begin: 0.0, end: 8.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(numbercontroller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          numbercontroller.reverse();
        }
      });

    okButtonScaleAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: okButtonScalecontroller, curve: Curves.fastOutSlowIn));
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: AlignmentDirectional.topCenter,
                    end: AlignmentDirectional.bottomCenter,
                    colors: [kLighOrange2, kPurple])),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 50),
                    _existingLoginSwitch(),
                    SizedBox(height: 10),
                    _forgotPassword(),
                    SizedBox(height: 10),
                    _orDivider(),
                    SizedBox(height: 20),
                    _socialLogin(),
                  ],
                ),
              ),
            ),
          ),
          loading ? LoadingIndicator() : Container()
        ],
      ),
    );
  }

//  Widget methods
  Widget hiveImage() {
    return Image.asset(
      'assets/images/hive.png',
      width: 230,
      height: 230,
    );
  }

  Widget _existingLoginSwitch() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          Container(
            width: screenWidth * 0.7,
            height: 40,
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.15),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.white,
              indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              tabs: [
                Tab(
                  child: Container(
                    width: 129,
                    child: Center(
                      child: Text(
                        Strings.existing,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    width: 129,
                    child: Center(
                      child: Text(
                        Strings.newlogin,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: screenWidth * .8,
            height: screenheight * .65,
            margin: EdgeInsets.only(top: 10),
            child: TabBarView(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        hiveImage(),
                        Container(
                          height: 190,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.white,
                          ),
                          child: Form(
                            key: _loginFormKey,
                            autovalidateMode: autovalidateMode,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                emailFormField(),
                                SizedBox(
                                  height: 10,
                                ),
                                passwordFormField(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        bottom: 0,
                        left: screenWidth * 0.1,
                        child: LoginButton(context)),
                  ],
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        _passwordGuideWidget(),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 190,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.white,
                          ),
                          child: Form(
                            key: _registerFormKey,
                            autovalidateMode: autovalidateMode,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                emailFormField(),
                                SizedBox(
                                  height: 10,
                                ),
                                passwordFormField(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        bottom: 0,
                        left: screenWidth * 0.1,
                        child: RegisterButton(context)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _forgotPassword() {
    return Container(
      child: InkWell(
        onTap: () {
          debugPrint('clicked');
        },
        child: Text(
          Strings.forgotPassword,
          style: TextStyle(decoration: TextDecoration.underline, fontSize: 15),
        ),
      ),
    );
  }

  Container _orDivider() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 100,
            height: 2,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(.1),
                Colors.white.withOpacity(0.5)
              ],
            )),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            child: Text(
              Strings.or,
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 100,
            height: 2,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.5),
                Colors.white.withOpacity(0.1)
              ],
            )),
          ),
        ],
      ),
    );
  }

  Container _socialLogin() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {},
            mini: true,
            heroTag: 'fab_facebook',
            backgroundColor: Colors.white,
            child: Image.asset(
              'assets/images/facebook.png',
              width: 20,
              height: 20,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: () {},
            mini: true,
            heroTag: 'fab_google',
            backgroundColor: Colors.white,
            child: Image.asset(
              'assets/images/Google.png',
              width: 20,
              height: 20,
            ),
          ),
        ],
      ),
    );
  }

  TextStyle CustomTextStyle() {
    return TextStyle(color: Colors.black, fontSize: 15.0);
  }

  InputDecoration CustomTextDecoration(
      {required String text,
      required IconData icon,
      bool trailingicon = false}) {
    return InputDecoration(
        hintText: text,
        hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        prefixIcon: Icon(icon, color: Colors.blueGrey[700]),
        suffixIcon: trailingicon
            ? IconButton(
                onPressed: () {
                  isObscurePassword = !isObscurePassword;
                  setState(() {});
                },
                icon: Icon(Icons.remove_red_eye),
                color: Colors.grey,
              )
            : null);
  }

  TextFormField passwordFormField() {
    return TextFormField(
      controller: passwordController,
      enabled: true,
      enableInteractiveSelection: true,
      obscureText: isObscurePassword,
      textInputAction: TextInputAction.done,
      style: CustomTextStyle(),
      focusNode: passawordNode,
      decoration: CustomTextDecoration(
          icon: Icons.lock, text: Strings.password, trailingicon: true),
//      validator: (text) {
//        return _validatePassword(value: text);
//      },
      onSaved: (val) => _password = val!,
    );
  }

  TextFormField emailFormField() {
    return TextFormField(
      enabled: true,
      enableInteractiveSelection: true,
      focusNode: emailNode,
      style: CustomTextStyle(),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration:
          CustomTextDecoration(icon: Icons.email, text: Strings.emailAddress),
      textCapitalization: TextCapitalization.none,
      onFieldSubmitted: (term) {
        emailNode.unfocus();
        FocusScope.of(context).requestFocus(passawordNode);
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter email';
        } else if (!new RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value!)) {
          return "Plase enter valid email";
        }
      },
      onSaved: (val) => _email = val!,
    );
  }

  Widget LoginButton(BuildContext context) {
    return RaisedGradientButton(
        child: Text(
          Strings.login.toUpperCase(),
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        height: 80,
        width: screenWidth * 0.6,
        gradient: LinearGradient(
          colors: <Color>[kPruple, kLighOrange2],
        ),
        onPressed: () async {
          FocusScope.of(context).requestFocus(new FocusNode());
          final form = _loginFormKey.currentState;

          if (form!.validate()) {
            form.save();
            print('email is $_email and password is $_password');

            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                loading = false;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              });
            });
          } else {
            setState(() {
              autovalidateMode = AutovalidateMode.always;
            });
          }
        });
  }

  Widget RegisterButton(BuildContext context) {
    return RaisedGradientButton(
        child: Text(
          Strings.register.toUpperCase(),
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        height: 80,
        width: screenWidth * 0.6,
        gradient: LinearGradient(
          colors: <Color>[kPruple, kLighOrange2],
        ),
        onPressed: () async {
          FocusScope.of(context).requestFocus(new FocusNode());
          final form = _registerFormKey.currentState;

          if (form!.validate()) {
            form.save();
            print('email is $_email and password is $_password');

            setState(() {
              loading = true;
            });
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                loading = false;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              });
            });
          } else {
            setState(() {
              autovalidateMode = AutovalidateMode.always;
            });
          }
        });
  }

  Widget LoadingIndicator() {
    return Positioned(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: SizedBox(
            height: 50.0,
            width: 50.0,
            child: CircularProgressIndicator(strokeWidth: 0.7),
          ),
        ),
      ),
    );
  }

  Widget _passwordGuideWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      width: screenWidth * .7,
      height: 230,
      child: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 160,
              width: screenWidth * .99,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
            Positioned(
              left: 5,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 160,
                width: screenWidth * .63,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                checkList(
                    animation: requiredCharacterAnimation,
                    text: Strings.characterLimit,
                    cutWidth: 0.25,
                    isCheck: isContainsRequiredCharacter),
                Container(
                  width: screenWidth * .63,
                  child: Divider(
                    color: Colors.blue,
                  ),
                ),
                checkList(
                    animation: spcialCharacterAnimation,
                    text: Strings.specialCharacterLimit,
                    cutWidth: 0.38,
                    isCheck: isContainsAtLeastSpecialCharacter),
                Container(
                  width: screenWidth * .63,
                  child: Divider(
                    color: Colors.blue,
                  ),
                ),
                checkList(
                    animation: upperCharacterAnimation,
                    text: Strings.upperCharacterLimit,
                    cutWidth: 0.26,
                    isCheck: isContainsUpperCaseCharacter),
                Container(
                  width: screenWidth * .63,
                  child: Divider(
                    color: Colors.blue,
                  ),
                ),
                checkList(
                    animation: numberrAnimation,
                    text: Strings.numberLimit,
                    cutWidth: 0.2,
                    isCheck: isContainsNumber),
                Container(
                  width: screenWidth * .63,
                  child: Divider(
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            Positioned(
              left: 50,
              top: 0,
              child: Container(
                width: 2,
                height: 500,
                color: Colors.pinkAccent,
              ),
            ),
            Positioned(
              right: 30,
              bottom: 10,
              child: ScaleTransition(
                scale: okButtonScaleAnimation,
                child: FloatingActionButton(
                  mini: true,
                  onPressed: () {},
                  backgroundColor: Colors.greenAccent,
                  child: Icon(
                    Icons.done,
                    color: Colors.pinkAccent,
                    size: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container checkList({
    required Animation animation,
    required String text,
    required double cutWidth,
    required bool isCheck,
  }) {
    return Container(
      height: 19,
      width: screenWidth * .63,
      margin: EdgeInsets.only(left: 20),
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: <Widget>[
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Container(
                padding: EdgeInsets.only(
                  left: animation.value + 40,
                ),
                child: AnimatedDefaultTextStyle(
                  child: Text(
                    text,
                  ),
                  style: TextStyle(
                      fontSize: 17,
                      color: isCheck ? Colors.grey : kPruple,
                      fontWeight:
                          isCheck ? FontWeight.normal : FontWeight.bold),
                  duration: Duration(milliseconds: 300),
                ),
              );
            },
          ),
          AnimatedContainer(
            margin: EdgeInsets.only(top: 5, left: 35),
            duration: Duration(milliseconds: 400),
            height: 4,
            width: isCheck ? screenWidth * cutWidth : 0,
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onChangePassword() {
    _validatePassword(value: passwordController.text, isRepaint: true);
  }

  String _validatePassword({required String value, bool isRepaint = false}) {
    if (value.isEmpty) {
      return 'Please enter password';
    }

    //Check for required character
    if (value.length < requiredPasswordCharacter) {
      if (isRepaint) {
        setState(() {
          if (isContainsRequiredCharacter == true) {
            requiredcontroller.forward(from: 0.0);
          }
          isContainsRequiredCharacter = false;
        });
      }
      return 'Password must be $requiredPasswordCharacter digit';
    } else {
      if (isRepaint) {
        setState(() {
          if (isContainsRequiredCharacter == false) {
            requiredcontroller.forward(from: 0.0);
          }
          isContainsRequiredCharacter = true;
        });
      }
    }

    //Special character
    if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      if (isRepaint) {
        setState(() {
          if (isContainsAtLeastSpecialCharacter == false) {
            spcialcontroller.forward(from: 0.0);
          }
          isContainsAtLeastSpecialCharacter = true;
        });
      }
    } else {
      if (isRepaint) {
        setState(() {
          if (isContainsAtLeastSpecialCharacter == true) {
            spcialcontroller.forward(from: 0.0);
          }
          isContainsAtLeastSpecialCharacter = false;
        });
      }
      return 'Password must contain at least 1 special character';
    }

    //1 Upper case
    if (value.contains(RegExp(r'[A-Z]'))) {
      if (isRepaint) {
        setState(() {
          if (isContainsUpperCaseCharacter == false) {
            uppercontroller.forward(from: 0.0);
          }
          isContainsUpperCaseCharacter = true;
        });
      }
    } else {
      if (isRepaint) {
        setState(() {
          if (isContainsUpperCaseCharacter == true) {
            uppercontroller.forward(from: 0.0);
          }
          isContainsUpperCaseCharacter = false;
        });
      }
      return 'Password must contain at least 1 Upper Case character';
    }

    //1 Number
    if (value.contains(RegExp(r'[0-9]'))) {
      if (isRepaint) {
        setState(() {
          if (isContainsNumber == false) {
            numbercontroller.forward(from: 0.0);
            okButtonScalecontroller.forward();
          }
          isContainsNumber = true;
        });
      }
    } else {
      if (isRepaint) {
        setState(() {
          if (isContainsNumber == true) {
            numbercontroller.forward(from: 0.0);
            okButtonScalecontroller.reverse();
          }
          isContainsNumber = false;
        });
      }
      return 'Password must contain at least 1 Number';
    }
    return "";
  }

  void openScreen(
      {required BuildContext context,
      required Widget screen,
      required bool isPushReplace}) {
    if (!isPushReplace) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
    }
  }
}
