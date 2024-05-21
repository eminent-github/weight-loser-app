import 'package:flutter/material.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/models/today_diet_model.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';

class TodoListItemWidget extends StatelessWidget {
  const TodoListItemWidget({
    super.key,
    required this.todosModel,
    required this.todoPressed,
  });

  final Todos todosModel;
  final VoidCallback todoPressed;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    var height = screenSize.height;
    var width = screenSize.width;
    // print(ApiUrls.imageBaseUrl + todosModel.image!);
    return Material(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          width: 0.70,
          color: AppColors.homeTodosBorderColor,
        ),
      ),
      child: InkWell(
        onTap: todoPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: width * 0.02,
            ),
            todosModel.completed!
                ? const Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.homeScreenCheckBoxColor,
                  )
                : const Icon(
                    Icons.check_circle_outline_rounded,
                    color: AppColors.homeScreenCheckBoxColor,
                  ),
            SizedBox(
              width: width * 0.03,
            ),
            Expanded(
              child: Text(
                truncateText(todosModel.title!),
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.formalTextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              width: width * 0.24,
              height: height * 0.09,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(5),
                // image: todosModel.image == null
                //     ? DecorationImage(
                //         image: const AssetImage(),
                //         fit: BoxFit.cover,
                //         colorFilter: ColorFilter.mode(
                //           AppColors.black.withOpacity(0.1),
                //           BlendMode.darken,
                //         ),
                //       )
                //     : DecorationImage(
                //         image: NetworkImage(
                //           ApiUrls.imageBaseUrl + todosModel.image!,
                //         ),
                //         fit: BoxFit.cover,
                //         // colorFilter: ColorFilter.mode(
                //         //   AppColors.black.withOpacity(0.1),
                //         //   BlendMode.darken,
                //         // ),
                //       ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: todosModel.image == null
                    ? Image.asset(
                        "assets/images/todo1.png",
                      )
                    : S3LoadingImage(
                        imageUrl:
                            "${ApiUrls.s3ImageBaseUrl}todos/${todosModel.image!}",
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String truncateText(String text, {int maxCharacters = 28}) {
    if (text.length <= maxCharacters) {
      return text;
    }
    return '${text.substring(0, maxCharacters)}...';
  }
}
