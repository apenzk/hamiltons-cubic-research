# Review r198, the nonsingularity control, and the cache

Audited at HEAD `9467c6c` plus the working tree, which changed three times while this review ran (`18c15f3`, `04e93f2`, `9467c6c`). Priority as briefed: claim 2, then claim 4; claims 1 and 3 are reported where my probes touched them.

Scripts: [scripts/reviewers/r198/](../scripts/reviewers/r198/), [probe.py](../scripts/reviewers/r198/probe.py), [sabotage2.py](../scripts/reviewers/r198/sabotage2.py), [probe0.py](../scripts/reviewers/r198/probe0.py).

## Verdict table

| # | Claim | Verdict | Ships with a control? | Is the control real? |
|---|---|---|---|---|
| 2 | h nonsingular, controlled by coincident copies | **Refuted** | yes | **no, and no control of this shape can be** |
| 4 | the count assert guards the cache | **Refuted** | no |, |
| 1 | mod-p screening is one-sided the safe way | **Refuted for three of the four asserts** | no |, |
| 3 | probes 1..3 exercise the word list | **Upheld, with a bounded blind spot** | yes (`dis == 0`) | yes, but it sees t ≤ 3 of up to 810 |

---

## Claim 2, the control is not real, and the assert it guards cannot fail either

The brief's diagnosis of the old control is right, and the repair committed as `04e93f2` does not fix it. Two independent facts, and the second is the one that matters.

### The rewritten control is still the constant matrix

The shipped control now reads

```python
_dup = [ADAPTED[_lam][0], ADAPTED[_lam][0]]          # copy 0 twice
_q = ip3(_dup[0][0], _dup[0][0]); _inv = pow(_q, PRIME-2, PRIME)
_ctl = [[ip3(_dup[i][0], _dup[j][0]) * _inv % PRIME for j in range(2)] for i in range(2)]
```

`_dup[0]` and `_dup[1]` are the same object, so all four calls are the single call `ip3(c0[0], c0[0])`, and `_ctl` is `[[1,1],[1,1]]` as an algebraic identity, for any `ip3` whatsoever with `ip3(x,x) != 0`. It is the same rank-1 literal the brief flagged, reached through four redundant function calls. Measured over all 24 blocks, `HMAT[lam][0][0]` takes the single value `1`, so the pre-`04e93f2` version was `[[1,1],[1,1]]` too: the rewrite changed the code path and left the matrix bit-identical.

### No control of this shape can have an error state

I built five stronger candidates, a deep copy, a rescaled copy `[c0, 3*c0]`, a complex-rescaled copy `[c0, i*c0]`, a dependent triple `[c0, c1, c0+c1]`, and `[c0, c1, i*c0+3*c1]`, and ran each against a bank of deliberately broken `ip3` variants ([sabotage2.py](../scripts/reviewers/r198/sabotage2.py)):

| control | correct | no conjugation | swapped `sym3_ip` args | `ip3 := 12345` |
|---|---|---|---|---|
| SHIPPED `[c0, c0]` aliased | 0 | 0 | 0 | 0 |
| `[c0, deep-copy of c0]` | 0 | 0 | 0 | 0 |
| `[c0, 3*c0]` | 0 | 0 | 0 | 0 |
| `[c0, i*c0]` | 0 | 0 | 0 | 0 |
| `[c0, c1, c0+c1]` | 0 | 0 | 0 | 0 |
| `[c0, c1, i*c0+3*c1]` | 0 | 0 | 0 | 0 |
| POSITIVE: the block as built | 8001 | 6108 | 56360 | 0 |

The reason is a theorem, not an accident. Write the copy list as `R_i = sum_a A_ia e_a` over any spanning set. Then `h_ij = <R_i, R_j> = (A* K A)_ij` for the Gram `K` of that set, so `rank(h) <= rank(A)`. A degenerate copy list has `rank(A) < m`, hence `det h = 0`, for **any** bi-additive form `K`, correct or corrupted. A negative control built by degenerating the copy list therefore confirms that `det_p` returns 0 on a singular matrix, and confirms nothing about `ip3`, the metric, or the adapted basis. This is why the whole first column is 0 and why every defect column is 0 with it.

