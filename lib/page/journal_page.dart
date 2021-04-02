import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth2/models/journallocal.dart';
import 'journal_input_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
3/28/2021 Gary- Moved the List of the Journal into Journal Page
*/
class JournalPage extends StatefulWidget {
  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage>
    with TickerProviderStateMixin {
  List<JournalLocal> list = new List<JournalLocal>();
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Journal Page',
          style: TextStyle(color: Colors.grey[850]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => goToJournalLocal(),
      ),
      body: list.isEmpty ? emptyList() : buildListView(),
    );
  }

  // Widget buildBody(){
//   return ListView.builder(itemBuilder: itemBuilder)
// }

  Widget emptyList() {
    return Center(child: Text('No Journals'));
  }

  Widget buildListView() {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return buildItem(list[index], index);
        });
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
        title: Text(item.createdAt),
      ),
      SizedBox(
        width: 300,
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
    list.insert(0, item);
    saveData();
  }

  void gotoEditeJournalView(item) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return JournalInputLocal(item: item);
    })).then((journals) {
      if (journals != null) {
        editJournal(item, journals);
      }
    });
  }

  void editJournal(JournalLocal item, String journals) {
    item.journals = journals;
    saveData();
  }

  void removeJournal(JournalLocal item) {
    list.remove(item);
    saveData();
  }

  void loadData() {
    List<String> listString = sharedPreferences.getStringList('list');
    if (listString != null) {
      list = listString
          .map((item) => JournalLocal.fromMap(json.decode(item)))
          .toList();
      setState(() {});
    }
  }

  void saveData() {
    List<String> stringList =
        list.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('list', stringList);
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
