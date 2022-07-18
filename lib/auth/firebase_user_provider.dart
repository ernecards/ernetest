import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class ErneFirebaseUser {
  ErneFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

ErneFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<ErneFirebaseUser> erneFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<ErneFirebaseUser>((user) => currentUser = ErneFirebaseUser(user));
