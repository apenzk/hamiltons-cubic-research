"""A by-product of claim 4's argument, against plan.md's open worry that
"sum m_lambda d_lambda = 7770" does not give a DIRECT sum.

It does, and the reason is the one that makes the replay a G-map.  The map
(x_1,...,x_m) -> sum_i phi_i(x_i) from V(lambda)^m into Sym^3 has kernel exactly
the linear relations among the phi_i inside Hom_g(V(lambda), Sym^3), and
phi -> phi(v_lambda) identifies that Hom with the highest-weight space, under
which phi_i corresponds to u_i.  The u_i are a nullspace basis, hence
independent, so the copies meet only in 0 -- for every block, unconditionally.

Confirmed on the multiplicity>=2 blocks that fit in seconds.
"""
import importlib.util, os
HERE = os.path.dirname(os.path.abspath(__file__))
spec = importlib.util.spec_from_file_location("core192", os.path.join(HERE, "core192.py"))
c = importlib.util.module_from_spec(spec); spec.loader.exec_module(c)

for lam in [(2, 0), (2, 2), (3, 2)]:
    key = f"{lam[0]},{lam[1]}"
    cols = c.C["hw"][key]["cols"]
    ns = [[c.gq(x) for x in v] for v in c.C["hw"][key]["vecs"]]
    m = len(ns); want = c.dimB2(lam)
    us = [{cols[j]: v[j] for j in range(len(cols)) if v[j] != c.Z} for v in ns]
    words = c.word_list(us[0], want)
    allv = [v for u in us for v in c.replay(u, words)]
    r = c.rank_of(allv)
    print(f"lambda={lam}: {m} copies x dim {want} = {m*want} vectors, "
          f"rank {r}   direct sum: {r == m*want}")
