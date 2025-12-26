import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_managerment_class/bloc/cart_event.dart';
import 'package:state_managerment_class/bloc/cart_state.dart';
import 'package:state_managerment_class/model/product_model.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial) {
    on<AddToCart>((event, emit) {
      final newCart = List<CartItem>.from(state.cart)
        ..add(CartItem(product: event.product));
      emit(state.copyWith(cart: newCart));
    });

    on<RemoveAt>((event, emit) {
      final newCart = List<CartItem>.from(state.cart)
        ..removeAt(event.index);
      emit(state.copyWith(cart: newCart));
    });

    on<ClearCart>((event, emit) {
      emit(state.copyWith(cart: []));
    });
  }
}

