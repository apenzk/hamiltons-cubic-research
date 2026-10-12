"""r238, claim 4b -- the covariant free-index worry, and whether passing to
complete contractions really dissolves it.

The corollary under review:

    "the covariant free-index worry ... dissolves for soundness: in the identity
     the covariants' free indices are contracted against each other, so the check
     lives among COMPLETE contractions, where the no-free-loop lemma is audited"

r232's audited lemma has an explicit grammar: a degree-d complete-contraction
diagram has exactly 4d index SLOTS, four per Weyl factor, and D is a perfect
matching OF THOSE SLOTS -- "there is no such slot" belonging to no tensor, hence
no free delta-loop, hence no factor of n.

This script asks whether the contraction of two degree-3 COVARIANTS lands in that
grammar.  It does when the covariants are pure-Weyl diagrams.  It does not when a
covariant carries a bare metric factor on its free indices: contracting two such
covariants joins the two metrics into exactly the excluded object, delta^a_a = n.

Exact integer arithmetic throughout; a Weyl tensor built on R^4 and zero-padded,
which r232 verified stays Weyl.
"""
import numpy as np
from fractions import Fraction

F = Fraction

def weyl_project_exact(R, n):
    T = np.transpose
    R = F(1,4) * (R - T(R,(1,0,2,3)) - T(R,(0,1,3,2)) + T(R,(1,0,3,2)))
    R = F(1,2) * (R + T(R,(2,3,0,1)))
    R = R - F(1,3) * (R + T(R,(0,2,3,1)) + T(R,(0,3,1,2)))
    g = np.eye(n, dtype=object) * F(1)
    Ric = np.einsum('ikjk->ij', R); s = np.trace(Ric)
    E = Ric - F(1,n) * s * g
    def KN(A,B):
        return (np.einsum('ik,jl->ijkl',A,B) + np.einsum('jl,ik->ijkl',A,B)
                - np.einsum('il,jk->ijkl',A,B) - np.einsum('jk,il->ijkl',A,B))
    W = R - F(1,n-2)*KN(E,g) - F(1, 2*n*(n-1))*s*KN(g,g)
    return F(1,2) * (W + T(W,(2,3,0,1)))

rng = np.random.default_rng(11)
A0 = np.vectorize(F)(rng.integers(-3, 4, size=(4,4,4,4)).astype(object))
W4 = weyl_project_exact(A0, 4)
# confirm it is a Weyl tensor
assert np.all(W4 == -np.transpose(W4,(1,0,2,3)))
assert np.all(W4 == np.transpose(W4,(2,3,0,1)))
assert np.all(W4 + np.transpose(W4,(0,2,3,1)) + np.transpose(W4,(0,3,1,2)) == 0)
assert np.all(np.einsum('ikjk->ij', W4) == 0)
print("built an exact integer Weyl tensor on R^4 (antisym, pair-sym, Bianchi, trace-free)")

def pad(W, n):
    out = np.zeros((n,n,n,n), dtype=object); out[:] = F(0)
    out[:4,:4,:4,:4] = W
    return out

def gmet(n):
    return np.eye(n, dtype=object) * F(1)

# ---- degree-3 covariants with two free indices --------------------------------
def P(W):   # pure Weyl:  3 factors, 12 slots, 10 matched, 2 free
    return np.einsum('aijk,bilm,jklm->ab', W, W, W)
def Q(W):   # a second pure-Weyl one
    return np.einsum('aijk,jklm,bilm->ab', W, W, W)
def I3(W):  # the cubic invariant
    return np.einsum('ijkl,klmn,mnij->', W, W, W)
def M(W, n):  # carries a BARE METRIC on its free indices: g_ab * I3(W)
    return gmet(n) * I3(W)

NS = (4, 5, 6, 7, 8, 10, 12)
rows = []
for n in NS:
    W = pad(W4, n)
    p, q, m = P(W), Q(W), M(W, n)
    rows.append((n,
                 np.einsum('ab,ab->', p, q),      # pure  x  pure
                 np.einsum('ab,ab->', p, m),      # pure  x  metric-carrying
                 np.einsum('ab,ab->', m, m)))     # metric x metric
print()
print("  n   <P,Q>  (pure x pure)        <P,M>  (pure x metric)      <M,M>  (metric x metric)")
for n, a, b, c in rows:
    print("  %-3d %-28s %-28s %s" % (n, a, b, c))

pp = {r[1] for r in rows}; pm = {r[2] for r in rows}; mm = {r[3] for r in rows}
print()
print("  <P,Q> constant in n : %s   (%d distinct value(s))" % (len(pp) == 1, len(pp)))
print("  <P,M> constant in n : %s   (%d distinct value(s))" % (len(pm) == 1, len(pm)))
print("  <M,M> constant in n : %s   (%d distinct value(s))" % (len(mm) == 1, len(mm)))
i3 = I3(pad(W4, 4))
print()
print("  and <M,M> is exactly  n * I3^2  with I3 = %s :" % i3)
for n, _, _, c in rows:
    assert c == n * i3 * i3, (n, c)
print("     verified at every n in %s -- the value is LINEAR IN n." % (NS,))
print()
print("CONCLUSION.  Contracting the free indices does land the check among complete")
print("contractions -- but not among the ones r232 audited.  r232's grammar has every")
print("one of the 4d slots on a Weyl factor, which is why no delta-loop can form.  A")
print("bare metric on a covariant's free indices is a delta whose endpoints belong to")
print("no tensor, and pairing two of them closes the loop:  g_ab g_ab = delta^a_a = n.")
print("The free-index worry is not dissolved by the passage to complete contractions;")
print("it is RELOCATED into the pairing, and that is exactly where plan.md's A2 says")
print("it lives -- 'every Gram entry of two diagram covariants is a closed Brauer")
print("diagram, VALUED A POLYNOMIAL IN N'.  Those two sentences cannot both describe")
print("the same objects.")
