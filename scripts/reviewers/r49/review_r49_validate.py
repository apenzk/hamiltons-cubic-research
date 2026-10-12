"""Reviewer 49 phase P1: validate the independent machinery."""
import sys, time
import numpy as np
sys.path.insert(0, 'scripts/lib')
import review_r49_core as C

np.set_printoptions(precision=12, suppress=True)


def main():
    print("=== dim Weyl_n vs n(n+1)(n+2)(n-3)/12 ===", flush=True)
    for n in range(4, 13):
        t = time.time()
        d = C.weyl_basis(n).shape[0]
        print(f"  n={n:2d}  measured {d:5d}  formula {C.dim_weyl(n):5d}  "
              f"{'OK' if d == C.dim_weyl(n) else 'MISMATCH'}  ({time.time()-t:.1f}s)", flush=True)

    print("\n=== structure constants: total antisymmetry, Jacobi ===", flush=True)
    for n in (4, 5, 6):
        c = C.struct(n)
        a1 = np.abs(c + c.transpose(1, 0, 2)).max()
        a2 = np.abs(c + c.transpose(0, 2, 1)).max()
        a3 = np.abs(c - c.transpose(1, 2, 0)).max()
        print(f"  n={n}: antisym(ab)={a1:.1e} antisym(bg)={a2:.1e} cyclic={a3:.1e}", flush=True)

    print("\n=== Q preserves Weyl_n; trilinear symmetry; tr(L_x)=0 ===", flush=True)
    rng = np.random.default_rng(4949)
    for n in (4, 5, 6, 7, 8):
        B = C.weyl_basis(n)
        d = B.shape[0]
        X = np.einsum('k,kij->ij', rng.standard_normal(d), B)
        Y = np.einsum('k,kij->ij', rng.standard_normal(d), B)
        Z = np.einsum('k,kij->ij', rng.standard_normal(d), B)
        QX = C.Qmap(n, X)
        leak = np.linalg.norm(QX - C.project_weyl(n, QX)) / np.linalg.norm(QX)
        t1 = C.fro(C.circ(n, X, Y), Z)
        t2 = C.fro(C.circ(n, Y, Z), X)
        t3 = C.fro(C.circ(n, X, Z), Y)
        Lx = C.L_op(n, X)
        print(f"  n={n}: dim={d:4d}  Q leaves Weyl by {leak:.1e}  "
              f"trilinear spread {max(abs(t1-t2), abs(t2-t3)):.1e}  "
              f"tr(L_x)={np.trace(Lx):.2e}  L sym {np.abs(Lx-Lx.T).max():.1e}", flush=True)

    print("\n=== known critical points: theta, residual, L_e W = W ===", flush=True)
    cases = [("S^3xS^3  n=6", 6, C.sphere_product((3, 3))),
             ("S^2xS^4  n=6", 6, C.sphere_product((2, 4))),
             ("S^4xS^4  n=8", 8, C.sphere_product((4, 4))),
             ("S^6xS^6  n=12", 12, C.sphere_product((6, 6))),
             ("W_CP2    n=4", 4, C.fox_cp2(4)),
             ("W_CP2 pad n=8", 8, C.embed(C.fox_cp2(4), 4, 8, (0, 1, 2, 3)))]
    for lbl, n, W in cases:
        W = C.normalize(W)
        ric = np.abs(C.ricci(n, W)).max()
        bia = np.abs(C.bianchi(n, W)).max() if n >= 4 else 0.0
        res, th = C.crit_residual(n, W)
        th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
        e = W / th
        lew = np.linalg.norm(C.circ(n, e, W) - W)
        print(f"  {lbl:14s} theta={th:.12f}  theta_0={th0:.9f}  resid={res:.2e}  "
              f"|Ric|={ric:.1e} |Bianchi|={bia:.1e}  |L_e W - W|={lew:.2e}", flush=True)

    print("\n  sqrt(3/2) =", np.sqrt(1.5), "  sqrt(3)/2 =", np.sqrt(3) / 2, flush=True)


if __name__ == "__main__":
    main()
