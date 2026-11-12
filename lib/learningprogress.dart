import 'package:flutter/material.dart';

// =====================================================================
// LearnMate — Learning Progress
// Implementasi Lengkap Kurikulum Pertemuan 1 - 7:
// • M01: Flutter Fundamentals (MaterialApp, Scaffold, Widget, ThemeData, Hot Reload)
// • M02: Vibe Code (Profil Mahasiswa Pembelajar, Context & Constraint)
// • M03: Basic Components & Reusable Widgets (Text, Icon, Image, RichText, CircleAvatar)
// • M04: Material Design 3 (Color System ThemeExtension, Typography, Spacing, Visual Hierarchy)
// • M05: Single-Child Widgets (Container, Padding, SizedBox, Center, Align, ClipRRect)
// • M06: Multi-Child Layout & Carousel (Row, Column, Expanded, Stack, Positioned, ListView.builder, PageView Swipe)
// • M07: Responsive & Adaptive UI (LayoutBuilder, Mobile/Tablet/Desktop Breakpoints, Adaptive Carousel)
//
// Light Theme : Morning Village   |   Dark Theme : Galaxy Night
// =====================================================================

void main() => runApp(const LearnMateApp());

/// -------------------------------------------------------------------
/// M01 & M04: THEME CONTROLLER & SYSTEM TEMA DUAL-MODE
/// -------------------------------------------------------------------
class ThemeController extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.light;
  ThemeMode get mode => _mode;

  void toggle() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

final themeController = ThemeController();

/// -------------------------------------------------------------------
/// M04: CUSTOM COLORS (ThemeExtension) — Material Design 3
/// -------------------------------------------------------------------
class CustomColors extends ThemeExtension<CustomColors> {
  final Color accent; // tombol & progress bar
  final Color onAccent; // teks di atas accent
  final Color cardColor;
  final Color cardBorder;
  final Color emptyBg; // latar empty state
  final Color sidebarBg;
  final Color sidebarText;
  final Color activeBg; // menu aktif
  final Color activeFg;
  final Color brand; // kata "Mate" di logo
  final Color brandLearn; // kata "Learn" di logo
  final Color textPrimary;
  final Color textSecondary;
  final Color badgeBg;
  final Color highlight; // achievement / badge

  const CustomColors({
    required this.accent,
    required this.onAccent,
    required this.cardColor,
    required this.cardBorder,
    required this.emptyBg,
    required this.sidebarBg,
    required this.sidebarText,
    required this.activeBg,
    required this.activeFg,
    required this.brand,
    required this.brandLearn,
    required this.textPrimary,
    required this.textSecondary,
    required this.badgeBg,
    required this.highlight,
  });

  // Morning Village (Light Mode)
  static const light = CustomColors(
    accent: Color(0xFFA8DADC), // Sky Blue
    onAccent: Color(0xFF1F3B3D),
    cardColor: Color(0xFFFFFDF5), // Rice Field Cream
    cardBorder: Color(0xFFE5EAE2),
    emptyBg: Color(0xFFF3F6EE),
    sidebarBg: Color(0xFF26352F),
    sidebarText: Color(0xFFF8FAF5),
    activeBg: Color(0xFFF4D35E), // Warm Sunrise Yellow
    activeFg: Color(0xFF26352D),
    brand: Color.fromARGB(255, 190, 224, 18), // "Mate" kuning-hijau
    brandLearn: Color.fromARGB(255, 9, 157, 29), // "Learn" hijau
    textPrimary: Color(0xFF26352D),
    textSecondary: Color(0xFF6B766D),
    badgeBg: Color(0xFFE9EDE7),
    highlight: Color(0xFFF15BB5),
  );

  // Galaxy Night (Dark Mode)
  static const dark = CustomColors(
    accent: Color(0xFF4CC9F0), // Starlight Cyan
    onAccent: Color(0xFF0B1020),
    cardColor: Color(0xFF161B33), // Night Sky
    cardBorder: Color(0xFF252D4A),
    emptyBg: Color(0xFF121830),
    sidebarBg: Color(0xFF10162F),
    sidebarText: Color(0xFFF1F5F9),
    activeBg: Color(0xFF6C63FF), // Cosmic Indigo
    activeFg: Color(0xFFFFFFFF),
    brand: Color(0xFFB07CFF), // "Mate" ungu
    brandLearn: Color(0xFF4D6BFE), // "Learn" biru tua
    textPrimary: Color(0xFFF8FAFC),
    textSecondary: Color(0xFF94A3B8),
    badgeBg: Color(0xFF1F2940),
    highlight: Color(0xFFF15BB5), // Galaxy Pink
  );

