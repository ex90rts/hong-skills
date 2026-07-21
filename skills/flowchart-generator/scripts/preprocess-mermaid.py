#!/usr/bin/env python3
"""Pre-process Mermaid source for better rendering.

1. Badge styles: Mermaid measures edge-label widths before inserting the final
   SVG, using a scratch element. If the badge is only styled by external CSS,
   the scratch element does not see the badge width and short labels get
   truncated. We inject an inline `style` attribute (with rgb() colors,
   because Mermaid's parser mangles `#` inside label HTML) into every
   `<span class='badge'>` / `<span class='badge-green'>` element.

2. Subgraph title padding: Mermaid places subgraph titles flush against the
   top border of the cluster. We prepend a `<br/>` to quoted subgraph titles
   so the title text sits a little lower, giving a cleaner visual padding.
"""

import re
import sys

BADGE_STYLE = (
    "display:inline-block;"
    "min-width:18px;"
    "min-height:18px;"
    "line-height:18px;"
    "text-align:center;"
    "background:rgb(59,130,246);"
    "color:rgb(255,255,255);"
    "border-radius:50%;"
    "font-size:12px;"
    "font-weight:700;"
    "margin-right:4px;"
    "padding:2px 6px;"
    "vertical-align:middle;"
)

BADGE_GREEN_STYLE = (
    "display:inline-block;"
    "min-width:18px;"
    "min-height:18px;"
    "line-height:18px;"
    "text-align:center;"
    "background:rgb(16,185,129);"
    "color:rgb(255,255,255);"
    "border-radius:50%;"
    "font-size:12px;"
    "font-weight:700;"
    "margin-right:4px;"
    "padding:2px 6px;"
    "vertical-align:middle;"
)

# Match: subgraph ID["title"] or subgraph ID['title']
SUBGRAPH_TITLE_RE = re.compile(
    r'(?P<prefix>subgraph\s+\w+\s*\[\s*(?P<quote>["\']))'
    r'(?P<title>.*?)'
    r'(?P=quote)\s*\]',
    re.IGNORECASE,
)


def add_badge_styles(text: str) -> str:
    # Match opening span tags that only have class='badge' or class="badge"
    # and avoid re-processing if a style attribute already exists.
    def badge_repl(m):
        q = m.group(1)  # quote char
        cls = m.group(2)
        style = BADGE_STYLE if cls == "badge" else BADGE_GREEN_STYLE
        return f"<span class={q}{cls}{q} style={q}{style}{q}"

    text = re.sub(
        r'<span\s+class=([\'"])((?:badge|badge-green))\1(?![^>]*\sstyle=)',
        badge_repl,
        text,
        flags=re.IGNORECASE,
    )
    return text


def add_subgraph_title_padding(text: str) -> str:
    """Add a small top padding to subgraph titles.

    Mermaid places subgraph titles flush against the top border. We wrap the
    title in an inline-block span with a small padding-top so the text is no
    longer touching the border, while keeping the title close to the content.
    """
    def repl(m):
        title = m.group('title')
        # If already padded, skip.
        if re.search(r'<span\s+style=\s*["\'][^"\']*padding-top', title, re.IGNORECASE):
            return m.group(0)
        return f"{m.group('prefix')}<span style='display:inline-block;padding-top:4px;padding-bottom:2px;'>{title}</span>{m.group('quote')}]"
    return SUBGRAPH_TITLE_RE.sub(repl, text)


def main():
    if len(sys.argv) < 3:
        print("Usage: preprocess-mermaid.py input.mmd output.mmd", file=sys.stderr)
        sys.exit(1)
    in_path = sys.argv[1]
    out_path = sys.argv[2]
    with open(in_path, "r", encoding="utf-8") as f:
        text = f.read()
    text = add_badge_styles(text)
    text = add_subgraph_title_padding(text)
    with open(out_path, "w", encoding="utf-8") as f:
        f.write(text)


if __name__ == "__main__":
    main()
