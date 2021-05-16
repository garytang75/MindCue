import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth2/models/journallocal.dart';
import 'journal_input_local.dart';
import '../journal_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/circular_button.dart';

/*
3/28/2021 Gary- Moved the List of the Journal into Journal Page
*/
class JournalPage extends StatefulWidget {
  final JournalLocal recieve;
  String get text {
    return recieve.journals;
  }

  JournalPage({Key key, this.recieve}) : super(key: key);
  @override
  JournalPageState createState() => JournalPageState();
}

class JournalPageState extends State<JournalPage>
    with TickerProviderStateMixin {
  List<JournalLocal> localjournallist = new List<JournalLocal>();
  SharedPreferences sharedPreferences;

  void initState() {
    loadSaved();
    super.initState();
  }

  void loadSaved() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.recieve != null) {
      addJournal(widget.recieve);
      Navigator.of(context).pop();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Journal Page',
          style: TextStyle(color: Colors.grey[850]),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () => goToJournalLocal(),
      // ),
      body: localjournallist.isEmpty ? emptyList() : buildListView(),
    );
  }

  // Widget buildBody(){
//   return ListView.builder(itemBuilder: itemBuilder)
// }

  Widget emptyList() {
    return Stack(children: [
      Center(child: Text('No Journals')),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color(0xFFCEE2EE), shape: BoxShape.rectangle),
          height: 55,
        ),
      ),
      Align(
        alignment: Alignment(0, 0.92),
        child: CircularButton(
            color: Color(0xFFFDBC59),
            width: 60,
            height: 60,
            icon: Icon(
              Icons.home_outlined,
              size: 30,
              color: Colors.black,
            ),
            onClick: () {
              // Navigator.popUntil(context, ModalRoute.withName('/home'));
              Navigator.pop(context);
            }),
      ),
    ]);
    //Bottom App Bar
  }

  Widget buildListView() {
    return Stack(
      children: [
        ListView.builder(
            itemCount: localjournallist.length,
            itemBuilder: (BuildContext context, int index) {
              return buildItem(localjournallist[index], index);
            }),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color(0xFFCEE2EE), shape: BoxShape.rectangle),
            height: 55,
          ),
        ),
        Align(
          alignment: Alignment(0, 0.92),
          child: CircularButton(
              color: Color(0xFFFDBC59),
              width: 60,
              height: 60,
              icon: Icon(
                Icons.home_outlined,
                size: 30,
                color: Colors.black,
              ),
              onClick: () {
                Navigator.pop(context);
              }),
        ),
      ],
    );
  }

  Widget buildItem(JournalLocal item, index) {
    return Dismissible(
      key: Key('${item.hashCode}'),
      background: Container(color: Colors.red[700]),
      onDismissed: (direction) => removeJournal(item),
      direction: DismissDirection.startToEnd,
      child: buildCard(item, index),
    );
  }

  Widget buildCard(item, index) {
    return Card(
        child: Column(children: [
      ListTile(
        leading: Container(width: 28, height: 28, child: moodWidget(item)),
        title: Text(item.createdAt,
            style: TextStyle(color: Colors.grey, fontSize: 14)),
        onTap: () {
          gotoEditeJournalView(item);
        },
      ),
      SizedBox(
        width: 280,
        height: 150,
        child:
            Text(item.journals, maxLines: 4, overflow: TextOverflow.ellipsis),
      ),
    ]));
  }

  void goToJournalLocal() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return JournalInputLocal();
    })).then((journals) {
      if ((journals != null)) {
        addJournal(journals);
      }
    });
  }

  void addJournal(JournalLocal item) {
    localjournallist.insert(0, item);
    saveData();
  }

  void recieveJournal(JournalLocal item) {
    addJournal(item);
  }

  void gotoEditeJournalView(JournalLocal item) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return JournalInputLocal(item: item);
    })).then((journals) {
      if (journals != null) {
        editJournal(item, journals);
      }
    });
  }

  void editJournal(JournalLocal item, JournalLocal journals) {
    item.journals = journals.journals;
    item.createdAt = item.createdAt;
    saveData();
    textJournal().sendDairy(item.journals, item.createdAt, item.iconPath);
  }

  void removeJournal(JournalLocal item) {
    localjournallist.remove(item);
    saveData();
    // Backend function gives 502, uncomment after fix
    // Journal().deleteDairy(item.createdAt);
  }

  void loadData() {
    List<String> listString = sharedPreferences.getStringList('list');
    if (listString != null) {
      localjournallist = listString
          .map((item) => JournalLocal.fromMap(json.decode(item)))
          .toList();
      setState(() {});
    }
  }

  void saveData() {
    List<String> stringList =
        localjournallist.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('list', stringList);
  }

  Widget moodWidget(JournalLocal item) {
    if (item.iconPath == '') {
      return null;
    } else {
      return Container(child: Image.asset(item.iconPath));
    }
  }

  String get getPath {
    final myObj = localjournallist[0];
    return myObj.iconPath;
  }
}

// ListView(
//         children: [
//           Column(
//             children: _localjournal.map((jr) {
//               return Card(
//                   child: Row(
//                 children: [
//                   Column(children: [
//                     SizedBox(
//                       width: 300,
//                       height: 150,
//                       child: Text(
//                         jr.journals,
//                         maxLines: 4,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     Text(jr.createdAt.toString()),
//                   ]),
//                   Icon(Icons.sentiment_dissatisfied, color: Colors.red),
//                 ],
//               ));
//             }).toList(),
//           ),
//         ],
//       ),
