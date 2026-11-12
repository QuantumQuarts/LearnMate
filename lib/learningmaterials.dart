import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const LearnMateApp());
}

/// ---------------------------------------------------------------------------
/// THEME CONTROLLER
/// ---------------------------------------------------------------------------
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

/// ---------------------------------------------------------------------------
/// PALET WARNA (sama dengan screenshot light & dark mode)
/// ---------------------------------------------------------------------------
class P {
  final bool dark;
  const P(this.dark);

  factory P.of(BuildContext context) =>
      P(Theme.of(context).brightness == Brightness.dark);

  Color get bg => dark ? const Color(0xFF0B1020) : const Color(0xFFFAF9F1);
  Color get sidebar =>
      dark ? const Color(0xFF141A3A) : const Color(0xFF1F3B2F);
  Color get card => dark ? const Color(0xFF161B3D) : const Color(0xFFFFFDF5);
  Color get border =>
      dark ? const Color(0xFF2A3153) : const Color(0xFFE6E8DC);
  Color get inner => dark ? const Color(0xFF161B3D) : const Color(0xFFF2F4EE);
  Color get text => dark ? Colors.white : const Color(0xFF1A2420);
  Color get muted => dark ? const Color(0xFFA3AACB) : const Color(0xFF5C6B63);
  Color get primary =>
      dark ? const Color(0xFF8E84FF) : const Color(0xFF4E8A5A);
  Color get accent => dark ? const Color(0xFF4CC9F0) : const Color(0xFFA8DADC);
  Color get navActive =>
      dark ? const Color(0xFF6C63FF) : const Color(0xFFF4D35E);
  Color get navActiveText => dark ? Colors.white : const Color(0xFF2B2A12);
  Color get track => dark ? const Color(0xFF232948) : const Color(0xFFE6E9E0);

  Color get logoLearn =>
      dark ? const Color(0xFF4C9BFF) : const Color(0xFF2FB04A);
  Color get logoMate =>
      dark ? const Color(0xFFA78BFA) : const Color(0xFFD7E94B);
  List<Color> get logoGradient => dark
      ? const [Color(0xFF7C4DFF), Color(0xFFB06BFF)]
      : const [Color(0xFF7FB77E), Color(0xFFE6E34A)];

  Color get iconBoxTint =>
      dark ? const Color(0xFF262B5C) : const Color(0xFFE5F0E3);
  Color get iconBoxIcon =>
      dark ? const Color(0xFF8E84FF) : const Color(0xFF4E8A5A);

  List<Color> get bannerGradient => dark
      ? const [Color(0xFF6C63FF), Color(0xFF9D4EDD)]
      : const [Color(0xFF1F3B2F), Color(0xFF4E8A5A)];
}

/// ---------------------------------------------------------------------------
/// APP
/// ---------------------------------------------------------------------------
class LearnMateApp extends StatelessWidget {
  const LearnMateApp({super.key});

  ThemeData _buildTheme(Brightness brightness) {
    final p = P(brightness == Brightness.dark);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: p.bg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: p.dark ? const Color(0xFF6C63FF) : const Color(0xFF7FB77E),
        brightness: brightness,
        primary: p.primary,
        secondary: p.navActive,
        tertiary: p.accent,
        surface: p.card,
      ),
      dividerColor: p.border,
      appBarTheme: AppBarTheme(
        backgroundColor: p.sidebar,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: p.sidebar,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(),
      ),
      cardTheme: CardThemeData(
        color: p.card,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: p.border),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeController,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'LearnMate',
          themeMode: themeController.themeMode,
          theme: _buildTheme(Brightness.light),
          darkTheme: _buildTheme(Brightness.dark),
          home: const LearnMatePage(),
        );
      },
    );
  }
}

/// ---------------------------------------------------------------------------
/// NAVIGASI (satu sumber data untuk sidebar desktop & drawer mobile)
/// ---------------------------------------------------------------------------
const List<(IconData, String)> _navItems = [
  (Icons.dashboard_rounded, 'Dashboard'),
  (Icons.chrome_reader_mode_rounded, 'Materi'),
  (Icons.stacked_line_chart_rounded, 'Progress'),
  (Icons.library_books_rounded, 'Quiz'),
  (Icons.calendar_month_rounded, 'Jadwal'),
  (Icons.forum_rounded, 'Diskusi'),
  (Icons.person_rounded, 'Profil'),
];

/// Lebar maksimum isi halaman (di luar padding) supaya layar besar tetap rapi.
const double _kMaxContentWidth = 1200;
const double _kDesktopBreakpoint = 850;
const double _kSidebarWidth = 256;

