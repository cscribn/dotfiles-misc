# DOCX Output

## Target & Compatibility

- Format: Native `.docx` optimized for Google Drive / Docs conversion.

## Document Structure & Styles

- Semantic Headings: Apply built-in heading styles (`Heading 1`, `Heading 2`, `Normal`) for structural hierarchy. Do not use manual bolding/sizing as a substitute for headings.
- Formatting & Colors: Standard fonts only (`Calibri`, `Arial`, `Times New Roman`). Use explicit ARGB/Hex codes for text and fills; do not use theme colors.
- Spacing: Set explicit paragraph spacing (`space_before`, `space_after`). Never insert empty paragraphs (`\n` / empty `<w:p>`) for visual spacing.

## Layout & Content

- Lists: Use native `List Bullet` / `List Number` structures. Do not use manual text prefixes (`*`, `-`, `1.`) or hard tabs.
- Tables: Single-level grid layouts only with explicit column widths. Avoid nested tables or merged cells unless strictly necessary.
- Page Setup: Standard 1-inch margins. Use native page breaks (`<w:br w:type="page"/>`) before major sections.
- Media: Embed images as inline shapes with explicit width and height attributes.

## Strictly Prohibited Elements

DO NOT include:

- Floating text boxes, frames, or anchored shapes (`w:drawing` with absolute positioning)
- Multi-column page sections or column breaks
- Form fields, legacy controls, ActiveX, or custom XML parts
- Macros (`.docm`), external template links, or embedded fonts
- Tracked changes, inline comments, or legacy field codes (except native Page Number / TOC fields)
