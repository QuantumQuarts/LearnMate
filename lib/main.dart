// =====================================================================
// Galaxy Night — Login & Sign Up (Flutter)
// - Geser vertikal Login <-> Sign Up (meniru translateY CSS)
// - Glassmorphism card dengan foto latar
// - Konten form SELALU di tengah box
// - Toggle Dark / Light theme di pojok kiri atas
// =====================================================================

import 'dart:ui';
import 'package:flutter/material.dart';
//import 'materials.dart';

void main() => runApp(const GalaxyAuthApp());

// ---------------------------------------------------------------------
// WARNA DASAR — Galaxy Night
// ---------------------------------------------------------------------AppPalette
class AppColors {
  static const cosmicIndigo = Color(0xFF6C63FF); // Primary
  static const nebulaPurple = Color(0xFF9D4EDD); // Secondary
  static const deepSpace = Color(0xFF0B1020); // Background
  static const nightSky = Color(0xFF161B33); // Surface/Card
  static const starlightCyan = Color(0xFF4CC9F0); // Accent (tombol utama)
  static const galaxyPink = Color(0xFFF15BB5); // Highlight (dipakai secukupnya: badge/achievement)
}

// Light Theme — Morning Village
class LightColors {
  static const sageGreen = Color(0xFF7FB77E); // Primary
  static const sunriseYellow = Color(0xFFF4D35E); // Secondary
  static const morningMist = Color(0xFFF8FAF5); // Background
  static const riceFieldCream = Color(0xFFFFFDF5); // Card
  static const skyBlue = Color(0xFFA8DADC); // Accent
  // Turunan untuk keterbacaan teks di atas kartu krem:
  static const forestInk = Color(0xFF2F3B2E); // teks utama
  static const sageDeep = Color(0xFF4F8A4E); // sage lebih gelap untuk link
}

