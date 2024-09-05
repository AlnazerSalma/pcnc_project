
import 'package:pcnc/ApiService/api_service.dart';
import 'package:pcnc/aa/features/cart/data/model/cart_model.dart';

class CartRepository {
  final List<CartItemModel> _cartItems = [];
  final ApiService apiService;
CartRepository(this.apiService);
  List<CartItemModel> getCartItems() {
    return _cartItems;
    
  }

  void addToCart(CartItemModel product) {
    final index = _cartItems.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      _cartItems[index].quantity++;
    } else {
      _cartItems.add(product);
    }
  }

  void removeFromCart(int id) {
    _cartItems.removeWhere((item) => item.id == id);
  }

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

  double getTotalPrice() {
    return _cartItems.fold(0, (total, item) => total + (double.tryParse(item.price)! * item.quantity));
  }
}
