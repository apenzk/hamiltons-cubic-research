# Gate 2, reviewer 133, the Kähler closed form and the branch-1 census

Cold review of commits `910ebd4`, `8d73e1a`, `ed5718a` (and of `103b543`, which rewrote the census passage mid-review), against [findings/target.md](../findings/target.md), [findings/algebra.md](../findings/algebra.md), [findings/graded-half.md](../findings/graded-half.md) and [references/bourguignon-karcher-1978-pinching/README.md](../references/bourguignon-karcher-1978-pinching/README.md). Everything below was derived before opening [scripts/](../scripts/); no script was read at any point.

## Verdict table

| Claim | Verdict |
| --- | --- |
| **A**, Bourguignon–Karcher's $\mathring R(\mathbb{CP}^m)$ spectrum $-2^{(m^2-1)}$, $4^{(m(m+1))}$ | **CONFIRMED**, and re-derived here from the Fubini–Study curvature tensor rather than quoted |
| **B**, $\mathring W=\mathring R-c\,\mathrm{Id}$ on $S^2_0$ with $c=2(m+1)/(2m-1)$ | **CONFIRMED as a statement**; its *stated derivation* is incomplete, see below |
| **C**, $\mu(\mathbb{CP}^m)=\sqrt{3m/((m^2-1)(2m-1))}$ | **CONFIRMED**, independently |
| **D**, $\theta\mu=1/(m-1)$ at $\mathbb{CP}^m$ | **CONFIRMED**, and $\theta^2(\mathbb{CP}^m)$ re-derived independently so D no longer inherits an unchecked input |
| **E**, branch 1 fails on the whole Kähler family | **CONFIRMED**; the failure factor is exactly $2(m+1)/3$ in $\theta^2$, and it survives every padding |
| **F**, every catalogued $\theta>\sqrt{3/2}$ is a sphere product | **CONFIRMED as a statement, OVERSTATED as a census.** I hunted for a non-product witness numerically, symbolically and by construction and found none, so F and G are not falsified. But the *list* is wrong, and `103b543` did not fix it: it still omits the catalogue's largest value, $S^{12}\times S^{12}$ at $1.325498$, and roughly 60 further points, while now claiming a full walk of [findings/](../findings/) |
| **G**, branch 1 is an equality at every sphere product; unfalsifiable where it matters | **Equality CONFIRMED and strengthened** (it holds at every product of round spheres, any number of factors, and I give the mechanism). **"Unfalsifiable … since such a point would be a counterexample to the conjecture" is FALSE** as an implication |

## 1. Claim A, re-derived rather than quoted

The record has this only through Li, and the reference note says the paper is not stored. It does not need to be. Take Fubini–Study with constant holomorphic sectional curvature $4$, $J$ the complex structure, $J_{ij}=\langle Je_i,e_j\rangle$:

$$R_{ijkl}=g_{ik}g_{jl}-g_{il}g_{jk}+J_{ik}J_{jl}-J_{il}J_{jk}+2J_{ij}J_{kl},$$

which gives $R_{ijij}=1$ on a $J$-orthogonal $2$-plane and $4$ on a holomorphic one. Contract in the record's $iklj$ order, $(\mathring Rh)_{ij}=\sum_{kl}R_{iklj}h_{kl}$, against a trace-free symmetric $h$. The $-g_{ij}g_{kl}$ and $-J_{ij}J_{kl}$ terms die on $\mathrm{tr}\,h=0$ and on $h$ symmetric against $J$ antisymmetric; the survivors are $g_{il}g_{kj}\mapsto h$, $J_{il}J_{kj}\mapsto JhJ$ and $2J_{ik}J_{lj}\mapsto 2JhJ$. So

$$\boxed{\ \mathring R=\mathrm{Id}+3\mathcal J\ \text{on }S^2_0,\qquad \mathcal Jh:=JhJ.\ }$$

