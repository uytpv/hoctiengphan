import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/grammar.dart';

final grammarRepositoryProvider = Provider<GrammarRepository>((ref) {
  return GrammarRepository(FirebaseFirestore.instance);
});

final grammarsStreamProvider = StreamProvider<List<Grammar>>((ref) {
  final repository = ref.watch(grammarRepositoryProvider);
  return repository.watchGrammars();
});

class GrammarRepository {
  final FirebaseFirestore _firestore;

  GrammarRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('grammars');

  Stream<List<Grammar>> watchGrammars() {
    return _collection.snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => Grammar.fromJson({...doc.data(), 'id': doc.id}))
          .toList(),
    );
  }

  Future<void> createGrammar(Grammar grammar) async {
    final data = grammar.toJson();
    data.remove('id');
    await _collection.add(data);
  }

  Future<void> updateGrammar(Grammar grammar) async {
    final data = grammar.toJson();
    data.remove('id');
    await _collection.doc(grammar.id).set(data, SetOptions(merge: true));
  }

  Future<void> deleteGrammar(String id) async {
    await _collection.doc(id).delete();
  }
}
