# Review r561, Lemma L99

Reviewer r561, independent adversarial audit. Target: Lemma L99, "a diagonal critical point with two components carrying an edge fails second-order maximality", in findings/diagonal-half.md.

Analysis-only footing: no computation was run beyond, at most, screens of claims about to be recorded; any screen is labelled as such and is never offered as evidence for a positive claim.

Verdicts are appended below as they are reached.

## Verdict in one line

**REPAIRED.** The heading is exactly the right statement and is now *proved*, every part of L99's core is a short derivation, including the kernel claim the block asserts from a census of some $400$ points. Three defects: the body states the claim for **every disconnected** point, which the file's own padded $n=9$ row contradicts; the body's admissibility condition $\sum a=0$ is the condition the same file withdraws ten lines above; and the projection the "algebraic candidates" identity is taken in has no definition.

## Conventions fixed before deriving

Read [findings/conventions.md](../findings/conventions.md) in full, including today's rows for $M(n)$, $d$/$d_\varphi$/$d_\psi$, $t$/$\kappa$, $\Pi$, $B$, $b$/$B^+$, and warning [W5](../findings/INDEX-traps.md).

- **The letter $M$.** In [diagonal-half.md](../findings/diagonal-half.md) $M$ is the $n\times n$ **sectional** matrix, not the global maximum $M(n)$ of the $M(n)$ row and not the $\Lambda^2$ operator. Unit Weyl norm is $\mathop{\mathrm{tr}}M^2=\sum_{a\ne b}M_{ab}^2=t=2$, the **ordered** sum. L99 is consistent with this throughout.
- **The ambient set** is $\mathcal D_n=\{S\ \text{symmetric},\ \text{hollow},\ S\mathbf1=0\}$, the vertex matrices of the coordinate-diagonal Weyl operators, per the $\mathcal D_n$ row.
- **The pairings.** $\langle\cdot,\cdot\rangle_{\Lambda^2}$ is half the $n\times n$ Frobenius pairing over both index orders. Every orthogonality statement below is insensitive to the choice; every *constant* below is stated in the pairing named.
- **$L_e=\mathcal L/\theta$** with $\mathcal L=\tfrac12D[\Phi-\mathop{\mathrm{diag}}(s)]$, $\Phi(M)=M^{\circ2}+M^2$, the file's own corrected operator, hollowed. [Lemma L24](../results.md) is the criterion: at a maximiser with $\theta>0$, $\lambda_{\max}(L_e\vert_{W^\perp})\le\tfrac12$.

### Symbols the block leans on that are defined nowhere

- **$\mathrm{proj}$**, in *"criticality forces $\mathrm{proj}(M^{\circ2})=-\mathrm{proj}(M^2)$ identically"*. The block never says which subspace. **This is load-bearing, not cosmetic**: the identity is true for the projection onto $\{\text{hollow},\ \text{zero row sums}\}\cap M^\perp$ and **false** for the projection onto $\{\text{hollow},\ \text{zero row sums}\}$ alone, where the image is $\theta M\ne0$. Derived below.
- **$D_X$** (written $D_A$ elsewhere), in *"$\Pi_{\mathcal W}H_A=c^\ast[D_X,W]$"*. Nowhere on the record. The nearest gloss is [bounds.md](../findings/bounds.md)'s $H_A=D_AW+WD_A$, which defines $H_A$ **from** $D_A$ rather than $D_A$; [second-order.md](../findings/second-order.md) repeats the same formula. Neither $D_A$ nor $\Pi_{\mathcal W}$ has a row in [conventions.md](../findings/conventions.md).
- **$\theta_c$ for a component of a given $M$.** The block introduces $\theta_i$ in the *construction* direction, where the summands are given as critical points, and then uses $\theta_c$ in the *analysis* direction, at an arbitrary disconnected critical point, where nothing has said what the component's $\theta$ is. Supplied in Derivation B below; the gap is fillable, but the block does not fill it.

## Derivation A, the kernel claim is a theorem, not a census

**The block asserts it from a census**: *"$\dim\ker M$ is the NUMBER OF CONNECTED COMPONENTS, not $1$, verified to $10^{-15}$ over some $400$ exact critical points."* It is two lines from the criticality equation the file itself derives.

