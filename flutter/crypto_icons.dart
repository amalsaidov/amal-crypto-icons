// amal-crypto-icons — Flutter drop-in interface.
//
// High-quality VECTOR (SVG) crypto + fiat icons, sharp at any size.
// Served from the public repo via jsDelivr CDN (cached). One source of truth
// for every Simple app (wallet · currency · ledge).
//
// Setup:  add `flutter_svg` to pubspec, drop this file in, then:
//
//   CoinIcon(symbol: 'ETH', size: 44)        // crypto, color
//   CoinIcon(symbol: 'USD', kind: IconKind.fiat)
//   CoinIcon(symbol: 'BTC', mono: true, tint: AppColors.textPrimary)
//
// No raster, no blur. Falls back to a deterministic tinted initial when a
// symbol has no icon.

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum IconKind { crypto, fiat }

class CryptoIcons {
  CryptoIcons._();

  /// jsDelivr CDN (immutable, fast, cached). Pin a tag for production.
  static const String cdn =
      'https://cdn.jsdelivr.net/gh/amalsaidov/amal-crypto-icons@main/';

  /// Wrapped / staked / bridged variants → their base coin's real logo.
  static const Map<String, String> aliases = {
    'weth': 'eth', 'steth': 'eth', 'cbeth': 'eth', 'wbeth': 'eth',
    'btcb': 'btc',
    'wbnb': 'bnb', 'tbnb': 'bnb',
    'wavax': 'avax',
    'wpol': 'matic', 'pol': 'matic', 'wmatic': 'matic',
    'wtrx': 'trx',
    'usdbc': 'usdc',
  };

  /// SVG URL for a [symbol]. [mono] picks the monochrome variant (crypto only).
  static String svgUrl(String symbol,
      {IconKind kind = IconKind.crypto, bool mono = false}) {
    var s = symbol.toLowerCase().split('.').first; // strip .e / .b suffixes
    if (kind == IconKind.fiat) return '${cdn}fiat/flag/$s.svg'; // 152 world flags
    s = aliases[s] ?? s;
    return '$cdn${mono ? 'crypto/mono' : 'crypto/color'}/$s.svg';
  }
}

/// Drop-in icon widget. Sharp SVG with a calm deterministic fallback.
class CoinIcon extends StatelessWidget {
  final String symbol;
  final double size;
  final IconKind kind;
  final bool mono;
  final Color? tint; // recolor mono SVGs (e.g. to the theme ink)
  final Color? fallbackBg;
  final Color? fallbackFg;

  const CoinIcon({
    super.key,
    required this.symbol,
    this.size = 40,
    this.kind = IconKind.crypto,
    this.mono = false,
    this.tint,
    this.fallbackBg,
    this.fallbackFg,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: SvgPicture.network(
          CryptoIcons.svgUrl(symbol, kind: kind, mono: mono),
          width: size,
          height: size,
          fit: BoxFit.cover,
          colorFilter: (mono && tint != null)
              ? ColorFilter.mode(tint!, BlendMode.srcIn)
              : null,
          placeholderBuilder: (_) => _fallback(),
        ),
      ),
    );
  }

  Widget _fallback() {
    final letters = symbol.length >= 2
        ? symbol.substring(0, 2).toUpperCase()
        : symbol.toUpperCase();
    final bg = fallbackBg ?? _tintFor(symbol);
    return Container(
      width: size,
      height: size,
      color: bg,
      alignment: Alignment.center,
      child: Text(
        letters,
        style: TextStyle(
          color: fallbackFg ?? Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: size * 0.34,
          letterSpacing: -0.5,
        ),
      ),
    );
  }

  // Deterministic calm tint from the symbol (no neon, no randomness).
  static Color _tintFor(String sym) {
    const palette = [
      Color(0xFF2E80F0), Color(0xFF3F7D5B), Color(0xFFA85D43),
      Color(0xFF4D6B54), Color(0xFF6A3FA0), Color(0xFF2B6CB0),
    ];
    final h = sym.codeUnits.fold(0, (a, b) => a + b);
    return palette[h % palette.length];
  }
}
