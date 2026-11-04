"""Draws the retrieval pipeline of the retrieval tool into pipeline.png beside this script.

    .venv/bin/python scripts/rag/figures/pipeline.py
"""
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import FancyArrowPatch, FancyBboxPatch

INK = '#1f2328'
MUTED = '#57606a'
FILL = {'input': '#eef2f7', 'step': '#ffffff', 'keyword': '#e3eefc', 'vector': '#fcebdc',
        'fuse': '#fdf3d7', 'output': '#f6f8fa', 'store': '#f3eefc', 'rerank': '#e6f4ea'}
EDGE = {'input': '#8c959f', 'step': '#8c959f', 'keyword': '#3b78c4', 'vector': '#c46a1f',
        'fuse': '#b08800', 'output': '#8c959f', 'store': '#7a5cc4', 'rerank': '#2f8a4c'}


def box(ax, x, y, w, h, title, lines, kind):
    ax.add_patch(FancyBboxPatch((x, y), w, h, boxstyle='round,pad=0.02,rounding_size=0.12',
                                fc=FILL[kind], ec=EDGE[kind], lw=1.4))
    ax.text(x + w / 2, y + h - 0.28, title, ha='center', va='top', fontsize=10.5,
            fontweight='bold', color=INK)
    ax.text(x + w / 2, y + h - 0.72, '\n'.join(lines), ha='center', va='top', fontsize=8.6,
            color=MUTED, linespacing=1.45)


def arrow(ax, a, b, color=MUTED, label=None, rad=0.0):
    ax.add_patch(FancyArrowPatch(a, b, arrowstyle='-|>', mutation_scale=13, lw=1.3, color=color,
                                 connectionstyle=f'arc3,rad={rad}', shrinkA=2, shrinkB=2))
    if label:
        ax.text((a[0] + b[0]) / 2, (a[1] + b[1]) / 2 + 0.16, label, ha='center', fontsize=8,
                color=color, style='italic')


def main():
    fig, ax = plt.subplots(figsize=(17.5, 6.4))
    ax.set_xlim(0, 17.7)
    ax.set_ylim(0, 6.4)
    ax.axis('off')

    box(ax, 0.2, 1.4, 2.3, 2.8, 'The record', ['markdown notes', 'Python and Lean', 'arXiv papers (TeX)',
                                                 'results.jsonl', 'values.jsonl'], 'input')
    box(ax, 3.0, 1.4, 2.3, 2.8, 'Chunker', ['cut at headings,', 'heading trail kept', 'one per function',
                                             'or declaration', 'one per theorem', 'one per result'], 'step')
    box(ax, 5.8, 1.4, 2.2, 2.8, 'Chunk store', ['index.sqlite:', 'chunks table,', 'FTS5 word and', 'trigram tables,',
                                          'sqlite-vec table'], 'store')
    box(ax, 8.6, 3.15, 2.4, 1.9, 'Keyword search', ['SQLite FTS5, BM25', 'over words and', 'over trigrams'], 'keyword')
    box(ax, 8.6, 0.55, 2.4, 1.9, 'Meaning search', ['Qwen3-Embedding-0.6B', 'cosine similarity',
                                                    'over sqlite-vec'], 'vector')
    box(ax, 11.6, 1.4, 1.75, 2.8, 'Combine', ['merges the', 'two lists,', 'top 200 of each'], 'fuse')
    box(ax, 13.75, 1.4, 1.75, 2.8, 'Rerank', ['Qwen3-Reranker', '-0.6B rescores', 'the top 200,', 'live results',
                                              'before withdrawn'], 'rerank')
    box(ax, 15.9, 1.4, 1.65, 2.8, 'Top 20 hits', ['file:line', 'heading', 'status', 'first 200', 'characters'],
        'output')
    box(ax, 8.6, 5.45, 2.4, 0.9, 'Query', ['one statement-sized string'], 'input')

    arrow(ax, (2.5, 2.8), (3.0, 2.8))
    arrow(ax, (5.3, 2.8), (5.8, 2.8), EDGE['store'])
    ax.text(5.55, 3.0, 'chunks', ha='center', fontsize=8.5, color=MUTED, style='italic')
    arrow(ax, (8.0, 3.3), (8.6, 4.1), EDGE['keyword'], rad=-0.15)
    arrow(ax, (8.0, 2.3), (8.6, 1.5), EDGE['vector'], rad=0.15)
    arrow(ax, (9.8, 5.45), (9.8, 5.05))
    ax.plot([11.0, 11.3, 11.3], [5.9, 5.9, 2.75], color=MUTED, lw=1.3)
    arrow(ax, (11.3, 2.75), (10.6, 2.47))
    arrow(ax, (11.0, 4.1), (11.6, 3.3), EDGE['keyword'], rad=0.15)
    arrow(ax, (11.0, 1.5), (11.6, 2.3), EDGE['vector'], rad=-0.15)
    arrow(ax, (13.35, 2.8), (13.75, 2.8), EDGE['fuse'])
    arrow(ax, (15.5, 2.8), (15.9, 2.8), EDGE['rerank'])

    out = Path(__file__).with_suffix('.png')
    fig.savefig(out, dpi=180, bbox_inches='tight', facecolor='white')
    print(out)


if __name__ == '__main__':
    main()