### The assert being controlled is itself tautological on any live build

`words[0]` is the empty word, so `R_i[0] = u_i`, the raw highest-weight vector. I verified this holds in **41/41 copies** ([probe0.py](../scripts/reviewers/r198/probe0.py)). The `u_i` come from `nullspace_G`, which returns a *basis* of the multiplicity space, linearly independent by construction. So `h` at probe 0 is the Gram of a linearly independent set under a definite form, and `det h != 0` is a restatement of "`nullspace_G` returned a basis". The assert on line 251 has no error state reachable by the live pipeline.

Its one genuine error state is a **corrupted cache**, which is claim 4's threat model: planting `ADAPTED[(2,1)][1] := ADAPTED[(2,1)][0]` in the pickle gives `det h = 0` and the assert fires. That is the honest scope of the check and it should be documented as such.

### What to ship instead

- Say in the comment that `det h != 0` at probe 0 restates the independence of the nullspace basis, so its power is confined to detecting a corrupted or stale cache.
- Move the nonsingularity assert to a probe `t > 0`, where `h` depends on the word list and can genuinely degenerate. The control is then a copy list replayed through a deliberately degenerate word list, a control with an error state, because a bad word list does *not* automatically make `h` singular.
- Keep positive-definiteness over Q as the real refinement at the final verification, as 195 and the current comment already say.

---

## Claim 4, the count assert has zero discriminating power

`assert n == 7770` cannot distinguish any two pickles this pipeline could ever produce.

**7770 is a constant of the problem.** The weight module is 35-dimensional and `35 * 36 * 37 / 6 = 7770 = dim Sym^3`. The block decomposition accounts for that dimension exactly, so `sum_lambda m_lambda * dim V(lambda) = 7770` holds for the correct answer and for every superseded run that got the *shape* right, which is every run, since the shape comes from the representation theory and no code change perturbs it. The assert's pass set contains every version of the cache that has ever existed.

Three concrete corruptions, all at count 7770, all passing the cache assert ([probe.py](../scripts/reviewers/r198/probe.py) section C):

| corruption | cache assert | caught downstream? |
|---|---|---|
| block (2,1) copy 1 := copy 0 (genuine coincidence) | passes | yes, `det h = 0` |
| block (5,0), m=1, vector at position 7 doubled | passes | **no**, m=1 blocks get `h = [[1]]` by fiat and are skipped by the multi-probe loop |
| block (2,1), m=2, copy 0 position 7 doubled | passes | **no**, see below |

The third is the sharpest. Every shipped check passes on it: `det h` (probe 0) `= 27394`, unchanged; multi-probe disagreements `= 0`; weight-inhomogeneous vectors `= 0`; `Q` still block-diagonal. Yet `h` computed at probe 7 is `[[1, 72], [65465, 34433]]` against the shipped `[[1, 144], [65393, 6658]]`, the copy identification is broken and `Q`, read off copy 0, is wrong at that weight. The corruption is invisible because it sits outside the `t = 1..3` window.

**Two aggravating factors, both observed in a real run** ([assemble_out.txt](../scripts/reviewers/r198/assemble_out.txt)):

- The cache path skips the only structural validation there is. On a rebuild, [run_n5_adapted.py](../scripts/runs/run_n5_adapted.py) checks that the word list spans the block (`len(words) != want`) and that every replayed copy stays independent (`r != want`), the check its own comment calls the one that "would show up here and nowhere else". On the cache path neither runs, and the summary line prints `blocks with a shared word list spanning every copy: 0/0`, which reads as success and is vacuity.
- The pickle is **rewritten on every load**. Lines 136–141 run unconditionally, so a run that read the cache immediately writes it back (`cached to n5_adapted.pkl: 26 MB`). The mtime (the only provenance the file carries), is destroyed on every use, so a stale cache is refreshed into looking current.

