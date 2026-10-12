# Gate 2 review r210 -- "rank = 13 EXACTLY"

Reviewer 210. Brief: brief16. Commits under review: 304d7ca, f2eeda4, 584c9c9.
Assigned priority: claims 3 and 4, then 5 and 6. Reviewer 209 runs claims 1-2 concurrently.

## Verdict table

| # | Claim | Verdict |
|---|---|---|
| 3 | The vanishing diagnostic: is 0/47 at W_0 sufficient for "the restriction is K"? | **UPHELD over Q, with the sufficiency argument SUPPLIED -- the file only records the necessary direction. REFUTED as implemented mod p: a witness T with 0/47 that is not K is constructed** |
| 4 | dim ANN = 1 and the conclusion chain | **UPHELD -- every link holds, F_5(W_0) = 0 is exact over Z. But r207's correction was applied to the docstring of run_n5_necessary.py and NOT to its stdout, which still prints the refuted sentence** |
| 5 | The 25/16/47 bookkeeping and the TR shape assert | **UPHELD in full** -- every count recomputed from the run's own ADAPTED, the rank-one structure verified at every position, and the 11 'gauge' directions confirmed to add no rank, which closes claim 4's open gap |
| 6 | Plants | **the vanishing diagnostic FAILS the hardest plant** -- an isotropic shift of T reads 0/47, keeps rank 13, and passes every assert while not being K. Three further plants slip; four are caught |

---

## Claim 3 -- the vanishing diagnostic

### What the diagnostic is, and what the file argues

