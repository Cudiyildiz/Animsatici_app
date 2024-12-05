import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animsatici_app/data/repo/notlardao_repo.dart';

class DetaySayfaCubit extends Cubit<void>{
  DetaySayfaCubit():super(0);
  var krepo = NotlarDaoRespository();
  Future<void> guncelle(int not_id,String not_masage) async{
    await krepo.guncelle(not_id, not_masage);
    print("DetaySayfaCubit: Guncelleme tamamlandı.");
  }
}