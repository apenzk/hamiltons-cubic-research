"""r208, claim 5: does the fitted A(x_a^2) actually PREDICT held-out points?

The whole rank measurement rests on the identity  integral x(hv)^2 dh = A(x^2)(v)
and on A(x^2) lying in the 14-dimensional invariant span.  Fit each A(x_a^2) to
the 14 sextics using only some of the sampled points, then predict the rest.  A
small held-out error says the sampled column really is an invariant sextic and
the pipeline is sound; a large one would say the object being fitted is not in
the span, and the rank would mean nothing.
"""
import sys, os, numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib208 as L, sextics as SX

BAS = SX.load_basis(); NV = 25
path, seed = sys.argv[1], int(sys.argv[2])
rng = np.random.default_rng(seed)
_ = rng.standard_normal((30, 35)); _ = rng.standard_normal((40, 35))
V = rng.standard_normal((NV, 35)); V /= np.linalg.norm(V, axis=1, keepdims=True)
V[0] = L.w0
PHI = np.array([[SX.evaluate(m, SX.tensor(V[p])).real for m in BAS] for p in range(NV)])
E = np.load(path)

tr = list(range(0, 19)); te = list(range(19, 25))
al = np.linalg.lstsq(PHI[tr], E[:, tr].T, rcond=None)[0]
pred = (PHI[te] @ al).T
err = np.abs(pred - E[:, te])/np.abs(E[:, te]).mean()
print(f"fit on {len(tr)} points, predict {len(te)} held out:")
print(f"  mean relative error {err.mean():.3e}, max {err.max():.3e}")
print(f"  for scale, the spread of E across points is "
      f"{E[:,1:].std()/np.abs(E[:,1:]).mean():.3f} of its mean")
# control: fit a NON-invariant sextic the same way and it must fail
ctrl = np.array([[float(np.einsum('i,i->', V[p], V[p])**0*(V[p][0]**6)) for p in range(NV)]])
alc = np.linalg.lstsq(PHI[tr], ctrl[:, tr].T, rcond=None)[0]
pc = (PHI[te] @ alc).T
print(f"\ncontrol -- a NON-invariant sextic (v_1^6) fitted the same way:")
print(f"  held-out mean relative error "
      f"{(np.abs(pc-ctrl[:,te])/np.abs(ctrl[:,te]).mean()).mean():.3e}   (must be O(1))")
