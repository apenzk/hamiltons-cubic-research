# r224: the STABLE (universal) O-character decomposition of Sym^3(Weyl), computed
# inside the ring of symmetric functions from Littlewood's inverse restriction
# formula.  Nothing is read from this repo and no modification rule is used.
#
#   omega_nu = sum_{beta in B} (-1)^{|beta|/2} s_{nu/beta},
#   B = partitions with Frobenius coordinates (a | a-1), a_i >= 1 strictly decreasing.
#
# {omega_nu} is a basis of Lambda whose structure constants are the
# Newell-Littlewood numbers (Koike-Terada), and evaluation at the eigenvalues of
# an SO(n) element is a lambda-ring map, so h_3[omega_lambda] is Sym^3 of the rep.
Sym = SymmetricFunctions(QQ); s = Sym.s(); h = Sym.h()
NMAX = 16

def B_set(nmax):
    out = [Partition([])]
    for r in (1,2,3):
        for a in Subsets(range(1, nmax+1), r):
            a = sorted(a, reverse=True)
            if 2*sum(a) > nmax: continue
            b = [x-1 for x in a]
            out.append(Partition(frobenius_coordinates=(tuple(a), tuple(b))))
    return out
B = B_set(NMAX)
print("B (Littlewood's beta-set) up to size %d: %s" % (NMAX, [list(b) for b in B]))

def omega(nu):
    nu = Partition(nu)
    r = s.zero()
    for b in B:
        if len(b) <= len(nu) and all(b[i] <= nu[i] for i in range(len(b))):
            r += (-1)**(sum(b)//2) * s(s(nu).skew_by(s(b)))
    return r

# sanity: the forward Littlewood restriction s_lam = sum_mu (sum_{delta even rows} c^lam_{mu delta}) omega_mu
def forward_check(lam):
    lam = Partition(lam)
    lhs = s(lam)
    rhs = s.zero()
    for d in range(0, sum(lam)+1, 2):
        for delta in Partitions(d):
            if any(x % 2 for x in delta): continue
            sk = s(lam).skew_by(s(delta))
            for mu, c in s(sk).monomial_coefficients().items():
                rhs += c * omega(mu)
    return lhs == rhs
for t in [[2],[1,1],[2,2],[3,1],[2,1,1],[4],[3,2,1]]:
    assert forward_check(t), t
print("forward Littlewood restriction reproduced for 7 test partitions -- omega basis is right")

# ---- expand an arbitrary symmetric function in the omega basis (triangular by degree)
def omega_expand(f, dmax=NMAX):
    f = s(f); out = {}
    for d in range(dmax, -1, -1):
        hd = s(f).restrict_degree(d)
        if hd == 0: continue
        for nu, c in hd.monomial_coefficients().items():
            if c == 0: continue
            out[Partition(nu)] = c
            f = f - c*omega(nu)
    assert s(f) == 0, "omega expansion left a remainder"
    return out

