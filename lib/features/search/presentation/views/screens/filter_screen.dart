import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/features/search/presentation/viewmodels/filter_viewmodel.dart';
import 'package:hotel_app/features/search/presentation/views/widgets/filter_facilities.dart';
import 'package:hotel_app/features/search/presentation/views/widgets/filter_price_textfield.dart';
import 'package:hotel_app/features/search/presentation/views/widgets/text_item.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({super.key});
  FilterViewmodel viewmodel = FilterViewmodel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextItem(
          text: "filter".tr(context: context),
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextItem(
              text: "facilities".tr(context: context),
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
            FilterFacilities(),
            TextItem(
              text: "rating".tr(context: context),
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
            Consumer<FilterViewmodel>(
              builder:
                  (context, value, child) => Row(
                    children: List.generate(
                      5,
                      (index) => IconButton(
                        onPressed: () {
                          value.setSelectRating(index + 1);
                        },
                        icon: Icon(
                          index < value.selectRating
                              ? Icons.star
                              : Icons.star_border,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
            ),
            TextItem(
              text: "price_range".tr(context: context),
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
            FilterPriceTextField(),
          ],
        ),
      ),
    );
  }
}
