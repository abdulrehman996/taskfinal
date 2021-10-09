import 'package:flutter/material.dart';
import '../../database/auth_methods.dart';
import '../../database/user_api.dart';
import '../../models/app_user.dart';

class UserProvider extends ChangeNotifier {
  UserProvider() {
    init();
  }
  List<AppUser> _user = <AppUser>[];
  List<String> _deviceToken = <String>[];
  List<String> get deviceToken => _deviceToken;
  void init() async {
    if (_user.isNotEmpty) return;
    _user.addAll(await UserAPI().getAllUsers());
    notifyListeners();
  }

  Future<void> refresh() async {
    _user = await UserAPI().getAllUsers();
    notifyListeners();
  }

  updateProfile(AppUser value) async {
    if (value.uid != AuthMethods.uid) return;
    int index = _indexOf(value.uid);
    if (index < 0) return;
    _user[index] = value;
    notifyListeners();
    await UserAPI().updateProfile(user: _user[index]);
  }

  List<AppUser> supporters({required String uid}) {
    List<AppUser> supporters = <AppUser>[];
    int index = _indexOf(uid);
    final AppUser tempUser = _user[index];
    if (index >= 0) {
      for (String element in tempUser.supporters!) {
        supporters.add(_user[_indexOf(element)]);
      }
    }
    return supporters;
  }

  List<AppUser> usersFromListOfString({required List<String> uidsList}) {
    List<AppUser> tempList = <AppUser>[];
    for (String element in uidsList) {
      tempList.add(_user[_indexOf(element)]);
    }
    return tempList;
  }

  List<AppUser> supportings({required String uid}) {
    List<AppUser> supporting = <AppUser>[];
    int index = _indexOf(uid);
    final AppUser tempUser = _user[index];
    if (index >= 0) {
      for (String element in tempUser.supporting!) {
        supporting.add(_user[_indexOf(element)]);
      }
    }
    return supporting;
  }

  List<AppUser> get users => <AppUser>[..._user];

  AppUser user({required String uid}) {
    int index = _indexOf(uid);
    return index < 0 ? _null : _user[index];
  }

  bool usernameExist({required String value}) {
    final int index = _user.indexWhere((AppUser element) =>
        element.username?.toLowerCase() == value.toLowerCase());
    if (index < 0) return false;
    if (_user[index].uid == AuthMethods.uid) return false;
    return true;
  }

  int _indexOf(String uid) {
    int index = _user.indexWhere((AppUser element) => element.uid == uid);
    return index;
  }

  static AppUser get _null => AppUser(
        uid: 'null',
        displayName: 'null',
      );
}
