"""The cone criterion off the R_ric0 = 0 slice: exactly ONE new term survives.

b_cone_bridge.py showed that on the slice R_ric0 = 0 the a = 0 invariance criterion is
exactly Conjecture A, theta <= theta_0(n).  This script does the general case
R = cI + Y + W with Y = R_ric0, and isolates what stands between the two.

The block structure of Q is Xu 2024 Proposition 2.7 (published; it also supplies the
symmetry of the trilinear map tri, used below):
    (1) Q(<I>,   <I>)     in <I>
    (2) Q(<I>,   <Ric0>)  in <Ric0>
    (3) Q(<I>,   <W>)     = 0
    (4) Q(<W>,   <W>)     in <W>
    (5) Q(<Ric0>,<W>)     in <Ric0>
and BW08 Lemma 2.2 supplies the one block Xu's list omits, the Weyl part of Q on <Ric0>:
    (Phi(Y))_W = (1/(n-2)) (Ric0 ^ Ric0)_W ,     Ric0 = ric(Y).

AGREEMENT, found after deriving: the resulting five-term expansion is Xu 2024 Lemma 2.8
eq. (2.34), term for term, including the 3/(n-2) coefficient -- which was reached here
from BW08 Lemma 2.2 rather than copied.  Xu attributes it to Huisken's proof of his
Theorem 3.3, where it is not an independent lemma.  This script is therefore a second
route to a published identity; what is not in Xu is the parity argument in STEP 4.

Run: python3 scripts/route-b/b_cone_offslice.py
"""
import sys, os
sys.path.insert(0, os.path.join(os.getcwd(), 'scripts'))
import sympy as sp
from itertools import product

# T(A,B,C) = <A, Phi(B,C)> is fully symmetric (BW08 eq. (5)).  Encode which blocks Phi
# lands in, then read off which triples pair nonzero against which block.
BLOCKS = ('I', 'Y', 'W')                      # <I>, <Ric0>, <W>
PHI = {                                       # Phi(B,C) -> set of blocks it can occupy
    frozenset(('I', 'I')): {'I'},             # Xu (1)
    frozenset(('I', 'Y')): {'Y'},             # Xu (2)
    frozenset(('I', 'W')): set(),             # Xu (3)  -- vanishes identically
    frozenset(('W', 'W')): {'W'},             # Xu (4)
    frozenset(('Y', 'W')): {'Y'},             # Xu (5)
    frozenset(('Y', 'Y')): {'I', 'Y', 'W'},   # BW08 Lemma 2.2 -- hits ALL THREE
}

def survives(a, b, c):
    """T(a,b,c) = <a, Phi(b,c)> can be nonzero only if block a meets Phi(b,c)'s blocks."""
    return a in PHI[frozenset((b, c))]

def main():
    print("STEP 1  which of the ten distinct triples survive")
    kept, killed = [], []
    seen = set()
    for t in product(BLOCKS, repeat=3):
        key = tuple(sorted(t))
        if key in seen:
            continue
        seen.add(key)
        # full symmetry: nonzero if ANY ordering pairs nonzero
        ok = any(survives(x, y, z) for x, y, z in set(product(t, repeat=3)) if sorted((x,y,z)) == list(key))
        ok = any(survives(p[0], p[1], p[2]) for p in {(key[i], key[j], key[k])
                 for i, j, k in product(range(3), repeat=3) if sorted((i,j,k)) == [0,1,2]})
        mult = {1: 1, 2: 3, 3: 6}[len(set(key))] if len(set(key)) != 2 else 3
        mult = 1 if len(set(key)) == 1 else (3 if len(set(key)) == 2 else 6)
        (kept if ok else killed).append((key, mult, ok))
    for key, mult, _ in kept:
        print(f"    {str(key):20s} multiplicity {mult}   SURVIVES")
    for key, mult, _ in killed:
        print(f"    {str(key):20s} multiplicity {mult}   vanishes")

    print("\nSTEP 2  the cubic form off the slice")
    print("    <R, Phi(R)> = c^3 (n-1) ||I||^2          [ (I,I,I) ]")
    print("                + 3c <I, Phi(Y)>             [ (I,Y,Y) ]")
    print("                +    <Y, Phi(Y)>             [ (Y,Y,Y) ]")
    print("                + 3  <W, Phi(Y)>             [ (Y,Y,W) ]  <-- THE NEW TERM")
    print("                +    <W, Q(W)>               [ (W,W,W) ]")
    print("    Compared with the slice, ONE genuinely new coupling appears, and it is")
    print("    (Y,Y,W): the Weyl part of Phi(Y) pairing against W.")

    print("\nSTEP 3  what that term is, by BW08 Lemma 2.2")
    n = sp.Symbol('n', positive=True)
    print(f"    3 <W, Phi(Y)> = 3 <W, (Phi(Y))_W> = {3/(n-2)} * <W, Ric0 ^ Ric0>,   Ric0 = ric(Y)")
    print("\nSTEP 4  parity in W, on BOTH sides")
    print("    LHS: (I,I,I), (I,Y,Y), (Y,Y,Y) are W-EVEN;  (Y,Y,W) and (W,W,W) are W-ODD.")
    print("    RHS = F(R) <ric R, ric Phi(R)>:")
    print("      ric(R)  = ric(cI) + ric(Y)          W-independent (Weyl carries no ric)")
    print("      ||R||^2 = c^2||I||^2+||Y||^2+||W||^2   W-EVEN, so F(R) is W-even")
    print("      ric(Phi(R)): the only W-dependent contribution is 2 Phi(Y,W), which by")
    print("      Xu (5) lands in <Ric0> and is W-ODD;  Phi(W,W) is in <W> and has no ric.")
    print("    So each side splits as even + odd, and W -> -W flips exactly the odd parts.")
    print("    Requiring the criterion at BOTH signs of W gives")
    print("        | LHS_odd - RHS_odd |  <=  RHS_even - LHS_even,")
    print("    with  LHS_odd = 3<W, Phi(Y)> + <W, Q(W)>")
    print("          RHS_odd = 2 F(R) <ric R, ric Phi(Y,W)>.")

    print("\nCONCLUSION.  Off the slice the a = 0 criterion is NOT Conjecture A alone.  What")
    print("it bounds is a COMBINATION -- <W, Q(W)> appears only inside LHS_odd, alongside the")
    print("single new coupling 3/(n-2) <W, Ric0 ^ Ric0> and against RHS_odd.  Setting Y = 0")
    print("kills both extra terms and recovers the bridge exactly, which is the consistency")
    print("check.  Bounding LHS_odd - RHS_odd against the constraint is what a general")
    print("R_ric0 proof still owes; Conjecture A supplies one of its three pieces.")

if __name__ == '__main__':
    main()