  @override
  CustomColors copyWith({
    Color? accent,
    Color? onAccent,
    Color? cardColor,
    Color? cardBorder,
    Color? emptyBg,
    Color? sidebarBg,
    Color? sidebarText,
    Color? activeBg,
    Color? activeFg,
    Color? brand,
    Color? brandLearn,
    Color? textPrimary,
    Color? textSecondary,
    Color? badgeBg,
    Color? highlight,
  }) {
    return CustomColors(
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      cardColor: cardColor ?? this.cardColor,
      cardBorder: cardBorder ?? this.cardBorder,
      emptyBg: emptyBg ?? this.emptyBg,
      sidebarBg: sidebarBg ?? this.sidebarBg,
      sidebarText: sidebarText ?? this.sidebarText,
      activeBg: activeBg ?? this.activeBg,
      activeFg: activeFg ?? this.activeFg,
      brand: brand ?? this.brand,
      brandLearn: brandLearn ?? this.brandLearn,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      badgeBg: badgeBg ?? this.badgeBg,
      highlight: highlight ?? this.highlight,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return CustomColors(
      accent: l(accent, other.accent),
      onAccent: l(onAccent, other.onAccent),
      cardColor: l(cardColor, other.cardColor),
      cardBorder: l(cardBorder, other.cardBorder),
      emptyBg: l(emptyBg, other.emptyBg),
      sidebarBg: l(sidebarBg, other.sidebarBg),
      sidebarText: l(sidebarText, other.sidebarText),
      activeBg: l(activeBg, other.activeBg),
      activeFg: l(activeFg, other.activeFg),
      brand: l(brand, other.brand),
      brandLearn: l(brandLearn, other.brandLearn),
      textPrimary: l(textPrimary, other.textPrimary),
      textSecondary: l(textSecondary, other.textSecondary),
      badgeBg: l(badgeBg, other.badgeBg),
      highlight: l(highlight, other.highlight),
    );
  }
}

extension ThemeX on BuildContext {
  CustomColors get cc => Theme.of(this).extension<CustomColors>()!;
  ColorScheme get cs => Theme.of(this).colorScheme;

  // Warna aksen kontras untuk ikon & elemen penting
  Color get tone => Color.lerp(cs.primary, cc.textPrimary, 0.25)!;
}

/// -------------------------------------------------------------------
/// M01: MATERIAL APP & THEME BUILDER
/// -------------------------------------------------------------------
ThemeData _buildTheme({
  required Brightness brightness,
  required Color primary,
  required Color secondary,
  required Color surface,
  required Color background,
  required CustomColors colors,
}) {
  final scheme = ColorScheme.fromSeed(
    seedColor: primary,
    brightness: brightness,
  ).copyWith(primary: primary, secondary: secondary, surface: surface);

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: scheme,
    scaffoldBackgroundColor: background,
    extensions: [colors],
  );
}

class LearnMateApp extends StatelessWidget {
  const LearnMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'LearnMate - Learning Progress',
          themeMode: themeController.mode,
          theme: _buildTheme(
            brightness: Brightness.light,
            primary: const Color(0xFF7FB77E), // Sage Green
            secondary: const Color(0xFFF4D35E), // Warm Sunrise Yellow
            surface: const Color(0xFFFFFDF5), // Rice Field Cream
            background: const Color(0xFFF8FAF5), // Morning Mist
            colors: CustomColors.light,
          ),
          darkTheme: _buildTheme(
            brightness: Brightness.dark,
            primary: const Color(0xFF6C63FF), // Cosmic Indigo
            secondary: const Color(0xFF9D4EDD), // Nebula Purple
            surface: const Color(0xFF161B33), // Night Sky
            background: const Color(0xFF0B1020), // Deep Space
            colors: CustomColors.dark,
          ),
          home: const ProgressShell(),
        );
      },
    );
  }
}

/// -------------------------------------------------------------------
/// DATA MODELS (M02 & M03 & M06)
/// -------------------------------------------------------------------
class NavItem {
  final String label;
  final IconData icon;
  const NavItem(this.label, this.icon);
}

