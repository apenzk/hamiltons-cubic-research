# Reviewer 200, the repaired asserts, the prime change, and stage 4

Gate 2, adversarial. Cold brief [brief12.md]; the four claims postdate reviews 177-198. Scripts under [scripts/reviewers/r200/](../scripts/reviewers/r200/), log at [agent_logs/gate2_200.log](../agent_logs/gate2_200.log). Nothing under review was edited or executed; every reconstruction copies the code character for character into a reviewer script.

## Verdict table

| claim | verdict | the decisive fact |
|---|---|---|
| 1. the four asserts now pass, each can fail | **REFUTED in two parts** | there are **three** asserts, not four, "every weight block is square" is a `print`, never asserted. And `assert cross == 0` **cannot fail**: it passes a wholly random basis. |
| 1a. does the 60-pair sampling retain power? | **MOOT** | the sweep had no power to retain at any sample size, exhaustive included. |
| 2. 1000033 prime, 1 mod 4, unrelated, cache clean | **CONFIRMED on the facts, REFUTED on the reason** | prime, $1 \bmod 4$, and **0 of 826 486 coefficients** die mod it. But the stated cause of the 65537 failure is false, so the property that saved this prime is luck and is nowhere checked. |
| 3. the record's statement of the mod-p direction | **PARTLY WRONG** | the paragraph's one positive claim names an assert that was deleted 190 lines later; and it calls `cross` a screen when `cross` is a tautology no exact recomputation can rescue. `dis` is correctly labelled and does **not** need the exact version. |
| 4. stage 4, committed unrun | **WILL PRODUCE ALL-ZERO COORDINATES SILENTLY** | [run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py)'s `cube` keys its output by **monomial tuple**; `solve_weight` keys its row map by **monomial index**. `if k in mi` is false for all 6545 of them, the augmented column stays zero, and every sample returns $x = 0$ with no error. |

---

## Claim 1, `assert cross == 0` is a tautology, and one of the four is not an assert

### The count

[run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) contains three content asserts, at lines 278, 335 and 341, plus the `IMOD` sanity assert at line 94 and the denominator guard inside `to_p`. Squareness is line 220, a `print` of the boolean `square`, followed by a diagnostic `if not square:` that prints detail and lets the run continue. The claim's fourth assert does not exist, and [plan.md](../plan.md) already records the same check as vacuous, "a count, invariant under the multiplicity-basis choice ... it fires only when a vector is zeroed", in the very table that also lists it under **STAGE 3 RUNS CLEAN** as a passing assert. This is the pattern the same table names two rows later: documenting a defect is not fixing it.

### `cross == 0` cannot fail, the argument

The Gram $H$ on the 35 weight-basis vectors is built in [run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py) at line 85 by an explicit `if WT[a] != WT[b]: continue`, so no off-weight pair is ever stored. I confirmed the support exhaustively: 45 entries stored, **0** of them with `WT[a] != WT[b]`, and none stored as an exact zero. `sym3_ip` (line 160) then reads `H.get((t[i], s[perm[i]]))` and drops the whole permutation term when the lookup misses.

Take monomials $t, s$ with $\mathop{\mathrm{mwt}}(t) \ne \mathop{\mathrm{mwt}}(s)$. In any surviving permutation term all three factors $H_{t_i, s_{\pi(i)}}$ are present, hence $\mathrm{WT}[t_i] = \mathrm{WT}[s_{\pi(i)}]$ for each $i$, hence $\sum_i \mathrm{WT}[t_i] = \sum_j \mathrm{WT}[s_j]$, contradiction. So every term dies and $\mathrm{sym3\_ip}(t,s) = 0$ **exactly**, for every unequal-weight pair. Therefore `ip3(u, v) = 0` for any weight-homogeneous $u, v$ of distinct weight, **whatever their coefficients are**.

`cross == 0` is thus implied by `inhom == 0` composed with 45 lines of data. It is not even a mod-p screen, the vanishing is exact before reduction.

### The sabotage that confirms it

[vacuous_cross.py](../scripts/reviewers/r200/vacuous_cross.py) replaces every one of the 7770 adapted vectors with a dense random Gaussian-integer vector supported on the whole weight space its original occupied, then runs the shipped sweep verbatim:

