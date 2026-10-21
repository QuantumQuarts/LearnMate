import 'package:flutter/material.dart';

// LearnMate - Learning Dashboard + Light/Dark theme
// Light : Morning Village   |   Dark : Galaxy Night
// UI only, tanpa dependency tambahan. Taruh di lib/main.dart.

void main() => runApp(const LearnMateApp());

/// ---------------------------------------------------------------
/// THEME CONTROLLER
/// ---------------------------------------------------------------
class ThemeController extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.light;
  ThemeMode get mode => _mode;

  void toggle() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

final themeController = ThemeController();

/// ---------------------------------------------------------------
/// CUSTOM COLORS (ThemeExtension)
/// ---------------------------------------------------------------
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
  final Color highlight; // achievement / badge, secukupnya

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

  // Morning Village
  // Logo: "Learn" ungu + "Mate" biru tua (kebalikan dari dark)
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
    brand: Color.fromARGB(255, 190, 224, 18), // "Mate" biru tua
    brandLearn: Color.fromARGB(255, 9, 157, 29), // "Learn" hijau
    textPrimary: Color(0xFF26352D),
    textSecondary: Color(0xFF6B766D),
    badgeBg: Color(0xFFE9EDE7),
    highlight: Color(0xFFF15BB5),
  );

  // Galaxy Night
  // Logo: "Learn" biru tua + "Mate" ungu
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

  /// Warna ikon: primary digelapkan/diterangkan sedikit supaya kontras
  /// tetap enak di kedua tema.
  Color get tone => Color.lerp(cs.primary, cc.textPrimary, 0.25)!;
}

/// ---------------------------------------------------------------
/// APP
/// ---------------------------------------------------------------
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
          title: 'LearnMate',
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
          home: const DashboardShell(),
        );
      },
    );
  }
}

/// ---------------------------------------------------------------
/// DATA (dummy, UI only)
/// ---------------------------------------------------------------
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

class Course {
  final String title;
  final String category;
  final IconData icon;
  const Course(this.title, this.category, this.icon);
}

const latestCourses = <Course>[
  Course('Struktur Data & Algoritma', 'Fundamental', Icons.account_tree_rounded),
  Course('Basis Data & SQL', 'Data', Icons.storage_rounded),
  Course('Jaringan Komputer', 'Infrastruktur', Icons.lan_rounded),
  Course('Pengantar Machine Learning', 'Kecerdasan Buatan', Icons.psychology_rounded),
];

/// ---------------------------------------------------------------
/// SHELL (responsive: desktop / tablet / mobile)
/// ---------------------------------------------------------------
class DashboardShell extends StatefulWidget {
  const DashboardShell({super.key});

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell> {
  int selected = 0;

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
              Expanded(child: DashboardBody(isMobile: isMobile)),
            ],
          ),
        );
      },
    );
  }
}

/// ---------------------------------------------------------------
/// THEME TOGGLE
/// ---------------------------------------------------------------
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

/// ---------------------------------------------------------------
/// SIDEBAR
/// ---------------------------------------------------------------
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
          padding: EdgeInsets.symmetric(horizontal: compact ? 12 : 16, vertical: 20),
          child: Column(
            children: [
              // Brand
              Row(
                mainAxisAlignment:
                    compact ? MainAxisAlignment.center : MainAxisAlignment.start,
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

              // Nav
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: navItems.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 6),
                  itemBuilder: (_, i) => _NavTile(
                    item: navItems[i],
                    selected: i == selected,
                    compact: compact,
                    onTap: () => onSelect(i),
                  ),
                ),
              ),

              // Tema + Keluar
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

