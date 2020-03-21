// 掛け金を入力して決定ボタンを押すと始まる
function betPoint(){
  // 入力された掛け金を取得
  var bet = document.getElementById('betBox').value;
  // 数値へ変換
  bet = Number(bet);
  console.log(bet);
  
  //所持金を取得
  var oldPoint = document.getElementById('oldPoint');
  oldPoint = Number(oldPoint.innerText);
  console.log(oldPoint);
  
  // infoのpタグを作成
  var info1 = document.createElement('p');
  
  if(bet>0 && oldPoint>bet){
    //変動後の所持ポイントのタグを作成する
    var newList = document.createElement('span');
    newList.setAttribute('id','newPoint');
    
    // /所持ポイントから掛け金を減らす
    var newPoint = document.createTextNode(oldPoint-bet);
    
    var oldList = document.getElementById('oldPoint');
    
    // 減らした所持金を作成したpタグに入れる
    newList.appendChild(newPoint);
    
    var parentNode = oldList.parentNode;
    
    // 所持金を更新する
    parentNode.replaceChild(newList,oldList);
    
    var text1 = document.createTextNode(bet+'ポイント賭けました。ゲームを開始します!');
    var text2 = document.createTextNode('プレイヤーとディーラーに2枚ずつカードが配られました');
    
    var text3 = document.createTextNode('プレイヤー');
    var text4 = document.createTextNode('ディーラー');
    
    info1.appendChild(text1);
    
    var info2 = document.createElement('p');
    info2.appendChild(text2);
    info2.setAttribute('class','info2');
    
    var textp = document.createElement('p');
    textp.appendChild(text3);
    textp.setAttribute('class','textp');
    
    var textd = document.createElement('p');
    textd.appendChild(text4);
    textd.setAttribute('class','textd');
    
    var listsElement = document.getElementById("info");
    listsElement.appendChild(info1);
    listsElement.appendChild(info2);
    
    var listsElementP = document.getElementById("deal-player");
    listsElementP.appendChild(textp);
    
    var listsElementD = document.getElementById("deal-dealer");
    listsElementD.appendChild(textd);
    deckCreate();
    
  }else{
    text1 = document.createTextNode('掛け金が足りていません');
    info1.appendChild(text1);
    listsElement = document.getElementById("info");
    listsElement.appendChild(info1);
  }
}

