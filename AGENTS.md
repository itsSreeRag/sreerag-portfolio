# Portfolio Repository Rules

## Project Context
- This is an existing Flutter Portfolio project.
- Follow these rules for all new code and modified files.
- Do not refactor unrelated files unless explicitly requested.

## Architecture
- Follow MVVM architecture.
- Use Provider (`ChangeNotifier`) for state management.
- Keep business logic inside ViewModels.
- Keep Views focused on UI only.
- Keep Models responsible only for data.

## Code Organization
- Organize features into their own folders.
- Place screen-specific widgets inside that screen's `widgets/` folder.
- Put reusable widgets inside `lib/widgets/components/`.
- Avoid duplicate code. Reuse existing widgets, helpers, and extensions whenever possible.

## UI & Design
- Preserve the existing UI, animations, and design unless explicitly instructed to change them.
- Maintain consistent spacing, typography, colors, and component styles.
- Use centralized theme/constants instead of hardcoded values whenever available.
- Every screen must remain responsive for Desktop, Tablet, and Mobile.

## Provider
- Prefer `Consumer<T>` for UI updates.
- Use `context.read<T>()` for one-time actions.
- Avoid unnecessary widget rebuilds.
- Prefer `StatelessWidget`; use `StatefulWidget` only when required (controllers, lifecycle, animations, etc.).

## Performance
- Use `const` constructors where possible.
- Split large widgets into smaller reusable widgets.
- Dispose controllers/listeners properly.
- Keep widget rebuilds minimal.

## AI Behavior
- Modify only files related to the current request.
- Never rewrite the entire project unless explicitly asked.
- Never change routing, folder structure, animations, or functionality without permission.
- Before creating a new widget, ViewModel, helper, or utility, check if an existing implementation can be reused.
- If a requested change could affect other parts of the project, explain it before making the change.

## Before Finishing
Ensure:
- No existing functionality is broken.
- UI remains unchanged unless requested.
- MVVM and Provider conventions are followed.
- Code is clean, modular, reusable, and production-ready.