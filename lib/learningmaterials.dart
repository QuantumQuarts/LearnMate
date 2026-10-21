import 'package:flutter/material.dart';

void main() {
  runApp(const LearnMateApp());
}

// Controller untuk mengelola state Tema (Light / Dark)
class ThemeController extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

final themeController = ThemeController();

class LearnMateApp extends StatelessWidget {
  const LearnMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'LearnMate',
          themeMode: themeController.themeMode,
          
          // ================= LIGHT THEME: MORNING VILLAGE =================
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF8FAF5), // Morning Mist
            colorScheme: ColorScheme.fromSeed(
              brightness: Brightness.light,
              seedColor: const Color(0xFF7FB77E),
              primary: const Color(0xFF7FB77E),      // Sage Green
              secondary: const Color(0xFFF4D35E),    // Warm Sunrise Yellow
              surface: const Color(0xFFFFFDF5),      // Rice Field Cream
            ),
            extensions: const [
              CustomColors(
                accent: Color(0xFFA8DADC),           // Sky Blue
                cardColor: Color(0xFFFFFDF5),
                cardBorder: Color(0xFFE5EAE2),
                sidebarBg: Color(0xFF26352F),
                textPrimary: Color(0xFF26352D),
                textSecondary: Color(0xFF778078),
                badgeBg: Color(0xFFE9EDE7),
                badgeText: Color(0xFF59645B),
                highlight: Color(0xFFF15BB5),
              ),
            ],
          ),

          // ================= DARK THEME: GALAXY NIGHT =================
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF0B1020), // Deep Space
            colorScheme: ColorScheme.fromSeed(
              brightness: Brightness.dark,
              seedColor: const Color(0xFF6C63FF),
              primary: const Color(0xFF6C63FF),      // Cosmic Indigo
              secondary: const Color(0xFF9D4EDD),    // Nebula Purple
              surface: const Color(0xFF161B33),      // Night Sky
            ),
            extensions: const [
              CustomColors(
                accent: Color(0xFF4CC9F0),           // Starlight Cyan
                cardColor: Color(0xFF161B33),
                cardBorder: Color(0xFF252D4A),
                sidebarBg: Color(0xFF10162F),
                textPrimary: Color(0xFFFFFFFF),
                textSecondary: Color(0xFF94A3B8),
                badgeBg: Color(0xFF1F2940),
                badgeText: Color(0xFF4CC9F0),
                highlight: Color(0xFFF15BB5),        // Galaxy Pink
              ),
            ],
          ),

          home: const LearnMatePage(),
        );
      },
    );
  }
}

// Extension untuk memudahkan akses warna kustom sesuai tema aktif
class CustomColors extends ThemeExtension<CustomColors> {
  final Color accent;
  final Color cardColor;
  final Color cardBorder;
  final Color sidebarBg;
  final Color textPrimary;
  final Color textSecondary;
  final Color badgeBg;
  final Color badgeText;
  final Color highlight;

  const CustomColors({
    required this.accent,
    required this.cardColor,
    required this.cardBorder,
    required this.sidebarBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.badgeBg,
    required this.badgeText,
    required this.highlight,
  });

