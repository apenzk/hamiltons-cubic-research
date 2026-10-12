"""r249 / claims 1(c) and 5: the projector without the 8-index array.

CLOSED FORM.  The file says P "needs no closed form and no guess: it needs a
basis".  A closed form exists and is elementary, which is what n = 12 needs since
wm is hardcoded to N = 5.  As an OPERATOR on 4-tensors, P = D o C o S where

  S  symmetrises into Sym^2(Lambda^2):  T -> ((T_abcd - T_bacd - T_abdc + T_badc)/4)
                                             then averaged with its pair swap;
  C  removes the Lambda^4 part:         R -> R - (1/3)(R_abcd + R_acdb + R_adbc);
  D  removes the traces:                R -> R - (Ric0 KN g)/(n-2) - s (g KN g)/(2n(n-1)),
     with Ric0 = Ric - (s/n) g,  s = tr Ric,  and KN the Kulkarni-Nomizu product.

Each factor is self-adjoint for the Frobenius product and the three ranges are
the orthogonal O(n)-isotypic pieces, so P is the orthogonal projector onto
Weyl_n.  Coefficients in D are forced: Ric(h KN g) = (n-2)h + tr(h) g gives
Ric(P T) = 0 identically.

COST.  O(n^4) per application, no storage.  Against the file's 8-index array at
n = 12: n^8 = 429,981,696 doubles = 3.44 GB, built by 1638 outer products.
"""
import importlib.util as _il, io as _io, contextlib as _cl, time
import numpy as np

def kn(h, k):
    return (np.einsum('ac,bd->abcd', h, k) + np.einsum('bd,ac->abcd', h, k)
            - np.einsum('ad,bc->abcd', h, k) - np.einsum('bc,ad->abcd', h, k))

def weyl_apply(T, n):
    """P T, matrix-free, O(n^4)."""
    g = np.eye(n)
    S = (T - T.transpose(1,0,2,3) - T.transpose(0,1,3,2) + T.transpose(1,0,3,2))/4.0
    S = (S + S.transpose(2,3,0,1))/2.0
    C = S - (S + S.transpose(0,2,3,1) + S.transpose(0,3,1,2))/3.0
    Ric = np.einsum('ambm->ab', C); s = np.trace(Ric); Ric0 = Ric - (s/n)*g
    return C - kn(Ric0, g)/(n-2) - s*kn(g, g)/(2.0*n*(n-1))

def dim_weyl(n): return n*(n+1)*(n+2)*(n-3)//12

def exact_trace(n, block=512):
    """tr(P) = sum_{abcd} (P e_abcd)_{abcd}, in blocks -- never forms n^8."""
    m = n**4; tot = 0.0
    for st in range(0, m, block):
        k = min(block, m-st)
        E = np.zeros((k, m)); E[np.arange(k), np.arange(st, st+k)] = 1.0
        E = E.reshape((k,)+(n,)*4)
        PE = np.stack([weyl_apply(E[i], n) for i in range(k)]).reshape(k, m)
        tot += PE[np.arange(k), np.arange(st, st+k)].sum()
    return tot

# ---- agreement with the file's basis-built P at n = 5 ----
def _load(p, nm):
    sp=_il.spec_from_file_location(nm,p); mo=_il.module_from_spec(sp)
    with _cl.redirect_stdout(_io.StringIO()): sp.loader.exec_module(mo)
    return mo
wm=_load("scripts/runs/run_n5_weyl_module.py","wm")
def t5(v):
    T=wm.sym2_to_R({wm.SPAIRS[i]:v[i] for i in range(len(v)) if v[i]})
    return np.array([[[[float(T[a][b][c][d]) for d in range(5)] for c in range(5)]
                      for b in range(5)] for a in range(5)])
B5=[t5(v) for v in wm.BASIS]
out=[]
for v in B5:
    w=v.copy()
    for u in out: w=w-np.einsum('abcd,abcd->',w,u)*u
    nn=np.sqrt(np.einsum('abcd,abcd->',w,w))
    if nn>1e-9: out.append(w/nn)
Pfile=np.zeros((5,)*8)
for b in out: Pfile+=np.einsum('abcd,efgh->abcdefgh',b,b)
rg=np.random.default_rng(2)
d=max(np.abs(weyl_apply(X,5)-np.einsum('abcdefgh,efgh->abcd',Pfile,X)).max()
      for X in (rg.standard_normal((5,)*4) for _ in range(20)))
print(f"n=5: |closed-form P X - basis-built P X|_max over 20 random X = {d:.2e}")
print(f"n=5: exact trace of the closed form = {exact_trace(5):.6f}   (dim Weyl_5 = {dim_weyl(5)})")

# ---- the properties at n = 12, where wm does not exist ----
for n in (12,):
    g=np.eye(n); rg=np.random.default_rng(4)
    t0=time.time(); X=rg.standard_normal((n,)*4); PX=weyl_apply(X,n); dt=time.time()-t0
    PPX=weyl_apply(PX,n)
    Y=rg.standard_normal((n,)*4); PY=weyl_apply(Y,n)
    sym=abs(np.einsum('abcd,abcd->',PX,Y)-np.einsum('abcd,abcd->',X,PY))
    nrm=np.abs(PX).max()
    print(f"\nn={n}: one application {dt*1000:.1f} ms")
    print(f"  idempotent   |P(PX)-PX|_max/|PX| = {np.abs(PPX-PX).max()/nrm:.2e}")
    print(f"  self-adjoint |<PX,Y>-<X,PY>|    = {sym:.2e}")
    print(f"  Riemann syms antisym={np.abs(PX+PX.transpose(1,0,2,3)).max()/nrm:.1e}"
          f" pairsym={np.abs(PX-PX.transpose(2,3,0,1)).max()/nrm:.1e}"
          f" bianchi={np.abs(PX+PX.transpose(0,2,3,1)+PX.transpose(0,3,1,2)).max()/nrm:.1e}"
          f" ricci={np.abs(np.einsum('ambm->ab',PX)).max()/nrm:.1e}")
    t0=time.time(); tr=exact_trace(n); dt=time.time()-t0
    print(f"  EXACT trace(P) = {tr:.6f}   dim Weyl_{n} = {dim_weyl(n)}   "
          f"(computed in {dt:.1f} s, peak memory O(n^4))")

print(f"\ncost of the file's 8-index route at n=12:")
print(f"  storage n^8 = {12**8:,} doubles = {12**8*8/2**30:.2f} GB")
print(f"  building it: {dim_weyl(12)} outer products, each writing that array")
print(f"  the idempotence check P.P is a {12**4}x{12**4} matmul = "
      f"{2*(12**4)**3/1e12:.1f} Tflop with ~{3*12**8*8/2**30:.1f} GB resident")
print(f"  exact over Q, as the docstring claims: {12**8:,} Fractions, >{12**8*56/2**30:.0f} GB")
