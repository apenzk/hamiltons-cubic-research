# Verifier v71, L62's "reduction modulo a prime can only lower it further", for the matrix the record actually reduces

*The brief was cold: the step was put neutrally, with no prior verdict attached, and every reading below was built from the sources named rather than from any earlier report. **I ran nothing (no script, no Sage, no numerics) and every value in this report is exact**, read out of the pipeline sources and the stored dumps as text. Log: [agent_logs/verify-L62-v71.log](../agent_logs/verify-L62-v71.log).*

## Verdict: `VALID AS WRITTEN`

The clause is valid for the matrix [Lemma L62](../findings/sym3-blocks.md) reduces, and it is valid for a reason the record never states. The general fact carries a hypothesis, the matrix must be $p$-integral, so that the object in characteristic $p$ is the entrywise reduction of a matrix over $\mathbb Q$, and L62's matrix satisfies it because its sample points are drawn over $\mathbb Q$ before any prime is chosen and everything downstream is a $p$-integral rational construction on them.

Three things follow, and the second and third are the part of this adjudication worth keeping:

| | |
| --- | --- |
| the clause, for L62's matrix | **valid**, on the $p$-integrality condition of §1, which §3 shows is met |
| the condition, on the record | **stated nowhere for L62**, silent in [results.md](../results.md), silent in [findings/conventions.md](../findings/conventions.md), and in [findings/sym3-blocks.md](../findings/sym3-blocks.md) stated only inside [Lemma L87](../findings/sym3-blocks.md)'s block, as L87's own defect |
| the neighbour, [Lemma L87](../findings/sym3-blocks.md) | **fails the condition as written**, its orbit points are elements of $O(5,\mathbb F_p)$ and are the reduction of nothing that was ever formed; the repair is an integral lift, which the record names and does not supply |

## 1. The condition, named and proved

Reduction modulo $p$ is a map on matrices only where it is defined, and it is defined on $\mathbb Z_{(p)}$ (the rationals whose denominators are prime to $p$) rather than on $\mathbb Q$. The precise statement is this.

**Condition.** Let $A$ have entries in $\mathbb Z_{(p)}$ (equivalently: in $\mathbb Z[i]$ localised at a prime $\mathfrak p$ above $p$, when the entries are Gaussian), and let $\bar A$ be its entrywise image under the reduction ring homomorphism $\mathbb Z_{(p)}\to\mathbb F_p$. Then

$$\operatorname{rank}_{\mathbb F_p}(\bar A)\ \le\ \operatorname{rank}_{\mathbb Q}(A).$$

**Proof.** Write $r=\operatorname{rank}_{\mathbb F_p}(\bar A)$. Some $r\times r$ minor of $\bar A$ is nonzero. Reduction is a ring homomorphism, so it commutes with the polynomial that a minor is: the corresponding $r\times r$ minor of $A$ reduces to that nonzero element, hence is itself nonzero in $\mathbb Z_{(p)}\subset\mathbb Q$. So $A$ has a nonvanishing $r\times r$ minor and $\operatorname{rank}_{\mathbb Q}(A)\ge r$. $\square$

Two ways the hypothesis can be lost, and both are live in a pipeline of this shape:

