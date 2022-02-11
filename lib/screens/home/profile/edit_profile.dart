
// ignore_for_file: must_be_immutable

import 'package:biz_link/database/user_api.dart';
import 'package:biz_link/widgets/custom_widgets/custom_elevated_button.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


import '../../../enums/role.dart';
import '../../../models/app_user.dart';
import '../../../utility/colors.dart';
import '../../../utility/custom_validators.dart';
import '../../../widgets/custom_widgets/custom_textformfield.dart';

import '../../../widgets/custom_widgets/show_loading.dart';


class EditProfile extends StatefulWidget {
  static const String routeName = '/edit-profile';
  EditProfile({required this.user, super.key});
  AppUser user;
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool _isAgree = false;

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _phoneNumber = TextEditingController();

  final TextEditingController _emailController = TextEditingController();


  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  void initState() {
    load();
    super.initState();
  }

  Role _selectedRole = Role.distributor;
  load() {
    _firstNameController.text = widget.user.displayName!;
    _lastNameController.text = widget.user.username!;
  _selectedRole=widget.user.role;
    _phoneNumber.text = widget.user.phoneNumber!;
    _emailController.text = widget.user.email!;
  }

  List<Role> _roleList = [
    Role.distributor,
    Role.factory,
    Role.wholesaler,
    Role.retailer,
  ];
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
                                  'Phone Number',
                                  style: TextStyle(
                                      color: MyColor.accent_color,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              CustomTextFormField(
                                controller: _phoneNumber,
                                hint: 'Phone Number',
                                validator: (value) =>
                                    CustomValidator.lessThen11(value),
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
                          
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    for (int i = 0; i < _roleList.length; i++)
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            _selectedRole = _roleList[i];
                                            setState(() {});
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(4),
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: _selectedRole ==
                                                          _roleList[i]
                                                      ? MyColor.accent_color
                                                      : Colors.grey.shade400,
                                                  width: 4),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                    _roleList[i].iconPath,
                                                    height: 40),
                                                FittedBox(
                                                  fit: BoxFit.fill,
                                                  child:
                                                      Text(_roleList[i].name),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: _isLoading
                                    ? const ShowLoading()
                                    : CustomElevatedButton(
                                        title: 'Update', onTap: () async{

                                          widget.user.displayName=_firstNameController.text;
                                          widget.user.username=_lastNameController.text;
                                          widget.user.phoneNumber=_phoneNumber.text;
                                          widget.user.email=_emailController.text;
                                          widget.user.role=_selectedRole;
                                       await  UserAPI().updateProfile(user: widget.user);
                                       Navigator.of(context).pop();
                                        }),
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
