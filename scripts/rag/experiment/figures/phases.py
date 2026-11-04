"""Draws the phases of the RAG experiment and their outcome into phases.png beside this script.

    .venv/bin/python scripts/rag/experiment/figures/phases.py
"""
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import FancyArrowPatch, FancyBboxPatch

INK = '#1f2328'
MUTED = '#57606a'
STYLE = {'done': ('#e6f4ea', '#2f8a4c', '-'), 'stop': ('#fcebdc', '#c46a1f', '-'),
         'skip': ('#f6f8fa', '#8c959f', '--')}
PHASES = [
    ('0', 'Eval set', ['26 incidents,', '8 negatives,', 'frozen'], 'done'),
    ('1', 'Registries', ['results, values,', 'paper manifest,', 'arXiv TeX'], 'done'),
    ('2', 'Arms B, C', ['keyword search', 'B 2/26', 'C 4/26'], 'done'),
    ('5', 'Arms D, E', ['Qwen vectors', 'D 3/26', 'E 4/26'], 'stop'),
    ('3', 'Arm A', ['cold agent,', 'as cycles', 'search today'], 'skip'),
    ('4', 'Sidecars', ['generated', 'summary per', 'function'], 'skip'),
    ('6', 'Arm F', ['agent with', 'the tool,', 'decision'], 'skip'),
]


def main():
    w, h, gap = 1.55, 2.1, 0.45
    fig, ax = plt.subplots(figsize=(13, 3.6))
    ax.set_xlim(0, len(PHASES) * (w + gap))
    ax.set_ylim(-0.75, 2.75)
    ax.axis('off')
    for i, (num, title, lines, kind) in enumerate(PHASES):
        fill, edge, ls = STYLE[kind]
        x = i * (w + gap) + 0.1
        ax.add_patch(FancyBboxPatch((x, 0), w, h, boxstyle='round,pad=0.02,rounding_size=0.12',
                                    fc=fill, ec=edge, lw=1.5, ls=ls))
        ax.text(x + w / 2, h - 0.22, f'Phase {num}', ha='center', va='top', fontsize=8.5, color=edge,
                fontweight='bold')
        ax.text(x + w / 2, h - 0.55, title, ha='center', va='top', fontsize=11, color=INK, fontweight='bold')
        ax.text(x + w / 2, h - 1.0, '\n'.join(lines), ha='center', va='top', fontsize=8.6, color=MUTED,
                linespacing=1.4)
        if i:
            skip = kind == 'skip'
            ax.add_patch(FancyArrowPatch((x - gap + 0.04, h / 2), (x - 0.04, h / 2), arrowstyle='-|>',
                                         mutation_scale=12, lw=1.2, color='#8c959f' if skip else MUTED,
                                         ls='--' if skip else '-'))
    stop_x = 4 * (w + gap) + 0.1 - gap / 2
    ax.plot([stop_x, stop_x], [-0.35, h + 0.35], color=STYLE['stop'][1], lw=2)
    ax.text(stop_x, h + 0.45, 'stop rule: D at most 5 of 26', ha='center', fontsize=9, color=STYLE['stop'][1],
            fontweight='bold')
    for k, (label, kind) in enumerate([('done', 'done'), ('ran, triggered the stop rule', 'stop'),
                                       ('not run', 'skip')]):
        fill, edge, ls = STYLE[kind]
        x = 0.1 + k * 3.2
        ax.add_patch(FancyBboxPatch((x, -0.62), 0.32, 0.22, boxstyle='round,pad=0.01', fc=fill, ec=edge,
                                    lw=1.2, ls=ls))
        ax.text(x + 0.45, -0.51, label, va='center', fontsize=8.6, color=MUTED)
    out = Path(__file__).with_suffix('.png')
    fig.savefig(out, dpi=180, bbox_inches='tight', facecolor='white')
    print(out)


if __name__ == '__main__':
    main()
