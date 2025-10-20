// Track added words with position
class AddedWord {
  final String word;
  final int lineNumber; // 1,2,3
  final int wordChipIndex; // original index in WordChips
  AddedWord(this.word, this.lineNumber, this.wordChipIndex);
}
