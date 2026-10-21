import 'package:flutter/material.dart';

void main() {
  runApp(const LearnMateApp());
}

// Nama font serif untuk judul (sesuai tampilan di foto)
const String kSerif = 'serif';

// Controller untuk mengelola state Tema (Light / Dark)
class ThemeController extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
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

          // ================= LIGHT THEME (sesuai foto) =================
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFEEF0F5), // abu terang
            colorScheme: ColorScheme.fromSeed(
              brightness: Brightness.light,
              seedColor: const Color(0xFFD9A93E),
              primary: const Color(0xFF1A2434),
              secondary: const Color(0xFFD9A93E), // emas (menu aktif)
              surface: Colors.white,
            ),
            extensions: const [
              CustomColors(
                accent: Color(0xFFD9A93E),
                cardColor: Colors.white,
                cardBorder: Color(0xFFE6E8EE),
                sidebarBg: Color(0xFF1A2434), // navy
                textPrimary: Color(0xFF1A2434),
                textSecondary: Color(0xFF7A8294),
                badgeBg: Color(0xFFDDE0E6), // warna jalur progress bar
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
              primary: const Color(0xFF6C63FF), // Cosmic Indigo
              secondary: const Color(0xFF9D4EDD), // Nebula Purple
              surface: const Color(0xFF161B33), // Night Sky
            ),
            extensions: const [
              CustomColors(
                accent: Color(0xFF4CC9F0), // Starlight Cyan
                cardColor: Color(0xFF161B33),
                cardBorder: Color(0xFF252D4A),
                sidebarBg: Color(0xFF10162F),
                textPrimary: Color(0xFFFFFFFF),
                textSecondary: Color(0xFF94A3B8),
                badgeBg: Color(0xFF1F2940),
                badgeText: Color(0xFF4CC9F0),
                highlight: Color(0xFFF15BB5), // Galaxy Pink
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

// ======================= HALAMAN PROGRES BELAJAR =======================
class LearnMatePage extends StatelessWidget {
  const LearnMatePage({super.key});

  // Daftar materi + progresnya (0.0 sampai 1.0)
  static const List<(String, double)> materi = [
    ('Pengantar Struktur Data', 0.0),
    ('Dasar-Dasar Basis Data', 0.0),
    ('Metodologi Penelitian', 0.0),
    ('Pengantar Machine Learning', 0.0),
    ('UI/UX untuk Aplikasi Edukasi', 0.0),
    ('Statistik untuk Riset', 0.0),
  ];

  // Kartu ringkasan di bagian atas
  static const List<(String, String)> stats = [
    ('0%', 'Materi selesai'),
    ('0', 'Kuis dikerjakan'),
    ('0%', 'Rata-rata nilai'),
  ];

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<CustomColors>()!;

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
                          padding: EdgeInsets.all(isDesktop ? 24 : 14),
                          children: [
                            // Baris atas: breadcrumb + tombol ganti tema
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Learning Progress',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: c.textSecondary,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    themeController.themeMode == ThemeMode.light
                                        ? Icons.dark_mode_outlined
                                        : Icons.light_mode_outlined,
                                    size: 20,
                                    color: c.accent,
                                  ),
                                  tooltip: 'Ubah Tema',
                                  onPressed: () => themeController.toggleTheme(),
                                ),
                              ],
                            ),
                            Text(
                              'Progres Belajar',
                              style: TextStyle(
                                fontFamily: kSerif,
                                fontSize: 26,
                                color: c.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // 3 kartu ringkasan (desktop: sejajar, mobile: tersusun ke bawah)
                            if (isDesktop)
                              Row(
                                children: [
                                  for (var i = 0; i < stats.length; i++) ...[
                                    if (i > 0) const SizedBox(width: 16),
                                    Expanded(
                                      child: _StatCard(
                                        value: stats[i].$1,
                                        label: stats[i].$2,
                                      ),
                                    ),
                                  ],
                                ],
                              )
                            else
                              Column(
                                children: [
                                  for (var i = 0; i < stats.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: _StatCard(
                                        value: stats[i].$1,
                                        label: stats[i].$2,
                                      ),
                                    ),
                                ],
                              ),
                            SizedBox(height: isDesktop ? 4 : 0),

                            // Kartu "Progres per materi"
                            _SectionCard(
                              title: 'Progres per materi',
                              child: Column(
                                children: [
                                  for (final m in materi)
                                    _ProgressRow(judul: m.$1, nilai: m.$2),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Kartu "Riwayat pembelajaran"
                            _SectionCard(
                              title: 'Riwayat pembelajaran',
                              child: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: c.cardBorder),
                                ),
                                child: Center(
                                  child: Text(
                                    'Belum ada riwayat pembelajaran.',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: c.textSecondary,
                                    ),
                                  ),
                                ),
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
          bottomNavigationBar: isDesktop ? null : const _MobileNavigation(),
        );
      },
    );
  }
}

