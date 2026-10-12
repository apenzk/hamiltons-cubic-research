#!/usr/bin/env python3
"""Render the loop skills' READMEs, mermaid and all, into one PDF.

WHY A SCRIPT RATHER THAN A ONE-OFF.  The diagrams live in the READMEs and the READMEs
change whenever a loop's rules do, so a PDF made by hand is out of date the moment the
next rule lands and nothing says which version it was.  This reads whatever the files
say NOW, so the artefact is always a rendering rather than a copy.

WHAT IT NEEDS.  Headless Chrome, for the mermaid.  Mermaid is fetched from cdnjs at
render time, so this wants network; with no network the diagrams come out blank and the
prose is still correct, which is the failure to watch for.

    python3 scripts/misc/loop_pdf.py [OUT.pdf] [--all]

It discovers every `.claude/skills/*/README.md` that contains a mermaid fence, so a
fourth loop needs no edit here.
"""

import html
import os
import pathlib
import re
import subprocess
import sys
import tempfile

REPO = pathlib.Path(__file__).resolve().parents[2]
SKILLS = REPO / ".claude" / "skills"
CHROME = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

# The order is the order a reader needs: what extends the record, what checks it, then
# how the two share a session.  Anything else discovered is appended alphabetically.
PREFERRED = ["research-loop", "lean-loop", "both-loops"]
ROLES = {
    "research-loop": "extends the record",
    "lean-loop": "checks the record",
    "both-loops": "shares a session",
    "verification-loop": "checks the record with readers",
}


def discover(everything=False):
    """The three loops by default; `--all` adds every other diagrammed skill.

    Discovery finds any README carrying a mermaid fence, which includes skills that
    are not loops at all, so the default is the named three and the rest is opt-in.
    A fourth LOOP is added by naming it in PREFERRED; anything else appears under
    `--all` without an edit here."""
    found = {p.parent.name: p for p in SKILLS.glob("*/README.md")
             if "```mermaid" in p.read_text(encoding="utf-8")}
    ordered = [n for n in PREFERRED if n in found]
    if everything:
        ordered += sorted(n for n in found if n not in PREFERRED)
    return [(n, found[n]) for n in ordered]


def inline(t):
    t = html.escape(t)
    t = re.sub(r"`([^`]+)`", r"<code>\1</code>", t)
    t = re.sub(r"\*\*([^*]+)\*\*", r"<strong>\1</strong>", t)
    t = re.sub(r"(?<!\*)\*([^*]+)\*(?!\*)", r"<em>\1</em>", t)
    t = re.sub(r"\[([^\]]+)\]\([^)]+\)", r"<a>\1</a>", t)
    return t


def body_of(md):
    """Markdown to HTML, with mermaid fences passed through untouched."""
    blocks = []

    def stash(m):
        blocks.append(m.group(1))
        return f"\x00M{len(blocks) - 1}\x00"

    md = re.sub(r"```mermaid\n(.*?)```", stash, md, flags=re.S)
    out, in_list, title = [], False, None
    for raw in md.split("\n"):
        s = raw.rstrip()
        if s.startswith("\x00M"):
            if in_list:
                out.append("</ul>")
                in_list = False
            n = int(re.search(r"\d+", s).group())
            out.append(f'<div class="dia"><pre class="mermaid">'
                       f'{html.escape(blocks[n])}</pre></div>')
            continue
        if not s.strip():
            if in_list:
                out.append("</ul>")
                in_list = False
            continue
        m = re.match(r"^(#{1,4}) (.*)$", s)
        if m:
            if in_list:
                out.append("</ul>")
                in_list = False
            lvl = len(m.group(1))
            if lvl == 1 and title is None:
                title = m.group(2)
                continue
            out.append(f"<h{lvl}>{inline(m.group(2))}</h{lvl}>")
            continue
        if re.match(r"^[-*] ", s):
            if not in_list:
                out.append("<ul>")
                in_list = True
            out.append(f"<li>{inline(s[2:])}</li>")
            continue
        if in_list:
            out.append("</ul>")
            in_list = False
        out.append(f"<p>{inline(s)}</p>")
    if in_list:
        out.append("</ul>")
    return title, "\n".join(out)


