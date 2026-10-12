# Validate the Littlewood restriction map used in r225_stable.sage, and the
# El Samra-King O(n) dimension formula, against each other on many cases:
#   dim_GL(n) s_lambda  ==  sum_mu  mult_mu * dim_O(n)[mu]   whenever l(lambda) <= n/2.
Sym = SymmetricFunctions(QQ); s = Sym.s()

def conj(la):
    la = [x for x in la if x]
    return [sum(1 for r in la if r > j) for j in range(la[0])] if la else []

def hooks(la):
    la = [x for x in la if x]; c = conj(la)
    return {(i,j): la[i]-j + c[j]-i - 1 for i in range(len(la)) for j in range(la[i])}

def dim_gl(la, n):
    la = [x for x in la if x]
    if len(la) > n: return 0
    H = hooks(la); num = 1; den = 1
    for (i,j),hh in H.items():
        num *= (n + j - i); den *= hh
    return Integer(num)/Integer(den)

def dim_o(la, n):
    """El Samra-King dimension of the O(n) irreducible [lambda]."""
    la = [x for x in la if x]; c = conj(la)
    if not la: return Integer(1)
    if (c[0] if c else 0) + (c[1] if len(c)>1 else 0) > n: return None   # not a label
    H = hooks(la); num = 1; den = 1
    def lam(i): return la[i-1] if i-1 < len(la) else 0
    def col(i): return c[i-1] if i-1 < len(c) else 0
    for (i0,j0),hh in H.items():
        i, j = i0+1, j0+1
        a = (n + lam(i) + lam(j) - i - j) if i <= j else (n - col(i) - col(j) + i + j - 2)
        num *= a; den *= hh
    return Integer(num)/Integer(den)

# spot-checks of the dimension formula against closed forms
for n in range(4, 20):
    assert dim_o([1], n) == n
    assert dim_o([2], n) == n*(n+1)/2 - 1
    assert dim_o([1,1], n) == n*(n-1)/2
    assert dim_o([2,2], n) == n*(n+1)*(n+2)*(n-3)/12
print("El Samra-King formula reproduces dim[1], dim[2], dim[1,1], dim[2,2] for n=4..19")

evens = [Partition([2*x for x in la]) for d in range(0,13,2) for la in Partitions(d//2)]
def restrict(f):
    G = Sym.zero()
    for d in evens: G += f.skew_by(s(d))
    return {tuple(la): int(cc) for la, cc in s(G) if cc != 0}

bad = 0; tested = 0
for d in range(0, 9):
    for la in Partitions(d):
        R = restrict(s(la))
        for n in range(2*len(la), 25):
            lhs = dim_gl(la, n)
            rhs = 0; skip = False
            for mu, m in R.items():
                dv = dim_o(mu, n)
                if dv is None: skip = True; break
                rhs += m*dv
            if skip: continue
            tested += 1
            if lhs != rhs:
                bad += 1
                print("  FAIL lambda=%s n=%d  GL=%s  sum O=%s" % (la, n, lhs, rhs))
print("Littlewood restriction x El Samra-King: %d checks, %d failures" % (tested, bad))

# planted violation: corrupt the restriction map and confirm the check fires
def restrict_bad(f):
    R = restrict(f)
    k = sorted(R)[0]; R[k] += 1
    return R
la = Partition([3,2,1]); R = restrict_bad(s(la)); n = 12
print("planted (one multiplicity bumped in res s_{3,2,1}): GL=%s vs sum O=%s -> %s"
      % (dim_gl(la,n), sum(m*dim_o(mu,n) for mu,m in R.items()),
         "CHECK FIRES" if dim_gl(la,n) != sum(m*dim_o(mu,n) for mu,m in R.items()) else "check blind"))
