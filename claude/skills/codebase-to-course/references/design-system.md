# Design System Reference

## Color Palette

The system defines backgrounds using warm, paper-like tones:

```css
:root {
  /* Backgrounds */
  --color-bg: #FAF7F2;            /* aged paper */
  --color-bg-warm: #F5F0E8;       /* alternating module background */
  --color-surface: #FFFFFF;
  --color-surface-warm: #FAF7F2;

  /* Text */
  --color-text: #2C2A28;          /* dark charcoal */
  --color-text-secondary: #6B6560;
  --color-text-muted: #9B9590;

  /* Accent — vermillion default, adaptable per project */
  --color-accent: #D94F30;
  --color-accent-muted: rgba(217, 79, 48, 0.3);
  --color-accent-light: rgba(217, 79, 48, 0.08);

  /* Actor colors — distinct hues for components */
  --color-actor-1: #D94F30;       /* vermillion */
  --color-actor-2: #2B9E8C;       /* teal */
  --color-actor-3: #8B6AAE;       /* muted plum */
  --color-actor-4: #C4922A;       /* golden */
  --color-actor-5: #3D7A4A;       /* forest green */

  /* Feedback */
  --color-success: #2B9E8C;
  --color-success-light: rgba(43, 158, 140, 0.1);
  --color-error: #D94F30;
  --color-error-light: rgba(217, 79, 48, 0.08);

  /* Borders */
  --color-border: #E0DBD4;
  --color-border-light: #EBE7E1;

  /* Code blocks */
  --color-bg-code: #1E1E2E;       /* deep indigo-charcoal */
}
```

Accent color can be adapted per project to coral, teal, amber, or forest green. **Avoid purple gradients.**

## Typography

Three font families establish personality:

```css
:root {
  --font-display: 'Bricolage Grotesque', sans-serif;  /* headings */
  --font-body: 'DM Sans', sans-serif;                 /* body text */
  --font-mono: 'JetBrains Mono', monospace;            /* code */
}
```

**Never use Inter, Roboto, Arial, or Space Grotesk for headings.**

### Type Scale (1.25 modular)

```css
:root {
  --text-xs: 0.75rem;    /* 12px */
  --text-sm: 0.875rem;   /* 14px */
  --text-base: 1rem;     /* 16px */
  --text-lg: 1.125rem;   /* 18px */
  --text-xl: 1.25rem;    /* 20px */
  --text-2xl: 1.5rem;    /* 24px */
  --text-3xl: 1.875rem;  /* 30px */
  --text-4xl: 2.25rem;   /* 36px */
  --text-5xl: 3rem;      /* 48px */
  --text-6xl: 3.75rem;   /* 60px */
}
```

### Line Heights

```css
:root {
  --leading-tight: 1.15;   /* headings */
  --leading-normal: 1.6;   /* body text */
}
```

Module numbers use 800-weight display font at 15% accent opacity.

## Spacing & Layout

A 4px base unit:

```css
:root {
  --space-1: 0.25rem;   /* 4px */
  --space-2: 0.5rem;    /* 8px */
  --space-3: 0.75rem;   /* 12px */
  --space-4: 1rem;      /* 16px */
  --space-5: 1.25rem;   /* 20px */
  --space-6: 1.5rem;    /* 24px */
  --space-8: 2rem;      /* 32px */
  --space-10: 2.5rem;   /* 40px */
  --space-12: 3rem;     /* 48px */
  --space-16: 4rem;     /* 64px */
  --space-20: 5rem;     /* 80px */
  --space-24: 6rem;     /* 96px */
}
```

```css
:root {
  --content-width: 800px;  /* standard reading width */
  --nav-height: 60px;
  --radius-sm: 8px;
  --radius-md: 12px;
  --radius-lg: 16px;
}
```

Modules occupy `min-height: 100dvh` with scroll-snap alignment, padding `var(--space-16)` horizontally and `calc(var(--nav-height) + var(--space-12))` from top.

## Shadows

```css
:root {
  --shadow-sm: 0 1px 3px rgba(44, 42, 40, 0.06);
  --shadow-md: 0 4px 12px rgba(44, 42, 40, 0.08);
  --shadow-lg: 0 8px 24px rgba(44, 42, 40, 0.12);
}
```

