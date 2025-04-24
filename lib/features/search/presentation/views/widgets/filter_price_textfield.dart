import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_app/features/search/presentation/viewmodels/filter_viewmodel.dart';
import 'package:provider/provider.dart';

class FilterPriceTextField extends StatelessWidget {
  FilterPriceTextField({super.key});

  @override
  Widget build(BuildContext context) {
    var viewmodel = context.read<FilterViewmodel>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 30,
      children: [
        Column(
          spacing: 30,
          children: [
            SizedBox(
              width: 100,
              height: 60,
              child: TextField(
                controller: viewmodel.minController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "min".tr(context: context),
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 100,
              height: 60,
              child: TextField(
                controller: viewmodel.maxController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "max".tr(context: context),
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _EnterOrClean(
              onPressed: () {
                // viewmodel.applyPriceFilter();
              },
              icon: Icons.send,
              text: 'enter'.tr(context: context),
            ),
            _EnterOrClean(
              onPressed: () {
                viewmodel.clearPrice();
              },
              icon: Icons.clear,
              text: 'clear'.tr(context: context),
            ),
          ],
        ),
      ],
    );
  }
}

class _EnterOrClean extends StatelessWidget {
  _EnterOrClean({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
  });
  final VoidCallback onPressed;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(color: Colors.black, onPressed: onPressed, icon: Icon(icon)),
        Text(
          text,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
