import 'package:bridgestate/state/bridge_controller.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_variables.dart';
import 'package:grateful_notes/modules/recaps/controllers/recap_inputs.dart';
import 'package:grateful_notes/modules/recaps/controllers/recap_variables.dart';
import 'package:grateful_notes/modules/recaps/data/recap_model.dart';
import 'package:logger/logger.dart';

class RecapController extends BridgeController {
  final BridgeState state;

  RecapController(this.state);
  RecapInput get _ri => RecapInput(state);
  RecapVariables get _rv => RecapVariables(state);
  GratitudeVariables get _gv => GratitudeVariables(state);

  createNew() => _ri.onRecapModelChanged(RecapModel.createNew());

  getNumberOfMoments(int month) {
    return _gv.allGratitudes
        .where((element) => element.date.month == month)
        .length;
  }

  getMostCommonWord(int month) {
    List data = _gv.allGratitudes
        .where((element) => element.date.month == month)
        .toList()
        .map((e) => e.texts.first)
        .toList();
    Map counter = {};

    for (String s in data) {
      s.split(" ").forEach((_) {
        if (!stopWords.contains(_.toLowerCase())) {
          if (counter.keys.contains(_)) {
            counter[_] += 1;
          } else {
            counter[_] = 1;
          }
        }
      });
    }
    int value = 0;

    counter.forEach((k, v) {
      if (v > value) {
        value = v;
        // _ri.onRecapModelChanged(_rv.currentRecap!.copyWith(mostCommonWord: k));
        Logger().i(k);
      }
    });
  }

  @override
  void dispose() {}

  @override
  void initialise() {
    getNumberOfMoments(DateTime.january);
  }
}

List stopWords = [
  "i",
  "me",
  "my",
  "myself",
  "we",
  "our",
  "ours",
  "ourselves",
  "you",
  "your",
  "yours",
  "yourself",
  "yourselves",
  "he",
  "him",
  "his",
  "himself",
  "she",
  "her",
  "hers",
  "herself",
  "it",
  "its",
  "itself",
  "they",
  "them",
  "their",
  "theirs",
  "themselves",
  "what",
  "which",
  "who",
  "whom",
  "this",
  "that",
  "these",
  "those",
  "am",
  "is",
  "are",
  "was",
  "were",
  "be",
  "been",
  "being",
  "have",
  "has",
  "had",
  "having",
  "do",
  "does",
  "did",
  "doing",
  "a",
  "an",
  "the",
  "and",
  "but",
  "if",
  "or",
  "because",
  "as",
  "until",
  "while",
  "of",
  "at",
  "by",
  "for",
  "with",
  "about",
  "against",
  "between",
  "into",
  "through",
  "during",
  "before",
  "after",
  "above",
  "below",
  "to",
  "from",
  "up",
  "down",
  "in",
  "out",
  "on",
  "off",
  "over",
  "under",
  "again",
  "further",
  "then",
  "once",
  "here",
  "there",
  "when",
  "where",
  "why",
  "how",
  "all",
  "any",
  "both",
  "each",
  "few",
  "more",
  "most",
  "other",
  "some",
  "such",
  "no",
  "nor",
  "not",
  "only",
  "own",
  "same",
  "so",
  "than",
  "too",
  "very",
  "s",
  "t",
  "can",
  "will",
  "just",
  "don",
  "should",
  "now",
  "I'm",
  "things"
];
