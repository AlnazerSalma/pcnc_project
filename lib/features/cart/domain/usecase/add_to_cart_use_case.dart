import 'package:pcnc/features/cart/data/model/cart_model.dart';
import 'package:pcnc/features/cart/data/repository/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository cartRepository;

  AddToCartUseCase(this.cartRepository);

  void execute(CartItemModel product) {
    cartRepository.addToCart(product);
  }
}

class RemoveFromCartUseCase {
  final CartRepository cartRepository;

  RemoveFromCartUseCase(this.cartRepository);

  void execute(int id) {
    cartRepository.removeFromCart(id);
  }
}

class UpdateQuantityUseCase {
  final CartRepository cartRepository;

  UpdateQuantityUseCase(this.cartRepository);

  void execute(int id, bool increase) {
    cartRepository.updateQuantity(id, increase);
  }
}

class GetCartItemsUseCase {
  final CartRepository cartRepository;

  GetCartItemsUseCase(this.cartRepository);

  List<CartItemModel> execute() {
    return cartRepository.getCartItems();
  }
}

class GetTotalPriceUseCase {
  final CartRepository cartRepository;

  GetTotalPriceUseCase(this.cartRepository);

  double execute() {
    return cartRepository.getTotalPrice();
  }
}