// デッキ作成の関数
function deckCreate(){
  var d = 8*13;
  var number = [];
  
  for(var i = 0; i < d; i++){
    number[i] = i % 10 + 1;
  }
  
  // デッキをシャッフルする
  var len = number.length;
  while(len > 0){
    var rnd = Math.floor(Math.random() * len);
    var tmp = number[len-1];
    number[len-1] = number[rnd];
    number[rnd] = tmp;
    len-=1;
  }
  
  // シャッフルしたデッキの変数名を変える
  var shuffled = number;
  
  // for(var i = 0; i < d; i++){
  // console.log(shuffled[i]);
  // }
  
  //Aがあっても1として扱ったときの各合計値
  var player = 0;
  var dealer = 0;
  
  //Aがあったときに11として扱ったときの各合計値
  //0のときは存在しないものとして扱う
  var playerA = 0;
  var dealerA = 0;
  
  var pB = false;    //プレイヤーがBlackJackかどうか
  var dB = false;    //ディーラーがBlackJackかどうか

  //Splitしたとき
  var pB1 = false;    //プレイヤー1がBlackJackかどうか
  var pB2 = false;    //プレイヤー2がBlackJackかどうか
  
  var top; //デッキトップの配列番号
  
  //playerに配られた2枚のカードの値
  for (i = 0; i < 2; i++){
    player += shuffled[i];  //Aがあっても1として扱ったときの値
  
    //Aを1枚11にするときの値
    //Aがないときの値
    if (shuffled[i] != 1){
      playerA += shuffled[i];
    }
    //Aを11としたときの値
    else{  
      playerA += shuffled[i];
      playerA += 10; //Aを+10して11にする
  
      if (playerA > 21) //(2枚ともAのとき、片方しか11にできない）
      {
          playerA -= 10;
      }
    }
  }
  
  top = i;
  //1枚目と2枚目が両方ともAではないなら、playerA = 0にする（表示したくないため）
  if (shuffled[0] != 1 && shuffled[1] != 1)
  {
      playerA = 0;
  }
  
  //dealerに配られた2枚のカードの値
  //Aを1にするまたはAがないときの各値
  for (i = top; i < (top + 2); i++)
  {
    dealer += shuffled[i];

    //Aを11にするときの各値
    if (shuffled[i] != 1)
    {
      dealerA += shuffled[i];
    }
    else  //1枚のAを11としたときの各値
    {
      dealerA += shuffled[i];
      dealerA += 10; //Aを+10して11にする

      if (dealerA > 21) //(2枚ともAのとき、片方しか11にできない）
      {
          dealerA -= 10;
      }
    }
  }
  
  if (shuffled[2] != 1 && shuffled[3] != 1)
  {
    dealerA = 0;
  }
  
  //プレイヤーとディーラーの2枚のカードの表示
  if (playerA == 21)  //BlackJack（2枚のカードで21になったとき。一番強い手）
  {
    console.log("プレイヤー 　" + shuffled[0] + "　+　" + shuffled[1] + "　=　" + playerA);
    
    var pc1 = document.createElement('span');
    pc1.setAttribute('class','pc1');
    var text1 =document.createTextNode(shuffled[0]);
    pc1.appendChild(text1);
    var listsElement = document.getElementById("deal-player");
    listsElement.appendChild(pc1);
    
    var pc2 = document.createElement('span');
    pc2.setAttribute('class','pc2');
    var text2 =document.createTextNode(shuffled[1]);
    pc2.appendChild(text2);
    listsElement = document.getElementById("deal-player");
    listsElement.appendChild(pc2);
    
    pB = true;
  }
  else if (playerA == 0)
  {
    console.log("プレイヤー　" + shuffled[0] + "　+　" + shuffled[1] + "　=　" + player);
    
    pc1 = document.createElement('span');
    pc1.setAttribute('class','pc1');
    text1 =document.createTextNode(shuffled[0]);
    pc1.appendChild(text1);
    listsElement = document.getElementById("deal-player");
    listsElement.appendChild(pc1);
    
    pc2 = document.createElement('span');
    pc2.setAttribute('class','pc2');
    text2 =document.createTextNode(shuffled[1]);
    pc2.appendChild(text2);
    listsElement = document.getElementById("deal-player");
    listsElement.appendChild(pc2);
  }
  else
  {
    console.log("プレイヤー　" + shuffled[0] + "　+　" + shuffled[1] + "　=　" + player + "　or　" + playerA);
    
    var pc1 = document.createElement('span');
    pc1.setAttribute('class','pc1');
    var text1 =document.createTextNode(shuffled[0]);
    pc1.appendChild(text1);
    var listsElement = document.getElementById("deal-player");
    listsElement.appendChild(pc1);
    
    var pc2 = document.createElement('span');
    pc2.setAttribute('class','pc2');
    var text2 =document.createTextNode(shuffled[1]);
    pc2.appendChild(text2);
    var listsElement = document.getElementById("deal-player");
    listsElement.appendChild(pc2);
  }

  if (dealerA == 21)  //BlackJack（2枚のカードでBlackJackになったとき。一番強い手）
  {
    console.log("dealer　" + shuffled[2]);
    dB = true;
    
    var dc1 = document.createElement('span');
    dc1.setAttribute('class','dc1');
    var text3 = document.createTextNode(shuffled[2]);
    dc1.appendChild(text3);
    var listsElementd = document.getElementById("deal-player");
    listsElementd.appendChild(dc1);
  }
  else
  {
    console.log("dealer　" + shuffled[2]);
    dc1 = document.createElement('span');
    dc1.setAttribute('class','dc1');
    text3 = document.createTextNode(shuffled[2]);
    dc1.appendChild(text3);
    listsElementd = document.getElementById("deal-dealer");
    listsElementd.appendChild(dc1);
  }
  var hp = 0;
  return shuffled;
}

// HiTしたとき
function hit(shuffled,player,playerA, i, pB,hp){
  var playerMax = 0;  //playerとplayerAの大きい方
  var hd = 0;         //DealerのHIT数の初期化（ShowHandメソッドのため） 
  
  var shuffled = deckCreate();
  
  if (pB == false)   //BlackJackでないならHITできる
  {
    hp += 1;
  }
  console.log(hp)
}


