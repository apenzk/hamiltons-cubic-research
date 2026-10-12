# Review r193, the abstract reading is the right one, and the kappa identity is a tautology

Gate 2, adversarial. Everything below was re-derived from definitions and re-measured with scripts written for this review, under [scripts/reviewers/r193/](../scripts/reviewers/r193/). Exact arithmetic over $\mathbb Q(i)$ throughout; the only floating-point numbers are the eigenvalues in the cone witness of claim 1 and wall-clock times.

## Verdict table

| Claim | Verdict | What decided it |
| --- | --- | --- |
| 1, the current abstract reading in [run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py) step 4: $B_{ij}=\overline{c^i}^{\mathsf T}Qc^j$ with no multiplicity-Gram factor, $Q$ read off copy 1 | **Correct as it stands, and the revert was right** | $G$ is the Gram *of a form on the multiplicity space*, not the matrix of an operator, so "$G$ PSD" is basis-free and needs no metric. Inserting $h$ replaces the feasible cone $\{G\succeq0\}$ by $\{G\circ h^{\circ-1}\succeq0\}$; for the measured $h$ of block $(2,2)$ the reciprocal $h^{\circ-1}$ has eigenvalues of both signs, so the two cones differ and the abstract one is the larger and the exact one |
| 1a, 192's warning that the two readings are not interchangeable | **Upheld, with the direction pinned** | Schur's product theorem gives $\{G\circ h:G\succeq0\}\subseteq\{G\succeq0\}$ one way only. The $h$-inserted reading is *sound but strictly conservative*: it can never certify a false $F\ge0$, it can only report a spurious infeasibility |
| 1b, the Schur factorisation $\langle R_i[t],R_j[s]\rangle=h_{ij}Q_{ts}$ the reading rests on | **Confirmed exactly, on three blocks, by machinery independent of the pipeline's** | Lowering operators rebuilt as adjoints of the cached raising operators. $17$ non-vacuous word-position pairs across $\lambda=(2,2),(2,1),(3,2)$ (multiplicities $4,2,3$), every entry of every $m\times m$ block an exact rational multiple of $N$. Per-copy replay as the negative control breaks it |
| 2, $\kappa=6$ as a joint check on the metric, the cube map and the coordinate solve | **Refuted. It is an algebraic identity in $w$ and in $H$, and it pins none of the three** | $\sum_{t,s}m_tm_sw^t\overline{w^s}\,\mathrm{ip}(t,s)=3!\,\lVert W\rVert^6$ for **every** $w\in\mathbb C^{35}$ and **every** $H$. Measured: $\kappa=6$ with $w$ a random vector that is nobody's coordinate vector, $\kappa=6$ with an off-diagonal entry of $H$ perturbed, $\kappa=6$ with $H$ replaced outright by a random Hermitian matrix |
| 2a, "can a compensating pair of errors preserve it?" | **Yes, and one is exhibited** | Drop the multinomial from `cube` and multiply `sym3_ip` by $m_tm_s$, that is $36\times$ MULT_UP, a convention 191's adjointness test *rejects*: each half alone gives $\kappa\ne6$, the two together give exactly $6$ |
| 3, the repaired cross-weight check, $0$ nonzero of $\sim1180$ | **Confirmed, and it can fail** | Independent rebuild: $45$ within-weight nonzeros, $0$ of the $1168$ cross-weight pairs nonzero. It is falsifiable because it tests the *cache's recorded weight labels* against the tensors, not a tautology, but its scope is narrower than it reads: it cannot see whether the form is invariant |
| 4, stage 3's three checks | **None of the three exists in the file** | [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) is $64$ lines and stops after indexing the adapted vectors by weight. It never forms $B$, never touches the trivial block, never builds a coefficient matrix, never takes a rank |
| 4a, "B must be Hermitian at every sample point" | **Would be near-vacuous if written** | $B_{ij}=\overline{c^i}^{\mathsf T}Qc^j$ with one Hermitian $Q$ is Hermitian for *any* $c$ whatsoever. It is a conjugation-bug detector and is blind to every error in the $c$, in the adapted basis and in the per-weight solve |
| 4b, the trivial block gives $B_{11}\propto\operatorname{tr}(W^3)^2$ | **Well posed and falsifiable, given a constant fitted rather than predicted** | $\dim(\mathrm{Sym}^3\mathcal W_5)^{SO(5)}=1$, recomputed here by an independent route, so the proportionality is forced by representation theory and only the implementation is under test. The falsifiable form is *the same ratio at two or more points* |
| 4c, "rank at most 14" | **The right bound, but one-sided; the sharp statement is rank exactly $14$** | $\dim(\mathrm{Sym}^6\mathcal W_5)^{SO(5)}=14$ recomputed independently (Brauer alternating sum over $W(B_2)$, full sequence $1,1,4,5,14$). Every invariant sextic *is* $\langle AW^3,W^3\rangle$ for some equivariant $A$, so the $B_{ij}$ span the whole $14$-dimensional space. Rank **below** $14$ is the likelier failure and the stated check is blind to it |