// ---------------------------------------------------------------------
// PALET TEMA — Dark (Galaxy Night) & Light (Morning Village)
// Disimpan sebagai ThemeExtension supaya pergantian tema teranimasi halus.
// ---------------------------------------------------------------------
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.overlay,
    required this.card,
    required this.border,
    required this.glowA,
    required this.glowB,
    required this.text,
    required this.textSoft,
    required this.ink,
    required this.loginButton,
    required this.signUpButton,
    required this.link,
    required this.accent,
  });

  final Color overlay; // tint di atas foto latar
  final Color card; // warna kaca
  final Color border; // border kartu
  final Color glowA; // glow kartu 1
  final Color glowB; // glow kartu 2
  final Color text; // teks utama
  final Color textSoft; // teks sekunder
  final Color ink; // teks gelap (di atas warna terang)
  final Color loginButton; // tombol Login
  final Color signUpButton; // tombol Sign Up
  final Color link; // link "Sign Up / Sign In" & label fokus
  final Color accent; // kursor, garis fokus, checkbox, thumb toggle

  // Dark — Galaxy Night
  static final dark = AppPalette(
    overlay: AppColors.deepSpace.withOpacity(0.55),
    card: AppColors.nightSky.withOpacity(0.35),
    border: Colors.white.withOpacity(0.25),
    glowA: AppColors.starlightCyan.withOpacity(0.25),
    glowB: AppColors.cosmicIndigo.withOpacity(0.25),
    text: Colors.white,
    textSoft: Colors.white70,
    ink: AppColors.deepSpace,
    loginButton: AppColors.starlightCyan, // Accent -> tombol
    signUpButton: AppColors.nebulaPurple, // Secondary
    link: AppColors.galaxyPink, // Highlight, secukupnya
    accent: AppColors.starlightCyan,
  );

  // Light — Morning Village
  static final light = AppPalette(
    // foto latar TIDAK ikut berubah: tint sama dengan Dark
    overlay: AppColors.deepSpace.withOpacity(0.55),
    card: LightColors.riceFieldCream.withOpacity(0.82),
    border: LightColors.sageGreen.withOpacity(0.70),
    glowA: LightColors.sageGreen.withOpacity(0.30),
    glowB: LightColors.sunriseYellow.withOpacity(0.25),
    text: LightColors.forestInk,
    textSoft: LightColors.forestInk.withOpacity(0.70),
    ink: LightColors.forestInk,
    loginButton: LightColors.sageGreen, // Primary
    signUpButton: LightColors.sunriseYellow, // Secondary
    link: LightColors.sageDeep,
    accent: LightColors.skyBlue, // Accent
  );

  static AppPalette of(BuildContext context) =>
      Theme.of(context).extension<AppPalette>()!;

  @override
  AppPalette copyWith({
    Color? overlay,
    Color? card,
    Color? border,
    Color? glowA,
    Color? glowB,
    Color? text,
    Color? textSoft,
    Color? ink,
    Color? loginButton,
    Color? signUpButton,
    Color? link,
    Color? accent,
  }) {
    return AppPalette(
      overlay: overlay ?? this.overlay,
      card: card ?? this.card,
      border: border ?? this.border,
      glowA: glowA ?? this.glowA,
      glowB: glowB ?? this.glowB,
      text: text ?? this.text,
      textSoft: textSoft ?? this.textSoft,
      ink: ink ?? this.ink,
      loginButton: loginButton ?? this.loginButton,
      signUpButton: signUpButton ?? this.signUpButton,
      link: link ?? this.link,
      accent: accent ?? this.accent,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    return AppPalette(
      overlay: Color.lerp(overlay, other.overlay, t)!,
      card: Color.lerp(card, other.card, t)!,
      border: Color.lerp(border, other.border, t)!,
      glowA: Color.lerp(glowA, other.glowA, t)!,
      glowB: Color.lerp(glowB, other.glowB, t)!,
      text: Color.lerp(text, other.text, t)!,
      textSoft: Color.lerp(textSoft, other.textSoft, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      loginButton: Color.lerp(loginButton, other.loginButton, t)!,
      signUpButton: Color.lerp(signUpButton, other.signUpButton, t)!,
      link: Color.lerp(link, other.link, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
    );
  }
}

// ---------------------------------------------------------------------
// APP ENTRY — menyimpan state dark/light
// ---------------------------------------------------------------------
class GalaxyAuthApp extends StatefulWidget {
  const GalaxyAuthApp({super.key});

  @override
  State<GalaxyAuthApp> createState() => _GalaxyAuthAppState();
}

class _GalaxyAuthAppState extends State<GalaxyAuthApp> {
  bool _isDark = true;

  ThemeData _buildTheme() {
    final palette = _isDark ? AppPalette.dark : AppPalette.light;
    return ThemeData(
      useMaterial3: true,
      brightness: _isDark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: AppColors.deepSpace,
      colorScheme: _isDark
          ? const ColorScheme.dark(
              primary: AppColors.cosmicIndigo,
              secondary: AppColors.nebulaPurple,
              surface: AppColors.nightSky,
            )
          : const ColorScheme.light(
              primary: LightColors.sageGreen,
              secondary: LightColors.sunriseYellow,
              surface: LightColors.riceFieldCream,
            ),
      extensions: [palette],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      home: AuthPage(
        isDark: _isDark,
        onToggleTheme: () => setState(() => _isDark = !_isDark),
      ),
    );
  }
}

// =======================================================================
// 1. GalaxyBackground — foto latar + tint sesuai tema
// =======================================================================
class GalaxyBackground extends StatelessWidget {
  const GalaxyBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        // 👇 GANTI SUMBER GAMBAR DI SINI SAJA 👇
        // Image.asset('assets/images/galaxy_bg.jpg', fit: BoxFit.cover),
        Image(
          image: const NetworkImage(
            'https://images.unsplash.com/photo-1419242902214-272b3f66ee7a?auto=format&fit=crop&w=1200&q=80',
          ),
          fit: BoxFit.cover,
        ),
        // Tint: gelap di Dark theme, terang di Light theme
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          color: p.overlay,
        ),
        child,
      ],
    );
  }
}

