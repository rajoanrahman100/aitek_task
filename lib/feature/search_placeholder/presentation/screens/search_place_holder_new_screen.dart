import 'package:aitek_task/core/theme/style.dart';
import 'package:aitek_task/core/widgets/responsive_content.dart';
import 'package:flutter/material.dart';

class SearchPlaceHolderNewScreen extends StatelessWidget {
  const SearchPlaceHolderNewScreen({super.key});

  static const _trendingSearches = <String>[
    'To do',
    'Fast Food',
    'Lotus Cheesecake Cup',
    'Grilled Halloumi Salad',
    'Smash Burger Deluxe',
    'Burger Duo Combo',
    'Falafel Power Bowl',
    'Crispy Wraps',
  ];

  static const _cuisines = <_CuisineCardData>[
    _CuisineCardData(
      title: 'Burgers',
      subtitle: 'Best sellers',
      icon: Icons.lunch_dining_rounded,
      gradient: [Color(0xFFFFC15D), Color(0xFFFF8A3D)],
    ),
    _CuisineCardData(
      title: 'Desserts',
      subtitle: 'Sweet picks',
      icon: Icons.icecream_rounded,
      gradient: [Color(0xFFFF80AB), Color(0xFFEA4C89)],
    ),
    _CuisineCardData(
      title: 'Bowls',
      subtitle: 'Fresh bowls',
      icon: Icons.ramen_dining_rounded,
      gradient: [Color(0xFF7CE0C3), Color(0xFF1BAE8E)],
    ),
    _CuisineCardData(
      title: 'Pizza',
      subtitle: 'Cheesy bites',
      icon: Icons.local_pizza_rounded,
      gradient: [Color(0xFFFFC46B), Color(0xFFFF6B4A)],
    ),
    _CuisineCardData(
      title: 'Sushi',
      subtitle: 'Light & fresh',
      icon: Icons.set_meal_rounded,
      gradient: [Color(0xFF8ED1FF), Color(0xFF4A86FF)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF8),
      body: SafeArea(
        child: ResponsiveContent(
          child: Stack(
            children: [
              const _Backdrop(),
              ListView(
                padding: const EdgeInsets.fromLTRB(18, 12, 18, 28),
                children: [
                  _TopBar(onBack: () => Navigator.maybePop(context)),
                  const SizedBox(height: 18),
                  const _HeroCard(),
                  const SizedBox(height: 22),
                  _SectionHeader(
                    title: 'Trendy searches',
                    subtitle: 'Hot picks from people around you',
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE3EF),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '14 live',
                        style: kSemiBoldTextStyle.copyWith(
                          color: const Color(0xFFB10B63),
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _trendingSearches.asMap().entries.map((entry) {
                      final index = entry.key;
                      final label = entry.value;
                      final highlighted = index == 1 || index == 4;
                      return _TrendChip(label: label, highlighted: highlighted);
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  _SectionHeader(
                    title: 'Favorite cuisine',
                    subtitle: 'Tap to jump into a mood',
                    trailing: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFFB10B63),
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'See All',
                            style: kSemiBoldTextStyle.copyWith(
                              color: const Color(0xFFB10B63),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 13,
                            color: Color(0xFFB10B63),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 144,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(right: 6),
                      itemCount: _cuisines.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final item = _cuisines[index];
                        return _CuisineCard(data: item);
                      },
                    ),
                  ),
                  const SizedBox(height: 18),
                  const _CalloutCard(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Backdrop extends StatelessWidget {
  const _Backdrop();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFF4EC), Color(0xFFFFFBF8)],
            ),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -42,
                right: -18,
                child: _GlowDot(
                  size: 132,
                  colors: [
                    const Color(0xFFFFB35C).withValues(alpha: 0.22),
                    const Color(0xFFFF6C74).withValues(alpha: 0.12),
                  ],
                ),
              ),
              Positioned(
                top: 88,
                left: -36,
                child: _GlowDot(
                  size: 102,
                  colors: [
                    const Color(0xFFB66CFF).withValues(alpha: 0.10),
                    const Color(0xFFFF6C74).withValues(alpha: 0.08),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlowDot extends StatelessWidget {
  const _GlowDot({required this.size, required this.colors});

  final double size;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: colors),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _IconCircle(icon: Icons.arrow_back_rounded, onTap: onBack),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: const Color(0xFFEEE7E1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.search_rounded, color: Color(0xFF8D8D8D)),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Search restaurants & cuisines',
                      hintStyle: kRegularTextStyle.copyWith(
                        color: const Color(0xFF9A9A9A),
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        _IconCircle(
          icon: Icons.tune_rounded,
          onTap: () {},
          background: const Color(0xFF1D1D1D),
          iconColor: Colors.white,
        ),
      ],
    );
  }
}

class _IconCircle extends StatelessWidget {
  const _IconCircle({
    required this.icon,
    required this.onTap,
    this.background = Colors.white,
    this.iconColor = const Color(0xFF1D1D1D),
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color background;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      shape: const CircleBorder(),
      elevation: 0,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 50,
          height: 50,
          child: Icon(icon, color: iconColor, size: 24),
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E1B2E), Color(0xFFB10B63), Color(0xFFFF6B4A)],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB10B63).withValues(alpha: 0.18),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'Discover now',
                    style: kSemiBoldTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Find the next dish you will love.',
                  style: kBoldTextStyle.copyWith(
                    color: Colors.white,
                    fontSize: 24,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'A smoother search experience with trendy picks, feel-good cuisine, and quick discovery.',
                  style: kRegularTextStyle.copyWith(
                    color: Colors.white.withValues(alpha: 0.86),
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    _MiniStat(label: 'Fast', value: 'Search'),
                    _MiniStat(label: 'Fresh', value: 'Ideas'),
                    _MiniStat(label: 'Hot', value: 'Near you'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Stack(
            clipBehavior: Clip.none,
            children: [
              const Positioned(
                right: 10,
                top: 8,
                child: _Orb(size: 82, color: Color(0x33FFFFFF)),
              ),
              const Positioned(
                left: 14,
                top: 76,
                child: _Orb(size: 42, color: Color(0x33FFFFFF)),
              ),
              Positioned(
                top: 18,
                right: 0,
                child: Container(
                  width: 88,
                  height: 132,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.16),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _DishBadge(
                        icon: Icons.local_pizza_rounded,
                        label: 'Pizza',
                        color: const Color(0xFFFFC15D),
                      ),
                      _DishBadge(
                        icon: Icons.icecream_rounded,
                        label: 'Sweet',
                        color: const Color(0xFFFF88B4),
                      ),
                      _DishBadge(
                        icon: Icons.ramen_dining_rounded,
                        label: 'Bowls',
                        color: const Color(0xFF7CE0C3),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
      ),
      child: RichText(
        text: TextSpan(
          style: kRegularTextStyle.copyWith(
            color: Colors.white.withValues(alpha: 0.88),
            fontSize: 11,
          ),
          children: [
            TextSpan(
              text: '$value ',
              style: kSemiBoldTextStyle.copyWith(
                color: Colors.white,
                fontSize: 11,
              ),
            ),
            TextSpan(text: label),
          ],
        ),
      ),
    );
  }
}

class _DishBadge extends StatelessWidget {
  const _DishBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: kSemiBoldTextStyle.copyWith(color: Colors.white, fontSize: 10),
        ),
      ],
    );
  }
}

class _Orb extends StatelessWidget {
  const _Orb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  final String title;
  final String subtitle;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: kBoldTextStyle.copyWith(fontSize: 22)),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: kRegularTextStyle.copyWith(
                  color: Colors.black54,
                  fontSize: 12,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        trailing,
      ],
    );
  }
}

class _TrendChip extends StatelessWidget {
  const _TrendChip({required this.label, required this.highlighted});

  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final background = highlighted ? const Color(0xFF1D1D1D) : Colors.white;
    final foreground = highlighted ? Colors.white : const Color(0xFF4A4A4A);
    final borderColor = highlighted
        ? const Color(0xFF1D1D1D)
        : const Color(0xFFD6D0C8);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: borderColor),
        boxShadow: highlighted
            ? [
                BoxShadow(
                  color: const Color(0xFF1D1D1D).withValues(alpha: 0.16),
                  blurRadius: 16,
                  offset: const Offset(0, 10),
                ),
              ]
            : [],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_fire_department_rounded,
            size: 16,
            color: highlighted
                ? const Color(0xFFFFCE73)
                : const Color(0xFF8F8F8F),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: kMediumTextStyle.copyWith(color: foreground, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _CuisineCard extends StatelessWidget {
  const _CuisineCard({required this.data});

  final _CuisineCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF0E9E2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 66,
            height: 66,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: data.gradient,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: data.gradient.last.withValues(alpha: 0.28),
                  blurRadius: 14,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(data.icon, color: Colors.white, size: 32),
          ),
          const Spacer(),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: kSemiBoldTextStyle.copyWith(fontSize: 13),
          ),
          const SizedBox(height: 3),
          Text(
            data.subtitle,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: kRegularTextStyle.copyWith(
              color: Colors.black54,
              fontSize: 10,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _CalloutCard extends StatelessWidget {
  const _CalloutCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF0E9E2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFC15D), Color(0xFFFF6B4A)],
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.shopping_bag_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hungry already?',
                  style: TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF181818),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Mix trending searches with your favorite cuisine and discover a match faster.',
                  style: TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            decoration: BoxDecoration(
              color: const Color(0xFF1D1D1D),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'Explore',
              style: kSemiBoldTextStyle.copyWith(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CuisineCardData {
  const _CuisineCardData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradient;
}
