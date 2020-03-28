// 掛け金を入力して決定ボタンを押すと始まる
function betPoint(){
  // 入力された掛け金を取得
  var bet = document.getElementById('betBox').value;
  // 数値へ変換
  bet = Number(bet);
  // console.log(bet);
  
  //所持金を取得
  var oldPoint = document.getElementById('oldPoint');
  oldPoint = Number(oldPoint.innerText);
  // console.log(oldPoint);
  
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
    
    info1.appendChild(text1);
    
    var info2 = document.createElement('p');
    info2.appendChild(text2);
    info2.setAttribute('class','info2');
    
    var listsElement = document.getElementById("info");
    listsElement.appendChild(info1);
    listsElement.appendChild(info2);
    
    var shuffled = deckCreate();
    deal(shuffled);
    
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
  
  return shuffled;
  
  
}

function deal(shuffled){
  //Aがあっても1として扱ったときの各合計値
  var player = 0;
  var dealer = 0;
  
  //Aがあったときに11として扱ったときの各合計値
  //0のときは存在しないものとして扱う
  var playerA = 0;
  var dealerA = 0;
  
  var pB = false;    //プレイヤーがBlackJackかどうか
  var dB = false;    //ディーラーがBlackJackかどうか
  
  var top; //デッキトップの配列番号
  
  // プレイヤーがヒットした回数
  var hp = document.createElement('span');
  hp.setAttribute('id','hp');
  var hpt =document.createTextNode("0");
  hp.appendChild(hpt);
  listsElement = document.getElementById("info");
  listsElement.appendChild(hp);
  
  //playerに配られた2枚のカードの値
  for (var i = 0; i < 2; i++){
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
    
    // プレイヤーに配られた1枚目のカード
    var pc1 = document.createElement('span');
    pc1.setAttribute('class','pc1');
    var text1 =document.createTextNode(shuffled[0]);
    pc1.appendChild(text1);
    var listsElement = document.getElementById("deal-player");
    listsElement.appendChild(pc1);
    
    // プレイヤーに配られた2枚目のカード
    var pc2 = document.createElement('span');
    pc2.setAttribute('class','pc2');
    var text2 =document.createTextNode(shuffled[1]);
    pc2.appendChild(text2);
    listsElement = document.getElementById("deal-player");
    listsElement.appendChild(pc2);
    
    // プレイヤーに配られた2枚のカードの合計
    var ps = document.createElement('p');
    ps.setAttribute('id','ps');
    var text3 =document.createTextNode("　合計　" +playerA);
    ps.appendChild(text3);
    listsElement = document.getElementById("deal-player");
    listsElement.appendChild(ps);
    
    // プレイヤーに配られた2枚のカードの合計をviewに保存（Aを11としたとき）
    var vpa = document.createElement('span');
    vpa.setAttribute('id','vpa');
    var vpat =document.createTextNode(playerA);
    vpa.appendChild(vpat);
    listsElement = document.getElementById("info");
    listsElement.appendChild(vpa);
    
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
    
    ps = document.createElement('p');
    ps.setAttribute('id','ps');
    text3 =document.createTextNode("　合計　" +player);
    ps.appendChild(text3);
    listsElement = document.getElementById("deal-player");
    listsElement.appendChild(ps);
    
    // プレイヤーに配られた2枚のカードの合計をviewに保存（Aを11としていないとき）
    var vp = document.createElement('span');
    vp.setAttribute('id','vp');
    var vpt =document.createTextNode(player);
    vp.appendChild(vpt);
    listsElement = document.getElementById("info");
    listsElement.appendChild(vp);
  }
  else
  {
    console.log("プレイヤー　" + shuffled[0] + "　+　" + shuffled[1] + "　=　" + player + "　or　" + playerA);
    
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
    
    ps = document.createElement('p');
    ps.setAttribute('id','ps');
    text3 =document.createTextNode("　合計　" + player + "　or　" + playerA);
    ps.appendChild(text3);
    listsElement = document.getElementById("deal-player");
    listsElement.appendChild(ps);
    
    vpa = document.createElement('span');
    vpa.setAttribute('id','vpa');
    vpat =document.createTextNode(playerA);
    vpa.appendChild(vpat);
    listsElement = document.getElementById("info");
    listsElement.appendChild(vpa);
    
    vp = document.createElement('span');
    vp.setAttribute('id','vp');
    vpt =document.createTextNode(player);
    vp.appendChild(vpt);
    listsElement = document.getElementById("info");
    listsElement.appendChild(vp);
  }

  if (dealerA == 21)  //BlackJack（2枚のカードでBlackJackになったとき。一番強い手）
  {
    console.log("dealer　" + shuffled[2]);
    dB = true;
    
    var dc1 = document.createElement('span');
    dc1.setAttribute('class','dc1');
    text3 = document.createTextNode(shuffled[2]);
    dc1.appendChild(text3);
    var listsElementd = document.getElementById("deal-dealer");
    listsElementd.appendChild(dc1);
    
    var dc2 = document.createElement('span');
    dc2.setAttribute('class','dc2');
    var text4 = document.createTextNode('?');
    dc2.appendChild(text4);
    var listsElementd1 = document.getElementById("deal-dealer");
    listsElementd1.appendChild(dc2);
    
    // ディーラーに配られた2枚のカードの合計
    var ds = document.createElement('p');
    ds.setAttribute('id','ds');
    var text5 =document.createTextNode("　合計　" +dealerA);
    ds.appendChild(text5);
    listsElement = document.getElementById("deal-dealer");
    listsElement.appendChild(ds);
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
    
    dc2 = document.createElement('span');
    dc2.setAttribute('class','dc2');
    text4 = document.createTextNode('?');
    dc2.appendChild(text4);
    listsElementd1 = document.getElementById("deal-dealer");
    listsElementd1.appendChild(dc2);
  }
  var hp = 0;
  
}

// HiTしたとき
function hit(){
  
  var shuffled = deckCreate();
  var playerMax = 0;  //playerとplayerAの大きい方
  var hd = 0;         //DealerのHIT数の初期化（ShowHandメソッドのため） 
  
  //現在のヒット数を取得
  var oldhp = document.getElementById('hp');
  oldhp = Number(oldhp.innerText);
  
  //変動後の所持ポイントのタグを作成する
  var newList = document.createElement('hp');
  newList.setAttribute('id','hp');
  
  //ヒット数をプラス1する
  var newhp = document.createTextNode(oldhp+1);
  
  var oldList = document.getElementById('hp');
  
  newList.appendChild(newhp);
  
  var parentNode = oldList.parentNode;
  
  parentNode.replaceChild(newList,oldList);
}


