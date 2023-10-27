import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:math_solver_app/constants/app_config.dart';
import 'package:math_solver_app/models/premium_model.dart';
import 'package:math_solver_app/pages/premium_page.dart';
import 'package:math_solver_app/pages/settings_page.dart';
import 'package:math_solver_app/pages/solving_page.dart';
import 'package:math_solver_app/services/mathpix_api._service.dart';
import 'package:math_solver_app/utils/dialog_utils.dart';
import 'package:math_solver_app/utils/text_utils.dart';
import 'package:math_solver_app/viewmodel/premium_viewmodel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? imageFile;
  final picker = ImagePicker();
  final apiService = MathpixApiService();

  Future<void> premiumButtonTopped(BuildContext context) async {
    context.read<PremiumViewModel>().checkPremiumComplate;
    if (context.read<PremiumViewModel>().getIsPremium == true) {
      DialogUtils.showCupertinoActionSheet(
          context, _imgFromCamera, _imgFromGallery);
    } else {
      final userBox = await Hive.openBox<PremiumModel>('premium');
      if (!userBox.containsKey(0)) {
        final userData = PremiumModel(0);
        userBox.put(0, userData);
      }
      PremiumModel? userData = userBox.getAt(0);
      if (userData != null) {
        if (userData.secilenValue < AppConfig.newValue) {
          DialogUtils.showCupertinoActionSheet(
              context, _imgFromCamera, _imgFromGallery);

          userData.secilenValue++;
          userBox.putAt(0, userData);
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PremiumPage()));
        }
      }
    }
  }

  void settingsTapped() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SettingsPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 85),
              TextUtils.buildTextWidget(
                "Start here",
                34,
                Colors.black,
                FontWeight.w700,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: TextUtils.buildTextWidget(
                  "Take a picture of your math problem or \nupload it from your photos.",
                  17,
                  Colors.black,
                  FontWeight.w400,
                ),
              ),
              const SizedBox(height: 46),
              Image.asset(
                'assets/images/Line2.png',
                height: 125,
              ),
              const SizedBox(height: 46),
              ElevatedButton(
                onPressed: () async {
                  await premiumButtonTopped(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(160),
                  ),
                  shadowColor: Colors.transparent,
                ),
                child: Container(
                  width: 94,
                  height: 94,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [Color(0xFFAF87FD), Color(0xFF904CFF)],
                    ),
                  ),
                ),
              )
            ]),
      ),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: TextUtils.buildTextWidget(
        "Math Solver",
        34,
        Colors.black,
        FontWeight.w700,
      ),
      actions: [
        IconButton(
          onPressed: () {
            settingsTapped();
          },
          icon: Image.asset(
            'assets/icons/Group1.png',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }

  void _imgFromGallery() async {
    await picker
        .pickImage(source: ImageSource.gallery, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  void _imgFromCamera() async {
    await picker
        .pickImage(source: ImageSource.camera, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  void _cropImage(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: "Image Cropper",
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: "Image Cropper",
          )
        ]);
    if (croppedFile != null) {
      imageCache.clear();
      setState(() {
        _navigateToSolvingPage(croppedFile);
      });
    }
  }

  void _navigateToSolvingPage(CroppedFile croppedFile) async {
    final file = File(croppedFile.path);

    final imageUrl = await uploadImageToFirebaseStorage(file);

    if (imageUrl != null && mounted) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SolvingPage(imageUrl: imageUrl),
      ));
    }
  }

  Future<String?> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      final storage = FirebaseStorage.instance;
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();

      final storageReference =
          storage.ref().child("/user_images/$fileName.png");

      await storageReference.putFile(imageFile);
      String downloadURL = await storageReference.getDownloadURL();

      return downloadURL;
    } catch (e) {
      return null;
    }
  }
}
