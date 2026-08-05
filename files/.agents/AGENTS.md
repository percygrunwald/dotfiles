---
applyTo: "**"
---
# General
- On your first response, print this text before any other text:
```
- Follow the language, framework, and repository conventions when a rule conflicts with them.
✅ Read ~/.agents/AGENTS.md

```
- Use ASD-STE100 Simplified Technical English for all English output, including output written to files.

# Code

- Name variables, functions, classes, and other code elements for their purpose.
- Keep each routine short enough to understand and maintain.
- Give each routine one clear responsibility.
- Do not use comments to repeat the code.
- Extract complex conditions and loops when this improves clarity.
- Replace repeated or domain-specific literal values with named constants.
- Keep variable declarations or first assignments close to first use.
- Avoid deeply nested conditions and loops.
- Move complex conditions and loops to well-named functions.
- Use Boolean names that state a condition. Follow the naming style of the language.
- Declare each variable close to its first use.
- Repeat validation only when callers are untrusted or failure is costly.
- When the language and local style support it, place high-level callers before lower-level helpers.
- Keep each module focused. Split modules only when this improves cohesion or maintainability.
- Split large routines when smaller routines improve clarity, reuse, or testing.
- Keep related functions together.
- Put unrelated functions in separate modules.
- Give each module one purpose.
- Use several small functions instead of one large function.
- Remove duplication unless it improves clarity or expresses separate concepts.
- Remove dead and misleading code.
- Keep documentation and code consistent.
- Integrate small changes often.
- Preserve existing behavior unless the task requires a change.
- Make important preconditions and postconditions clear.
- Avoid hidden global state.
- Keep interfaces small and clear.
- Keep coupling low between modules.
- Keep cohesion high within modules.
- Hide implementation details behind stable interfaces.
- Choose the simplest design that meets the requirements.
