import '../main.dart';
import '../redux/actions.dart';

abstract class StoreService {
  Future<void> loadNotes(int archived) async {
    if (archived == 0) {
      await store.dispatch(LoadNotesAction());
    } else {
      await store.dispatch(LoadArchiveNotesAction());
    }
  }

  Future<void> loadAllNotes() async {
    await store.dispatch(LoadAllNotesAction());
  }
}
