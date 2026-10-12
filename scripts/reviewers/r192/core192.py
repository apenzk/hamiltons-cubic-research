'''Shared exact machinery for reviewer 192: the lowering action on Sym^3,
leading-term reduction, the BFS word list and the replay.'''

import json, os, itertools, random
from fractions import Fraction as F

HERE = os.path.dirname(os.path.abspath(__file__))
RUNS = os.path.join(HERE, "..", "..", "runs")
C = json.load(open(os.path.join(RUNS, "n5_hw_cache.json")))
L = json.load(open(os.path.join(HERE, "low_cache.json")))
def gq(pr):
    (rn, rd), (inn, idd) = pr
    return (F(rn, rd), F(inn, idd))
Z = (F(0), F(0))
def cadd(x, y): return (x[0]+y[0], x[1]+y[1])
def cmul(x, y): return (x[0]*y[0]-x[1]*y[1], x[0]*y[1]+x[1]*y[0])
def cdiv(x, y):
    d = y[0]*y[0]+y[1]*y[1]
    return ((x[0]*y[0]+x[1]*y[1])/d, (x[1]*y[0]-x[0]*y[1])/d)
LOW = [[[gq(x) for x in row] for row in L["F1C"]],
       [[gq(x) for x in row] for row in L["F2C"]]]
MONO = list(itertools.combinations_with_replacement(range(35), 3))
MIDX = {m: i for i, m in enumerate(MONO)}

def lower(vec, EC):
    out = {}
    for idx, co in vec.items():
        a, b, c = MONO[idx]
        for pos, x in enumerate((a, b, c)):
            rest = [y for j, y in enumerate((a, b, c)) if j != pos]
            for t in range(35):
                if EC[x][t] != Z:
                    j = MIDX[tuple(sorted(rest+[t]))]
                    out[j] = cadd(out.get(j, Z), cmul(co, EC[x][t]))
    return {k: v for k, v in out.items() if v != Z}

def reduce_full(w, ech):
    w = dict(w)
    while w:
        piv = max(w)
        if piv not in ech: break
        f = cdiv(w[piv], ech[piv][piv])
        for k, c in ech[piv].items():
            p = cmul(f, c); cur = w.get(k, Z)
            w[k] = (cur[0]-p[0], cur[1]-p[1])
        w = {k: c for k, c in w.items() if c != Z}
    return w

def word_list(u, cap):
    ech, words, out = {}, [], []
    frontier = [([], u)]
    while frontier and len(out) < cap:
        nxt = []
        for word, v in frontier:
            r = reduce_full(v, ech)
            if not r: continue
            ech[max(r)] = r; out.append(v); words.append(word)
            for oi in (0, 1):
                nv = lower(v, LOW[oi])
                if nv: nxt.append((word+[oi], nv))
        frontier = nxt
    return words

def replay(u, words):
    out = []
    for w in words:
        v = u
        for oi in w: v = lower(v, LOW[oi])
        out.append(v)
    return out

def rank_of(vecs):
    ech = {}; r = 0
    for v in vecs:
        w = reduce_full(v, ech)
        if w: ech[max(w)] = w; r += 1
    return r

def dimB2(l): return (l[0]-l[1]+1)*(l[0]+l[1]+2)*(2*l[0]+3)*(2*l[1]+1)//6


