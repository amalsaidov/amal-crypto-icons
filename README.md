# amal-crypto-icons

> High-quality **vector (SVG)** crypto + fiat currency icons — sharp at any size, never blurry.
> One shared source for all **Simple** apps (wallet · currency · ledge). Config-driven, CC0.

- **489 crypto** icons (color + monochrome) · **20 fiat** currency icons · all SVG
- Served free via **jsDelivr CDN** (cached, immutable) or **GitHub raw**
- Drop-in **Flutter** widget + a browsable **web gallery**
- Single source of truth → identical icons across every app (no drift)

## CDN / URL scheme

```
https://cdn.jsdelivr.net/gh/amalsaidov/amal-crypto-icons@main/crypto/color/<symbol>.svg
https://cdn.jsdelivr.net/gh/amalsaidov/amal-crypto-icons@main/crypto/mono/<symbol>.svg
https://cdn.jsdelivr.net/gh/amalsaidov/amal-crypto-icons@main/fiat/color/<code>.svg
```

`<symbol>` / `<code>` are lowercase (e.g. `eth`, `btc`, `usdc`, `usd`, `eur`). Pin a
release tag instead of `@main` for production immutability.

## Flutter (convenient interface)

1. `flutter pub add flutter_svg`
2. Copy [`flutter/crypto_icons.dart`](flutter/crypto_icons.dart) into your app.

```dart
CoinIcon(symbol: 'ETH', size: 44)                      // crypto, color, sharp
CoinIcon(symbol: 'USD', kind: IconKind.fiat)           // fiat
CoinIcon(symbol: 'BTC', mono: true, tint: theme.ink)   // monochrome, recolored
```

`CoinIcon` renders the SVG (vector → never blurry) and falls back to a calm,
deterministic tinted initial when a symbol is unknown. URL helper:
`CryptoIcons.svgUrl('ETH')`.

## Manifest

[`manifest.json`](manifest.json) lists every icon: `symbol`, `name`, brand `color`,
and `colorSvg` / `monoSvg` paths (+ a `fiat` array). Use it to populate pickers or
validate coverage.

```json
{ "symbol": "ETH", "name": "Ethereum", "color": "#627eea",
  "colorSvg": "crypto/color/eth.svg", "monoSvg": "crypto/mono/eth.svg" }
```

## Gallery

**Live:** https://amalsaidov.github.io/amal-crypto-icons/ — searchable grid of every
icon; click one to copy its CDN URL. (Or open [`index.html`](index.html) locally.)

## Structure

```
crypto/color/   489 color SVGs (32×32)
crypto/mono/    489 monochrome SVGs
fiat/color/     20 fiat currency SVGs
manifest.json   index of everything
flutter/        crypto_icons.dart — drop-in widget + resolver
index.html      browsable gallery
```

## Adding icons

Drop an SVG into `crypto/color/<symbol>.svg` (+ `crypto/mono/`), add an entry to
`manifest.json`, commit. Keep `viewBox="0 0 32 32"`.

## Credits / License

- Crypto icons from [spothq/cryptocurrency-icons](https://github.com/spothq/cryptocurrency-icons) — **CC0 1.0**.
- Fiat icons + Flutter interface: this repo — **CC0 1.0** (see [LICENSE](LICENSE)).

Coin logos may be trademarks of their respective projects; CC0 covers the icon files only.
