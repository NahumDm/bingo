import 'package:bingo/Core/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Provider/bingo_number_model.dart';

class TableGrid extends StatefulWidget {
  final BingoCard card;
  const TableGrid({Key? key, required this.card}) : super(key: key);

  @override
  State<TableGrid> createState() => _TableGridState();
}

class _TableGridState extends State<TableGrid> {
  // Track clicked state for each cell (excluding headers and star cell)
  late List<List<bool>> clicked;

  @override
  void initState() {
    super.initState();
    // 5 columns x 5 rows, but N column has a star in the center
    clicked = List.generate(5, (col) => List.generate(5, (row) => false));
  }

  void clearClicked() {
    setState(() {
      clicked = List.generate(5, (col) => List.generate(5, (row) => false));
    });
  }

  @override
  Widget build(BuildContext context) {
    // Prepare columns
    final columns = [
      {'label': 'B', 'numbers': widget.card.b},
      {'label': 'I', 'numbers': widget.card.i},
      {'label': 'N', 'numbers': List<int?>.from(widget.card.n)},
      {'label': 'G', 'numbers': widget.card.g},
      {'label': 'O', 'numbers': widget.card.o},
    ];

    // Insert star in the middle of 'N' column (index 2, row 2)
    final nNumbers = columns[2]['numbers'] as List<int?>;
    nNumbers.insert(2, null); // null will be replaced by the star

    // Prepare grid items: first row is headers, then numbers/star
    List<Widget> gridItems = [];
    // Add headers
    for (var col in columns) {
      gridItems.add(
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFa5a5a5),
            shape: BoxShape.circle, // 100% radius for circular background
          ),
          alignment: Alignment.center,
          child: Text(
            col['label'] as String,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Constants.secondColor, // Alphabet color
              fontSize: Constants.textFont,
            ),
          ),
        ),
      );
    }
    SizedBox(height: 8.0);
    // Add numbers and star
    for (int row = 0; row < 5; row++) {
      for (int colIdx = 0; colIdx < columns.length; colIdx++) {
        final numbers = columns[colIdx]['numbers'] as List;
        Widget child;
        Color cellColor = const Color(0xFFa5a5a5);
        bool isStarCell = colIdx == 2 && row == 2;
        bool isNumberCell = !isStarCell && numbers[row] != null;

        if (isStarCell) {
          cellColor = Constants.secondColor;
          child = Center(
            child: FaIcon(
              FontAwesomeIcons.solidStar,
              color: Colors.white,
              size: 20,
            ),
          );
        } else if (isNumberCell) {
          if (clicked[colIdx][row]) {
            cellColor = Constants.secondColor;
          }
          child = InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: () {
              setState(() {
                clicked[colIdx][row] = !clicked[colIdx][row];
              });
            },
            child: Center(
              child: Text(
                numbers[row].toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color:
                      clicked[colIdx][row]
                          ? Constants.textColor
                          : Colors.black, // <-- updated line
                ),
              ),
            ),
          );
        } else {
          child = const SizedBox.shrink();
        }
        gridItems.add(
          Container(
            decoration: BoxDecoration(
              color: cellColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: child,
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.stretch, // Ensures children take full width
      children: [
        GridView.count(
          crossAxisCount: 5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.0,
          mainAxisSpacing: 6.0,
          crossAxisSpacing: 8.0,
          padding: EdgeInsets.zero, // <-- Remove default padding
          children: gridItems,
        ),
        const SizedBox(height: 2.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: clearClicked,
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.secondColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 2.0,
                ),
              ),
              child: const Text('Clear', style: TextStyle(fontSize: 18.0)),
            ),
          ],
        ),
      ],
    );
  }
}
