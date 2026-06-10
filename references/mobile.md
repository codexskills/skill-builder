# Mobile App Stack Reference

## Common Stacks

### Stack A: React Native + Expo (Recommended)
| Component | Choice | Why |
|-----------|--------|-----|
| Framework | React Native + Expo SDK 52+ | Cross-platform, OTA updates, managed build pipeline |
| Navigation | Expo Router | File-based routing (like Next.js), deep links |
| State | Zustand + TanStack Query | Lightweight client state + server cache |
| Database | SQLite (expo-sqlite) | Local persistence, sync with Supabase |
| Backend | Supabase | Postgres DB, auth, real-time, storage |
| Auth | Supabase Auth + Apple/Google | Social sign-in, magic link, OTP |
| Notifications | Expo Notifications | Push notifications, local notifications |
| Hosting | EAS Build + App Store/Play Store | Managed builds and submissions |

### Stack B: Flutter (Cross-Platform, Premium UI)
| Component | Choice | Why |
|-----------|--------|-----|
| Framework | Flutter 3.x | Native performance, custom UI, one codebase |
| State | Riverpod | Compile-safe, testable, no BuildContext dependency |
| Navigation | GoRouter | Declarative routing, deep linking |
| Local DB | Isar / Drift (Moor) | Fast, NoSQL (Isar) or SQL (Drift) |
| Backend | Firebase / Supabase | Full backend suite |
| Auth | Firebase Auth / Supabase Auth | Multi-provider, built-in UI |
| Hosting | App Store / Play Store | Standard distribution |

### Stack C: SwiftUI + UIKit (iOS-Only)
| Component | Choice | Why |
|-----------|--------|-----|
| Framework | SwiftUI + UIKit interop | Best iOS experience, latest APIs |
| State | @Observable (iOS 17+) / Combine | Native observation, Swift 6 concurrency |
| Networking | URLSession + async/await | Built-in, no dependencies |
| Local DB | SwiftData (iOS 17+) / Core Data | Native persistence |
| Backend | Vapor (server-side Swift) | Full-stack Swift if backend also Swift |
| Auth | Sign in with Apple + Firebase | System-level auth |
| Hosting | App Store | iOS distribution only |

## When to Choose Which

| Criteria | Stack A (Expo) | Stack B (Flutter) | Stack C (SwiftUI) |
|----------|----------------|-------------------|-------------------|
| Target platforms | iOS + Android | iOS + Android + Web | iOS only |
| Native features | Excellent (Expo modules) | Excellent (packages) | Best (first-party) |
| UI customization | Native components | Custom Canvas (Skia) | Native + custom |
| Developer speed | Fast (hot reload) | Fast (hot reload) | Moderate |
| JavaScript ecosystem | Full | Dart pub only | Swift Package Manager |
| Web support | Yes (Expo for Web) | Yes (Flutter Web) | No |
| Performance | Good | Excellent | Excellent |

## Sample Environment Variables

```env
# Expo + Supabase
EXPO_PUBLIC_SUPABASE_URL="https://xxx.supabase.co"
EXPO_PUBLIC_SUPABASE_ANON_KEY="xxx"
EXPO_PUBLIC_APP_SCHEME="myapp"
EXPO_PUBLIC_SENTRY_DSN="https://xxx@sentry.io/yyy"

# Apple Sign-In
APPLE_CLIENT_ID="com.example.app"
APPLE_REDIRECT_URL="https://xxx.supabase.co/auth/v1/callback"
```

## Deployment Quirks

### App Store (iOS)
- Apple Developer Program: $99/year
- App Review: 1-3 days average
- TestFlight for beta testing (up to 100 external testers)
- Required: Privacy manifests, App Tracking Transparency
- Signing: Xcode automatic or manual with Fastlane match

### Google Play (Android)
- Developer account: $25 one-time
- Review: 2-8 hours typically
- Closed/Open testing tracks before production
- Internal testing: instant, no review
- Signing: App Signing by Google Play (recommended)

