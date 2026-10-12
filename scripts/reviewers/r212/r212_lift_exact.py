"""r212: independent CRT + rational reconstruction of the n=5 sextic rows.

Written from the definitions rather than adapted from run_n5_lift.py, and every
lifted rational is pushed BACK through each prime and compared with the observed
residue -- a reconstruction that is wrong cannot survive that for all three.

Output: an exact 40x47 rational matrix A and rational rhs B, pickled for reuse.
"""
import os, json, glob, pickle
from fractions import Fraction as Fr

HERE = os.path.dirname(os.path.abspath(__file__))
RUNS = os.path.join(HERE, "..", "..", "runs")

def load_rows():
    files = sorted(glob.glob(os.path.join(RUNS, "n5_rows_*.json")))
    data = [json.load(open(f)) for f in files]
    for x in data[1:]:
        assert x["blocks"] == data[0]["blocks"] and x["shape"] == data[0]["shape"]
    return data

def egcd(a, b):
    if b == 0: return (a, 1, 0)
    g, x, y = egcd(b, a % b)
    return (g, y, x - (a // b) * y)

def crt(rs, ps):
    """garner, written independently of the pipeline's version"""
    x, m = 0, 1
    for r, p in zip(rs, ps):
        g, inv, _ = egcd(m % p, p)
        assert g == 1
        t = ((r - x) * inv) % p
        x += m * t
        m *= p
    return x % m, m

def ratrec(a, M, bound):
    """half-extended Euclid; returns Fr(num,den) with |num|,den <= bound or None"""
    r0, r1 = M, a % M
    t0, t1 = 0, 1
    while r1 > bound:
        q = r0 // r1
        r0, r1 = r1, r0 - q * r1
        t0, t1 = t1, t0 - q * t1
    if t1 == 0 or abs(t1) > bound: return None
    n, d = r1, t1
    if d < 0: n, d = -n, -d
    from math import gcd
    if gcd(abs(n), d) != 1: return None
    return Fr(n, d)

def main():
    data = load_rows()
    ps = [x["prime"] for x in data]
    M = 1
    for p in ps: M *= p
    bound = int((M // 2) ** 0.5)
    NR, NC = len(data[0]["rows"]), len(data[0]["rows"][0])
    print(f"primes {ps}  bits {sum(p.bit_length() for p in ps)}  M~2^{M.bit_length()}")
    print(f"{NR} x {NC}, reconstruction bound {bound}")

    A = [[None]*NC for _ in range(NR)]
    fails = []
    for i in range(NR):
        for j in range(NC):
            v, m = crt([data[k]["rows"][i][j] for k in range(len(ps))], ps)
            r = ratrec(v, m, bound)
            if r is None: fails.append((i, j))
            A[i][j] = r
    B = []
    for i in range(NR):
        v, m = crt([data[k]["rhs"][i] for k in range(len(ps))], ps)
        r = ratrec(v, m, bound)
        if r is None: fails.append((i, -1))
        B.append(r)
    print(f"failed reconstructions: {len(fails)} of {NR*NC+NR}")
    assert not fails

    # CONSISTENCY: reduce every lifted rational back mod each prime.
    bad = 0
    for k, p in enumerate(ps):
        for i in range(NR):
            for j in range(NC):
                x = A[i][j]
                if (x.numerator * pow(x.denominator % p, p-2, p)) % p != data[k]["rows"][i][j] % p:
                    bad += 1
            x = B[i]
            if (x.numerator * pow(x.denominator % p, p-2, p)) % p != data[k]["rhs"][i] % p:
                bad += 1
    print(f"round-trip mismatches across all three primes: {bad} (must be 0)")
    assert bad == 0

    hts = [max(abs(x.numerator), x.denominator) for r in A for x in r] + \
          [max(abs(x.numerator), x.denominator) for x in B]
    hts_nz = [h for h in hts if h > 1]
    print(f"max height {max(hts):.6g}   bound {bound:.6g}   ratio {max(hts)/bound:.3e}")
    print(f"zero entries: {sum(1 for r in A for x in r if x == 0)} of {NR*NC}")

    with open(os.path.join(HERE, "exact_rows.pkl"), "wb") as f:
        pickle.dump({"A": A, "B": B, "primes": ps,
                     "blocks": [tuple(b) for b in data[0]["blocks"]],
                     "shape": data[0]["shape"]}, f)
    print("wrote exact_rows.pkl")

if __name__ == "__main__":
    main()
