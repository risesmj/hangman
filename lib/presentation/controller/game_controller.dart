import 'dart:math';

import 'package:diacritic/diacritic.dart';
import 'package:flutter/cupertino.dart';
import 'package:hangman/core/constants.dart';
import 'package:hangman/domain/entities/letter_entity.dart';

class GameController {
  List<LetterEntity> listLetter = [];
  bool menuInitialActive = true;
  bool endGame = false;
  int wrongs = 0;
  List<String> lastWords = [];
  List<String> lastLetters = [];
  bool isWinner = false;

  TextEditingController ctrlInputLetter = TextEditingController(
    text: "",
  );
  FocusNode focusNode = FocusNode();

  startGame() {
    menuInitialActive = false;
    endGame = false;
    isWinner = false;
    wrongs = 0;
    lastLetters.clear();
    _sortNewWord();
  }

  _sortNewWord() {
    if (lastWords.length == GameConstants.words.length) {
      lastWords.clear();
    }

    String newWord = "";
    listLetter.clear();

    do {
      newWord =
          GameConstants.words[Random().nextInt(GameConstants.words.length)];
    } while (lastWords.where((e) => e == newWord).isNotEmpty);

    lastWords.add(newWord);

    for (int i = 0; i < newWord.length; i++) {
      listLetter.add(
        LetterEntity(
          letter: newWord[i],
        ),
      );
    }
  }

  sendLetter(String newLetter) {
    _checkLetterInWord(newLetter);
    _checkEndGame();
    ctrlInputLetter.clear();
    focusNode.requestFocus();
  }

  _normalizeLetter(String letter) =>
      removeDiacritics(letter).toLowerCase().trim();

  _checkLetterInWord(String letter) {
    if (letter.isEmpty) return;

    //remove accents, ç and other characters specials
    letter = _normalizeLetter(letter);

    if (GameConstants.letterValid.where((s) => s == letter).isEmpty) return;

    //verifiy if inputed previously
    if (lastLetters.where((element) => element == letter).isNotEmpty) return;

    lastLetters.add(letter);

    //find all index letter in word
    var listFinded = listLetter
        .where(
          (element) => _normalizeLetter(element.letter) == letter,
        )
        .toList();

    //if finded, enable all index, if not, increment wrongs +1
    if (listFinded.isNotEmpty) {
      for (LetterEntity l in listFinded) {
        l.enable = true;
      }
    } else {
      _incrementWrongs();
    }
  }

  _incrementWrongs() {
    if ((wrongs + 1) < 12) {
      wrongs++;
    }
  }

  _checkEndGame() {
    if (wrongs >= 11) {
      endGame = true;
      return;
    }

    if (listLetter.where((element) => !element.enable).isEmpty) {
      endGame = true;
      isWinner = true;
      return;
    }
  }

  String getLastLettersFormatted() => lastLetters
      .toString()
      .replaceAll(
        "[",
        "",
      )
      .replaceAll(
        "]",
        "",
      )
      .toUpperCase();

  getTextEndGame() =>
      "Você ${isWinner ? 'acertou' : 'errou'} a palavra ${lastWords.last}";
}