There is also a live instance of the hazard in the tree right now: [run_n5_highest_weight.py](../scripts/runs/run_n5_highest_weight.py), which is upstream of the pickle, has uncommitted changes (adding `wbasis_tensors` to its own JSON cache) and nothing links the two.

### What to ship instead

- Stamp the pickle with a SHA-256 over the source text of [run_n5_adapted.py](../scripts/runs/run_n5_adapted.py) and [run_n5_highest_weight.py](../scripts/runs/run_n5_highest_weight.py) *and* over the `HW` nullspace vectors it was built from; on load, recompute and rebuild on mismatch. That is the only check that separates a current cache from a superseded one.
- Assert `R_i[0] == u_i` against a freshly loaded `HW` on the cache path. It is 41 dict comparisons, it ties the pickle to the current upstream, and it has a genuine error state, it is exactly what my [probe0.py](../scripts/reviewers/r198/probe0.py) runs.
- Re-run the per-copy independence check on the cache path. It is one `reduce_full` pass over 7770 vectors.
- Skip the rewrite when the cache was loaded, so mtime keeps meaning something.

---

## Claim 1, the mod-p justification is backwards for three of the four asserts

The file argues that "a screen that is wrong mod p is wrong over Q too". The sound statement is narrower, and it depends on the *direction* of the assert:

- **"this quantity is NONZERO"**, nonzero mod p implies nonzero over Q. Sound. This covers `assert not sing`.
- **"this quantity is ZERO"**, zero mod p does **not** imply zero over Q. A false pass is possible. This covers `assert cross == 0`, `assert dis == 0`, and `assert det_p(_ctl) == 0`.

Three of the four asserts are of the unsound form. `dis == 0` runs roughly 231 comparisons (12 multiplicity blocks, 3 probes, `m^2` each), each of which false-passes with probability about `1/65537` on a genuinely nonzero disagreement; `cross == 0` runs several thousand. The fix is one line: repeat the two zero-tests at a second prime.

On `to_p` and denominators divisible by 65537, there is **no guard**, and `pow(0, PRIME-2, PRIME)` returns `0`, so such a coefficient silently reduces to the wrong residue rather than raising. I scanned all **826,486** coefficients in the adapted basis: **0** have a denominator divisible by 65537, so the hazard does not currently fire, but it is one `assert a.denominator % PRIME` away from being impossible instead of merely lucky.

---

## Claim 3, the multi-probe check is sound and narrow

Probes `t = 1, 2, 3` all have `q != 0` and all sit at weights **distinct from probe 0** in all 12 multiplicity blocks ([sabotage2.py](../scripts/reviewers/r198/sabotage2.py) tail); e.g. block (2,2) runs `(2,2) -> (2,1) -> (1,2) -> (2,0)`. So the check does escape 195's probe-(0,0) blindness, and it is a real check with a real error state.

Its limit is coverage: `range(1, min(4, ...))` reads 3 positions out of copies that are up to 810 vectors long. Corruption 3 above is a witness, a defect at position 7 of a 35-vector copy that every shipped assert passes. Widening to a random sample of positions per block would cost little and close it.

---

## What was found and fixed while this review ran

Three defects in the same class were live when I started and were repaired by the parallel session mid-review; I confirmed each independently before the fix landed:

- `det_p` used at line 139 and defined at line 228, `NameError`, so every assert after the `h` loop was unreachable (`18c15f3`).
- `_ctl = [[HMAT[l][0][0] ...]]`, `l` is bound only inside two comprehensions, which do not leak in Python 3, so this was a second `NameError` (`04e93f2`). I reproduced it in isolation before the fix.
- `to_p` unpacking a `G` object, `TypeError: cannot unpack non-iterable G object`, reproduced in my own run of [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) at [assemble_err.txt](../scripts/reviewers/r198/assemble_err.txt). The mod-p path had never executed at all.

The pattern is worth naming: three separate unreachable-code defects in one file, each of which made the asserts that were being advertised as the enforcement mechanism not run. A single `python3 scripts/runs/run_n5_assemble.py` to completion, required before any claim about an assert, would have caught all three.
