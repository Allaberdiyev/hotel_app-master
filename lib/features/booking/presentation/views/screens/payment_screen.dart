import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<String> paymentTypes = ["Naqd", "Plastik"];
  late String dropdownValue;
  @override
  void initState() {
    super.initState();
    dropdownValue = paymentTypes.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("payment".tr(context: context)),
        centerTitle: true,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("payment_successful".tr(context: context)),
                  ),
                );
                Navigator.pop(context);
              },
              child: Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xFF0071FE),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "cash".tr(context: context),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("payment_successful".tr(context: context)),
                  ),
                );
                Navigator.pop(context);
              },
              child: Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xFF001529),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "card".tr(context: context),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
