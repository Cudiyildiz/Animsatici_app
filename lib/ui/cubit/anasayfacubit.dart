import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animsatici_app/data/entity/notlar.dart';
import 'package:animsatici_app/data/repo/notlardao_repo.dart';


class AnasayfaCubit extends Cubit<List<Notlar>> {
  AnasayfaCubit() : super(<Notlar>[]);
  var krepo = NotlarDaoRespository();

  Future<void> notlariYukle() async {
    try {
      var liste = await krepo.notlariYukle();
      emit(liste);
    } catch (e) {
      print("Hata: $e");
    }
  }
  Future<void> sil(int not_id) async{
    await krepo.sil(not_id);
    await notlariYukle();
  }
  Future<void> ara(String aramaKelimesi) async{
    var liste = await krepo.ara(aramaKelimesi);
    emit(liste);
  }
}