- **A denominator divisible by $p$.** Then $A$ has no reduction, the homomorphism does not exist, and the minor argument has nothing to run on. The pipeline knows this failure by name: [run_n5_assemble.py:234](../scripts/runs/run_n5_assemble.py#L234) refuses such an entry because `pow(0, p-2, p)` "would silently return the reduction of a pole".
- **No $A$ at all.** If the object in characteristic $p$ was built from data that exists only in characteristic $p$, then it is not the reduction of anything, and no inequality relates its rank to a rank over $\mathbb Q$. This is the failure mode the brief points at, and §6 shows it is exactly L87's.

A third edge, sharper and specific to how these matrices are built: **a construction may branch on a mod-$p$ test, and only the non-vanishing branch lifts.** A pivot chosen because it is nonzero mod $p$ is nonzero over $\mathbb Q$, so the same choice is available over $\mathbb Q$ and the mod-$p$ object is the reduction of the object built by the same recipe upstairs. A choice made because something *vanishes* mod $p$ has no such warrant. Every branch in L62's path is of the first kind, §3 checks them one by one.

## 2. The matrix the record actually reduces

The step is about the **restricted** matrix, the one carrying the cap $13$: rows indexed by sample points, columns by the Hermitian coordinates of an invariant Gram supported on $K$. In code it is `RROWS`, built at [run_n5_assemble.py:1181](../scripts/runs/run_n5_assemble.py#L1181), and it is $40\times47$, forty sample points against the $47=\sum m'^2_\lambda$ Hermitian coordinates of the post-orbit shape (two $3\times3$, five $2\times2$, nine scalars, so $2\cdot9+5\cdot4+9=47$). The four stored dumps [n5_rows_1099511627873.json](../scripts/runs/n5_rows_1099511627873.json), [n5_rows_1099511627917.json](../scripts/runs/n5_rows_1099511627917.json), [n5_rows_1099511627933.json](../scripts/runs/n5_rows_1099511627933.json) and [n5_rows_1099511627953.json](../scripts/runs/n5_rows_1099511627953.json) are those rows, one file per prime, each written at [run_n5_assemble.py:1248](../scripts/runs/run_n5_assemble.py#L1248) only after the run's own `assert rk_A == 13` at [run_n5_assemble.py:1235](../scripts/runs/run_n5_assemble.py#L1235) has passed. So the four files are themselves the evidence for the record's "at four primes", and the primes are the four just above $2^{40}=1099511627776$.

Where the entries come from, in the order the pipeline builds them:

1. **The sample point.** `rand_weyl_tensor` at [run_n5_assemble.py:895](../scripts/runs/run_n5_assemble.py#L895) draws $v\in\{-4,\dots,4\}^{35}$ as `Fraction` objects and contracts them against `wm2.BASIS`, a rational basis of $\mathcal W_5$. The seed is fixed at [run_n5_assemble.py:894](../scripts/runs/run_n5_assemble.py#L894), so the forty points are **integral, prime-independent, and identical at every prime**, which is also what makes the four dumps CRT-compatible entry for entry, as the dump comment says.
2. **The cube.** `ev.cube` sends the point to $W^3\in\mathrm{Sym}^3$ with coefficients in $\mathbb Q(i)$, exact.
3. **The adapted basis.** `ADAPTED` is a cache of highest-weight-generated vectors whose coefficients are Gaussian rationals, objects carrying `.r` and `.i` as `Fraction`s, as the prime scan's own traversal at [run_n5_assemble.py:121](../scripts/runs/run_n5_assemble.py#L121) shows. **This is a characteristic-zero object**, fixed before any prime is chosen.
4. **The expansion.** `invert_weight` at [run_n5_assemble.py:762](../scripts/runs/run_n5_assemble.py#L762) inverts each per-weight adapted-basis block mod $p$; `solve_weight_g` at [run_n5_assemble.py:794](../scripts/runs/run_n5_assemble.py#L794) applies it to $W^3$.
5. **The Gram.** `sample_row` at [run_n5_assemble.py:814](../scripts/runs/run_n5_assemble.py#L814) forms $G_{ij}=\sum_{a,b}x_{ia}\overline{x_{jb}}\,Q_{ab}$, with $Q$ the position Gram read off copy $0$ by `ip3_g`.
6. **The restriction.** $T$ is built at [run_n5_assemble.py:1034](../scripts/runs/run_n5_assemble.py#L1034) from the expansion vector $u$ of $W_0^3$, read at the first position where it is nonzero ([run_n5_assemble.py:1018](../scripts/runs/run_n5_assemble.py#L1018)); the rows of $T$ are $e_i-\bigl(u_i/u_k\bigr)e_k$ for a pivot $k$ with $u_k\ne0$.
7. **The real coordinates.** `herm_row` at [run_n5_assemble.py:848](../scripts/runs/run_n5_assemble.py#L848) forms $H=TGT^*$ and emits, per block, the real part of each diagonal entry and both parts of each entry above it.

**The ring the entries live in.** Gaussian rationals are carried as a *pair* $(a,b)$ with $a,b$ reduced separately, `gp` at [run_n5_assemble.py:158](../scripts/runs/run_n5_assemble.py#L158), with the ring-map property tested against exact $\mathbb Q(i)$ arithmetic three lines below the definition. The pair form is exactly what makes the emitted coordinates reductions of *rational* numbers: `herm_row` emits components of the pair, and each component is the reduction of one rational. Folding $i$ into a single residue $a+b\cdot\mathrm{IMOD}$ would still be a homomorphism $\mathbb Z[i]_{\mathfrak p}\to\mathbb F_p$ and would still support the rank inequality, but it would fuse two coordinates into one and change the matrix; the file's own comment at [run_n5_assemble.py:151](../scripts/runs/run_n5_assemble.py#L151) records that hazard for a different reason and the reading adopted here agrees with it.

**Reading adopted where the record admits two.** L62's "sampled rank" is the *restricted* one, the $13$, `rr`/`rk_A` on the $47$-column matrix, not the unrestricted $14$ on the $89$-column one. The record supports this: the cap being attained is $13$, and $13$ is the post-orbit number. The gauge directions cost nothing here, $47=36+11$ Hermitian against real-symmetric coordinates, and the $11$ lie in the kernel of the Gram-to-sextic map, so the rank read on $47$ columns is the rank read on $36$.

## 3. The matrix satisfies the condition

Take $A^{\mathbb Q}$ to be the $40\times47$ matrix built by steps 1–7 over $\mathbb Q(i)$ rather than mod $p$: same forty rational sample points, same cached adapted basis, exact inverses, exact restriction. Every step is a ring operation on $\mathbb Q(i)$-data, with these inversions and no others:

| inversion | why the rational counterpart is $p$-integral |
| --- | --- |
| the per-weight adapted-basis block, step 4 | the mod-$p$ elimination finds a pivot in every column ([run_n5_assemble.py:775](../scripts/runs/run_n5_assemble.py#L775) asserts it), so $\det\not\equiv0$; the rational $\operatorname{adj}/\det$ therefore has entries in $\mathbb Z_{(p)}$ and reduces to the computed inverse |
| the pivot norm inside `gpinv` | asserted nonzero mod $p$, so the rational reciprocal is a $p$-unit |
| $u_k$ in the restriction, step 6 | $k$ is chosen at [run_n5_assemble.py:1034](../scripts/runs/run_n5_assemble.py#L1034) *because* $u_k\ne0$ mod $p$, hence $u_k\ne0$ over $\mathbb Q(i)$ and $1/u_k\in\mathbb Z[i]_{\mathfrak p}$ |
| the block normaliser $q_{00}$ in stage 3 | asserted nonzero mod $p$ at [run_n5_assemble.py:298](../scripts/runs/run_n5_assemble.py#L298), with the comment giving the reason it is nonzero over $\mathbb Q(i)$ |

Every branch is of the liftable kind: the position $t$ at which $u$ is read is the first at which $u$ is **nonzero** mod $p$, so the same position is available over $\mathbb Q(i)$; the pivot $k$ likewise; and the sparse-storage tests that *drop* an entry (`if val != (0,0)`, `if not xa: continue`) drop only terms that contribute $0$ to a sum mod $p$, so the accumulated value is still the reduction of the exact sum. Hence

$$\text{the dumped rows}\ =\ \overline{A^{\mathbb Q}},\qquad A^{\mathbb Q}\in\mathbb Z_{(p)}^{40\times47},$$

and §1 applies. **The condition is met, and what is reduced is the reduction of something over $\mathbb Q$.**

Two honest qualifications, neither of which changes the verdict:

- **One guard is missing on the path stage 5 actually uses.** `to_p` at [run_n5_assemble.py:223](../scripts/runs/run_n5_assemble.py#L223) asserts that no denominator is divisible by the prime; `gp` at [run_n5_assemble.py:158](../scripts/runs/run_n5_assemble.py#L158), which is the converter the pair arithmetic and therefore the whole of stage 5 runs on, performs the same `pow(den, p-2, p)` with no such assert. So $p$-integrality of the cached coefficients is a **fact about the data at these four primes rather than a checked invariant of the run**. The prime scan at [run_n5_assemble.py:121](../scripts/runs/run_n5_assemble.py#L121) does not cover it: it checks numerators, for a different hazard.
- **The closure is a posteriori and it is strong.** [run_n5_lift.py](../scripts/runs/run_n5_lift.py) CRTs the stored rows across the primes and rational-reconstructs every entry, and it asserts zero reconstruction failures across all $40\times47+40$ entries. A rational row of bounded height whose reductions agree with the dumps at four independent primes near $2^{40}$ *is* the $A^{\mathbb Q}$ the argument needs, exhibited. [findings/sym3-blocks.md:202](../findings/sym3-blocks.md#L202) records the same lift with a uniqueness margin. So the rational matrix is not merely available in principle: it was formed.

## 4. The chain, end to end

Write $\mu_K$ for the restriction of $\mu\colon\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)\to\mathrm{Sym}^6\mathcal W_5^*$ to the invariants supported on $K$, and $\mathrm{ev}$ for evaluation at the forty points. The sampled matrix is $\mathrm{ev}\circ\mu_K$ in coordinates, so its row space sits inside the image of $\mu_K^*$ and

$$13\ \overset{\text{(a)}}{=}\ \operatorname{rank}_{\mathbb F_p}\overline{A^{\mathbb Q}}\ \overset{\text{(b)}}{\le}\ \operatorname{rank}_{\mathbb Q}A^{\mathbb Q}\ \overset{\text{(c)}}{\le}\ \operatorname{rank}\mu_K\ \overset{\text{(d)}}{\le}\ 13,$$

with (a) the measurement, (b) §1 under §3's condition, (c) the sampling inequality, and (d) L62's own theorem, every product of two cubics of $K$ vanishes at $W_0$, and $\lVert W\rVert^6$ has value $1$ there, so evaluation at $W_0$ is a nonzero functional on the $14$ and the image lies in its $13$-dimensional kernel. The chain closes, $\operatorname{rank}\mu_K=13$, and $\dim\mathrm{ANN}=14-13=1$.

Step (b) is the clause under adjudication and it holds. Step (c) is not free either, and the pipeline says so where the record does not: the cap $\operatorname{rank}(\mathrm{ev}\circ\mu_K)\le\operatorname{rank}\mu_K$ needs the copies identified **equivariantly**, guarded by the multi-probe Schur test at [run_n5_assemble.py:501](../scripts/runs/run_n5_assemble.py#L501), and the file records a counterexample at [run_n5_assemble.py:721](../scripts/runs/run_n5_assemble.py#L721), $S_3$ on $\mathbb R^3$ with one copy given its own position list, sampled rank $10$ against a cap of $7$. That hypothesis is outside this brief; it is named here because a reader checking (b) will meet it next.

## 5. Whether the record states the condition

It does not, at any of the three sites the brief names.

| site | what it says | condition present |
| --- | --- | --- |
| [results.md:631](../results.md#L631), L62's block | "reduction modulo a prime can only lower it further" | no |
| [results.md:206](../results.md#L206), L62's one-line entry | "a sampled rank is a lower bound and reduction modulo $p$ can only lower it" | no |
| [results.md:23](../results.md#L23), the status table | "a sampled mod-$p$ rank is a rigorous lower bound" | no |
| [findings/sym3-blocks.md:346](../findings/sym3-blocks.md#L346), L62's proof | "reducing modulo $p$ can only lower it further" | no |
| [findings/conventions.md](../findings/conventions.md), the $\mathrm{Cat}_F$/ANN row | "$\dim\mathrm{ANN}=1$ rests on one sampled mod-$p$ rank" | no |

The nearest thing to it in L62's own block is the Gate 2 note at [findings/sym3-blocks.md:337](../findings/sym3-blocks.md#L337), which lists "the primes" among three hypotheses riding on the measurement, but the primes are named there for the false-zero hazard the prime scan addresses, which is a different property from the one the rank inequality needs. The condition **is** on the record, once, at [findings/sym3-blocks.md:130](../findings/sym3-blocks.md#L130), and it is written there as L87's defect, in a block that does not say the same question applies to L62 and that L62 answers it affirmatively.

## 6. The neighbour: L87, built the same way in outline, and failing the condition

[Lemma L87](../findings/sym3-blocks.md) squeezes the same way: a theoretical cap of $3570=\sum_\lambda d_\lambda$ over the sixteen $\lambda_2$-even blocks, and a mod-$p$ rank meeting it, so the sixteen evaluation maps are all nonzero and every even block loses exactly one multiplicity. The measurement is [scripts/reviewers/r178/orbit_span.sage](../scripts/reviewers/r178/orbit_span.sage), and the difference from L62 is in its first four lines of sampling:

- $A$ is a random skew matrix **over $\mathrm{GF}(46337)$**, `a = F.random_element()` at [orbit_span.sage:35](../scripts/reviewers/r178/orbit_span.sage#L35);
- $g=(I-A)(I+A)^{-1}$ is its Cayley transform, an element of $O(5,\mathbb F_p)$ and of nothing else;
- the orbit points $W_g=\Lambda^2(g)\,W_0\,\Lambda^2(g)^{\mathsf T}$, and the Gram $\langle W_a,W_b\rangle^3$ whose rank is read, live in characteristic $p$ from the start.

So **the matrix whose rank is $3570$ is the reduction of nothing that was formed**, and step (b) has no rational matrix to point at. This is exactly the difference: L62 draws its points over $\mathbb Q$ and then reduces; L87 draws its points in $\mathbb F_p$ and never had a characteristic-zero object. The record already carries the observation, at [findings/sym3-blocks.md:130](../findings/sym3-blocks.md#L130), together with the further point that the direct characteristic-$p$ route is closed, $p$ divides $\lvert O(5,\mathbb F_p)\rvert$, so $\mathrm{Sym}^3\mathcal W_5$ is not semisimple there and the isotypic decomposition the cap $3570$ depends on does not exist.

**The repair works, and it is worth writing out, since the record names it in half a sentence and supplies it nowhere.** Lift $A$ entrywise to an integer skew $\tilde A$. Then $\det(I+\tilde A)\ge1$: for real skew $\tilde A$ the matrix $I+\tilde A$ has eigenvalues $1\pm i s_j$ in conjugate pairs, so $\det(I+\tilde A)=\prod_j(1+s_j^2)\ge1$, with the value a positive integer here. The Cayley transform $\tilde g=(I-\tilde A)(I+\tilde A)^{-1}$ is therefore defined over $\mathbb Q$ and is genuinely orthogonal, so $\tilde g\in O(5,\mathbb Q)\subset O(5,\mathbb R)$ and $\tilde g\cdot W_0$ is a genuine point of the real orbit. Its entries are $p$-integral because $\det(I+\tilde A)\equiv\det(I+A)\not\equiv0$, the run having discarded the singular draws at [orbit_span.sage:37](../scripts/reviewers/r178/orbit_span.sage#L37). Reduction being a ring homomorphism, $\tilde g$ reduces to $g$, the lifted Gram reduces to the computed one, and the squeeze then runs on genuine characteristic-zero orbit points: $3570=\operatorname{rank}_{\mathbb F_p}\le\operatorname{rank}_{\mathbb Q}\le3570$. **L87's conclusion survives; L87's stated warrant does not, and the two-line lift is what closes the distance.**

The asymmetry is worth naming plainly, because the record's status table at [results.md:23](../results.md#L23) treats the two measurements as one kind of thing, "L87's rank and L62's value are proofs rather than measurements": L62's inequality is licensed by the objects the pipeline actually builds, and L87's needs an argument that is not on the record.

## 7. The strongest defence of the step, and what would overturn it

The strongest reading the words support is not the general one. Read as a bare claim about matrices ("reduction modulo a prime can only lower rank"), the sentence is false as stated, since a rational matrix with $p$ in a denominator has no reduction at all and a matrix born in $\mathbb F_p$ has no rank over $\mathbb Q$ to be compared with. Read as a claim about **this** pipeline's matrix, it is true, and true for a reason the author may well have had and did not write: the sample points are `Fraction` vectors drawn before the prime is read from the environment, the adapted basis is a cached $\mathbb Q(i)$ object, and every branch downstream keys on non-vanishing rather than vanishing, so the characteristic-$p$ matrix is the reduction of a rational matrix that the CRT lift went on to exhibit entry by entry. That is the hypothesis the step needs, and it holds.

What would overturn the verdict, and what would not:

- **Overturn.** A cached adapted-basis coefficient, or a $\mathrm{Sym}^3$ inner-product value, whose denominator is divisible by one of the four primes. `gp` would then have substituted the reduction of a pole silently and the dumped rows would not be the reduction of $A^{\mathbb Q}$. Settling this by computation is outside this brief's footing; the a posteriori CRT reconstruction of §3 is what stands against it, and it stands strongly, since a poisoned entry at one prime would have to reconstruct consistently against three clean ones.
- **Does not overturn.** The unresolved questions around L62 that sit on other steps, the equivariant-copy hypothesis behind (c), the pointer dispute in L62's Gate 2 notes, the `Lemma`/`Observation` split. Step (b) is sound independently of all three.

**Recommendation, recorded and not applied.** L62's blocks in [results.md](../results.md) and [findings/sym3-blocks.md](../findings/sym3-blocks.md) would carry their own warrant if the clause read *"and the sampled matrix is the reduction of a rational one (its points are drawn over $\mathbb Q$ before the prime is chosen) so reduction modulo a prime can only lower the rank further"*. The same sentence, applied to L87, is what that block still owes.
