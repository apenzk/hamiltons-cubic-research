"""I67: the owed StarWedgeIdentity, its constant, its sign, and a reduction to the layer's triple6.

The Lean layer carries `StarWedgeIdentity` as an unproved `Prop` and flags star6's normalisation
anchor as "taken from the record and NOT checked in Lean", so the constant and the base sign were
the unverified part.  The record (diagonal-half.md) states the identity as star(J^J) = 2 Pf(J) J.

WHAT THIS SETTLES.
  * the anchor star(e_0123) = e_45 holds EXACTLY, with no other entries;
  * eps_J = Pf(J), and the base sign at the layer's own stdJ6 is -1, since stdJ6 is three blocks
    [[0,-1],[1,0]] and Pf = (-1)^3;
  * both signs occur, one per SO(6) orbit, so eps_J is well defined and genuinely two-valued;
  * the identity reduces to the layer's existing triple6: <star6(J^J), Z> = 12 triple6(Z,J,J),
    because star6 and triple6 share levi6 and antisymmetry makes the three wedge terms equal.
    So StarWedgeIdentity is equivalent to 6 triple6(Z,J,J) = pf6(J) <J,Z> at every Z.

A SAMPLING DEFECT THIS SCREEN CAUGHT IN ITSELF, recorded because it is the interesting part.
A first pass drew R from numpy's QR of a Gaussian and reported Pf(J) = +1 on 200 of 200 draws,
concluding the two orbits were not both reached.  numpy's Householder QR returns det(Q) = -1 on
EVERY draw at n = 6, so the sample was one orbit throughout.  The orbits are forced explicitly
below.  **Random is not uniform, and a control that reports one value is reporting the sampler.**
"""
import itertools, numpy as np

N = 6
lev = np.zeros((N,) * 6)
for p in itertools.permutations(range(N)):
    s, q = 1, list(p)
    for i in range(N):
        for j in range(i + 1, N):
            if q[i] > q[j]: s = -s
    lev[p] = s


def phi(i, j):
    M = np.zeros((N, N)); M[j, i] += 1.0; M[i, j] -= 1.0; return M


stdJ6 = phi(0, 1) + phi(2, 3) + phi(4, 5)
halfw = lambda X, Y: (np.einsum('ab,cd->abcd', X, Y) - np.einsum('ac,bd->abcd', X, Y)
                      + np.einsum('ad,bc->abcd', X, Y))
wedgeSelf = lambda X: 2 * halfw(X, X)
star6 = lambda T: (1 / 24) * np.einsum('abcdef,cdef->ab', lev, T)
triple6 = lambda X, Y, Z: (1 / 48) * np.einsum('abcdef,ab,cd,ef->', lev, X, Y, Z)
pf6 = lambda X: triple6(X, X, X)

print("=" * 76)
print("I67: the owed identity, its constant and its sign")
print("=" * 76)

assert np.allclose(stdJ6 @ stdJ6, -np.eye(N)) and np.allclose(stdJ6.T, -stdJ6)
print("\ncontrol: stdJ6 is skew with J^2 = -I  (asserted)")

T = np.zeros((N,) * 4)
for p in itertools.permutations((0, 1, 2, 3)):
    s, q = 1, list(p)
    for i in range(4):
        for j in range(i + 1, 4):
            if q[i] > q[j]: s = -s
    T[p] = s
A = star6(T)
E45 = np.zeros((N, N)); E45[4, 5] = 1.0; E45[5, 4] = -1.0
assert np.allclose(A, E45, atol=1e-12), "the anchor star(e_0123) = e_45 FAILS"
print("anchor: star6(e_0123) = e_45 EXACTLY, no other entries  (asserted)")

assert abs(pf6(stdJ6) - (-1)) < 1e-12
assert np.allclose(star6(wedgeSelf(stdJ6)), -2 * stdJ6, atol=1e-12)
print(f"base sign: Pf(stdJ6) = {pf6(stdJ6):+.0f}, and star6(J^J) = -2 J there  (asserted)")

print("\n--- both orbits, forced, because numpy's QR gives det = -1 every time ---")
rng = np.random.default_rng(1)
worst_id = worst_red = 0.0
seen = set()
for want in (+1.0, -1.0):
    for _ in range(60):
        R = np.linalg.qr(rng.normal(size=(N, N)))[0]
        if np.sign(np.linalg.det(R)) != want:
            R = R.copy(); R[:, 0] *= -1
        J = R @ stdJ6 @ R.T
        e = pf6(J)
        seen.add(round(e))
        assert abs(e - np.linalg.det(R) * pf6(stdJ6)) < 1e-9
        worst_id = max(worst_id, np.abs(star6(wedgeSelf(J)) - 2 * e * J).max())
        Z = rng.normal(size=(N, N)); Z = Z - Z.T
        lhs = float(np.einsum('ab,ab->', star6(wedgeSelf(J)), Z))
        worst_red = max(worst_red, abs(lhs - 12 * triple6(Z, J, J)))
