
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:joylink/model/repo/googleRepo/google_auth_repo.dart';
import 'package:meta/meta.dart';

part 'google_auth_event.dart';
part 'google_auth_state.dart';

class GoogleAuthBloc extends Bloc<GoogleAuthEvent, GoogleAuthState> {
  GoogleAuthBloc() : super(GoogleAuthInitial()) {
    on<SigninEvent>(_signinWithGoogle);
  }

  final AuthRepository authRepository = AuthRepository();

  Future<void> _signinWithGoogle(
      SigninEvent event, Emitter<GoogleAuthState> emit) async {
    emit(GoogleAuthLoading());
    await FirebaseAuth.instance.signOut();
    final user = await authRepository.signinWithGoogle();
    if (user != null) {
      final name = user.email?.split('@').first;
      // print(name);
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({'uid': user.uid, 'mail': user.email, 'name': name});
      emit(GoogleAuthSuccess());
      // print('success');
    }
    emit(GoogleAuthError());
  }
}
