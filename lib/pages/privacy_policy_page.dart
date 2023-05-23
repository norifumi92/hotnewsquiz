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
# 規約・プライバシーポリシー

この規約・プライバシーポリシーは、Hot News Quizの利用に関連して収集される情報とその使用方法について説明します。お客様がHot News Quizを使用する場合、以下に記載されている情報の収集と使用に同意したものとみなします。

## 収集される情報
### 1.1 リワード広告の提供
Hot News Quizは、広告提供のためにサードパーティの広告ネットワークと連携します。これにより、リワード広告が表示され、ユーザーが特定のアクションを実行した場合に報酬が提供されます。リワード広告を表示するために、アプリは以下の情報を収集することがあります。
デバイスID: ユーザーが広告をクリックしたかどうかを識別するために使用されることがあります。
広告の視認性と相互作用: リワード広告の表示やクリックに関連する情報を収集することがあります。

### 1.2 匿名の使用統計データの収集
Hot News Quizは、匿名の使用統計データを収集する場合があります。これには、アプリの利用状況やクラッシュレポートなどが含まれます。これらの情報は、アプリの改善やトラブルシューティングに使用される可能性があります。

## 収集された情報の使用
### 2.1 リワード広告の提供と報酬の付与
収集された情報は、リワード広告の提供とユーザーへの報酬付与に使用されます。これにより、ユーザーが特定のアクションを実行すると、報酬が提供されます。

### 2.2 アプリの改善
収集された使用統計データは、アプリの機能改善やパフォーマンス向上に役立てられます。匿名で集計されたデータは、アプリの品質向上や新しい機能の開発に使用される可能性があります。

## 情報の共有
### 3.1 サードパーティとの共有
Hot News Quizは、リワード広告の提供のためにサードパーティの広告ネットワークと情報を共有する場合があります。これにより、リワード広告が表示され、ユーザーに報酬が提供されます。

### 3.2 法的要件や安全対策
Hot News Quizは、法的要件や安全対策のために、必要に応じて情報を開示することがあります。これには、法律に基づく要求、知的財産権の保護、ユーザーまたは一般の人々の安全確保が含まれます。

## ユーザーの選択肢と設定
### 4.1 広告のオプトアウト
ユーザーは、設定やデバイスの広告IDに関連するオプトアウトオプションを使用することで、リワード広告の提供を拒否することができます。ただし、報酬の提供は行われなくなります。

## セキュリティ
### 5.1 データの保護
Hot News Quizは、ユーザーの情報を適切に保護するために合理的なセキュリティ対策を実施しています。ただし、インターネットを介してデータを送信する際には、完全なセキュリティを保証することはできません。

## お問い合わせ先
ご質問やプライバシーポリシーに関するお問い合わせは、以下の連絡先までご連絡ください。

noristyle92@gmail.com

''';
}