const navItems = <NavItem>[
  NavItem('Dashboard', Icons.dashboard_rounded),
  NavItem('Materi', Icons.menu_book_rounded),
  NavItem('Progress', Icons.insights_rounded),
  NavItem('Quiz', Icons.quiz_rounded),
  NavItem('Jadwal', Icons.calendar_month_rounded),
  NavItem('Diskusi', Icons.forum_rounded),
  NavItem('Profil', Icons.person_rounded),
];

class ProgressMaterial {
  final String title;
  final String category;
  final IconData icon;
  final double progress; // 0.0 sampai 1.0

  const ProgressMaterial({
    required this.title,
    required this.category,
    required this.icon,
    required this.progress,
  });
}

const progressList = <ProgressMaterial>[
  ProgressMaterial(
    title: 'Pengantar Struktur Data',
    category: 'Fundamental',
    icon: Icons.account_tree_rounded,
    progress: 0.0,
  ),
  ProgressMaterial(
    title: 'Dasar-Dasar Basis Data',
    category: 'Data',
    icon: Icons.storage_rounded,
    progress: 0.0,
  ),
  ProgressMaterial(
    title: 'Metodologi Penelitian',
    category: 'Riset',
    icon: Icons.biotech_rounded,
    progress: 0.0,
  ),
  ProgressMaterial(
    title: 'Pengantar Machine Learning',
    category: 'Kecerdasan Buatan',
    icon: Icons.psychology_rounded,
    progress: 0.0,
  ),
  ProgressMaterial(
    title: 'UI/UX untuk Aplikasi Edukasi',
    category: 'Desain',
    icon: Icons.palette_rounded,
    progress: 0.0,
  ),
  ProgressMaterial(
    title: 'Statistik untuk Riset',
    category: 'Data',
    icon: Icons.analytics_rounded,
    progress: 0.0,
  ),
];

class MilestoneItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String badgeText;
  final Color badgeColor;

  const MilestoneItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.badgeText,
    required this.badgeColor,
  });
}

const milestoneList = <MilestoneItem>[
  MilestoneItem(
    title: 'Target Belajar Mingguan',
    subtitle: 'Selesaikan minimal 2 materi fundamental minggu ini.',
    icon: Icons.track_changes_rounded,
    badgeText: '0 / 2 Selesai',
    badgeColor: Color(0xFF4CC9F0),
  ),
  MilestoneItem(
    title: 'Streak Pembelajar Aktif',
    subtitle: 'Belajar berturut-turut untuk membangun kebiasaan ngoding.',
    icon: Icons.local_fire_department_rounded,
    badgeText: '0 Hari Streak',
    badgeColor: Color(0xFFF4D35E),
  ),
  MilestoneItem(
    title: 'Evaluasi & Nilai Kuis',
    subtitle: 'Uji pemahaman topikmu lewat kuis interaktif di setiap modul.',
    icon: Icons.military_tech_rounded,
    badgeText: 'Level: Pemula',
    badgeColor: Color(0xFFF15BB5),
  ),
];

/// -------------------------------------------------------------------
/// M07 & M01: RESPONSIVE SHELL DENGAN SCAFFOLD & LAYOUTBUILDER
/// -------------------------------------------------------------------
class ProgressShell extends StatefulWidget {
  const ProgressShell({super.key});

  @override
  State<ProgressShell> createState() => _ProgressShellState();
}

class _ProgressShellState extends State<ProgressShell> {
  // Index 2 = menu "Progress" aktif
  int selected = 2;

  @override
  Widget build(BuildContext context) {
    final c = context.cc;

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final isMobile = w < 700;
        final isTablet = w >= 700 && w < 1000;

        void onSelect(int i) {
          setState(() => selected = i);
          if (isMobile) Navigator.of(context).maybePop();
        }

        return Scaffold(
          // Mobile Top Bar
          appBar: isMobile
              ? AppBar(
                  backgroundColor: c.sidebarBg,
                  foregroundColor: c.sidebarText,
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                  title: const BrandText(size: 20),
                  actions: [
                    ThemeToggleButton(color: c.sidebarText),
                    const SizedBox(width: 4),
                  ],
                )
              : null,
          // Mobile Drawer (bisa di-swipe buka/tutup dari kiri)
          drawer: isMobile
              ? Drawer(
                  backgroundColor: c.sidebarBg,
                  shape: const RoundedRectangleBorder(),
                  child: Sidebar(
                    compact: false,
                    selected: selected,
                    onSelect: onSelect,
                  ),
                )
              : null,
          // Desktop & Tablet Layout
          body: Row(
            children: [
              if (!isMobile)
                SizedBox(
                  width: isTablet ? 84 : 256,
                  child: Sidebar(
                    compact: isTablet,
                    selected: selected,
                    onSelect: onSelect,
                  ),
                ),
              Expanded(child: ProgressBody(isMobile: isMobile)),
            ],
          ),
        );
      },
    );
  }
}