---

## Claim 1, which object the SDP's $G$ is dual to

### The step-4 docstring answers the wrong question, and still reaches the right answer

The text argues about *which object $c$ is*: $R_i[t]=\varphi_i(b_t)$, so $y_i=\sum_tc^i_tR_i[t]=\varphi_i(x_i)$ with $x_i=\sum_tc^i_tb_t\in V(\lambda)$ abstract, hence $c$ is a coordinate vector in $V(\lambda)$. That much is right, and 192 proved it. But it does not by itself decide the question, because the ambient Gram $\langle y_i,y_j\rangle=h_{ij}\langle x_i,x_j\rangle_\lambda$ is *also* expressible in those same abstract coordinates. What decides it is which object the unknown $G$ is dual to, and the docstring never says.

Here is the missing link, and it settles the matter in the direction the file now takes.

Fix a block and write the $\lambda$-isotypic component of $\mathrm{Sym}^3\mathcal W_5$ as $V(\lambda)\otimes M$, $M\cong\mathbb C^m$ the multiplicity space, $\Phi(x\otimes e_i)=\varphi_i(x)$. The ambient invariant Hermitian form restricts to $\langle\,,\rangle_\lambda\otimes\langle\,,\rangle_M$, and $\langle e_i,e_j\rangle_M=h_{ij}$ *by definition of $h$*. Every equivariant self-adjoint $A$ on the block is $1\otimes a$ with $a$ self-adjoint for $\langle\,,\rangle_M$ (Schur). Writing $W^3_\lambda=\sum_ix_i\otimes e_i$,

$$\langle AW^3,W^3\rangle\;=\;\sum_{i,j}\langle x_i,x_j\rangle_\lambda\,\langle ae_i,e_j\rangle_M\;=\;\sum_{i,j}G_{ij}B_{ij},\qquad B_{ij}:=\langle x_i,x_j\rangle_\lambda,\quad G_{ij}:=\langle ae_i,e_j\rangle_M.$$

Two things follow immediately.

- $B$ is the **abstract** Gram, exactly $\overline{c^i}^{\mathsf T}Qc^j$, with no $h$.
- $G$ is the Gram *of the Hermitian form* $(u,v)\mapsto\langle au,v\rangle_M$ in the copy basis. "$A\succeq0$" is "that form is positive semidefinite", which is "$G\succeq0$ as a matrix" **in any basis at all**. The metric $h$ never appears, because a form's Gram carries the metric already; $h$ would only be needed to convert $G$ back into the *operator* $a$, and nothing downstream wants the operator.

So the correspondence $A\succeq0\iff G\succeq0$ is exact, with $B$ the abstract Gram. The current text is right.

### The over-correction was sound, and strictly conservative

The alternative object is the ambient Gram $B'_{ij}=\langle y_i,y_j\rangle=h_{ij}B_{ij}$, i.e. $B'=h\circ B$. It is also a Gram matrix, hence also PSD pointwise, so $\sum G'_{ij}B'_{ij}\ge0$ whenever $G'\succeq0$: inserting $h$ **cannot manufacture a false certificate**. What it does is move the feasible set. Representing the same $F$ needs $G'=G\circ h^{\circ-1}$, so the reachable cone is

$$\{\,h\circ G' \;:\; G'\succeq0\,\}\;\subseteq\;\{\,G\succeq0\,\},$$

an inclusion by the Schur product theorem, and one-directional: entrywise reciprocation does not preserve PSD. This is 192's warning, and it is exactly right; what it did not say is which side is the larger, and the derivation above says the abstract one is, and that the abstract one is the *exact* image of $\{A\succeq0\}$.

The inclusion is strict for the actual $h$, not merely in principle. Measured on block $\lambda=(2,2)$, multiplicity $4$ ([schur_test.py](../scripts/reviewers/r193/schur_test.py)):

