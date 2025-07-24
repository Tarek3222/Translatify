import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/utils/app_constants.dart';
import 'package:translators/features/payment/logic/orders_translators_cubit/orders_translators_cubit.dart';
import 'package:translators/features/payment/ui/widgets/orders_translators_body.dart';

class OrdersTranslatorsView extends StatelessWidget {
  const OrdersTranslatorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => OrdersTranslatorsCubit()
            ..getTranslatorsFromOrders(SharedPrefKeys.kOrderListForUser),
          child: const OrdersTranslatorsBody(),
        ),
      ),
    );
  }
}