/// ---------------------------------------------------------------------------
/// HALAMAN MATERI
/// ---------------------------------------------------------------------------
class LearnMatePage extends StatefulWidget {
  const LearnMatePage({super.key});

  @override
  State<LearnMatePage> createState() => _LearnMatePageState();
}

class _LearnMatePageState extends State<LearnMatePage> {
  String _selectedCategory = 'Semua';
  String _searchText = '';
  int _selectedNavigation = 1;

  static const List<Map<String, String>> _materiList = [
    {
      'judul': 'Pengantar Struktur Data',
      'kategori': 'Ilmu Komputer',
      'deskripsi': 'Konsep dasar array, linked list, stack, dan queue.',
      'icon': 'code',
    },
    {
      'judul': 'Dasar-Dasar Basis Data',
      'kategori': 'Ilmu Komputer',
      'deskripsi': 'Model relasional, normalisasi, dan query SQL dasar.',
      'icon': 'database',
    },
    {
      'judul': 'Metodologi Penelitian',
      'kategori': 'Metodologi',
      'deskripsi': 'Anatomi riset, research gap, dan tahapan penelitian.',
      'icon': 'research',
    },
    {
      'judul': 'Pengantar Machine Learning',
      'kategori': 'Kecerdasan Buatan',
      'deskripsi': 'Pengenalan supervised dan unsupervised learning.',
      'icon': 'ai',
    },
    {
      'judul': 'UI/UX untuk Aplikasi Edukasi',
      'kategori': 'Desain',
      'deskripsi': 'Prinsip desain antarmuka yang ramah untuk pembelajar.',
      'icon': 'design',
    },
    {
      'judul': 'Statistik untuk Riset',
      'kategori': 'Metodologi',
      'deskripsi': 'Probabilitas, uji hipotesis, dan interpretasi hasil.',
      'icon': 'chart',
    },
  ];

  static const List<String> _categories = [
    'Semua',
    'Ilmu Komputer',
    'Metodologi',
    'Kecerdasan Buatan',
    'Desain',
  ];

  List<Map<String, String>> get _filteredMateri {
    final query = _searchText.toLowerCase();
    return _materiList.where((item) {
      final categoryMatch = _selectedCategory == 'Semua' ||
          item['kategori'] == _selectedCategory;
      final searchMatch = item['judul']!.toLowerCase().contains(query) ||
          item['deskripsi']!.toLowerCase().contains(query);
      return categoryMatch && searchMatch;
    }).toList();
  }

  void _selectNav(int index) => setState(() => _selectedNavigation = index);

  @override
  Widget build(BuildContext context) {
    final p = P.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= _kDesktopBreakpoint;
        final basePadding = constraints.maxWidth < 400
            ? 16.0
            : (isDesktop ? 40.0 : 24.0);

        return Scaffold(
          // MOBILE: top bar hijau gelap (terang) / navy (gelap) + hamburger.
          appBar: isDesktop
              ? null
              : _MobileAppBar(onThemeToggle: themeController.toggleTheme),
          // MOBILE: sidebar yang sama dipakai sebagai Drawer.
          drawer: isDesktop
              ? null
              : Drawer(
                  width: 280,
                  backgroundColor: p.sidebar,
                  child: SafeArea(
                    child: _SidebarContent(
                      selectedIndex: _selectedNavigation,
                      onSelected: (index) {
                        _selectNav(index);
                        Navigator.of(context).pop(); // tutup drawer
                      },
                    ),
                  ),
                ),
          body: SafeArea(
            top: isDesktop, // di mobile, AppBar sudah menangani status bar
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isDesktop)
                  SizedBox(
                    width: _kSidebarWidth,
                    child: ColoredBox(
                      color: p.sidebar,
                      child: _SidebarContent(
                        selectedIndex: _selectedNavigation,
                        onSelected: _selectNav,
                      ),
                    ),
                  ),
                Expanded(child: _buildContent(p, isDesktop, basePadding)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(P p, bool isDesktop, double basePadding) {
    return LayoutBuilder(
      builder: (context, area) {
        // Padding sisi dihitung supaya isi tetap di tengah, sementara
        // scrollbar menempel di tepi jendela (bukan di tepi kolom 1200px).
        final side =
            math.max(basePadding, (area.maxWidth - _kMaxContentWidth) / 2);
        final media = MediaQuery.of(context);
        final items = _filteredMateri;

        return MediaQuery(
          // Di desktop teks sedikit diperbesar agar tidak terlalu kecil.
          data: media.copyWith(
            textScaler:
                isDesktop ? const TextScaler.linear(1.12) : media.textScaler,
          ),
          child: ListView(
            padding: EdgeInsets.fromLTRB(side, isDesktop ? 32 : 22, side, 32),
            children: [
              _PageHeading(
                showToggle: isDesktop,
                onThemeToggle: themeController.toggleTheme,
              ),
              const SizedBox(height: 22),
              const _WelcomeBanner(),
              const SizedBox(height: 26),
              const _SectionHeading(
                title: 'Temukan Materi',
                subtitle: 'Pilih materi dan mulai tingkatkan kemampuanmu.',
              ),
              const SizedBox(height: 14),
              _SearchField(
                onChanged: (value) => setState(() => _searchText = value),
              ),
              const SizedBox(height: 14),
              _CategoryRow(
                categories: _categories,
                selectedCategory: _selectedCategory,
                onCategorySelected: (category) =>
                    setState(() => _selectedCategory = category),
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Daftar Materi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: p.text,
                    ),
                  ),
                  Text(
                    '${items.length} materi',
                    style: TextStyle(color: p.muted, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (items.isEmpty)
                const _EmptyState()
              else
                _MateriList(items: items),
              const SizedBox(height: 24),
              const _ProgressCard(),
            ],
          ),
        );
      },
    );
  }
}

/// Daftar materi: 1 kolom (HP), 2 kolom (tablet/laptop), 3 kolom (layar lebar).
class _MateriList extends StatelessWidget {
  final List<Map<String, String>> items;
  const _MateriList({required this.items});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        final columns = box.maxWidth >= 1000 ? 3 : (box.maxWidth >= 640 ? 2 : 1);

        if (columns == 1) {
          return Column(
            children: [
              for (final item in items)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _MateriCard(item: item),
                ),
            ],
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            mainAxisExtent: 160,
          ),
          itemBuilder: (context, index) => _MateriCard(item: items[index]),
        );
      },
    );
  }
}

