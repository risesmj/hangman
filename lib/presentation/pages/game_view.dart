import 'package:flutter/material.dart';
import 'package:hangman/presentation/controller/game_controller.dart';
import 'package:hangman/presentation/modal/end_game_modal.dart';
import 'package:hangman/presentation/modal/menu_modal.dart';
import 'package:hangman/presentation/widgets/letter_tile.dart';

class GameView extends StatefulWidget {
  final GameController controller = GameController();

  GameView({
    super.key,
  });

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildStick(),
                  _buildWord(),
                  _buildLastLetter(),
                ],
              ),
            ),
            if (widget.controller.menuInitialActive)
              MenuModal(
                onStart: () {
                  setState(() {
                    widget.controller.startGame();
                  });
                },
              ),
            if (widget.controller.endGame &&
                !widget.controller.menuInitialActive)
              EndGameModal(
                text: widget.controller.getTextEndGame(),
                onRetry: () {
                  setState(() {
                    widget.controller.startGame();
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  _buildStick() {
    return Column(
      children: [
        SizedBox(
          width: 200,
          height: 250,
          child: Image.asset(
            "assets/images/${widget.controller.wrongs}.png",
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            widget.controller.getLastLettersFormatted(),
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple),
          ),
        )
      ],
    );
  }

  _buildLastLetter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Informe uma letra",
          style: TextStyle(
            fontSize: 12,
            fontFamily: "press start2p regular",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 40,
          width: 50,
          child: TextFormField(
            readOnly: widget.controller.endGame,
            focusNode: widget.controller.focusNode,
            controller: widget.controller.ctrlInputLetter,
            keyboardType: TextInputType.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            onFieldSubmitted: (value) {
              setState(() {
                widget.controller.sendLetter(value);
              });
            },
            textAlign: TextAlign.center,
            maxLength: 1,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(4),
              counterText: "",
              fillColor: Colors.black,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildWord() {
    return Container(
      padding: const EdgeInsets.all(4),
      alignment: Alignment.center,
      child: Wrap(
        children: List.from(
          widget.controller.listLetter.map<LetterTile>(
            (e) => LetterTile(entity: e),
          ),
        ),
      ),
    );
  }
}
