# Agent prompt — wire a Simple app to `amal-crypto-icons`

> Paste this to any terminal agent working on a **Simple** app (wallet · currency · ledge)
> so its coin/fiat icons come from this **standalone** repo — sharp vectors, never blurry,
> identical across all apps.

## What this repo is

`amal-crypto-icons` (https://github.com/amalsaidov/amal-crypto-icons) — a **separate, standalone**
public repo of high-quality vector icons. **NOT a git submodule.** Apps consume it two ways:
- **CDN** (jsDelivr) for the long tail — `https://cdn.jsdelivr.net/gh/amalsaidov/amal-crypto-icons@main/...`
- **Bundled copies** of the hot set in the app's `assets/` (instant, offline)

Contents: `crypto/color/<sym>.svg` · `crypto/mono/<sym>.svg` · `fiat/flag/<code>.svg` (152 ISO 4217)
· `crypto/raster/<sym>.png` (few tokens with only a raster logo) · `manifest.json` (index + `aliases`).

## Do this (visual layer only — never touch business logic / web3 / providers)

1. **Deps:** `flutter pub add flutter_svg`. Do NOT use `CachedNetworkImage` for coin/fiat icons
   (raster → blurry when scaled). Vectors only.
2. **Bundle the hot set:** copy the app's own tokens (+ common fiat) from this repo into
   `assets/crypto/`, `assets/fiat/`, and any raster ones into `assets/crypto_png/`. Add those
   dirs to `pubspec.yaml` `flutter: assets:`.
3. **One resolver** (e.g. in the icon widget) with **three-tier** resolution per symbol:
   - normalize: `base = symbol.toLowerCase().split('.').first` then apply the **alias map**
     (wrapped/staked → base coin): `weth/steth/cbeth→eth, btcb→btc, wbnb/tbnb→bnb, wavax→avax,
     wpol/pol→matic, wtrx→trx, usdbc→usdc`.
   - **raster set** (`busd, magic, aero, brett, usdj`) → `Image.asset('assets/crypto_png/$base.png',
     filterQuality: FilterQuality.high, errorBuilder: …fallback)`.
   - **bundled set** → `SvgPicture.asset('assets/crypto/$base.svg', placeholderBuilder: …fallback)`.
   - else → `SvgPicture.network('<CDN>/crypto/color/$base.svg', placeholderBuilder: …fallback)`.
   - **fallback** = a calm deterministic tinted initial (hash of symbol → on-brand token color),
     never a blank, never neon. Wrap icons in `ClipOval` + `BoxFit.cover`.
4. **Fiat:** same pattern against `fiat/flag/<code>.svg` (path-based flags render in `flutter_svg`;
   text-symbol icons do NOT — never use them).
5. Keep it **token-driven** (Simple Design System): icon background wells use `surface2`,
   fallback text uses `onPrimary`. `flutter analyze` clean; app still runs.

## Acceptance
- No `CachedNetworkImage` / raster blur on coin or fiat icons.
- Every app token resolves to a real logo (bundled or CDN), wrapped/staked aliased, the 5 raster
  tokens render, unknowns get the crisp tinted-initial fallback.
- Icons look identical across wallet / currency / ledge (one source).
- Browse/verify in the gallery: https://amalsaidov.github.io/amal-crypto-icons/

> Reference implementation: `simple_wallet/lib/presentation/widgets/network_icon.dart`
> (`TokenIconWithBadge.coinSvg` / `fiatFlag` / `cryptoSvgUrl` / `_iconAliases` / `_raster`).
