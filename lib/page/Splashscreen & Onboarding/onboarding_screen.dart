import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_apps/page/Homepage & Flow Utama/home_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final Color greenNormal = const Color(0xFF179778); 
  final Color greenLight = const Color(0xFFE8F5F2);  
  final Color darkGreen = const Color(0xFF093731);  
  final Color whiteInactive = const Color(0xFFFFFFFF).withOpacity(0.2);

  final List<Map<String, String>> _onboardingData = [
    {
      "image": "assets/image 2.png", 
      "title": "Tanam Sayur Segar dari Rumah Tanpa Ribet! 🥕🍅",
      "desc": "Bersama HydropoMe, menanam sayuran untuk hidup lebih sehat dan hemat jadi lebih mudah!"
    },
    {
      "image": "assets/image 3.png",
      "title": "Belanja Starter Kit & Jual Hasil Panen!",
      "desc": "Belanja, jual panen, dan penuhi kebutuhanmu di marketplace kami. Praktis banget buat kamu yang suka berkebun dari rumah!"
    },
  ];

  void _nextPage() {
    if (_currentIndex < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. PageView (Gambar Background)
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    width: double.infinity,
                    child: Image.asset(
                      _onboardingData[index]['image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),

          // 2. Card Hijau Melengkung
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.45, 
            child: ClipPath(
              clipper: CurvedTopClipper(),
              child: Container(
                color: darkGreen, // #093731
                padding: const EdgeInsets.fromLTRB(24, 60, 24, 30), 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          _onboardingData[_currentIndex]['title']!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w700, 
                            height: 1.2, 
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _onboardingData[_currentIndex]['desc']!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 14, 
                            fontWeight: FontWeight.w400, 
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),

                    //Bagian Navigasi Bawah
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _currentIndex > 0
                            ? Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    _pageController.previousPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeIn,
                                    );
                                  },
                                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                                ),
                              )
                            : const SizedBox(width: 42), 
  
                        Row(
                          children: List.generate(
                            _onboardingData.length,
                            (index) {
                              bool isActive = _currentIndex == index;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                
                                height: isActive ? 14 : 12,
                                width: isActive ? 14 : 12,
                                decoration: BoxDecoration(
                                  color: isActive ? greenNormal : whiteInactive,
                                  shape: BoxShape.circle,
                                ),
                              );
                            },
                          ),
                        ),

                        // Tombol Next
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            onPressed: _nextPage,
                            icon: const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

          // 3. Tombol Lewati
          Positioned(
            top: 60,
            right: 20,
            child: Container(
              width: 64,
              height: 36,
              decoration: BoxDecoration(
                color: greenLight, // #E8F5F2
                borderRadius: BorderRadius.circular(12),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  child: Center(
                    child: Text(
                      "Lewati",
                      style: GoogleFonts.plusJakartaSans(
                        color: greenNormal, // #179778
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurvedTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 40); 
    path.quadraticBezierTo(size.width / 2, 100, size.width, 40);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}