"""Reviewer 187 shared harness: the shipped coeff, the S6 symmetrisation, and
an independent sympy-exact expansion of J(sum_k x_k A_k)."""
import sys, os, itertools, random
import numpy as np
ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "..")
sys.path.insert(0, os.path.join(ROOT, "scripts", "reviewers", "r179"))
import weyl_invariants as WI
import importlib.util
_spec = importlib.util.spec_from_file_location(
    "pol", os.path.join(ROOT, "scripts", "runs", "run_n5_polarised_diagram.py"))
pol = importlib.util.module_from_spec(_spec); _spec.loader.exec_module(pol)
ep = pol.eval_polarised

_cspec = importlib.util.spec_from_file_location(
    "shipped", os.path.join(ROOT, "scripts", "runs", "run_n5_coefficient.py"))
shipped = importlib.util.module_from_spec(_cspec); _cspec.loader.exec_module(shipped)
coeff = shipped.coeff          # THE OBJECT UNDER REVIEW

def coeff_sym(tensors, beta, matching, k, p):
    """[x^beta] J  as the sum over the 6!/beta! DISTINCT vertex placements."""
    seq = [a for a, b in enumerate(beta) for _ in range(b)]
    seen, tot = set(), 0
    for sg in itertools.permutations(seq):
        if sg in seen: continue
        seen.add(sg)
        tot = (tot + ep([tensors[a] for a in sg], matching, p)) % p
    return tot % p

def coeff_exact_sympy(tensors, beta, matching, k, p):
    """[x^beta] J by literally forming T = sum_k x_k A_k over the polynomial ring
    and expanding -- no interpolation anywhere.  Independent of coeff by
    construction; O(n^4 * monomials) memory, so use sparingly."""
    import sympy
    r = len(tensors)
    xs = sympy.symbols(f"x0:{r}")
    T = sum((sympy.Integer(int(x)) * A.astype(object) for x, A in zip(xs, tensors)),
            start=np.zeros_like(tensors[0], dtype=object))
    val = _eval_diagram_obj(T, matching, k, p)
    poly = sympy.Poly(sympy.expand(val), *xs)
    c = poly.coeff_monomial(sympy.prod([x**b for x, b in zip(xs, beta)]))
    return int(c) % p

def _eval_diagram_obj(W, matching, k, p):
    """WI.eval_diagram, but on an object-dtype (polynomial-entry) tensor."""
    legs = {}
    for a, b in matching:
        legs[a] = b; legs[b] = a
    tensors = [(W, [4*v+j for j in range(4)]) for v in range(k)]
    while True:
        best = None
        for i in range(len(tensors)):
            for j in range(i+1, len(tensors)):
                li, lj = tensors[i][1], tensors[j][1]
                sh = [(a, legs[a]) for a in li if legs.get(a) in lj]
                if not sh: continue
                out = len(li) + len(lj) - 2*len(sh)
                if best is None or out < best[0]: best = (out, i, j, sh)
        if best is None: break
        out, i, j, sh = best
        Ti, li = tensors[i]; Tj, lj = tensors[j]
        ax0 = [li.index(a) for a, b in sh]; ax1 = [lj.index(b) for a, b in sh]
        import sympy
        Tn = np.tensordot(Ti, Tj, axes=(ax0, ax1))
        Tn = np.vectorize(lambda z: sympy.expand(z))(Tn) if Tn.ndim else Tn
        ln = [l for x, l in enumerate(li) if x not in ax0] + \
             [l for x, l in enumerate(lj) if x not in ax1]
        for a, b in sh: legs.pop(a, None); legs.pop(b, None)
        tensors = [t for x, t in enumerate(tensors) if x not in (i, j)] + [(Tn, ln)]
    import sympy
    val = sympy.Integer(1)
    for T, l in tensors:
        assert T.ndim == 0
        val = val * T.item()
    return sympy.expand(val)
