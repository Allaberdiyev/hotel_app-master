import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/features/search/presentation/viewmodels/filter_viewmodel.dart';
import 'package:hotel_app/features/search/presentation/views/widgets/filter_selected_button_widget.dart';
import 'package:provider/provider.dart';

class FilterFacilities extends StatelessWidget {
  const FilterFacilities({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Consumer<FilterViewmodel>(
              builder:
                  (context, value, child) => FilterSelectedButtonWidget(
                    text: "wf".tr(context: context),
                    onTap: () {
                      value.wfSelected();
                      print(value.wf);
                    },
                    isSelected: value.wf,
                  ),
            ),
            Consumer<FilterViewmodel>(
              builder:
                  (context, value, child) => FilterSelectedButtonWidget(
                    text: "tv".tr(context: context),
                    onTap: () {
                      value.tvSelected();
                    },
                    isSelected: value.tv,
                  ),
            ),
            Consumer<FilterViewmodel>(
              builder:
                  (context, value, child) => FilterSelectedButtonWidget(
                    text: "basseyn".tr(context: context),
                    onTap: () {
                      value.basseynSelected();
                    },
                    isSelected: value.basseyn,
                  ),
            ),
          ],
        ),
        Consumer<FilterViewmodel>(
          builder:
              (context, value, child) => FilterSelectedButtonWidget(
                text: "breakfast".tr(context: context),
                onTap: () {
                  value.breakfastSelected();
                },
                isSelected: value.breakfast,
              ),
        ),
      ],
    );
  }
}
