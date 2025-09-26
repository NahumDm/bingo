import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'bingo_number_model.dart';

class BingoCardProvider extends ChangeNotifier {
  List<BingoCard> _cards = [];

  List<BingoCard> get cards => _cards;

  Future<void> loadCards() async {
    final String response = await rootBundle.loadString(
      'assets/data/bingoCards.json',
    );
    final Map<String, dynamic> data = json.decode(response);
    final Map<String, dynamic> cardsMap = data['cards'];
    _cards =
        cardsMap.values
            .map((json) => BingoCard.fromJson(json as Map<String, dynamic>))
            .toList();
    notifyListeners();
  }

  BingoCard? getCardById(int id) {
    try {
      return _cards.firstWhere((card) => card.id == id);
    } catch (e) {
      return null;
    }
  }
}
