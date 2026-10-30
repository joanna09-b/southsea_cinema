import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/widgets/cinema_button.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';


class BasketView extends StatefulWidget {
  const BasketView({super.key});

  @override
  State<BasketView> createState() {
    return _BasketViewState();
  }
}

class _BasketViewState extends State<BasketView> {
  String _confirmationMessage = '';

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32.0),
        child: Text(
          'Your basket is empty.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildLineItem(BasketItem item, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${item.quantity} x ${item.movie.title}',
                  style: const TextStyle(
                    color: cinemaFontWhite,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.movie.date} at ${item.movie.time}',
                  style: const TextStyle(color: cinemaFontWhite),
                ),
                const SizedBox(height: 4),
                Text(
                  '£${item.lineTotal.toStringAsFixed(2)}',
                  style: const TextStyle(color: cinemaFontWhite),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () {
              setState(() {
                BasketRepository.instance.removeItem(index);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, String value, {bool emphasise = false}) {
    final TextStyle style;
    if (emphasise) {
      style = const TextStyle(
          color: cinemaFontWhite,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        );
    } else {
      style = const TextStyle(
        color: cinemaFontWhite,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    ); 

  }
  Widget _buildBasketList(BasketRepository basket, List<BasketItem> items) {
    final List<Widget> children = [];

    children.add(
      const Text(
        'Your basket', 
        style: TextStyle(
          color: cinemaFontWhite,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    children.add(const SizedBox(height: 16));

    for (int index = 0; index < items.length; index++) {
      children.add(_buildLineItem(items[index], index));
    }
    
    children.add(const SizedBox(height: 24));
      children.add(_buildTotalRow('Total Tickets', '${basket.getTotalTickets()}'));
      children.add(
        _buildTotalRow(
          'Total to pay',
          '£${basket.getTotal().toStringAsFixed(2)}',
          emphasise: true,
        ),
      );
      children.add(const SizedBox(height: 24));
      children.add(
        SizedBox(
          width: double.infinity,
          child: CinemaButton(
            label: 'Checkout',
            onPressed: () {
              setState(() {
                _confirmationMessage = 'Thank you for your order!';
                basket.clear();
              });
            },
          ),
        ),
      );
  
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      );
    }
  
    @override
    Widget build(BuildContext context) {
      final BasketRepository basket = BasketRepository.instance;
      final List<BasketItem> items = basket.getItems();

      final Widget content;
      if (items.isEmpty) {
        if (_confirmationMessage.isNotEmpty) {
          content = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEmptyState(),
              const SizedBox(height: 12),
              Text(
                _confirmationMessage,
                style: const TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        } else {
          content = _buildEmptyState();
        }
      } else {
        content = _buildBasketList(basket, items);
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        drawer: const NavDrawer(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: content,
        ),
      );
    }
  }