# Fares Elhabashy — Flutter Developer Portfolio 🚀

A modern, responsive, and performance-optimized personal portfolio web application built with **Flutter Web**, demonstrating clean architecture, smooth scroll animations, dark/light theme switching, and production-grade mobile-first design.

🔗 **Live Demo:** [https://faresfady.github.io/portfolio/](https://faresfady.github.io/portfolio/)

---

## ✨ Features

- 🌓 **Dynamic Theme Switching:** Seamless toggling between bespoke Dark and Light color palettes with instant reactive rebuilds and zero-latency caching.
- 📱 **Fully Responsive:** Fluid, adaptive layout tailored for everything from mobile phones (390px+) to ultra-wide desktop monitors with zero horizontal overflow.
- 💫 **Graceful Scroll Animations:** In-viewport element reveals powered by custom deceleration cubic curves (`Curves.easeOutCubic`) with frame-throttled scroll listeners for steady 60/120 FPS performance.
- 🟢 **Live Availability Beacon:** An animated radar pulse status indicator showing active availability for mobile developer roles.
- 📄 **Direct Resume Download:** One-click instant CV PDF download with base64 data fallback and mobile-friendly viewing.
- 💬 **Interactive Contact & WhatsApp:** Direct background messaging to Gmail via Web3Forms API with form validation, plus WhatsApp instant chat routing.
- ⚡ **Mobile Performance Optimized:** Image compression (77% size reduction), parallel Google Fonts preloading, and an instant branded splash loader for near-instant perceived load times.
- 🚀 **Production-Ready CI/CD:** Fully automated GitHub Actions workflow that builds and deploys the release web bundle on every push.

---

## 🛠️ Tech Stack & Architecture

- **Framework:** [Flutter Web](https://flutter.dev) (Channel stable, 3.x)
- **Language:** [Dart](https://dart.dev)
- **Architecture:** Clean Architecture & MVVM Separation
- **Typography:** Google Fonts (`Fraunces`, `IBM Plex Sans`, `IBM Plex Mono`)
- **Hosting & CI/CD:** GitHub Pages via GitHub Actions / Vercel Edge

---

## 📂 Project Structure

```
lib/
├── main.dart                  # Application entry point & home scaffold
├── theme/
│   └── app_theme.dart         # Design tokens, color system, typography, cached themes
├── widgets/
│   ├── brand_icons.dart       # Authentic vector brand logos (GitHub, LinkedIn, etc.)
│   ├── content_wrapper.dart   # Responsive max-width container
│   ├── interactive_link.dart  # Hover-animated buttons & interactive cards
│   ├── pulsing_status_dot.dart# Radar pulse online status beacon
│   └── scroll_reveal.dart     # Hardware-accelerated in-viewport reveal widget
└── sections/
    ├── nav_bar.dart           # Pinned glassmorphic navigation header
    ├── hero_section.dart      # Hero showcase, profile portrait & intro
    ├── projects_section.dart  # Featured projects with deep dives
    ├── skills_section.dart    # Categorized technical competencies
    ├── education_section.dart # Degrees, certifications & spoken languages
    ├── contact_section.dart   # Direct channels & message feedback form
    └── footer_section.dart    # Developer quote & copyright
```

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (`>=3.0.0`)
- Google Chrome or any modern web browser

### Run Locally (Development)
```bash
git clone https://github.com/FaresFady/portfolio.git
cd portfolio
flutter pub get
flutter run -d chrome
```

### Run Locally (High-Performance Release Mode)
```bash
flutter run -d chrome --release
```

### Build for Production
```bash
flutter build web --release
```

---

## 📬 Contact

- **Name:** Fares Elhabashy
- **Email:** [fareselhabashy7@gmail.com](mailto:fareselhabashy7@gmail.com)
- **LinkedIn:** [fares-elhabashy](https://www.linkedin.com/in/fares-elhabashy-484b31295/)
- **GitHub:** [@FaresFady](https://github.com/FaresFady)
- **WhatsApp:** [+20 128 178 8394](https://wa.me/201281788394)
