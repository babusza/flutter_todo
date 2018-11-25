import 'package:cloud_firestore/cloud_firestore.dart';

class TodoItem /*extends Comparable */{
  final DocumentReference reference;
  final int id;
  final String name;
  bool isComplete;

  TodoItem({this.id, this.name, this.isComplete = false, this.reference});
/*
  @override
  int compareTo(other) {
    if (this.isComplete && !other.isComplete) {
      return 1;
    } else if (!this.isComplete && other.isComplete) {
      return -1;
    } else {
      return this.id.compareTo(other.id);
    }
  }
*/
  TodoItem.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['id'] != null),
        assert(map['name'] != null),
        assert(map['isComplete'] != null),
        id = map['id'],
        name = map['name'],
        isComplete = map['isComplete'];

  TodoItem.fromSnapshot(DocumentSnapshot documentSnapshot)
      : this.fromMap(documentSnapshot.data, reference: documentSnapshot.reference);

}
