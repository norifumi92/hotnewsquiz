import 'package:flutter/material.dart';
import 'package:hotnewsquiz/components/my_drawer.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  Future<String> _loadMarkdownAsset() async {
    return markdownText;
  }

  //scaffold key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.purple.shade800,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: _openDrawer,
          ),
        ),
        drawer: const MyDrawer(),
        body: FutureBuilder<String>(
          future: _loadMarkdownAsset(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Markdown(data: snapshot.data ?? '');
            } else if (snapshot.hasError) {
              print(snapshot.error.toString());
              return Text('Error loading privacy policy');
            }
            return CircularProgressIndicator();
          },
        ));
  }

  final String markdownText = '''
# Markdownパッケージの実線(# h1)
## 強調関連(## h2)
### サブタイトル(### h3)
#### サブ・サブタイトル(#### h4)
通常
**強調** 
*斜線* 
~取消~ 
## リンク
[リンク](https://www.google.com)
## 改行
空白行あり→改行できる 
空白行なし
→改行できない
## Details - 折りたたみ
サンプルコード
(上に空行が必要)
```rb
puts 'Hello, World'
```

### リスト
- リスト1
- リスト2

## テーブル
| Left align | Right align | Center align |
|:-----------|------------:|:------------:|
| column     | column      | column       |
## 終わり
''';
}