print(f"  Pf(J) values over both orbits           = {sorted(seen)}")
print(f"  max |star6(J^J) - 2 Pf(J) J|            = {worst_id:.3e}")
print(f"  max |<star6(J^J),Z> - 12 triple6(Z,J,J)| = {worst_red:.3e}")
assert seen == {-1, 1}, "eps_J must take both signs"
assert worst_id < 1e-9 and worst_red < 1e-9
print("\n  eps_J = Pf(J), two-valued, one sign per orbit  (asserted)")
print("  and <star6(J^J),Z> = 12 triple6(Z,J,J) at EVERY skew Z  (asserted)")

print("\n--- the reduction holds at arbitrary skew X, not only complex structures ---")
worst = 0.0
for _ in range(200):
    X = rng.normal(size=(N, N)); X = X - X.T
    Z = rng.normal(size=(N, N)); Z = Z - Z.T
    lhs = float(np.einsum('ab,ab->', star6(wedgeSelf(X)), Z))
    worst = max(worst, abs(lhs - 12 * triple6(Z, X, X)))
print(f"  max residue over 200 random skew pairs = {worst:.3e}")
assert worst < 1e-9
print("\n  SO StarWedgeIdentity IS: 6 triple6(Z,J,J) = pf6(J) <J,Z> at every skew Z,")
print("  a statement about objects the layer already carries with additivity lemmas.")

# ---- THE ADJUGATE LAW, PROVED SYMBOLICALLY (Gate 2: r990, r991) ---------------------
# The record's warrant for this law was 300 random skew samples.  BOTH readers showed that
# insufficient by a counting argument: each entry of X sigma(X) + Pf(X) Id is a homogeneous
# cubic in 15 variables, and those span C(17,3) = 680 dimensions, so 300 points leave a
# >= 380-dimensional space of forms fitting the data.  Proved outright here instead.
import sympy as _sp
print("\n" + "=" * 76)
print("the adjugate law, proved symbolically over the 15 free entries")
print("=" * 76)
_pairs = [(i, j) for i in range(6) for j in range(i + 1, 6)]
_lev = {}
for _p in itertools.permutations(range(6)):
    _s, _q = 1, list(_p)
    for _i in range(6):
        for _j in range(_i + 1, 6):
            if _q[_i] > _q[_j]: _s = -_s
    _lev[_p] = _s
_sy = {p: _sp.Symbol(f"z{p[0]}{p[1]}") for p in _pairs}
_X = _sp.zeros(6, 6)
for (_i, _j), _v in _sy.items():
    _X[_i, _j] = _v; _X[_j, _i] = -_v

def _sig(a, b):
    t = 0
    for c in range(6):
        for d in range(6):
            for e in range(6):
                for f in range(6):
                    s = _lev.get((a, b, c, d, e, f), 0)
                    if s: t += s * 2 * (_X[c,d]*_X[e,f] - _X[c,e]*_X[d,f] + _X[c,f]*_X[d,e])
    return _sp.expand(_sp.Rational(1, 48) * t)

_S = _sp.Matrix(6, 6, lambda a, b: _sig(a, b))
_pf = _sp.expand(_sp.Rational(1, 48) * sum(s * _X[p[0],p[1]]*_X[p[2],p[3]]*_X[p[4],p[5]]
                                           for p, s in _lev.items()))
_bad = [(a, b) for a in range(6) for b in range(6)
        if _sp.simplify(_sp.expand(_X * _S + _pf * _sp.eye(6))[a, b]) != 0]
print(f"\n  entries of X*sigma(X) + Pf(X)*Id not identically zero: {len(_bad)}")
assert not _bad, f"the law FAILS at {_bad[:3]}"
print("  the adjugate law is an IDENTITY over the 15 free entries  (asserted)")
assert _sp.expand(_pf) != 0
assert any(_sp.simplify(_S[a,b]) != 0 for a in range(6) for b in range(6))
_D2 = _sp.expand(_X * _S - _pf * _sp.eye(6))
assert any(_sp.simplify(_D2[a,b]) != 0 for a in range(6) for b in range(6)), \
    "the opposite sign must FAIL, or this check distinguishes nothing"
print("  controls: Pf and sigma are nonzero, and the OPPOSITE sign fails  (asserted)")
print(f"  so 300 samples were never enough: cubics in 15 vars span {_sp.binomial(17,3)} dims.")