/// ---------------------------------------------------------------------------
/// SIDEBAR (dipakai desktop & drawer mobile)
/// Bisa di-scroll sehingga tidak "BOTTOM OVERFLOWED" di jendela yang pendek.
/// ---------------------------------------------------------------------------
class _SidebarContent extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _SidebarContent({
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final p = P.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 22, 16, 18),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight - 40, // dikurangi padding vertikal
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 26),
                    child: _LearnMateLogo(),
                  ),
                  ...List.generate(_navItems.length, (index) {
                    final item = _navItems[index];
                    final active = selectedIndex == index;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Material(
                        color: active ? p.navActive : Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () => onSelected(index),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 15),
                            child: Row(
                              children: [
                                Icon(
                                  item.$1,
                                  size: 20,
                                  color: active
                                      ? p.navActiveText
                                      : Colors.white70,
                                ),
                                const SizedBox(width: 14),
                                Text(
                                  item.$2,
                                  style: TextStyle(
                                    color: active
                                        ? p.navActiveText
                                        : Colors.white,
                                    fontSize: 15,
                                    fontWeight: active
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  const Spacer(),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.logout_rounded, size: 18),
                    label: const Text('Keluar'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white24),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
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
  }
}

/// ---------------------------------------------------------------------------
/// APP BAR MOBILE (hamburger kiri, logo, ikon tema kanan) -> sama dengan
/// tampilan di screenshot teman.
/// ---------------------------------------------------------------------------
class _MobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onThemeToggle;

  const _MobileAppBar({required this.onThemeToggle});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final p = P.of(context);

    return AppBar(
      backgroundColor: p.sidebar,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: const IconThemeData(color: Colors.white),
      // Tombol hamburger otomatis muncul karena Scaffold punya drawer.
      titleSpacing: 0,
      centerTitle: false,
      title: const _LearnMateLogo(compact: true, showIcon: false),
      actions: [
        IconButton(
          tooltip: p.dark ? 'Mode terang' : 'Mode gelap',
          onPressed: onThemeToggle,
          icon: Icon(
            p.dark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}

class _LearnMateLogo extends StatelessWidget {
  final bool compact;
  final bool showIcon;
  const _LearnMateLogo({this.compact = false, this.showIcon = true});

  @override
  Widget build(BuildContext context) {
    final p = P.of(context);
    final boxSize = compact ? 34.0 : 40.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showIcon) ...[
          Container(
            width: boxSize,
            height: boxSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: p.logoGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(
              Icons.terminal_rounded,
              size: compact ? 20 : 23,
              color: p.dark ? Colors.white : const Color(0xFF1F3B2F),
            ),
          ),
          const SizedBox(width: 10),
        ],
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: compact ? 21 : 24,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
            ),
            children: [
              TextSpan(text: 'Learn', style: TextStyle(color: p.logoLearn)),
              TextSpan(text: 'Mate', style: TextStyle(color: p.logoMate)),
            ],
          ),
        ),
      ],
    );
  }
}

