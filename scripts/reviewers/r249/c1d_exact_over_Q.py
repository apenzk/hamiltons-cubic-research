"""r249 / claim 1(b), the docstring: "Orthonormalising it is exact over Q by
Gram-Schmidt on the Frobenius product."

ORTHOnormalising is not exact over Q -- the norms are square roots of rationals.
The code knows this and does floats ("float here, exactness is the next step"),
so the docstring and the code disagree.

P itself IS exactly rational, by a route the file does not take: run Gram-Schmidt
WITHOUT normalising and set P = sum_k b_k (x) b_k / <b_k, b_k>.  Every quantity
stays in Q.  Verified here at n = 5: exact orthogonality (0, not 1e-16) and an
exact trace of 35.
"""
import importlib.util as _il, io as _io, contextlib as _cl
from fractions import Fraction as F
def _load(p,nm):
    sp=_il.spec_from_file_location(nm,p); m=_il.module_from_spec(sp)
    with _cl.redirect_stdout(_io.StringIO()): sp.loader.exec_module(m)
    return m
wm=_load("scripts/runs/run_n5_weyl_module.py","wm"); N=5
def flat(v):
    T=wm.sym2_to_R({wm.SPAIRS[i]:v[i] for i in range(len(v)) if v[i]})
    return [T[a][b][c][d] for a in range(N) for b in range(N)
            for c in range(N) for d in range(N)]
def dot(x,y): return sum(a*b for a,b in zip(x,y))
B=[flat(v) for v in wm.BASIS]
out=[]
for v in B:
    w=list(v)
    for u in out:
        c=F(dot(w,u), 1)/dot(u,u)
        w=[a-c*b for a,b in zip(w,u)]
    if any(w): out.append(w)
print(f"exact orthogonal basis: {len(out)} vectors")
maxoff=max(abs(dot(out[i],out[j])) for i in range(len(out)) for j in range(i+1,len(out)))
print(f"  max |<b_i,b_j>| for i != j = {maxoff}   (exact zero, not 1e-16)")
print(f"  all norms rational and nonzero: {all(dot(w,w)>0 for w in out)}")
tr=sum(F(dot(w,w),1)/dot(w,w) for w in out)
print(f"  trace(P) = sum <b,b>/<b,b> = {tr}  exactly, type {type(tr).__name__}")
print(f"  every entry of P = sum b (x) b / <b,b> is a ratio of integers -> P is exact over Q")
print(f"  NOTE this also shows trace(P) is identically the NUMBER of basis vectors:")
print(f"       it cannot see the subspace they span.")
