import 'package:biz_link/database/auth_methods.dart';
import 'package:biz_link/screens/auth/signup_page.dart';
import 'package:biz_link/screens/home/main_screen.dart';
import 'package:biz_link/widgets/custom_widgets/password_textformfield.dart';
import 'package:biz_link/widgets/custom_widgets/show_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utility/colors.dart';
import '../../utility/custom_validators.dart';
import '../../widgets/custom_widgets/custom_textformfield.dart';
import '../../widgets/input_decorations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String routeName = '/login-screen';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 35.h,
            width: 100.w,
            color: MyColor.accent_color,
          ),
          CustomScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.only(top: 48.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child:
                                Image.asset('assets/images/biz_link_logo.jpeg'),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20.0, top: 10),
                      child: Text(
                        'Log in to BizLink',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 18.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.08),
                              blurRadius: 20,
                              spreadRadius: 0.0,
                              offset: const Offset(0.0, 10.0),
                            )
                          ],
                        ),
                        child: Form(
                          key: _key,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                      color: MyColor.accent_color,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CustomTextFormField(
                                      controller: _emailController,
                                      hint: 'test@test.com',
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (String? value) =>
                                          CustomValidator.email(value),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Text(
                                  "Password",
                                  style: TextStyle(
                                      color: MyColor.accent_color,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    PasswordTextFormField(
                                      controller: _passwordController,
                                      validator: (value) =>
                                          CustomValidator.password(value),
                                    ),
                                  ],
                                ),
                              ),
                              _isLoading
                                  ? const ShowLoading()
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 30.0),
                                      child: Container(
                                        height: 45,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: MyColor.text_field_grey,
                                                width: 1),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12.0))),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            primary: MyColor.accent_color,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6.0))),
                                            fixedSize: Size.fromWidth(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width),
                                          ),
                                          child: const Text(
                                            'Login',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          onPressed: () async {
                                            if (!_key.currentState!
                                                .validate()) {
                                              return;
                                            }
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            final User? user =
                                                await AuthMethods()
                                                    .loginWithEmailAndPassword(
                                              _emailController.text,
                                              _passwordController.text,
                                            );
                                            if (user == null) {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              return;
                                            }
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return const MaineScreen();
                                            }));
                                          },
                                        ),
                                      ),
                                    ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 15),
                                child: Center(
                                    child: Text(
                                  'or, create a new account',
                                  style: TextStyle(
                                      color: MyColor.font_grey, fontSize: 12),
                                )),
                              ),
                              SizedBox(
                                height: 45,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    fixedSize: Size.fromWidth(
                                        MediaQuery.of(context).size.width),
                                    primary: MyColor.amber,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6.0))),
                                  ),
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                        color: MyColor.accent_color,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const SignupPage();
                                    }));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
