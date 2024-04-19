import 'package:bloc/bloc.dart';
import 'package:joylink/model/repo/googleRepo/google_auth_repo.dart';
import 'package:meta/meta.dart';

part 'google_auth_event.dart';
part 'google_auth_state.dart';

class GoogleAuthBloc extends Bloc<GoogleAuthEvent, GoogleAuthState> {
  GoogleAuthBloc() : super(GoogleAuthInitial()) {
    on<SigninEvent>(_signinWithGoogle);
  }

  final AuthRepository authRepository=AuthRepository();


  Future<void> _signinWithGoogle(
      SigninEvent event, Emitter<GoogleAuthState> emit) async {
        emit(GoogleAuthLoading());
        final user=await authRepository.signinWithGoogle();
        if(user==null){
          return emit(GoogleAuthError());
        }
        emit(GoogleAuthSuccess());
        print('success');
      }
}
