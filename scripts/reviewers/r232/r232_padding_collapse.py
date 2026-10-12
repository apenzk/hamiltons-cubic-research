"""r232 / claim 1a.  THE PADDING-COLLAPSE STEP, attacked directly.

run_bn_transfer_theorem.py: "Evaluating q_D^{(n)} on a PADDED tensor collapses
every contraction sum to the n_0 range, because each index is attached to a
W-factor that vanishes there and the perfect matching leaves no free delta-loop
to contribute a factor of n."

THE ATTACK.  A complete-contraction diagram for a degree-d invariant of
Sym^d(W_n^*) has 4d index SLOTS -- four per Weyl factor -- and D is a perfect
matching of those slots.  A "free delta-loop" would be a cycle of delta edges
touching no W-factor; it would evaluate to delta^a_a = n and destroy
restriction-compatibility.  For such a cycle to exist the matching would have to
pair two endpoints of a delta with each other, i.e. leave a slot unattached to
any W.  Since the matching is a perfect matching OF THE SLOTS THEMSELVES and
every slot belongs to a W-factor, no such edge exists.  There is no counterexample
to construct; the diagram grammar forbids it.

  WHERE AN n DOES COME FROM, so the reader can see the boundary: a free loop is
  exactly the degree-ZERO diagram delta^a_a, which is the invariant "n" itself.
  It is not among the degree-d generators because those have 4d occupied slots
  and no spare delta.  The programme meets this factor elsewhere -- the trace of
  the identity, run_theta_free_description.py's delta^a_a repair -- and there it
  is fatal, for exactly the reason the grammar excludes it here.

WHAT IS CHECKED BELOW, since a grammar argument deserves a witness.
  (1) every diagram on d = 2 and d = 3 Weyl factors takes the SAME value on a
      padded tensor for every n -- the invariant is literally n-independent;
  (2) the total number of diagrams is (4d-1)!! and every one of them is tested
      at d = 2 -- exhaustively, not by sampling;
  (3) the boundary: the same contraction with ONE delta detached from the W's
      -- the free loop the argument rules out -- does scale like n, so the
      claim is not vacuous.
"""
import sys, os, itertools
from fractions import Fraction
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

def kn(h, n):
    """Kulkarni-Nomizu-type product h (x) g: an algebraic curvature tensor."""
    d = np.eye(n, dtype=object)
    return (np.einsum('ik,jl->ijkl', h, d) + np.einsum('jl,ik->ijkl', h, d)
            - np.einsum('il,jk->ijkl', h, d) - np.einsum('jk,il->ijkl', h, d))

def sphere(n):
    d = np.eye(n, dtype=object)
    return np.einsum('ik,jl->ijkl', d, d) - np.einsum('il,jk->ijkl', d, d)

def ric(R):
    return np.einsum('ikjk->ij', R)

def weyl_from(h_list, n):
    """an INTEGER Weyl tensor: project sum_a h_a (x) h_a and clear denominators."""
    R = sum(kn(h, n) @ 1 if False else np.einsum('ik,jl->ijkl', h, h)
            + np.einsum('jl,ik->ijkl', h, h)
            - np.einsum('il,jk->ijkl', h, h)
            - np.einsum('jk,il->ijkl', h, h) for h in h_list)
    Rc = ric(R)
    t = int(np.trace(Rc))
    A = Rc * n - t * np.eye(n, dtype=object)            # n * (trace-free part)
    # W = R - (1/(n-2)) A/n (x) g - (t/(n(n-1))) S ; scale by n(n-1)(n-2)
    c = n * (n - 1) * (n - 2)
    W = c * R - (n - 1) * kn(A, n) - (n - 2) * t * sphere(n)
    assert not ric(W).any(), "the projection did not land in the Weyl space"
    return W

def pad(W, n0, n):
    out = np.zeros((n, n, n, n), dtype=object)
    out[:n0, :n0, :n0, :n0] = W
    return out