$$N=\langle u_i,u_j\rangle=\begin{pmatrix}2727936&-393216&-921600\,i&-1474560\\-393216&4456448&491520\,i&-983040\\921600\,i&-491520\,i&1566720&-184320\,i\\-1474560&-983040&184320\,i&2949120\end{pmatrix},$$

positive definite with eigenvalues $\approx(7.99,14.96,43.94,50.11)\times10^5$, Hermitian, **complex and far from diagonal**. Its entrywise reciprocal $h^{\circ-1}$ has eigenvalues of ratio $(-0.889,-0.276,+0.406,+1)$, indefinite. So $G=J$, the all-ones matrix, is a legal PSD unknown in the abstract reading whose $h$-inserted image $J\circ h^{\circ-1}=h^{\circ-1}$ is not PSD: an explicit certificate the inserted-$h$ SDP would refuse.

That $h$ is non-diagonal also disposes of the worst case. Had the copies come out ambient-orthogonal, $h$ would be diagonal, $h\circ G$ would kill every off-diagonal unknown outright, and the inserted-$h$ SDP would silently have collapsed the $36$ unknowns onto their diagonal. It does not, but only by measurement.

### The factorisation the whole reading rests on, tested against the code

Everything above uses $\langle\varphi_ix,\varphi_jy\rangle=h_{ij}\langle x,y\rangle_\lambda$, equivalently

$$\langle R_i[t],R_j[s]\rangle=h_{ij}\,Q_{ts},$$

which is Schur's lemma and therefore a statement about the *code*, not about the mathematics. 192 measured it as a Kronecker test at $0$ failures of $784$ and $3136$. [schur_test.py](../scripts/reviewers/r193/schur_test.py) re-measures it with independent machinery: the lowering operators are rebuilt here as the adjoints of the cached raising operators for the ambient form (solving $\sum_sH_{xs}u_s=(EH)_{xy}$ per weight block) rather than taken from [run_n5_highest_weight.py](../scripts/runs/run_n5_highest_weight.py)'s root vectors. They come out with weight shifts $(-1,+1)$ and $(0,-1)$, one negative root each, which is the self-test that the adjoint was built correctly; any scalar mis-normalisation cancels out of a proportionality test.

For each pair of word positions the $m\times m$ matrix $\langle R_i[t],R_j[s]\rangle$ must be one scalar multiple of $N$:

| block | mult | non-vacuous position pairs | exact factors | failures |
| --- | --- | --- | --- | --- |
| $(2,2)$ | $4$ | $3$ | $4,\;24,\;16$ | $0$ of $48$ entries |
| $(2,1)$ | $2$ | $7$ | $4,\;2,\;4,\;16,\;8,\;8,\;16$ | $0$ of $28$ entries |
| $(3,2)$ | $3$ | $7$ | $4,\;4,\;24,\;32,\;16,\;16,\;24$ | $0$ of $63$ entries |

Off-diagonal position pairs $t\ne s$ are included and non-vacuous ($[1,0]\times[0,1]$ pairs at factors $8$ and $16$) so the test sees $Q$ off its diagonal, which is where a wrong identification would hide. **The negative control breaks it in every block**: giving copy $2$ a different lowering word, which is precisely the per-copy word list [run_n5_adapted.py](../scripts/runs/run_n5_adapted.py) exists to prevent, destroys proportionality.

So: the abstract reading is correct, the revert was correct, and the reason to be given for it is the one above rather than the one in the docstring.

---

## Claim 2, $\kappa=6$ is an identity, and it pins nothing

### Proof

Let $H$ be *any* function $[35]^2\to\mathbb C$ (missing entries read as $0$, as the code reads them), let $w\in\mathbb C^{35}$ be *any* vector, and use the file's own definitions,

$$\mathrm{cube}(w)_t=m_t\,w^t,\qquad m_t=\frac{3!}{|\mathrm{Aut}(t)|},\qquad \mathrm{ip}(t,s)=\sum_{\sigma\in S_3}\prod_{i=1}^3H(t_i,s_{\sigma(i)}).$$

Each unordered multiset $t$ has exactly $m_t$ orderings, and $\mathrm{ip}$ depends only on the multisets, so summing over unordered pairs with the weights $m_tm_s$ is summing over *ordered* triples $A,B\in[35]^3$:

