import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'forgott_password_event.dart';
part 'forgott_password_state.dart';

class ForgottPasswordBloc extends Bloc<ForgottPasswordEvent, ForgottPasswordState> {
  ForgottPasswordBloc() : super(ForgottPasswordInitial()) {
    on<ResetPasswordEvent>((event, emit)async {

      try{
        emit(ResetLoadingState());
        await FirebaseAuth.instance.sendPasswordResetEmail(email: event.email.trim());
        print('success');
        emit(ResetSuccssState());
      }catch(e){
         print(e.toString());
         emit(ResetErrorState());
      }

    });
  }
}
