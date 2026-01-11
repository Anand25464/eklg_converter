import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = "";
  String _lastWords1 = "";

  /*Map<String,String> map = {
  "અ":"y",	"આ":"yt",	"ઇ":"E",	"ઈ":"E",	"ઉ":"W",	"ઊ":"Q",	"એ":"yu",	"ઐ":"yi",	"ઓ":"ytu",	"ઔ":"yti",	"અં":"yk",	"અઃ":"y&",
  "ક":"f",	"કા":"ft",	"કિ":"rf",	"કી":"fe",	"કુ":"fw",	"કૂ":"fq",	"કે":"fu",	"કૈ":"fi",	"કો":"ftu",	"કૌ":"fti",	"કં":"fk",	"કઃ":"f&",
  "ખ":"Ft",	"ખા":"Ftt",	"ખિ":"rFt",	"ખી":"Fte",	"ખુ":"Ftw",	"ખૂ":"Ftq",	"ખે":"Ftu",	"ખૈ":"Fti",	"ખો":"Fttu",	"ખૌ":"Ftti",	"ખં":"Ftk",	"ખઃ":"Ft&",
  "ગ":"dt",	"ગા":"dtt",	"ગિ":"rdt",	"ગી":"dte",	"ગુ":"dtw",	"ગૂ":"dtq",	"ગે":"dtu",	"ગૈ":"dti",	"ગો":"dttu",	"ગૌ":"dtti",	"ગં":"dtk",	"ગઃ":"dt&",
  "ઘ":"Dt",	"ઘા":"Dtt",	"ઘિ":"rDt",	"ઘી":"Dte",	"ઘુ":"Dtw",	"ઘૂ":"Dtq",	"ઘે":"Dtu",	"ઘૈ":"Dti",	"ઘો":"Dttu",	"ઘૌ":"Dtti",	"ઘં":"Dtk",	"ઘઃ":"Dt&",
  "ચ":"at",	"ચા":"att",	"ચિ":"rat",	"ચી":"ate",	"ચુ":"atw",	"ચૂ":"atq",	"ચે":"atu",	"ચૈ":"ati",	"ચો":"attu",	"ચૌ":"atti",	"ચં":"atk",	"ચઃ":"at&",
  "છ":"A",	"છા":"At",	"છિ":"rA",	"છી":"Ae",	"છુ":"Aw",	"છૂ":"Aq",	"છે":"Au",	"છૈ":"Ai",	"છો":"Atu",	"છૌ":"Ati",	"છં":"Ak",	"છઃ":"A&",
  "જ":"s",	"જા":"st",	"જી":"B",	"જુ":"sw",	"જૂ":"sq",	"જે":"su",	"જૈ":"si",	"જો":"stu",	"જૌ":"sti",	"જં":"sk",	"જઃ":"s&",
  "ઝ":"L",	"ઝા":"Lt",	"ઝિ":"rL",	"ઝી":"Le",	"ઝુ":"Lw",	"ઝૂ":"Lq",	"ઝે":"Lu",	"ઝૈ":"Li",	"ઝો":"Ltu",	"ઝૌ":"Lti",	"ઝં":"Lk",	"ઝઃ":"L&",
  "ટ":"x",	"ટા":"xt",	"ટિ":"rx",	"ટી":"xe",	"ટુ":"xw",	"ટૂ":"xq",	"ટે":"xu",	"ટૈ":"xi",	"ટો":"xtu",	"ટૌ":"xti",	"ટં":"xk",	"ટઃ":"x&",
  "ઠ":"X",	"ઠા":"Xt",	"ઠિ":"rX",	"ઠી":"Xe",	"ઠુ":"Xw",	"ઠૂ":"Xq",	"ઠે":"Xu",	"ઠૈ":"Xi",	"ઠો":"Xtu",	"ઠૌ":"Xti",	"ઠં":"Xk",	"ઠઃ":"X&",
  "ડ":"z",	"ડા":"zt",	"ડિ":"rz",	"ડી":"ze",	"ડુ":"zw",	"ડૂ":"zq",	"ડે":"zu",	"ડૈ":"zi",	"ડો":"ztu",	"ડૌ":"zti",	"ડં":"zk",	"ડઃ":"z&",
  "ઢ":"Z",	"ઢા":"Zt",	"ઢિ":"rZ",	"ઢી":"Ze",	"ઢુ":"Zw",	"ઢૂ":"Zq",	"ઢે":"Zu",	"ઢૈ":"Zi",	"ઢો":"Ztu",	"ઢૌ":"Zti",	"ઢં":"Zk",	"ઢઃ":"Z&",
	"ણ":"Kt",	"ણા":"Ktt",	"ણિ":"rKt",	"ણી":"Kte",	"ણુ":"Ktw",	"ણૂ":"Ktq",	"ણે":"Ktu",	"ણૈ":"Kti",	"ણૉ":"Kttu",	"ણૌ":"Ktti",	"ણં":"Ktk",	"ણઃ":"Kt&",
  "ત":";t",	"તા":";tt",	"તિ":"r;t",	"તી":";te",	"તુ":";tw",	"તૂ":";tq",	"તે":";tu",	"તૈ":";ti",	"તો":";ttu",	"તૌ":";tti",	"તં":";tk",	"તઃ":";t&",
  "થ":":t",	"થા":":tt",	"થિ":"r:t",	"થી":":te",	"થુ":":tw",	"થૂ":":tq",	"થે":":tu",	"થૈ":":ti",	"થો":":ttu",	"થૌ":":tti",	"થં":":tk",	"થઃ":":t&",
  "દ":"\'",	"દા":"\'t",	"દિ":"r\'",	"દી":"\'e",	"દુ":"\'w",	"દૂ":"\'q",	"દે":"\'u",	"દૈ":"\'i",	"દો":"\'tu",	"દૌ":"\'ti",	"દં":"\'k",	"દઃ":"\'&",
  "ધ":"\"t",	"ધા":"\"tt",	"ધિ":"r\"t",	"ધી":"\"te",	"ધુ":"\"tw",	"ધૂ":"\"tq",	"ધે":"\"tu",	"ધૈ":"\"ti",	"ધો":"\"ttu",	"ધૌ":"\"tti",	"ધં":"\"tk",	"ધઃ":"\"t&",
  "ન":"lt",	"ના":"ltt",	"નિ":"rlt",	"ની":"lte",	"નુ":"ltw",	"નૂ":"ltq",	"ને":"ltu",	"નૈ":"lti",	"નો":"lttu",	"નૌ":"ltti",	"નં":"ltk",	"નઃ":"lt&",
  "પ":"vt",	"પા":"vtt",	"પિ":"rvt",	"પી":"vte",	"પુ":"vtw",	"પૂ":"vtq",	"પે":"vtu",	"પૈ":"vti",	"પો":"vttu",	"પૌ":"vtti",	"પં":"vtk",	"પઃ":"vt&",
  "ફ":"V",	"ફા":"Vt",	"ફિ":"rV",	"ફી":"Ve",	"ફુ":"Vw",	"ફૂ":"Vq",	"ફે":"Vu",	"ફૈ":"Vi",	"ફો":"Vtu",	"ફૌ":"Vti",	"ફં":"Vtk",	"ફઃ":"ht&",
  "બ":"ct",	"બા":"ctt",	"બિ":"rct",	"બી":"cte",	"બુ":"ctw",	"બૂ":"ctq",	"બે":"ctu",	"બૈ":"cti",	"બો":"cttu",	"બૌ":"ctti",	"બં":"ctk",	"બઃ":"ct&",
  "ભ":"Ct",	"ભા":"Ctt",	"ભિ":"rCt",	"ભી":"Cte",	"ભુ":"Ctw",	"ભૂ":"Ctq",	"ભે":"Ctu",	"ભૈ":"Cti",	"ભો":"Cttu",	"ભૌ":"Ctti",	"ભં":"Ctk",	"ભઃ":"Ct&",
  "મ":"bt",	"મા":"btt",	"મિ":"rbt",	"મી":"bte",	"મુ":"btw",	"મૂ":"btq",	"મે":"btu",	"મૈ":"bti",	"મો":"bttu",	"મૌ":"btti",	"મં":"btk",	"મઃ":"bt&",
  "ય":"gt",	"યા":"gtt",	"યિ":"rgt",	"યી":"gte",	"યુ":"gtw",	"યૂ":"gtq",	"યે":"gtu",	"યૈ":"gti",	"યો":"gttu",	"યૌ":"gtti",	"યં":"gtk",	"યઃ":"gt&",
  "ર":"h",	"રા":"ht",	"રિ":"rh",	"રી":"he",	"રુ":"hw",	"રૂ":"~",	"રે":"hu",	"રૈ":"hi",	"રો":"htu",	"રૌ":"hti",	"રં":"hk",	"રઃ":"h&",
  "લ":"jt",	"લા":"jtt",	"લિ":"rjt",	"લી":"jte",	"લુ":"jtw",	"લૂ":"jtq",	"લે":"jtu",	"લૈ":"jti",	"લો":"jttu",	"લૌ":"jtti",	"લં":"jtk",	"લઃ":"jt&",
  "વ":"Jt",	"વા":"Jtt",	"વિ":"rJt",	"વી":"Jte",	"વુ":"Jtw",	"વૂ":"Jtq",	"વે":"Jtu",	"વૈ":"Jti",	"વો":"Jttu",	"વૌ":"Jtti",	"વં":"Jtk",	"વઃ":"Jt&",
  "શ":"Nt",	"શા":"Ntt",	"શિ":"rNt",	"શી":"Nte",	"શુ":"Ntw",	"શૂ":"Ntq",	"શે":"Ntu",	"શૈ":"Nti",	"શો":"Nttu",	"શૌ":"Ntti",	"શં":"Ntk",	"શઃ":"Nt&",
  "ષ":"Mt",	"ષા":"Mtt",	"ષિ":"rMt",	"ષી":"Mte",	"ષુ":"Mtw",	"ષૂ":"Mtq",	"ષે":"Mtu",	"ષૈ":"Mti",	"ષો":"Mttu",	"ષૌ":"Mtti",	"ષં":"Mtk",	"ષઃ":"Mt&",
  "સ":"mt",	"સા":"mtt",	"સિ":"rmt",	"સી":"mte",	"સુ":"mtw",	"સૂ":"mtq",	"સે":"mtu",	"સૈ":"mti",	"સો":"mttu",	"સૌ":"mtti",	"સં":"mtk",	"સઃ":"mt&",
  "હ":"n",	"હા":"nt",	"હિ":"rn",	"હી":"ne",	"હુ":"nw",	"હૂ":"nq",	"હે":"nu",	"હૈ":"ni",	"હો":"ntu",	"હૌ":"nti",	"હં":"nk",	"હઃ":"n&",
  "ળ":"G",	"ળા":"Gt",	"ળિ":"rG",	"ળી":"Ge",	"ળુ":"Gw",	"ળૂ":"Gq",	"ળે":"Gu",	"ળૈ":"Gi",	"ળો":"Gtu",	"ળૌ":"Gti",	"ળં":"Gk",	"ળઃ":"G&",
  "ક્ષ":"Ht",	"ક્ષા":"Htt",	"ક્ષિ":"rHt",	"ક્ષી":"Hte",	"ક્ષુ":"Htw",	"ક્ષૂ":"Htq",	"ક્ષે":"Htu",	"ક્ષૈ":"Hti",	"ક્ષો":"Httu",	"ક્ષૌ":"Htti",	"ક્ષં":"Htk",	"ક્ષઃ":"Ht&",
  "ત્ર":"*t",	"ત્રા":"*t",	"ત્રી":";*e",	"ત્રુ":"*tw",	"ત્રૂ":"*tq",	"ત્રે":"*tu",	"ત્રૈ":"*ti",	"ત્રો":"*ttu",	"ત્રૌ":"*tti",	"ત્રં":"*tk",	"ત્રઃ":"*t&",
  "જ્ઞ":"\|t",	"જ્ઞા":"\|tt",	"જ્ઞિ":"r\|t",	"જ્ઞી":"\|te",	"જ્ઞુ":"\|tw",	"જ્ઞૂ":"\|tq",	"જ્ઞે":"\|tu",	"જ્ઞૈ":"\|ti",	"જ્ઞો":"\|ttu",	"જ્ઞૌ":"\|tti",	"જ્ઞં":"\|tk",	"જ્ઞઃ":"\|t&",
  "ક્ક":"²","ફ્ર":"§","પ્ર":"©","દ્ર":"Y","દ્વ":"«","જ્ર":"¯","શ્ન":"±","જ્જ":"´","દ્મ":"Æ","ન્ન":"Ë","રુ":"Ì","હ્મ":"Í","શ્વ":"\\","ઋ":"Ò","ા":"t",
    "ક્ક":"²","ક્કા":"²t","ક્કિ":"r²","ક્કી":"²e","ક્કુ":"²w","ક્કૂ":"²q","ક્કે":"²u","ક્કૈ":"²i","ક્કો":"²tu","ક્કૌ":"²ti","ક્કં":"²k","ક્કઃ":"²&",
    "ફ્ર":"§","ફ્રા":"§t","ફ્રિ":"r§","ફ્રી":"§e","ફ્રુ":"§w","ફ્રૂ":"§q","ફ્રે":"§u","ફ્રૈ":"§i","ફ્રો":"§tu","ફ્રૌ":"§ti","ફ્રં":"§k","ફ્રઃ":"§&",
    "પ્ર":"©","પ્રા":"©t","પ્રિ":"r©","પ્રી":"©e","પ્રુ":"©w","પ્રૂ":"©q","પ્રે":"©u","પ્રૈ":"©i","પ્રો":"©tu","પ્રૌ":"©ti","પ્રં":"©k","પ્રઃ":"©&",
    "દ્ર":"Y",  "દ્રા":"Yt","દ્રિ":"rY","દ્રી":"Ye","દ્રુ":"Yw","દ્રૂ":"Yq","દ્રે":"Yu","દ્રૈ":"Yi","દ્રો":"Ytu","દ્રૌ":"Yti","દ્રં":"Yk","દ્રઃ":"Y&",
  "દ્વ":"«",  "દ્વા":"«t","દ્વિ":"r«","દ્વી":"«e","દ્વુ":"«w","દ્વૂ":"«q","દ્વે":"«u","દ્વૈ":"«i","દ્વો":"«tu","દ્વૌ":"«ti","દ્વં":"«k","દ્વઃ":"«&",
  "જ્ર":"¯",  "જ્રા":"¯t","જ્રિ":"r¯","જ્રી":"¯e","જ્રુ":"¯w","જ્રૂ":"¯q","જ્રે":"¯u","જ્રૈ":"¯i","જ્રો":"¯tu","જ્રૌ":"¯ti","જ્રં":"¯k","જ્રઃ":"¯&",
  "શ્ન":"±",  "શ્ના":"±t","શ્નિ":"r±","શ્ની":"±e","શ્નુ":"±w","શ્નૂ":"±q","શ્ને":"±u","શ્નૈ":"±i","શ્નો":"±tu","શ્નૌ":"±ti","શ્નં":"±k","શ્નઃ":"±&",
  "જ્જ":"´",  "જ્જા":"´t","જ્જિ":"r´","જ્જી":"´e","જ્જુ":"´w","જ્જૂ":"´q","જ્જે":"´u","જ્જૈ":"´i","જ્જો":"´tu","જ્જૌ":"´ti","જ્જં":"´k","જ્જઃ":"´&",
  "દ્મ":"Æ",  "દ્મા":"Æt","દ્મિ":"rÆ","દ્મી":"Æe","દ્મુ":"Æw","દ્મૂ":"Æq","દ્મે":"Æu","દ્મૈ":"Æi","દ્મો":"Ætu","દ્મૌ":"Æti","દ્મં":"Æk","દ્મઃ":"Æ&",
  "ન્ન":"Ë",  "ન્ના":"Ët","ન્નિ":"rË","ન્ની":"Ëe","ન્નુ":"Ëw","ન્નૂ":"Ëq","ન્ને":"Ëu","ન્નૈ":"Ëi","ન્નો":"Ëtu","ન્નૌ":"Ëti","ન્નં":"Ëk","ન્નઃ":"Ë&",
  "હ્મ":"Í",  "હ્મા":"Ít","હ્મિ":"rÍ","હ્મી":"Íe","હ્મુ":"Íw","હ્મૂ":"Íq","હ્મે":"Íu","હ્મૈ":"Íi","હ્મો":"Ítu","હ્મૌ":"Íti","હ્મં":"Ík","હ્મઃ":"Í&",
  "શ્વ":"\\",  "શ્વા":"\\t","શ્વિ":"r\\","શ્વી":"\\e","શ્વુ":"\\w","શ્વૂ":"\\q","શ્વે":"\\u","શ્વૈ":"\\i","શ્વો":"\\tu","શ્વૌ":"\\ti","શ્વં":"\\k","શ્વઃ":"\\&",
    "ઋ":"Ò",  "ઋા":"Òt","ઋિ":"rÒ","ઋી":"Òe","ઋુ":"Òw","ઋૂ":"Òq","ઋે":"Òu","ઋૈ":"Òi","ઋો":"Òtu","ઋૌ":"Òti","ઋં":"Òk","ઋઃ":"Ò&",
  };*/

  Map<String, String> map = {
    'અ': 'y',
    'આ': 'yt',
    'ઇ': 'E',
    'ઈ': 'E',
    'ઉ': 'W',
    'ઊ': 'W',
    'ઋ': 'Ò',
    'ૠ': 'Ò',
    'ઌ': 'lu',
    'એ': 'yu',
    'ઐ': 'yi',
    'ઓ': 'ytu',
    'ઔ': 'yti',
    // 'ક': 'f',
    // 'ખ': 'F',
    // 'ગ': 'dt',
    // 'ઘ': 'Dt',
    // 'ઙ': 'ng',
    // 'ચ': 'at',
    // 'છ': 'A',
    // 'જ': 's',
    // 'ઝ': 'L',
    // 'ઞ': 'nj',
    // 'ટ': 'x',
    // 'ઠ': 'X',
    // 'ડ': 'z',
    // 'ઢ': 'Z',
    // 'ણ': 'Kt',
    // 'ત': ';t',
    // 'થ': ':t',
    // 'દ': '\'',
    // 'ધ': '\"',
    // 'ન': 'lt',
    // 'પ': 'vt',
    // 'ફ': 'V',
    // 'બ': 'ct',
    // 'ભ': 'Ct',
    // 'મ': 'bt',
    // 'ય': 'gt',
    // 'ર': 'h',
    // 'લ': 'jt',
    // 'ળ': 'G',
    // 'વ': 'Jt',
    // 'શ': 'Nt',
    // 'ષ': 'Mt',
    // 'સ': 'mt',
    // 'હ': 'n',
    // 'ક્ષ': 'Ht',
    // 'ત્ર': '*t',
    // 'જ્ઞ': '\|t',
    "ક": "f",
    "કા": "ft",
    "કિ": "rf",
    "કી": "fe",
    "કુ": "fw",
    "કું": "fwk",
    "કૂ": "fq",
    "કે": "fu",
    "કૈ": "fi",
    "કો": "ftu",
    "કૌ": "fti",
    "કં": "fk",
    "કઃ": "f7",

    // ખ family
    "ખ": "Ft",
    "ખા": "Ftt",
    "ખિ": "rFt",
    "ખી": "Fte",
    "ખુ": "Ftw",
    "ખૂ": "Ftq",
    "ખે": "Ftu",
    "ખૈ": "Fti",
    "ખો": "Fttu",
    "ખૌ": "Ftti",
    "ખં": "Ftk",
    "ખઃ": "Ft7",

    // ગ family
    "ગ": "dt",
    "ગા": "dtt",
    "ગિ": "rdt",
    "ગી": "dte",
    "ગુ": "dtw",
    "ગૂ": "dtq",
    "ગે": "dtu",
    "ગૈ": "dti",
    "ગો": "dttu",
    "ગૌ": "dtti",
    "ગં": "dtk",
    "ગઃ": "dt7",

    // ઘ family
    "ઘ": "Dt",
    "ઘા": "Dtt",
    "ઘિ": "rDt",
    "ઘી": "Dte",
    "ઘુ": "Dtw",
    "ઘૂ": "Dtq",
    "ઘે": "Dtu",
    "ઘૈ": "Dti",
    "ઘો": "Dttu",
    "ઘૌ": "Dtti",
    "ઘં": "Dtk",
    "ઘઃ": "Dt7",

    // ચ family
    "ચ": "at",
    "ચા": "att",
    "ચિ": "rat",
    "ચી": "ate",
    "ચુ": "atw",
    "ચૂ": "atq",
    "ચે": "atu",
    "ચૈ": "ati",
    "ચો": "attu",
    "ચૌ": "atti",
    "ચં": "atk",
    "ચઃ": "at7",

    // છ family
    "છ": "A",
    "છા": "At",
    "છિ": "rA",
    "છી": "Ae",
    "છુ": "Aw",
    "છૂ": "Aq",
    "છે": "Au",
    "છૈ": "Ai",
    "છો": "Atu",
    "છૌ": "Ati",
    "છં": "Ak",
    "છઃ": "A7",

    // જ family
    "જ": "s",
    "જા": "st",
    "જિ": "rs",
    "જી": "B",
    "જુ": "sw",
    "જૂ": "sq",
    "જે": "su",
    "જૈ": "si",
    "જો": "stu",
    "જૌ": "sti",
    "જં": "sk",
    "જઃ": "s7",

    // ઝ family
    "ઝ": "L",
    "ઝા": "Lt",
    "ઝિ": "rL",
    "ઝી": "Le",
    "ઝુ": "Lw",
    "ઝૂ": "Lq",
    "ઝે": "Lu",
    "ઝૈ": "Li",
    "ઝો": "Ltu",
    "ઝૌ": "Lti",
    "ઝં": "Lk",
    "ઝઃ": "L7",

    // ટ family
    "ટ": "x",
    "ટા": "xt",
    "ટિ": "rx",
    "ટી": "xe",
    "ટુ": "xw",
    "ટૂ": "xq",
    "ટે": "xu",
    "ટૈ": "xi",
    "ટો": "xtu",
    "ટૌ": "xti",
    "ટં": "xk",
    "ટઃ": "x7",

    // ઠ family
    "ઠ": "X",
    "ઠા": "Xt",
    "ઠિ": "rX",
    "ઠી": "Xe",
    "ઠુ": "Xw",
    "ઠૂ": "Xq",
    "ઠે": "Xu",
    "ઠૈ": "Xi",
    "ઠો": "Xtu",
    "ઠૌ": "Xti",
    "ઠં": "Xk",
    "ઠઃ": "X7",

    // ડ family
    "ડ": "z",
    "ડા": "zt",
    "ડિ": "rz",
    "ડી": "ze",
    "ડુ": "zw",
    "ડૂ": "zq",
    "ડે": "zu",
    "ડૈ": "zi",
    "ડો": "ztu",
    "ડૌ": "zti",
    "ડં": "zk",
    "ડઃ": "z7",

    // ઢ family
    "ઢ": "Z",
    "ઢા": "Zt",
    "ઢિ": "rZ",
    "ઢી": "Ze",
    "ઢુ": "Zw",
    "ઢૂ": "Zq",
    "ઢે": "Zu",
    "ઢૈ": "Zi",
    "ઢો": "Ztu",
    "ઢૌ": "Zti",
    "ઢં": "Zk",
    "ઢઃ": "Z7",

    // ણ family
    "ણ": "Kt",
    "ણા": "Ktt",
    "ણિ": "rKt",
    "ણી": "Kte",
    "ણુ": "Ktw",
    "ણૂ": "Ktq",
    "ણે": "Ktu",
    "ણૈ": "Kti",
    "ણો": "Kttu",
    "ણૌ": "Ktti",
    "ણં": "Ktk",
    "ણઃ": "Kt7",

    // ત family
    "ત": ";t",
    "તા": ";tt",
    "તિ": "r;t",
    "તી": ";te",
    "તુ": ";tw",
    "તું": ";tq",
    "તે": ";tu",
    "તૈ": ";ti",
    "તો": ";ttu",
    "તૌ": ";tti",
    "તં": ";tk",
    "તઃ": ";t7",

    // થ family
    "થ": ":t",
    "થા": ":tt",
    "થિ": "r:t",
    "થી": ":te",
    "થુ": ":tw",
    "થૂ": ":tq",
    "થે": ":tu",
    "થૈ": ":ti",
    "થો": ":ttu",
    "થૌ": ":tti",
    "થં": ":tk",
    "થઃ": ":t7",

    // દ family
    "દ": "'",
    "દા": "'t",
    "દિ": "r'",
    "દી": "'e",
    "દુ": "'w",
    "દૂ": "'q",
    "દે": "'u",
    "દૈ": "'i",
    "દો": "'tu",
    "દૌ": "'ti",
    "દં": "'k",
    "દઃ": "'7",

    // ધ family
    "ધ": "\"t",
    "ધા": "\"tt",
    "ધિ": "r\"t",
    "ધી": "\"te",
    "ધુ": "\"tw",
    "ધૂ": "\"tq",
    "ધે": "\"tu",
    "ધૈ": "\"ti",
    "ધો": "\"ttu",
    "ધૌ": "\"tti",
    "ધં": "\"tk",
    "ધઃ": "\"t7",

    // ન family
    "ન": "lt",
    "ના": "ltt",
    "નિ": "rlt",
    "ની": "lte",
    "નુ": "ltw",
    "નૂ": "ltq",
    "ને": "ltu",
    "નૈ": "lti",
    "નો": "lttu",
    "નૌ": "ltti",
    "નં": "ltk",
    "નઃ": "lt7",

    // પ family
    "પ": "vt",
    "પા": "vtt",
    "પિ": "rvt",
    "પી": "vte",
    "પુ": "vtw",
    "પૂ": "vtq",
    "પે": "vtu",
    "પૈ": "vti",
    "પો": "vttu",
    "પૌ": "vtti",
    "પં": "vtk",
    "પઃ": "vt7",

    // ફ family
    "ફ": "V",
    "ફા": "Vt",
    "ફિ": "rV",
    "ફી": "Ve",
    "ફુ": "Vw",
    "ફૂ": "Vq",
    "ફે": "Vu",
    "ફૈ": "Vi",
    "ફો": "Vtu",
    "ફૌ": "Vti",
    "ફં": "Vk",
    "ફઃ": "V7",

    // બ family
    "બ": "ct",
    "બા": "ctt",
    "બિ": "rct",
    "બી": "cte",
    "બુ": "ctw",
    "બૂ": "ctq",
    "બે": "ctu",
    "બૈ": "cti",
    "બો": "cttu",
    "બૌ": "ctti",
    "બં": "ctk",
    "બઃ": "ct7",

    // ભ family
    "ભ": "Ct",
    "ભા": "Ctt",
    "ભિ": "rCt",
    "ભી": "Cte",
    "ભુ": "Ctw",
    "ભૂ": "Ctq",
    "ભે": "Ctu",
    "ભૈ": "Cti",
    "ભો": "Cttu",
    "ભૌ": "Ctti",
    "ભં": "Ctk",
    "ભઃ": "Ct7",

    // મ family
    "મ": "bt",
    "મા": "btt",
    "મિ": "rbt",
    "મી": "bte",
    "મુ": "btw",
    "મૂ": "btq",
    "મે": "btu",
    "મૈ": "bti",
    "મો": "bttu",
    "મૌ": "btti",
    "મં": "btk",
    "માં": "bttk",
    "મઃ": "bt7",

    // ય family
    "ય": "gt",
    "યા": "gtt",
    "યિ": "rgt",
    "યી": "gte",
    "યુ": "gtw",
    "યૂ": "gtq",
    "યે": "gtu",
    "યૈ": "gti",
    "યો": "gttu",
    "યૌ": "gtti",
    "યં": "gtk",
    "યઃ": "gt7",

    // ર family
    "ર": "h",
    "રા": "ht",
    "રિ": "rh",
    "રી": "he",
    "રુ": "hw",
    "રૂ": "hq",
    "રે": "hu",
    "રૈ": "hi",
    "રો": "htu",
    "રૌ": "hti",
    "રં": "hk",
    "રઃ": "h7",

    // લ family
    "લ": "jt",
    "લા": "jtt",
    "લિ": "rjt",
    "લી": "jte",
    "લુ": "jtw",
    "લૂ": "jtq",
    "લે": "jtu",
    "લૈ": "jti",
    "લો": "jttu",
    "લૌ": "jtti",
    "લં": "jtk",
    "લઃ": "jt7",

    // વ family
    "વ": "Jt",
    "વા": "Jtt",
    "વિ": "rJt",
    "વી": "Jte",
    "વુ": "Jtw",
    "વૂ": "Jtq",
    "વે": "Jtu",
    "વૈ": "Jti",
    "વો": "Jttu",
    "વૌ": "Jtti",
    "વં": "Jtk",
    "વઃ": "Jt7",

    // શ family
    "શ": "Nt",
    "શા": "Ntt",
    "શિ": "rNt",
    "શી": "Nte",
    "શુ": "Ntw",
    "શૂ": "Ntq",
    "શે": "Ntu",
    "શૈ": "Nti",
    "શો": "Nttu",
    "શૌ": "Ntti",
    "શં": "Ntk",
    "શઃ": "Nt7",

    // ષ family
    "ષ": "Mt",
    "ષા": "Mtt",
    "ષિ": "rMt",
    "ષી": "Mte",
    "ષુ": "Mtw",
    "ષૂ": "Mtq",
    "ષે": "Mtu",
    "ષૈ": "Mti",
    "ષો": "Mttu",
    "ષૌ": "Mtti",
    "ષં": "Mtk",
    "ષઃ": "Mt7",

    // સ family
    "સ": "mt",
    "સા": "mtt",
    "સિ": "rmt",
    "સી": "mte",
    "સુ": "mtw",
    "સૂ": "mtq",
    "સે": "mtu",
    "સૈ": "mti",
    "સો": "mttu",
    "સૌ": "mtti",
    "સં": "mtk",
    "સઃ": "mt7",

    // હ family
    "હ": "n",
    "હા": "nt",
    "હિ": "rn",
    "હી": "ne",
    "હુ": "nw",
    "હૂ": "nq",
    "હે": "nu",
    "હૈ": "ni",
    "હો": "ntu",
    "હૌ": "nti",
    "હં": "nk",
    "હઃ": "n7",

    // ળ family
    "ળ": "G",
    "ળા": "Gt",
    "ળી": "Ge",
    "ળિ": "rG",
    "ળુ": "Gw",
    "ળૂ": "Gq",
    "ળે": "Gu",
    "ળૈ": "Gi",
    "ળો": "Gtu",
    "ળૌ": "Gti",
    "ળં": "Gk",
    "ળઃ": "G7",

    // ક્ષ family
    "ક્ષ": "Ht",
    "ક્ષા": "Htt",
    "ક્ષિ": "rHt",
    "ક્ષી": "Hte",
    "ક્ષુ": "Htw",
    "ક્ષૂ": "Htq",
    "ક્ષે": "Htu",
    "ક્ષૈ": "Hti",
    "ક્ષો": "Httu",
    "ક્ષૌ": "Htti",
    "ક્ષં": "Htk",
    "ક્ષઃ": "Ht7",

    // જ્ઞ family
    "જ્ઞ": "\\t",
    "જ્ઞા": "\\tt",
    "જ્ઞિ": "r\\t",
    "જ્ઞી": "\\te",
    "જ્ઞુ": "\\tw",
    "જ્ઞૂ": "\\tq",
    "જ્ઞે": "\\tu",
    "જ્ઞૈ": "\\ti",
    "જ્ઞો": "\\ttu",
    "જ્ઞૌ": "\\tti",
    "જ્ઞં": "\\tk",
    "જ્ઞઃ": "\\t7",

    // શ્ર family
    "શ્ર": "`",
    "શ્રા": "`t",
    "શ્રિ": "r`",
    "શ્રી": "`e",
    "શ્રુ": "`w",
    "શ્રૂ": "`q",
    "શ્રે": "`u",
    "શ્રૈ": "`i",
    "શ્રો": "`u",
    "શ્રૌ": "`i",
    "શ્રં": "`k",
    "શ્રઃ": "`7",

    "ર્ક": "fo",
    "ર્ખ": "Fo",
    "ર્ગ": "dto",
    "ર્ઘ": "Dto",
    "ર્ચ": "ato",
    "ર્છ": "Ao",
    "ર્જ": "so",
    "ર્ઝ": "Lo",
    "ર્ટ": "xo",
    "ર્ઠ": "Xo",
    "ર્ડ": "zo",
    "ર્ઢ": "Zo",
    "ર્ણ": "Kto",
    "ર્ત": ";to",
    "ર્થ": ":to",
    "ર્દ": "\'o",
    "ર્ધ": "\"o",
    "ર્ન": "lto",
    "ર્પ": "vto",
    "ર્ફ": "Vo",
    "ર્બ": "cto",
    "ર્ભ": "CtO",
    "ર્મ": "bto",
    "ર્ય": "gto",
    "ર્ર": "ho",
    "ર્લ": "jto",
    "ર્ળ": "Go",
    "ર્વ": "Jto",
    "ર્વા": "Jtto",
    "ર્શ": "Nto",
    "ર્ષ": "Mto",
    "ર્સ": "mto",
    "ર્હ": "no",
    "ર્ળ": "Go",
    "ર્ક્ષ": "Hto",
    "ર્જ્ઞ": "\\to",

    "ક્ર": "-",
    "ખ્ર": "Ft{",
    "ગ્ર": "dt{",
    "ઘ્ર": "Dt{",
    "ચ્ર": "at{",
    "છ્ર": "A{",
    "જ્ર": "s{",
    "ઝ્ર": "L{",
    "ટ્ર": "x[",
    "ઠ્ર": "X[",
    "ડ્ર": "z[",
    "ઢ્ર": "Z[",
    "ણ્ર": "Kt{",
    "ત્ર": "*t",
    "થ્ર": ";t{",
    "દ્ર": "Y{",
    "ન્ર": "lt{",
    "પ્ર": "vt{",
    "ફ્ર": "V{",
    "બ્ર": "ct{",
    "ભ્ર": "Ct{",
    "મ્ર": "bt{",
    "ય્ર": "gt{",
    "લ્ર": "jt{",
    "ળ્ર": "G{",
    "વ્ર": "Jt{",
    "ષ્ર": "Mt{",
    "સ્ર": "mt{",
    "હ્ર": "Ñ",
    "ળ્ર": "G{",
    "ક્ષ્ર": "Ht{",
    "જ્ઞ્ર": "\\t{",

    "શ્વ": "#",
    "શ્ચ": "|",
    "દ્ધ": "]",
    "દ્ધા": "]t",
    "માં": "btk",
    "કિં": "rfk",
    "દ્વા": "«t",
    "ઠ્ઠ": "¸",
    "ક્ક": "²",
    "ફ્ર": "§",
    "પ્ર": "©",
    "દ્વ": "«",
    "જ્ર": "¯",
    "શ્ન": "±",
    "જ્જ": "´",
    "દ્મ": "Æ",
    "ન્ન": "Ë",
    "રુ": "Ì",
    "હ્મ": "Í",
    "શ્વ": "#",
    "ા": "t",
    "ક્કા": "²t",
    "ક્કિ": "r²",
    "ક્કી": "²e",
    "ક્કુ": "²w",
    "ક્કૂ": "²q",
    "ક્કે": "²u",
    "ક્કૈ": "²i",
    "ક્કો": "²tu",
    "ક્કૌ": "²ti",
    "ક્કં": "²k",
    "ક્કઃ": "²&",
    "ફ્રા": "§t",
    "ફ્રિ": "r§",
    "ફ્રી": "§e",
    "ફ્રુ": "§w",
    "ફ્રૂ": "§q",
    "ફ્રે": "§u",
    "ફ્રૈ": "§i",
    "ફ્રો": "§tu",
    "ફ્રૌ": "§ti",
    "ફ્રં": "§k",
    "ફ્રઃ": "§&",
    "પ્ર": "©",
    "પ્રા": "©t",
    "પ્રિ": "r©",
    "પ્રી": "©e",
    "પ્રુ": "©w",
    "પ્રૂ": "©q",
    "પ્રે": "©u",
    "પ્રૈ": "©i",
    "પ્રો": "©tu",
    "પ્રૌ": "©ti",
    "પ્રં": "©k",
    "પ્રઃ": "©&",
    "દ્રા": "Yt",
    "દ્રિ": "rY",
    "દ્રી": "Ye",
    "દ્રુ": "Yw",
    "દ્રૂ": "Yq",
    "દ્રે": "Yu",
    "દ્રૈ": "Yi",
    "દ્રો": "Ytu",
    "દ્રૌ": "Yti",
    "દ્રં": "Yk",
    "દ્રઃ": "Y&",
    "દ્વા": "«t",
    "દ્વિ": "r«",
    "દ્વી": "«e",
    "દ્વુ": "«w",
    "દ્વૂ": "«q",
    "દ્વે": "«u",
    "દ્વૈ": "«i",
    "દ્વો": "«tu",
    "દ્વૌ": "«ti",
    "દ્વં": "«k",
    "દ્વઃ": "«&",
    "જ્ર": "¯",
    "જ્રા": "¯t",
    "જ્રિ": "r¯",
    "જ્રી": "¯e",
    "જ્રુ": "¯w",
    "જ્રૂ": "¯q",
    "જ્રે": "¯u",
    "જ્રૈ": "¯i",
    "જ્રો": "¯tu",
    "જ્રૌ": "¯ti",
    "જ્રં": "¯k",
    "જ્રઃ": "¯&",
    "શ્ના": "±t", "શ્નિ": "r±", "શ્ની": "±e", "શ્નુ": "±w", "શ્નૂ": "±q", "શ્ને": "±u", "શ્નૈ": "±i", "શ્નો": "±tu", "શ્નૌ": "±ti", "શ્નં": "±k", "શ્નઃ": "±&",
    "જ્જા": "´t", "જ્જિ": "r´", "જ્જી": "´e", "જ્જુ": "´w", "જ્જૂ": "´q", "જ્જે": "´u", "જ્જૈ": "´i", "જ્જો": "´tu", "જ્જૌ": "´ti", "જ્જં": "´k", "જ્જઃ": "´&",
    "દ્મા": "Æt", "દ્મિ": "rÆ", "દ્મી": "Æe", "દ્મુ": "Æw", "દ્મૂ": "Æq", "દ્મે": "Æu", "દ્મૈ": "Æi", "દ્મો": "Ætu", "દ્મૌ": "Æti", "દ્મં": "Æk", "દ્મઃ": "Æ&",
    "ન્ના": "Ët", "ન્નિ": "rË", "ન્ની": "Ëe", "ન્નુ": "Ëw", "ન્નૂ": "Ëq", "ન્ને": "Ëu", "ન્નૈ": "Ëi", "ન્નો": "Ëtu", "ન્નૌ": "Ëti", "ન્નં": "Ëk", "ન્નઃ": "Ë&",
    "હ્મા": "Ít", "હ્મિ": "rÍ", "હ્મી": "Íe", "હ્મુ": "Íw", "હ્મૂ": "Íq", "હ્મે": "Íu", "હ્મૈ": "Íi", "હ્મો": "Ítu", "હ્મૌ": "Íti", "હ્મં": "Ík", "હ્મઃ": "Í&",
    "શ્વા": "#t", "શ્વિ": "r#", "શ્વી": "#e", "શ્વુ": "#w", "શ્વૂ": "#q", "શ્વે": "#u", "શ્વૈ": "#i", "શ્વો": "#tu", "શ્વૌ": "#ti", "શ્વં": "#k", "શ્વઃ": "#&",
    "ઋા": "Òt", "ઋિ": "rÒ", "ઋી": "Òe", "ઋુ": "Òw", "ઋૂ": "Òq", "ઋે": "Òu", "ઋૈ": "Òi", "ઋો": "Òtu", "ઋૌ": "Òti", "ઋં": "Òk", "ઋઃ": "Ò&",
    "િ": "r",    // i (prepended)
    "ી": "e",    // ii
    "ુ": "w",    // u
    "ૂ": "q",    // uu
    "ે": "u",    // e
    "ૈ": "i",    // ai
    "ો": "tu",   // o
    "ૌ": "ti",   // au
    "ં": "k",    // anusvara
    "ઃ": "7",


    "ક્": "f",
    "ખ્": "F",
    "ગ્": "d",
    "ઘ્": "D",
    "ઙ્": "T",
    "ચ્": "a",
    "છ્": "A",
    "જ્": "s",
    "ઝ્": "L",
    "ઞ્": "~",
    "ટ્": "x",
    "ઠ્": "X",
    "ડ્": "z",
    "ઢ્": "Z",
    "ણ્": "K",
    "ત્": ";",
    "થ્": ":",
    "દ્": "'",
    "ધ્": "\"",
    "ન્": "l",
    "પ્": "v",
    "ફ્": "V",
    "બ્": "c",
    "ભ્": "C",
    "મ્": "b",
    "ય્": "g",
    "ર્": "h",
    "લ્": "j",
    "વ્": "J",
    "શ્": "N",
    "ષ્": "M",
    "સ્": "m",
    "હ્": "n",
    "ળ્": "G",
    "ક્ષ્": "H",
    "ત્ર્": "*",
    "જ્ઞ્": "|",
    "કૃ":"f]",
  "કિં":"rfk", "ખિં":"rFtk", "ગિં":"rdfk", "ઘિં":"rDfk", "ચિં":"ratk", "છિં":"rAk", "જિં":"rsk", "ઝિં":"rLk", "ટિં":"rxk", "ઠિં":"rXk", "ડિં":"rzk", "ઢિં":"rZk", "ણિં":"rKtk", "તિં":"r;tk", "થિં":"r:tk", "દિં":"r'k", "ધિં":"r\"k", "નિં":"rltk", "પિં":"rvtk", "ફિં":"rVk", "બિં":"rctk", "ભિં":"rCtk", "મિં":"rbtk", "યિં":"rgtk", "લિં":"rjtk", "ળિં":"rGk", "વિં":"rJtk", "શિં":"rNtk", "ષિં":"rMtk", "સિં":"rmtk", "હિં":"rnk",
  "ક્ષિં":"rHkt", "જ્ઞિં":"r\\tk", "શ્રિં":"r`k",

    "કીં":"fek",
    "ખીં":"Ftek",
    "ગીં":"dtek",
    "ઘીં":"Dtek",
    "ચીં":"atek",
    "છીં":"Aek",
    "જીં":"Bek",
    "ઝીં":"Lek",
    "ટીં":"xek",
    "ઠીં":"Xek",
    "ડીં":"zek",
    "ઢીં":"Zek",
    "ણીં":"Ktek",
    "તીં":";tek",
    "થીં":":tek",
    "દીં":"'ek",
    "ધીં":"\"tek",
    "નીં":"ltek",
    "પીં":"vtek",
    "ફીં":"Vek",
    "બીં":"ctek",
    "ભીં":"Ctek",
    "મીં":"btek",
    "યીં":"gtek",
    "લીં":"jtek",
    "ળીં":"Gek",
    "વીં":"Jtek",
    "શીં":"Ntek",
    "ષીં":"Mtek",
    "સીં":"mtek",
    "હીં":"nek",
    "ક્ષીં":"Htek",
    "જ્ઞીં":"\\tek",
    "શ્રીં":"`ek",

    "કું":"fwk",
    "ખું":"Ftwk",
    "ગું":"dtwk",
    "ઘું":"Dtwk",
    "ચું":"atwk",
    "છું":"Awk",
    "જું":"swk",
    "ઝું":"Lwk",
    "ટું":"xwk",
    "ઠું":"Xwk",
    "ડું":"zwk",
    "ઢું":"Zwk",
    "ણું":"Ktwk",
    "તું":";twk",
    "થું":":twk",
    "દું":"'wk",
    "ધું":"\"twk",
    "નું":"ltwk",
    "પું":"vtwk",
    "ફું":"Vwk",
    "બું":"ctwk",
    "ભું":"Ctwk",
    "મું":"btwk",
    "યું":"gtwk",
    "લું":"jtwk",
    "ળું":"Gwk",
    "વું":"Jtwk",
    "શું":"Ntwk",
    "ષું":"Mtwk",
    "સું":"mtwk",
    "હું":"nwk",
    "ક્ષું":"Htwk",
    "જ્ઞું":"\\twk",
    "શ્રું":"`wk",

    "કૂં":"fqk",
    "ખૂં":"Ftqk",
    "ગૂં":"dtqk",
    "ઘૂં":"Dtqk",
    "ચૂં":"atqk",
    "છૂં":"Aqk",
    "જૂં":"sqk",
    "ઝૂં":"Lqk",
    "ટૂં":"xqk",
    "ઠૂં":"Xqk",
    "ડૂં":"zqk",
    "ઢૂં":"Zqk",
    "ણૂં":"Ktqk",
    "તૂં":";tqk",
    "થૂં":":tqk",
    "દૂં":"'qk",
    "ધૂં":"\"tqk",
    "નૂં":"ltqk",
    "પૂં":"vtqk",
    "ફૂં":"Vqk",
    "બૂં":"ctqk",
    "ભૂં":"Ctqk",
    "મૂં":"btqk",
    "યૂં":"gtqk",
    "લૂં":"jtqk",
    "ળૂં":"Gqk",
    "વૂં":"Jtqk",
    "શૂં":"Ntqk",
    "ષૂં":"Mtqk",
    "સૂં":"mtqk",
    "હૂં":"nqk",
    "ક્ષૂં":"Htqk",
    "જ્ઞૂં":"\\tqk",
    "શ્રૂં":"`qk",

    "કેં": "fuk",
    "ખેં": "Fuk",
    "ગેં": "duk",
    "ઘેં": "Duk",
    "ચેં": "auk",
    "છેં": "Auk",
    "જેં": "suk",
    "ઝેં": "Luk",
    "ટેં": "xuk",
    "ઠેં": "Xuk",
    "ડેં": "zuk",
    "ઢેં": "Zuk",
    "ણેં": "Ktuk",
    "તેં": ";tuk",
    "થીં": ":tuk",
    "દેં": "'uk",
    "ધેં": "\"tuk",
    "નેં": "ltuk",
    "પેં": "vtuk",
    "ફેં": "Vuk",
    "બેં": "ctuk",
    "ભેં": "Ctuk",
    "મેં": "btuk",
    "યેં": "gtuk",
    "લેં": "jtuk",
    "ળેં": "Guk",
    "વેં": "Jtuk",
    "શેં": "Ntuk",
    "ષેં": "Mtuk",
    "સેં": "mtuk",
    "હેં": "nuk",
    "ક્ષેં": "Htuk",
    "જ્ઞેં": "\\tuk",
    "શ્રેં": "`uk",

    "કોં": "ftuk",
    "ખોં": "Fttuk",
    "ગોં": "dttuk",
    "ઘોં": "Dttuk",
    "ચોં": "attuk",
    "છોં": "Atuk",
    "જોં": "stuk",
    "ઝોં": "Ltuk",
    "ટોં": "xtuk",
    "ઠોં": "Xtuk",
    "ડોં": "ztuk",
    "ઢોં": "Ztuk",
    "ણોં": "Kttuk",
    "તોં": ";ttuk",
    "થોં": ":ttuk",
    "દોં": "'tuk",
    "ધોં": "\"ttuk",
    "નોં": "lttuk",
    "પોં": "vttuk",
    "ફોં": "Vtuk",
    "બોં": "cttuk",
    "ભોં": "Cttuk",
    "મોં": "bttuk",
    "યોં": "gttuk",
    "લોં": "jttuk",
    "ળોં": "Gtuk",
    "વોં": "Jttuk",
    "શોં": "Nttuk",
    "ષોં": "Mttuk",
    "સોં": "mttuk",
    "હોં": "ntuk",
    "ક્ષોં": "Httuk",
    "જ્ઞોં": "\\ttuk",
    "શ્રોં": "`tuk",

    "કૌં":"ftik",
    "ખૌં":"Fttik",
    "ગૌં":"dttik",
    "ઘૌં":"Dttik",
    "ચૌં":"attik",
    "છૌં":"Atik",
    "જૌં":"stik",
    "ઝૌં":"Ltik",
    "ટૌં":"xtik",
    "ઠૌં":"Xtik",
    "ડૌં":"ztik",
    "ઢૌં":"Ztik",
    "ણૌં":"Kttik",
    "તૌં":";ttik",
    "થૌં":":ttik",
    "દૌં":"'tik",
    "ધૌં":"\"ttik",
    "નૌં":"lttik",
    "પૌં":"vttik",
    "ફૌં":"Vttik",
    "બૌં":"cttik",
    "ભૌં":"Cttik",
    "મૌં":"bttik",
    "યૌં":"gttik",
    "લૌં":"jttik",
    "ળૌં":"Gtik",
    "વૌં":"Jttik",
    "શૌં":"Nttik",
    "ષૌં":"Mttik",
    "સૌં":"mttik",
    "હૌં":"ntik",
    "ક્ષૌં":"Httik",
    "જ્ઞૌં":"\\ttik",
    "શ્રૌં":"`ttik",
  };
  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      localeId: 'gu-IN',
    );
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  _onSpeechResult(SpeechRecognitionResult result) {
    print(result);
    _lastWords = result.recognizedWords;
    /*_lastWords.split('').map((e) => print(e));
     _lastWords1="";
     for (int i = 0; i < _lastWords.length; i++) {
       String char = _lastWords[i];
       if (map.containsKey(char)) {
         _lastWords1 += map[char]!;
       } else {
         _lastWords1 += char; // Handle characters not in the map
       }
     }*/
    setState(() {});
  }

  String convertToEklg(String input) {
    String output = input;

    // Replace longest matches first (like કો before ક)
    final sortedKeys = map.keys.toList()..sort((a, b) => b.length.compareTo(a.length));

    for (var key in sortedKeys) {
      print("key : $key");
      output = output.replaceAll(key, map[key]!);
    }

    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Recognized words:',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  // If listening is active show the recognized words
                  _lastWords1.isNotEmpty
                      ? '${_lastWords1}'
                      // If listening isn't active but could be tell the user
                      // how to start it, otherwise indicate that speech
                      // recognition is not yet ready or not supported on
                      // the target device
                      : _speechEnabled
                          ? 'mttkCtGJtt bttxu bttE_tuVtult vth fjtef fhtu'
                          : 'Speech not available',
                  style: TextStyle(fontFamily: 'EKLG-13B'),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  // If listening is active show the recognized words
                  _speechToText.isListening
                      ? '${_lastWords}'
                      // If listening isn't active but could be tell the user
                      // how to start it, otherwise indicate that speech
                      // recognition is not yet ready or not supported on
                      // the target device
                      : _speechEnabled
                          ? _lastWords.isNotEmpty
                              ? '$_lastWords'
                              : 'Tap the microphone to start listening...'
                          : 'Speech not available',
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
               _lastWords1 =  "$_lastWords1\n${convertToEklg(_lastWords)}";
              });
            },
            tooltip: 'Convert',
            child: Icon(Icons.camera_outlined),
          ),
          SizedBox(
            height: 16,
          ),
          FloatingActionButton(
            onPressed: () {
              _copyToClipboard(_lastWords1);
            },
            tooltip: 'Copy text',
            child: Icon(Icons.copy),
          ),
          SizedBox(
            height: 16,
          ),
          FloatingActionButton(
            onPressed:
                // If not yet listening for speech start, otherwise stop
                _speechToText.isNotListening ? _startListening : _stopListening,
            tooltip: 'Listen',
            child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
          ),
        ],
      ),
    );
  }

  Future<void> _copyToClipboard(String text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Text copied to clipboard!'),
        ),
      );
    } catch (e) {
      // Show a snackbar on failure
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to copy text.'),
        ),
      );
    }
  }
}