$$\sum_{t,s}m_tm_s\,w^t\overline{w^s}\,\mathrm{ip}(t,s)=\sum_{A,B}w_A\overline{w_B}\sum_{\sigma}\prod_iH(A_i,B_{\sigma(i)})=\sum_{\sigma}\prod_{i=1}^3\Big(\sum_{a,b}w_a\overline{w_b}H(a,b)\Big)=3!\,\big(\lVert W\rVert^2\big)^3,$$

reindexing $B$ by $\sigma$ inside each factor. Hence $\kappa\equiv3!=6$. **No property of $H$ is used, not Hermitian symmetry, not positivity, not invariance, not even that it is the Gram of anything, and no property of $w$ is used.** The numerator and the denominator are computed from the same $w$ and the same $H$, so the ratio is blind to both.

The claim at [run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py) lines 211–214, "breaking any ONE of the three destroys its constancy, so it is a check all three must pass jointly", is therefore false on all three counts.

### Measured

[kappa_and_h.py](../scripts/reviewers/r193/kappa_and_h.py), exact rational arithmetic, weight-grouped summation ($921{,}780$ pairs against the $7770^2=60.4$ million the committed double loop evaluates):

| what is broken | $\kappa$ |
| --- | --- |
| nothing, a random rational Weyl tensor through `coords` | $6$ |
| $w$ replaced by a random complex vector that is nobody's coordinate vector | $6$ |
| one within-weight **off-diagonal** entry of $H$ perturbed by $7/3+5i/2$ | $6$ |
| $H$ replaced outright by a random Hermitian block matrix | $6$ |

The second line kills the coordinate-solve half of the claim; the third and fourth kill the metric half. The third is the sharpest: those ten off-diagonal entries are the ones the file's own comment at lines $120$–$123$ singles out as where the conventions part company and "nothing else in the pipeline looks", and $\kappa$ does not look either.

### The compensating pair

Any pair of scalings $\mathrm{cube}(w)_t=\lambda_t w^t$ and $\mathrm{ip}\mapsto\mu_{ts}\,\mathrm{ip}$ with $\lambda_t\lambda_s\mu_{ts}=m_tm_s$ reproduces $\kappa=6$. The instructive instance is $\lambda_t=1$, $\mu_{ts}=m_tm_s$: the cube map loses its multinomial and the metric becomes $36\times$ MULT_UP, the divide-by-$|\mathrm{Aut}(t)||\mathrm{Aut}(s)|$ convention that 191's adjointness test **rejects with a witness**. Measured on the same sample point:

| variant | $\kappa$ |
| --- | --- |
| `cube` without the multinomial, `sym3_ip` unchanged | $83576322407/330576748544$ |
| `cube` unchanged, $\mathrm{ip}=m_tm_s\times(\text{bijection sum})$ | $2319596130027/11806312448$ |
| **both together** | $\mathbf{6}$ |
| permutation sum dropped, `cube` unchanged | $464843073377/82644187136$ |
| $w$ scaled by $2$ (control) | $6$ |

So $\kappa=6$ is consistent with a metric convention already refuted by a test that does have teeth. It is a check on one product of normalisations, not on three objects.

### What should be checked instead

Two replacements, both cheap, both able to fail, both run here.

1. **The round trip.** $W=\sum_aw_af_a$ from the solved coordinates, entry by entry on the rank-$4$ tensor: $0$ bad entries of $625$. This is the check $\kappa$ is claimed to provide for the coordinate solve and does not.
2. **Parseval against the block decomposition.** The identity proved above says $\lVert W^3\rVert^2=6\lVert W\rVert^6$ *exactly*, and orthogonality of isotypic components says $\lVert W^3\rVert^2=\sum_\lambda\sum_{ij}h^\lambda_{ij}B^\lambda_{ij}$. So

$$\sum_\lambda\sum_{i,j}h^\lambda_{ij}\,B^\lambda_{ij}\;=\;6\,\lVert W\rVert^6$$

is one scalar equation per sample point tying the block decomposition, the multiplicity Grams and $B$ together, and it *can* fail: a missing copy, a mis-scaled $Q$, a per-weight solve that leaks between blocks all break it. It is also where $h_{ij}$ genuinely belongs. If $Q$ is read off copy 1, the left side is $\sum_\lambda(h^\lambda_{11})^{-1}\sum_{ij}h^\lambda_{ij}\tilde B^\lambda_{ij}$.

Two further remarks on the block as committed. The imaginary-part line at line $251$ reads `tot` and `n2` leaked from the loop body, so it reports the last trial only. And the double loop at lines $236$–$242$ evaluates all $7770^2$ monomial pairs where $\mathrm{ip}$ vanishes off the weight diagonal; grouping by weight cuts that to $921{,}780$, a factor of $65$, and is what makes the check affordable to run more than once.

