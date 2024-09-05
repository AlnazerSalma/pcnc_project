import 'package:pcnc/features/cart/data/model/cart_model.dart';
import 'package:pcnc/features/cart/data/repository/cart_repository_impl.dart';

class AddToCartUseCase {
  final CartRepositoryImpl cartRepository;

  AddToCartUseCase(this.cartRepository);

  void execute(CartItemModel product) {
    cartRepository.addToCart(product);
  }
}

class RemoveFromCartUseCase {
  final CartRepositoryImpl cartRepository;

  RemoveFromCartUseCase(this.cartRepository);

  void execute(int id) {
    cartRepository.removeFromCart(id);
  }
}

class UpdateQuantityUseCase {
  final CartRepositoryImpl cartRepository;

  UpdateQuantityUseCase(this.cartRepository);

  void execute(int id, bool increase) {
    cartRepository.updateQuantity(id, increase);
  }
}

class GetCartItemsUseCase {
  final CartRepositoryImpl cartRepository;

  GetCartItemsUseCase(this.cartRepository);

  List<CartItemModel> execute() {
    return cartRepository.getCartItems();
  }
}

class GetTotalPriceUseCase {
  final CartRepositoryImpl cartRepository;

  GetTotalPriceUseCase(this.cartRepository);

  double execute() {
    return cartRepository.getTotalPrice();
  }
}