/// -------------------------------------------------------------------
/// M03: REUSABLE BRAND LOGO DENGAN RICHTEXT
/// -------------------------------------------------------------------
class BrandText extends StatelessWidget {
  final double size;
  const BrandText({super.key, this.size = 22});

  @override
  Widget build(BuildContext context) {
    final c = context.cc;
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
          color: c.brandLearn, // "Learn"
        ),
        children: [
          const TextSpan(text: 'Learn'),
          TextSpan(text: 'Mate', style: TextStyle(color: c.brand)), // "Mate"
        ],
      ),
    );
  }
}

/// -------------------------------------------------------------------
/// M01: THEME TOGGLE BUTTON
/// -------------------------------------------------------------------
class ThemeToggleButton extends StatelessWidget {
  final Color color;
  const ThemeToggleButton({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return IconButton(
      tooltip: isDark ? 'Mode terang' : 'Mode gelap',
      onPressed: themeController.toggle,
      icon: Icon(
        isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
        color: color,
      ),
    );
  }
}

/// -------------------------------------------------------------------
/// M03, M05, M06: SIDEBAR REUSABLE COMPONENT
/// -------------------------------------------------------------------
class Sidebar extends StatelessWidget {
  final bool compact;
  final int selected;
  final ValueChanged<int> onSelect;

