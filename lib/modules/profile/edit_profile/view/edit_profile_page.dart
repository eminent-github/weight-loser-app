import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../widgets/custom_large_button.dart';
import '../controller/edit_profile_controller.dart';
import '../widgets/edit_profile_field.dart';

class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({
    super.key,
    required this.profId,
  });
  final int profId;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Profile',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.015,
                      ),
                      InkWell(
                        onTap: () async {
                          try {
                            await controller.pickImage(context);
                          } catch (e) {
                            print(e);
                          }
                        },
                        borderRadius: BorderRadius.circular(100),
                        child: controller.updatedImage.value.isNotEmpty
                            ? Container(
                                height: height * 0.18,
                                width: width * 0.35,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: const Color(0xffAFD3E2),
                                  ),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(ApiUrls.imageBaseUrl +
                                          controller.updatedImage.value),
                                      fit: BoxFit.cover),
                                ),
                              )
                            : Container(
                                height: height * 0.18,
                                width: width * 0.35,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: const Color(0xffAFD3E2),
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Container(
                                    height: height * 0.13,
                                    width: width * 0.25,
                                    decoration: const BoxDecoration(
                                      color: Color(0xffAFD3E2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add_a_photo_rounded,
                                        size: 35,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Full Name',
                              style: AppTextStyles.formalTextStyle(
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium!
                                    .color!,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            EditProfileTextField(
                              controller: controller.nameController,
                              labelText: "Name",
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Text(
                              'Phone Number',
                              style: AppTextStyles.formalTextStyle(
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium!
                                    .color!,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            EditProfileTextField(
                              controller: controller.phoneNumberController,
                              labelText: "Phone Number",
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Text(
                              'Email',
                              style: AppTextStyles.formalTextStyle(
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium!
                                    .color!,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            EditProfileTextField(
                              controller: controller.emailController,
                              labelText: "Email",
                              readOnly: true,
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Text(
                              'Location',
                              style: AppTextStyles.formalTextStyle(
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium!
                                    .color!,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            EditProfileTextField(
                              controller: controller.locationController,
                              labelText: "Location",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      CustomLargeButton(
                        height: height,
                        width: width * 0.6,
                        text: "Save",
                        onPressed: () {
                          var currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          controller.validateAndPost(profId: profId);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              controller.isLoading.value
                  ? const OverlayWidget()
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
