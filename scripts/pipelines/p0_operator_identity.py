"""
Is M_{W1} . Pi_ker Q(W1) = 0 an operator identity with a structural cause?

Route A now has one gap: five vanishings hold at n = 12, 14, 16 but are verified
rather than proven.  Four candidate proofs have died on the SCALAR ones -- the
isotropy circle, a Z_2 grading, the Casimir contraction, and the SO(n)-invariance
identity (which proves a sixth statement, inert here).

The newest vanishing has a different shape.  It is not a scalar coincidence but
an OPERATOR identity: for every W_1 in V_{1/3},

    b = Pi_ker Q(W_1)  is orthogonal to the TOP EIGENSPACE of
    M_{W1} : ker -> ker,  K -> Pi_ker( W_1 o K ),

which is what makes the inner trust-region problem hard-case and hence globally
solvable.  An operator identity has more structure to attack than a scalar one,
and three things are worth separating before any proof is attempted:

  1. WHERE Q(W_1) SITS.  Is Pi_ker Q(W_1) a distinguished vector -- for instance
     proportional to a fixed element of ker F_u independent of W_1, or lying in a
     single isotypic piece of the stabiliser?  If it is confined to one piece,
     the identity reduces to a statement about that piece.

  2. WHETHER M_{W1} ANNIHILATES MORE.  Is Pi_ker Q(W_1) in the kernel of M_{W1}
     alone, or is the kernel large and this vector unremarkable inside it?  The
     kernel dimension against the ambient dimension says which.

  3. WHETHER u IS NEEDED.  The SO(n)-invariance identity turned out not to use
     criticality of u at all.  Testing this one at a non-critical base point
     separates what follows from the eigenspace structure from what follows from
     u being a critical point.

Answering these decides which proof to attempt rather than attempting one blind.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from run_unconstrained_search import build_weyl_basis
from p0_tubular_hessian import fox_point, F_matrix

SQ32 = np.sqrt(1.5)


def run(n, trials=24, seed=3):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    u, th, _ = fox_point(n, L2, Eflat, c)
    Nl = u.shape[0]
    M = F_matrix(u, c, Eflat)
    w, V = np.linalg.eigh(M)
    r = w / SQ32
    V13 = V[:, np.abs(r - 1 / 3) < 1e-7]
    Vker = V[:, np.abs(r) < 1e-7]
    k13, kk = V13.shape[1], Vker.shape[1]
    rng = np.random.default_rng(seed)

    def mk(B, y):
        X = (Eflat.T @ (B @ y)).reshape(Nl, Nl)
        X = 0.5 * (X + X.T)
        return X / max(np.linalg.norm(X), 1e-300)

    print(f"n={n:3d}  dim V_1/3={k13}  dim ker={kk}")
    qs, kerdims, resid, tops, lams = [], [], [], [], []
    for _ in range(trials):
        y = rng.normal(size=k13); y /= np.linalg.norm(y)
        W1 = mk(V13, y)
        q = Vker.T @ (Eflat @ Q_full(W1, c).reshape(-1))        # Pi_ker Q(W1)
        qs.append(q / max(np.linalg.norm(q), 1e-300))
        # the TRS in K has quadratic form K -> Pi_ker(W1 o K), a map ker -> ker,
        # and the hard case is b orthogonal to its TOP eigenspace
        Mw = np.empty((kk, kk))
        for i in range(kk):
            K = (Eflat.T @ Vker[:, i]).reshape(Nl, Nl)
            K = 0.5 * (K + K.T)
            col = (Q_full(W1 + K, c) - Q_full(W1 - K, c)) / 4.0
            Mw[:, i] = Vker.T @ (Eflat @ col.reshape(-1))
        Mw = 0.5 * (Mw + Mw.T)
        ev, U = np.linalg.eigh(Mw)
        top = U[:, np.abs(ev - ev[-1]) < 1e-9 * max(abs(ev[-1]), 1e-300)]
        resid.append(np.linalg.norm(top.T @ q) / max(np.linalg.norm(q), 1e-300))
        kerdims.append(top.shape[1])
        tops.append(top)
        lams.append(ev[-1])
    qs = np.array(qs)
    print(f"      |<b, top eigenspace>| / |b| : max {max(resid):.3e}"
          f"   -> {'HARD CASE holds' if max(resid) < 1e-9 else 'not the hard case'}")
    print(f"      dim of the top eigenspace = {kerdims}  out of {kk}")
    G = np.abs(qs @ qs.T)
    off = G[~np.eye(len(qs), dtype=bool)]
    print(f"      |cos| between Pi_ker Q(W1) for different W1: min {off.min():.4f} max {off.max():.4f}"
          f"   -> {'a FIXED direction' if off.min() > 0.999 else 'varies with W1'}")
    # is the top eigenspace FIXED, or does it move with W_1?
    prin = []
    for i in range(len(tops)):
        for j in range(i + 1, len(tops)):
            sv = np.linalg.svd(tops[i].T @ tops[j], compute_uv=False)
            prin.append(sv.min())
    print(f"      top eigenvalue = {np.array(lams).round(6)}")
    print(f"      min principal cosine between top eigenspaces for different W_1:"
          f" {min(prin):.6f}"
          f"   -> {'a FIXED 2-plane' if min(prin) > 0.999 else 'the 2-plane MOVES with W_1'}")
    # does the fixed-plane reading hold: is every b orthogonal to every other top plane?
    cross = max(np.linalg.norm(tops[j].T @ qs[i]) for i in range(len(qs)) for j in range(len(tops)))
    print(f"      max |<b_i, top_j>| over ALL pairs: {cross:.3e}"
          f"   -> {'b avoids EVERY top plane' if cross < 1e-9 else 'b avoids only its own'}")
    # the planes move, but every b avoids every plane -- so span(tops) is a FIXED
    # subspace of ker F_u orthogonal to Pi_ker Q(V_{1/3}).  Measure both spans.
    Tall = np.hstack(tops)
    svT = np.linalg.svd(Tall, compute_uv=False)
    dT = int(np.sum(svT > 1e-8 * svT[0]))
    Ball = np.array(qs).T
    svB = np.linalg.svd(Ball, compute_uv=False)
    dB = int(np.sum(svB > 1e-8 * svB[0]))
    UT = np.linalg.svd(Tall, full_matrices=False)[0][:, :dT]
    UB = np.linalg.svd(Ball, full_matrices=False)[0][:, :dB]
    print(f"      dim span(top planes) = {dT} from {len(tops)} samples"
          f"   dim span(b) = {dB}   ambient ker = {kk}")
    print(f"      max |<span(b), span(tops)>| = {np.abs(UB.T @ UT).max():.3e}"
          f"   -> {'the two spans are ORTHOGONAL' if np.abs(UB.T @ UT).max() < 1e-9 else 'they overlap'}")
    print(flush=True)


if __name__ == "__main__":
    for n in (10, 12):
        run(n)
