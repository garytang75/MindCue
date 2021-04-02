import 'package:flutter/foundation.dart';

class JournalLocal {
  String createdAt;
  String journals;

  JournalLocal({@required this.createdAt, @required this.journals});

  JournalLocal.fromMap(Map map)
      : this.createdAt = map['createdAt'],
        this.journals = map['journals'];

  Map toMap() {
    return {
      'createdAt': this.createdAt,
      'journals': this.journals,
    };
  }
}

// final List<Journal> journals = [
//   Journal(
//       userId: 'gary',
//       createdAt: DateTime.now(),
//       journals:
//           "It is always easier to remember things when they are fresh in your brain, so try and write as much as you can while traveling; every day if you can. Your journal entries don’t have to be long, but let them highlight what you feel was most important or exciting. How did you feel during your visit to the local market? What did you smell, taste and hear? Did you learn something new from the person you spoke to at the bar? Were you surprised by the clothes people were wearing? What was the view from the top of the mountain like? Before you go to bed, try and recall what you did that day, what you thought and how you felt. This will serve as a great way to remember more from your trip, but will also help you reflect and grow from what you encountered."),
//   Journal(
//       userId: 'gary',
//       createdAt: DateTime.now(),
//       journals: "abcddfjkd i like thiss!!!!!!!!"),
//   Journal(
//       userId: 'gary',
//       createdAt: DateTime.now(),
//       journals: "abcddfjkd i like thiss!!!!!!!!"),
//   Journal(
//       userId: 'gary',
//       createdAt: DateTime.now(),
//       journals: "abcddfjkd i like thiss!!!!!!!!"),
//   Journal(
//       userId: 'gary',
//       createdAt: DateTime.now(),
//       journals: "abcddfjkd i like thiss!!!!!!!!"),
// ];
