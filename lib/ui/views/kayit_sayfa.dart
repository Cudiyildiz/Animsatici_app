import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animsatici_app/commit/renkler.dart';
import 'package:animsatici_app/ui/cubit/kayitsayfacubit.dart';
import '../../data/entity/notlar.dart';

class KayitSayfa extends StatefulWidget {
  @override
  State<KayitSayfa> createState() => _KayitSayfaState();
}

class _KayitSayfaState extends State<KayitSayfa> {
  var tfMasage = TextEditingController();

  Future<void> guncelle(int not_id, String not_masage) async {
    print("Not Kaydet: $not_id - $not_masage");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: siyah,
      appBar: AppBar(
        backgroundColor: mor,
        title: const Text("Kayit Sayfa",style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(
          color: beyaz,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save,color: beyaz,), // Sağ üst köşede ayarlar ikonu
            onPressed: () {
              context.read<KayitSayfaCubit>().kaydet(tfMasage.text);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // Kenarlardan boşluk bırakmak için padding
        child: Column(
          children: [
            Expanded(
              child: TextField(
                style: TextStyle(
                  color: beyaz,
                ),
                controller: tfMasage,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff333232)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff333232)),
                  ),
                  hintText: "Notunu gir...",
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                maxLines: null, // Sınırsız satır yüksekliği
                expands: true, // TextField'ı genişletir, tüm boş alanı kaplar
                minLines: null, // Minimum satır sayısı yok
              ),
            ),
          ],
        ),
      ),
    );
  }
}
