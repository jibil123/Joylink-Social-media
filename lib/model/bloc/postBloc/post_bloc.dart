import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:joylink/model/bloc/authBloc/model/post_model.dart';
import 'package:meta/meta.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<AddPhoto>(_onAddPhoto);
    on<SavePostEvent>(onSavePost);
    on<CancelPostEvent>(onCancelPost);
  }
  void _onAddPhoto(AddPhoto event, Emitter<PostState> emit) {
    emit(PostPhotoAdded(photo: event.photo));
  }

  void onSavePost(SavePostEvent event, Emitter<PostState> emit) async {
    print(event.postModel.description);
    print(event.postModel.photo);
    emit(PostLoadingState());
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref('upload photos')
          .child(DateTime.now().microsecondsSinceEpoch.toString());
      final metadata =
          firebase_storage.SettableMetadata(contentType: 'image/jpeg');
      await ref.putData(event.postModel.photo!, metadata);
      String downloadURL = await ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('user post').add({
        'description': event.postModel.description,
        'photoUrl': downloadURL,
        'time': DateTime.now()
      });
      emit(PostSavedState());
    } catch (e) {
      print(e.toString());
    }
  }

  void onCancelPost(CancelPostEvent event, Emitter<PostState> emit) {
    emit(PostCanceledState());
  }
}
