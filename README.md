# EHTR - Extensible Template Engine for Ruby

ノンプログラマに優しい

* HTMLタグの属性を使うのでDOM構造や表示が崩れない
* テンプレートファイルへのプレゼンテーションロジックの混入を抑制

拡張しやすい

* 独自ハンドラをRubyの継承を使って簡単に追加できる

## 例

    <h1 eter="var" eter:name="title">TITLE(DUMMY)</h1>
    <div eter="var" eter:name="content"></div>
    <ul eter="loop" eter:name="links">
        <li><a href="#dummy" $href="__key__" eter="var" eter:name="__value__">LINK</a></li>
    </ul>

    eter = Eter::Template.new(tmpl)
    eter.output(title: 'Title',
                content: 'Content',
                links: {'http://www.google.com/' => 'Google',
                        'http://www.yahoo.co.jp/' => 'Yahoo! JAPAN'})

    <h1>Title</h1>
    <div>Content</div>
    <ul>
        <li><a href="http://www.google.com/">Google</a></li>
        <li><a href="http://www.yahoo.co.jp/">Yahoo! JAPAN</a></li>
    </ul>

## 独自ハンドラによる拡張

独自ハンドラを作成することで、テンプレートファイル中のプレゼンテーションロジックへの埋め込みを減らし、デザイナーの負担を減らすことができます。
独自ハンドラはRubyの継承を使って簡単に追加することができます。

    <div eter="var" eter:name="no" eter:value="1"></div>
    <dl eter="loop" eter:name="items">
        <dt><span class="no"><eter:var name="no"></span>:<span class="name"><eter:var name="__key__"></span></dt>
        <dd><span class="description"><eter:var name="__value__"></span></dd>
        <div eter="var" eter:name="no" eter:op="+" eter:value="1"></div>
    </dl>

独自ハンドラ item* を追加して変数処理やカウントアップをテンプレートから分離

    <dl eter="items">
        <dt><span class="no" eter="itemno">1</span>:<span class="name" eter="itemname">DUMMY</span></dt>
        <dd><span class="description" eter="itemdescription">DUMMY</span></dd>
    </dl>

これらは以下のようなハンドラクラスを作成するだけです。

    # items
    Eter::Node::Handler::Items
    # itemno
    Eter::Node::Handler::Itemno
    # itemname
    Eter::Node::Handler::Itemname
    # itemdescription
    Eter::Node::Handler::Itemdescription

## 組み込みハンドラ

### Var

変数を取得したりセットしたりできます。

    <span eter="var" name="hoge">変数hogeの内容を表示</span>

valueパラメータを指定すると値をセットします。この時、出力には表示されません。

    <span eter="var" eter:name="hoge" eter:value="HOGE"></span>

また、変数の内容についてopパラメータを使うことで変数に対して処理を行うことができます。

    <!-- 変数countの値に1を加算 -->
    <span eter="var" eter:name="count" eter:op="+" eter:value="1"></span>

出力時にエスケープを行う場合は、escapeパラメータを設定します。

    <p eter="message" eter:escape="html">message変数の値をHTMLエスケープして表示します。</p>

### Loop

繰り返しを行います。

    <div eter="loop" eter:name="items">
       <p eter="var" eter:name="__value__">DUMMY</p>
    </div>

### If

分岐選択制御を行います。

    <div eter="if" eter:name="hoge">
      変数hogeの値が存在すればこの内容を表示
      ここで'存在する'とは nil でなく、配列やハッシュの場合は空でないこと
    </div>

    <div eter="if" eter:name="hoge" eter:eq="HOGE">
      変数hogeの値が'HOGE'ならこの内容を表示
    </div>

## 属性の書き換え

Aタグのhrefを設定したい場合など、タグの属性を変数の値で書き換えることができます。

    <a href="#dummy" set:href="url">TEXT</a>

この場合、href属性にurl変数の値を設定します。なお、この値は自動的にHTMLエスケープされます。

## タグの除去

deletionパラメータを指定すると、そのタグ自体は出力に含まれなくなります。

    <div eter="var" eter:name="hoge">hogeの値<div>

    <div>HOGE</div>

    <div eter="var" eter:name="hoge" eter:deletion="1">hogeの値<div>

    HOGE

## Contributing to ETER

Fork, fix, then send me a pull request.

## Copyright

Copyright(c) 2013 Yuichi Takeuchi, released under the MIT license