```
RANDOM garbage basis: cross = 0 over 1330 entries -> assert PASSES
homogeneity on the same garbage: inhom = 0
```

I also ran the failure mode the file's own comment names (lines 227-234, the invariant **bilinear** Gram making $Q$ block-anti-diagonal) by dropping the conjugation from `ip3`. It gives `cross = 0` as well, and exhaustively over every cross-weight entry of $V(0,0)$, $V(1,0)$, $V(2,0)$ and $V(2,1)$ (676 entries), the bilinear version is zero everywhere too. Conjugating the coefficients is not what block-anti-diagonality would take; it would take a different $H$, and $H$ is fixed upstream.

### So the sampling question does not arise

For the record, the coverage numbers ([combi.py](../scripts/reviewers/r200/combi.py)): 1 318 354 cross-weight entries exist across the 24 blocks; the sweep evaluates 1330 of them, a fraction of $1.1\times10^{-3}$, at a fixed seed, so repeat runs inspect the same 1330 every time. Under a hypothetical anti-diagonal violation the per-block detection probability would run from $1.00$ at $V(1,0)$ down to $0.30$ at $V(6,6)$. All of that is moot: the quantity being sampled is identically zero.

`dis == 0` and `inhom == 0` are the two real asserts, and both can fail. `dis` fires at the **new** prime, [dis_fires.py](../scripts/reviewers/r200/dis_fires.py) transposes one same-weight pair inside copy 1 and gets 4, 4 and 6 disagreements at $\lambda = (2,0), (2,1), (3,0)$ against a clean 0. `inhom` fires on a single foreign monomial inserted into one vector.

---

## Claim 2, the prime is fine, the reason given for it is not

### The facts, confirmed

$1000033 = 10^6 + 33$ is prime (trial verified, `sympy.factorint` returns $\{1000033: 1\}$) and is $1 \bmod 4$. `IMOD` comes out **350504**, and $350504^2 \equiv -1$. Scanning all 826 486 stored coefficients of [n5_adapted.pkl](../scripts/runs/n5_adapted.pkl) ([scan_prime.py](../scripts/reviewers/r200/scan_prime.py)):

| scan | 65537 | 1000033 |
|---|---|---|
| $p$ divides a real or imaginary part's numerator | 1 | **0** |
| $p$ divides a denominator | 0 | **0** |
| the full Gaussian reduction $a + b\,\mathrm{IMOD}$ vanishes with $(a,b)\ne 0$ | 1 | **0** |

The third row is a scan reviewer 197 did not run and it is strictly stronger than the first: a coefficient with both parts nonzero and neither divisible by $p$ still reduces to zero whenever $a \equiv -b\,\mathrm{IMOD}$. At 65537 it finds the same single witness ($\lambda = (6,4)$, copy 0, position 787, monomial 56) and nothing new. At 1000033 both scans are empty.

### The reason in the file is false

Lines 87-91 say 65537 "divided the data" because $65537 = 2^{16}+1$ and "the cached coefficients are built from powers of two". Neither half survives contact with the cache.

- The **denominators** carry the powers of two, and their entire prime support across all 826 486 coefficients is $\{2, 3, 7\}$, 24 distinct values. `to_p` inverts denominators, so a denominator can never manufacture a false zero; it can only trip the guard, and it never does.
- The witness was a **numerator**: $701\,361\,681\,334\,272\,000 = 2^{24}\cdot 3^{6}\cdot 5^{3}\cdot 7\cdot 65537$. A number "built from powers of two" has no $3$, $5$, $7$ or $65537$ in it. 65537 is there as an ordinary large prime factor, exactly as $5^3$ is.
- **It is not rare.** 9794 distinct primes divide some stored numerator, 9178 of them below $10^6$, the largest being 162 215 671. In the window $(9\times10^5,\,1.1\times10^6)$, **681 of the 14 440 primes** divide some numerator, a $4.7\%$ hit rate. 1000033 missed. So did $95.3\%$ of its neighbours.

The operative property is not "unrelated to powers of two" and not "unrelated to the construction", it is "divides no numerator", and that is an empirical property of one cache file, not of the prime. Rebuilding the adapted basis (a different nullspace basis, a different word list) regenerates the numerators and restores the $4.7\%$ risk, silently, because **nothing in the pipeline checks it**.

