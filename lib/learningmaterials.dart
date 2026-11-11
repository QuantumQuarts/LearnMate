import 'package:flutter/material.dart';

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
        backgroundColor: p.bg,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
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
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: p.card,
        surfaceTintColor: Colors.transparent,
        indicatorColor: p.navActive,
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
    return _materiList.where((item) {
      final categoryMatch = _selectedCategory == 'Semua' ||
          item['kategori'] == _selectedCategory;
      final searchMatch =
          item['judul']!.toLowerCase().contains(_searchText.toLowerCase()) ||
              item['deskripsi']!
                  .toLowerCase()
                  .contains(_searchText.toLowerCase());
      return categoryMatch && searchMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final p = P.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 850;
        final horizontalPadding = constraints.maxWidth < 400 ? 16.0 : 28.0;

        return Scaffold(
          body: SafeArea(
            child: Row(
              children: [
                if (isDesktop)
                  _DesktopSidebar(
                    selectedIndex: _selectedNavigation,
                    onSelected: (index) {
                      setState(() => _selectedNavigation = index);
                    },
                  ),
                Expanded(
                  child: Column(
                    children: [
                      if (!isDesktop)
                        _MobileHeader(
                          onThemeToggle: themeController.toggleTheme,
                        ),
                      Expanded(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1100),
                            child: ListView(
                              padding: EdgeInsets.fromLTRB(
                                horizontalPadding,
                                isDesktop ? 28 : 22,
                                horizontalPadding,
                                28,
                              ),
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
                                  subtitle:
                                      'Pilih materi dan mulai tingkatkan kemampuanmu.',
                                ),
                                const SizedBox(height: 14),
                                _SearchField(
                                  onChanged: (value) {
                                    setState(() => _searchText = value);
                                  },
                                ),
                                const SizedBox(height: 14),
                                _CategoryRow(
                                  categories: _categories,
                                  selectedCategory: _selectedCategory,
                                  onCategorySelected: (category) {
                                    setState(
                                        () => _selectedCategory = category);
                                  },
                                ),
                                const SizedBox(height: 18),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      '${_filteredMateri.length} materi',
                                      style: TextStyle(
                                        color: p.muted,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                if (_filteredMateri.isEmpty)
                                  const _EmptyState()
                                else
                                  LayoutBuilder(
                                    builder: (context, box) {
                                      final columns =
                                          box.maxWidth >= 760 ? 2 : 1;
                                      if (columns == 1) {
                                        return Column(
                                          children: _filteredMateri
                                              .map(
                                                (item) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 12),
                                                  child:
                                                      _MateriCard(item: item),
                                                ),
                                              )
                                              .toList(),
                                        );
                                      }
                                      return GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: _filteredMateri.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 14,
                                          mainAxisSpacing: 14,
                                          mainAxisExtent: 154,
                                        ),
                                        itemBuilder: (context, index) =>
                                            _MateriCard(
                                          item: _filteredMateri[index],
                                        ),
                                      );
                                    },
                                  ),
                                const SizedBox(height: 24),
                                const _ProgressCard(),
                              ],
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
          bottomNavigationBar: isDesktop
              ? null
              : _MobileNavigation(
                  selectedIndex: _selectedNavigation,
                  onSelected: (index) {
                    setState(() => _selectedNavigation = index);
                  },
                ),
        );
      },
    );
  }
}

/// ---------------------------------------------------------------------------
/// SIDEBAR (sesuai screenshot)
/// ---------------------------------------------------------------------------
class _DesktopSidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _DesktopSidebar({
    required this.selectedIndex,
    required this.onSelected,
  });

  static const _items = <(IconData, String)>[
    (Icons.dashboard_rounded, 'Dashboard'),
    (Icons.chrome_reader_mode_rounded, 'Materi'),
    (Icons.stacked_line_chart_rounded, 'Progress'),
    (Icons.library_books_rounded, 'Quiz'),
    (Icons.calendar_month_rounded, 'Jadwal'),
    (Icons.forum_rounded, 'Diskusi'),
    (Icons.person_rounded, 'Profil'),
  ];

  @override
  Widget build(BuildContext context) {
    final p = P.of(context);

    return Container(
      width: 256,
      color: p.sidebar,
      padding: const EdgeInsets.fromLTRB(16, 22, 16, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 26),
            child: _LearnMateLogo(),
          ),
          ...List.generate(_items.length, (index) {
            final item = _items[index];
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
                          color: active ? p.navActiveText : Colors.white70,
                        ),
                        const SizedBox(width: 14),
                        Text(
                          item.$2,
                          style: TextStyle(
                            color: active ? p.navActiveText : Colors.white,
                            fontSize: 15,
                            fontWeight:
                                active ? FontWeight.w700 : FontWeight.w500,
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
    );
  }
}

class _MobileHeader extends StatelessWidget {
  final VoidCallback onThemeToggle;

  const _MobileHeader({required this.onThemeToggle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 16, 8),
      child: Row(
        children: [
          const _LearnMateLogo(compact: true),
          const Spacer(),
          _ThemeToggleButton(onPressed: onThemeToggle),
        ],
      ),
    );
  }
}

class _LearnMateLogo extends StatelessWidget {
  final bool compact;
  const _LearnMateLogo({this.compact = false});

  @override
  Widget build(BuildContext context) {
    final p = P.of(context);
    final boxSize = compact ? 34.0 : 40.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
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
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
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

class _MobileNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _MobileNavigation({
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final p = P.of(context);

    Widget icon(IconData data, {bool selected = false}) => Icon(
          data,
          color: selected ? p.navActiveText : p.muted,
        );

    return NavigationBar(
      selectedIndex: selectedIndex.clamp(0, 4),
      onDestinationSelected: onSelected,
      height: 68,
      backgroundColor: p.card,
      indicatorColor: p.navActive,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: [
        NavigationDestination(
          icon: icon(Icons.dashboard_outlined),
          selectedIcon: icon(Icons.dashboard_rounded, selected: true),
          label: 'Dashboard',
        ),
        NavigationDestination(
          icon: icon(Icons.chrome_reader_mode_outlined),
          selectedIcon:
              icon(Icons.chrome_reader_mode_rounded, selected: true),
          label: 'Materi',
        ),
        NavigationDestination(
          icon: icon(Icons.stacked_line_chart_rounded),
          selectedIcon:
              icon(Icons.stacked_line_chart_rounded, selected: true),
          label: 'Progress',
        ),
        NavigationDestination(
          icon: icon(Icons.library_books_outlined),
          selectedIcon: icon(Icons.library_books_rounded, selected: true),
          label: 'Quiz',
        ),
        NavigationDestination(
          icon: icon(Icons.person_outline_rounded),
          selectedIcon: icon(Icons.person_rounded, selected: true),
          label: 'Profil',
        ),
      ],
    );
  }
}