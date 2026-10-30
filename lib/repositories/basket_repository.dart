import 'package:southsea_cinema/models/basket_item.dart';

class BasketRepository {
  BasketRepository._internal();

    static const double serviceChargePerLine = 2.0;

    double getServiceCharge() {
      return _items.length * serviceChargePerLine;
    }

    double getTotalDue() {
      return getTotal() + getServiceCharge();
    }

  static final BasketRepository instance = BasketRepository._internal();

  final List<BasketItem> _items = [];

  List<BasketItem> getItems () {
    return List<BasketItem>.unmodifiable(_items);
  }

  void addItem(BasketItem item) {
    _items.add(item);
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
    }
  }

  int getTotalTickets() {
    int total = 0;
    for (final BasketItem item in _items) {
      total += item.quantity;
    }
    return total;
  }

  double getTotal() {
    double sum = 0.0;
    for (final BasketItem item in _items) {
      sum += item.lineTotal;
    }
    return sum;
  }

  void clear() {
    _items.clear();
  }
}
