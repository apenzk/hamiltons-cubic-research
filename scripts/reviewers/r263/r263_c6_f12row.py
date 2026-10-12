"""r263 CLAIM 6 -- r259's recommendation 5 asked for the f = 12 row, and the record
states its conclusion without a run.

findings/brauer-pairing.md: "At f=12 the two part company at every n<=10 and agree at
every n>=11."  run_diagram_realisation.py prints prose at f = 12 and computes nothing.
Both counts are pure combinatorics -- no n^f tensor -- so the row is affordable.
"""
def conj(lam):
    return tuple(sum(1 for p in lam if p > k) for k in range(lam[0])) if lam else ()

def admissible(lam, n):
    c = conj(lam)
    return (c[0] if c else 0) + (c[1] if len(c) > 1 else 0) <= n

def updown(f, n=None):
    """n = None -> unrestricted (dim Delta_lambda); else restricted (m_lambda(n))."""
    cur = {(): 1}
    for _ in range(f):
        nxt = {}
        for lam, c in cur.items():
            for k in range(len(lam) + 1):
                new = list(lam) + [0]; new[k] += 1
                if all(new[t] >= new[t+1] for t in range(len(new)-1)):
                    key = tuple(x for x in new if x)
                    if n is None or admissible(key, n):
                        nxt[key] = nxt.get(key, 0) + c
            for k in range(len(lam)):
                new = list(lam); new[k] -= 1
                if new[k] >= 0 and all(new[t] >= new[t+1] for t in range(len(new)-1)):
                    key = tuple(x for x in new if x)
                    if n is None or admissible(key, n):
                        nxt[key] = nxt.get(key, 0) + c
        cur = nxt
    return cur

f = 12
cell_all = updown(f)
print(f"  f = {f}:  sum over ALL labels of (dim Delta_lambda)^2 = {sum(d*d for d in cell_all.values())}"
      f"   ((2f-1)!! = {23*21*19*17*15*13*11*9*7*5*3*1})")
print(f"\n  {'n':>3} {'sum m_lambda(n)^2':>18} {'sum (dim Delta)^2':>18} {'agree':>7}   n >= f-1 = 11")
first_agree = None
for n in range(1, 15):
    uni = sum(c*c for c in updown(f, n).values())
    cell = sum(d*d for lam, d in cell_all.items() if admissible(lam, n))
    ok = uni == cell
    if ok and first_agree is None:
        first_agree = n
    print(f"  {n:>3} {uni:>18} {cell:>18} {str(ok):>7}   {n >= f-1}")
print(f"\n  the two forms first agree at n = {first_agree}"
      f"   -- the record says they 'part company at every n <= 10 and agree at every n >= 11'")

# and the block count of the n=12 table, from the same recursion
print(f"\n  labels of V^{{tensor 12}} admissible at n=12: "
      f"{len([l for l in updown(f, 12)])}  (of {len(cell_all)} labels in all)")
print(f"  labels admissible at n=6 : {len([l for l in updown(f, 6)])}"
      f"   -- the record's '77 of 160'")
