# VERIFY v72, Lemma L62's "reduction modulo a prime can only lower it further"

*Cold brief, adjudicated neutrally. **Nothing was run**: no script, no Sage, no numerics, no screen. Every value below is read verbatim from the sources or derived by hand, and every one is exact. Log: [agent_logs/verify-L62-v72.log](../agent_logs/verify-L62-v72.log).*

## Verdict

**`VALID AS WRITTEN`**, for the matrix the record actually reduces, with the condition it needs unstated everywhere in the record, and one step of the pipeline unguarded against it.

| | |
|---|---|
| The clause | "reduction modulo a prime can only lower it further", [results.md:631](../results.md#L631), restated at [results.md:206](../results.md#L206) and [sym3-blocks.md:346](../findings/sym3-blocks.md#L346) |
| The condition it needs | the reduced matrix must be **the image of a characteristic-zero matrix under a ring homomorphism into $\mathbb F_p$**, equivalently, $p$-integral entries and every division along the way by a $p$-unit |
| Does L62's matrix satisfy it | **Yes.** The sample points are exact rationals, the whole value chain is one ring map, and the single inversion in it is guarded by the pipeline's own unit asserts |
| Does the record state the condition | **No**, not in [results.md](../results.md), not in [sym3-blocks.md](../findings/sym3-blocks.md) under L62, and not at all in [conventions.md](../findings/conventions.md) |
| The neighbouring measurement, L87 | **Fails the same condition**, and its own block says so and leaves the repair unmade, [sym3-blocks.md:130](../findings/sym3-blocks.md#L130) |

The two lemmas the record treats as "identical in shape" ([sym3-blocks.md:128](../findings/sym3-blocks.md#L128)) sit on opposite sides of the one hypothesis neither states.

## 1. The general fact, and the condition it carries

The inequality $\operatorname{rank}_{\mathbb F_p}(\bar A)\le\operatorname{rank}_{\mathbb Q}(A)$ is not a fact about matrices over $\mathbb Q$; over $\mathbb Q$ the symbol $\bar A$ has no meaning. It is a fact about matrices over the local ring $\mathbb Z_{(p)}$ (rationals whose denominators are prime to $p$) where the residue map $\mathbb Z_{(p)}\to\mathbb F_p$ is a ring homomorphism. The proof is one line: an $r\times r$ minor of $\bar A$ is the residue of the corresponding minor of $A$, so a minor non-vanishing in $\mathbb F_p$ has a non-vanishing lift, and $\operatorname{rank}\bar A\le\operatorname{rank}A$.

So the condition is **$p$-integrality**, and the inequality fails without it in the strongest possible way: with $p$ dividing a denominator there is no $\bar A$ at all, and any residue assigned by fiat (for instance by the convention $1/p\mapsto 0$ that a modular inverse routine silently supplies), can carry the rank in either direction.

**But $p$-integrality is the weaker half of what is at stake here, and stating it alone would understate the hypothesis.** Any rational matrix can be made $p$-integral for free: scale each row by the $p$-part of its denominators, which changes neither $\operatorname{rank}_{\mathbb Q}$ nor the meaning of the residue. What cannot be arranged after the fact is the existence of the lift. A rank computed natively in characteristic $p$ (from data assembled in $\mathbb F_p$ rather than reduced into it), bounds nothing in characteristic zero, because there is no $A$ over $\mathbb Q$ of which the computed matrix is the reduction. The condition in its load-bearing form is therefore:

> **There is a matrix $A$ over $\mathbb Q$ (or a number field), with entries integral at $p$, whose residue is the matrix whose rank was computed.**

For a pipeline that works modulo $p$ from the start, this is a condition on the *arithmetic*: the computation must be the image of a characteristic-zero computation under a ring map, which requires that every input be $p$-integral and every division be by a $p$-unit. Both requirements are checkable, and below both are checked.

## 2. What the record actually reduces

The matrix is the one dumped to [scripts/runs/n5_rows_1099511627873.json](../scripts/runs/n5_rows_1099511627873.json) and its three siblings, by the block at [run_n5_assemble.py:1247](../scripts/runs/run_n5_assemble.py#L1247). Read as text, the four files carry a `prime`, a `rows` array, an `rhs` array, and the block order and shape; counting the delimiters gives **40 rows of 47 entries**, matching the shipped `assert len(RROWS[0]) == 47` and the 47 Hermitian coordinates on the 25 surviving multiplicities. The four primes are

$$1099511627873,\quad 1099511627917,\quad 1099511627933,\quad 1099511627953,$$

all just above $2^{40}$ and all $\equiv1\pmod4$, which is what the file's own `assert PRIME % 4 == 1` demands. These are the "four primes" of L62's sentence; the record names none of them, [sym3-blocks.md:225](../findings/sym3-blocks.md#L225) names a different pair, $1000033$ and $1000003$, the second of which is $3\bmod4$ and so could not have been produced by this script at all, consistent with that line's own statement that reviewer 209 used its own code.

The value chain of a single entry, traced through the file:

| Step | Object | Ring | Where |
|---|---|---|---|
| 1 | sample point $W$: 35 coefficients drawn from $\{-4,\dots,4\}$ as `Fraction`s against `wm2.BASIS`, a nullspace over $\mathbb Q$ | $\mathbb Q$ | [run_n5_assemble.py:895](../scripts/runs/run_n5_assemble.py#L895) |
| 2 | $W^3$, expanded per $\mathrm{Sym}^3$ monomial | $\mathbb Q(i)$ | `ev.cube` |
| 3 | coordinates $x=A_w^{-1}b$ per weight $w$, $A_w$ the adapted-basis matrix of that weight | $\mathbb Q(i)$ | `invert_weight`, `solve_weight_g` |
| 4 | $G^\lambda_{ij}=\sum_{t,s}x_{i,t}\,\overline{x_{j,s}}\,Q^\lambda_{ts}$ | $\mathbb Q(i)$ | `sample_row` |
| 5 | $H=TGT^{*}$, $T$ the restriction to $u_\lambda^{\perp}$ | $\mathbb Q(i)$ | `herm_row` |
| 6 | the 47 real coordinates $\operatorname{Re}H_{ii}$, $\operatorname{Re}H_{ij}$, $\operatorname{Im}H_{ij}$ | $\mathbb Q$ | `herm_row` |

Two facts about this chain matter and are worth stating separately.

**The entries whose rank is taken are rational, not Gaussian.** $H$ is Hermitian, so its diagonal is real and its off-diagonal splits into a real and an imaginary part, each in $\mathbb Q$. The Gaussian field appears only in the intermediate arithmetic. So the relevant residue map is the ordinary $\mathbb Z_{(p)}\to\mathbb F_p$, and the rank is taken over a field.

**The arithmetic is carried as a pair, and the pair form is a ring map.** The file's `gp`, `gpmul`, `gpadd`, `gpconj` implement $\mathbb Z[i]_{(p)}\to\mathbb F_p[x]/(x^2+1)$, $a+bi\mapsto(a\bmod p,\;b\bmod p)$, which is a ring homomorphism intertwining conjugation with $(a,b)\mapsto(a,-b)$. Extracting slot 0 of the pair is exactly reducing $\operatorname{Re}$, because reduction is $\mathbb Z_{(p)}$-linear on the basis $\{1,i\}$. So step 6's residues are the residues of step 6's rationals, entry for entry. **Note that this map is a homomorphism for every $p$**; the congruence $p\equiv1\pmod4$ is needed only by `to_p`, the single-residue conversion the live path does not use. The rank argument therefore does not depend on the splitting at all, which is worth knowing given that the splitting is a hazard elsewhere in the same file.

## 3. The condition, checked for L62's matrix

**Step 1, the points are characteristic zero.** `rand_weyl_tensor` draws integer coefficients as `Fraction`s and pushes them through `wm2.BASIS`, itself a nullspace computed over $\mathbb Q$; `_r5.seed(20260829)` fixes them, so the same rational points are used at all four primes, which is what makes the four rows correspond entry for entry as the dump comment claims. $W_0$ is equally rational: [run_n5_extremiser.py:41](../scripts/runs/run_n5_extremiser.py#L41) builds $S$ from `F(s,1)*w[a]*w[b]/nrm` with $F$ the `Fraction` constructor. **This is the fact on which the whole verdict turns**, and it is the one the record never states.

**Step 3, the one division, and why it is a $p$-unit.** Expanding $W^3$ needs $A_w^{-1}$, and this is the only place the computation inverts something that is not obviously a unit. Over $\mathbb Q(i)$, $A_w$ is invertible: the adapted vectors of a given $\mathrm{Sym}^3$ weight are a basis of that weight space, which the file asserts as `square` and again as `assert n == len(mons)`. That gives $\det A_w\ne0$ but **not** $\det A_w\not\equiv0\bmod p$, which is what is needed, and a rank-deficient reduction would leave $\bar A_w$ singular while the exact $A_w$ stands, so the mod-$p$ solve would return a particular solution rather than the residue of the rational one.

The pipeline closes this. `invert_weight` at [run_n5_assemble.py:762](../scripts/runs/run_n5_assemble.py#L762) performs the elimination with `assert pv is not None, "the adapted basis is SINGULAR at weight w"` on every one of the $n$ columns, and each pivot is inverted through `gpinv`, which asserts $a^2+b^2\not\equiv0$. In $\mathbb F_p[x]/(x^2+1)$ the norm $a^2+b^2$ is the product of the two component images, so `gpinv`'s assert is precisely "this element is a unit of the ring". An elimination that reaches a pivot in every column with every pivot a unit exhibits $\bar A_w\in GL_n$, hence $\det A_w$ a $p$-unit, hence $A_w^{-1}$ $p$-integral with $\overline{A_w^{-1}}=(\bar A_w)^{-1}$. **The pipeline's own asserts discharge exactly the hypothesis the record leaves out**, and they discharge it at each of the four primes independently, since they run inside each run.

**Step 5, the restriction $T$ is a rational matrix, not a modular one.** $T$'s rows are built at [run_n5_assemble.py:1039](../scripts/runs/run_n5_assemble.py#L1039) as $v_i=1$, $v_k=-u_i u_k^{-1}$, with $k$ chosen as the first index where $u_k\not\equiv0$. Because $k$ is selected by a non-vanishing test modulo $p$, and non-vanishing modulo $p$ implies non-vanishing over $\mathbb Q(i)$, the same $k$ is legitimate in characteristic zero; the rational $T$ built with that same $k$ has $m-1$ rows spanning the hyperplane $\{a:\sum a_iu_i=0\}$ exactly, and $u_k$ being a $p$-unit makes $-u_i/u_k$ $p$-integral. So $T\bmod p$ is the residue of a rational $T$, and $T$ is the right hyperplane. The three earlier wrong restrictions the file records (conjugated condition, $\langle R,W_0^3\rangle$ in place of the expansion vector $a$), are errors about *which* rational $T$, not about whether one exists.

**Assembling.** With steps 1, 3 and 5 $p$-integral and every other operation a ring-map image of an exact one, the 40×47 matrix over $\mathbb F_p$ is the residue of a 40×47 matrix $A$ over $\mathbb Q$: the real coordinates of $H(W_s)=T\,G(W_s)\,T^{*}$ at 40 rational points. The chain of inequalities the lemma needs is then

$$\operatorname{rank}_{\mathbb F_p}(\bar A)\;\le\;\operatorname{rank}_{\mathbb Q}(A)\;=\;\operatorname{rank}(\mathrm{ev}\circ\mu_K)\;\le\;\operatorname{rank}(\mu_K)\;\le\;13,$$

the last step being L62's own order-1 argument, a product of two cubics of $K$ vanishes at $W_0$, and evaluation at $W_0$ is a nonzero functional on the 14, since $\lVert W\rVert^6$ is 1 there. Every inequality points the same way, so an observed $\operatorname{rank}_{\mathbb F_p}(\bar A)=13$ collapses the chain and forces $\operatorname{rank}(\mu_K)=13$, hence $\dim\mathrm{ANN}=14-13=1$. **The bolded clause is the first inequality of that chain and it holds.**

## 4. The one place the condition is unguarded

The input-side half of $p$-integrality (that no cached adapted-basis coefficient has a denominator divisible by $p$), is asserted in one conversion and not in the other, and the live path uses the one without the assert.

- `to_p` at [run_n5_assemble.py:223](../scripts/runs/run_n5_assemble.py#L223) carries `assert a.denominator % PRIME and b.denominator % PRIME`, with the reason spelled out in its own docstring: `pow(0, p-2, p)` returns 0, so an unguarded denominator silently yields the residue of a pole.
- `gp` at [run_n5_assemble.py:158](../scripts/runs/run_n5_assemble.py#L158) performs the same conversion into pair form and carries **no such assert**.
- Grepping the call sites: `to_p` is reached only from `solve_weight`, `ip3` and `sym3_ip_p`; `solve_weight` is never called, and stage 5 runs entirely through `invert_weight`, `solve_weight_g`, `ip3_g` and `sample_row`, all of which convert through `gp`. So **the denominator guard never executes on the adapted basis on the path that produces the dumped rows.**
- `_scan_prime` does not cover it. It tests whether a cached coefficient's *numerator* combination vanishes modulo $p$ (a false-zero screen, the one the 65537 episode motivated) and reads `x.r.numerator` and `x.i.numerator` only.

This is a gap in the *checking*, not a demonstrated defect. Nothing in the sources exhibits a coefficient with a $p$-divisible denominator, and the failure mode is heavily over-determined downstream: a corrupted `gp` would have to leave `invert_weight` non-singular, the multi-probe Schur test at 0 disagreements, $G$ Hermitian at 9 points, $Ta=0$ on every restricted block, $F_5(W_0)=0$, and the augmented system consistent, and do so at four independent primes. But none of that is an argument, and the repair is one line: give `gp` the assert `to_p` already has. I record it as an owed check rather than a failure, because the clause is about the matrix and the matrix is a reduction; what is unproven is that the *reduction was computed faithfully*, which is a claim about the code and not about the mathematics.

Two related hazards are handled and worth naming so they are not mistaken for this one. The isotropy of $z\bar z$ in the split algebra $\mathbb F_p[i]$ at $p\equiv1\pmod4$ is real, and the file meets it by asserting $q=Ta=0$ directly rather than through the products $q_a\overline{q_b}$; it bears on whether $T$ is the right restriction, not on the rank inequality. And the equivariance hypothesis behind $\operatorname{rank}(\mathrm{ev}\circ\mu_K)\le\operatorname{rank}(\mu_K)$ (reviewer 209's $S_3$-on-$\mathbb R^3$ counterexample, sampled rank 10 against a cap of 7), is guarded by the multi-probe Schur test, and the record does state that one, at [sym3-blocks.md:231](../findings/sym3-blocks.md#L231).

## 5. Whether the record states the condition

It does not, in any of the three files.

| Location | What it says about the mod-$p$ step |
|---|---|
| [results.md:631](../results.md#L631), L62 | "reduction modulo a prime can only lower it further", bare, no hypothesis |
| [results.md:206](../results.md#L206), the direct-results list | "a sampled rank is a lower bound and reduction modulo $p$ can only lower it", bare |
| [results.md:23](../results.md#L23), the canon table | "A sampled mod-$p$ rank is a rigorous lower bound", bare, and it is this sentence that promotes both L87 and L62 from measurements to proofs |
| [sym3-blocks.md:346](../findings/sym3-blocks.md#L346), L62's proof | "reducing modulo $p$ can only lower it further", bare |
| [sym3-blocks.md:225](../findings/sym3-blocks.md#L225) | "Sampling and reduction only lose rank", bare |
| [sym3-blocks.md:231](../findings/sym3-blocks.md#L231), "three things the cap argument needs" | equivariance, orbit-vanishing, non-self-validating attainment, **integrality is not among the three** |
| [conventions.md](../findings/conventions.md) | silent: it carries no entry on modular reduction, integrality, or characteristic at all |

The closest the record comes is [sym3-blocks.md:130](../findings/sym3-blocks.md#L130), which names the condition in the negative and about a different lemma, "not the reduction of anything", and a repair by "a $p$-integral $\tilde g\in O(5,\mathbb Q)$ reducing to $g$". The concept is therefore present in the record exactly once, as a defect note on L87, and is never lifted into a general hypothesis or attached to L62. **Nothing on the record tells a reader that L62's 40 sample points are rational**, which is the fact that makes L62's clause true.

## 6. The neighbouring measurement: L87

**L87 does not satisfy the condition, and its own block records that.** Its number is the rank of the orbit Gram $\langle g_aW_0,g_bW_0\rangle^3$ over 3700 points, exactly 3570 over $\mathbb F_{46337}$, squeezed against the cap $\sum_\lambda d_\lambda$ over the $\lambda_2$-even blocks ([sym3-blocks.md:140](../findings/sym3-blocks.md#L140)). The audit note four lines above it says the orbit points are Cayley transforms of random skew matrices drawn **over $\mathrm{GF}(46337)$**, so each $g_a$ is an element of $O(5,\mathbb F_p)$ and the Gram is not the reduction of any characteristic-zero Gram. It further closes the escape route of reading the whole computation in characteristic $p$: $p$ divides $\lvert O(5,\mathbb F_p)\rvert$ for every $p$, so $\mathrm{Sym}^3\mathcal W_5$ is not semisimple there and the isotypic decomposition the cap $3570$ is computed from does not exist. The repair is named, $\det(I+\tilde A)\ge1$ for real skew $\tilde A$, so a $p$-integral lift $\tilde g\in O(5,\mathbb Q)$ reducing to $g$ exists, and the block says it "is nowhere on the record". I found no lift anywhere in [findings/sym3-blocks.md](../findings/sym3-blocks.md) or [results.md](../results.md).

The difference is worth naming precisely, because the record asserts the two are the same argument:

| | L62 | L87 |
|---|---|---|
| Sample points | rational, `Fraction` coefficients in $\{-4,\dots,4\}$, fixed seed | Cayley transforms of skew matrices **over $\mathbb F_{46337}$** |
| Is the reduced matrix a reduction? | **Yes** (the whole chain is a ring-map image | **No**), it is not the reduction of anything |
| The unit condition on the one inversion | asserted in code, per prime | not applicable; the failure is upstream |
| Primes | four, all $\equiv1\bmod4$, near $2^{40}$ | one, 46337 |
| Repair needed | one assert on `gp` | an integral lift, named and unmade |
| Status of the mod-$p$ inequality | **holds** | **not available as written**; the conclusion is believed on other grounds |

[sym3-blocks.md:128](../findings/sym3-blocks.md#L128) calls L87 "identical in shape to L62". On the hypothesis that decides both, they are opposites: L62's data was constructed in characteristic zero and reduced, L87's was constructed in characteristic $p$. The record's summary sentence at [results.md:23](../results.md#L23), "a sampled mod-$p$ rank is a rigorous lower bound, and under an exact cap a lower bound is all that is needed, so L87's rank and L62's value are proofs rather than measurements", is therefore sound for L62 and unsupported for L87, and it is the sentence that carries both into the canon as proofs.

## 7. Readings adopted

The record admits two readings in three places, and the verdict depends on the first.

- **"a sample of $K$"** reads naturally as a sample of *cubics from $K$*. I adopt instead the reading the pipeline implements: a sample of *points* $W$ at which the restricted invariant sextics are evaluated, with $K$ entering through the restriction $T$ that cuts the copy index. On this reading the sampled matrix is $\mathrm{ev}\circ\mu_K$ and the "bounds from below" claim is the standard $\operatorname{rank}(\mathrm{ev}\circ\mu_K)\le\operatorname{rank}(\mu_K)$. On the alternative reading (sampling the domain $\mathrm{Sym}^2(K)$), the same inequality holds for the same reason, so the clause survives either way; the points reading is the one the four dumps carry.
- **"the true rank"** I read as $\operatorname{rank}\big(\mu\vert_{\mathrm{Sym}^2(K)^{O(5)}}\big)$, the map from the 36 real unknowns to the 14 invariant sextics, so that $\dim\mathrm{ANN}=14-\operatorname{rank}$ by L59's apolarity adjunction. This is the quantity [sym3-blocks.md:251](../findings/sym3-blocks.md#L251) says L91's block never names.
- **"can only lower it further"**, "it" is the sampled rank, not the true rank, giving one chain of same-signed inequalities. The alternative antecedent would make the sentence claim that reduction lowers the *true* rank, which is meaningless; the intended reading is unambiguous in context.

## 8. The strongest defence, and what it rests on

Stated as the record ought to state it:

> The 40 sample points and the base point $W_0$ are exact rational Weyl tensors. Every quantity computed from them, the $\mathrm{Sym}^3$ expansion, the block Grams $G^\lambda$, the restriction $T$ to $u_\lambda^{\perp}$, and the 47 real coordinates of $H=TGT^{*}$, lies in $\mathbb Q(i)$ and in fact the 47 coordinates lie in $\mathbb Q$. The pipeline computes their residues by a ring homomorphism $\mathbb Z[i]_{(p)}\to\mathbb F_p[x]/(x^2+1)$ that keeps the real and imaginary parts in separate slots, so slot 0 of the result is the residue of the rational coordinate. The only division by a non-obvious unit is the per-weight inversion $A_w^{-1}$, and the run establishes $\bar A_w\in GL_n$ directly, by reaching a unit pivot in every column; that makes $\det A_w$ a $p$-unit, so $A_w^{-1}$ is $p$-integral and its residue is the inverse of the residue. Hence the 40×47 matrix over $\mathbb F_p$ is the reduction of a matrix over $\mathbb Q$, and $\operatorname{rank}_{\mathbb F_p}\le\operatorname{rank}_{\mathbb Q}$ applies. Composed with $\operatorname{rank}(\mathrm{ev}\circ\mu_K)\le\operatorname{rank}(\mu_K)\le13$, an observed 13 forces equality.

That defence succeeds. It rests on four things, three of which the sources establish and one of which is owed:

1. the rationality of the sample points and of $W_0$, established, in [run_n5_assemble.py:895](../scripts/runs/run_n5_assemble.py#L895) and [run_n5_extremiser.py:41](../scripts/runs/run_n5_extremiser.py#L41);
2. the ring-map property of the pair arithmetic, including the conjugation, established, and tested in the file by the $i^2=-1$, ring-map, additivity and conjugation asserts that reviewers 201 and 204 forced in;
3. the unit condition on $\bar A_w$, established by `invert_weight`'s and `gpinv`'s asserts, per prime;
4. the $p$-integrality of the cached adapted coefficients, **owed**, because `gp` lacks the denominator assert `to_p` carries and the live path uses only `gp`.

Item 4 is why the verdict is "valid as written" and not "valid and fully discharged". It does not move the verdict, because it is a defect of verification in the code rather than a defect in the step; the step is a statement about a matrix that demonstrably is a reduction.

**Three repairs the record owes, none of which changes a number.**

- State in L62's block that the 40 sample points are rational and fixed by seed, which is what makes the mod-$p$ clause a theorem rather than a screen, and say that the reduction is of the real coordinates, in $\mathbb Q$.
- Add the integrality hypothesis to the general sentence wherever it appears, [results.md:23](../results.md#L23), [results.md:206](../results.md#L206), [results.md:631](../results.md#L631), [sym3-blocks.md:225](../findings/sym3-blocks.md#L225), [sym3-blocks.md:346](../findings/sym3-blocks.md#L346), or give [conventions.md](../findings/conventions.md) one entry that every occurrence can point at. It belongs in the "three things the cap argument needs" list at [sym3-blocks.md:231](../findings/sym3-blocks.md#L231) as a fourth.
- Separate L62 from L87 wherever the record pairs them. The pairing at [sym3-blocks.md:128](../findings/sym3-blocks.md#L128) and the joint promotion at [results.md:23](../results.md#L23) attribute to L87 a warrant only L62 has.
