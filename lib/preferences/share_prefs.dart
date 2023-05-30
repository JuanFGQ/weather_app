import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/models/save_news_class.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static List<String> _history = [];
  static String _placeName = '';

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

//******************************************************* */

//get list from sharePreferences
  static List<String> get history {
    return _prefs.getStringList('history') ?? _history;
  }

//save list on sharePreferences
  static set history(List<String> history) {
    _history = history;
    _prefs.setStringList('history', history);
  }

//******************************************************* */
//for get selected Item
  static String get placeName {
    return _prefs.getString('placeName') ?? _placeName;
  }

//for save selected Item;
  static set placeName(String placeName) {
    _placeName = placeName;
    _prefs.setString('placeName', placeName);
  }

  //****************************************************** */

  //this list contains the list of savedNews this is the list i call on listview.builder

  static List<String> _newsListShow = [];

  static List<String> get newsListShow {
    return _prefs.getStringList('newsListShow') ?? _newsListShow;
  }

  static set newsListShow(List<String> newsListShow) {
    _newsListShow = newsListShow;
    _prefs.setStringList('newListShow', newsListShow);
  }

//*************************************************** */

//this list i where i save the sub-list that contains the main information for show

  static List<String> _savedNews = [];

  static List<String> get gSavedNews {
    return _prefs.getStringList('gSavedNews') ?? _savedNews;
  }

  static set sSavedNews(List<String> sSavedNews) {
    _savedNews = sSavedNews;
    _prefs.setStringList('gSavedNews', sSavedNews);
  }
//*************************************************** */
}