$\mathcal J^2=\mathrm{Id}$ because $J^2=-\mathrm{Id}$, so the spectrum is $1\pm3=\{4,-2\}$ with no computation. Multiplicities are the two $\pm1$-eigenspaces of $\mathcal J$: $\mathcal Jh=-h\iff[J,h]=0$, the real form of the Hermitian $m\times m$ matrices, dimension $m^2$, trace-free part $m^2-1$, eigenvalue $-2$. $\mathcal Jh=+h\iff Jh=-hJ$, the real form of the complex *symmetric* $m\times m$ matrices, dimension $m(m+1)$, automatically trace-free, eigenvalue $4$.

Three checks fall out for free, all of which the brief asked for:

- **Multiplicity bookkeeping.** $(m^2-1)+m(m+1)=2m^2+m-1=(2m-1)(m+1)=\dim S^2_0(\mathbb{R}^{2m})$. The BK spectrum is stated on $S^2_0$, not on $S^2$, confirmed independently against [Li 2022](https://ar5iv.labs.arxiv.org/html/2208.14505), whose $\mathring R(\varphi,\psi)=\sum R_{ijkl}\varphi_{il}\psi_{jk}$ is *identical* to the record's $iklj$ contraction after relabelling.
- **The trace.** $(m^2-1)(-2)+m(m+1)\cdot4=2(m+1)^2$. Independently: $\mathop{\mathrm{tr}}_{S^2}\mathring R=\tfrac12\sum_{ab}R_{abab}=S/2$, and $\mathring Rg=-\mathrm{Ric}=-\lambda_Eg$ gives the eigenvalue on the $g$-line, so $\mathop{\mathrm{tr}}_{S^2_0}\mathring R=S/2+\lambda_E$. With $S=4m(m+1)$ and $\lambda_E=2(m+1)$ that is $2m(m+1)+2(m+1)=2(m+1)^2$. Agreement, and it pins the Fubini–Study normalisation at the same time.
- **The index order.** In the flipped $ikjl$ order the whole operator changes sign, giving $(-4,2)$, exactly what the reference note reports the cross-check returning. Better, the order is *determined*, not chosen: on the unit round sphere the $iklj$ contraction gives $\mathring R=+\mathrm{Id}$ on $S^2_0$, the $ikjl$ one gives $-\mathrm{Id}$. Since the whole subject is built on the round sphere being second-kind positive, $iklj$ is the only admissible convention. The record settles this against a 1978 paper it does not hold; it can be settled in one line against $S^n$.

**The sign is load-bearing, so it is worth saying why.** Under the flipped order the shift becomes $c=-2(m+1)/(2m-1)$ and the bottom becomes $-6(m-1)/(2m-1)$, giving $\mu=\sqrt{3(m-1)/(m(m+1)(2m-1))}$, $0.4082$ at $m=2$ against $0.8165$. Claims C, D and E would all change. The record's caveat "only in Li's $iklj$ order" is therefore not a nicety.

**Literature check.** The attribution is correct. Bourguignon–Karcher, *Curvature operators: pinching estimates and geometric examples*, Ann. Sci. ÉNS **11** (1978) 71–92, is the standard citation for this spectrum, quoted verbatim in [Li 2022](https://ar5iv.labs.arxiv.org/html/2208.14505) and [Li 2022 (JGA)](https://link.springer.com/article/10.1007/s12220-022-01033-8). **One thing the reference note drops and should carry: the normalisation.** The eigenvalues $-2$ and $4$ hold for the Fubini–Study metric of constant *holomorphic sectional curvature 4*; without that the pair of numbers is meaningless. It is harmless here only because everything is rescaled to $\lVert\mathring W\rVert^2=3$. And no source I reached carries $\mathring W$'s spectrum or $\mu(\mathbb{CP}^m)$ in closed form (Li's papers treat $\mathring R$ on $S^2_0$ and never the Weyl part) so the record's closed form appears to be its own.

## 2. Claim B, true, but the derivation on file is not the reason it is true

The commit computes $c$ as $\mathrm{trace}/\dim$. That step *presupposes* what it is meant to establish: trace-matching pins the constant only once you already know the difference is a constant. Two facts are needed and neither is stated:

1. **The shift is scalar because $\mathbb{CP}^m$ is Einstein**, and only for that reason. With $\mathrm{Ric}_0=0$ the Kulkarni–Nomizu decomposition collapses to $R_{ijkl}=W_{ijkl}+\frac{S}{n(n-1)}(g_{ik}g_{jl}-g_{il}g_{jk})$, and the second piece is the constant-curvature tensor, whose $iklj$ contraction is $+\mathrm{Id}$ on $S^2_0$. Hence, structurally,

$$\mathring R=\mathring W+\frac{S}{n(n-1)}\mathrm{Id}\ \text{ on }S^2_0,\qquad c=\frac{S}{n(n-1)}=\frac{4m(m+1)}{2m(2m-1)}=\frac{2(m+1)}{2m-1}.$$

   Same number, obtained without trace-matching. Einstein is also what makes $S^2_0$ an invariant subspace at all ($\mathring Rg=-\mathrm{Ric}$ is proportional to $g$ only then), so the restriction the whole claim is about is well posed for the same reason.
2. **$\mathop{\mathrm{tr}}_{S^2_0}\mathring W=0$**, which the trace-matching route silently uses. True because Weyl is totally trace-free: $\mathring Wg=0$ and $\mathop{\mathrm{tr}}_{S^2}\mathring W=\tfrac12\sum_{ab}W_{abab}=0$.

The arithmetic downstream is right: $-2-c=-6m/(2m-1)$, $4-c=6(m-1)/(2m-1)$, and

$$\lVert\mathring W\rVert_F^2=\frac{36}{(2m-1)^2}\big[(m^2-1)m^2+m(m+1)(m-1)^2\big]=\frac{36\,m(m+1)(m-1)}{2m-1},$$

with the eigenvalues summing to zero as they must. **Verdict: the claim is CONFIRMED, the write-up should replace "subtracts $c=\mathrm{trace}/\dim$" with "subtracts $S/(n(n-1))$, because Einstein makes $R-W$ a constant-curvature tensor".** As written, a reader cannot tell that Einstein is a hypothesis, and B is false without it.

## 3. Claim on normalisation, CONFIRMED, and here is the identity

The brief asks whether $|W|=1$ really gives $\lVert\mathring W\rVert_F^2=3$, and on which space. It does, and it is an identity rather than a convention.

Write $\hat W_{ij,kl}=\tfrac12(W_{ikjl}+W_{iljk})$ for the symmetrised kernel (symmetric in $ij$, in $kl$, and under pair swap, each by pair symmetry). Then $\lVert\mathring W\rVert_F^2=\sum_{ijkl}\hat W_{ij,kl}^2=\tfrac12(A+B)$ with $A=\sum W_{ikjl}^2=|W|_4^2$ and $B=\sum W_{ikjl}W_{iljk}$. First Bianchi gives $B=|W|_4^2-C$ with $C=\sum W_{abcd}W_{acbd}$, and contracting the Bianchi identity against $W$ gives the classical $C=\tfrac12|W|_4^2$. Hence

$$\boxed{\ \lVert\mathring W\rVert_F^2=\tfrac34\,|W|_4^2=3\,\lVert W\rVert_{\Lambda^2}^2\ }$$

where $|W|_4^2=\sum_{ijkl}W_{ijkl}^2$ and $\lVert W\rVert_{\Lambda^2}^2=\sum_{i<j,k<l}W_{ijkl}^2$ is the Frobenius norm of $W$ as an operator on $\Lambda^2$, which is the project's $|W|$. So $|W|=1\Rightarrow\lVert\mathring W\rVert_F^2=3$, for **every** Weyl tensor, with no criticality and no symmetry. The record asserts this; it is worth recording as the one-line consequence of first Bianchi that it is.

## 4. Claims C, D, E, all CONFIRMED, and D no longer rests on an unchecked $\theta^2$

$\mu$ is the bottom of $\mathring W$ after scaling to $\lVert\mathring W\rVert^2=3$:

$$\mu=\frac{6m}{2m-1}\cdot\sqrt{\frac{3(2m-1)}{36\,m(m+1)(m-1)}}=\sqrt{\frac{3m}{(m^2-1)(2m-1)}}.$$

Reproduces $0.8164966$, $0.4743416$, $0.3380617$, $0.2635231$, $0.2162250$, $0.1834498$ at $m=2,\dots,7$, the recorded table exactly. **C CONFIRMED.**

D inherits $\theta^2(\mathbb{CP}^m)$ from [algebra.md](../findings/algebra.md), where it comes from Fox's norm identity. **That input is now independently confirmed, by a route that uses nothing of Fox.** Convert my $\lVert\mathring W\rVert^2$ to the record's Einstein-constant-$\tfrac12$ normalisation: $\lVert W\rVert_{\Lambda^2}^2=\tfrac13\lVert\mathring W\rVert^2=12m(m^2-1)/(2m-1)$ at holomorphic sectional curvature $4$, and rescaling the metric by $\sigma=4(m+1)$ to reach $\mathrm{Ric}=\tfrac12g$ divides the curvature operator by $\sigma$:

$$\lVert W\rVert^2=\frac{3m(m-1)}{4(m+1)(2m-1)},\qquad\text{so }\lVert W\rVert^2(\mathbb{CP}^2)=\tfrac16,$$

matching [graded-half.md](../findings/graded-half.md) exactly. With $\theta=1/(2\lVert W\rVert)$ this is $\theta^2=(m+1)(2m-1)/(3m(m-1))$, the record's value, from the curvature tensor alone. Then

$$\theta^2\mu^2=\frac{(m+1)(2m-1)}{3m(m-1)}\cdot\frac{3m}{(m^2-1)(2m-1)}=\frac1{(m-1)^2}.\qquad\textbf{D CONFIRMED.}$$

**A remark the write-up should carry.** $\theta\mu$ is not a coincidence of two closed forms; in any fixed normalisation $\theta\mu=\nu_{\min}^{\text{raw}}/(2\lVert W\rVert^2)$, since the $\lVert W\rVert$-dependence in $\theta$ and $\mu$ is reciprocal. At $\mathbb{CP}^m$ with $\lambda_E=\tfrac12$ that reads $-\nu_{\min}(\mathring W)=\frac{3m}{2(m+1)(2m-1)}$ against $\lVert W\rVert^2=\frac{3m(m-1)}{4(m+1)(2m-1)}$, and $1/(m-1)$ drops out. Stating it this way makes the identity checkable in one line and removes the appearance of a numerological accident.

**E.** Branch 1 at $\mathbb{CP}^m$ needs $\theta^2\le\frac{2m-1}{2m(m-1)}$; actual over required is exactly $\frac{2(m+1)}{3}$, i.e. $2$ at $m=2$ and linear in $m$ after. The commit's table and its "factor of two at $m=2$, widening after" are right. **It also survives padding**, which the commit does not say and should: padding into $\mathbb{R}^n$ leaves $\theta$ and $\mu$ untouched and only relaxes the branch to $\theta\le\mu$, i.e. $\theta^2\le1/(m-1)$, still failed at every $m$. **E CONFIRMED, and stronger than stated.**

**One wording objection.** "The two branches are exactly complementary here, and that is why the $\max$ is not removable." On the Kähler family the branches are not complementary, branch 2 covers all of it and branch 1 contributes nothing anywhere on it. Non-removability of the $\max$ needs *two* families: $\mathbb{CP}^m$ kills the branch-1-only reading, sphere products kill the branch-2-only reading. The conclusion is right; the sentence attributes it to one family.

## 5. Claim F, the kind claim survives, the census does not

*Written against `103b543`, which rewrote this passage mid-review. The rewrite replaces "Querying the value table" with "Walking [findings/](../findings/) in full, not merely the index", and adds an audit of two near-misses. **It leaves the three-item list untouched.** Both near-misses it names, $1.238486$ at $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ and $1.234230$ at $(S^8)^3$, I had already cleared independently, on the same grounds, and they are in the table below. So the method note changed and the output did not, which makes the finding below sharper rather than weaker: a walk of [findings/](../findings/) in full cannot return that list.*

**The omission that matters.** [graded-half.md:224](../findings/graded-half.md) records the graded enumeration's largest value as $\theta=1.325498$ at $S^{12}\times S^{12}$, and [graded-half.md:230](../findings/graded-half.md) gives it in closed form, $\theta^2=253/144$. It is $\theta_0(24)$. **The commit names $S^{11}\times S^{13}$ at $1.324617$ as the top of the census and omits the point above it.** That line is a plain decimal literal carrying the word $\theta$; an index-only scan misses it because the value table carries $\theta_0(n)$ as a family rather than as rows, but a walk of the findings files cannot.

**Two more the redone census still misses, in the same form.** [route-a.md:33](../findings/route-a.md) reads: *"Odd $n\ge13$ also clears $\sqrt{3/2}$, $1.248376$ at $n=13$, $1.270978$ at $n=15$."* Those are $S^6\times S^7$ and $S^7\times S^8$, and the sentence exists precisely because someone noticed they clear the threshold. Any full walk hits it.

**The count is off by an order of magnitude, and needs no search to establish.** [graded-half.md](../findings/graded-half.md) proves the closed form $\theta^2=2(n-1)^2\big/\big(n^2+\frac{q^2}{p-1}+\frac{p^2}{q-1}\big)$ for $S^p\times S^q$. Evaluating it in exact rationals over the enumeration's own range $n=8,\dots,24$ with $p,q\ge2$ gives **62 splits above $\sqrt{3/2}$** (35 of them at even $n$), from $S^5\times S^7$ at $264/175$ up to $S^{12}\times S^{12}$ at $253/144$. The commit reports three. "Sphere products and nothing else" is right about *kind* and wrong about *extent*, and the sentence "that is a fact about the catalogue" claims the extent.

**What I checked and cleared, so it is not repeated.** Every catalogued decimal in $(\sqrt{3/2},2)$ across [findings/](../findings/) and [findings/INDEX.md](../findings/INDEX.md) was pulled and classified. The near misses:

| value | where | why it is not a counterexample |
| --- | --- | --- |
| $1.544872$, $1.545809$, $1.546426$, $1.5449$ | [second-order.md:202](../findings/second-order.md) | values of the **bound** $\lambda_{\max}p+B_5$, not of $\theta$; the maximiser has $\theta=1.2238$ and criticality residual $2.7\times10^{-2}$ |
| $1.238486$ at $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$, $1.1654$, $1.2041$ | [bounds.md:237](../findings/bounds.md) | not Weyl tensors, Ricci residual $0.288$ |
| $1.236031$ | [target.md:259](../findings/target.md) | non-diagonal and $S=0$ but **not critical**, residual $1.3\times10^{-3}$ |
| $1.234230$ at $(S^8)^3$ | [graded-half.md:212](../findings/graded-half.md) | that is $\mathrm{RHS}$, not $\theta$; the point has $\theta^2=161/192$, i.e. $0.9157$ |
| $1.322183$ at $(6,6,6)$ | [graded-half.md:234](../findings/graded-half.md) | an inflated $\mathrm{RHS}$ with a dropped factor, corrected to $1.200263$; not a $\theta$ |
| $1.248376$, $1.270978$ | [route-a.md:33](../findings/route-a.md) | odd-$n$ sphere products, $S^6\times S^7$ and $S^7\times S^8$, sphere products, and two more the census omits |
| $1.290994=\sqrt{5/3}$ | [bispectral.md:262](../findings/bispectral.md) | a ratio at odd $n$, not a $\theta$ |
| $1.632993=\sqrt{8/3}$ | [target.md:180](../findings/target.md) | the retired "drop the commutator mass" bound |
| $1.4657$, $1.6038$, $1.7227$, $1.5305$, $1.413614$, $1.306498$, $2.2913$, $2.4942$ | [FINDINGS.md:86](../findings/INDEX.md), [REVIEW.md:1021](INDEX.md) | LP and relaxation optima, already flagged in the record as not $\theta$ |

**The symbolic families, which a numeric walk cannot see, are cleared by argument.** This is the class the coordinator flagged as still open, so each closed form on record was evaluated over its admissible parameter range rather than sampled:

| family | closed form | why it cannot clear $\sqrt{3/2}$ |
| --- | --- | --- |
| $\mathbb{CP}^m$ | $\frac{(m+1)(2m-1)}{3m(m-1)}$ | decreasing; $=\tfrac32$ exactly at $m=2$ |
| $\mathbb{HP}^m$ | $\frac{(m+2)^2(4m-1)}{9m(m-1)(2m+1)}$ | decreasing; $\tfrac{56}{45}$ at $m=2$ |
| $(\mathfrak{su}(m),\mathfrak{so}(m))$ algebraic | $\frac{T}{T-1}$, $T=\binom{m+1}2$ | $>\tfrac32\iff T<3$, and $T\ge3$ for every admissible $m$, **the tightest near-miss in the record**, sitting exactly *on* the threshold at $m=2$ |
| $SU(m)/SO(m)$, the actual space | $\frac{8m(m^2+m-4)}{(m-2)(m-1)(m+1)(m+2)(m+4)}$ | $m\ge3$ forced; maximum $\tfrac{24}{35}$ at $m=3$ |
| Type II, compact simple $G$ | $\frac{4(n-1)}{n(n-3)}$ | $>\tfrac32$ only at $n=4,5$, where **no simple Lie algebra exists**; first admissible $n$ is $8$, giving $\tfrac7{10}$ |
| $S^{n_1}\times\dots\times S^{n_k}$, $k\ge3$ | $<\frac2{k-1}$ | $\le1$ for every partition and every $n$ |
| $SO(2m)/U(m)$, Wolf, complex Grassmannians | tabulated | all $\le0.987$ |

**And the direct-sum class closes in one line, which the record does not say.** If $Q(W_i)=\theta_iW_i$ on orthogonal supports, then $W=aW_1+bW_2$ is critical iff $a\theta_1=b\theta_2=\theta$ with $a^2+b^2=1$, so

$$\frac1{\theta^2}=\frac1{\theta_1^2}+\frac1{\theta_2^2}\ \Longrightarrow\ \theta<\min(\theta_1,\theta_2).$$

Orthogonal sums *always* lower $\theta$, so no sum of catalogued points can reach the threshold from below and no sum of sphere products can stay above it. Checked against the record's own $(+\mathrm{Fox})\oplus(-\mathrm{Fox})$: two points at $\sqrt{3/2}$ give $\theta^2=3/4$, i.e. $\sqrt3/2=0.866025$, matching [second-order.md](../findings/second-order.md) exactly.

**Conclusion of the hunt: no non-product catalogued critical point above $\sqrt{3/2}$ exists.** I found none numerically, none symbolically, and none constructible by sum or padding. The largest non-product value anywhere on record is $\sqrt{3/2}$ itself, attained at $\mathbb{CP}^2$ and at the $m=2$ member of the $(\mathfrak{su}(m),\mathfrak{so}(m))$ family, both *on* the threshold, neither above it. **F's kind claim stands; F and G are not falsified.**

**The repair makes the claim stronger, and it is a theorem.** Within the symmetric class the record already has everything needed. (i) Irreducible: $\theta\le\sqrt{3/2}$ with equality only at $\mathbb{CP}^2$, proved in [graded-half.md](../findings/graded-half.md). (ii) Reducible: $\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+B(n_1,\dots,n_k)$ with $B$ depending on the partition alone and $\theta=1/(2\lVert W\rVert)$, so at fixed partition $\theta$ is maximised exactly when every $\lVert W_a\rVert=0$, i.e. every factor is a round sphere. (iii) $k\ge3$ forces $\theta^2<2/(k-1)\le1$. Together: **above $\sqrt{3/2}$, within the symmetric class, a critical point is a two-factor round-sphere product, proved, not surveyed.** Off the symmetric class the claim is evidence only, and the record's own ungraded ceiling of $0.900828$ is what carries it. Say that instead of querying a table.

**Verdict F: CONFIRMED as a statement, OVERSTATED as a census.** The kind claim holds and is a theorem on the symmetric class; the enumeration is wrong, missing the catalogue's maximum and roughly 60 further points, both before and after `103b543`.

## 6. Claim G, the equality is a theorem, and a better one than the record states

The commit attributes the equality to reviewer 132 via "$\omega=d$ and $\mu_1(K)=n\lambda/(n-1)$", i.e. through the vertex matrix. It does not need the vertex matrix, and routing through $K$ hides both the mechanism and the true scope. Here is the direct derivation.

Let $M=M_1\times\dots\times M_k$ be a product of round spheres $S^{n_a}$, $n_a\ge2$, each scaled so the product is Einstein with $\mathrm{Ric}=\lambda_Eg$, $\lambda_E=\tfrac12$; write $\kappa_a$ for the sectional curvature of the $a$-th factor, $\kappa_a=\lambda_E/(n_a-1)$. Since $R_{iklj}$ vanishes unless all four indices lie in one factor, $\mathring R$ is block-diagonal on $S^2(V_1)\oplus\dots\oplus S^2(V_k)\oplus\bigoplus_{a<b}(V_a\otimes V_b)$, acting as $\kappa_a$ on each trace-free $S^2_0(V_a)$, as $\kappa_a(1-n_a)=-\lambda_E$ on each $g_a$, and as $0$ on every mixed block. Restricting to $S^2_0(\mathbb{R}^n)$ and subtracting $c=S/(n(n-1))=\lambda_E/(n-1)$:

| eigenvalue of $\mathring W$ | multiplicity |
| --- | --- |
| $\kappa_a-c$ | $\tfrac{n_a(n_a+1)}2-1$, each $a$ |
| $-c$ | $\sum_{a<b}n_an_b$ |
| $-\lambda_E-c$ | $k-1$ |

The $(k-1)$-dimensional block is the trace directions inside $S^2_0$ (spanned by differences of the $g_a$) and it is an eigenspace *because* the product is Einstein, all $\kappa_a(1-n_a)$ being equal. Since every $\kappa_a>0$, the bottom is that block, so

$$\nu_{\min}^{\text{raw}}=-\lambda_E-c=-\frac{n}{2(n-1)}\ \ \text{at }\lambda_E=\tfrac12,$$

**depending on $n$ alone**. With $\mu=-\nu_{\min}^{\text{raw}}/\lVert W\rVert$ (from $\lVert\mathring W\rVert=\sqrt3\lVert W\rVert$) and $\theta=1/(2\lVert W\rVert)$,

$$\boxed{\ \frac{\mu}{\theta}=2\,\big(-\nu_{\min}^{\text{raw}}\big)=\frac{n}{n-1}\ \Longrightarrow\ \theta=\frac{n-1}n\mu\ \text{exactly}.\ }$$

Checked against the record: at $S^6\times S^6$ this gives $\mu=0.545455/0.404520=1.348400$ and $\sum\nu^2=0.490909=3\lVert W\rVert^2$, both matching [target.md:161](../findings/target.md) to every digit shown.

**So G's equality is CONFIRMED and its scope is larger than claimed.** It holds for every $k\ge2$, not only $k=2$; and it is not really about spheres, it holds at any Einstein product whose factors' own second-kind bottoms exceed $-\lambda_E$. **The mechanism is worth stating in the record**: branch 1 is saturated exactly at reducibility, because a product supplies a distinguished direction in $S^2_0$ (the difference of the factor metrics), on which $\mathring R$ is exactly minus the Einstein constant. Branch 1 asserts that no critical point beats that reducible direction. That is a far more useful statement of the route's difficulty than "it is an equality on a two-parameter family", and it explains E at the same time: $\mathbb{CP}^m$ is irreducible, has no such direction, and its bottom comes from the $(1,1)$ block instead, at $m=2$ giving exactly half the product value, hence the factor-of-two failure.

**The second half of G is where it breaks.** The commit writes: *"no point is known where it does non-trivial work, since such a point would be a counterexample to the conjecture."* **That implication is false on both readings of "the conjecture".**

- Against Conjecture A ($\theta\le\theta_0(n)$): a point with $\sqrt{3/2}<\theta<\tfrac{n-1}n\mu$ satisfies $\mathrm{CD}_n$ and, with the projection estimate $\tfrac{n-1}n\mu\le\Theta_n$, satisfies Conjecture A. It refutes nothing.
- Against the target ($\sup\{\theta:\text{critical},S=0,\text{non-diagonal}\}\le\sqrt{3/2}$): only a point that is additionally non-diagonal with $S=0$ refutes it. Every catalogued point above $\sqrt{3/2}$ is a sphere product, and sphere products sit **on the diagonal locus**, so they are outside the target set entirely. Worse, the diagonal case is *proved* at every $n\ge4$ ([FINDINGS.md:28](../findings/INDEX.md)), so a diagonal critical point where branch 1 does strict work would refute nothing whatever, and there is a whole settled region where the implication is plainly wrong.

"Unfalsifiable" is also the wrong word for a universally quantified statement over critical points: a single point with $\theta>\max\{\sqrt{3/2},\tfrac{n-1}n\mu\}$ refutes it. The accurate statement is the one **the record already made** at [target.md:252](../findings/target.md): *"no point anyone has produced distinguishes $\mathrm{CD}_n$ from the target, so adopting it buys a mechanism with no demonstrated content."*

**Which raises a separate concern about `ed5718a`.** Both of its halves were already in the same file, five sections earlier. [target.md:246](../findings/target.md) already tabulates "every $S^p\times S^q$: $\lambda=\tfrac{n-1}n\mu$ **exactly**", and [target.md:250](../findings/target.md) already says "On the catalogue $\mathrm{CD}_n$ never bites: every point with $\lambda>\sqrt{3/2}$ is a sphere product, where the second branch is an equality." The commit re-states both, adds an incomplete list and a stronger word, and files the result as `Deliverable: derivation`. The genuinely new content is the mechanism, which is missing.

## 7. The single most load-bearing defect, and the fix

**The defect, restated after `103b543`.** The census's *conclusion* is right, I hunted for a non-product witness by every route available and there is none. What is wrong is the census as a census, and `103b543` did not fix it: it rewrote the method line to claim a full walk of [findings/](../findings/) and left the same three points in place. The record's own maximum, $S^{12}\times S^{12}$ at $\sqrt{253}/12=1.325498$, is written twice in [graded-half.md](../findings/graded-half.md) (once as a decimal beside the word $\theta$, once as the closed form $253/144$) and is still absent, as are $1.248376$ and $1.270978$, which [route-a.md:33](../findings/route-a.md) states in a sentence whose whole point is that they clear the threshold. Roughly 60 further splits go with them. **A claim whose force is "that is a fact about the catalogue" is now backed by a method description the output contradicts, which is worse than the original overreach, because a reader can no longer tell the claim was never checked.**

**The fix, in two parts, both of which make the claim stronger than the one being repaired.**

1. **Replace the census with the theorem, and stop enumerating.** Within the symmetric class, "above $\sqrt{3/2}$ implies two-factor round-sphere product" follows from three results the record already owns: the irreducible bound $\theta\le\sqrt{3/2}$, the partition identity $\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+B$ with $\theta=1/(2\lVert W\rVert)$, and $\theta^2<2/(k-1)$. Add the two closures in §5, every symbolic family evaluated over its admissible range, and $1/\theta^2=1/\theta_1^2+1/\theta_2^2$ for orthogonal sums, and the only residue is the unstructured ungraded population, carried by its ceiling $0.900828$. Nothing is queried, nothing can be missed, and the statement covers every $n$ rather than $n\le24$. If a list is wanted at all, it must be generated from the sphere-product closed form, not read off; and then it has 62 entries in $n\le24$, topped by $S^{12}\times S^{12}$.
2. **Replace "unfalsifiable, since such a point would be a counterexample" with the mechanism.** $\theta=\tfrac{n-1}n\mu$ at every Einstein product because the trace directions in $S^2_0$ carry $\mathring R=-\lambda_E$ exactly; branch 1 is the assertion that no critical point beats the reducible direction; the catalogued points above $\sqrt{3/2}$ are all reducible *and all diagonal*, hence outside the target set, so branch 1 is not merely saturated there, it is not needed for the target at any known point. That is true, it is checkable, and it says the same thing about the route's difficulty without a false implication.

**Nothing in `910ebd4` or `8d73e1a` needs repair beyond the two derivational gaps in §2**, the Einstein hypothesis that makes the shift scalar, and the $\mathop{\mathrm{tr}}_{S^2_0}\mathring W=0$ that trace-matching uses. The closed forms $\mu(\mathbb{CP}^m)$, $\theta^2(\mathbb{CP}^m)$ and $\theta\mu=1/(m-1)$ are all correct, and all three now have a second, independent derivation on file.
