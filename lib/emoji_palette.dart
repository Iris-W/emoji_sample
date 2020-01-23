import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

class EmojiPanel extends StatefulWidget {
  @override
  State<EmojiPanel> createState() => _EmojiPanelState();
}

class _EmojiPanelState extends State<EmojiPanel>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ItemScrollController _listcontroller;
  ItemPositionsListener _listlistener;
  int i = 0;

  List<Icon> emojiSet = [
    Icon(Icons.ac_unit),
    Icon(Icons.access_alarm),
    Icon(Icons.access_time),
    Icon(Icons.accessible),
    Icon(Icons.add_alarm),
    Icon(Icons.add_shopping_cart),
    Icon(Icons.alarm_off),
    Icon(Icons.arrow_downward),
    Icon(Icons.art_track),
    Icon(Icons.device_unknown)
  ];

  List<String> _emojiNameSet = [
    'Recent',
    'Face',
    'Natures',
    'Diet',
    'Activity',
    'Travel',
    'Objects',
    'Symbols',
    'Flags',
    'Guild',
  ];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: emojiSet.length);
    _listcontroller = ItemScrollController();
    _listlistener = ItemPositionsListener.create();
    _listlistener.itemPositions.addListener(listener);
    super.initState();
  }

  void listener() {
    if(i != _listlistener.itemPositions.value.first.index){
      i = _listlistener.itemPositions.value.first.index;
      _tabController.animateTo(i);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 400,
            child: Column(
              children: <Widget>[
                Card(
                  child: TabBar(
                    controller: _tabController,
                    onTap: (index) {
                      i = index;
                      _listcontroller.scrollTo(
                          index: index,
                          curve: Curves.ease,
                          duration: Duration(milliseconds: 200));
                    },
                    unselectedLabelColor: Colors.grey,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black26)),
                    isScrollable: true,
                    tabs: emojiSet,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: ScrollablePositionedList.builder(
                    itemScrollController: _listcontroller,
                    itemPositionsListener: _listlistener,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Wrap(
                        children: <Widget>[
                          Text(
                            _emojiNameSet[index],
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                          FlutterLogo(
                            size: 200,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            )));
  }
}
