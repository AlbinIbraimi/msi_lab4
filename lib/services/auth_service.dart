import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab_4/main.dart';
import 'package:lab_4/models/user.dart';
import 'package:lab_4/providers/app_provider.dart';
import 'package:provider/provider.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final provider = Provider.of<ApplicationProvider>(
    navigatorKey.currentContext!,
    listen: false,
  );

  MyUser userFromFirebase(User? user) {
    return MyUser(user?.uid ?? "", user?.email ?? "");
  }

  Future<MyUser?> signInAnno() async {
    try {
      var result = await _auth.signInAnonymously();
      if (result.user != null) {
        var myUser = userFromFirebase(result.user);
        provider.user = myUser;
        return myUser;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future signout() async {
    await _auth.signOut();
    provider.user = MyUser("", "");
  }
}
