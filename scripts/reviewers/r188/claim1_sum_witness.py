"""The shipped coefficient validation tests a SUM.  Two witnesses that pass it,
and the one-line repair that pins every beta.

run_n5_coefficient.py's only multi-index check is

    sum_d coeff(d, 6-d) == J(A+B).

Any rule that preserves that sum passes.  Below: (W1) reverse the multi-index,
(W2) move mass from beta=(2,4) to beta=(4,2).  Both pass the shipped check.
The repair is to weight the sum -- sum_d coeff(d,6-d) s^d t^(6-d) == J(sA+tB)
at enough (s,t) -- which is a Vandermonde system in s/t and therefore pins each
coefficient individually.  It also extends to r > 2 distinct tensors, which the
shipped tests never exercise.
"""
import sys, os, itertools, random, numpy as np
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "..", "r179"))
import weyl_invariants as WI
import importlib.util
spec = importlib.util.spec_from_file_location(
    "shipped", os.path.join(HERE, "..", "..", "runs", "run_n5_coefficient.py"))
sh = importlib.util.module_from_spec(spec); spec.loader.exec_module(sh)
coeff = sh.coeff

N, P, K = 5, 10007, 6
rng = np.random.default_rng(188); pyrng = random.Random(188)
A = WI.random_weyl(N, P, rng); B = WI.random_weyl(N, P, rng); Cc = WI.random_weyl(N, P, rng)
MS = [WI.random_matching(K, pyrng) for _ in range(5)]

print("=== the shipped check, and two rules that pass it ===")
for mi, m in enumerate(MS):
    cs = [coeff([A, B], [d, 6-d], m, K, P) for d in range(7)]
    target = WI.eval_diagram((A+B) % P, m, K, P) % P
    ok = sum(cs) % P == target
    rev = list(reversed(cs))                       # W1
    red = cs[:]; red[2] = (red[2]+1234) % P; red[4] = (red[4]-1234) % P   # W2
    print(f"  matching {mi}: shipped sum ok {ok};  palindromic {cs == rev};  "
          f"W1 passes {sum(rev)%P == target};  W2 passes {sum(red)%P == target}")

print("\n=== the repair: weight the sum, then it is a Vandermonde in s/t ===")
def weighted_ok(cs, m, tensors, r, trials=4):
    """sum_beta cs[beta] prod s_i^beta_i == J(sum s_i T_i) at random s."""
    good = 0
    for _ in range(trials):
        s = [pyrng.randrange(1, P) for _ in range(r)]
        T = np.zeros_like(tensors[0])
        for i, si in enumerate(s): T = (T + si*tensors[i]) % P
        lhs = sum(c*np.prod([pow(s[i], b[i], P) for i in range(r)]) % P
                  for b, c in cs.items()) % P
        if lhs == WI.eval_diagram(T % P, m, K, P) % P: good += 1
    return good == trials

for mi, m in enumerate(MS):
    cs = {(d, 6-d): coeff([A, B], [d, 6-d], m, K, P) for d in range(7)}
    rev = {(d, 6-d): cs[(6-d, d)] for d in range(7)}
    red = dict(cs); red[(2,4)] = (red[(2,4)]+1234) % P; red[(4,2)] = (red[(4,2)]-1234) % P
    print(f"  matching {mi}: shipped {weighted_ok(cs, m, [A,B], 2)}   "
          f"W1 {weighted_ok(rev, m, [A,B], 2)}   W2 {weighted_ok(red, m, [A,B], 2)}")

print("\n=== r = 3 distinct tensors: the shape the shipped tests never run ===")
for mi, m in enumerate(MS[:3]):
    cs = {}
    for b in itertools.product(range(7), repeat=3):
        if sum(b) == 6: cs[b] = coeff([A, B, Cc], list(b), m, K, P)
    tot = sum(cs.values()) % P
    tgt = WI.eval_diagram((A+B+Cc) % P, m, K, P) % P
    print(f"  matching {mi}: {len(cs)} multi-indices;  unweighted sum matches "
          f"J(A+B+C): {tot == tgt};  WEIGHTED identity holds: "
          f"{weighted_ok(cs, m, [A,B,Cc], 3)}")

