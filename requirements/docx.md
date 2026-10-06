# DOCX Output Requirements

## Target & Compatibility

- Format: Native `.docx` optimized for Google Drive / Docs conversion.

## Document Structure & Styles

- Semantic Styles: Use standard built-in heading styles (`Heading 1`, `Heading 2`, `Normal`) for structural text.
- Typography: Use cross-platform web/safe standard fonts (e.g., `Arial`, `Calibri`, `Georgia`, `Times New Roman`).
- Colors: Use explicit ARGB/Hex codes for font and shading colors. Avoid theme-dependent colors.
- Spacing: Use explicit paragraph spacing (`space_before`, `space_after`) and line spacing instead of empty paragraph breaks (`\n` / empty `<w:p>`).

## Content Elements

- Lists: Use native bullet/numbered list structures (`List Bullet`, `List Number`), not manual text symbols (`*`, `-`, `1.`) or hard tabs.
- Tables: Keep table structure simple. Explicitly set cell paddings and column widths. Avoid nested tables.
- Page Setup: Standard margins (1 inch / 72pt), clear page breaks before major top-level headings if needed.
- Images: Embed as inline shapes with explicit width/height dimensions.

## Strictly Prohibited Elements

DO NOT include:

- Floating frames, text boxes, or absolute positioning (`w:drawing` anchored shapes)
- Multi-column page layouts or section column breaks
- Form fields, legacy controls, or Active-X objects
- Custom XML parts, macros (`.docm`), or external template bindings
- Custom embedded fonts (`w:embedBold`, `w:embedRegular`)
- Tracked changes, inline comments, or legacy field codes (except standard page numbers/TOC)
