import 'package:pcnc/core/app_service/api_service.dart';
import 'package:pcnc/features/cart/data/model/cart_model.dart';
import 'package:pcnc/features/cart/domain/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final List<CartItemModel> _cartItems = [];
  final ApiService apiService;

  CartRepositoryImpl(this.apiService);

  @override
  List<CartItemModel> getCartItems() {
    return _cartItems;
  }

  @override
  void addToCart(CartItemModel product) {
    final index = _cartItems.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      _cartItems[index].quantity++;
    } else {
      _cartItems.add(product);
    }
  }

  @override
  void removeFromCart(int id) {
    _cartItems.removeWhere((item) => item.id == id);
  }

  @override
  void updateQuantity(int id, bool increase) {
    final index = _cartItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      if (increase) {
        _cartItems[index].quantity++;
      } else {
        if (_cartItems[index].quantity > 1) {
          _cartItems[index].quantity--;
        }
      }
    }
  }

  @override
  double getTotalPrice() {
    return _cartItems.fold(
        0,
        (total, item) =>
            total + (double.tryParse(item.price)! * item.quantity));
  }
}