print("\n=== is the shipped Vandermonde elimination actually right? ===")
# It fits a degree-b_i polynomial in x_i through the b_i+1 points 0..b_i, while
# the true function has degree |beta| = 6 in each variable.  That looks wrong and
# is not: the functional it applies is the b-th finite difference at 0 over b!,
# which on x^d returns the Stirling number S(d,b), and S(d,b) = 0 for d < b.
# So pass i keeps only the terms with d_i >= b_i.  After all r passes,
# sum_i d_i = 6 = sum_i b_i with d_i >= b_i for every i forces d = beta, with
# coefficient S(b_i,b_i) = 1.  Exact for any r and any beta of total degree 6 --
# and it fails the moment |beta| != deg, which is the untested boundary.
def stirling2(d, b):
    from math import comb
    return sum((-1)**(b-j)*comb(b, j)*j**d for j in range(b+1))//__import__("math").factorial(b)
print("  S(d,b) for d<b is 0: "
      f"{all(stirling2(d,b)==0 for b in range(1,7) for d in range(b))}; "
      f"S(b,b)=1: {all(stirling2(b,b)==1 for b in range(7))}")

print("\n=== ground truth by FULL-degree interpolation, r = 2 ===")
def solve(Mrows, n):
    M=[r[:] for r in Mrows]; r=0
    for c in range(n):
        s_=next(k for k in range(r,len(M)) if M[k][c]%P)
        M[r],M[s_]=M[s_],M[r]
        inv=pow(M[r][c],P-2,P); M[r]=[x*inv%P for x in M[r]]
        for k in range(len(M)):
            if k!=r and M[k][c]%P:
                f=M[k][c]; M[k]=[(x-f*y)%P for x,y in zip(M[k],M[r])]
        r+=1
    return [M[d][n] for d in range(n)]
for mi, m in enumerate(MS[:3]):
    rows=[[pow(s,d,P) for d in range(7)]+[WI.eval_diagram((s*A+B)%P,m,K,P)%P]
          for s in range(7)]
    true=solve(rows,7)
    ship=[coeff([A,B],[d,6-d],m,K,P) for d in range(7)]
    print(f"  matching {mi}: full 7-point extraction == shipped 3-to-5-point: "
          f"{true==ship}")

print("\n=== r = 4, a lopsided multi-index, against a finite difference ===")
D = WI.random_weyl(N, P, rng)
m = MS[0]
for b in [(3,1,1,1), (2,2,1,1), (4,1,1,0), (1,1,1,3)]:
    c = coeff([A, B, Cc, D], list(b), m, K, P)
    # independent: iterated finite difference in each variable on the product grid
    grids = [range(bi+1) for bi in b]
    acc = 0
    for x in itertools.product(*grids):
        T = np.zeros_like(A)
        for i, xi in enumerate(x):
            if xi: T = (T + xi*[A,B,Cc,D][i]) % P
        w = 1
        for i, xi in enumerate(x):
            # Lagrange weight extracting the b[i]-th coefficient on 0..b[i]
            num, den = 1, 1
            for y in grids[i]:
                if y != xi: den = den*((xi-y) % P) % P
            w = w*num % P
            w = w*pow(den, P-2, P) % P
            w = w*pow(xi, 0, P) % P
        # Lagrange interpolation gives the polynomial; its top coefficient in
        # variable i is sum_x val * (leading coeff of the Lagrange basis poly)
        acc = (acc + w*WI.eval_diagram(T % P, m, K, P)) % P
    print(f"  beta={b}: shipped {c}, Lagrange-top-coefficient {acc}, "
          f"agree {c == acc}")
