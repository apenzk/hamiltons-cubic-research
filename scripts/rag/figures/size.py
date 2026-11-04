"""Draws the growth of the retrieval index and vector cache from RAG-SIZE.json into RAG-SIZE.png.

    .venv/bin/python scripts/rag/figures/size.py [<root>]

<root> is the checkout holding RAG-SIZE.json, the current directory by default. rag.py runs
this after every `index`, so the chart in RAG-SIZE.md stays current.
"""
import json
import sys
from datetime import datetime
from pathlib import Path

import matplotlib.dates as mdates
import matplotlib.pyplot as plt

INDEX = '#3b78c4'
CACHE = '#c46a1f'


def main():
    root = Path(sys.argv[1] if len(sys.argv) > 1 else '.')
    rows = json.loads((root / 'RAG-SIZE.json').read_text())
    t = [datetime.fromisoformat(r['time']) for r in rows]
    fig, ax = plt.subplots(figsize=(8, 3.4))
    ax.plot(t, [r['index_mb'] for r in rows], marker='o', color=INDEX, label='index.sqlite')
    ax.plot(t, [r['cache_mb'] for r in rows], marker='o', color=CACHE, label='vector cache')
    ax.set_ylabel('MB')
    ax.set_ylim(bottom=0)
    ax.grid(axis='y', color='#d0d7de', lw=0.6)
    for side in ('top', 'right'):
        ax.spines[side].set_visible(False)
    ax.xaxis.set_major_formatter(mdates.DateFormatter('%m-%d %H:%M'))
    fig.autofmt_xdate()
    ax.legend(frameon=False, loc='upper left')
    fig.savefig(root / 'RAG-SIZE.png', dpi=150, bbox_inches='tight', facecolor='white')


if __name__ == '__main__':
    main()