### EAS Build (Expo)
- `eas build --platform all` for production
- `eas submit --platform ios --path build.ipa` for submission
- OTA updates via `eas update` (no app store review for JS changes)
- Free tier: 30 builds/month

## Example Folder Structure (Expo)

```
mobile-app/
├── app/                    # Expo Router pages (file-based)
│   ├── (auth)/            # Auth-grouped routes
│   │   ├── login.tsx
│   │   └── register.tsx
│   ├── (tabs)/            # Tab navigation
│   │   ├── _layout.tsx
│   │   ├── index.tsx      # Home tab
│   │   ├── profile.tsx
│   │   └── settings.tsx
│   ├── _layout.tsx        # Root layout
│   └── +not-found.tsx
├── src/
│   ├── components/        # Shared UI
│   │   ├── ui/            # Base components
│   │   └── features/      # Feature components
│   ├── hooks/             # Custom hooks
│   ├── lib/               # Utilities, API clients
│   ├── providers/         # Context providers
│   ├── services/          # Business logic
│   └── types/             # TypeScript types
├── supabase/
│   ├── migrations/        # DB migrations
│   └── seed.sql
├── assets/                # Images, fonts
├── app.json               # Expo config
├── eas.json               # EAS Build config
├── package.json
├── tsconfig.json
└── .env
```

## Testing Strategy

| Layer | Tool | What to Test |
|-------|------|-------------|
| Unit | Jest (Expo) / flutter_test / XCTest | Hooks, state management, utility functions, data formatting |
| Widget/Component | React Native Testing Library / flutter_test WidgetTester / SwiftUI Preview | Component rendering, user interactions, empty states |
| Integration | Detox (E2E) / Patrol (Flutter) / XCTest UI | Full user flows: signup → browse → purchase → logout |
| Snapshot | Jest snapshot / SwiftUI Previews | UI regression — use sparingly |
| Device | BrowserStack / Firebase Test Lab | Real device coverage for edge cases (notch, tablets, older OS) |

## When NOT to Choose Each Stack

### Stack A (Expo)
- **Avoid when**: Need native module not in Expo SDK (bare Workflow possible but adds complexity)
- **Avoid when**: App is highly custom native (AR, Bluetooth peripheral, custom camera pipeline)
- **Avoid when**: App size must stay under 30MB (Expo adds ~10MB overhead)

### Stack B (Flutter)
- **Avoid when**: Platform-native UI is critical (Flutter paints its own widgets — doesn't match native exactly)
- **Avoid when**: Team only knows JavaScript/TypeScript (Dart learning curve)
- **Avoid when**: App is a simple form-over-data (overkill — Expo is faster)

### Stack C (SwiftUI)
- **Avoid when**: Android support is needed (iOS only)
- **Avoid when**: Supporting iOS <16 (SwiftUI improvements in iOS 16+)
- **Avoid when**: Need cross-platform backend reuse

## Scaling Limits

| Stack | Breaks At | Upgrade Path |
|-------|-----------|-------------|
| Expo + Supabase free | 50k users, 2GB DB | Supabase Pro ($25/mo) → Team ($599/mo) |
| Flutter + Firebase free | 100 concurrent connections, 1GB DB | Firebase Blaze (pay-as-you-go) |
| SwiftUI + custom API | Varies by backend | Scale backend independently |

## Cost Profile

| Stack | Free Tier | Typical Monthly | Notes |
|-------|-----------|----------------|-------|
| Expo + Supabase | Yes (generous) | $0-50 | Supabase free: 2GB DB, 50k users; Apple Developer $99/yr |
| Flutter + Firebase | Yes (limited) | $0-50 | Firebase free: 1GB DB, 10GB storage; Google Play $25 one-time |
| SwiftUI + Vapor | Some (server costs) | $5-100 | No framework costs; Apple Developer $99/yr; server hosting separate |