Let $M\in\mathcal D_n$ satisfy the diagonal criticality equation $M^{\circ2}+M^2=\theta M+\mathop{\mathrm{diag}}(s)$, $s_a=\sum_bM_{ab}^2$. Let $G(M)$ be the support graph (vertices $1,\dots,n$, edge $ab$ iff $M_{ab}\ne0$), with $k$ connected components $c_1,\dots,c_k$. Put

$$L\ :=\ \mathop{\mathrm{diag}}(s)-M^{\circ2}.$$

$M^{\circ2}$ is entrywise nonnegative, hollow, with row sums $s$, so **$L$ is exactly the Laplacian of the weighted graph with weights $w_{ab}=M_{ab}^2$**, whose support is $G(M)$. Hence $L\succeq0$, $u^{\mathsf T}Lu=\tfrac12\sum_{a,b}M_{ab}^2(u_a-u_b)^2$, and $\ker L$ is spanned by the component indicators $\mathbf1_{c_1},\dots,\mathbf1_{c_k}$, the standard fact, with $\dim\ker L=k$.

**$\ker M\subseteq\ker L$.** If $Mu=0$ then $M^2u=0$, and applying the criticality equation to $u$,

$$M^{\circ2}u+\underbrace{M^2u}_{=0}=\theta\underbrace{Mu}_{=0}+\mathop{\mathrm{diag}}(s)u\quad\Longrightarrow\quad Lu=\big(\mathop{\mathrm{diag}}(s)-M^{\circ2}\big)u=0 .$$

**$\ker L\subseteq\ker M$.** For a component $c$, row $a$ of $M\mathbf1_c$ is $\sum_{b\in c}M_{ab}$. If $a\in c$ this is $\sum_bM_{ab}=0$, since $M_{ab}=0$ for $b\notin c$; if $a\notin c$ every term vanishes. So $M\mathbf1_c=0$.

