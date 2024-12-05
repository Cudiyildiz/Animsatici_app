import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animsatici_app/commit/renkler.dart';
import 'package:animsatici_app/data/entity/notlar.dart';
import 'package:animsatici_app/ui/cubit/anasayfacubit.dart';
import 'package:animsatici_app/ui/views/detay_sayfa.dart';
import 'package:animsatici_app/ui/views/kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;

  Future<void> sil(int kisi_id) async {
    print("Kişi Silindi : $kisi_id");
    // Burada silme işlemini gerçekleştirebilirsiniz.
  }

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().notlariYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: anaRenk,
      appBar: AppBar(
        backgroundColor: mor,
        title: aramaYapiliyorMu
            ? TextField(
          style: TextStyle(
            color: beyaz,
          ),
          decoration: InputDecoration(hintText: "Ara",hintStyle: TextStyle(color: Colors.white70)),
          onChanged: (aramaSonucu) {
            context.read<AnasayfaCubit>().ara(aramaSonucu);
          },
        )
            : const Text(
          "Yapılacaklar Listesi",
          style: TextStyle(color: Colors.white,fontFamily: "popins"),
        ),
        actions: [
          aramaYapiliyorMu
              ? IconButton(
              onPressed: () {
                setState(() {
                  aramaYapiliyorMu = false;
                });
              },
              icon: Icon(Icons.clear, color: beyaz))
              : IconButton(
              onPressed: () {
                setState(() {
                  aramaYapiliyorMu = true;
                });
              },
              icon: Icon(Icons.search, color: beyaz))
        ],
      ),
      body: BlocBuilder<AnasayfaCubit, List<Notlar>>(
        builder: (context, notlarListesi) {
          if (notlarListesi.isNotEmpty) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // İki kart yan yana
                crossAxisSpacing: 10, // Kartlar arasındaki yatay boşluk
                mainAxisSpacing: 10, // Kartlar arasındaki dikey boşluk
                childAspectRatio: 3 / 2, // Kartların boy/en oranı
              ),
              itemCount: notlarListesi.length,
              itemBuilder: (context, indeks) {
                var kisi = notlarListesi[indeks];
                bool isLongPressed = false;
                return GestureDetector(
                  onLongPress: () {
                    setState(() {
                      isLongPressed = true;
                    });
                  },
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetaySayfa(not: kisi)))
                        .then((value) {
                      context.read<AnasayfaCubit>().notlariYukle();
                      print("Anasayfaya dönüldü");
                    });
                  },
                  child: Dismissible(
                    key: Key(kisi.not_id.toString()),
                    direction: DismissDirection.endToStart, // Sadece sağdan sola kaydırma
                    onDismissed: (direction) {
                      context.read<AnasayfaCubit>().sil(kisi.not_id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${kisi.not_mesage} silindi.")),
                      );
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Card(
                      color: siyah,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      kisi.not_mesage,
                                      style: TextStyle(fontSize: 18, color: beyaz),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isLongPressed)
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                onPressed: () {
                                  context.read<AnasayfaCubit>().sil(kisi.not_id);
                                  setState(() {
                                    isLongPressed = false;
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 35,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("Henüz not yok.")); // Not yoksa gösterilecek mesaj
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => KayitSayfa())).then((value){
            context.read<AnasayfaCubit>().notlariYukle();
          });
        },
        backgroundColor: siyah,
        child: const Icon(Icons.add, color: Colors.white, size: 35),
      ),
    );
  }
}
