---
applyTo: "**"
---
# Agent preferences

## General

- On your first response, print this exact status line before any other text.
  It is literal output text, not an instruction to read the named file:
```
✅ I have read `~/.agents/AGENTS.md`

```
- Use ASD-STE100 Simplified Technical English for all English output, including output written to files.
- Use American English unless otherwise instructed.
- Don't use smart quotes (use regular quotes instead) or em-dashes (use regular hyphens instead).
- If in doubt about any of the guidelines, simply ask before starting work. If you are explicitly instructed to ask no questions, make an assumption, note the assumption and proceed.

## Commands

- You MUST prefix all commands with `PATH="$HOME/bin:$HOME/.asdf/shims:$PATH"`

## Web research

- Do not use browser UI automation unless instructed (e.g. `mcp__cua_repl`).
- Use an enabled web search tool, fetch tool or `curl` for web research.

## Network requests

- Before making a network request from a command or tool, request sandbox network permission. This applies to browser requests and other tools, including `curl`, Cargo commands, Git commands, and package managers.
- If a request fails because network access is restricted, request sandbox permission and retry. Do not treat a failure before permission was granted as a confirmed network outage.
- If requests still fail after permission is granted, stop and report the error. Do not continue based on assumptions.

## Code

### General

- Follow the recommendations of Code Complete 2nd Ed. by Steve McConnell. If following the recommendations would produce code that is not idiomatic for a given language, use the language's idioms instead. The most important recommendations are:
  - Order code top-down by dependency and use, while respecting language requirements and idioms. Put callers and higher-level API methods before the helpers they call. Put a shared helper after all its callers. Order related methods by workflow or API use. Use alphabetical order only for peers with no clearer order.
- Err on the side of "over-factoring":
  - Keep each function at one level of abstraction. An orchestration function should call named steps. Each step function should do one job.
  - Split distinct phases into named helpers, even when each helper has one caller. Apply this to closures, too. Keep inline closures short. Move multi-step behavior into a named function.
  - Treat any function or closure longer than about 15 lines as a prompt to review its factoring. Also split shorter functions that perform multiple distinct phases. Line count is a review prompt, not a hard limit.
  - Prefer named helpers for meaningful phases in parsing, serialization, I/O, and setup or cleanup.
  - Keep the caller as a short sequence of named steps. Do not add wrappers for trivial statements. Each helper should have a clear purpose.
  - If a file contains multiple classes/structs with implementations, consider breaking these into separate files even before they get "large" for conceptual
- Use newlines to add visual separation to make the code easier to read.
- If a function body has multiple lines and the last line returns a value, add a preceeding newline.
- Always ask before adding dependencies to a project.
- When nesting 2 or more levels, consider whether it would be cleaner/more readable to refactor to remove the nesting.
- Name non-trivial boolean checks with a descriptive local variable or function before using them in conditionals.
- Before adding upstream depedencies (e.g. crates, packages, etc.):
  - If it's a de-facto standard dependency for the language (e.g. serde in rust), feel free to add it if it's the right solution for the project
  - In other cases, make sure to research whether the dependency is mature and widely used (e.g. Github stars, forks, PRs, etc.) before adding it
  - When in doubt: ask. Or if explicitly instructed not to ask: err on the side of not adding immature dependencies.
- Keep functions focused on real use. Do not add or retain functions only to support tests. When a refactor changes an interface, update the tests to use it and remove redundant helpers. Add test-only code only when the behavior cannot be tested through the real interface
- For function calls with a multi-field struct argument, build the struct in a named local first. Keep the call focused on the operation, not the setup.

### Tests

- While writing the tests, look for repeated setup and expected values. Add small helpers when they make the tests shorter and clearer.
- Keep each test focused on one behavior. Treat length as a smell, not a limit: review long tests (e.g. for mixed behaviors) and consider splitting them. Prefer clear tests over the fewest possible tests.
- Move substantial test helpers into a separate module file and import that module.

### Rust

- For expressions/statements that break onto >3 lines, _consider_ putting this into its own function to keep the code cleaner.
- Keep comments within Rustfmt's default `comment_width` of 80 columns, as Rustfmt does not wrap comments by default.
- Use `thiserror` when projects need custom error types.
- Keep each type declaration next to its primary impl block. Place supporting types after the primary type and its impl when that order makes the API easier to scan. This may override other ordering preferences.
- Keep control flow shallow. For example, a loop → match → branch → conditional chain is too deep. When a match arm needs conditional logic or several state updates, move that work into a named helper. Use indentation as a readability check.
- Put unit tests in a separate file.

### Shell

- Use Bash by default for shell scripts and enable set -o pipefail. Use features supported by the Bash version shipped with recent macOS releases, Bash 3.2.
- Use a named variable or function to wrap a complex command or argument list. Give the variable/function a clear name that describes its purpose.
- Document function arguments and add brief documentation at the top of shell scripts.
- Pipe list variables into loops with printf; do not pass them through here-docs at the end of loops.
- Print a brief status message before each action to say what the script is about to do.
- Move functions used by multiple files into a shared common file.
- Use `shellcheck` to check shell code for errors.
- Write an explicit empty value with quotes, such as CDPATH='' cd, to make the intent clear.
