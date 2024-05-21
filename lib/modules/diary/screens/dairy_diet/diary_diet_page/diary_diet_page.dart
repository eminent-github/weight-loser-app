import 'package:flutter/material.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/diary/models/diary_model.dart';
import 'package:weight_loss_app/modules/diary/screens/dairy_diet/widgets/diary_diet_item.dart';

class DiaryDietPage extends StatelessWidget {
  const DiaryDietPage({
    super.key,
    required this.breakfastList,
    required this.luncheList,
    required this.dinnerList,
    required this.snackList,
  });
  final List<BreakfastList> breakfastList;
  final List<LuncheList> luncheList;
  final List<DinnerList> dinnerList;
  final List<SnackList> snackList;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
        SliverToBoxAdapter(
          child: Text(
            'Breakfast',
            style: AppTextStyles.formalTextStyle(
              fontSize: 12,
              color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
            ),
          ),
        ),
        DiaryBreakFastItem(breakfastList: breakfastList),
        ///////////////////////////
        SliverToBoxAdapter(
          child: Text(
            'Snacks',
            style: AppTextStyles.formalTextStyle(
              fontSize: 12,
              color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
            ),
          ),
        ),
        DiarySnackItem(snackList: snackList),
        /////////////////////
        SliverToBoxAdapter(
          child: Text(
            'Lunch',
            style: AppTextStyles.formalTextStyle(
              fontSize: 12,
              color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
            ),
          ),
        ),
        DiaryLunchItem(luncheList: luncheList),
        ///////////////////////////
        SliverToBoxAdapter(
          child: Text(
            'Dinner',
            style: AppTextStyles.formalTextStyle(
              fontSize: 12,
              color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
            ),
          ),
        ),
        DiaryDinnerItem(dinnerList: dinnerList),
        const SliverToBoxAdapter(
          child: SizedBox(height: 50),
        )
      ],
    );
  }
}
