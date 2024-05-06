import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joylink/model/bloc/PostFetchBloc/post_bloc.dart';
import 'package:joylink/model/model/post_model.dart';
import 'package:joylink/model/bloc/postBloc/post_bloc.dart';
import 'package:joylink/utils/media_quary.dart';
import 'package:joylink/view/screens/authScreen/utils/custom_elevated_button.dart';
import 'package:joylink/view/screens/authScreen/utils/customtextformfield.dart';
import 'package:joylink/view/screens/postScreen/location_screen.dart';
import 'package:joylink/view/screens/postScreen/post_photo.dart';

class PostScreen extends StatelessWidget {
  PostScreen({
    super.key,
  });

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final postbloc = BlocProvider.of<PostBloc>(context);
    final postFetchBloc = BlocProvider.of<PostFetchBloc>(context);
    return BlocConsumer<PostBloc, PostState>(
      listener: (context, state) {
        if (state is PostSavedState) {
          descriptionController.text='';
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Successfully done'),
            backgroundColor: Colors.green,
          ));
         postFetchBloc.add(FetchPostsEvent());
        }
        if (state is PostCanceledState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Upload canceled'),
            backgroundColor: Colors.red,
          ));
        }
        if (state is AddPhotoBeforeUpload) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please add a photo before upload'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is PostLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Upload'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const PostPhotoScreen(),
                      SizedBox(
                        height: mediaqueryHeight(0.03, context),
                      ),
                      LocationScreen(),
                      SizedBox(
                        height: mediaqueryHeight(0.03, context),
                      ),
                      CustomTextField(
                          maxLines: 4,
                          hintText: 'Enter description',
                          controller: descriptionController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter the description';
                            } else {
                              return null;
                            }
                          }),
                      SizedBox(
                        height: mediaqueryHeight(0.03, context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomElevatedButton(
                              label: 'Save',
                              onPressed: () {
                                postbloc.postModel.description =
                                    descriptionController.text;
                                postbloc.add(SavePostEvent());
                              },
                              icon: Icons.save),
                          CustomElevatedButton(
                              label: 'Cancel',
                              onPressed: () {
                                descriptionController.text='';
                                postbloc.add(CancelPostEvent());
                              },
                              icon: Icons.cancel)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
