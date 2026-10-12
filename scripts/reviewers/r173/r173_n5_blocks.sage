"""Reviewer 173 -- independent n = 5 block list for Sym^3(Weyl_5), and the parity question.

RUN:  sage scripts/reviewers/r173/r173_n5_blocks.sage   (seconds)

Weyl_5 = O(5)-irreducible [2,2], which as a B2 = so(5) highest weight is 2e1+2e2 = 4*omega_2.
n is odd, so O(5) = SO(5) x {+-I} and -I acts trivially on Weyl_5 (four tensor indices),
hence trivially on Sym^3.  Therefore each SO(5)-constituent with label mu lifts to EXACTLY
ONE O(5)-irreducible: [mu] when |mu| is even, [mu] tensor det when |mu| is odd.  The SO(5)
and O(5) block lists are in bijection with equal multiplicities.
"""
Ra = WeylCharacterRing("B2")                 # ambient (e-basis) labels
W  = Ra(2, 2)
print("dim Weyl_5 =", W.degree())

S3 = W.symmetric_power(3)
d  = S3.monomial_coefficients()
rows = []
for k, v in d.items():
    lam = tuple(Integer(c) for c in k.to_vector())
    rows.append((lam, Integer(Ra(k).degree()), Integer(v)))
rows.sort(key=lambda t: (-t[1], t[0]))

print("dim Sym^3 =", S3.degree(), " (binom(37,3) =", binomial(37,3), ")")
print("blocks =", len(rows))
print("sum mult*dim =", sum(dd*m for _, dd, m in rows))
print("sum of mults =", sum(m for _,_,m in rows))
print("scalar unknowns =", sum(m*(m+1)//2 for _,_,m in rows))
print()
print("%-10s %6s %5s %6s %s" % ("SO(5) hw", "dim", "mult", "|mu|", "O(5) label"))
for lam, dd, m in rows:
    absmu = lam[0] + lam[1]
    tag = "[%d,%d]" % lam if absmu % 2 == 0 else "[%d,%d] (x) det" % lam
    print("%-10s %6d %5d %6d   %s" % (str(lam), dd, m, absmu, tag))

print()
for probe in [(0,0), (1,0), (1,1), (2,0), (2,2)]:
    print("mult of", probe, "dim", Ra(*probe).degree(), "=", d.get(Ra(*probe).support()[0], 0)
          if Ra(*probe).support() else None)