CSS = """
@page { size: A4; margin: 18mm 16mm; }
body { font-family: "IBM Plex Serif", Georgia, serif; font-size: 10.5pt; line-height: 1.55;
       color: #16191c; max-width: 165mm; }
h1 { font-family: "IBM Plex Sans", system-ui, sans-serif; letter-spacing: -.02em; }
h2 { font-family: "IBM Plex Sans", system-ui, sans-serif; font-size: 13pt; margin: 8mm 0 2mm;
     border-bottom: .4pt solid #dcd9cf; padding-bottom: 1.5mm; }
h3, h4 { font-family: "IBM Plex Sans", system-ui, sans-serif; font-size: 11pt; margin: 6mm 0 1.5mm; }
p { margin: 0 0 3mm; } ul { margin: 0 0 3mm; padding-left: 6mm; } li { margin-bottom: 1mm; }
code { font-family: "IBM Plex Mono", ui-monospace, monospace; font-size: 9pt;
       background: #f0eee8; padding: .3mm 1mm; border-radius: 1pt; }
em { color: #4a545b; } a { color: #1f6f8b; text-decoration: none; }
.dia { break-inside: avoid; page-break-inside: avoid; margin: 5mm 0 6mm; text-align: center; }
.dia svg { max-width: 100%; height: auto; }
.kicker { font-family: "IBM Plex Mono", monospace; font-size: 8.5pt; letter-spacing: .16em;
          text-transform: uppercase; color: #6b747b; margin: 0 0 3mm; }
.cover { height: 232mm; display: flex; flex-direction: column; justify-content: center;
         break-after: page; page-break-after: always; }
.covert { font-size: 34pt; margin: 0 0 6mm; }
.sub { font-size: 12pt; color: #4a545b; max-width: 120mm; margin: 0 0 14mm; }
.toc { list-style: none; padding: 0; margin: 0; border-top: .4pt solid #dcd9cf; }
.toc li { display: flex; justify-content: space-between; align-items: baseline;
          padding: 3mm 0; border-bottom: .4pt solid #dcd9cf; margin: 0; }
.tt { font-family: "IBM Plex Sans", sans-serif; font-size: 12pt; font-weight: 600; }
.tr { font-family: "IBM Plex Mono", monospace; font-size: 8.5pt; color: #1f6f8b; }
.doc { break-before: page; page-break-before: always; }
.doc > h1 { font-size: 22pt; margin: 0 0 6mm; padding-bottom: 3mm;
            border-bottom: 1pt solid #1f6f8b; }
"""


def main():
    args = [a for a in sys.argv[1:] if a != "--all"]
    out_pdf = pathlib.Path(args[0] if args else "the-three-loops.pdf").resolve()
    docs = discover(everything="--all" in sys.argv)
    if not docs:
        print("no skill README carries a mermaid fence", file=sys.stderr)
        return 1
    if not os.path.exists(CHROME):
        print(f"headless Chrome not found at {CHROME}; install it or edit CHROME",
              file=sys.stderr)
        return 1

    parts = ['<div class="cover">',
             '<p class="kicker">hamiltons-cubic &middot; .claude/skills</p>',
             f'<h1 class="covert">The {"Three" if len(docs) == 3 else len(docs)} '
             f'{"Loops" if len(docs) == 3 else "Skills"}</h1>',
             '<p class="sub">Rendered from the READMEs as they stand. '
             'Only the research loop can advance the conjecture; the others secure '
             'and schedule what it produces.</p>', '<ol class="toc">']
    bodies = []
    for name, path in docs:
        title, inner = body_of(path.read_text(encoding="utf-8"))
        title = title or name
        role = ROLES.get(name, "")
        parts.append(f'<li><span class="tt">{html.escape(title)}</span>'
                     f'<span class="tr">{html.escape(role)}</span></li>')
        bodies.append(f'<section class="doc"><p class="kicker">{html.escape(role)}</p>'
                      f'<h1>{html.escape(title)}</h1>{inner}</section>')
    parts.append("</ol></div>")

    page = ('<!doctype html><html><head><meta charset="utf-8">'
            '<title>The Three Loops</title>'
            '<script src="https://cdnjs.cloudflare.com/ajax/libs/mermaid/10.9.1/'
            'mermaid.min.js"></script>'
            f"<style>{CSS}</style></head><body>"
            + "\n".join(parts + bodies)
            + "<script>mermaid.initialize({startOnLoad:true,theme:'neutral',"
              "flowchart:{useMaxWidth:true}});</script></body></html>")

    # PROBE THE ACTUAL CAUSE, BEFORE SPENDING THE RENDER.  Two proxies were tried and
    # both were wrong: a page count (7 pages against 6 fences with no network, so it never
    # fired) and a count of vector operators in the PDF bytes (meaningless, since content
    # streams are Flate-compressed, so it fired on a correct render).  mermaid is fetched
    # from cdnjs at render time and that fetch is the thing that fails, so it is the thing
    # to test.
    try:
        import urllib.request
        urllib.request.urlopen(
            "https://cdnjs.cloudflare.com/ajax/libs/mermaid/10.9.1/mermaid.min.js",
            timeout=10).read(1024)
    except Exception as exc:
        print(f"cdnjs is unreachable ({exc}), so mermaid cannot load and the diagrams "
              f"would render blank. Refusing to write a PDF that silently drops its "
              f"subject. Retry with network, or pass --no-diagrams to accept prose only.",
              file=sys.stderr)
        if "--no-diagrams" not in sys.argv:
            return 1

    with tempfile.TemporaryDirectory() as td:
        src = pathlib.Path(td) / "all.html"
        src.write_text(page, encoding="utf-8")
        subprocess.run([CHROME, "--headless", "--disable-gpu", "--no-sandbox",
                        "--virtual-time-budget=20000", "--no-pdf-header-footer",
                        f"--print-to-pdf={out_pdf}", f"file://{src}"],
                       check=True, capture_output=True)

    data = out_pdf.read_bytes()
    pages = data.count(b"/Type /Page") - data.count(b"/Type /Pages")

    print(f"{out_pdf}  {len(data) // 1024} KB, {pages} pages, "
          f"from {', '.join(n for n, _ in docs)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
