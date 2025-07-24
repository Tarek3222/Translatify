import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/utils/app_constants.dart';
import 'package:translators/features/payment/logic/history_payments_cubit/history_payments_cubit.dart';
import 'package:translators/features/payment/ui/widgets/payments_history_body.dart';

class PaymentsHistoryView extends StatelessWidget {
  const PaymentsHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => HistoryPaymentsCubit()
            ..getTranslatorsFromPayments(
              SharedPrefKeys.kPaymnetsListForUser,
            ),
          child: const PaymentsHistoryBody(),
        ),
      ),
    );
  }
}
