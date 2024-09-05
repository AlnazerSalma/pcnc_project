import 'package:flutter/material.dart';
import 'package:pcnc/features/cart/data/model/cart_model.dart';
import 'package:pcnc/features/cart/domain/usecase/add_to_cart_usecase.dart';

class CartProvider with ChangeNotifier {
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final UpdateQuantityUseCase updateQuantityUseCase;
  final GetCartItemsUseCase getCartItemsUseCase;
  final GetTotalPriceUseCase getTotalPriceUseCase;

  CartProvider({
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
    required this.updateQuantityUseCase,
    required this.getCartItemsUseCase,
    required this.getTotalPriceUseCase,
  });

  List<CartItemModel> get cartItems => getCartItemsUseCase.execute();

  double get totalPrice => getTotalPriceUseCase.execute();

  void addToCart(CartItemModel product) {
    addToCartUseCase.execute(product);
    notifyListeners();
  }

  void removeFromCart(int id) {
    removeFromCartUseCase.execute(id);
    notifyListeners();
  }

  void updateQuantity(int id, bool increase) {
    updateQuantityUseCase.execute(id, increase);
    notifyListeners();
  }
   bool isInCart(int id) {
    return cartItems.any((item) => item.id == id);
  }
}
