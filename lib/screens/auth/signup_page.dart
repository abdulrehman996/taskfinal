import 'package:biz_link/screens/auth/login_page.dart';
import 'package:biz_link/utility/custom_validators.dart';
import 'package:biz_link/widgets/custom_widgets/custom_textformfield.dart';
import 'package:biz_link/widgets/custom_widgets/custom_toast.dart';
import 'package:biz_link/widgets/custom_widgets/password_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utility/colors.dart';
import '../../widgets/input_decorations.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isAgree = false;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

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
                        'Join BizLink',
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Text(
                                  'First Name',
                                  style: TextStyle(
                                      color: MyColor.accent_color,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              CustomTextFormField(
                                controller: _firstNameController,
                                hint: 'First Name',
                                validator: (value) =>
                                    CustomValidator.lessThen3(value),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Text(
                                  'Last Name',
                                  style: TextStyle(
                                      color: MyColor.accent_color,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              CustomTextFormField(
                                controller: _lastNameController,
                                hint: 'Last Name',
                                validator: (value) =>
                                    CustomValidator.lessThen3(value),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                      color: MyColor.accent_color,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              CustomTextFormField(
                                controller: _emailController,
                                hint: 'test@test.com',
                                keyboardType: TextInputType.emailAddress,
                                validator: (String? value) =>
                                    CustomValidator.email(value),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Text(
                                  'Password',
                                  style: TextStyle(
                                      color: MyColor.accent_color,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              PasswordTextFormField(
                                controller: _passwordController,
                                hint: ' . . . . . . .',
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Text(
                                  'Confirm Password',
                                  style: TextStyle(
                                      color: MyColor.accent_color,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              PasswordTextFormField(
                                controller: _passwordConfirmController,
                                hint: ' . . . . . . .',
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 15,
                                      width: 15,
                                      child: Checkbox(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        value: _isAgree,
                                        onChanged: (newValue) {
                                          _isAgree = newValue!;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: SizedBox(
                                        width: 100.w - 130,
                                        child: RichText(
                                            maxLines: 2,
                                            text: TextSpan(
                                                style: TextStyle(
                                                    color: MyColor.font_grey,
                                                    fontSize: 12),
                                                children: [
                                                  const TextSpan(
                                                    text: "I agree to the",
                                                  ),
                                                  TextSpan(
                                                    text: " terms & condition",
                                                    style: TextStyle(
                                                        color: MyColor
                                                            .accent_color),
                                                  ),
                                                  const TextSpan(
                                                    text: " &",
                                                  ),
                                                  TextSpan(
                                                    text: " & privacy policy ",
                                                    style: TextStyle(
                                                        color: MyColor
                                                            .accent_color),
                                                  ),
                                                ])),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: MyColor.text_field_grey,
                                          width: 1),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12.0))),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      primary: MyColor.accent_color,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.0))),
                                      fixedSize: Size.fromWidth(
                                          MediaQuery.of(context).size.width),
                                    ),
                                    child: const Text(
                                      'Sign up',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    onPressed: () {
                                      if (!_key.currentState!.validate())
                                        return;
                                      if (!_isAgree) {
                                        CustomToast.errorToast(
                                          message:
                                              'Accept Terms and condition to signup',
                                        );
                                        return;
                                      }
                                      // onPressedLogin();
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Text(
                                      'Already have an account',
                                      style: TextStyle(
                                          color: MyColor.font_grey,
                                          fontSize: 12),
                                    )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                            color: MyColor.accent_color,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const LoginPage();
                                        }));
                                      },
                                    ),
                                  ],
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
