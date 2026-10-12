"""r249 / claim 1(b): can float Gram-Schmidt drift off Weyl_n while KEEPING all
four asserted properties?

Answer, established by scan rather than assertion: NO, not by roundoff alone.
Classical Gram-Schmidt's error modes are coupled -- the same ill-conditioning
that pushes the output off span(input) destroys orthogonality by the same order,
and lost orthogonality shows up in |P.P - P|.  So the four checks do bound the
NUMERICAL fidelity of P to the span of whatever basis it was given.

What they do not bound is the span itself.  GS output lies in span(input) to
O(eps*kappa); if the input is not a basis of Weyl_n, every check still passes
(claim 2, witness C).  The file's range therefore rests entirely on wm.BASIS,
which this file never checks.
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
def orthonormalise(B):                        # verbatim from run_weyl_projector.py
    out=[]
    for v in B:
        w=v.copy()
        for u in out: w=w-np.einsum('abcd,abcd->',w,u)*u
        nrm=np.sqrt(np.einsum('abcd,abcd->',w,w))
        if nrm>1e-9: out.append(w/nrm)
    return out
def proj(B):
    P=np.zeros((N,)*8)
    for b in B: P+=np.einsum('abcd,efgh->abcdefgh',b,b)
    return P
def metrics(ON):
    P=proj(ON)
    PP=np.einsum('abcdefgh,efghijkl->abcdijkl',P,P)
    rg=np.random.default_rng(1); w=sum(rg.standard_normal()*b for b in ON)
    return dict(k=len(ON), idem=np.abs(PP-P).max(),
                sym=np.abs(P-P.transpose(4,5,6,7,0,1,2,3)).max(),
                tr=np.einsum('abcdabcd->',P),
                fix=np.abs(np.einsum('abcdefgh,efgh->abcd',P,w)-w).max(), P=P)

B5=[t(v) for v in wm.BASIS]
Q,_=np.linalg.qr(np.stack([b.ravel() for b in B5]).T)
off=lambda x:(lambda v: np.linalg.norm(v-Q@(Q.T@v))/max(np.linalg.norm(v),1e-30))(x.ravel())

ON=orthonormalise(B5); m=metrics(ON)
print("(i) the shipped input (exact rational basis, rounded to float):")
print(f"    Gram cond = {np.linalg.cond(np.stack([b.ravel() for b in B5])@np.stack([b.ravel() for b in B5]).T):.2e}"
      f"   max off-Weyl = {max(off(b) for b in ON):.2e}   idem = {m['idem']:.1e}"
      f"   trace = {m['tr']:.6f}")
print("    -> the shipped n=5 run is numerically sound.\n")

print("(ii) scan: inputs of increasing ill-conditioning, all lying in Weyl_5.")
print("     Does any regime give a big off-Weyl drift with a passing idempotence?")
print(f"     {'kappa(input)':>13} {'#accepted':>9} {'maxoffWeyl':>11} {'idem':>10} {'sym':>8} {'trace':>10} {'fix':>10} {'checks':>8}")
rg=np.random.default_rng(5)
combo=sum(rg.standard_normal()*b for b in B5[:34])
worst=None
for e in range(0,17):
    delta=10.0**(-e)
    inp=[b.copy() for b in B5[:34]]+[combo+delta*B5[34]]
    Wm=np.stack([x.ravel() for x in inp])
    kap=np.linalg.cond(Wm)
    O2=orthonormalise(inp)
    if len(O2)==0: continue
    m2=metrics(O2); mo=max(off(b) for b in O2)
    ok=(m2['k']==35 and m2['idem']<1e-9 and m2['sym']<1e-9
        and abs(m2['tr']-35)<1e-9 and m2['fix']<1e-9)
    print(f"     {kap:13.2e} {m2['k']:9d} {mo:11.2e} {m2['idem']:10.1e} {m2['sym']:8.1e}"
          f" {m2['tr']:10.6f} {m2['fix']:10.1e} {'PASS' if ok else 'fail':>8}")
    if ok and mo>1e-8: worst=(kap,mo)
print("\n     regimes passing all four checks while drifting off Weyl_5 by >1e-8:",
      worst if worst else "NONE FOUND")
print("     -> roundoff drift and loss of orthogonality scale together; the checks")
print("        catch the drift.  The span of the INPUT is what they cannot see.")
