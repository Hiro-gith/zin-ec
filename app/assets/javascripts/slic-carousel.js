$(document).on('turbolinks:load', function(){
  $('.slick1').slick({
    autoplay:false,   //自動再生
    infinite: true,   //スライドのループ有効化
    
    slidesToShow: 5,    //表示するスライドの数
    slidesToScroll: 5,   //スクロールで切り替わるスライドの数
    
    dots:true,
     
  });
});
