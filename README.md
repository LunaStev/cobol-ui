# COBOL UI

COBOL UI is a tiny “COBOL-like” declarative UI language and a generator that outputs plain HTML.

You write a `.cbl` file that looks like a document rather than markup. The tool parses it into an AST and renders HTML. The goal is not to be COBOL-compatible, and not to replace HTML/CSS frameworks. The goal is to make “form-like / document-like” pages easy to define with strict, readable structure, and to let a generator do the boring parts.

This repository contains:

- a lexer and parser for the `.cbl` UI DSL
- an AST builder based on COBOL-style level numbers (01/05/10…)
- an HTML renderer that can emit either “modern minimal HTML” or “no-style retro HTML” depending on the input

===

## What problem this tries to solve

Modern UI is often written as a mixture of structure, styling, and behavior. That is fine when you are already inside a framework. But sometimes you want something simpler:

You want a screen that reads like a form. You want strict input that can be validated easily. You want output HTML without hand-writing tags. You want something you can generate, diff, review, and keep stable for years.

COBOL historically excelled at describing business data and documents. COBOL UI borrows that “document definition” feel and aims it at HTML output.

This is especially useful for:

Admin pages, internal tools, dashboards, settings pages, reports, invoice-like documents, static landing pages, and “retro” pages where you want pure HTML without CSS.

---

## Quick start

Build and run:

```bash
cargo run -- examples/01_login.cbl out.html
```

If you omit the output path, it prints HTML to stdout:

```bash
cargo run -- examples/01_login.cbl
```

---

## The DSL in 60 seconds

A `.cbl` file is a list of statements. Every statement ends with a dot (.).
Each statement starts with a “level number” and a name:

```cobol
01 SCREEN.
05 HEADER.
10 TEXT VALUE "Hello".
```

The level number controls nesting. A higher number becomes a child of the previous lower level. A lower-or-equal number closes the previous scope and attaches higher up.

In other words: you build a tree by indentation, but using numbers instead of spaces.

A statement can also have attributes. Attributes are simple keyword + string pairs:

```cobol
10 INPUT TYPE "password" NAME "password" ID "pw" PIC X(20).
```

Some keywords have special meaning:

- `VALUE "..."` is used by text-like elements (`TEXT`, `LABEL`, `BUTTON`, `LINK`)
- `PIC X(n)` is used by `INPUT` as a hint for length / size
- `ID "..."` and `CLASS "..."` become HTML id and class
- Any other `KEY "value"` becomes a generic HTML attribute (lowercased on output)

---

## Core elements

The “container” elements build page structure:

```cobol
01 SCREEN.
   05 HEADER.
   05 BODY.
   05 FOOTER.
```

Layout helpers:

```cobol
05 BODY.
   10 ROW.
      15 COL.
      15 COL.
```

Basic components:

```cobol
10 TEXT VALUE "Hello".
10 LABEL VALUE "Username".
10 INPUT PIC X(20) NAME "user".
10 BUTTON VALUE "Submit" TYPE "submit".
10 LINK VALUE "Open docs" HREF "#docs".
10 IMAGE SRC "https://example.com/banner.png" ALT "banner".
```

There is also a “retro HTML” subset for CSS-free pages:

```cobol
10 CENTER.
10 HR.
10 BR.
10 LIST.
10 ITEM.
10 TABLE.
10 TR.
10 TD.
10 MARQUEE.
```

---

## Example 1: login screen

`examples/01_login.cbl`

```cobol
01 SCREEN ID "login".
   05 HEADER.
      10 TEXT VALUE "Login".
   05 BODY.
      10 ROW.
         15 LABEL VALUE "User" FOR "user".
         15 INPUT PIC X(20) ID "user" NAME "user".
      10 ROW.
         15 LABEL VALUE "Password" FOR "password".
         15 INPUT PIC X(20) ID "password" TYPE "password" NAME "password".
      10 ROW.
         15 BUTTON VALUE "Sign in" TYPE "submit".
```

This generates HTML that is intentionally simple and readable. You can add more props as needed:

```cobol
15 INPUT TYPE "email" NAME "email" PLACEHOLDER "you@example.com" AUTOCOMPLETE "email".
```

## Example 2: small admin dashboard layout

```cobol
01 SCREEN ID "dashboard".
   05 HEADER.
      10 TEXT VALUE "Admin Dashboard".
   05 BODY.
      10 ROW.
         15 COL.
            20 TEXT VALUE "Users".
            20 TEXT VALUE "120".
         15 COL.
            20 TEXT VALUE "Revenue".
            20 TEXT VALUE "$3,210".
```

## Example 3: CSS-free 1990s-style page

If you want “pure HTML without CSS”, set `NOSTYLE "true"` on the `SCREEN`.
When `NOSTYLE` is enabled, the renderer avoids injecting the `<style>` block and also avoids adding layout helper classes automatically.

```cobol
01 SCREEN NOSTYLE "true" ID "home".
   05 HEADER.
      10 CENTER.
         15 TEXT AS "h1" VALUE "Neo Park's Home Page".
         15 HR.
         15 MARQUEE BEHAVIOR "alternate" SCROLLAMOUNT "6".
            20 TEXT VALUE "★ Welcome to my personal homepage! ★".
   05 BODY.
      10 TEXT AS "h2" VALUE "About Me".
      10 TEXT VALUE "This page is generated from a .cbl UI declaration into plain HTML.".
      10 HR.
      10 TEXT AS "h2" VALUE "Links".
      10 LIST.
         15 ITEM.
            20 LINK VALUE "My BBS" HREF "#".
         15 ITEM.
            20 LINK VALUE "Kernel.org" HREF "https://www.kernel.org/".
      10 HR.
      10 TABLE BORDER "1" CELLPADDING "6" CELLSPACING "0" WIDTH "90%".
         15 TR.
            20 TD.
               25 TEXT VALUE "CPU".
            20 TD.
               25 TEXT VALUE "Pentium II 400MHz".
```

---

## Attributes and how they map to HTML

The DSL is deliberately strict. Attributes are key-value pairs in the statement. Keys are case-insensitive in the DSL. Output keys are lowercased.

This:

```cobol
10 LINK VALUE "Download" HREF "/download" TARGET "_blank".
```

Becomes:

```cobol
<a href="/download" target="_blank">Download</a>
```

This:

```cobol
10 INPUT TYPE "text" NAME "title" PLACEHOLDER "hello" PIC X(40) ID "title".
```

Becomes:

```cobol
<input type="text" name="title" placeholder="hello" size="40" id="title">
```

Notes:

`PIC X(n)` becomes `size="n"` on the output `<input>`.
`CLASS "a b c"` becomes `class="a b c"`.
`ID "..."` becomes `id="..."`.

Some attributes are currently “internal” and are not emitted directly as raw HTML attributes:

- `NOSTYLE` (used to control renderer output)
- `AS` (used to select a tag for `TEXT`)
- `FOR` is supported for `LABEL` and is emitted as `for="..."`

---

## TEXT tags with AS

`TEXT` renders as `<p>` by default. If it is inside `HEADER`, it renders as `<h1>` by default.

You can override that using `AS`:

```cobol
10 TEXT AS "h2" VALUE "Section Title".
10 TEXT AS "pre" VALUE "line1\nline2\n".
10 TEXT AS "blockquote" VALUE "A quote".
```

Only a small allowlist is accepted for safety (p/h1-h6/pre/blockquote).

---

## License

This project is licensed under the Mozilla Public License 2.0 (MPL-2.0).