import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/features/payment/ui/widgets/payment_method_item.dart';

class PaymentMethodsListView extends StatefulWidget {
  const PaymentMethodsListView({super.key});

  @override
  State<PaymentMethodsListView> createState() => _PaymentMethodsListViewState();
}

class _PaymentMethodsListViewState extends State<PaymentMethodsListView> {
  final List<String> paymentMethodsItems = const [
    'assets/images/card.svg',
    // 'assets/images/paypal.svg',
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62.h,
      child: ListView.builder(
        itemCount: paymentMethodsItems.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8).w,
            child: InkWell(
              onTap: () {
                if (index != selectedIndex) {
                  setState(() {
                    selectedIndex = index;
                  });
                }
              },
              child: PaymentMethodItem(
                isSelected: selectedIndex == index,
                imagePath: paymentMethodsItems[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