---

## Claim 3, the repaired cross-weight check

Confirmed by an independent rebuild in [kappa_and_h.py](../scripts/reviewers/r193/kappa_and_h.py), which recomputes $H$ from the cached tensors with a sparse representation and no weight filter anywhere: **$45$ within-weight nonzero entries and $0$ nonzero among the $1168$ cross-weight pairs.** The arithmetic behind the count: the $35$ weight-basis vectors carry $25$ distinct weights, $16$ of multiplicity $1$, eight of multiplicity $2$, one of multiplicity $3$, so $\sum_\mu m_\mu^2=57$ ordered within-weight pairs and $1225-57=1168$ across. Of the $57$, the $35$ diagonal ones and $10$ of the $22$ off-diagonal ones are nonzero, so $45$ does carry information, and the ten are exactly the entries the metric-convention comment at lines $120$–$123$ says nothing else in the pipeline looks at.

**It can fail.** Orthogonality of distinct weight spaces is a theorem for an invariant Hermitian form, so what the check tests is that the tensors in the cache really do have the weights the cache records for them; a mislabelled or corrupted row shows up here and, as the file says, nowhere else. It is a genuine check on the cache.

**Its scope is narrower than the wording suggests.** Block-diagonality by weight does *not* imply the form is invariant, any diagonal reweighting of the weight basis stays block-diagonal and destroys invariance. The invariance is a separate fact, established by 183's exact identity $A^{\mathsf T}G+GA=0$ on all ten generators, and the cross-weight check adds nothing to it.

Two checks that the same rebuild adds for free, and that the file does not make: $H$ is **Hermitian** ($H_{ba}=\overline{H_{ab}}$ on all $45$ entries) and **positive definite** on every weight block (all leading principal minors real and positive). The second is what the per-weight Gaussian elimination in `coords` implicitly assumes when it looks for a pivot.

---

## Claim 4, stage 3's own checks

### The three checks are not in the file

[run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) is $64$ lines. It loads the adapted basis, indexes the $7770$ adapted vectors by weight, prints the weight-class sizes and the sum of their squares, and stops. There is no $B$, no trivial block, no coefficient matrix, no rank. The docstring's "Checks that can fail, run before the solve" describes three checks that do not run, before a solve that does not happen. Everything below is therefore about what those checks *would* be worth.

### 4a, $B$ Hermitian: near-vacuous

If $B_{ij}=\overline{c^i}^{\mathsf T}Qc^j$ is formed from one Hermitian $Q$ and one array of $c$, then $B_{ji}=\overline{B_{ij}}$ identically, for *any* $c$ at all. The check can only fail if $Q$ comes out non-Hermitian or if the code assembles $(i,j)$ and $(j,i)$ from different data, a conjugation-bug detector, which is worth something given that 191 reports a transpose break, but it is blind to every error in the coordinates, in the adapted basis, in the per-weight solve and in the block labelling.

Three checks in its place that can fail on the real content: **$B\succeq0$ at every sample point** (it is a Gram matrix, and this also catches a $Q$ that has lost positivity); the **Parseval identity** of claim 2 above; and **invariance**, $B_{ij}(gW)=B_{ij}(W)$ for a rational $g\in SO(5)$ from a Cayley transform, which is the one check that exercises the whole chain at once and is what the rank bound of 4c only tests in aggregate.

### 4b, the trivial block

$\dim(\mathrm{Sym}^3\mathcal W_5)^{SO(5)}=1$, recomputed here ([invariant_counts.py](../scripts/reviewers/r193/invariant_counts.py)) by a route independent of both the Weyl-integration count and the contraction identity: the Brauer alternating sum $\dim M^{\mathfrak g}=\sum_{w\in W(B_2)}\mathrm{sgn}(w)\dim M_{w\rho-\rho}$ over weight multiplicities of $\mathrm{Sym}^k$ obtained by a multiset DP on the $35$ weights of $\mathcal W_5=V(2,2)$. The self-test $\dim\mathcal W_5^{SO(5)}=0$ passes and the $\mathrm{Sym}^k$ dimensions reproduce $\binom{34+k}{k}$.

