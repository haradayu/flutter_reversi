
class GameManager{
  static const width = 8;
  static const height = 8;
  static const blank = 0;
  static const black = 1;
  static const white = 2;
  List<List<int>> board = List.generate(width, (_) => List.generate(height, (_) => blank));
  int turn = black;
  int passCount = 0;

  GameManager(){
    board[3][3] = black;
    board[4][4] = black;
    board[3][4] = white;
    board[4][3] = white;
  }



  int getCellStatus(x,y){
    return board[x][y];
  }
  int getTurn(){
    return turn;
  }
  int getScore(turn){
    int score = 0;
    for(int i=0;i<width;i++){
      for(int j=0;j<height;j++){
        if(board[i][j] == turn){
          score += 1;
        }
      }
    }
    return score;
  }
  bool detectPass(){
    if(getNumOfValidCell(this.turn) == 0){
      this.passCount++;
      return true;
    }else{
      passCount = 0;
    }
    return false;
  }
  int getPassCount(){
    return passCount;
  }
  void changeTurn(){
    if(this.turn==black){
      this.turn = white;
    }else{
      this.turn = black;
    }
  }

  int getNumOfValidCell(int turn){
    int numOfValidCell = 0;
    for(int i=0;i<width;i++){
      for(int j=0;j<height;j++){
        if(detectValid(i, j, turn) == true){
          numOfValidCell++;
        }
      }
    }
    return numOfValidCell;
  }

  bool putStone(x, y){
    var isValid = detectValid(x, y, this.turn,changeStone: true);
    if(isValid) {
      board[x][y] = turn;
      if(this.turn==black){
        this.turn = white;
      }else{
        this.turn = black;
      }
    }
    return isValid;
  }

  bool detectValid(x, y, turn,{changeStone = false}){
    if (board[x][y] != blank){
      return false;
    }
    bool isValid = false;
    var deltaArray = [[1,0],[-1,0],[0,1],[0,-1],[1,1],[-1,-1],[1,-1],[-1,1]];
    deltaArray.forEach((delta){
      if (0<revers(x + delta[0], y + delta[1], delta[0], delta[1], turn, changeStone: changeStone)) isValid = true;
    });
    return isValid;
  }

  int revers(x,y,deltaX,deltaY,player, {changeStone = true}){
    print("$x,$y,$deltaX,$deltaY");
    if (!(0<=x && x<width && 0<=y && y<height)){
      return -width;
    }
    if(board[x][y] == blank){
      return -width;
    }
    if(board[x][y] == player){
      return 0;
    }
    int ret = revers(x + deltaX, y + deltaY, deltaX, deltaY, player);
    if(0 <= ret && changeStone == true){
      board[x][y] = player;
    }
    return ret + 1;
  }


}