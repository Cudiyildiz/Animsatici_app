import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animsatici_app/commit/renkler.dart';

import '../../data/entity/notlar.dart';
import '../cubit/detaysayfacubit.dart';

class DetaySayfa extends StatefulWidget {
  Notlar not;

  DetaySayfa({required this.not});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  var tfMasage = TextEditingController();

  Future<void> guncelle(int not_id, String not_masage) async {
    print("Not Kaydet: $not_id - $not_masage");
  }

  @override
  void initState() {
    super.initState();
    var not = widget.not;
    tfMasage.text = not.not_mesage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: anaRenk,
      appBar: AppBar(
        backgroundColor: mor,
        title: const Text("Detay Sayfa",style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(
          color: beyaz,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save), // Sağ üst köşede ayarlar ikonu
            onPressed: () {
              context.read<DetaySayfaCubit>().guncelle(widget.not.not_id, tfMasage.text);
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
                  color: siyah,
                ),
                controller: tfMasage,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff333232)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff000000)),
                  ),
                  hintText: "Mesaj",
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
