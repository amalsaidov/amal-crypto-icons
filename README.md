# amal-crypto-icons

> High-quality **vector (SVG)** crypto + fiat currency icons — sharp at any size, never blurry.
> One shared source for all **Simple** apps (wallet · currency · ledge). Config-driven, CC0.

- **2061 crypto** icons (color + mono) · **207 network/chain** icons · **152 fiat** currency icons (all ISO 4217, flag-based) · all SVG
- Served free via **jsDelivr CDN** (cached, immutable) or **GitHub raw**
- Drop-in **Flutter** widget + a browsable **web gallery**
- Single source of truth → identical icons across every app (no drift)

## CDN / URL scheme

```
https://cdn.jsdelivr.net/gh/amalsaidov/amal-crypto-icons@main/crypto/color/<symbol>.svg
https://cdn.jsdelivr.net/gh/amalsaidov/amal-crypto-icons@main/crypto/mono/<symbol>.svg
https://cdn.jsdelivr.net/gh/amalsaidov/amal-crypto-icons@main/fiat/flag/<code>.svg
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
crypto/color/   2061 color SVGs
crypto/mono/    1783 monochrome SVGs
crypto/raster/  5 PNG logos (tokens with no free vector)
networks/color/ 207 chain logos (+ mono)
fiat/flag/      152 world currency flag SVGs (ISO 4217)
manifest.json   index of everything
flutter/        crypto_icons.dart — drop-in widget + resolver
index.html      browsable gallery
```

## Adding icons

Drop an SVG into `crypto/color/<symbol>.svg` (+ `crypto/mono/`), add an entry to
`manifest.json`, commit. Keep `viewBox="0 0 32 32"`.

## Credits / License

- Core crypto icons from [spothq/cryptocurrency-icons](https://github.com/spothq/cryptocurrency-icons) — **CC0 1.0**.
- Additional modern tokens (ARB, OP, PEPE, SHIB, GMX, PENDLE, JOE, CAKE, FRAX, SUN, JST…) from [0xa3k5/web3icons](https://github.com/0xa3k5/web3icons) — **MIT**.
- Fiat **flags** from [lipis/flag-icons](https://github.com/lipis/flag-icons) — **MIT**.
- Flutter interface: this repo — **CC0 1.0** (see [LICENSE](LICENSE)).

Coin logos may be trademarks of their respective projects; CC0 covers the icon files only.
