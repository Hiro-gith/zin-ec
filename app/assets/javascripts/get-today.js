
  // 明日の日付を求めて返す
  function getToday() {
    var now = new Date();
    var mon = now.getMonth()+1; //１を足すこと
    var day = now.getDate()+1;
  
    //出力用
    var s = mon + "/" + day;
    return s;
  }
  
  // 明日の曜日を求めて返す
  function getYoubi() {
    var now = new Date();
    var you = (now.getDay()+1)%7; //曜日(0～6=日～土)
  
    //曜日の選択肢
    var youbi = new Array("日","月","火","水","木","金","土");
    //出力用
    var y =" (" + youbi[you] + ")"+ "お届け";
    return y;
  }
  
