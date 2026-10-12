# r214 claim 4 foundation: dim (Sym^6 Weyl_5)^{O(5)}.
# Weyl_5 = B2 irrep with epsilon highest weight (2,2), dim 35.
R = WeylCharacterRing("B2")
V = R(2,2)
print("dim Weyl_5 =", V.degree())
# O(5) = SO(5) x {+-I} and -I acts as +1 on a 4-tensor, so O(5)-invariants
# = SO(5)-invariants here.
wm = V.weight_multiplicities()
ws = []
for w, m in wm.items():
    ws += [tuple(QQ(t) for t in w.to_vector())]*m
print("weights collected:", len(ws))
L = LaurentPolynomialRing(ZZ, 2, 'x')
x, y = L.gens()
mon = [x**ZZ(a)*y**ZZ(b) for a, b in ws]
# h_6 of the 35 monomials, by the Newton / generating-function recursion
# H(t) = prod 1/(1 - m_i t);  h_k = (1/k) sum_{j=1}^{k} p_j h_{k-j}
p = [L.zero()]*7
for j in range(1, 7):
    p[j] = sum(m**j for m in mon)
h = [L.one()] + [L.zero()]*6
for k in range(1, 7):
    acc = L.zero()
    for j in range(1, k+1):
        acc += p[j]*h[k-j]
    h[k] = acc // k
S6 = h[6]
print("dim Sym^6 (sum of coeffs) =", sum(S6.coefficients()), " expected C(40,6) =", binomial(40,6))
co = {}
for m_, c in zip(S6.monomials(), S6.coefficients()):
    e = m_.exponents()[0]
    co[(e[0]-e[2] if len(e)>2 else e[0], e[1]-e[3] if len(e)>3 else e[1])] = c
# LaurentPolynomialRing exponents already signed
co = {}
for m_, c in zip(S6.monomials(), S6.coefficients()):
    co[tuple(m_.exponents()[0])] = c
def mult(w):
    return co.get(tuple(w), 0)
# Kostant multiplicity of the trivial:  sum_{w in W} (-1)^{l(w)} m(rho - w rho)
Wg = WeylGroup(['B',2], prefix="s")
amb = RootSystem(['B',2]).ambient_space()
rho = amb.rho()          # (3/2, 1/2) for B2
tot = 0
for g in Wg:
    wr = g.matrix()*vector(rho.to_vector())
    d = vector(rho.to_vector()) - wr
    tot += g.matrix().det()*mult(tuple(QQ(t) for t in d))
print("multiplicity of the trivial rep in Sym^6(Weyl_5) =", tot)
