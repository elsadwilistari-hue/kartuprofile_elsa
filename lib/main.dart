import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

// ====== Palet warna pink soft ======
const Color kRose = Color(0xFFD6638C);
const Color kRoseDark = Color(0xFF8E3B5A);
const Color kSoftPink = Color(0xFFFFE4EC);
const Color kBlush = Color(0xFFFFF5F8);
const Color kText = Color(0xFF5A2A3C);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kartu Profil',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: kRose,
      ),
      home: const ProfileCardPage(),
    );
  }
}

class ProfileCardPage extends StatelessWidget {
  const ProfileCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFE9F0), Color(0xFFFFD6E4), Color(0xFFFCEAF5)],
          ),
        ),
        child: SafeArea(
          // LayoutBuilder: layar > 600 => Row, layar sempit => Column
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool isWide = constraints.maxWidth > 600;
              return Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(isWide ? 32 : 20),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 820),
                    child: ProfileCard(isWide: isWide),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final bool isWide;
  const ProfileCard({super.key, required this.isWide});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isWide ? 40 : 26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: kSoftPink, width: 2),
        boxShadow: [
          BoxShadow(
            color: kRose.withOpacity(0.18),
            blurRadius: 40,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: isWide
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const _PhotoSection(),
          const SizedBox(width: 44),
          Expanded(child: _InfoSection(centered: false)),
        ],
      )
          : Column(
        children: [
          const _PhotoSection(),
          const SizedBox(height: 28),
          _InfoSection(centered: true),
        ],
      ),
    );
  }
}

// ====== Foto profil + badge (Stack + Positioned) ======
class _PhotoSection extends StatelessWidget {
  const _PhotoSection();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      height: 190,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Ring gradient pink
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFB6CE), kRose],
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const CircleAvatar(
                radius: 80,
                backgroundColor: kSoftPink,
                // Ganti dengan foto kamu:
                // 1) taruh file di assets/foto.jpg dan daftarkan di pubspec.yaml
                // 2) hapus 'child' di bawah, lalu aktifkan baris ini:
                // backgroundImage: AssetImage('assets/foto.jpg'),
                child: Text(
                  'ED',
                  style: TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.w600,
                    color: kRose,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ),
          // Badge "Available" di sudut foto
          Positioned(
            bottom: 6,
            right: -10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: kRose.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.circle, size: 10, color: Color(0xFF4CAF7D)),
                  SizedBox(width: 6),
                  Text(
                    'Available',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: kText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ====== Info: nama, prodi, deskripsi, skill, kontak ======
class _InfoSection extends StatelessWidget {
  final bool centered;
  const _InfoSection({required this.centered});

  @override
  Widget build(BuildContext context) {
    final align = centered ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = centered ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: align,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Elsa Dwi Listari',
          textAlign: textAlign,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: kText,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Mahasiswa Sistem Informasi',
          textAlign: textAlign,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: kRose,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          spacing: 8,
          runSpacing: 8,
          children: const [
            _InfoPill(icon: Icons.badge_outlined, text: 'NIM 4124005'),
            _InfoPill(icon: Icons.location_on_outlined, text: 'Rejoso'),
          ],
        ),
        const SizedBox(height: 18),
        Divider(color: kSoftPink, thickness: 1.5, height: 1),
        const SizedBox(height: 18),
        Text(
          'Mahasiswa yang antusias belajar pengembangan aplikasi mobile '
              'dan perancangan sistem informasi. Suka menyusun tampilan yang '
              'rapi, lembut, dan nyaman dipandang.',
          textAlign: textAlign,
          style: TextStyle(
            fontSize: 14.5,
            height: 1.6,
            color: kText.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 20),

        // Skill memakai Chip di dalam Wrap (otomatis pindah baris)
        Wrap(
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          spacing: 8,
          runSpacing: 8,
          children: const [
            _SkillChip('Flutter'),
            _SkillChip('Dart'),
            _SkillChip('UI Design'),
            _SkillChip('Basis Data'),
            _SkillChip('Analisis Sistem'),
          ],
        ),
        const SizedBox(height: 24),

        // 3 ikon kontak memakai Row
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
          centered ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: const [
            _ContactIcon(icon: Icons.mail_outline_rounded, tooltip: 'Email'),
            SizedBox(width: 14),
            _ContactIcon(icon: Icons.phone_outlined, tooltip: 'Telepon'),
            SizedBox(width: 14),
            _ContactIcon(icon: Icons.code_rounded, tooltip: 'GitHub'),
          ],
        ),
      ],
    );
  }
}

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoPill({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: kBlush,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kSoftPink),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: kRose),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: kRoseDark,
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  const _SkillChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      labelStyle: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: kRoseDark,
      ),
      backgroundColor: kSoftPink,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 6),
    );
  }
}

class _ContactIcon extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  const _ContactIcon({required this.icon, required this.tooltip});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kBlush,
          border: Border.all(color: kSoftPink, width: 1.5),
        ),
        child: Icon(icon, color: kRose, size: 22),
      ),
    );
  }
}