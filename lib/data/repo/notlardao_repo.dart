import 'package:animsatici_app/sqlite/veritabani_yardimcisi.dart';
import '../entity/notlar.dart';

class NotlarDaoRespository{
  Future<void> kaydet(String not_masage) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var yeniNot = Map<String,dynamic>();
    yeniNot["not_mesage"] = not_masage;
    await db.insert("notlar", yeniNot);
  }
  Future<List<Notlar>> notlariYukle() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM notlar");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Notlar(
        not_id: satir["id"] ?? 0,
        not_mesage: satir["not_mesage"] ?? "Bilinmiyor",
      );
    });
  }
  Future<void> guncelle(int not_id, String not_masage) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var guncellenenNot = Map<String, dynamic>();
    guncellenenNot["not_mesage"] = not_masage;

    // Güncelleme işlemi, 'id' sütununa göre yapılacak
    int count = await db.update("notlar", guncellenenNot, where: "id = ?", whereArgs: [not_id]);

    if (count > 0) {
      print("Güncelleme başarılı");
    } else {
      print("Güncelleme başarısız");
    }
  }
  Future<void> sil(int not_id) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    await db.delete("notlar",where: "id = ?", whereArgs: [not_id]);
  }
  Future<List<Notlar>> ara(String aramaKelimesi) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM notlar WHERE not_mesage like '%$aramaKelimesi%'");
    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Notlar(not_id: satir["id"], not_mesage: satir["not_mesage"]);
    });
  }
}