import 'package:flutter/material.dart';
import 'package:hotel_app/features/search/presentation/viewmodels/filter_viewmodel.dart';
import 'package:hotel_app/features/search/presentation/views/widgets/text_item.dart';
import 'package:provider/provider.dart';

class FilterSelectedButtonWidget extends StatelessWidget {
  const FilterSelectedButtonWidget({
    super.key,
    required this.text,
    required this.onTap,
    required this.isSelected,
  });

  final String text;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Stack(
        children: [
          Container(
            width: 100,
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
              // boxShadow: [
              //   BoxShadow(
              //     blurRadius: 5,
              //     offset: Offset(1, 2),
              //     blurStyle: BlurStyle.inner,
              //   ),
              // ],
            ),
            alignment: Alignment.center,
            child: TextItem(
              text: text,
              fontWeight: FontWeight.w700,
              fontSize: 10,
            ),
          ),
          isSelected == true
              ? Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.check, size: 12, color: Colors.white),
                ),
              )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
