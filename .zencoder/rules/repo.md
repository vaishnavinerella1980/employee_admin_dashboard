# Repository Overview

- **Name**: employee_admin_dashboard
- **Platform**: Flutter (Dart), multi-platform (Web, Android, iOS, Desktop)
- **State Management**: Riverpod 3 (flutter_riverpod)
- **Networking**: http, retrofit/dio present but primary custom ApiService uses http
- **DI**: get_it + injectable
- **Storage**: hive_flutter, shared_preferences

## Project Structure (key paths)
- `lib/main.dart` and `lib/app.dart`: App bootstrap
- `lib/config/`: DI, env, routes
- `lib/core/`: constants, network, utils
- `lib/data/`: API layer, datasources, models, providers
  - `data/api_service.dart`: HTTP calls and response handling
  - `data/providers/riverpod_providers.dart`: Notifiers and providers
  - `data/models/`: data classes
- `lib/domain/`: entities and domain logic
- `lib/presentation/`: UI screens, theme, widgets

## Setup Notes
1. Ensure a valid API base URL in `lib/data/api_service.dart`:
   - `static const String baseUrl = 'https://your.api.server.com';`
2. If running on Web, configure CORS on the backend to allow your origin.
3. Run code generation when editing models/retrofit/freezed:
   - `dart run build_runner build --delete-conflicting-outputs`
4. After dependency changes: `flutter pub get`

## Known Pitfalls / Fixes
- **Base URL placeholder**: `'YOUR_API_BASE_URL'` causes runtime errors. Replace with a valid URL.
- **Employee update mismatch**:
  - Provider passes `employeeId`; API method originally didn’t accept it. Ensure API call uses `/employees/{id}` if your backend expects path parameter.
- **LinkedMap JSON handling**: Handled safely via `_safeMapConversion` in both providers and ApiService; keep it in place to avoid type issues.

## Useful Commands
- Run: `flutter run -d chrome` (or your device)
- Analyze: `flutter analyze`
- Test: `flutter test`
- Build runner: `dart run build_runner build --delete-conflicting-outputs`

## Environment
- Dart SDK: ">=3.0.0 <4.0.0"
- Riverpod: ^3.0.0
- http: ^1.5.0

## TODO Links
- See `TODO.md` for pending tasks.

## Troubleshooting Checklist
- Is `baseUrl` correct and reachable?
- Are endpoints aligned with backend (paths, params)?
- Any network/CORS errors in terminal or browser console?
- If retrofit models are used, re-run build_runner after changes.