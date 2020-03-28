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
  var listsElement = document.getElementById("info");
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
    show_player_deal(shuffled,player,playerA);
    // プレイヤーに配られた2枚のカードの合計を表示
    var psvt = document.createElement('p');
    psvt.setAttribute('id','psv');
    var text3 =document.createTextNode("　合計　"+ playerA);
    psvt.appendChild(text3);
    listsElement = document.getElementById("deal-player-sum");
    listsElement.appendChild(psvt);
  }
  else if (playerA == 0)
  {
    show_player_deal(shuffled,player,playerA);
    // プレイヤーに配られた2枚のカードの合計を表示
    psvt = document.createElement('p');
    psvt.setAttribute('id','psv');
    text3 =document.createTextNode("　合計　"+ player);
    psvt.appendChild(text3);
    listsElement = document.getElementById("deal-player-sum");
    listsElement.appendChild(psvt);
  }
  else
  {
    show_player_deal(shuffled,player,playerA);
    // プレイヤーに配られた2枚のカードの合計を表示
    psvt = document.createElement('p');
    psvt.setAttribute('id','psv');
    text3 =document.createTextNode("　合計　"+ player +"　or　" + playerA);
    psvt.appendChild(text3);
    listsElement = document.getElementById("deal-player-sum");
    listsElement.appendChild(psvt);
  }

  if (dealerA == 21)  //BlackJack（2枚のカードでBlackJackになったとき。一番強い手）
  {
    show_dealer_deal(shuffled,dealer,dealerA);
    // ディーラーに配られた2枚のカードの合計
    var dst = document.createElement('p');
    dst.setAttribute('id','dst');
    var text5 =document.createTextNode("　合計　"+ dealerA);
    dst.appendChild(text5);
    listsElement = document.getElementById("deal-dealer-sum");
    listsElement.appendChild(dst);
  }
  else if(dealerA == 0)
  {
    show_dealer_deal(shuffled,dealer,dealerA);
    dst = document.createElement('p');
    dst.setAttribute('id','dst');
    text5 =document.createTextNode("　合計　"+ dealer);
    dst.appendChild(text5);
    listsElement = document.getElementById("deal-dealer-sum");
    listsElement.appendChild(dst);
  }
  else{
    show_dealer_deal(shuffled,dealer,dealerA);
    dst = document.createElement('p');
    dst.setAttribute('id','dst');
    text5 =document.createTextNode("　合計　"+ dealer +"　or　" + dealerA);
    dst.appendChild(text5);
    listsElement = document.getElementById("deal-dealer-sum");
    listsElement.appendChild(dst);
  }
}

function show_player_deal(shuffled,player,playerA){
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
  
  // プレイヤーに配られた2枚のカードの合計をviewに保存（hidden）（Aを11としたとき）
  var psa = document.createElement('span');
  psa.setAttribute('id','psa');
  var psat =document.createTextNode(playerA);
  psa.appendChild(psat);
  listsElement = document.getElementById("deal-player-sum");
  listsElement.appendChild(psa);
  
  // プレイヤーに配られた2枚のカードの合計をviewに保存（hidden）（Aを11としていないとき）
  var ps = document.createElement('span');
  ps.setAttribute('id','ps');
  var pst =document.createTextNode(player);
  ps.appendChild(pst);
  listsElement = document.getElementById("deal-player-sum");
  listsElement.appendChild(ps);
}

function show_dealer_deal(shuffled,dealer,dealerA){
  var dc1 = document.createElement('span');
  dc1.setAttribute('class','dc1');
  var text3 = document.createTextNode(shuffled[2]);
  dc1.appendChild(text3);
  var listsElementd = document.getElementById("deal-dealer");
  listsElementd.appendChild(dc1);
  
  var dc2 = document.createElement('span');
  dc2.setAttribute('class','dc2');
  var text4 = document.createTextNode('?');
  dc2.appendChild(text4);
  var listsElementd1 = document.getElementById("deal-dealer");
  listsElementd1.appendChild(dc2);
  
  var ds = document.createElement('span');
  ds.setAttribute('id','ds');
  var text6 =document.createTextNode(dealer);
  ds.appendChild(text6);
  var listsElement = document.getElementById("deal-dealer-sum");
  listsElement.appendChild(ds);
  
  var dsa = document.createElement('span');
  dsa.setAttribute('id','dsa');
  var text7 =document.createTextNode(dealerA);
  ds.appendChild(text7);
  listsElement = document.getElementById("deal-dealer-sum");
  listsElement.appendChild(dsa);
}

