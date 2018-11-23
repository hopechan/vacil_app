import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<GoogleSignInAccount> cuentaExistente(GoogleSignIn googleSignIn) async{
  //El usuario ya se habia registrado?
  GoogleSignInAccount cuenta = googleSignIn.currentUser;
  if(cuenta == null){
    cuenta = await googleSignIn.signInSilently();
  }
  return cuenta;
}

Future<FirebaseUser> entrarFirebase(GoogleSignInAccount cuentaGoogle) async{
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignInAuthentication googleAuth = await cuentaGoogle.authentication;
  return await _auth.signInWithGoogle(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken
  );
}