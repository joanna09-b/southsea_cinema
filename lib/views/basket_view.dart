import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/widgets/cinema_button.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

const TextStyle _bodyStyle = TextStyle(color: cinemaFontWhite, fontSize: 16);
const TextStyle _boldStyle = TextStyle(
  color: cinemaFontWhite,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);
const TextStyle _brandStyle = TextStyle(
  color: cinemaBrand,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

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
        child: Text('Your basket is empty', style: _bodyStyle),
      ),
    );
  }

  Widget _buildHeaderRow() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text('Item', style: _boldStyle)),
          Expanded(flex: 4, child: Text('Details', style: _boldStyle)),
          Expanded(
            flex: 2,
            child: Text('Price', style: _boldStyle, textAlign: TextAlign.right),
          ),
          SizedBox(width: 56),
        ],
      ),
    );
  }

  Widget _buildLineItem(BasketItem item, int index) {
    String ticketWord = 'Tickets';
    if (item.quantity == 1) {
      ticketWord = 'Ticket';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text('${item.quantity} $ticketWord', style: _brandStyle),
          ),
          Expanded(
            flex: 4,
            child: Text(
              '${item.quantity} Standard\n'
              '${item.movie.title}, ${item.movie.date} ${item.movie.time}, '
              'Southsea Cinema Room',
              style: _bodyStyle,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '£${item.lineTotal.toStringAsFixed(2)}',
              style: _bodyStyle,
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 48,
            height: 48,
            color: cinemaBrand,
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: () {
                setState(() {
                  BasketRepository.instance.removeItem(index);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, String value, {bool emphasise = false}) {
    final TextStyle style;
    if (emphasise) {
      style = _boldStyle;
    } else {
      style = _bodyStyle;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
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
        'MY ORDER',
        style: TextStyle(
          color: cinemaFontWhite,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    children.add(const SizedBox(height: 16));
    children.add(_buildHeaderRow());

    for (int index = 0; index < items.length; index++) {
      children.add(_buildLineItem(items[index], index));
    }

    children.add(const SizedBox(height: 16));
    children.add(
      _buildTotalRow(
        'Service Charge',
        '£${basket.getServiceCharge().toStringAsFixed(2)}',
      ),
    );
    children.add(
      _buildTotalRow(
        'Total Due',
        '£${basket.getTotalDue().toStringAsFixed(2)}',
        emphasise: true,
      ),
    );
    children.add(const SizedBox(height: 24));
    children.add(
      Row(
        children: [
          Expanded(
            child: CinemaButton(
              label: 'UPDATE ORDER',
              horizontalPadding: 8,
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: CinemaButton(
              label: 'BUY TICKETS',
              horizontalPadding: 8,
              onPressed: () {
                setState(() {
                  basket.clear();
                  _confirmationMessage = 'Thanks, your tickets are booked';
                });
              },
            ),
          ),
        ],
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
            Text(_confirmationMessage, style: _boldStyle),
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
        padding: const EdgeInsets.all(16.0),
        child: content,
      ),
    );
  }
}