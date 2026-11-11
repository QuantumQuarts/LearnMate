import 'package:flutter/material.dart';
import 'learningdashboard.dart';

// LearnMate - Learning Dashboard (Responsive + Adaptive) v2
// Light : Morning Village   |   Dark : Galaxy Night
// UI only, tanpa dependency tambahan. Taruh di lib/learningdashboard.dart.
//
// Pembagian tugas API responsif:
//   LayoutBuilder      -> lebar area yang tersedia (struktur navigasi, kolom grid)
//   OrientationBuilder -> portrait / landscape (mode padat di HP miring)
//   MediaQuery         -> tinggi jendela (mode padat) dan skala teks sistem
//
// Penanda perubahan dari v1: // BARU dan // UBAH

// Nyalakan (true) saat testing responsif. Muncul chip kecil di pojok kanan
// bawah berisi lebar, kelas layar, orientasi, tinggi jendela, skala teks.
const bool kShowScreenInfo = false;

void main() => runApp(const LearnMateApp());

/// ---------------------------------------------------------------
/// BREAKPOINT & UKURAN (satu sumber kebenaran)
/// ---------------------------------------------------------------
enum ScreenSize { mobile, tablet, desktop }

class Breakpoints {
  static const double tablet = 700; // lebar LAYAR mulai tablet
  static const double desktop = 1000; // lebar LAYAR mulai desktop
  static const double splitInner = 700; // lebar AREA KONTEN: dua kartu tengah berdampingan
  static const double shortHeight = 500; // BARU: tinggi jendela di bawah ini = "pendek"

  static ScreenSize of(double width) {
    if (width >= desktop) return ScreenSize.desktop;
    if (width >= tablet) return ScreenSize.tablet;
    return ScreenSize.mobile;
  }
}

class Dim {
  static const double gap = 16;
  static const double radiusCard = 18;
  static const double radiusInner = 14;
  static const double minTap = 48; // area sentuh minimal (pedoman 48 dp)
  static const double maxContent = 1100;
  static const double sidebarFull = 256;
  static const double sidebarRail = 84;
  static const double toolbarDense = 48; // BARU: AppBar saat mode padat

  // UBAH: ada mode padat (HP miring), padding dibatasi maksimal 16.
  static double pagePadding(ScreenSize s, {bool dense = false}) {
    double base;
    switch (s) {
      case ScreenSize.mobile:
        base = 16;
        break;
      case ScreenSize.tablet:
        base = 24;
        break;
      case ScreenSize.desktop:
        base = 28;
        break;
    }
    return dense && base > 16 ? 16 : base;
  }

  // BARU: jarak header ke konten
  static double headerGap(bool dense) => dense ? 12 : 22;
}

/// ---------------------------------------------------------------
/// BARU: ScreenInfo
/// Satu objek yang merangkum semua fakta layar dari tiga sumber:
/// LayoutBuilder (width), MediaQuery (window), OrientationBuilder.
/// ---------------------------------------------------------------
class ScreenInfo {
  final double width; // lebar area tersedia (LayoutBuilder)
  final Size window; // ukuran jendela penuh (MediaQuery.sizeOf)
  final Orientation orientation; // portrait / landscape (OrientationBuilder)
  final ScreenSize size; // mobile / tablet / desktop

  ScreenInfo({
    required this.width,
    required this.window,
    required this.orientation,
  }) : size = Breakpoints.of(width);

  bool get isLandscape => orientation == Orientation.landscape;

  /// Mode padat: landscape DAN tinggi jendela pendek (HP miring).
  /// Ruang vertikal sempit, jadi jarak dan tinggi bar dipadatkan.
  bool get isDense => isLandscape && window.height < Breakpoints.shortHeight;
}

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
  // Logo: "Learn" hijau + "Mate" kuning-hijau
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
    brand: Color.fromARGB(255, 190, 224, 18),
    brandLearn: Color.fromARGB(255, 9, 157, 29),
    textPrimary: Color(0xFF26352D),
    textSecondary: Color(0xFF6B766D),
    badgeBg: Color(0xFFE9EDE7),
    highlight: Color(0xFFF15BB5),
  );

  // Galaxy Night
  // Logo: "Learn" biru + "Mate" ungu
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
    brand: Color(0xFFB07CFF),
    brandLearn: Color(0xFF4D6BFE),
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