/// ---------------------------------------------------------------
/// DASHBOARD BODY
/// ---------------------------------------------------------------
class DashboardBody extends StatelessWidget {
  final bool isMobile;
  const DashboardBody({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final c = context.cc;

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final pad = w < 600 ? 16.0 : 28.0;
        final wideStats = w >= 640;
        final wideMid = w >= 820;

        return SingleChildScrollView(
          padding: EdgeInsets.all(pad),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header (tanpa nama user)
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Siap ngoding hari ini? 👋',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.6,
                                color: c.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Ringkasan perjalanan belajar kamu di LearnMate.',
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
                  const SizedBox(height: 22),

                  // Stats
                  _responsiveRow(
                    wide: wideStats,
                    gap: 16,
                    children: [
                      StatCard(
                        icon: Icons.menu_book_rounded,
                        value: '6',
                        label: 'Total materi',
                        color: context.cs.primary,
                      ),
                      StatCard(
                        icon: Icons.task_alt_rounded,
                        value: '0',
                        label: 'Materi selesai',
                        color: c.accent,
                      ),
                      StatCard(
                        icon: Icons.emoji_events_rounded,
                        value: '0%',
                        label: 'Rata-rata nilai kuis',
                        color: c.highlight, // achievement
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Sedang dipelajari + Progres
                  _responsiveRow(
                    wide: wideMid,
                    gap: 16,
                    flexes: const [3, 2],
                    stretch: true,
                    children: const [
                      _CurrentLearningCard(),
                      _ProgressCard(),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Materi terbaru
                  SectionCard(
                    title: 'Materi terbaru',
                    trailing: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(foregroundColor: context.tone),
                      child: const Text('Lihat semua'),
                    ),
                    child: Column(
                      children: [
                        for (int i = 0; i < latestCourses.length; i++) ...[
                          CourseTile(course: latestCourses[i]),
                          if (i != latestCourses.length - 1)
                            const SizedBox(height: 10),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Ringkasan aktivitas
                  const SectionCard(
                    title: 'Ringkasan aktivitas',
                    child: _EmptyState(
                      icon: Icons.code_rounded,
                      mono: '// belum ada aktivitas',
                      text: 'Yuk mulai belajar!',
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Row kalau lebar, Column kalau sempit.
  Widget _responsiveRow({
    required bool wide,
    required double gap,
    required List<Widget> children,
    List<int>? flexes,
    bool stretch = false,
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
    final row = Row(
      crossAxisAlignment:
          stretch ? CrossAxisAlignment.stretch : CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < children.length; i++) ...[
          Expanded(flex: flexes?[i] ?? 1, child: children[i]),
          if (i != children.length - 1) SizedBox(width: gap),
        ],
      ],
    );
    return stretch ? IntrinsicHeight(child: row) : row;
  }
}

/// ---------------------------------------------------------------
/// REUSABLE WIDGETS
/// ---------------------------------------------------------------
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
    // ikon dibuat sedikit lebih kontras dari warna dasarnya
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

class _CurrentLearningCard extends StatelessWidget {
  const _CurrentLearningCard();

  @override
  Widget build(BuildContext context) {
    final c = context.cc;
    return SectionCard(
      title: 'Sedang dipelajari',
      child: _EmptyState(
        icon: Icons.terminal_rounded,
        mono: r'$ belum ada materi aktif',
        text: 'Pilih satu materi dan mulai perjalananmu.',
        action: FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.play_arrow_rounded, size: 18),
          label: const Text('Mulai materi baru'),
          style: FilledButton.styleFrom(
            backgroundColor: c.accent,
            foregroundColor: c.onAccent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard();

  @override
  Widget build(BuildContext context) {
    final c = context.cc;
    return SectionCard(
      title: 'Progres belajar',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Keseluruhan',
                  style: TextStyle(fontSize: 13, color: c.textSecondary)),
              Text('0%',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: c.textPrimary)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0,
              minHeight: 10,
              backgroundColor: c.badgeBg,
              color: c.accent,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: context.cs.secondary.withAlpha(46),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '🔥 0 hari streak ngoding',
              style: TextStyle(fontSize: 13, color: c.textPrimary),
            ),
          ),
          const SizedBox(height: 14),
          RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 13, color: c.textSecondary),
              children: [
                const TextSpan(text: 'Lihat rincian lengkap di halaman '),
                TextSpan(
                  text: 'Progress',
                  style: TextStyle(
                    color: context.tone,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CourseTile extends StatelessWidget {
  final Course course;
  const CourseTile({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final c = context.cc;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: c.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: c.cardBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: context.cs.primary.withAlpha(40),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(course.icon, size: 20, color: context.tone),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: c.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  course.category,
                  style: TextStyle(fontSize: 12, color: c.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: c.badgeBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Belum',
              style: TextStyle(fontSize: 11, color: c.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}