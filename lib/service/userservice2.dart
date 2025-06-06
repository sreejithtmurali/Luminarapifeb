import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled3/Model/User.dart';

class Userservice2 {
  final String _refresh="refresh";
  final String _access="access";
  final String _id="id";
  final String _name="name";
  final String _place="place";
  final String _email="email";

  final String _user="user";
  String? refresh;
  String? access;
  int? id;
  String? name;
  String? place;
  String? email;

  Future<void> saveuser(User user) async {
    final _pref=await SharedPreferences.getInstance();
    // var jsonuser=await userToJson(user);
    // if(jsonuser!=null){
    //   _pref.setString(_user, jsonuser);
    // }
    _pref.setString(_refresh, user.refresh!);
    _pref.setString(_access, user.access!);
    _pref.setInt(_id, user.id!);
    _pref.setString(_name, user.name!);
    _pref.setString(_place, user.place!);
    _pref.setString(_email, user.email!);
  }
  Future<bool> islogin() async {
    final _pref=await SharedPreferences.getInstance();
    name=_pref.getString(_name);
    if(name!=null){
      return true;
    }
    return false;
  }
  Future<User?> getuser() async {
    final _pref=await SharedPreferences.getInstance();
    if(islogin()==true) {
      name = _pref.getString(_name);
      refresh = _pref.getString(_refresh);
      access = _pref.getString(_access);
      id = _pref.getInt(_id);
      place = _pref.getString(_place);
      email = _pref.getString(_email);
      User user = User(
          refresh: refresh,
          access: access,
          name: name,
          id: id,
          email: email,
          place: place);
      return user;
    }
  }
Future<String?> getaccesskey() async {
  final _pref=await SharedPreferences.getInstance();
  if(await islogin()) {
    return _pref.getString(_access);
  }
}

Future<void> logout() async {
  final _pref=await SharedPreferences.getInstance();
  _pref.clear();
}

}