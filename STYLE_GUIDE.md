# App Style Guide

## Color Palette

### Primary
| Name       | Hex       | Usage                                  |
|------------|-----------|----------------------------------------|
| Terracotta | `#C4652E` | Primary buttons, active nav, links     |
| Turmeric   | `#D4943A` | Star ratings, warnings, egg badge      |
| Clay       | `#A0522D` | Hover states, darker accents           |
| Walnut     | `#8B6F4E` | Secondary text, borders, outlines      |

### Backgrounds
| Name         | Hex       | Usage                                |
|--------------|-----------|--------------------------------------|
| Cream        | `#FFFBF7` | Light mode page background           |
| Warm gray    | `#F5EDE4` | Light mode cards & surfaces          |
| Dark bg      | `#1E1A15` | Dark mode page background            |
| Dark surface | `#2C2418` | Dark mode cards & surfaces           |

### Text
| Context              | Light Mode | Dark Mode  |
|----------------------|------------|------------|
| Primary text         | `#2C2418`  | `#F5EDE4`  |
| Secondary text       | `#8B6F4E`  | `#B8A898`  |
| Tertiary / hints     | `#B8A898`  | `#6B5D4F`  |
| Accent text (links)  | `#C4652E`  | `#E8A46D`  |

### Semantic
| Name    | Hex       | Usage                          |
|---------|-----------|--------------------------------|
| Success | `#5A8C5A` | Success messages, veg badge    |
| Error   | `#C44E3F` | Errors, destructive, non-veg badge |
| Warning | `#D4943A` | Warnings, egg badge            |
| Info    | `#4A7C8C` | Info messages, tooltips        |

### Star Ratings
- Filled star: `#D4943A`
- Empty star: `#D1C8BC`

### Diet Badges (Indian food labeling convention)
- Vegetarian: green dot `#5A8C5A` + "Veg"
- Non-vegetarian: red dot `#C44E3F` + "Non-veg"
- Eggetarian: amber dot `#D4943A` + "Egg"
- Style: small pill, border-radius full, light tinted background matching dot color

---

## Typography

### Font Families
- **Headings, UI labels, buttons:** Inter (weights: 500, 600)
- **Body text, descriptions, recipe steps:** DM Sans (weights: 400, 500)
- Google Fonts import: `Inter:wght@400;500;600` and `DM+Sans:wght@400;500;600`

### Type Scale
| Element       | Font     | Weight | Size  | Line Height |
|---------------|----------|--------|-------|-------------|
| h1            | Inter    | 600    | 28px  | 1.3         |
| h2            | Inter    | 600    | 22px  | 1.3         |
| h3            | Inter    | 500    | 18px  | 1.4         |
| Body          | DM Sans  | 400    | 15px  | 1.6         |
| Small/caption | DM Sans  | 400    | 13px  | 1.5         |
| Button        | Inter    | 500    | 14px  | 1           |
| Input label   | Inter    | 500    | 13px  | 1           |

---

## Spacing

| Token       | Value |
|-------------|-------|
| `--space-xs`  | 4px   |
| `--space-sm`  | 8px   |
| `--space-md`  | 16px  |
| `--space-lg`  | 24px  |
| `--space-xl`  | 32px  |
| `--space-2xl` | 48px  |

---

## Border Radius

| Token          | Value    | Usage                          |
|----------------|----------|--------------------------------|
| `--radius-sm`  | 6px      | Inputs, small buttons          |
| `--radius-md`  | 10px     | Cards, modals, dropdowns       |
| `--radius-lg`  | 16px     | Recipe cards, photo frames     |
| `--radius-full`| 9999px   | Avatars, badges, pills         |

---

## Shadows

- Cards: `0 1px 3px rgba(0, 0, 0, 0.06)`
- Elevated (modals, dropdowns): `0 4px 12px rgba(0, 0, 0, 0.1)`
- No heavy shadows — keep it soft and flat

---

## Components

### Buttons
- **Primary:** Terracotta (`#C4652E`) fill, white text. Hover darkens 10%.
- **Secondary:** Transparent bg, walnut (`#8B6F4E`) 1px border, walnut text. Hover fills with warm gray.
- **Destructive:** Error red (`#C44E3F`) fill, white text.
- **Disabled:** 50% opacity, no pointer events.
- Border radius: `--radius-sm` (6px). Padding: 10px 20px.

### Cards
- Background: warm gray (`#F5EDE4`) in light mode, dark surface (`#2C2418`) in dark mode.
- Border: 1px solid with 10% opacity border color.
- Border radius: `--radius-lg` (16px).
- Shadow: `0 1px 3px rgba(0, 0, 0, 0.06)`.

### Recipe Photos
- Border radius: `--radius-lg` (16px).
- `object-fit: cover`.
- Aspect ratio: 3:2 for card thumbnails, 16:9 for hero/detail view.

### Navigation
- Clean top bar, minimal.
- Terracotta accent on active state.
- Icons: 1.5px stroke style (Lucide icons or Heroicons outline set).

### Inputs
- Border: 1px solid walnut at 30% opacity.
- Border radius: `--radius-sm` (6px).
- Focus ring: 2px terracotta outline.
- Padding: 10px 14px.

---

## Dark Mode

Dark mode uses the same warm palette shifted darker. Key mappings:
- Page bg: `#1E1A15`
- Surface/cards: `#2C2418`
- Primary text: `#F5EDE4`
- Secondary text: `#B8A898`
- Accent color shifts from terracotta (`#C4652E`) to a lighter golden tone (`#E8A46D`) for readability.
- Borders: white at 10% opacity.
- Implement with CSS `prefers-color-scheme` media query and/or a toggle that sets a `data-theme` attribute on `<html>`.

---

## General Principles
- Warm, inviting, minimal — feels like a kitchen, not a tech app.
- Generous whitespace. Don't crowd elements.
- Rounded corners throughout for a soft, friendly feel.
- Subtle transitions (150-200ms ease) on hover/focus states.
- No harsh black (`#000`) anywhere — use dark brown tones instead.
