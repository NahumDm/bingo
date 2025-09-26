import 'package:bingo/Core/constants.dart';
import 'package:flutter/material.dart';
import '../Provider/bingo_number_provider.dart';
import '../Provider/bingo_number_model.dart';
import '../Widget/table_grid.dart';
import '../Widget/card_input.dart';

class BingoScreen extends StatefulWidget {
  const BingoScreen({super.key});

  @override
  State<BingoScreen> createState() => _BingoScreenState();
}

class _BingoScreenState extends State<BingoScreen> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  BingoCardProvider _provider = BingoCardProvider();
  BingoCard? _selectedCard1;
  BingoCard? _selectedCard2;

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  //Dispose TextEditingControllers
  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  void _loadCards() async {
    await _provider.loadCards();
    if (!mounted) return;
    setState(() {});
  }

  void _onPlay1() {
    final id = int.tryParse(_controller1.text);
    if (id != null) {
      setState(() {
        _selectedCard1 = _provider.getCardById(id);
      });
    }
  }

  void _onPlay2() {
    final id = int.tryParse(_controller2.text);
    if (id != null) {
      setState(() {
        _selectedCard2 = _provider.getCardById(id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar
      appBar: AppBar(
        title: Text(
          'Revo Bingo',
          style: TextStyle(
            color: const Color.fromARGB(255, 15, 3, 3),
            fontSize: Constants.appbarFont,
            fontFamily: 'Super Sunday',
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: true,
        backgroundColor: Constants.textColor,
      ),
      backgroundColor: Constants.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 15.0),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 20.0),
              //   child: Text(
              //     'Enter Card Number',
              //     style: TextStyle(
              //       fontSize: Constants.textFont,
              //       fontFamily: 'Bitcount Grid Double',
              //       color: Constants.secondColor,
              //     ),
              //   ),
              // ),
              // First card input and result
              CardInput(
                controller: _controller1,
                onPlay: _onPlay1,
                label: 'Enter Card Number 1',
              ),
              const SizedBox(height: 10),
              if (_selectedCard1 != null)
                TableGrid(card: _selectedCard1!)
              else
                const Text('No card selected or card not found.'),
              const SizedBox(height: 30),
              // Second card input and result
              CardInput(
                controller: _controller2,
                onPlay: _onPlay2,
                label: 'Enter Card Number 2',
              ),
              const SizedBox(height: 10),
              if (_selectedCard2 != null)
                TableGrid(card: _selectedCard2!)
              else
                const Text('No card selected or card not found.'),
            ],
          ),
        ),
      ),
    );
  }
}