$$\boxed{\ \ker M=\ker L=\mathop{\mathrm{span}}\{\mathbf1_{c_1},\dots,\mathbf1_{c_k}\},\qquad \dim\ker M=\#\text{components}.\ }$$

**Hypotheses used**: criticality, hollowness, $M\mathbf1=0$. Nothing else, no $\theta>0$, no normalisation, no connectedness, no dimension. **The statement is stronger than the block's**: it identifies $\ker M$, not only its dimension, and that identification is what the deformation family below actually needs.

*This is the reverse inequality the brief says it sees no argument for. It is available, it is short, and the record does not carry it, grep of [findings/](../findings/) finds no weighted-Laplacian argument attached to the criticality equation anywhere.*

## Derivation B, the scaling law and the harmonic-square law, both directions

**Construction direction.** Let $M_i\in\mathcal D_{n_i}$ be diagonal critical points with $\mathop{\mathrm{tr}}M_i^2=2$ and values $\theta_i$, and set $M=\bigoplus_i\lambda_iM_i$ on $n=\sum n_i$ coordinates. Blocks meet in no index, so $M^{\circ2}=\bigoplus\lambda_i^2M_i^{\circ2}$ and $M^2=\bigoplus\lambda_i^2M_i^2$, giving

$$M^{\circ2}+M^2=\bigoplus_i\lambda_i^2\big(\theta_iM_i+\mathop{\mathrm{diag}}(s^{(i)})\big).$$

The diagonal matches for free, since $s\vert_{c_i}=\lambda_i^2s^{(i)}$. Off-diagonally, criticality $=\theta M+\mathop{\mathrm{diag}}(s)$ reads $\lambda_i^2\theta_iM_i=\theta\lambda_iM_i$, so at every $\lambda_i\ne0$ with $M_i\ne0$,

$$\lambda_i\theta_i=\theta .$$

Unit norm is $\mathop{\mathrm{tr}}M^2=2\sum\lambda_i^2=2$, i.e. $\sum\lambda_i^2=1$, so $\theta^2\sum_i\theta_i^{-2}=1$ and $\theta=\big(\sum_i\theta_i^{-2}\big)^{-1/2}$. **Consistency of the value**: contracting the criticality equation against $M$ (which kills $\mathop{\mathrm{diag}}(s)$, $M$ being hollow) gives $2\theta=\langle M^{\circ2}+M^2,M\rangle=\sum_i\lambda_i^3\cdot2\theta_i$, hence $\theta=\theta^3\sum\theta_i^{-2}=\theta$. No new information, and no contradiction.

**Analysis direction, which the block needs and never states.** Given *any* diagonal critical point $M$ with support components $c$, restrict the criticality equation to the diagonal block $M\vert_c$: it is the same equation with the same $\theta$. Put $\lambda_c^2=\tfrac12\mathop{\mathrm{tr}}\big((M\vert_c)^2\big)$ and $M_c=(M\vert_c)/\lambda_c$; then $M_c\in\mathcal D_{|c|}$ is critical at $\theta_c=\theta/\lambda_c$. So the decomposition into scaled critical summands is **automatic** rather than a hypothesis, $\sum_c\lambda_c^2=1$, and the harmonic-square law follows for every disconnected diagonal critical point.

**Verdict on this part: CONFIRMED, and the numerics are surplus.** The block's own sentence carries the reason (*"since $\lambda_i\theta_i=\theta$ is what makes each block satisfy the same equation, and unit norm then gives"*), so the *"verified to $10^{-17}$"* at three points is a check on an argument already given in the line above it. **The record also holds the law twice over, derived**: [second-order.md](../findings/second-order.md) proves it in one line from $\circ$-orthogonality, and [nondegeneracy.md](../findings/nondegeneracy.md) states $\tfrac1{\theta^2}=\sum_i\tfrac1{\theta_i^2}$ with $|\theta|<\min_i|\theta_i|$. **The brief's reading is right: a measurement stands where a proof was available and the proof is one file away.** The repair is a cross-reference, not new mathematics.

## Derivation C, the eigenvector, with no numerics and no normalisation

Let $M$ be a diagonal critical point, $a\in\ker M$, so by **Derivation A** $a=\sum_ca_c\mathbf1_c$ is constant on each component. Define

$$N_{ab}:=a_{c(a)}M_{ab},$$

well defined and symmetric because $M_{ab}=0$ whenever $a,b$ lie in different components. $N$ is hollow, and $N\mathbf1=0$ blockwise, so $N\in\mathcal D_n$, an admissible *shape*.

Fix $a\ne b$ in a common component $c$. Then

- $(M\circ N)_{ab}=M_{ab}N_{ab}=a_c\,(M^{\circ2})_{ab}$;
- $(MN)_{ab}=\sum_dM_{ad}a_{c(d)}M_{db}$, and a term survives only when $d$ is adjacent to both $a$ and $b$, forcing $c(d)=c$; so $(MN)_{ab}=a_c(M^2)_{ab}$, and likewise $(NM)_{ab}$.

Hence $\mathcal L(N)_{ab}=a_c\big(M^{\circ2}+M^2\big)_{ab}=a_c\,\theta M_{ab}=\theta N_{ab}$, using criticality off the diagonal. For $a,b$ in **different** components, $N_{ab}=0$, $M_{ab}=0$, and $(MN)_{ab}=0$ for the same adjacency reason, so both sides vanish. The diagonal is hollowed by definition of $\mathcal L$. Therefore

$$\boxed{\ \mathcal LN=\theta N\ \text{ exactly},\qquad L_eN=N.\ }$$

**No normalisation, no $\theta_c$, no direct-sum bookkeeping enters**, the whole computation is the adjacency remark plus the criticality equation. The block's *"ratio $1.000000000$"* is a check on this.

## Derivation D, admissibility, and why "two components carrying an edge" is exactly right

Write $\tau_c:=\mathop{\mathrm{tr}}\big((M\vert_c)^2\big)=2\lambda_c^2=2\theta^2/\theta_c^2$, which is $>0$ iff the component carries an edge. Then

$$\langle N,M\rangle_F=\sum_{a\ne b}N_{ab}M_{ab}=\sum_ca_c\!\!\sum_{a,b\in c}\!\!M_{ab}^2=\sum_ca_c\tau_c=2\theta^2\sum_c\frac{a_c}{\theta_c^2},$$

so at the $\Lambda^2$ level $\langle N,M\rangle=\theta^2\sum_ca_c\theta_c^{-2}$, **the block's constant, exactly, in the pairing it names**, and the sum runs over edge-carrying components only. Two consequences, both structural:

- $N\ne0$ iff $a_c\ne0$ for some **edge-carrying** $c$; singleton components contribute nothing whatever $a_c$ is.
- $N\perp M$ iff $\sum_ca_c\theta_c^{-2}=0$ over the edge-carrying components.

Let $k^+$ be the number of components carrying an edge.

| $k^+$ | the family | conclusion |
| --- | --- | --- |
| $\ge2$ | take $a_{c_1}=\theta_{c_1}^2$, $a_{c_2}=-\theta_{c_2}^2$, $a=0$ elsewhere: then $N\ne0$ and $N\perp M$ | $L_eN=N$ with $N\in W^\perp$, so $\lambda_{\max}(L_e\vert_{W^\perp})\ge1>\tfrac12$ and [Lemma L24](../results.md) fails |
| $1$ | $\sum_ca_c\theta_c^{-2}=0$ forces $a_{c_1}=0$, so $N=0$; equivalently every member of the family is $N=a_{c_1}M$ | **radial**, certifies nothing |
| $0$ | $N=0$ always | vacuous |

The admissible eigenspace this supplies has dimension $k^+-1$, so **three or more edge-carrying components give a multiplicity-$\ge2$ violation and no exceptional case**, the brief's quantifier question. The failure is claimed at *every* such point and holds at every such point.

$$\textbf{Lemma L99, proved.}\ \textit{Let }M\in\mathcal D_n\textit{ be a diagonal critical point with }\theta>0\textit{ whose support graph has at least two components carrying an edge. Then }\lambda_{\max}(L_e\vert_{W^\perp})\ge1,\textit{ so }W\textit{ is not a maximiser.}$$

**And the hypothesis is sharp for this family**: at $k^+=1$ the family is exhausted by the radial direction. So the heading's clause *"two components carrying an edge"* is the exact hypothesis, arrived at here by a route sharing nothing with the block's.

## Defect 1, the body claims the lemma for **every disconnected** point, and the file refutes that two paragraphs above

> *"So every disconnected diagonal critical point with $\theta>0$ has $\lambda_{\max}\ge\theta>\theta/2$ and fails second-order maximality"* … *"every disconnected diagonal critical point with $\theta>0$ fails second-order maximality, at eigenvalue exactly $\theta$"* … *"the $A=\mathop{\mathrm{diag}}(a)$ family is **live at every disconnected point**"*.

All three sentences take **disconnected**, i.e. $k\ge2$. The correct hypothesis is $k^+\ge2$. The gap is exactly padding, and the file states the counterexample **at line 155, eight lines earlier**:

> *"$S^4\times S^4$ plus an isolated vertex at $n=9$ is disconnected by the record's own criterion ($\dim\ker M=2=\#$components) and has $\theta>0$, yet $\lambda_{\max}(L_e)=0.5714$, and the indicator $N$ there has $\cos(N,M)=+1.000000$, i.e. it **is** the radial direction … The repair is "at least two components **carrying an edge**", not "disconnected"."*

Derivation D reproduces both halves of that row without computing: at a padded point $k^+=1$, so every member of the family is $a_{c_1}M$, whence $\cos(N,M)=\pm1$ exactly, the reported $+1.000000$ is forced, not measured, and the family is dead. The recorded $\lambda_{\max}(L_e)=0.5714<1$ then contradicts the body's *"$\lambda_{\max}\ge\theta$"* outright.

**Status: the heading was repaired and the body was not.** [plan.md](../plan.md) already carries this as an open item (*"Lemma L99 needing to exclude paddings explicitly"*), and [reviews/plan-maximizer.md](plan-maximizer.md) line 100 repeats it. **A correction filed and never applied to the text it corrects**, the pattern the brief names.

**Verdict: the three sentences as written are REFUTED; the heading's statement is CONFIRMED and now proved.** The repair is to replace "disconnected" by "with at least two components carrying an edge" at all three places.

### Defect 1b, the same over-reach in the withdrawal note

> *"This record's withdrawal of the family was correct only for connected support."*

Also wrong, and in the same direction. The withdrawal was correct whenever $k^+\le1$, which includes every padding of a connected point. Connected support is the $k=1$ special case.

## Defect 2, the body's admissibility condition is the one the file withdraws ten lines above

> *"the **component-indicator** deformation ($a$ constant on each component with $\sum a=0$), gives an admissible $N$ (row sums $6\times10^{-17}$)"*

Two errors in one clause, both already diagnosed inside the same file, ten and twelve lines above:

1. **$\sum a=0$ is not admissibility.** Derivation D gives $\sum_ca_c\theta_c^{-2}=0$. The paragraph at [diagonal-half.md](../findings/diagonal-half.md) line 155 says so in terms, and adds *"so $\sum a_c=0$ enforces nothing and the cosine reaches $0.99$ across $205$ sums"*. $\sum a=0$ coincides with the true condition only when all edge-carrying blocks share a $\theta_c$.
2. **Row sums are the wrong check.** [Lemma L24](../results.md) needs $N\perp W$. [diagonal-half.md](../findings/diagonal-half.md) line 153 states this exactly: *"only the row sums were checked … so it certified nothing."* Worse, for this family row sums vanish **identically** (they are equivalent to $a\in\ker M$, which is how the family is defined) so *"row sums $6\times10^{-17}$"* is a check with no content at all.

**Verdict: REPAIRED.** The conclusion survives, because a valid $a$ exists whenever $k^+\ge2$ (Derivation D), but the stated certificate is the withdrawn one. Replace *"with $\sum a=0$"* by *"with $\sum_ca_c\theta_c^{-2}=0$ over the components carrying an edge"*, and drop the row-sum figure.

## Cross-check of Derivation C against the record, by a route sharing nothing with L99

[second-order.md](../findings/second-order.md) carries a *derived* identity for the same family, obtained without the component decomposition: for $A=\mathop{\mathrm{diag}}(a)$ the deformation is $N_{ij}=2M_{ij}(a_i+a_j)$ and

$$(L_WH_A)_{ij}=(a_i+a_j)\big[M_{ij}^2+\theta M_{ij}\big]+2\big(M\mathop{\mathrm{diag}}(a)M\big)_{ij}.$$

Rebuilt from the definitions: $M_{ij}N_{ij}=2M_{ij}^2(a_i+a_j)$ and $\tfrac12(MN+NM)_{ij}=2(M\mathop{\mathrm{diag}}(a)M)_{ij}+(a_i+a_j)(M^2)_{ij}$, and substituting $(M^2)_{ij}=\theta M_{ij}-M_{ij}^2$ reproduces the recorded right-hand side exactly. **Specialising to $a$ constant on components**, where $a_i+a_j=2a_c$ on an edge and $(M\mathop{\mathrm{diag}}(a)M)_{ij}=a_c(M^2)_{ij}$ by the same adjacency remark, gives $4a_c\theta M_{ij}=\theta N_{ij}$. **Derivation C confirmed, from a formula on the record that was derived rather than measured, and that never mentions components.**

## The "algebraic candidates" identity is also a two-line derivation

> *"they are not three candidates but two: criticality forces $\mathrm{proj}(M^{\circ2})=-\mathrm{proj}(M^2)$ identically, **verified here to $7\times10^{-17}$**"*

Take $\mathrm{proj}$ to be the orthogonal projection onto the admissible space $V=\{N\in\mathcal D_n:N\perp M\}$, the reading the statement needs, and the one the block does not supply. Project the criticality equation:

- $\mathop{\mathrm{diag}}(s)$ is purely diagonal and every element of $V$ is hollow, so $\mathrm{proj}(\mathop{\mathrm{diag}}(s))=0$;
- $M\in\mathcal D_n$ and $V\perp M$, so $\mathrm{proj}(\theta M)=0$.

Hence $\mathrm{proj}(M^{\circ2})+\mathrm{proj}(M^2)=\mathrm{proj}(\theta M+\mathop{\mathrm{diag}}(s))=0$. $\square$

**CONFIRMED, and the numerics are again surplus.** The derivation also explains the reported figures without a run: it forces $\lVert\mathrm{proj}(M^{\circ2})\rVert=\lVert\mathrm{proj}(M^2)\rVert$, which is the repeated $0.211$, $0.211$ at the $C_5$ blow-up and the *"$0.059$ twice"* at the $n=9$ witness. **And it shows why $\mathrm{proj}$ had to be defined**: drop the $\perp M$ condition and the image is $\theta M\ne0$, so the identity is false for the projection onto $\mathcal D_n$.

## Defect 3, the third retraction is incomplete: the withdrawn claim still stands in the file L99 points at

> *"the representation-theoretic obstruction is a property of SYMMETRIC points only … the isotypic claim dies most cleanly on this record's own live-target point, where $\mathfrak k(W)=0$ exactly, $\mathrm{Sym}_0(\mathbb R^8)$ is a single isotype of multiplicity $35$, and $L_e$ takes **eight** distinct values on it."*

That is right, and [second-order.md](../findings/second-order.md) states the retraction itself in bold: *"REFUTED AS STATED, and repaired, $L_e$ is scalar on IRREDUCIBLES, not on isotypic components. An isotype of multiplicity $m$ carries an $m\times m$ block."* **Four lines below its own retraction the same file still asserts the withdrawn version verbatim**: *"$L_e$ commutes with $\mathfrak k$, so **$L_e$ acts as a scalar on each isotypic component**."* The inference is Schur's lemma applied without multiplicity-freeness; [route-a.md](../findings/route-a.md) states the correct form, $F_u=\bigoplus_\lambda F_\lambda\otimes\mathrm{Id}_{V_\lambda}$, *"with no multiplicity-free hypothesis, since multiplicities are exactly what the spaces $M_\lambda$ absorb"*, a matrix per type, not a scalar.

**Verdict: L99's retraction is correct; its application to the record is incomplete.** The sentence at [second-order.md](../findings/second-order.md) is the seventh-plus instance in this audit of a correction filed and never applied to the text it corrects, and it is the one L99 itself is retracting.

*The other two retractions check out.* *"They do not project to zero … it is the Rayleigh quotient that vanishes"* and *"not three candidates but two"* are both consistent with the derivation above, and no other file on the record leans on the withdrawn forms, [nondegeneracy.md](../findings/nondegeneracy.md)'s *"project to zero"* is about $K$-invariant Weyl operators and is unrelated.

## Defect 4, the labels, part by part

The brief's rule is literal: `Lemma` means proved, `Observation` means verified numerically at the dimensions named. The block is one `Lemma` heading over parts of both kinds.

| part of the block | status after this audit | label owed |
| --- | --- | --- |
| the direct-sum scaling $\lambda_i\theta_i=\theta$ and $\theta=(\sum\theta_i^{-2})^{-1/2}$ | proved, Derivation B; and already derived at [second-order.md](../findings/second-order.md) | **Lemma**, citing the existing derivation instead of the $10^{-17}$ figures |
| the block decomposition of an arbitrary disconnected critical point | proved, Derivation B, analysis direction, currently unstated | **Lemma**, and it must be written down |
| $\dim\ker M=\#$components | proved, Derivation A, and strengthened to identify $\ker M$ | **Lemma**, replacing the census of $\sim400$ points |
| $\mathcal LN=\theta N$ on the component family | proved, Derivation C, cross-checked against [second-order.md](../findings/second-order.md) | **Lemma**, replacing *"ratio $1.000000000$"* |
| the failure of maximality at $k^+\ge2$ | proved, Derivation D | **Lemma**, the heading, at its own hypothesis |
| $\mathrm{proj}(M^{\circ2})=-\mathrm{proj}(M^2)$ | proved above, once $\mathrm{proj}$ is defined | **Lemma**, replacing $7\times10^{-17}$ |
| *"the projections are $0.211$, $0.211$ and $0.047$"*; the $n=9$ witness's $0.059$ | measurement at two named points | **Observation** |
| the $n=8$ point with $\Delta=11.16$, $\lvert\mathrm{Aut}(M)\rvert=2$, deviation $0$, invariant maximum $0.000$ against $\theta/2=0.335$ | measurement at one named point | **Observation** |
| *"the block-graph statistic fails at $n=12$ too"*, three points, $\lambda_{\max}$ up to $1.152$, all seven readings | census at one dimension | **Observation at $n=12$** |
| the residual $7\times10^{-3}$ for equal scaling | a screen supporting a negative, and correct as such | fine where it is |

**So `Lemma` is the right label for the core, and the block earns it only after the derivations are written in.** As it stands the core is asserted from measurement, so **no downgrade is owed for the core and no obligation is created**, the derivations above discharge it. The peripheral three rows are Observations and should say so; **the obligation those carry, if they stay unlabelled, is a proof that the $n=8$ and $n=12$ phenomena are not artefacts of the dimensions run**, which is precisely what the neighbouring [Observation L98](../findings/diagonal-half.md) block records going wrong once already (*"the $1.025$ once recorded here was the minimum of a population that stopped at $n=8$"*).

## Consumers, the $21$ mentions, checked against the hypothesis

| consumer | what it takes from L99 | inside the hypothesis? |
| --- | --- | --- |
| [REVIEW_r391.md](REVIEW_r391.md) lines 66–70 | the construction, the eigenvector, **and the correct admissibility $\sum_ca_c\theta_c^{-2}=0$**; witness is two copies of $S^3\times S^3$ padded to $n=12$ | **yes**, $k^+=2$; and it states the condition L99's own body gets wrong |
| [ATTEMPTS.md](../ATTEMPTS.md) line 3449 | r391's witness, to settle a constant | **yes**, same point |
| [plan-diagfam.md](plan-diagfam.md) lines 12, 110 | the harmonic-square law as a closure property | **yes**, and it correctly calls it a consequence rather than a fourth relation |
| [DERIVE-mx1.md](DERIVE-mx1.md) line 3 | L99 as the record's diagonal-locus result | **yes** |
| [plan-maximizer.md](plan-maximizer.md) lines 13, 18, 28, 32 | the **four-set quotient** $(M_{ac}+M_{ad}+M_{bc}+M_{bd}-2M_{ab}-2M_{cd})/4\theta$, attributed to L99 | **misattributed**, that family belongs to [Observation L98](../findings/diagonal-half.md), the next block down, not to L99 |
| [plan-maximizer.md](plan-maximizer.md) line 100, [plan.md](../plan.md) line 198 | that L99 must exclude paddings explicitly | **open item, correctly raised**, Derivation D settles it |
| [INDEX-results.md](../findings/INDEX-results.md) row 99 | the heading, *"Gate 2: no verdict on the record"* | **yes**, the heading is the correct statement |

**No consumer treats the kernel claim as proved and leans on it for a positive result**, and no consumer inherits the over-broad "every disconnected point" form. The one live citation defect is the four-mention misattribution of L98's quotient family to L99 in [plan-maximizer.md](plan-maximizer.md); it costs nothing mathematically, since that file re-derives the quotient itself, but it reads a `Lemma` label onto an `Observation`.

## Overall verdict

**REPAIRED.**

| # | defect | verdict |
| --- | --- | --- |
| 1 | body claims the lemma at **every disconnected** point; contradicted by the file's own padded $n=9$ row | **REFUTED** as written; heading **CONFIRMED** and now proved |
| 1b | *"the withdrawal was correct only for connected support"*, should be $k^+\le1$ | **REFUTED** |
| 2 | admissibility given as $\sum a=0$, certified by row sums; both withdrawn ten and twelve lines above | **REPAIRED** (conclusion survives, certificate replaced) |
| 3 | the isotypic retraction is not applied, the withdrawn scalarity claim still stands in [second-order.md](../findings/second-order.md) | **defect confirmed, outside this block** |
| 4 | `Lemma` over parts that are censuses; and the core's proofs missing where they exist | **REPAIRED** by Derivations A–D; three peripheral rows are Observations |
| 5 | $\mathrm{proj}$ undefined, and load-bearing; $D_X$ undefined anywhere on the record | **defect confirmed** |
| 6 | $\theta_c$ used in the analysis direction with no definition there | **REPAIRED** by Derivation B |

**The heading is the right statement, its hypothesis is sharp, and it is a theorem.** What the block records as five separate numerical verifications, $10^{-17}$, $10^{-15}$ over $400$ points, $7\times10^{-17}$, ratio $1.000000000$, row sums $6\times10^{-17}$, is one adjacency remark plus the criticality equation, applied four times.

*No computation was run for this review. Every claim above is a derivation from the definitions in [conventions.md](../findings/conventions.md) and the criticality equation in [diagonal-half.md](../findings/diagonal-half.md); the two figures quoted from the record ($\lambda_{\max}=0.5714$ at the padded $n=9$ point, and the $0.211$/$0.059$ projections) are cited as the record's measurements and are used only to corroborate conclusions that Derivation D reaches independently.*
