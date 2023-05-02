// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  PhoneAuthCubit() : super(PhoneAuthInitial());
  late String verificationId;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(Loading());
    return await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: 10),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print('verificationCompleted');

    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException authException) {
    print('verificationFailed: ${authException.toString()}}');

    emit(ErrorOccurred(error: authException.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    this.verificationId = verificationId;

    emit(PhoneNumberSubmited());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout');
  }

  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);
    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await auth.signInWithCredential(credential);
      emit(PhoneOTPVerified());
    } catch (error) {
      emit(ErrorOccurred(error: error.toString()));
    }
  }

  Future<void> logOut() async {
    await auth.signOut();
  }

  User getLoggedInUser() {
    return auth.currentUser!;
  }
}
