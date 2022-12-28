import 'package:flutter/material.dart';
import 'package:hangman/domain/entities/letter_entity.dart';

class LetterTile extends StatefulWidget {
  final LetterEntity entity;

  const LetterTile({required this.entity, super.key});

  @override
  State<LetterTile> createState() => _LetterTileState();
}

class _LetterTileState extends State<LetterTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        4,
      ),
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: const Duration(
              milliseconds: 600,
            ),
            key: ValueKey(widget.entity.enable),
            child: Text(
              widget.entity.enable ? widget.entity.letter.toUpperCase() : "",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 3,
            width: 26,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