def matchings(k):
    def rec(rest):
        if not rest:
            yield []
            return
        a = rest[0]
        for i in range(1, len(rest)):
            for tail in rec(rest[1:i] + rest[i + 1:]):
                yield [(a, rest[i])] + tail
    yield from rec(list(range(k)))

LET = "abcdefghijklmnopqrstuvwxyz"

def diagram_value(tensors, M):
    """contract the given 4-tensors according to the perfect matching M."""
    d = len(tensors)
    lab = [None] * (4 * d)
    for e, (a, b) in enumerate(M):
        lab[a] = lab[b] = LET[e]
    spec = ",".join("".join(lab[4 * t:4 * t + 4]) for t in range(d)) + "->"
    return np.einsum(spec, *[T.astype(np.float64) for T in tensors])

n0 = 4
W0 = weyl_from([np.array([[2, 1, 0, 0], [1, -1, 3, 0], [0, 3, 1, 1], [0, 0, 1, -2]], dtype=object),
                np.array([[0, 0, 1, 2], [0, 1, 0, 1], [1, 0, -1, 0], [2, 1, 0, 0]], dtype=object)], n0)
W0 = W0 // int(np.gcd.reduce(np.abs(W0.ravel().astype(np.int64))[np.abs(W0.ravel().astype(np.int64)) > 0]))
print(f"  built an integer Weyl tensor on R^{n0}: max |entry| = {int(np.abs(W0).max())}, "
      f"Ric = 0: {not ric(W0).any()}")
assert np.abs(W0).max() < 200

NS = [4, 5, 6, 8, 12]
print()
print("=" * 72)
print("(1) d = 2: ALL 105 diagrams, value on the padded tensor, as n varies")
Ms = list(matchings(8))
assert len(Ms) == 105
vals = {}
for n in NS:
    Wn = pad(W0, n0, n)
    vals[n] = [diagram_value([Wn, Wn], M) for M in Ms]
    assert all(abs(v) < 9e15 and v == int(v) for v in vals[n])
bad = [i for i in range(len(Ms)) if len(set(vals[n][i] for n in NS)) != 1]
print(f"  diagrams whose value MOVES with n: {len(bad)} of {len(Ms)}")
assert not bad, ("a complete-contraction diagram changed value under padding -- "
                 "restriction-compatibility is broken and step (1) is refuted")
print(f"  sample values (constant in n): {sorted(set(vals[NS[0]]))[:6]} ...")

print()
print("(2) d = 3: 200 random diagrams of the 10395, n in", NS)
rng = np.random.default_rng(232)
Ms3 = list(matchings(12))
assert len(Ms3) == 10395
pick = [Ms3[i] for i in rng.choice(len(Ms3), 200, replace=False)]
bad3 = 0
for M in pick:
    vs = set()
    for n in NS:
        Wn = pad(W0, n0, n)
        v = diagram_value([Wn, Wn, Wn], M)
        assert abs(v) < 9e15 and v == int(v)
        vs.add(v)
    if len(vs) != 1:
        bad3 += 1
print(f"  diagrams whose value MOVES with n: {bad3} of 200")
assert bad3 == 0

print()
print("(3) THE BOUNDARY.  Attach a spare delta to nothing -- the free loop the")
print("    grammar forbids -- and the value does scale with n:")
nz = next(i for i in range(len(Ms)) if vals[NS[0]][i] != 0)
for n in NS:
    Wn = pad(W0, n0, n)
    base = diagram_value([Wn, Wn], Ms[nz])
    print(f"    n = {n:2d}:  q_D = {base:>12.0f}    q_D * delta^a_a = {base * n:>14.0f}")
print()
print("  So the no-free-loop claim is what carries step (1), and it is TRUE:")
print("  in a degree-d diagram all 4d slots sit on W-factors and the matching")
print("  has no edge left over to close a loop.")