  @override
  CustomColors copyWith({
    Color? accent,
    Color? cardColor,
    Color? cardBorder,
    Color? sidebarBg,
    Color? textPrimary,
    Color? textSecondary,
    Color? badgeBg,
    Color? badgeText,
    Color? highlight,
  }) {
    return CustomColors(
      accent: accent ?? this.accent,
      cardColor: cardColor ?? this.cardColor,
      cardBorder: cardBorder ?? this.cardBorder,
      sidebarBg: sidebarBg ?? this.sidebarBg,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      badgeBg: badgeBg ?? this.badgeBg,
      badgeText: badgeText ?? this.badgeText,
      highlight: highlight ?? this.highlight,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;
    return CustomColors(
      accent: Color.lerp(accent, other.accent, t)!,
      cardColor: Color.lerp(cardColor, other.cardColor, t)!,
      cardBorder: Color.lerp(cardBorder, other.cardBorder, t)!,
      sidebarBg: Color.lerp(sidebarBg, other.sidebarBg, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      badgeBg: Color.lerp(badgeBg, other.badgeBg, t)!,
      badgeText: Color.lerp(badgeText, other.badgeText, t)!,
      highlight: Color.lerp(highlight, other.highlight, t)!,
    );
  }
}

class LearnMatePage extends StatelessWidget {
  const LearnMatePage({super.key});

  static const List<Map<String, String>> materi = [
    {
      'judul': 'Pengantar Struktur Data',
      'kategori': 'Ilmu Komputer',
      'deskripsi': 'Konsep dasar array, linked list, stack, dan queue.',
    },
    {
      'judul': 'Dasar-Dasar Basis Data',
      'kategori': 'Ilmu Komputer',
      'deskripsi': 'Model relasional, normalisasi, dan query SQL dasar.',
    },
    {
      'judul': 'Metodologi Penelitian',
      'kategori': 'Metodologi',
      'deskripsi': 'Anatomi riset, research gap, dan tahapan proses penelitian.',
    },
    {
      'judul': 'Pengantar Machine Learning',
      'kategori': 'Kecerdasan Buatan',
      'deskripsi': 'Pengenalan supervised dan unsupervised learning.',
    },
    {
      'judul': 'UI/UX untuk Aplikasi Edukasi',
      'kategori': 'Desain',
      'deskripsi': 'Prinsip desain antarmuka yang ramah untuk pembelajar.',
    },
    {
      'judul': 'Statistik untuk Riset',
      'kategori': 'Metodologi',
      'deskripsi': 'Probabilitas, uji hipotesis, dan interpretasi hasil.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 700;

        return Scaffold(
          body: SafeArea(
            child: Row(
              children: [
                if (isDesktop) const _DesktopSidebar(),
                Expanded(
                  child: Column(
                    children: [
                      if (!isDesktop) const _MobileHeader(),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.all(isDesktop ? 24 : 16),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Learning Materials',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: customColors.textSecondary,
                                  ),
                                ),
                                // Tombol Ganti Tema (Light / Dark)
                                IconButton(
                                  icon: Icon(
                                    themeController.themeMode == ThemeMode.light
                                        ? Icons.dark_mode_outlined
                                        : Icons.light_mode_outlined,
                                    size: 20,
                                    color: customColors.accent,
                                  ),
                                  tooltip: 'Ubah Tema',
                                  onPressed: () => themeController.toggleTheme(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Daftar Materi',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: customColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const _CategoryRow(),
                            const SizedBox(height: 12),
                            ...materi.map(
                              (item) => Padding(
                                padding: const EdgeInsets.only(bottom: 9),
                                child: _MateriCard(
                                  judul: item['judul']!,
                                  kategori: item['kategori']!,
                                  deskripsi: item['deskripsi']!,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Progres pengembangan: 25%',
                              style: TextStyle(
                                fontSize: 12,
                                color: customColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: LinearProgressIndicator(
                                value: 0.25,
                                minHeight: 6,
                                backgroundColor: customColors.badgeBg,
                                color: customColors.accent, // Menggunakan warna Accent sesuai tema
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar:
              isDesktop ? null : const _MobileNavigation(),
        );
      },
    );
  }
}

class _DesktopSidebar extends StatelessWidget {
  const _DesktopSidebar();

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    const items = [
      (Icons.home_outlined, 'Dashboard'),
      (Icons.menu_book_outlined, 'Materi'),
      (Icons.donut_large_outlined, 'Progress'),
      (Icons.quiz_outlined, 'Quiz'),
      (Icons.calendar_month_outlined, 'Jadwal'),
      (Icons.forum_outlined, 'Diskusi'),
      (Icons.person_outline, 'Profil'),
    ];

    return Container(
      width: 190,
      color: customColors.sidebarBg,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(7, 8, 0, 28),
            child: _LearnMateLogo(),
          ),
          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final active = index == 1;

            return Container(
              margin: const EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                color: active ? Theme.of(context).colorScheme.secondary : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                dense: true,
                visualDensity: VisualDensity.compact,
                leading: Icon(
                  item.$1,
                  size: 17,
                  color: active ? customColors.textPrimary : Colors.white70,
                ),
                title: Text(
                  item.$2,
                  style: TextStyle(
                    fontSize: 12,
                    color: active ? customColors.textPrimary : Colors.white70,
                    fontWeight: active ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                onTap: () {},
              ),
            );
          }),
          const Spacer(),
          const Divider(color: Colors.white24),
          const Text(
            'user1',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
          const Text(
            '@Agornya',
            style: TextStyle(color: Colors.white60, fontSize: 10),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 34),
              side: const BorderSide(color: Colors.white30),
            ),
            child: const Text('Keluar', style: TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }
}

class _MobileHeader extends StatelessWidget {
  const _MobileHeader();

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      color: customColors.cardColor,
      child: const Row(
        children: [
          _LearnMateLogo(),
          Spacer(),
          Icon(Icons.menu, size: 22),
        ],
      ),
    );
  }
}

class _LearnMateLogo extends StatelessWidget {
  const _LearnMateLogo();

  @override
  Widget build(BuildContext context) {
    return const Text.rich(
      TextSpan(
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: 'Learn',
            style: TextStyle(color: Color(0xFFF8FAF5)),
          ),
          TextSpan(
            text: 'Mate',
            style: TextStyle(color: Color(0xFFF4D35E)),
          ),
        ],
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow();

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    const categories = [
      'Semua',
      'Ilmu Komputer',
      'Metodologi',
      'Kecerdasan Buatan',
      'Desain',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.asMap().entries.map((entry) {
          final selected = entry.key == 0;

          return Padding(
            padding: const EdgeInsets.only(right: 7),
            child: Chip(
              label: Text(entry.value),
              labelStyle: TextStyle(
                fontSize: 10,
                color: selected ? customColors.textPrimary : customColors.textSecondary,
              ),
              backgroundColor: selected
                  ? Theme.of(context).colorScheme.secondary
                  : customColors.cardColor,
              side: BorderSide.none,
              padding: const EdgeInsets.symmetric(horizontal: 3),
              visualDensity: VisualDensity.compact,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _MateriCard extends StatelessWidget {
  final String judul;
  final String kategori;
  final String deskripsi;

  const _MateriCard({
    required this.judul,
    required this.kategori,
    required this.deskripsi,
  });

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return Card(
      color: customColors.cardColor,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: customColors.cardBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: customColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$kategori · $deskripsi',
                    style: TextStyle(
                      fontSize: 10,
                      height: 1.3,
                      color: customColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: customColors.badgeBg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'belum',
                style: TextStyle(fontSize: 9, color: customColors.badgeText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MobileNavigation extends StatelessWidget {
  const _MobileNavigation();

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: 1,
      onDestinationSelected: (index) {},
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          label: 'Beranda',
        ),
        NavigationDestination(
          icon: Icon(Icons.menu_book_outlined),
          label: 'Materi',
        ),
        NavigationDestination(
          icon: Icon(Icons.donut_large_outlined),
          label: 'Progres',
        ),
        NavigationDestination(
          icon: Icon(Icons.quiz_outlined),
          label: 'Quiz',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          label: 'Profil',
        ),
      ],
    );
  }
}