from fractions import Fraction
from itertools import combinations_with_replacement
def span_test(values, mults, label):
    d = len(values)
    types = [t for t in combinations_with_replacement(range(d), 3)
             if all(t.count(v) <= mults[v] for v in set(t))]
    rows = []
    for v in range(d):
        for rel in ('A', 'B', 'C'):
            row = []
            for t in types:
                acc = Fraction(0)
                for pos in range(3):
                    if t[pos] == v:
                        others = [t[i] for i in range(3) if i != pos]
                        if rel == 'A': acc += 1
                        elif rel == 'B': acc += values[others[0]] + values[others[1]]
                        else: acc += values[others[0]]*values[others[1]]
                row.append(acc)
            rows.append(row)
    F = []
    for t in types:
        x, y, z = (values[t[0]], values[t[1]], values[t[2]])
        F.append(x*x*y*y + y*y*z*z + z*z*x*x)
    Mrows = [r[:] for r in rows]
    ncols = len(types); piv = []; r_i = 0
    for col in range(ncols):
        sel = None
        for rr in range(r_i, len(Mrows)):
            if Mrows[rr][col] != 0: sel = rr; break
        if sel is None: continue
        Mrows[r_i], Mrows[sel] = Mrows[sel], Mrows[r_i]
        pv = Mrows[r_i][col]
        Mrows[r_i] = [x/pv for x in Mrows[r_i]]
        for rr in range(len(Mrows)):
            if rr != r_i and Mrows[rr][col] != 0:
                f = Mrows[rr][col]
                Mrows[rr] = [a - f*b for a, b in zip(Mrows[rr], Mrows[r_i])]
        piv.append(col); r_i += 1
        if r_i == len(Mrows): break
    rank = r_i
    Fred = F[:]
    for rr, col in enumerate(piv):
        if Fred[col] != 0:
            f = Fred[col]
            Fred = [a - f*b for a, b in zip(Fred, Mrows[rr])]
    in_span = all(x == 0 for x in Fred)
    print(f"[{label}] d={d} #types={len(types)} rank={rank} F220 in span: {in_span}")
    return rank, in_span
