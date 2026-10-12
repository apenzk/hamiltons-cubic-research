"""r249 / claim 1(a): is wm.BASIS really a basis of Weyl_5?

Checked WITHOUT reusing the module's own reasoning: build the Weyl conditions
directly on (R^5)^{tensor 4} (625 unknowns) -- antisymmetry in ab and in cd, pair
symmetry, first Bianchi, Ricci-trace zero -- get the dimension of that solution
space numerically by rank, and confirm every wm.BASIS tensor satisfies them and
that the 35 of them are independent.
"""
import importlib.util as _il, io as _io, contextlib as _cl
import numpy as np
def _load(p,n):
    sp=_il.spec_from_file_location(n,p); m=_il.module_from_spec(sp)
    with _cl.redirect_stdout(_io.StringIO()): sp.loader.exec_module(m)
    return m
wm=_load("scripts/runs/run_n5_weyl_module.py","wm"); N=5
def t(v):
    T=wm.sym2_to_R({wm.SPAIRS[i]:v[i] for i in range(len(v)) if v[i]})
    return np.array([[[[float(T[a][b][c][d]) for d in range(N)] for c in range(N)]
                      for b in range(N)] for a in range(N)])
B5=[t(v) for v in wm.BASIS]
M=np.stack([b.ravel() for b in B5])
print(f"wm.BASIS: {len(B5)} tensors in R^{M.shape[1]}, numerical rank {np.linalg.matrix_rank(M)}")

# the Weyl conditions as linear rows on the 625 coordinates
rows=[]
def add(fn):
    for a in range(N):
     for b in range(N):
      for c in range(N):
       for d in range(N):
        r=np.zeros((N,)*4); fn(r,a,b,c,d)
        if np.abs(r).max()>0: rows.append(r.ravel())
add(lambda r,a,b,c,d: (r.__setitem__((a,b,c,d), r[a,b,c,d]+1), r.__setitem__((b,a,c,d), r[b,a,c,d]+1)))
add(lambda r,a,b,c,d: (r.__setitem__((a,b,c,d), r[a,b,c,d]+1), r.__setitem__((a,b,d,c), r[a,b,d,c]+1)))
add(lambda r,a,b,c,d: (r.__setitem__((a,b,c,d), r[a,b,c,d]+1), r.__setitem__((c,d,a,b), r[c,d,a,b]-1)))
add(lambda r,a,b,c,d: (r.__setitem__((a,b,c,d), r[a,b,c,d]+1), r.__setitem__((a,c,d,b), r[a,c,d,b]+1),
                       r.__setitem__((a,d,b,c), r[a,d,b,c]+1)))
for i in range(N):
    for j in range(N):
        r=np.zeros((N,)*4)
        for m in range(N): r[i,m,j,m]+=1
        rows.append(r.ravel())
A=np.stack(rows)
rk=np.linalg.matrix_rank(A)
print(f"Weyl-condition system: {A.shape[0]} rows, rank {rk}, solution dim {625-rk}  (dim Weyl_5 = 35)")
res=np.abs(A @ M.T).max()
print(f"max residual of wm.BASIS against those conditions: {res:.2e}")
print("VERDICT 1(a):", "wm.BASIS spans exactly Weyl_5" if (625-rk==35 and np.linalg.matrix_rank(M)==35 and res<1e-9)
      else "PROBLEM")