  const Sidebar({
    super.key,
    required this.compact,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.cc;
    final muted = c.sidebarText.withAlpha(190);

    return Container(
      color: c.sidebarBg,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: compact ? 12 : 16, vertical: 20),
          child: Column(
            children: [
              // Logo & Brand Header
              Row(
                mainAxisAlignment: compact
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      gradient: LinearGradient(
                        colors: [context.cs.primary, context.cs.secondary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Icon(Icons.terminal_rounded,
                        color: c.activeFg, size: 22),
                  ),
                  if (!compact) ...[
                    const SizedBox(width: 10),
                    const BrandText(),
                  ],
                ],
              ),
              const SizedBox(height: 28),

              // Menu Navigasi
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: navItems.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 6),
                  itemBuilder: (_, i) => _NavTile(
                    item: navItems[i],
                    selected: i == selected,
                    compact: compact,
                    onTap: () => onSelect(i),
                  ),
                ),
              ),

              // Bagian Bawah: Switch Tema & Keluar
              if (compact) ...[
                ThemeToggleButton(color: muted),
                Tooltip(
                  message: 'Keluar',
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.logout_rounded, color: muted),
                  ),
                ),
              ] else
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.logout_rounded, size: 18),
                    label: const Text('Keluar'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: muted,
                      side: BorderSide(color: c.sidebarText.withAlpha(50)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
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

class _NavTile extends StatelessWidget {
  final NavItem item;
  final bool selected;
  final bool compact;
  final VoidCallback onTap;

  const _NavTile({
    required this.item,
    required this.selected,
    required this.compact,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.cc;
    final fg = selected ? c.activeFg : c.sidebarText.withAlpha(190);

    final tile = Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 46,
          padding: EdgeInsets.symmetric(horizontal: compact ? 0 : 14),
          decoration: BoxDecoration(
            color: selected ? c.activeBg : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment:
                compact ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              Icon(item.icon, size: 20, color: fg),
              if (!compact) ...[
                const SizedBox(width: 12),
                Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: fg,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );

    return compact ? Tooltip(message: item.label, child: tile) : tile;
  }
}

/// -------------------------------------------------------------------
/// M02, M03, M06: KARTU PROFIL MAHASISWA PEMBELAJAR (CIRCLEAVATAR + STACK)
/// -------------------------------------------------------------------
class _StudentProfileCard extends StatelessWidget {
  const _StudentProfileCard();

  @override
  Widget build(BuildContext context) {
    final c = context.cc;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: c.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: c.cardBorder),
      ),
      child: Row(
        children: [
          // M03 & M06: CircleAvatar + Stack & Positioned untuk Badge Status
          Stack(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: context.cs.primary.withAlpha(50),
                child: ClipOval(
                  child: Image.network(
                    'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150',
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.person_rounded,
                      size: 30,
                      color: context.tone,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E), // Status online hijau
                    shape: BoxShape.circle,
                    border: Border.all(color: c.cardColor, width: 2.5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Informasi Profil Mahasiswa (M02)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Mahasiswa Pembelajar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: c.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: context.cs.primary.withAlpha(40),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Aktif',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: context.tone,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  'Universitas Mikroskil • S1 Informatika',
                  style: TextStyle(fontSize: 12, color: c.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// -------------------------------------------------------------------
/// M06 & M07: SWIPEABLE CAROUSEL CARD (PAGEVIEW HORIZONTAL SWIPE)
/// Fitur Swipe: di mobile/tablet bisa di-swipe horizontal,
/// di layar lebar otomatis adaptif menjadi 3 kolom sejajar.
/// -------------------------------------------------------------------
class MilestoneCarousel extends StatefulWidget {
  final bool isMobile;
  const MilestoneCarousel({super.key, required this.isMobile});

  @override
  State<MilestoneCarousel> createState() => _MilestoneCarouselState();
}

class _MilestoneCarouselState extends State<MilestoneCarousel> {
  late final PageController _pageController;
  int _activePage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.94);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.cc;

    // Di desktop lebar: tampilkan 3 kolom langsung berdampingan
    if (!widget.isMobile) {
      return Row(
        children: [
          for (int i = 0; i < milestoneList.length; i++) ...[
            Expanded(child: _MilestoneCard(item: milestoneList[i])),
            if (i != milestoneList.length - 1) const SizedBox(width: 14),
          ],
        ],
      );
    }

    // Di mobile: Tampilkan Carousel Swipeable horizontal dengan indikator titik (Page Indicator)
    return Column(
      children: [
        SizedBox(
          height: 128,
          child: PageView.builder(
            controller: _pageController,
            itemCount: milestoneList.length,
            onPageChanged: (page) => setState(() => _activePage = page),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _MilestoneCard(item: milestoneList[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        // Indikator Titik Swipe (Dots Indicator)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < milestoneList.length; i++)
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _activePage == i ? 18 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: _activePage == i ? c.accent : c.badgeBg,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _MilestoneCard extends StatelessWidget {
  final MilestoneItem item;
  const _MilestoneCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final c = context.cc;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: c.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: c.cardBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: item.badgeColor.withAlpha(40),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, color: item.badgeColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: c.textPrimary,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: item.badgeColor.withAlpha(35),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        item.badgeText,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: item.badgeColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  item.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.3,
                    color: c.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// -------------------------------------------------------------------
/// M03, M04, M05: REUSABLE SECTION CARD & STAT CARD
/// -------------------------------------------------------------------
class SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;

  const SectionCard({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.cc;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: c.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: c.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: c.textPrimary,
                  ),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.cc;
    final iconColor = Color.lerp(color, c.textPrimary, 0.3)!;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: c.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: c.cardBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: color.withAlpha(46),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 28,
                    height: 1.1,
                    fontWeight: FontWeight.w800,
                    color: c.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, color: c.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String mono;
  final String text;
  final Widget? action;

  const _EmptyState({
    required this.icon,
    required this.mono,
    required this.text,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.cc;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
      decoration: BoxDecoration(
        color: c.emptyBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: c.cardBorder),
      ),
      child: Column(
        children: [
          Icon(icon, size: 30, color: context.tone),
          const SizedBox(height: 10),
          Text(
            mono,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              color: context.tone,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: c.textSecondary, fontSize: 14),
          ),
          if (action != null) ...[const SizedBox(height: 14), action!],
        ],
      ),
    );
  }
}

/// -------------------------------------------------------------------
/// M07 & M06: PROGRESS BODY CONTENT DENGAN LISTVIEW.BUILDER & CAROUSEL
/// -------------------------------------------------------------------
class ProgressBody extends StatelessWidget {
  final bool isMobile;
  const ProgressBody({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final c = context.cc;

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final pad = w < 600 ? 16.0 : 28.0;
        final wideStats = w >= 640;

        return SingleChildScrollView(
          padding: EdgeInsets.all(pad),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Halaman & Tombol Ubah Tema
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Progres Belajar 📊',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.6,
                                color: c.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Pantau pencapaian, pemahaman materi, dan riwayat belajar kamu.',
                              style: TextStyle(
                                  color: c.textSecondary, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      if (!isMobile)
                        Container(
                          decoration: BoxDecoration(
                            color: c.cardColor,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: c.cardBorder),
                          ),
                          child: ThemeToggleButton(color: c.textPrimary),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // M02 & M03: Kartu Profil Mahasiswa Pembelajar
                  const _StudentProfileCard(),
                  const SizedBox(height: 16),

                  // M06 & M07: Target & Milestone Belajar dengan Fitur Swipe Carousel
                  SectionCard(
                    title: 'Target & Pencapaian',
                    trailing: isMobile
                        ? Row(
                            children: [
                              Icon(Icons.swipe_rounded,
                                  size: 16, color: c.textSecondary),
                              const SizedBox(width: 4),
                              Text(
                                'Geser',
                                style: TextStyle(
                                    fontSize: 12, color: c.textSecondary),
                              ),
                            ],
                          )
                        : null,
                    child: MilestoneCarousel(isMobile: isMobile),
                  ),
                  const SizedBox(height: 16),

                  // M04 & M07: 3 Kartu Ringkasan Metrik (Stats) Responsif
                  _responsiveRow(
                    wide: wideStats,
                    gap: 16,
                    children: [
                      StatCard(
                        icon: Icons.task_alt_rounded,
                        value: '0%',
                        label: 'Materi selesai',
                        color: context.cs.primary,
                      ),
                      StatCard(
                        icon: Icons.quiz_rounded,
                        value: '0',
                        label: 'Kuis dikerjakan',
                        color: c.accent,
                      ),
                      StatCard(
                        icon: Icons.emoji_events_rounded,
                        value: '0%',
                        label: 'Rata-rata nilai kuis',
                        color: c.highlight,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // M03 & M06: Section Progres Materi dengan ListView.separated
                  SectionCard(
                    title: 'Progres per materi',
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: c.badgeBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${progressList.length} Topik',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: c.textSecondary,
                        ),
                      ),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: progressList.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) =>
                          _MaterialProgressTile(item: progressList[index]),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // M05: Section Riwayat Pembelajaran (_EmptyState)
                  const SectionCard(
                    title: 'Riwayat pembelajaran',
                    child: _EmptyState(
                      icon: Icons.history_rounded,
                      mono: '// belum ada riwayat aktivitas',
                      text:
                          'Selesaikan modul materi atau kuis untuk mulai mencatat riwayat belajarmu.',
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Row jika layar lebar, Column jika sempit (M07)
  Widget _responsiveRow({
    required bool wide,
    required double gap,
    required List<Widget> children,
  }) {
    if (!wide) {
      return Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            SizedBox(width: double.infinity, child: children[i]),
            if (i != children.length - 1) SizedBox(height: gap),
          ],
        ],
      );
    }
    return Row(
      children: [
        for (int i = 0; i < children.length; i++) ...[
          Expanded(child: children[i]),
          if (i != children.length - 1) SizedBox(width: gap),
        ],
      ],
    );
  }
}

/// -------------------------------------------------------------------
/// M03, M05: PROGRESS TILE PER MATERI DENGAN CLIPRRECT
/// -------------------------------------------------------------------
class _MaterialProgressTile extends StatelessWidget {
  final ProgressMaterial item;
  const _MaterialProgressTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final c = context.cc;
    final percent = (item.progress * 100).round();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: c.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: c.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: context.cs.primary.withAlpha(36),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(item.icon, size: 18, color: context.tone),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: c.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.category,
                      style: TextStyle(fontSize: 12, color: c.textSecondary),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: percent > 0
                      ? context.cs.primary.withAlpha(40)
                      : c.badgeBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$percent%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: percent > 0 ? context.tone : c.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // M05: ClipRRect untuk membulatkan sudut bar progres
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: item.progress,
              minHeight: 8,
              backgroundColor: c.badgeBg,
              color: c.accent,
            ),
          ),
        ],
      ),
    );
  }
}