class _ThemeToggleButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _ThemeToggleButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final p = P.of(context);
    return Material(
      color: p.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: p.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onPressed,
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(
            p.dark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            size: 21,
            color: p.text,
          ),
        ),
      ),
    );
  }
}

class _PageHeading extends StatelessWidget {
  final bool showToggle;
  final VoidCallback onThemeToggle;

  const _PageHeading({
    required this.showToggle,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    final p = P.of(context);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LEARNING SPACE',
                style: TextStyle(
                  color: p.muted,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.7,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Learning Materials',
                style: TextStyle(
                  color: p.text,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.7,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Kelola dan pelajari materi pilihanmu.',
                style: TextStyle(color: p.muted, fontSize: 12),
              ),
            ],
          ),
        ),
        if (showToggle) _ThemeToggleButton(onPressed: onThemeToggle),
      ],
    );
  }
}

class _WelcomeBanner extends StatelessWidget {
  const _WelcomeBanner();

  @override
  Widget build(BuildContext context) {
    final p = P.of(context);

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: p.bannerGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -12,
            top: -20,
            child: Icon(
              Icons.auto_stories_rounded,
              size: 115,
              color: Colors.white.withValues(alpha: 0.10),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  '✦  KEEP LEARNING',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Belajar lebih mudah,\nraih targetmu!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  height: 1.2,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Satu langkah kecil hari ini membawa\nkemajuan besar untuk masa depan.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionHeading({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final p = P.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: p.text,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(color: p.muted, fontSize: 12),
        ),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const _SearchField({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final p = P.of(context);

    OutlineInputBorder border(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: color, width: width),
        );

    return TextField(
      onChanged: onChanged,
      style: TextStyle(color: p.text, fontSize: 13),
      cursorColor: p.primary,
      decoration: InputDecoration(
        hintText: 'Cari materi pembelajaran...',
        hintStyle: TextStyle(fontSize: 12, color: p.muted),
        prefixIcon: Icon(Icons.search_rounded, size: 20, color: p.muted),
        filled: true,
        fillColor: p.card,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        border: border(p.border),
        enabledBorder: border(p.border),
        focusedBorder: border(p.primary, 1.5),
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const _CategoryRow({
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final p = P.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          final selected = category == selectedCategory;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(category),
              selected: selected,
              onSelected: (_) => onCategorySelected(category),
              labelStyle: TextStyle(
                fontSize: 11,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? p.navActiveText : p.muted,
              ),
              selectedColor: p.navActive,
              backgroundColor: p.card,
              side: BorderSide(
                color: selected ? Colors.transparent : p.border,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              showCheckmark: false,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _MateriCard extends StatelessWidget {
  final Map<String, String> item;
  const _MateriCard({required this.item});

  IconData _getIcon(String? type) {
    switch (type) {
      case 'database':
        return Icons.storage_rounded;
      case 'research':
        return Icons.biotech_rounded;
      case 'ai':
        return Icons.psychology_rounded;
      case 'design':
        return Icons.palette_rounded;
      case 'chart':
        return Icons.query_stats_rounded;
      default:
        return Icons.code_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = P.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: p.iconBoxTint,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  _getIcon(item['icon']),
                  color: p.iconBoxIcon,
                  size: 23,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item['kategori']!,
                      style: TextStyle(
                        color: p.primary,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item['judul']!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: p.text,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item['deskripsi']!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: p.muted,
                        fontSize: 10,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_forward_ios_rounded, size: 14, color: p.muted),
            ],
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
    final p = P.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: p.iconBoxTint,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.trending_up_rounded,
                      color: p.iconBoxIcon, size: 20),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Text(
                    'Progres Pengembangan',
                    style: TextStyle(
                      color: p.text,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Text(
                  '25%',
                  style: TextStyle(
                    color: p.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: 0.25,
                minHeight: 9,
                backgroundColor: p.track,
                color: p.primary,
              ),
            ),
            const SizedBox(height: 9),
            Text(
              'Terus lanjutkan proses belajarmu. Kamu sudah memulai dengan baik!',
              style: TextStyle(color: p.muted, fontSize: 10, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final p = P.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 35),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.search_off_rounded, size: 42, color: p.muted),
            const SizedBox(height: 10),
            Text(
              'Materi tidak ditemukan',
              style: TextStyle(
                color: p.text,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Coba kata kunci atau kategori lainnya.',
              style: TextStyle(color: p.muted, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}