import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animsatici_app/data/repo/notlardao_repo.dart';

class KayitSayfaCubit extends Cubit<void>{
  KayitSayfaCubit():super(0);
  var krepo = NotlarDaoRespository();
  Future<void> kaydet(String not_masage) async{
    await krepo.kaydet(not_masage);
    print("Kayit Sayfa Cubit: Kaydedildi");
  }
}