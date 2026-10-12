"""r224: turn the universal (stable) O-table into a prediction for the SO(n)
decomposition, then compare with the Weyl-character-formula computation.

For n >= 12 the argument under review says every one of the 71 universal labels
is a legitimate O(n) label, so the O(n) table IS the universal table.  Passing to
SO(n):
  * a label with ell(lambda) < n/2 restricts to the SO(n) irreducible lambda;
  * n even and ell(lambda) = n/2: [lambda] is self-associate and splits into the
    two SO(n) irreducibles (lambda_1,...,+lambda_m) and (...,-lambda_m);
  * a label with ell(lambda) > n/2 restricts like its associate, so the two add.
At n = 11 the single label (2,2,2,2,2,2) has lambda'_1+lambda'_2 = 12 = n+1,
which King's rule sends to zero, so the O(11) table is the universal one minus
that block.
"""
import json, sys
E = {tuple(json.loads(k)): v for k, v in json.load(open('scripts/reviewers/r224/universal_table.json')).items()}

def cols(l):
    return [sum(1 for x in l if x >= j) for j in range(1, (max(l) if l else 0)+1)]
def from_cols(c):
    c = [x for x in c if x]
    return tuple(sum(1 for y in c if y >= i) for i in range(1, (max(c) if c else 0)+1))
def associate(l, n):
    c = cols(l); c = [n - (c[0] if c else 0)] + c[1:]
    if c[0] < (c[1] if len(c) > 1 else 0): return None
    return from_cols(c)

for n in (11, 12, 13, 14, 16):
    m = n // 2
    tab = {l: v for l, v in E.items() if (len(l) + sum(1 for x in l if x >= 2)) <= n}
    dropped = [l for l in E if l not in tab]
    so = {}
    for l, v in tab.items():
        if len(l) > m:
            a = associate(l, n); key = a + (0,)*(m-len(a))
            so[key] = so.get(key, 0) + v
        elif n % 2 == 0 and len(l) == m:
            k = tuple(l)
            so[k] = so.get(k, 0) + v
            so[k[:-1] + (-k[-1],)] = so.get(k[:-1] + (-k[-1],), 0) + v
        else:
            key = tuple(l) + (0,)*(m-len(l))
            so[key] = so.get(key, 0) + v
    print("n=%-3d O-blocks %3d  O-mult %3d  (dropped by modification: %s)   ->  predicted SO blocks %3d  SO mult %3d"
          % (n, len(tab), sum(tab.values()), [list(d) for d in dropped], len(so), sum(so.values())))
    json.dump({str(list(k)): v for k, v in so.items()}, open('scripts/reviewers/r224/pred_so_%d.json' % n, 'w'))
