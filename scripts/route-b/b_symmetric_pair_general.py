"""theta in closed form for EVERY two-eigenvalue symmetric-pair point, in four invariants.

The derivation that closed the (su(m), so(m)) family used nothing about su(m).  It used
only that (g, k) is a SYMMETRIC PAIR inside so(n).  Written out in general it gives a
single formula covering the whole class at once -- which is what the live target needs:
cap families analytically, do not census them.

THE SETUP.  g = k (+) m a symmetric pair, g inside so(n), with p = dim k, q = dim m, and
the two-eigenvalue graded ansatz

    W = a . Pi_k  +  b . Pi_m ,     a p + b q = 0 (trace-free),  a^2 p + b^2 q = 1 (unit),

so a^2 = q / (p (p+q)) and b = -a p / q.

TWO OF THE FOUR BLOCK MASSES VANISH IDENTICALLY, for ANY symmetric pair, because
[k,k] in k perp m and [m,m] in k perp m:

    S_kkm = 0 ,   S_mmm = 0 .

The second is why every such point has S = 0 -- i.e. why this whole class lands in the
target set.  With S_XYZ := sum over a in X, b in Y, c in Z of <[v_a,v_b],v_c>^2 :

    theta^2 = ( S_kkk q^2 + 3 S_kmm p^2 - 2 p^3 + 2 p q^2 )^2 / ( 4 p^3 q (p+q)^3 ) .

THE RELATION between the two survivors.  For g simple with Killing constant c, meaning
sum_{b in g} ||[a,b]||^2 = c ||a||^2 for a in g, summing over an orthonormal basis of k
splits that into

    S_kkk + S_kmm = c p ,

so theta depends on only FOUR Lie-theoretic invariants of the pair: p, q, S_kkk, c.

VERIFIED against the one family already derived independently: for (su(m), so(m)) with
p = m(m-1)/2, q = m(m+1)/2 - 1, S_kkk = (m-2)p (the Killing form of so(m)) and c = 2m,
the relation gives S_kmm = (m+2)p, which equals m q identically, and the general formula
returns theta^2 = m(m+1)/((m-1)(m+2)) -- matching the direct derivation exactly.

SCOPE, stated plainly.  This covers the TWO-EIGENVALUE ansatz only.  CP^m and HP^2 have
THREE distinct eigenvalues and are NOT of this form, so they are not covered and still
need their own arguments.  What the formula does deliver is every graded two-eigenvalue
point in one expression, reducing "which symmetric pairs threaten sqrt(3/2)?" to an
arithmetic question in (p, q, S_kkk, c).

THE FOUR INVARIANTS ARE CLASSICAL TABLE DATA.  c is not a free parameter: for a simple g
in the orthogonal representation rho : g -> so(n), the inherited Killing constant is

    c = 2 h^v(g) / I_rho ,

the dual Coxeter number over the Dynkin index of rho.  Likewise S_kkk = c_k p with
c_k = 2 h^v(k) / I_{rho|k}.  The rule is checked against the only two constants this
project already knows exactly, and reproduces both:

    g = so(n), rho standard   h^v = n-2, I = 1  ->  c = 2(n-2)   [the record's rho_a]
    g = su(m), rho = C^m_R    h^v = m,   I = 1  ->  c = 2m       [derived here]
    k = so(m) in su(m),
      rho|k = R^m + R^m       h^v = m-2, I = 2  ->  c_k = m-2    [S_kkk = (m-2)p]

So maximising theta over the two-eigenvalue class is a FINITE ARITHMETIC PROBLEM over
Cartan's list of symmetric pairs together with the branching index I_{rho|k} -- no
searching, no sampling.  That is the next step, and the literature (Helgason's tables of
(g, k) with dimensions; Dynkin indices of the relevant representations) supplies every
input.

FALSIFIER: a two-eigenvalue symmetric-pair point whose theta disagrees with the formula.
"""
import sympy as sp


def theta_sq_symbolic():
    """The general formula, and its form after eliminating S_kmm via the Killing relation."""
    p, q, Skkk, Skmm, c = sp.symbols('p q S_kkk S_kmm c', positive=True)
    a = sp.symbols('a', positive=True)
    b = -a * p / q
    a_sq = sp.solve(sp.Eq(sp.simplify(a**2 * p + b**2 * q), 1), a**2)[0]
    theta = (a**3 * p + b**3 * q) + sp.Rational(1, 2) * (a**3 * Skkk + 3 * a * b**2 * Skmm)
    th_sq = sp.simplify(sp.factor(sp.expand(sp.simplify(theta / a**3)**2) * a_sq**3))
    return th_sq, sp.simplify(sp.factor(th_sq.subs(Skmm, c * p - Skkk))), (p, q, Skkk, Skmm, c)


def main():
    th_sq, th_sq_killing, syms = theta_sq_symbolic()
    p, q, Skkk, Skmm, c = syms
    print("=== the general two-eigenvalue symmetric-pair formula ===")
    print(f"  a^2 = q/(p(p+q)),   b = -a p / q")
    print(f"  theta^2 = {th_sq}")
    print(f"\n  after S_kkk + S_kmm = c p  (Killing, g simple):")
    print(f"  theta^2 = {th_sq_killing}")

    print("\n=== check against the independently derived (su(m), so(m)) family ===")
    m = sp.symbols('m', positive=True, integer=True)
    P, Q = m * (m - 1) / 2, m * (m + 1) / 2 - 1
    lhs = sp.expand((m + 2) * P)
    print(f"  Killing relation gives S_kmm = (c - (m-2)) p = (m+2) p")
    print(f"    (m+2)p = {lhs}   m q = {sp.expand(m*Q)}   equal: "
          f"{sp.simplify(lhs - m*Q) == 0}")
    val = sp.simplify(th_sq_killing.subs({p: P, q: Q, Skkk: (m - 2) * P, c: 2 * m}))
    print(f"  general formula -> theta^2 = {sp.simplify(sp.factor(val))}")
    print(f"  direct derivation gave  m(m+1)/((m-1)(m+2));  agree: "
          f"{sp.simplify(val - m*(m+1)/((m-1)*(m+2))) == 0}")
    print(f"\n  max over the family at m=3: theta^2 = {sp.nsimplify(val.subs(m,3))}"
          f" = {float(val.subs(m,3)):.6f}, theta = {float(sp.sqrt(val.subs(m,3))):.9f}")
    print(f"  against sqrt(3/2) = {float(sp.sqrt(sp.Rational(3,2))):.9f}")

    print("\n  SCOPE: two-eigenvalue ansatz only.  CP^m and HP^2 have three distinct")
    print("  eigenvalues and are not of this form; they still need their own arguments.")


if __name__ == '__main__':
    main()
