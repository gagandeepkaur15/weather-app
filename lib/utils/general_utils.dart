//Method to capitalize first letter of any word
String capitalizeWord(String word) {
  return "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}";
}