Never use black drop shadows — always warm-toned.

## Animations & Transitions

```css
:root {
  --duration-fast: 150ms;
  --duration-normal: 300ms;
  --duration-slow: 500ms;
  --ease-out: cubic-bezier(0.16, 1, 0.3, 1);
}
```

Scroll-triggered reveals combine opacity and `translateY(20px)` transforms over 500ms. Children stagger via `calc(var(--stagger-index, 0) * 120ms)`.

### Intersection Observer Pattern

```javascript
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.classList.add('visible');
      // Only trigger once
      observer.unobserve(entry.target);
    }
  });
}, { rootMargin: '0px 0px -10% 0px' });

document.querySelectorAll('.animate-in').forEach(el => observer.observe(el));
```

```css
.animate-in {
  opacity: 0;
  transform: translateY(20px);
  transition: opacity var(--duration-slow) var(--ease-out),
              transform var(--duration-slow) var(--ease-out);
}
.animate-in.visible {
  opacity: 1;
  transform: translateY(0);
}
/* Staggered children */
.animate-in.visible > * {
  transition-delay: calc(var(--stagger-index, 0) * 120ms);
}
```

## Navigation & Progress

### Nav Dots

```css
.nav-dot {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  border: 2px solid var(--color-text-muted);
  background: transparent;
  cursor: pointer;
  transition: all var(--duration-normal) var(--ease-out);
}
.nav-dot.current {
  border-color: var(--color-accent);
  box-shadow: 0 0 0 3px var(--color-accent-muted);
}
.nav-dot.visited {
  background: var(--color-accent);
  border-color: var(--color-accent);
}
```

Keyboard navigation maps arrow keys to module progression.

### Progress Bar

```javascript
window.addEventListener('scroll', () => {
  const scrollTop = document.documentElement.scrollTop;
  const scrollHeight = document.documentElement.scrollHeight - window.innerHeight;
  const progress = (scrollTop / scrollHeight) * 100;
  document.querySelector('.progress-bar').style.width = progress + '%';
}, { passive: true });
```

## Code Blocks

All code must **wrap text and never show a horizontal scrollbar.**

```css
.code-block {
  background: var(--color-bg-code);
  color: #CDD6F4;
  padding: var(--space-6);
  border-radius: var(--radius-md);
  font-family: var(--font-mono);
  font-size: var(--text-sm);
  line-height: 1.7;
  overflow-x: hidden;
}
.code-block pre,
.code-block code {
  white-space: pre-wrap;
  word-break: break-word;
  overflow-x: hidden;
}
```

### Syntax Highlighting (Catppuccin-inspired)

```css
.code-keyword { color: #CBA6F7; }   /* purple */
.code-string { color: #A6E3A1; }    /* green */
.code-function { color: #89B4FA; }  /* blue */
.code-comment { color: #6C7086; }   /* muted gray */
.code-property { color: #F9E2AF; }  /* yellow */
.code-number { color: #FAB387; }    /* peach */
```

Snippets should be exact copies from real codebases — naturally short (5-10 lines) — never modified or simplified.

## Responsive Breakpoints

```css
/* Tablet */
@media (max-width: 768px) {
  :root {
    --text-5xl: 2.25rem;
    --text-4xl: 1.875rem;
    --text-3xl: 1.5rem;
  }
  /* Grids stack to single columns */
  .pattern-cards,
  .translation-block {
    grid-template-columns: 1fr;
  }
}

/* Mobile */
@media (max-width: 480px) {
  :root {
    --text-5xl: 1.875rem;
    --text-4xl: 1.5rem;
  }
  .module {
    padding: var(--space-8) var(--space-4);
  }
}
```

## Scrollbar Styling

```css
::-webkit-scrollbar {
  width: 8px;
}
::-webkit-scrollbar-track {
  background: var(--color-bg);
}
::-webkit-scrollbar-thumb {
  background: var(--color-border);
  border-radius: 4px;
}
::-webkit-scrollbar-thumb:hover {
  background: var(--color-text-muted);
}
```
