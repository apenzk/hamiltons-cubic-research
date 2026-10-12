"""The CP^m eigenvalue master formula, checked against every summand's weight.

Reviewer 42 derived, from closed forms for sb(P_omega, .) and sb(P_u, .),

    lambda_S = 1 - (c_S + q_S^2) / (4(m+1)),
    c_S = sum_i nu_i (nu_i + m + 1 - 2 i),      q_S = sum_i nu_i,

where nu is the summand's highest weight as a GL(m) weight: for V_{lam;mu} that is
(lam_1..lam_k, 0..0, -mu_l..-mu_1).  This script computes c_S and q_S symbolically
in m for all seven summands and checks the formula reproduces the known eigenvalues.

Nondegeneracy is then an arithmetic statement: lambda_S = 1/2 iff c_S + q_S^2 =
2(m+1).  The orbit hits it identically; V_{(1,1);(1,1)} gives 4(m-1), which equals
2(m+1) exactly at m = 3, where dim V_{(1,1);(1,1)} = m^2(m+1)(m-3)/4 = 0.
"""
import sympy as sp

m = sp.symbols('m', positive=True, integer=True)

def casimir(weight_terms):
    """weight_terms: list of (position i, value nu_i), positions 1-based in 1..m."""
    return sp.simplify(sum(v * (v + m + 1 - 2 * i) for i, v in weight_terms))

def charge(weight_terms):
    return sp.simplify(sum(v for _, v in weight_terms))

SUMMANDS = {
    'trivial <W>':        ([],                                    sp.Integer(1)),
    'su(m) adjoint':      ([(1, 1), (m, -1)],                     (m + 2) / (2 * (m + 1))),
    'orbit Lam^2 E':      ([(1, 1), (2, 1)],                      sp.Rational(1, 2)),
    'V_(1,1);(1,1)':      ([(1, 1), (2, 1), (m - 1, -1), (m, -1)], 2 / (m + 1)),
    'V_(2,1);(1)':        ([(1, 2), (2, 1), (m, -1)],             sp.Integer(0)),
    'V_(2);(2)':          ([(1, 2), (m, -2)],                     sp.Integer(0)),
    'V_(2,2);nothing':    ([(1, 2), (2, 2)],                      -3 / (m + 1)),
}

if __name__ == "__main__":
    print(f"{'summand':>18} {'c_S':>14} {'q_S':>5} {'formula':>18} {'known':>18} {'match':>6}")
    ok = True
    for name, (w, known) in SUMMANDS.items():
        c, q = casimir(w), charge(w)
        lam = sp.simplify(1 - (c + q**2) / (4 * (m + 1)))
        agree = sp.simplify(lam - known) == 0
        ok &= agree
        print(f"{name:>18} {str(sp.factor(c)):>14} {str(q):>5} {str(sp.factor(lam)):>18} "
              f"{str(sp.factor(known)):>18} {str(agree):>6}")
    print(f"\nall seven reproduced: {ok}")
    print("\nnondegeneracy: solve c_S + q_S^2 = 2(m+1) over the summands")
    for name, (w, _) in SUMMANDS.items():
        c, q = casimir(w), charge(w)
        sol = sp.solve(sp.Eq(c + q**2, 2 * (m + 1)), m)
        tag = "identically" if sp.simplify(c + q**2 - 2 * (m + 1)) == 0 else f"at m = {sol}"
        print(f"   {name:>18}: c+q^2 = {sp.factor(c + q**2)}   -> 1/2 {tag}")
