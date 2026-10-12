"""Claim 4, second half: the shipped per-copy SPANNING check cannot fail.

phi_i : V(lambda) -> Sym^3 is the unique g-map with v_lambda -> u_i; it is
injective because V(lambda) is irreducible and phi_i is nonzero.  The replayed
vector for word w is X_w u_i = phi_i(X_w v_lambda) = phi_i(b_w).  Copy 1's list
spanning its block means {b_w} is a BASIS of V(lambda) -- dim many, independent
because phi_1 is injective.  An injective map sends a basis to an independent
set, so EVERY copy's replay is independent and of the same size.  The branch
that prints '!!' in run_n5_adapted.py is unreachable once len(words) == dim.

Demonstration: replay copy 1's word list on RANDOM elements of the multiplicity
space -- not just the two-to-four echelon vectors the shipped script uses -- and
watch the rank never drop.
"""
import importlib.util, os, random
from fractions import Fraction as F
HERE = os.path.dirname(os.path.abspath(__file__))
spec = importlib.util.spec_from_file_location("core192", os.path.join(HERE, "core192.py"))
c = importlib.util.module_from_spec(spec); spec.loader.exec_module(c)

random.seed(1920)
for lam in [(2, 0), (2, 2), (3, 2)]:
    key = f"{lam[0]},{lam[1]}"
    cols = c.C["hw"][key]["cols"]
    ns = [[c.gq(x) for x in v] for v in c.C["hw"][key]["vecs"]]
    m = len(ns); want = c.dimB2(lam)
    us = [{cols[j]: v[j] for j in range(len(cols)) if v[j] != c.Z} for v in ns]
    words = c.word_list(us[0], want)
    if len(words) != want:
        print(f"lambda={lam}: word list short ({len(words)}/{want})"); continue
    ranks = set()
    for _ in range(25):
        co = [(F(random.randint(-9, 9)), F(random.randint(-9, 9))) for _ in range(m)]
        if all(x == c.Z for x in co): continue
        u = {}
        for i, x in enumerate(co):
            for k, v in us[i].items(): u[k] = c.cadd(u.get(k, c.Z), c.cmul(x, v))
        u = {k: v for k, v in u.items() if v != c.Z}
        ranks.add(c.rank_of(c.replay(u, words)))
    print(f"lambda={lam}  dim {want}  mult {m}: ranks over 25 random "
          f"multiplicity-space vectors = {sorted(ranks)}   "
          f"(the shipped check asks rank == {want})")