// =======================================================================
// 2. GlassCard — kartu kaca blur
// =======================================================================
class GlassCard extends StatelessWidget {
  const GlassCard({super.key, required this.child, this.width = 380});

  final Widget child;
  final double width;

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          width: width,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: p.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: p.border, width: 1.5),
            boxShadow: [
              BoxShadow(color: p.glowA, blurRadius: 40, spreadRadius: 2),
              BoxShadow(color: p.glowB, blurRadius: 60, spreadRadius: -10),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

// =======================================================================
// 3. AnimatedAuthSwitcher — geser vertikal Login <-> Sign Up
// =======================================================================
class AnimatedAuthSwitcher extends StatelessWidget {
  const AnimatedAuthSwitcher({
    super.key,
    required this.showSignIn,
    required this.signIn,
    required this.signUp,
    this.slotHeight = 500,
  });

  final bool showSignIn;
  final Widget signIn;
  final Widget signUp;
  final double slotHeight;

  static const _duration = Duration(milliseconds: 1000);
  static const _curve = Curves.easeInOut;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SizedBox(
        height: slotHeight,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: _duration,
              curve: _curve,
              top: showSignIn ? 0 : -slotHeight,
              left: 0,
              right: 0,
              height: slotHeight,
              child: signIn,
            ),
            AnimatedPositioned(
              duration: _duration,
              curve: _curve,
              top: showSignIn ? slotHeight : 0,
              left: 0,
              right: 0,
              height: slotHeight,
              child: signUp,
            ),
          ],
        ),
      ),
    );
  }
}

