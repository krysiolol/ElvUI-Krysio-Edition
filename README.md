# ElvUI-Grimfall

A fork of **ElvUI (WotLK 3.3.5a)** customized for the classless private server **Grimfall WoW**.

On Grimfall every character is flagged as `DRUID` regardless of the abilities they use, which breaks ElvUI's class-based features. This fork adapts ElvUI to that environment.

## What's different from upstream ElvUI

- **Always-on Death Knight runes.** The rune bar is built for every character with no class detection (since the server reports everyone as `DRUID`). It defaults to the top of the Player unit frame and shows the 6-rune resource.
- **Dedicated "Death Knight Runes" config section** under *Unit Frames → Player*, with enable, height, fill style (spaced/filled), spacing, detach/move, width, orientation and strata options. Rune colors live under *Unit Frames → General → Colors → Class Resource*.
- **Ebonhold removed.** The Ebonhold addon skinning module, its options panel, settings, locale strings and the Ebonhold step in the install wizard have been fully purged. The install wizard is now 8 pages.
- Version string and TOC notes mark the build as the Grimfall fork.

## Included addons

ElvUI core plus the following companion plugins: AddOnSkins, AuraBarsMovers, BagControl, CastBarOverlay, CustomTags, CustomTweaks, DataTextColors, DTBars2, Enhanced, EnhancedFriendsList, ExtraActionBars, OptionsUI, RaidMarkers, SwingBar.

## Installation

Clone or download into your WoW `Interface\AddOns` directory so each `ElvUI*` folder sits directly under `AddOns`.

## Credits

Based on ElvUI by Elv, Bunny and the ElvUI-WotLK community. This fork only adds the Grimfall-specific changes described above.