### The cheap repair

The scan above is 0.5 s over all 826 486 coefficients if the 24 denominator inverses are memoised. It belongs in [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) immediately after `PRIME` is set, as an assert with a witness in the message, and the search that produces `IMOD` should be extended to reject a prime that fails it. That converts a lucky draw into a checked precondition at no cost. Running every verdict at a second independent prime, as 197 did by hand, is the complementary half.

### Stale text at the same site

`to_p`'s docstring (line 104) still says "with $i = 256$" and `ip3`'s (line 133) still says "$256 \to -256$". `IMOD` is 350504. The code is right and both docstrings are wrong.

---

## Claim 3, the mod-p paragraph is stale in its positive half and wrong about `cross`

Lines 96-101 say the reduction argument "supports the NONSINGULARITY assert, which passes on non-vanishing, and does NOT support the two zero-tests below".

- **The positive half names a deleted assert.** The nonsingularity assert and its control were removed at line 290 by reviewer 198. The paragraph's only sound-by-direction claim now refers to nothing in the file. What remains of that computation is the `det h` print at line 183, which does carry the non-vanishing direction ($\det h \not\equiv 0 \bmod p$ certifies $\det h \ne 0$ over $\mathbb{Q}$) but it is a print, so it certifies nothing automatically.
- **"the two zero-tests" is the right count** of the three surviving asserts: `inhom == 0` is exact combinatorics on monomial indices with no mod-p arithmetic anywhere in it, so it is correctly excluded, and it is sound over $\mathbb{Q}$ as it stands.
- **`cross` is misclassified.** Calling it a screen whose zero is "evidence pending the exact check" implies an exact check would add something. It would not: the vanishing is already exact, by the argument above, and holds for random garbage. A check with no error state is not a screen at any precision.
- **`dis` is correctly classified and does not need the exact version.** It performs 9568 ratio comparisons over 1503 probe positions. A single false agreement has probability $p^{-1}$; hiding a real violation requires *every* disagreement it would produce to vanish simultaneously, at $p^{-k}$. The total expected false-agreement count across the whole run is $9568/p = 0.0096$, against $0.146$ at the old prime, a tenfold improvement that is the actual benefit of the prime change. The `skipped` counter guards the other side: 1503 diagonal norms are tested for nonvanishing, expected spurious zeros $0.0015$, observed 0.

**Load-bearing?** No. `HMAT` is written at lines 176 and 182, printed at 183-184, read once at line 332 inside the `dis` loop, and never referenced again, the docstring's design (lines 13-16) deliberately arranges for $h$ to be absorbed into $G$, so $h$ is measured, self-checked, and discarded. `dis` earns its place as a basis-integrity check, not as a producer of anything downstream, and $p^{-k}$ is enough for that.

---

## Claim 4, what will break in stage 4

Stage 4 is 58 lines. What executes is the `IDX` loop, the `UNK` loop and two `print`s. `sample_weyl` and `solve_weight` are defined and **never called**, `IDX` is a second name for `BYW` built identically at line 60, and `UNK` is built and then unused. So "committed unrun" understates it: running the file to completion, which is reviewer 198's remedy, will not exercise either function.

Here is what each piece does when it is wired up. [stage4_break.py](../scripts/reviewers/r200/stage4_break.py) copies `solve_weight` and `sample_weyl` verbatim out of the file and runs them against the inputs the docstring names.

### 1. The key spaces do not meet, fatal, and silent

`solve_weight` builds `mi = {m: k for k, m in enumerate(mons)}` from `MONS[w]`, which holds monomial **indices** (`MONS.setdefault(mwt(idx), []).append(idx)` over `range(len(MONO))`). The adapted vectors are keyed by index too, so the basis columns fill correctly. The target does not: the only thing in the pipeline that produces $W^3$ is `cube` in [run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py) (line 216), and it keys its output by the monomial **tuple**, `out[t] = z` over `for t in MONO`.

```
a key of cube(w): (0, 0, 0)  type tuple
a key of an adapted vector: 7769  type int
keys of cube(w) that are in MONS' index space: 0 of 6545
```