[run_n5_assemble.py:1028-1034](../scripts/runs/run_n5_assemble.py#L1028) states the diagnostic's warrant as:

> Every restricted sextic is a sum of squares of cubics that vanish on the orbit, so ALL of them must vanish at W_0.

That is the **necessary** direction only: correct restriction implies a zero row. The file never states why a zero row implies the restriction is K, which is exactly what the brief asks and what the run uses the diagnostic for.

### The sufficiency argument, which does hold (over Q)

Three steps, each provable from what the record already has.

1. **The rank-one structure is a theorem, not an observation.** The copy-i component of the lambda-isotypic projection of W^3 is an equivariant cubic map R_i : Weyl_5 -> V_lambda. W_0 is H-fixed, so R_i(W_0) lies in V_lambda^H, which is one-dimensional for lambda_2 even (the record's mod-p Gram rank 3570 meeting its cap). Hence R_i(W_0) = a_i xi for a single xi, i.e. x_{i,t} = a_i b_t -- rank one in (copy, position), with the ratios across copies independent of t. This justifies reading u at one position t, and it is a consequence rather than a coincidence.

2. **The restricted space is an O(5)-SUBMODULE, so point-vanishing upgrades to orbit-vanishing for free.** TR touches only the COPY index and leaves the position index whole, so the restricted cubics are V_lambda tensor rowspace(T), an O(5)-submodule U. For f in U and any g, f(g W_0) = (g^{-1} f)(W_0), and g^{-1} f is again in U. So *U vanishes at W_0 <=> U vanishes on the whole orbit.* This is the step the brief asks for and it is clean. Concretely: q_{a,t}(W_0) = q_a b_t with q = T a, so vanishing at W_0 across all positions t already forces q = 0.

3. **Zero row plus full row rank pins the subspace exactly.** H_ab(W_0) = c q_a conj(q_b), so over Q(i) -- where c = b* Q b > 0 and z conj(z) is definite -- a zero row gives q = T a = 0, i.e. rowspace(T) is contained in the annihilator a^perp. T's rows are e_i - (a_i/a_k) e_k for i != k, which are independent, so rowspace(T) has dimension m-1 = dim a^perp and the containment is equality. **The restriction is K.**

So the claim is right, and the reason is not the one the file gives.

### Where it fails as implemented: mod p the diagnostic is not sound

Script: [claim3_isotropy.py](../scripts/reviewers/r210/claim3_isotropy.py). The run does the diagnostic in pair arithmetic mod `PRIME = 1000033`, and 1000033 = 1 mod 4, so -1 is a square and **Z/p[i] splits as Z/p x Z/p**. Writing z = (re, im) as (alpha, beta) = (re + I im, re - I im), conjugation SWAPS the two components, so

    z conj(w) = (alpha_z beta_w, beta_z alpha_w).

Two consequences, neither excluded by any assert in the file:

- **Isotropy.** Any q whose components all lie in the line beta = 0 satisfies q_a conj(q_b) = 0 for every a, b. So H(W_0) vanishes identically with q = T a NONZERO. The script builds an explicit witness at m = 3 on the run's own prime: taking T' = T + delta (x) s with delta in the isotropic line gives T' a = [(453462, 7), (813815, 28)] != 0 while every entry of H(W_0) = q' q'* is zero. **A T that reads 0/47 and is not K.**
- **A vanishing block constant.** c = b* Q b is a sum of squares mod p and can be 0 outright; in that block the diagnostic reads zero for EVERY T, K or not.

Over Q(i) both are impossible -- the argument in step 3 uses positive-definiteness, which is exactly the property reduction mod p destroys. The file's `_scan_prime` guards the cached coefficients against a false zero; nothing guards the diagnostic itself.

### How much this costs the theorem

Less than it first appears, and the reason should be recorded rather than assumed:

- T is *constructed* to satisfy T u = 0 and that is asserted directly at [run_n5_assemble.py:1009](../scripts/runs/run_n5_assemble.py#L1009), independently of the diagnostic. So the isotropy gap does not let a wrong T through the construction; it lets a wrong *u* through -- the diagnostic is the only check that the u read at a single position t is the true expansion vector a.
- The cap rank <= 13 is safe either way: it follows from K-membership by the order-1 argument of [run_n5_order2.py](../scripts/runs/run_n5_order2.py), not from the mod-p row.
- **Robustness worth stating:** even a restriction that is a PROPER subspace of K still proves the conclusion. If rowspace(T) is contained in a^perp, the image of Sym^2 of that subspace is contained in the image of Sym^2(K), so a sampled rank of 13 forces dim image(K) >= 13, and the cap forces = 13. The route only breaks if rowspace(T) is NOT contained in a^perp -- which is what the mod-p diagnostic can miss.

### Recommendation

Replace the diagnostic's warrant with the submodule argument above, and make the mod-p check faithful by testing q = T a and c = b* Q b directly (both are already computed) rather than testing the products q_a conj(q_b), which is the only quantity of the three that can vanish spuriously mod p.

---

## Claim 4 -- dim ANN = 1 and the conclusion chain

Four links. All four hold; one is stated wrongly where a reader will see it.

### (a) Is A(W_0^6) definitely in ANN? YES, and the file's *current docstring* gives the right reason

ANN = {F invariant sextic : Cat_F(K, K) = 0}, and for a sixth power

    Cat_{A(v^6)}(f, g) = integral over O(5) of f(g v) g(g v).

At v = W_0 each integrand factor vanishes because every f in K vanishes on the **whole orbit**, not merely at the point -- so the integral is zero term by term and A(W_0^6) is in ANN. This is exactly the reason [run_n5_necessary.py](../scripts/runs/run_n5_necessary.py) now carries after 584c9c9, and it is correct. r207's objection -- that the catalecticant is the orbit average, of rank 3570, not the rank-one form (f,g) |-> f(W_0) g(W_0), which is not even O(5)-invariant and so is the catalecticant of no invariant sextic -- is also correct, and is orthogonal to the conclusion.

**A(W_0^6) is nonzero**, which the chain needs and no file states: <F, A(W_0^6)> is proportional to F(W_0), and the invariant |W|^6 takes the value 1 at W_0, so the functional is nonzero on the 14.

### (b) The repair did not reach the output -- the refuted sentence is still printed

584c9c9 rewrote the docstring paragraph. It left [run_n5_necessary.py:125-126](../scripts/runs/run_n5_necessary.py#L125) untouched, and that is a `print`. Running the file today emits:

> ONE coincidence is known: A(W_0^6), whose catalecticant is (f,g) |-> f(W_0) g(W_0) and which kills K x K.

which is verbatim the claim r207 refuted and the commit message says was removed. The file contradicts itself again, in the opposite direction from before: the docstring is now right and the stdout is wrong. This is the same class of defect the project has hit repeatedly (docstring describes checks the code does not run; r208's print that should have been an assert), and it is the worse half, because stdout is what a reader of the run sees. **Repair: delete "whose catalecticant is (f,g) |-> f(W_0) g(W_0) and" and print the orbit-vanishing reason instead.**

### (c) Does dim ANN = 1 plus A(W_0^6) in ANN give ANN = span{A(W_0^6)}? YES

A nonzero vector in a one-dimensional space spans it. The only content is that A(W_0^6) != 0, established in (a). No further argument is needed and none is missing.

The link that carries the weight is the one before it: rank 13 => dim ANN = 1. That is sound as a chain -- ANN is by definition the annihilator inside the 14 of the image of the restricted certificate map, so dim ANN = 14 - dim image; the sampled mod-p rank is a lower bound for dim image and the order-1 argument is an upper bound of 13, so dim image = 13 exactly. **Two inputs are imported rather than re-derived here:** dim (Sym^6 Weyl_5)^{O(5)} = 14, and the attained-cap monotonicity (claim 1, reviewer 209).

**One gap I could not close from the code, carried to claim 5:** the sampled matrix has **47** columns (Hermitian), while ANN is the annihilator of the image of Sym^2(K), whose parameter space is the **36** real symmetric directions. If the 11 antisymmetric-imaginary directions are genuinely gauge -- map to the zero sextic -- the two ranks coincide and the chain is intact. If they are not, the measured 13 is a rank on a *larger* parameter space, dim ANN could exceed 14 - 13, and "the family is 36 - 13 = 23" would not follow. Tested under claim 5.

### (d) Is F_5(W_0) = 0 exact over Q? YES -- over Z, in both conventions

Script: [claim4_f5_at_w0.py](../scripts/reviewers/r210/claim4_f5_at_w0.py). Exact rational arithmetic, on the same W_0 tensor [run_n5_assemble.py:948](../scripts/runs/run_n5_assemble.py#L948) feeds the sampler:

| quantity | value |
|---|---|
| tr(S^2), tr(S^3) with S = sqrt6 W_0 on Lambda^2 R^5 | 6, 6 |
| Lambda^2 normalisation: 3/2 abs(W_0)^6 - 9 tr(W_0^3)^2 | **0** |
| q = W_abcd W_abcd on the rank-4 tensor | 24 = 4 tr(S^2) |
| t3 = tr(M^3), M = W reshaped 25 x 25 | 48 = 8 tr(S^3) |
| [run_n5_certificate.py:169](../scripts/runs/run_n5_certificate.py#L169)'s F_5 = 3/2 q^3 - 9 t3^2 | **0** |

The two normalisations differ (q = 4 tr(S^2), t3 = 8 tr(S^3)) and both give zero, because 96 t2^3 = 576 t3^2 reduces to 216 = 6 * 36 when t2 = t3 = 6. The vanishing is not convention-dependent and involves no floating point anywhere. **The last link of the chain is exact.**

---

## Claim 5 -- the 25 / 16 / 47 bookkeeping

Script: [audit.py](../scripts/reviewers/r210/audit.py), output [audit.out](../scripts/reviewers/r210/audit.out). Every number is recomputed from the run's own `ADAPTED` -- dumped by [dump_state.py](../scripts/reviewers/r210/dump_state.py), which is [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) with a pickle appended -- so this is the pipeline's data, not the `MULT` table quoted in [run_n5_necessary.py](../scripts/runs/run_n5_necessary.py).

| quantity | recomputed | claimed |
|---|---|---|
| blocks / sum m / sum m^2 / sum m(m+1)/2 | 24 / 41 / 89 / 65 | same |
| lambda_2 even / odd blocks | 16 / 8 | same |
| survivors: blocks, multiplicities | 16, 25 | same |
| survivor shape | two 3, five 2, nine 1 | same |
| O_SYM, O_HERM, gauge | 36, 47, 11 | same |

**Two things the run asserts and two it does not.** The shape assert is real and it is the check that catches over-restriction (plant P9). The run never checks that each TR block has **full row rank** -- measured here in both factors of the split ring Z/p[i], and it does: no block is rank-deficient. It also never checks the two quantities its own rank-one derivation depends on; both are clean:

- **B(W_0) = c a conj(a) exactly, in every one of the 16 even blocks**, with c != 0 mod p. So neither mod-p failure mode of claim 3 is live in the run as it stands.
- **x[:, t] is proportional to u at EVERY position t**, not merely the first -- the equivariance the file asserts "the ratios across copies do not depend on t" is confirmed rather than assumed, and the odd blocks have B(W_0) identically zero as (V_lambda)^H = 0 requires.

### The 11 gauge directions -- claim 4's open gap, closed

The concern was that the sampled matrix has 47 Hermitian columns while ANN annihilates the image of Sym^2(K), a 36-parameter space. Measured on the 40 sample points:

| matrix | columns | rank |
|---|---|---|
| unrestricted, all | 89 = 65 re + 24 im | 14 |
| unrestricted, re only | 65 | **14** |
| unrestricted, im only | 24 | 9 |
| restricted, all | 47 = 36 re + 11 im | 13 |
| restricted, re only | 36 | **13** |
| restricted, im only | 11 | 5 |

The imaginary columns are **not identically zero** (360 nonzero entries across 40 points), so "gauge" cannot mean "absent"; but they add no rank, so the rank on the 36 real symmetric unknowns is 13 exactly. **"The affine family is 36 - 13 = 23" is therefore justified**, and claim 4's chain is intact. The file's own phrasing at [run_n5_assemble.py:605](../scripts/runs/run_n5_assemble.py#L605) -- "the SPLIT is 24-dimensional by theorem, but WHICH 24 is not these coordinates" -- is precisely right, and the measurement above is the missing confirmation that it does not matter for the rank.

---

## Claim 6 -- plants

All plants act on the run's own dumped `GS0`, `GSAMP`, `TR`, with `herm_row` and `rank_mod_p` re-implemented in [audit.py](../scripts/reviewers/r210/audit.py) so a corrupted copy in the file under review cannot hide.

| plant | row at W_0 | rank | shape assert | T u = 0 | cap assert | outcome |
|---|---|---|---|---|---|---|
| baseline | 0/47 | 13 | pass | yes | pass | -- |
| **P1 isotropic shift of T at (2,2)** | **0/47** | **13** | pass | **NO** | pass | **SLIPS -- not K, and nothing says so** |
| **P2 duplicated row at (2,1)** | 0/47 | 13 | pass | yes | pass | **SLIPS -- proper subspace of K** |
| P3 corrupted u at (2,2) | 6/47 | 14 | pass | NO | **FIRES** | caught twice |
| P4 conjugated condition (TRC) | 4/47 | 14 | pass | NO | **FIRES** | caught twice |
| **P5 rank routine capped at 13** | 0/47 | 13 | pass | yes | pass | **SLIPS -- no self-test exists** |
| **P6 conj -> identity inside herm_row** | 0/47 | 13 | -- | -- | pass | **SLIPS -- answer unchanged** |
| P7 random T of the right shape | 27/47 | 14 | pass | NO | **FIRES** | caught |
| P8 drop the last copy | 20/47 | 14 | pass | NO | **FIRES** | caught |
| P9 over-restrict the odd blocks | 0/35 | 13 | **FIRES** | yes | pass | caught by shape alone |

**P8 reproduces the commit message's "the wrong restrictions read 20/47" exactly**, which is a good sign for the diagnostic on the failure modes it was built against.

### The four that slip, in order of seriousness

1. **P1 is the brief's requested witness, realised on the pipeline's own data.** Perturbing TR at block (2,2) by `delta (x) s` with `delta` in the isotropic line of Z/p[i] gives a T whose row space is **not** contained in a^perp -- `T u != 0` -- yet the restricted row at W_0 reads **0/47** and the restricted rank still reads **13**. The run would print "the restriction annihilates W_0, as K requires" and then "THE NECESSARY CONDITION IS A THEOREM". *Over Q(i) this T is impossible* (claim 3, step 3), so the plant is a statement about the arithmetic the check is performed in, not about the mathematics. The one thing that stops it in the file as written is the separate `assert acc == (0,0)` at [run_n5_assemble.py:1009](../scripts/runs/run_n5_assemble.py#L1009), which tests `T u = 0` directly -- **that assert, not the diagnostic, is what makes the restriction sound.** The diagnostic's advertised role ("does not need sampling and fails loudly") is not one it can play.

2. **P2 and P9 show the checks cannot distinguish K from a proper subspace of K.** Duplicating a TR row, or dropping an extra copy from an odd block, leaves 0/47 and rank 13. This is **harmless to the theorem** for a reason that deserves to be written down: if rowspace(T) is contained in a^perp then image(Sym^2 of it) is contained in image(Sym^2 K), so a sampled 13 forces dim image(K) >= 13 and the cap forces equality. The conclusion survives an under-restriction; it does not survive an over-reach, which is what P1 is.

3. **P5: the rank routine has no self-test.** Capping `rank_mod_p` at 13 makes every assert pass and prints the theorem. Verified separately that the routine as written is **correct** -- planted ranks 0, 1, 5, 12, 13, 14, 20, 40 on 40 x 47 matrices all reported exactly -- so this is a missing test, not a live bug. It costs eight lines.

4. **P6: replacing conj by the identity inside `herm_row` changes nothing** -- still 0/47, still rank 13 -- even though u is genuinely complex on 5 of the 16 even blocks. The conjugation in the T contraction is unconstrained by any output the run reports.

### What would close them

One assert, in the arithmetic the run already has: check `q = T a` componentwise and `c = b* Q b` per block, rather than the products `q_a conj(q_b)`. `q = 0` and `c != 0` are the two statements the sufficiency argument needs, and neither can vanish spuriously mod p.

---

## Summary

The theorem stands. Three of the four claims I was given are upheld outright, and the fourth -- the vanishing diagnostic -- is a correct claim resting on the wrong reason and checked by a test that cannot decide it in the arithmetic used. Two repairs are owed:

1. **[run_n5_necessary.py:125-126](../scripts/runs/run_n5_necessary.py#L125)** still prints the sentence r207 refuted and 584c9c9 removed from the docstring seventy lines above. The file contradicts itself, and the wrong half is the half a reader sees.
2. **The vanishing diagnostic should test `T a = 0` and `c != 0`, not `T B(W_0) T* = 0`.** The submodule argument -- restricting the copy index leaves an O(5)-submodule, and a submodule vanishing at W_0 vanishes on the whole orbit -- is what makes 0/47 sufficient, and it belongs in the file in place of the necessary-direction sentence now there.
