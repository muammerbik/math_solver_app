import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:math_solver_app/app/constants/app_config.dart';
import 'package:math_solver_app/app/constants/colors_constants.dart';
import 'package:math_solver_app/app/constants/text_constants.dart';
import 'package:math_solver_app/app/pages/premium_page.dart';
import 'package:math_solver_app/app/pages/settings_page.dart';
import 'package:math_solver_app/app/pages/solving_page.dart';
import 'package:math_solver_app/app/services/mathpix_api._service.dart';
import 'package:math_solver_app/app/utils/dialog_utils.dart';
import 'package:math_solver_app/app/utils/text_utils.dart';
import 'package:math_solver_app/app/viewmodel/app_view_model.dart';
import 'package:math_solver_app/app/viewmodel/premium_viewmodel.dart';
import 'package:math_solver_app/app/widgets/custom_circle_elevatet_button.dart';
import 'package:math_solver_app/app/widgets/custom_home_appbar.dart';
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
      final premiumRight = context.read<AppViewModel>().premiumRight;

      if (premiumRight > 0) {
        DialogUtils.showCupertinoActionSheet(
            context, _imgFromCamera, _imgFromGallery);
        context.read<AppViewModel>().decreasePremiumRight();
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PremiumPage()));
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
      appBar: CustomHomeAppbar(
          newIconButton: IconButton(
        onPressed: () {
          settingsTapped();
        },
        icon: Image.asset(
          'assets/icons/Group1.png',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      )),
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 85),
              TextUtils.buildTextWidget(
                TextContants.startHere,
                34,
                ColorConstants.blackColor,
                FontWeight.w700,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: TextUtils.buildTextWidget(
                  TextContants.homePageLongText,
                  17,
                  ColorConstants.blackColor,
                  FontWeight.w400,
                ),
              ),
              const SizedBox(height: 46),
              Image.asset(
                'assets/images/Line2.png',
                height: 125,
              ),
              const SizedBox(height: 46),
              CustomCircleElevatedButton(ConPressed: () {
                AppConfig.datas = '';
                AppConfig.mathExpressionData = '';
                premiumButtonTopped(context);
              })
            ]),
      ),
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
              toolbarColor: ColorConstants.deepOrangeColor,
              toolbarWidgetColor: ColorConstants.backgroundColor,
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
    showLoadingDialog(context);

    final file = File(croppedFile.path);

    final imageUrl = await uploadImageToFirebaseStorage(file);

    if (imageUrl != null && mounted) {
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SolvingPage(imageUrl: imageUrl),
      ));
    } else {
      Navigator.of(context).pop();
    }
  }

  Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Kullanıcının dışarı tıklamasına izin verme
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(), // Yükleniyor animasyonu
        );
      },
    );
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
