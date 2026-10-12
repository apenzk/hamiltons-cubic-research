import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np, core, points, le

def tau_of(n):
    """tau = sum_k B_k o B_k over an orthonormal basis of Weyl_n."""
    B = core.weyl_basis(n)
    t = np.zeros_like(B[0])
    for k in range(B.shape[0]):
        t += core.circ(n, B[k], B[k])
    return t

def trL_weyl(n, X):
    """tr of the compression of L_X = X o (.) to Weyl_n (no theta division)."""
    B = core.weyl_basis(n); d = B.shape[0]
    Bf = B.reshape(d, -1)
    s = 0.0
    for k in range(d):
        s += float(np.sum(core.circ(n, X, B[k]) * B[k]))
    return s

def closed_weyl(n, tol=1e-10):
    """is Weyl_n closed under o?"""
    B = core.weyl_basis(n)
    rng = np.random.default_rng(0)
    worst = 0.0
    for _ in range(4):
        a = rng.normal(size=B.shape[0]); b = rng.normal(size=B.shape[0])
        X = np.einsum('k,kij->ij', a, B); Y = np.einsum('k,kij->ij', b, B)
        C = core.circ(n, X, Y)
        worst = max(worst, np.linalg.norm(C - core.proj_weyl(n, C)) / np.linalg.norm(C))
    return worst

if __name__ == "__main__":
    for n in (5, 6, 7, 8):
        B = core.weyl_basis(n)
        t = tau_of(n)
        tw = core.proj_weyl(n, t)
        rng = np.random.default_rng(7)
        vals = []
        for _ in range(3):
            co = rng.normal(size=B.shape[0])
            X = np.einsum('k,kij->ij', co, B); X /= np.linalg.norm(X)
            vals.append(trL_weyl(n, X))
        # control: identity of Lambda^2 (constant curvature, NOT Ricci-flat)
        N = B.shape[1]
        Id = np.eye(N) / np.sqrt(N)
        v_id = trL_weyl(n, Id)
        # control: a Ricci-flat but Bianchi-violating symmetric operator
        print(f"n={n} dimW={B.shape[0]} ||tau||={np.linalg.norm(t):.6e} "
              f"||Pi_W tau||={np.linalg.norm(tw):.3e} closed_o={closed_weyl(n):.2e} "
              f"trL(random Weyl)={np.max(np.abs(vals)):.3e} trL(Id_Lambda2)={v_id:+.6f}")
