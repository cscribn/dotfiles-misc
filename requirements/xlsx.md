# XLSX Output

## Target & Compatibility

- Format: Native `.xlsx` optimized for Google Drive / Sheets import.

## Data Types & Formatting

- Numeric & Dates: Store as raw numeric/date values; apply explicit number/date formats.
- Colors: Use explicit ARGB/Hex codes for fills and fonts. Do not use themes or `IndexedColors`.
- Typography: Standard sans-serif fonts only (e.g., `Calibri`, `Arial`).
- Hyperlinks: Insert cell-level URL hyperlinks where the cell text equals the full URL.

## Layout

- Column Widths: Auto-fit with a max cap of 50 characters.
- Structure: Keep layout grid-aligned.

## Prohibited Elements

DO NOT include:

- VBA / Macros (`.xlsm`)
- Native Excel Tables (`ListObjects`)
- Charts, Pivot Tables, or Conditional Formatting rules
- External workbook links or formula dependencies
