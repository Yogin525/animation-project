import 'package:get/get.dart';

class MatrixController extends GetxController {

//for animation
  RxBool isSelected = false.obs;
  RxDouble targetSize = 100.0.obs;
  RxBool isTopLeft = false.obs;
  void toggleSelection() {
    isSelected.value = !isSelected.value;
  }

  void toggleSize() {
    targetSize.value = targetSize.value == 100.0 ? 200.0 : 100.0;
  }
  void togglePosition(){
      isTopLeft.value = !isTopLeft.value;
  }





  /// for mateix
  RxList<List<int>> matrix = <List<int>>[].obs;
 var matrixSize = 5.obs; // Default matrix size
  var highlightedCells = <String>{}.obs;
  var tappedCells = <String>{}.obs;
  var selectedRow = (-1).obs;
  var selectedCol = (-1).obs;
  var tappedRow = (-1).obs;
  var tappedCol = (-1).obs;

  void updateMatrixSize(int newSize) {
    matrixSize.value = newSize;

    // Optional: reset highlights on size change
    highlightedCells.clear();
    selectedRow.value = -1;
    selectedCol.value = -1;
    tappedRow.value = -1;
    tappedCol.value = -1;
  }

  void selectCell(int row, int col) {
    selectedRow.value = row;
    selectedCol.value = col;
    tappedRow.value = row;
    tappedCol.value = col;

    tappedCells.add('$row,$col'); // Keep tapped cells for displaying '0'

    final matrix = matrixSize.value;
    final tappedRightEdge = col == matrix - 1;
    final tappedBottomEdge = row == matrix - 1;

    for (int r = 0; r < matrix; r++) {
      for (int c = 0; c < matrix; c++) {
        bool sameRowLeft = row == r && tappedRightEdge && c < col;
        bool sameRowRight = row == r && !tappedRightEdge && c > col;
        bool sameColAbove = col == c && tappedBottomEdge && r < row;
        bool sameColBelow = col == c && !tappedBottomEdge && r > row;
        bool onForwardDiagonal = (r - row) == (c - col) && r > row && c > col;

        bool onBackwardDiagonal = false;
        if (tappedBottomEdge && tappedRightEdge) {
          onBackwardDiagonal = (row - r) == (col - c) && r < row && c < col;
        } else if (tappedBottomEdge && !tappedRightEdge) {
          onBackwardDiagonal = (row - r) == (c - col) && r < row && c > col;
        } else if (tappedRightEdge) {
          onBackwardDiagonal = (r - row) == -(c - col) && r > row && c < col;
        }

        if (r == row && c == col ||
            sameRowLeft ||
            sameRowRight ||
            sameColAbove ||
            sameColBelow ||
            onForwardDiagonal ||
            onBackwardDiagonal) {
          highlightedCells.add('$r,$c');
        }
      }
    }
  }

  void clearHighlights() {
    highlightedCells.clear();
    tappedCells.clear();
    selectedRow.value = -1;
    selectedCol.value = -1;
    tappedRow.value = -1;
    tappedCol.value = -1;
  }

  void generateMatrix(int n) {
    List<List<int>> result = List.generate(n, (_) => List.filled(n, 0));
    int num = 1;
    int top = 0, bottom = n - 1;
    int left = 0, right = n - 1;

    while (top <= bottom && left <= right) {
      for (int i = right; i >= left; i--) {
        result[bottom][i] = num++;
      }
      bottom--;

      for (int i = bottom; i >= top; i--) {
        result[i][left] = num++;
      }
      left++;

      for (int i = left; i <= right; i++) {
        result[top][i] = num++;
      }
      top++;

      for (int i = top; i <= bottom; i++) {
        result[i][right] = num++;
      }
      right--;
    }

    matrix.value = result;
  }

  bool isPrime(int number) {
    if (number <= 1) return false;
    if (number == 2) return true;
    for (int i = 2; i <= number ~/ 2; i++) {
      if (number % i == 0) return false;
    }
    return true;
  }
}
