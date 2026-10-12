"""Reviewer 202, claim 3(b) at full scale: EVERY block's copies made coincident,
then the whole shipped check battery -- count, digest, Hermitian, dis, skipped,
square, inhom -- plus det h, which the working tree deleted."""
import sys, os, copy, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import harness as H

t0 = time.time()
A = {k: [copy.deepcopy(cs[0]) for _ in cs] for k, cs in H.ADAPTED.items()}
tot, sq, BYW, MONS = H.square_check(A)
print(f"vectors {tot} (7770: {tot==7770}) | square {sq} | inhom {H.inhom_check(A)} "
      f"| digest {H.digest(A)}  (clean digest 84a0459fe49cc41e)", flush=True)
DIS = SK = 0
for lam in sorted(A, key=lambda l: len(A[l][0])):
    m = len(A[lam])
    if m == 1: continue
    HM = H.measure_h(A, lam)
    d, sk = H.dis_probe(A, lam, HM)
    DIS += d; SK += sk
    allone = all(x == (1, 0) for r in HM for x in r)
    print(f"  lambda={lam} m={m}: Hermitian {H.hermitian(HM)} | h is all-ones "
          f"{allone} | complex off-diag "
          f"{sum(1 for i in range(m) for j in range(m) if i!=j and HM[i][j][1])} "
          f"| dis {d} skipped {sk} | det h {H.det_gp(HM)}   [{time.time()-t0:.0f}s]",
          flush=True)
print(f"\nSHIPPED ASSERTS: dis == 0 -> {DIS == 0}; skipped == 0 -> {SK == 0}; "
      f"square -> {sq}; inhom == 0 -> {H.inhom_check(A) == 0}; count 7770 -> {tot == 7770}")
print(f"the whole of run_n5_assemble.py passes on this cache.  [{time.time()-t0:.0f}s]")