// HiTしたとき
function hit(){
  
  var shuffled = deckCreate();
  var playerMax = 0;  //playerとplayerAの大きい方
  
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
  
  //playerAの値を読み込む
  var player = document.getElementById('ps');
  player = Number(player.innerText);
  var playerA = document.getElementById('psa');
  playerA = Number(playerA.innerText);
  
  //ヒット数を読み込む
  //ヒット数+3する
  newhp = document.getElementById('hp');
  newhp = Number(newhp.innerText);
  var i = newhp + 3;
  
  if (playerA != 0) //今までカードのうち、Aを1枚11として扱ったとき
  {
    player += shuffled[i]; //以降のAは1になる
    playerA += shuffled[i]; //以降のAは1になる
    i += 1;

    //Aが11のときBUSTした場合
    if (playerA > 21)
    {
      //Aを1にし playerAはなくなりplayerになる
      playerA = 0;
      
      hit_card(shuffled,i,player,playerA);
    }
    //21のときは表示してループを抜ける
    else if (playerA == 21)
    {
      hit_card(shuffled,i,player,playerA);
    }
    //Aが11のとき、BUSTも21でもない場合
    else
    {
      hit_card(shuffled,i,player,playerA);
    }
  }
  else  //今までのカードのうち、Aがあっても1として扱ったとき
  {
    if (shuffled[i] != 1) //HITしたカードがAではないとき
    {
      player += shuffled[i];
      i += 1;

      if (player == 21)
      {
        hit_card(shuffled,i,player,playerA);
      }
      else if (player < 21)
      {
        hit_card(shuffled,i,player,playerA);
      }
      else if (player > 21)
      {
        hit_card(shuffled,i,player,playerA);
      }
    }
    else //HITしたカードがAのとき
    {
      //HITしたカードのAを1として扱うとき
      player += shuffled[i];
      i += 1;

      //HITしたカードのAを11として扱うとき
      playerA = player + 10;

      if (playerA > 21)   //playerAがBUSTのとき、playerのみ表示する
      {
        playerA = 0;    //干渉しないようにするため
        if (player == 21)
        {
           hit_card(shuffled,i,player,playerA);
        }
        else if (player < 21)
        {
           hit_card(shuffled,i,player,playerA);
        }
        else if (player > 21)
        {
           hit_card(shuffled,i,player,playerA);
        }
      }
      else  //playerAがBUSTしていないとき
      {
        if (playerA == 21)
        {
           hit_card(shuffled,i,player,playerA);
        }
        else
        {
           hit_card(shuffled,i,player,playerA);
        }
      }
    }
  }
}

function hit_card(shuffled,i,player,playerA){
  var pc3 = document.createElement('span');
  pc3.setAttribute('class','pc2');
  var text3 =document.createTextNode(shuffled[i]);
  pc3.appendChild(text3);
  var listsElement = document.getElementById("deal-player");
  listsElement.appendChild(pc3);
  
  //現在のplayerを取得
  var oldps = player;
  // oldps = Number(oldps.innerText);
  
  //変動後のplayerのタグを作成する
  var newList1 = document.createElement('ps');
  newList1.setAttribute('id','ps');
  
  //ヒット数をプラス1する
  var newps = document.createTextNode(oldps + shuffled[i]);
  var oldList1 = document.getElementById('ps');
  newList1.appendChild(newps);
  var parentNode1 = oldList1.parentNode;
  parentNode1.replaceChild(newList1,oldList1);
  
  //現在のplayerAを取得
  var oldpsa = playerA;
  // oldpsa = Number(oldpsa.innerText);
  
  //変動後のplayerのタグを作成する
  var newList2 = document.createElement('psa');
  newList2.setAttribute('id','psa');
  
  //ヒット数をプラス1する
  var newpsa = document.createTextNode(oldpsa + shuffled[i]);
  var oldList2 = document.getElementById('psa');
  newList2.appendChild(newpsa);
  var parentNode2 = oldList2.parentNode;
  parentNode2.replaceChild(newList2,oldList2);
}