`if k in mi` is therefore false 6545 times out of 6545. The augmented column stays all zeros, the elimination runs, and `x` comes back all zeros, for every weight and every sample, with no exception raised. The witness is weight $(-6,-6)$, where the true restriction of $W^3$ is a single nonzero monomial and the shipped solve returns `[0]`. Downstream, $B_{ij} \equiv 0$, the coefficient matrix is zero, and "rank exactly 14" reports 0 with nothing to point at the cause.

### 2. The target is never reduced, fatal, and currently masked by defect 1

Repair the key space and the next line fails: `A[mi[k]][n] = cv % PRIME` where `cv` is a `(Fraction, Fraction)` pair.

```
with the key space repaired (tuple -> index):
   raises TypeError: unsupported operand type(s) for %: 'tuple' and 'int'
```

Every other coefficient in the matrix goes through `to_p`; the target does not. A `G` object would raise the same way, `G` defines no `__mod__`. And if the target ever arrives as a bare `Fraction`, Python's `Fraction.__mod__` returns a `Fraction` (`Fraction(9,16) % 1000033` is `9/16`) so that variant is silently wrong rather than a crash. The line wants `to_p(cv)`.

With both repaired the solve is correct: at weight $(-6,-6)$ it returns `[844398]` and the expansion reproduces the target on 1 of 1 monomials.

### 3. No solvability check, the failure mode that will not announce itself

`solve_weight` pivots only over `c in range(n)` and never inspects the augmented column afterwards. If the weight block is rank-deficient it sets the free coordinates to 0 and returns one arbitrary member of an affine family, and if the system is inconsistent it returns a vector that does not expand the target, in both cases with no signal. The file's `square` print is a **count** check, necessary and far from sufficient; independence is never tested.

I measured it: all **169** weight blocks are nonsingular mod $p$, 0 deficient, 12 s for the sweep. So the assert would pass today. That is the argument for adding it, not against, `assert r == n` and `assert all(A[t][n] == 0 for t in range(r, len(A)))` cost nothing and are the only thing standing between a corrupted cache and a plausible-looking $B$.

### 4. "89 Hermitian unknowns" is the right count for the wrong reason mod p

$\sum_\lambda m_\lambda^2 = 89$ over the 24 blocks with multiplicities $(1,1,2,2,4,2,2,3,1,2,2,4,2,2,1,1,2,1,1,1,1,1,1,1)$, so `len(UNK)` will print 89. But `UNK` tags its entries `"re"` and `"im"`, and those are not obtainable from `ip3`. `ip3` returns the single residue $\mathrm{Re} + \mathrm{IMOD}\cdot\mathrm{Im}$, and $p \equiv 1 \bmod 4$ collapses $\mathbb{Q}(i)$ onto $\mathbb{F}_p$, so the two parts are unrecoverable from one call. Expanding $\sum_{ij} G_{ij}B_{ij}$ with $G$ Hermitian gives row coefficients $2\,\mathrm{Re}\,B_{ij}$ and $-2\,\mathrm{Im}\,B_{ij}$; both need the conjugate entry $B_{ji} = \mathrm{ip3}(c^j, c^i)$ as well, and then $\mathrm{Re} = (B_{ij}+B_{ji})/2$, $\mathrm{Im} = (B_{ij}-B_{ji})(2\,\mathrm{IMOD})^{-1}$. That doubles the $B$ work and appears nowhere. The trap is that the unknown **count** is $m^2$ either way, so building the row from one `ip3` value per pair produces a system of the right shape and the wrong content.

[run_n5_certificate.py](../scripts/runs/run_n5_certificate.py) states the same hazard in its header and resolves it the other way: "the mod-p verdict transfers to $\mathbb{Q}$ only because `random_weyl` is a purely rational construction and this script carries (re, im) separately; collapsing the Gaussian part first would void it." `to_p` performs exactly that collapse. Stage 4 owes an argument that the relaxed system it will actually solve mod $p$ has the rank it attributes to the Hermitian one, or it must carry the parts separately as the certificate does.

### 5. "rank exactly 14" and the consistency test are one test, not two

