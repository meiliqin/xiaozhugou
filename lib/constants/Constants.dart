import 'package:event_bus/event_bus.dart';

class Constants {
  static final String REDIRECT_URL = "http://yubo725.top/osc/osc.php";

  static final String LOGIN_URL =
      "https://www.oschina.net/action/oauth2/authorize?client_id=4rWcDXCNTV5gMWxtagxI&response_type=code&redirect_uri=" +
          REDIRECT_URL;

  static final String OSC_CLIENT_ID = "4rWcDXCNTV5gMWxtagxI";

  static final String END_LINE_TAG = "COMPLETE";

  static EventBus eventBus = new EventBus();
  static final String LUN_BO_JSON = "";

  static final List LUN_BO_MAP = [
    {
      "imgUrl":
          "https://ok.166.net/reunionpub/1_20190703_16bb7252e75655276.jpeg",
      "scid": "546649971707"
    },
    {
      "imgUrl":
          "https://ok.166.net/reunionpub/1_20190703_16bb7252e75422475.jpeg",
      "scid": "546649971707"
    },
    {
      "imgUrl":
          "https://ok.166.net/reunionpub/1_20190703_16bb7252e75426037.jpeg",
      "scid": "546649971707"
    },
    {
      "imgUrl":
          "https://ok.166.net/reunionpub/1_20190703_16bb7252e75422673.jpeg",
      "scid": "546649971707"
    },
    {
      "imgUrl":
          "https://ok.166.net/reunionpub/1_20190703_16bb7252e75907127.jpeg",
      "scid": "546649971707"
    }
  ];

  static final String PID="mm_343780171_368000361_101527600308";

  static final List<String>CAT_TITLE=["母婴","美妆","日用居家","鞋包配饰","美食","文体","家电数码","女装","内衣","男装"];

  static final List<int>CAT_ID=[2,3,4,5,6,7,8,10,11,12];

  static final List<String>CAT_ICON=['images/muy.png','images/meiz.png','images/riy.png','images/xiebao.png','images/meis.png','images/went.png','images/shuma.png','images/nvz.png','images/neiy.png','images/nanz.png'];

}