// Kartu kecil: angka besar + keterangan
class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<CustomColors>()!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: c.cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: c.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontFamily: kSerif,
              fontSize: 22,
              color: c.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 10, color: c.textSecondary),
          ),
        ],
      ),
    );
  }
}

// Kartu putih dengan judul (dipakai untuk "Progres per materi" dan "Riwayat")
class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<CustomColors>()!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: c.cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: c.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: kSerif,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: c.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

// Satu baris progres: nama materi, persen di kanan, bar di bawahnya
class _ProgressRow extends StatelessWidget {
  final String judul;
  final double nilai; // 0.0 - 1.0

  const _ProgressRow({required this.judul, required this.nilai});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<CustomColors>()!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  judul,
                  style: TextStyle(fontSize: 10, color: c.textSecondary),
                ),
              ),
              Text(
                '${(nilai * 100).round()}%',
                style: TextStyle(fontSize: 10, color: c.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: nilai,
              minHeight: 4,
              backgroundColor: c.badgeBg,
              color: c.accent,
            ),
          ),
        ],
      ),
    );
  }
}

// ======================= SIDEBAR DESKTOP =======================
class _DesktopSidebar extends StatelessWidget {
  const _DesktopSidebar();

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<CustomColors>()!;
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
      width: 200,
      color: c.sidebarBg,
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
            final active = index == 2; // "Progress" yang aktif

            return Container(
              margin: const EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                color: active
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                dense: true,
                visualDensity: VisualDensity.compact,
                leading: Icon(
                  item.$1,
                  size: 17,
                  color: active ? c.textPrimary : Colors.white70,
                ),
                title: Text(
                  item.$2,
                  style: TextStyle(
                    fontSize: 12,
                    color: active ? c.textPrimary : Colors.white70,
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

// ======================= HEADER MOBILE =======================
class _MobileHeader extends StatelessWidget {
  const _MobileHeader();

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<CustomColors>()!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      color: c.sidebarBg,
      child: Row(
        children: [
          const _LearnMateLogo(),
          const Spacer(),
          // Tombol menu dengan garis tepi, seperti di foto
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.white30),
            ),
            child: const Icon(Icons.menu, size: 16, color: Colors.white70),
          ),
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
        style: TextStyle(fontFamily: kSerif, fontSize: 15),
        children: [
          TextSpan(
            text: 'Learn',
            style: TextStyle(color: Colors.white),
          ),
          TextSpan(
            text: 'Mate',
            style: TextStyle(color: Color(0xFFD9A93E)),
          ),
        ],
      ),
    );
  }
}

// ======================= NAVIGASI BAWAH (MOBILE) =======================
class _MobileNavigation extends StatelessWidget {
  const _MobileNavigation();

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<CustomColors>()!;
    final gold = Theme.of(context).colorScheme.secondary;

    const items = [
      (Icons.home_outlined, 'Dashboard'),
      (Icons.menu_book_outlined, 'Materi'),
      (Icons.donut_large_outlined, 'Progress'),
      (Icons.quiz_outlined, 'Quiz'),
      (Icons.person_outline, 'Profil'),
    ];
    const selectedIndex = 2; // "Progress"

    return Container(
      color: c.sidebarBg,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          items[i].$1,
                          size: 18,
                          color: i == selectedIndex ? gold : Colors.white60,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          items[i].$2,
                          style: TextStyle(
                            fontSize: 9,
                            color: i == selectedIndex ? gold : Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
