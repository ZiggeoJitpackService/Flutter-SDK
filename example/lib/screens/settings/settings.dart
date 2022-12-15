import 'package:flutter/material.dart';
import 'package:ziggeo/ziggeo.dart';
import 'package:ziggeo_example/screens/settings/player_settings.dart';
import 'package:ziggeo_example/screens/settings/recorder_settings.dart';
import 'package:ziggeo_example/res/colors.dart';
import 'package:ziggeo_example/screens/settings/settings_common.dart';

class SettingsScreen extends StatefulWidget {
  Ziggeo ziggeo;
  static const String routeName = 'title_settings';

  SettingsScreen(this.ziggeo);

  @override
  _SettingsScreenState createState() => _SettingsScreenState(
        ziggeo,
        <Widget>[
          CommonSettingsScreen(this.ziggeo),
          RecorderSettingsScreen(this.ziggeo),
          PlayerSettingsScreen(this.ziggeo),
        ],
      );
}

class _SettingsScreenState extends State<SettingsScreen> {
  final Ziggeo ziggeo;
  List<Widget> _widgetOptions;

  _SettingsScreenState(this.ziggeo, this._widgetOptions);

  int _currentSelected = 0;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  void _onItemTapped(int index) {
    setState(() {
      _currentSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      body: _widgetOptions.elementAt(_currentSelected),
      drawer: Drawer(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        currentIndex: _currentSelected,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey[800],
        selectedItemColor: Color(primary),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Common Settings',
            icon: Icon(Icons.settings),
          ),
          BottomNavigationBarItem(
            label: 'Recorder Settings',
            icon: Icon(Icons.videocam),
          ),
          BottomNavigationBarItem(
            label: 'Player Settings',
            icon: Icon(Icons.play_circle_filled),
          ),
        ],
      ),
    );
  }
}
