"""r263 CLAIM 3 -- what run_seed_is_a_diagram.py actually tests, and two latent defects.

(1) THE ODD-f CELLS TEST A VECTOR ORBIT, NOT A MAP ORBIT.  For odd f the reviewed
    script uses base = np.eye(n)[0], the weight vector e_0 of V, and measures
    span{ nu(D) (e_0 tensor cup^k) } inside V^{tensor f}.  The lemma's c_0 is the
    MAP id_V tensor cup^k : V -> V^{tensor f}, and the theorem is about
    span{ nu(D) c_0 } inside Hom(V, V^{tensor f}).  Those are different spaces.
    Here both are computed and compared, at the four odd-f cells of the run.

(2) padded_seed infers m = round(log(len(base))/log(n)) in floating point and then
    takes k = (f - m) // 2 with NO parity guard, so an odd f - m is silently
    floored and the function returns a tensor with the WRONG number of legs.
    Exhibited below.

(3) The same log/log inference divides by log(n), so n = 1 raises, and n = 1 is
    exactly the row r259 and r260 added to the OTHER script's sweep.
"""
import numpy as np

def nu_s(T, i):
    return np.swapaxes(T, i, i + 1)

def nu_e(T, i, n):
    A = np.moveaxis(T, [i, i + 1], [0, 1])
    tr = np.einsum('aa...->...', A)
    out = np.zeros(A.shape)
    for a in range(n):
        out[a, a] = tr
    return np.moveaxis(out, [0, 1], [i, i + 1])

def closure(seed, f, n):
    basis = np.zeros((0, seed.size))
    frontier = [seed]
    def add(vs):
        nonlocal basis
        keep = []
        for v in vs:
            w = v.reshape(-1).astype(float)
            if basis.shape[0]:
                w = w - basis.T @ (basis @ w)
                w = w - basis.T @ (basis @ w)
            if np.linalg.norm(w) > 1e-7:
                basis = np.vstack([basis, w / np.linalg.norm(w)])
                keep.append(v)
        return keep
    frontier = add(frontier)
    while frontier:
        nxt = []
        for T in frontier:
            for i in range(f - 1):
                nxt.append(nu_s(T, i))
            nxt.append(nu_e(T, 0, n))
        frontier = add(nxt)
    return basis.shape[0]

def conj(lam):
    return tuple(sum(1 for p in lam if p > k) for k in range(lam[0])) if lam else ()
def admissible(lam, n):
    c = conj(lam)
    return (c[0] if c else 0) + (c[1] if len(c) > 1 else 0) <= n
def restricted_updown(f, n):
    cur = {(): 1}
    for _ in range(f):
        nxt = {}
        for lam, c in cur.items():
            for k in range(len(lam) + 1):
                new = list(lam) + [0]; new[k] += 1
                if all(new[t] >= new[t+1] for t in range(len(new)-1)):
                    key = tuple(x for x in new if x)
                    if admissible(key, n): nxt[key] = nxt.get(key, 0) + c
            for k in range(len(lam)):
                new = list(lam); new[k] -= 1
                if new[k] >= 0 and all(new[t] >= new[t+1] for t in range(len(new)-1)):
                    key = tuple(x for x in new if x)
                    if admissible(key, n): nxt[key] = nxt.get(key, 0) + c
        cur = nxt
    return cur

print("  (1) the odd-f cells: the run's VECTOR orbit against the lemma's MAP orbit\n")
print(f"  {'f':>2} {'n':>2} {'run: span nu(D)(e_0 x cup^k)':>29} "
      f"{'lemma: span nu(D) c_0 (maps)':>29} {'m_(1)(n)':>9}")
for f, n in ((3, 3), (3, 2), (5, 2), (5, 3)):
    k = (f - 1) // 2
    cup = np.zeros((n, n)); np.fill_diagonal(cup, 1.0)
    # the run's object: one vector in V^{tensor f}
    v = np.eye(n)[0]
    for _ in range(k):
        v = np.tensordot(v, cup, axes=0)
    vec = closure(v, f, n)
    # the lemma's object: the MAP id_V tensor cup^k, spectator index last
    M = np.eye(n)
    Mt = M.reshape(n, n)                      # (leg, V_lambda index)
    c0 = np.moveaxis(Mt, 1, 0)                # (d,) + (n,)
    for _ in range(k):
        c0 = np.tensordot(c0, cup, axes=0)
    c0 = np.moveaxis(c0, 0, -1)               # (n,)*f + (d,)
    mp = closure(c0, f, n)
    want = restricted_updown(f, n).get((1,), 0)
    print(f"  {f:>2} {n:>2} {vec:>29} {mp:>29} {want:>9}   "
          f"{'agree' if vec == mp == want else 'DISAGREE'}")
print("\n      The two agree because evaluation at e_0 is INJECTIVE on M_(1): a nonzero")
print("      equivariant V -> V^{tensor f} is injective (V is irreducible), so no")
print("      nonzero combination of the nu(D)c_0 can kill e_0.  The run's number is")
print("      therefore right -- for a reason the run never states, and one that fails")
print("      as soon as lambda is a label whose V_lambda the base vector does not span.\n")

print("  (2) padded_seed's missing parity guard -- a silent undershoot\n")
def padded_seed(f, n, base):
    m = int(round(np.log(len(base)) / np.log(n))) if len(base) > 1 else 0
    k = (f - m) // 2
    out = base
    for _ in range(k):
        c = np.zeros(n * n)
        for a in range(n):
            c[a * n + a] = 1.0
        out = np.kron(out, c)
    return out
for f, n, name in ((4, 3, "e_0 (m=1) into an f=4 slot"), (3, 3, "scalar (m=0) into an f=3 slot")):
    base = np.eye(n)[0] if "e_0" in name else np.array([1.0])
    v = padded_seed(f, n, base)
    print(f"      padded_seed(f={f}, n={n}, {name}):  len = {len(v)},  n^f = {n**f}"
          f"   {'OK' if len(v) == n**f else 'WRONG NUMBER OF LEGS -- returned silently'}")
print("\n      The eight tested cells all have f - m even, so the run never trips it;")
print("      an added cell with the wrong parity would return a shorter vector and")
print("      the rank comparison against m_lambda(n) would then be meaningless.\n")

print("  (3) the log/log inference at n = 1")
try:
    padded_seed(2, 1, np.eye(1)[0])
    print("      n = 1: no error")
except Exception as ex:
    print(f"      n = 1 raises {type(ex).__name__}: {ex}")
import warnings
with warnings.catch_warnings():
    warnings.simplefilter("error")
    try:
        v = padded_seed(2, 1, np.array([1.0, 0.0]))
        print(f"      padded_seed(2, 1, len-2 base) -> len {len(v)}")
    except Exception as ex:
        print(f"      padded_seed(2, 1, len-2 base) raises {type(ex).__name__}: {ex}")
