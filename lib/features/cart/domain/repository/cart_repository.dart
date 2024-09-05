import 'package:pcnc/features/cart/data/model/cart_model.dart';

abstract class CartRepository {
  List<CartItemModel> getCartItems();
  void addToCart(CartItemModel product);
  void removeFromCart(int id);
  void updateQuantity(int id, bool increase);
  double getTotalPrice();
}
