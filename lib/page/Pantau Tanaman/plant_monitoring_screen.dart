import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';
import 'package:motion_apps/models/plant.dart';
import 'package:motion_apps/widget/plant_card.dart';
import 'package:motion_apps/page/Profil/profile_screen.dart';

class PlantMonitoringScreen extends StatefulWidget {
  const PlantMonitoringScreen({super.key});

  @override
  State<PlantMonitoringScreen> createState() => _PlantMonitoringScreenState();
}

class _PlantMonitoringScreenState extends State<PlantMonitoringScreen> {
  final Color greenNormal = const Color(0xFF179778);
  int _selectedIndex = 1; // Index 1 untuk "Pantau Tanaman"

  // Data Tanaman
  final List<Plant> myPlants = [
    Plant(
      name: "Sawi Pakcoy",
      image: "lib/assets/pakcoy.png",
      level: "Siap Panen",
      time: "5 Hari Lagi",
      color: const Color(0xFF179778),
    ),
    Plant(
      name: "Selada Keriting",
      image: "lib/assets/selada.png",
      level: "Tumbuh Baik",
      time: "12 Hari Lagi",
      color: const Color(0xFF179778),
    ),
    Plant(
      name: "Bayam Hijau",
      image: "lib/assets/bayam.png",
      level: "Fase Awal",
      time: "20 Hari Lagi",
      color: Colors.orange,
    ),
    Plant(
      name: "Stroberi",
      image: "lib/assets/stroberi.png",
      level: "Berbuah",
      time: "3 Hari Lagi",
      color: Colors.redAccent,
    ),
    Plant(
      name: "Tomat Ceri",
      image: "lib/assets/tomat.png",
      level: "Berbunga",
      time: "15 Hari Lagi",
      color: Colors.orange,
    ),
    Plant(
      name: "Seledri",
      image: "lib/assets/seledri.png",
      level: "Penyemaian",
      time: "25 Hari Lagi",
      color: Colors.blueGrey,
    ),
  ];

  // Logika Navigasi
  void _onItemTapped(int index) {
    if (index == 2) return; // Marketplace non-aktif

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Kembali ke Beranda
        Navigator.pop(context);
        break;
      case 1:
        // Sudah di halaman ini
        break;
      case 3:
        // Pindah ke Profil (Ganti halaman ini dengan Profil)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(UniconsLine.arrow_left, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Pantau Tanaman",
          style: GoogleFonts.plusJakartaSans(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(UniconsLine.plus, color: greenNormal),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 20),
          itemCount: myPlants.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            return PlantCard(plant: myPlants[index]);
          },
        ),
      ),
      
      // NAVBAR NAVIGATION
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: greenNormal,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(UniconsLine.estate),
              label: "Beranda",
            ),
            BottomNavigationBarItem(
              icon: Icon(UniconsLine.flower),
              label: "Pantau Tanaman",
            ),
            BottomNavigationBarItem(
              icon: Icon(UniconsLine.shopping_bag),
              label: "Marketplace",
            ),
            BottomNavigationBarItem(
              icon: Icon(UniconsLine.user_circle),
              label: "Profil",
            ),
          ],
        ),
      ),
    );
  }
}