// Tema dibuat sekali (top-level), bukan dibangun ulang setiap toggle.
final ThemeData lightTheme = _buildTheme(
  brightness: Brightness.light,
  primary: const Color(0xFF7FB77E), // Sage Green
  secondary: const Color(0xFFF4D35E), // Warm Sunrise Yellow
  surface: const Color(0xFFFFFDF5), // Rice Field Cream
  background: const Color(0xFFF8FAF5), // Morning Mist
  colors: CustomColors.light,
);

final ThemeData darkTheme = _buildTheme(
  brightness: Brightness.dark,
  primary: const Color(0xFF6C63FF), // Cosmic Indigo
  secondary: const Color(0xFF9D4EDD), // Nebula Purple
  surface: const Color(0xFF161B33), // Night Sky
  background: const Color(0xFF0B1020), // Deep Space
  colors: CustomColors.dark,
);

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
          theme: lightTheme,
          darkTheme: darkTheme,
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
/// SHELL (adaptive: Drawer / rail ikon / sidebar penuh)
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

    // BARU: MediaQuery.sizeOf hanya memicu rebuild saat UKURAN berubah
    // (lebih hemat daripada MediaQuery.of).
    final window = MediaQuery.sizeOf(context);
    final textScale = MediaQuery.textScalerOf(context).scale(14) / 14;

    // BARU: OrientationBuilder -> portrait / landscape
    return OrientationBuilder(
      builder: (context, orientation) {
        // LayoutBuilder -> lebar area yang benar-benar tersedia
        return LayoutBuilder(
          builder: (context, constraints) {
            final info = ScreenInfo(
              width: constraints.maxWidth,
              window: window,
              orientation: orientation,
            );
            final size = info.size;
            final isMobile = size == ScreenSize.mobile;
            final isTablet = size == ScreenSize.tablet;

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
                      // UBAH: AppBar lebih pendek saat HP miring
                      toolbarHeight: info.isDense ? Dim.toolbarDense : null,
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
                        dense: info.isDense, // UBAH
                        selected: selected,
                        onSelect: onSelect,
                      ),
                    )
                  : null,
              body: Stack(
                fit: StackFit.expand,
                children: [
                  Row(
                    children: [
                      if (!isMobile)
                        SizedBox(
                          width: isTablet ? Dim.sidebarRail : Dim.sidebarFull,
                          child: Sidebar(
                            compact: isTablet,
                            dense: info.isDense, // UBAH
                            selected: selected,
                            onSelect: onSelect,
                          ),
                        ),
                      Expanded(child: DashboardBody(info: info)), // UBAH
                    ],
                  ),
                  // Chip debug (hanya aktif kalau kShowScreenInfo = true)
                  if (kShowScreenInfo)
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: IgnorePointer(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.black87, // khusus debug
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${info.width.round()} px · ${size.name} · '
                            '${orientation.name} · h=${window.height.round()} · '
                            'teks x${textScale.toStringAsFixed(2)}'
                            '${info.isDense ? ' · padat' : ''}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
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
  final bool dense; // BARU: mode padat (HP miring)
  final int selected;
  final ValueChanged<int> onSelect;

  const Sidebar({
    super.key,
    required this.compact,
    this.dense = false,
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
            horizontal: compact ? 12 : 16,
            vertical: dense ? 12 : 20, // UBAH
          ),
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
                    // FittedBox: logo mengecil, bukan overflow, saat teks
                    // sistem diperbesar.
                    const Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: BrandText(),
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: dense ? 12 : 28), // UBAH

              // Nav
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: navItems.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: dense ? 4 : 6), // UBAH
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
                      padding: EdgeInsets.symmetric(
                          vertical: dense ? 10 : 14), // UBAH
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
          // minHeight (bukan height tetap) -> tile ikut tumbuh kalau teks
          // diperbesar, dan tetap >= 48 dp untuk sentuhan.
          constraints: const BoxConstraints(minHeight: Dim.minTap),
          padding: EdgeInsets.symmetric(horizontal: compact ? 0 : 14, vertical: 4),
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
                Flexible(
                  child: Text(
                    item.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                      color: fg,
                    ),
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
/// AutoGrid
/// Jumlah kolom dihitung otomatis dari lebar yang tersedia
/// (LayoutBuilder) dan skala teks sistem (MediaQuery). Item "yatim"
/// (baris terakhir sendirian) dihindari.
/// ---------------------------------------------------------------
class AutoGrid extends StatelessWidget {
  final List<Widget> children;
  final double minItemWidth;
  final double spacing;

  const AutoGrid({
    super.key,
    required this.children,
    required this.minItemWidth,
    this.spacing = Dim.gap,
  });

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();

    // BARU: MediaQuery.textScalerOf -> kalau teks sistem diperbesar, lebar
    // minimal kartu ikut membesar, sehingga kolom berkurang dan teks tidak
    // terhimpit. Dibatasi 1.0 - 1.6 supaya layout tetap masuk akal.
    final textScale = (MediaQuery.textScalerOf(context).scale(14) / 14)
        .clamp(1.0, 1.6)
        .toDouble();
    final minWidth = minItemWidth * textScale;

    return LayoutBuilder(
      builder: (context, box) {
        final w = box.maxWidth;
        var cols = ((w + spacing) / (minWidth + spacing)).floor();
        cols = cols.clamp(1, children.length).toInt();
        // 3 item + 2 kolom = 1 item yatim -> turunkan kolom
        while (cols > 1 && children.length % cols != 0) {
          cols--;
        }
        final itemWidth = (w - spacing * (cols - 1)) / cols;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final child in children)
              SizedBox(width: itemWidth, child: child),
          ],
        );
      },
    );
  }
}

/// ---------------------------------------------------------------
/// DASHBOARD BODY (responsive)
/// ---------------------------------------------------------------
class DashboardBody extends StatelessWidget {
  final ScreenInfo info; // UBAH: seluruh fakta layar, bukan hanya ScreenSize
  const DashboardBody({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    final c = context.cc;
    final size = info.size;
    final isMobile = size == ScreenSize.mobile;
    final dense = info.isDense;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(Dim.pagePadding(size, dense: dense)), // UBAH
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: Dim.maxContent),
            // LayoutBuilder di DALAM batas konten, jadi keputusan layout
            // memakai lebar konten yang sebenarnya.
            child: LayoutBuilder(
              builder: (context, box) {
                final split = box.maxWidth >= Breakpoints.splitInner;

                return Column(
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
                                  // UBAH: mengecil juga saat mode padat
                                  fontSize: (isMobile || dense) ? 22 : 28,
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
                        // Hanya desktop. Mobile: toggle di AppBar,
                        // tablet: toggle di rail.
                        if (size == ScreenSize.desktop)
                          Container(
                            decoration: BoxDecoration(
                              color: c.cardColor,
                              borderRadius: BorderRadius.circular(Dim.radiusInner),
                              border: Border.all(color: c.cardBorder),
                            ),
                            child: ThemeToggleButton(color: c.textPrimary),
                          ),
                      ],
                    ),
                    SizedBox(height: Dim.headerGap(dense)), // UBAH

                    // Stats: kolom otomatis
                    AutoGrid(
                      minItemWidth: 190,
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
                    const SizedBox(height: Dim.gap),

                    // Sedang dipelajari + Progres
                    if (split)
                      const IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(flex: 3, child: _CurrentLearningCard()),
                            SizedBox(width: Dim.gap),
                            Expanded(flex: 2, child: _ProgressCard()),
                          ],
                        ),
                      )
                    else
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _CurrentLearningCard(),
                          SizedBox(height: Dim.gap),
                          _ProgressCard(),
                        ],
                      ),
                    const SizedBox(height: Dim.gap),

                    // Materi terbaru: 1 atau 2 kolom otomatis
                    SectionCard(
                      title: 'Materi terbaru',
                      trailing: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            foregroundColor: context.tone),
                        child: const Text('Lihat semua'),
                      ),
                      child: AutoGrid(
                        minItemWidth: 340,
                        spacing: 10,
                        children: [
                          for (final course in latestCourses)
                            CourseTile(course: course),
                        ],
                      ),
                    ),
                    const SizedBox(height: Dim.gap),

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
                );
              },
            ),
          ),
        ),
      ),
    );
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
        borderRadius: BorderRadius.circular(Dim.radiusCard),
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
        borderRadius: BorderRadius.circular(Dim.radiusCard),
        border: Border.all(color: c.cardBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: color.withAlpha(46),
              borderRadius: BorderRadius.circular(Dim.radiusInner),
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
                // maksimal 2 baris, tidak terpotong "…" di kartu sempit
                Text(
                  label,
                  maxLines: 2,
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
        borderRadius: BorderRadius.circular(Dim.radiusInner),
        border: Border.all(color: c.cardBorder),
      ),
      child: Column(
        children: [
          Icon(icon, size: 30, color: context.tone),
          const SizedBox(height: 10),
          Text(
            mono,
            textAlign: TextAlign.center,
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
            minimumSize: const Size(0, Dim.minTap), // area sentuh 48 dp
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
        borderRadius: BorderRadius.circular(Dim.radiusInner),
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
