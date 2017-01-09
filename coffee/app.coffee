$ ->
  app.initialize()

  jankenhand = ['rock', 'scissors', 'paper']

window.app =
  initialize: ->
    @setBind()
    @pchand = null # pcの手をグローバル変数として入れる null(カラ)
    @myhand = null #自分で出した手を入れる　rock = 0 scissors = 1 paper = 2 を入れる
    #pchand, myhandともに数字でじゃんけんの手を管理
    @life = 3
    @lifeDecrase = 1
    @lifePc = 3

  setBind: ->
 #   @checklife() #ここで読み込んでも一回しか読み込まれないのでチェックできない
 #   console.log 'checking...'

    $('#rock').click =>
      @clickprocess 'rock'

    $('#scissors').click =>
      @clickprocess 'scissors'

    $('#paper').click =>
      @clickprocess 'paper'

  checklife: -> #lifeが0でないかをチェックする
    if @life is 0 or @lifePc is 0
      @showGameOver()
  
  showGameOver: -> 
    if @life is 0 #lifeが0の時の処理　モータルを表示
      $('.overlay').css 'visibility', 'visible'
      $('#lastmessage').html "あなたの負け"
      $('#lastpic').attr 'src', 'img/lose.png'
      $('#replay-button').click =>
        @replay()
      $('#quit-button').click =>
        @closeApp
    else
      $('.overlay').css 'visibility', 'visible'
      $('#lastmessage').html "あなたの勝ち"
      $('#lastpic').attr 'src', 'img/win.png'
      $('#replay-button').click =>
        @replay()
      $('#quit-button').click =>
        @closeApp()
    
  replay: -> #もう一度遊ぶボタンを押した時の処理
    console.log 'replay'
    console.log @life
    console.log @lifePc
    @life = 3
    @lifePc = 3
    $('#result').html 'じゃんけん...'
    $('.overlay').css 'visibility', 'hidden'
    num = 1
    while num <= 3
      $("""#myHeart#{num}""").css 'visibility', 'visible'
      $("""#pcHeart#{num}""").css 'visibility', 'visible'
      num++
 
  closeApp: -> #アプリを終了する
    console.log 'close'
    window.open('about:blank','_self').close()

  clickprocess: (hand) -> #ボタンが押された時の処理
    $('#picBoxMe').html $("""<img class="pic" src="img/#{hand}.png">""")
    $('.janken_picBox').css 'border', 'none'
    @randamHand()
    @myhand = @myhandConvertTonum hand
    @judge()

  myhandConvertTonum: (hand) -> #グー、チョキ、パーを数字として管理
    if hand is 'rock'
      return  0
    else if hand is 'scissors'
      return 1
    else
      return 2

  randamHand: -> #pcの手を、ランダムで出力
    jankenhand = ['rock', 'scissors', 'paper']
  #  pchand = jankenhand[Math.floor(Math.random()*jankenhand.length)] #ランダムでpchandの手を選ぶ
    pchand = jankenhand[ _.random(0, 2)] #アンダースコアjsの書き方
    if pchand is 'rock'
      @pchand = 0
    else if pchand is 'scissors'
      @pchand = 1
    else 
      @pchand = 2

    $('#picBoxPc').html $("""<img class="pic" src="img/#{pchand}.png">""")

  judge: -> #勝ち負け判定
     hands = @myhand - @pchand #myhandとpchandの差分を利用
     if @pchand is @myhand #あいこの場合
       $('#result').html 'あいこ'
     else if (hands is -1) or (hands is 2) #myhand とpchandの差分を計算　自分が勝つ場合
       $('#result').html '勝ち'
       @heartremovePc()
     else
       $('#result').html '負け'　#自分が負ける場合
       @heartRemoveMe()
  
  heartRemoveMe: -> #自分のライフを減らす
    $("""#myHeart#{@life}""").css 'visibility', 'hidden'
    @life = @life - @lifeDecrase
    @checklife()
    console.log @life

  heartremovePc: -> #pcのライフを減らす
    $("""#pcHeart#{@lifePc}""").css 'visibility', 'hidden'
    @lifePc = @lifePc - @lifeDecrase
    @checklife()
    console.log @lifePc