| $k$ | $2$ | $3$ | $4$ | $5$ | $6$ |
| --- | --- | --- | --- | --- | --- |
| $\dim(\mathrm{Sym}^k\mathcal W_5)^{SO(5)}$ | $1$ | $1$ | $4$ | $5$ | $14$ |

Multiplicity $1$ at $k=3$ means the trivial block's single coordinate $c^1$ *is* the cubic invariant up to scale, and $\operatorname{tr}(W^3)$ is a nonzero one, so $B_{11}=|c^1|^2Q_{11}$ is forced to be a positive multiple of $\operatorname{tr}(W^3)^2$. The check tests only the implementation, and it can fail, since a per-weight solve that leaks another block into the trivial coordinate breaks it. The constant is not predictable, for the normalisation reason the file already records at lines $45$–$48$, so the falsifiable form is **the same ratio at two or more sample points, and positive**; a single point cannot fail.

### 4c, the rank bound

$14=\dim(\mathrm{Sym}^6\mathcal W_5)^{SO(5)}$ is confirmed above by the third independent method, and at odd $n$ the $O(5)$ and $SO(5)$ counts agree since $-I$ acts trivially. Each $B_{ij}$ is an invariant sextic ($W\mapsto y_i(W)$ is equivariant and the form is invariant) so the columns of the coefficient matrix lie in a $14$-dimensional space of functions and **rank $\le14$ is right**, over $\mathbb R$ as well, since the real and imaginary parts of $B_{ij}$ are separately real invariant sextics.

It is one-sided, and the sharp statement is **rank exactly $14$** at generic sample points. Every invariant sextic is reachable: an invariant $J\in(\mathrm{Sym}^6\mathcal W_5)^*$ pulls back to the invariant functional $a\otimes b\mapsto J(ab)$ on $\mathrm{Sym}^3\otimes\mathrm{Sym}^3$, every invariant sesquilinear form there is $\langle A\cdot,\cdot\rangle$ for an equivariant $A$ because $\mathcal W_5$ is real, and evaluating at $W^3\otimes W^3$ gives $J(W^6)=J$ back. So $\mathrm{span}\{B_{ij}\}$ is the whole $14$-dimensional space, and with $\ge14$ generic points the rank is exactly $14$. There are $\sum_\lambda m_\lambda^2=2\cdot16+9+9\cdot4+12=89$ complex unknowns before the orbit constraint, so the kernel is large and expected.

What each direction diagnoses:

- **Rank $>14$** means the $B_{ij}$ are not invariant functions. The live cause is an identification of copies that is not the $\mathfrak g$-map (the per-copy word list) or a metric that is not the invariant one. Both are already covered by tests with witnesses (192's Kronecker test, the negative control above), so this is a backstop rather than a primary check.
- **Rank $<14$** with enough generic points is the likelier failure and the stated check is blind to it: a block dropped from the sum, a per-weight solve that silently returned a partial expansion, a $Q$ that degenerated on some copy. It also matters downstream, because "the $14\times36$ system" presupposes $14$ *independent* constraints; a deficient rank makes the system more under-determined than the record says, and quietly.

The check to write is therefore "rank equals $14$ on $\ge20$ generic points", with the two failure directions reported separately.

---

## What was run

| script | cost | what it establishes |
| --- | --- | --- |
| [invariant_counts.py](../scripts/reviewers/r193/invariant_counts.py) | $3$ s | $1,1,4,5,14$ by Brauer alternating sum; the $14$ and the trivial multiplicity $1$, independent of Weyl integration |
| [kappa_and_h.py](../scripts/reviewers/r193/kappa_and_h.py) | $73$ s | $H$ Hermitian, positive definite, $0$ of $1168$ cross-weight nonzeros; round trip $0$ of $625$; $\kappa=6$ under four mutually exclusive breakages; the compensating pair |
| [schur_test.py](../scripts/reviewers/r193/schur_test.py) | $5$ s | $\langle R_i[t],R_j[s]\rangle=h_{ij}Q_{ts}$ exactly on three blocks with independent lowering operators; the per-copy negative control; the indefinite $h^{\circ-1}$ witness |

## Checks in the current text that could not fail

Added to the running table.

| check | why it cannot fail |
| --- | --- |
| $\kappa=6$, in all three of its stated roles | an identity in $w$ and in $H$; see claim 2 |
| "constant across trials" at line $250$ | the same identity, weaker |
| $B$ Hermitian, as described for stage 3 | automatic for any $c$ once $Q$ is Hermitian |
| the trivial block at a **single** sample point | the constant is unnormalised, so one point fits it |