If the $B_{ij}$ are invariant sextics and $F_5$ is an invariant sextic, both premises the record establishes elsewhere, the 14 confirmed independently in [run_n5_sextic_basis.py](../scripts/runs/run_n5_sextic_basis.py), then $\mathop{\mathrm{rank}}(A) = 14$ means the $B_{ij}$ span the whole space, so $F_5$ lies in the span and $\mathop{\mathrm{rank}}[A \mid F_5] = 14$ **necessarily**. The consistency test the docstring calls "the test with real content" cannot fail once rank 14 is observed; it acquires content only in the case rank $< 14$. Demanding both, as lines 22-28 do, is demanding one. And the direction that matters is only half available mod $p$: $\mathop{\mathrm{rank}}_p \le \mathop{\mathrm{rank}}_{\mathbb{Q}}$, so rank 14 mod $p$ certifies $\mathop{\mathrm{rank}}_{\mathbb{Q}} \ge 14$ soundly, while "never more than 14" is precisely what reduction cannot certify. Inconsistency mod $p$ does refute over $\mathbb{Q}$; consistency mod $p$ is a screen.

Separately, note that 14 is doing double duty in this file: the widest $Q$ weight block is also 14, attained at $V(6,3)$ and $V(6,4)$ and unrelated to the sextic count. Nothing depends on the coincidence, but the docstring reads as though it might.

### 6. Two comments that contradict each other and the code

Line 251 says `# blocks discarded; rebuilt per sample point` while lines 236-240, fifteen lines above, say Q **is** retained in full in `QWIDTH` and explain why `del blocks` does not free it. `QWIDTH[lam] = blocks` is on the very next line. Stage 4 must read `QWIDTH`; `QB[lam][1]` is `None` and will fail on whoever trusts the nearer comment.

And "each block is factored ONCE and every sample point is a back-substitution" (lines 210-211) does not describe `solve_weight`, which rebuilds $A$ with a fresh `to_p` on every entry and runs a full elimination on every call. That is $\sum_w n_w^2 = 921\,780$ modular inversions and $\sum_w n_w^3 = 142\,915\,872$ row-operation steps **per sample point**, I measured 12 s per pass over the 169 weights. Factoring once, as the comment describes, is a one-off 12 s and a back-substitution per sample.

### 7. Both `random` aliases are the same module

`import random` (line 35), `import random as _rnd` (265) and `import random as _r2` (350) bind one module object. `_r2.seed(17)` resets the same global generator `_rnd.seed(11)` set, so the cross sweep and the sampler share a stream despite the naming. Harmless in the present order (the sweep completes before line 350) and a live hazard the moment anything is interleaved or re-run.

---

## What I recommend, in order

1. **Delete `assert cross == 0`** or move it to where it has content. The falsifiable version already exists and already runs, on $H$ itself, in [run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py) lines 99-112. The comment at line 260 ("Reviewer 191 forced this repair on H and it was never carried across here"), misreads what carrying it across would mean: at the Sym$^3$ level the fact is a consequence, not an independent measurement, and the attempt to measure it is what drove the memory blowup, the 2 GB cache cap and the sampling.
2. **Assert what the squareness print only reports**, and make it a rank rather than a count, [plan.md](../plan.md) already records that the count passes a duplicated vector and `copy 1 := copy 0`.
3. **Assert the prime's fitness**: no stored coefficient reduces to zero. 0.5 s, and it is the property the prime was actually chosen for.
4. **Fix the two stage-4 defects before running it**, in this order: `TIDX = {t: i for i, t in enumerate(MONO)}` on `cube`'s output, then `to_p(cv)` in place of `cv % PRIME`. Add `assert r == n` and the consistency check on the augmented column.
5. **Correct the four stale comments**: `i = 256` twice, the deleted nonsingularity assert, the false powers-of-two diagnosis, and `blocks discarded; rebuilt per sample point`.

## What I could not do

The full [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) run was not repeated, the brief forbids editing or killing it and the main session owns it. Every number above comes from the cached basis and from verbatim copies of the file's own functions, so the reconstruction is exact but it is a reconstruction. The one claim I take on the record's word is that the shipped run printed `cross = 0`, `dis = 0`, `skipped = 0` and `inhom = 0`; my reconstruction reproduces all four.