// =======================================================================
// 4. ThemeToggle — saklar Dark / Light (pojok kiri atas)
// =======================================================================
class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key, required this.isDark, required this.onTap});

  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    const duration = Duration(milliseconds: 300);

    return Tooltip(
      message: isDark ? 'Ganti ke Light theme' : 'Ganti ke Dark theme',
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AnimatedContainer(
              duration: duration,
              width: 76,
              height: 38,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: p.card,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: p.border, width: 1.5),
              ),
              child: Stack(
                children: [
                  // ikon samar di kedua sisi
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.light_mode_rounded,
                              size: 16, color: p.textSoft),
                          Icon(Icons.dark_mode_rounded,
                              size: 16, color: p.textSoft),
                        ],
                      ),
                    ),
                  ),
                  // thumb yang bergeser
                  AnimatedAlign(
                    duration: duration,
                    curve: Curves.easeInOut,
                    alignment:
                        isDark ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: p.accent,
                        boxShadow: [
                          BoxShadow(
                            color: p.accent.withOpacity(0.55),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Icon(
                        isDark
                            ? Icons.dark_mode_rounded
                            : Icons.light_mode_rounded,
                        size: 16,
                        color: p.ink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =======================================================================
// HALAMAN UTAMA
// =======================================================================
class AuthPage extends StatefulWidget {
  const AuthPage({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _showSignIn = true;

  void _toggle() => setState(() => _showSignIn = !_showSignIn);

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);

    return Scaffold(
      body: GalaxyBackground(
        child: Stack(
          children: [
            Center(
              child: GlassCard(
                child: AnimatedAuthSwitcher(
                  showSignIn: _showSignIn,
                  slotHeight: 500,
                  signIn: AuthForm(
                    title: 'Login',
                    fields: const [
                      GlassTextField(label: 'Username'),
                      GlassTextField(label: 'Password', obscure: true),
                    ],
                    checkboxLabel: 'Remember me',
                    buttonLabel: 'Login',
                    buttonColor: p.loginButton,
                    footerPrefix: "Don't have an account? ",
                    footerLinkText: 'Sign Up',
                    onFooterTap: _toggle,
                  ),
                  signUp: AuthForm(
                    title: 'Sign Up',
                    fields: const [
                      GlassTextField(label: 'Username'),
                      GlassTextField(
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      GlassTextField(label: 'Password', obscure: true),
                    ],
                    checkboxLabel: 'I agree to the terms & conditions',
                    buttonLabel: 'Sign Up',
                    buttonColor: p.signUpButton,
                    footerPrefix: 'Already have an account? ',
                    footerLinkText: 'Sign In',
                    onFooterTap: _toggle,
                  ),
                ),
              ),
            ),
            // Toggle tema — pojok kiri atas
            Align(
              alignment: Alignment.topLeft,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ThemeToggle(
                    isDark: widget.isDark,
                    onTap: widget.onToggleTheme,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =======================================================================
// AuthForm — dipakai ulang untuk Login & Sign Up
// Konten DIPUSATKAN secara vertikal di dalam slot (box).
// =======================================================================
class AuthForm extends StatelessWidget {
  const AuthForm({
    super.key,
    required this.title,
    required this.fields,
    required this.checkboxLabel,
    required this.buttonLabel,
    required this.buttonColor,
    required this.footerPrefix,
    required this.footerLinkText,
    required this.onFooterTap,
  });

  final String title;
  final List<Widget> fields;
  final String checkboxLabel;
  final String buttonLabel;
  final Color buttonColor;
  final String footerPrefix;
  final String footerLinkText;
  final VoidCallback onFooterTap;

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);

    // LayoutBuilder + minHeight = tinggi slot, lalu Center -> konten
    // selalu di tengah vertikal; kalau layar terlalu kecil tetap bisa di-scroll.
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: p.text,
                    ),
                  ),
                  const SizedBox(height: 24),
                  for (final field in fields)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: field,
                    ),
                  AuthCheckboxRow(label: checkboxLabel),
                  const SizedBox(height: 14),
                  GlowButton(
                    label: buttonLabel,
                    color: buttonColor,
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                  FooterLink(
                    prefix: footerPrefix,
                    linkText: footerLinkText,
                    linkColor: p.link,
                    onTap: onFooterTap,
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

// =======================================================================
// GlassTextField
// =======================================================================
class GlassTextField extends StatelessWidget {
  const GlassTextField({
    super.key,
    required this.label,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
  });

  final String label;
  final bool obscure;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return TextField(
      obscureText: obscure,
      keyboardType: keyboardType,
      style: TextStyle(color: p.text, fontSize: 16),
      cursorColor: p.accent,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: p.textSoft),
        floatingLabelStyle: TextStyle(color: p.link),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: p.textSoft.withOpacity(0.5)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: p.accent, width: 2),
        ),
      ),
    );
  }
}

// =======================================================================
// AuthCheckboxRow
// =======================================================================
class AuthCheckboxRow extends StatefulWidget {
  const AuthCheckboxRow({super.key, required this.label});

  final String label;

  @override
  State<AuthCheckboxRow> createState() => _AuthCheckboxRowState();
}

class _AuthCheckboxRowState extends State<AuthCheckboxRow> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Row(
      children: [
        SizedBox(
          width: 22,
          height: 22,
          child: Checkbox(
            value: _checked,
            activeColor: p.accent,
            checkColor: p.ink,
            side: BorderSide(color: p.textSoft, width: 1.5),
            onChanged: (v) => setState(() => _checked = v ?? false),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            widget.label,
            style: TextStyle(color: p.textSoft, fontSize: 13),
          ),
        ),
      ],
    );
  }
}

// =======================================================================
// GlowButton
// =======================================================================
class GlowButton extends StatelessWidget {
  const GlowButton({
    super.key,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Container(
      width: double.infinity,
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.55),
            blurRadius: 18,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          // teks gelap di atas warna terang, putih di atas warna gelap
          foregroundColor:
              ThemeData.estimateBrightnessForColor(color) == Brightness.light
                  ? p.ink
                  : Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
    );
  }
}

// =======================================================================
// FooterLink
// =======================================================================
class FooterLink extends StatelessWidget {
  const FooterLink({
    super.key,
    required this.prefix,
    required this.linkText,
    required this.linkColor,
    required this.onTap,
  });

  final String prefix;
  final String linkText;
  final Color linkColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            prefix,
            style: TextStyle(color: p.textSoft, fontSize: 13),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            linkText,
            style: TextStyle(
              color: linkColor,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}