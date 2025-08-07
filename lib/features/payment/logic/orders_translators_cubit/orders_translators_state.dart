part of 'orders_translators_cubit.dart';

sealed class OrdersTranslatorsState extends Equatable {
  const OrdersTranslatorsState();

  @override
  List<Object> get props => [];
}

final class OrdersTranslatorsInitial extends OrdersTranslatorsState {}

final class OrdersTranslatorsLoadingClearAll extends OrdersTranslatorsState {}

final class OrdersTranslatorsLoadingDeleteTranslator
    extends OrdersTranslatorsState {}

final class OrdersTranslatorsSuccess extends OrdersTranslatorsState {
  final List<OrderTranslatorModel> translatorsList;

  const OrdersTranslatorsSuccess({required this.translatorsList});

  @override
  List<Object> get props => [translatorsList];
}

final class OrdersTranslatorsEmptyList extends OrdersTranslatorsState {}
