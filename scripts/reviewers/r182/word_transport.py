"""Claim 2c: is "the SAME lowering words" a well-defined equivariant
identification of copy i with copy j, and can a word kill one copy's vector
but not another's?

THEORY.  u_i, u_j are highest weight vectors of the same weight lambda inside a
finite-dimensional module M.  U(g)u is a highest weight module of weight
lambda; it is a submodule of a completely reducible module, so it is a direct
sum of irreducibles, and a highest weight module has a unique maximal proper
submodule, hence a unique irreducible quotient -- so U(g)u = L(lambda).  The
map U(n^-) -> L(lambda), X -> X.u, is therefore surjective with kernel the
preimage of the maximal submodule N(lambda) of the Verma M(lambda) under the
U(n^-)-module isomorphism U(n^-) = M(lambda).  That kernel is J(lambda), a
function of lambda ALONE.  Hence Ann(u_i) = Ann(u_j) and X.u_i -> X.u_j is
well defined and equivariant.  A word cannot kill one copy and spare another.

TEST, in the real n=5 data.  Take a block with multiplicity >= 2, run the
record's BFS on copy 1 recording the words, transport that word list to copy 2,
and check (a) it is still a basis, (b) every word that annihilates copy 1's
vector annihilates copy 2's, over an exhaustive sweep of short words.
"""
import importlib.util, sys, os, time, itertools

d = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
spec = importlib.util.spec_from_file_location("hw", os.path.join(d, "run_n5_highest_weight.py"))
hw = importlib.util.module_from_spec(spec)
_o = sys.stdout; sys.stdout = open(os.devnull, "w")
spec.loader.exec_module(hw); sys.stdout = _o
ZERO, ONE = hw.ZERO, hw.ONE
MONO, MIDX, WWT, HW = hw.MONO, hw.MIDX, hw.WWT, hw.HW
print(f"loaded n=5 module: {len(MONO)} monomials, {sum(len(v[1]) for v in HW.values())} hw vectors", flush=True)

RV1m, RV2m = hw.root_vector(-1, 1), hw.root_vector(0, -1)
F1 = hw.lin({k: RV1m[k] for k in range(10) if RV1m[k]})
F2 = hw.lin({k: RV2m[k] for k in range(10) if RV2m[k]})
F1C = hw.to_weight_coords([hw.apply(F1, v) for v in hw.WBASIS])
F2C = hw.to_weight_coords([hw.apply(F2, v) for v in hw.WBASIS])
OPS = [F1C, F2C]

def lower(vec, EC):
    out = {}
    for idx, co in vec.items():
        a, b, c = MONO[idx]
        for pos, x in enumerate((a, b, c)):
            rest = [y for j, y in enumerate((a, b, c)) if j != pos]
            for t in range(35):
                if EC[x][t]:
                    j = MIDX[tuple(sorted(rest + [t]))]
                    out[j] = out.get(j, ZERO) + co*EC[x][t]
    return {k: v for k, v in out.items() if v}

def apply_word(u, word):
    v = u
    for oi in word:
        v = lower(v, OPS[oi])
        if not v: return {}
    return v

def reduce_full(v, ech):
    """iterated leading-term reduction -- the fix claim 3 is about."""
    w = dict(v)
    while w:
        piv = max(w)
        if piv not in ech: break
        f = w[piv] / ech[piv][piv]
        for k, c in ech[piv].items(): w[k] = w.get(k, ZERO) - f*c
        w = {k: c for k, c in w.items() if c}
    return w

def rank_of(vecs):
    ech = {}
    r = 0
    for v in vecs:
        w = reduce_full(v, ech)
        if w: ech[max(w)] = w; r += 1
    return r

def words_basis(u, cap):
    """BFS recording the WORD of each new independent vector -- the record's
    words_from, with the iterated reduction the echelon fix installed."""
    ech, words = {}, []
    frontier = [([], u)]
    while frontier and len(words) < cap:
        nxt = []
        for word, v in frontier:
            w = reduce_full(v, ech)
            if not w: continue
            ech[max(w)] = w; words.append(word)
            for oi in range(2):
                nv = lower(v, OPS[oi])
                if nv: nxt.append((word + [oi], nv))
        frontier = nxt
    return words

def dimB2(l): return (l[0]-l[1]+1)*(l[0]+l[1]+2)*(2*l[0]+3)*(2*l[1]+1)//6

MULT = {l: len(HW[l][1]) for l in HW}
targets = sorted([l for l in HW if MULT[l] >= 2], key=dimB2)[:3]
print(f"blocks with multiplicity >= 2, smallest three: "
      f"{[(l, dimB2(l), MULT[l]) for l in targets]}", flush=True)

for lam in targets:
    cols, ns = HW[lam]
    want = dimB2(lam); m = len(ns)
    U = [{cols[j]: v[j] for j in range(len(cols)) if v[j]} for v in ns]
    t0 = time.time()
    W1 = words_basis(U[0], want)
    print(f"\nlambda={lam} dim {want} mult {m}: words from copy 1: {len(W1)} "
          f"(want {want})  [{time.time()-t0:.0f}s]", flush=True)
    # (a) transport the SAME word list to every other copy
    for i in range(m):
        vecs = [apply_word(U[i], w) for w in W1]
        nz = sum(1 for v in vecs if v)
        r = rank_of(vecs)
        print(f"  copy {i}: {nz}/{len(W1)} words give a nonzero vector, "
              f"rank {r} (want {want})  -> basis: {r == want}", flush=True)
    # (b) exhaustive short-word sweep: does any word kill one copy and not another?
    mism = 0; tested = 0
    for L in range(0, 8):
        for word in itertools.product(range(2), repeat=L):
            tested += 1
            z = [not apply_word(U[i], list(word)) for i in range(m)]
            if len(set(z)) > 1:
                mism += 1
                if mism <= 3: print(f"    !! word {word} kills {z}")
    print(f"  words of length <= 7 swept: {tested}; "
          f"annihilation pattern differs between copies in {mism} of them", flush=True)
