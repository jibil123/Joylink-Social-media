import 'package:flutter/material.dart';
import 'package:joylink/utils/colors.dart';

// Uint8List? selectedImage;
Widget followFunction(String text) {
  return Container(
    width: 150,
    height: 30,
    decoration: BoxDecoration(
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.whiteColor,
          fontSize: 15,
        ),
      ),
    ),
  );
}

// showdialogForProfile(BuildContext context) {
//   BlocProvider.of<ProfilePhotoBloc>(context);
//   showDialog(
//       context: context,
//       builder: (context) {
//         return BlocBuilder<ProfilePhotoBloc, ProfilePhotoState>(        
//           builder: (context, state) {

//             return AlertDialog(
//               content: const Text('Pick profile image',
//                   style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.blackColor)),
//               actions: [
//                 IconButton(
//                     onPressed: () {
//                       // profilebloc.add(SelectPhotoFromCamAndGal());
//                       // getImageCamAndGal(ImageSource.gallery);
//                       Navigator.pop(context);
//                     },
//                     icon: const Icon(
//                       Icons.image,
//                       size: 50,
//                     )),
//                 IconButton(
//                     onPressed: () {
//                       // getImageCamAndGal(ImageSource.camera);
//                       Navigator.pop(context);
//                     },
//                     icon: const Icon(
//                       Icons.camera,
//                       size: 50,
//                     ))
//               ],
//             );
//           },
//         );
//       });
//   return selectedImage;
// }

// void getImageCamAndGal(ImageSource source) async {
//   final XFile? image = await ImagePicker().pickImage(source: source);
//   if (image != null) {
//     selectedImage = await image.readAsBytes();

//     image.name.toString();
//   }
// }
