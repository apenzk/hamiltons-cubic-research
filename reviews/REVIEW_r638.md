# Review r638, Lemma L97

Reviewer r638, independent adversarial audit, cold from the definitions. Target: **Lemma L97, "the vertex Laplacian is PSD at a diagonal critical point, $K^2-\lambda K\succeq0$"**, at [findings/diagonal-half.md](../findings/diagonal-half.md) line 229. This is the lemma's first pair; the block itself carries *"Gate 2 owed on this section"* and [INDEX-results.md](../findings/INDEX-results.md) row 97 reads *"Gate 2: no verdict on the record"*, both accurate.

Analysis-only footing. No computation was run. The one arithmetic check below is a hand evaluation at $S^3\times S^3$ of an identity already derived analytically, is labelled a screen, and carries no positive claim of its own.

## Verdict in one line

**CONFIRMED**, the identity $K^2-\lambda K=L(K_{ab}^2)$ and the conclusion $K^2-\lambda K\succeq0$ are correct, both equalities of the display are exact including the factor $\tfrac12$, and the "strictly stronger" clause is **true** against the scalar statement as this same file defines it. **Two defects, neither touching the boxed matrix inequality**: the word *"equivalently"* in the box now joins the PSD statement to a strictly stronger one, and the file contradicts itself in headline form on the "strictly stronger" question 70 lines below.

| item | verdict |
| --- | --- |
| The criticality equation $K^{\circ2}+K^2=\lambda K+D$ | **CONFIRMED**, derived below from the pair equation alone |
| First equality, $v^{\mathsf T}Dv-v^{\mathsf T}K^{\circ2}v=\sum_{ab}K_{ab}^2(v_a^2-v_av_b)$ | **CONFIRMED**, ordered sums, $a=b$ terms vanish by hollowness |
| Second equality and the factor $\tfrac12$ | **CONFIRMED**, and the $\tfrac12$ is right *only* under the ordered convention the record fixes |
| $v^{\mathsf T}(K^2-\lambda K)v\ge0$ for arbitrary $v$, hence $K^2-\lambda K\succeq0$ | **CONFIRMED**, the quantity shown non-negative is exactly $v^{\mathsf T}(K^2-\lambda K)v$, no dropped term |
| The boxed *"equivalently $K$ has no eigenvalue in $(0,\lambda]$"* | **GAP.** PSD is equivalent to the **open** interval being empty; the half-open version is strictly stronger and is [L129](../findings/diagonal-half.md), which consumes a hypothesis L97 does not |
| *"strictly stronger than the scalar one"* | **CONFIRMED** against the block's own definition of "the scalar one", and the gap is load-bearing for the counting corollary |
| *"And the matrix statement is not stronger than the scalar one"*, 70 lines below | **OVERSTATED in the headline**, correct in the body, it silently changes what "the scalar one" means |
| Provenance note naming Reviewer 125 | **TRUE**, and checkable to the minute in `git` |
| Scope: every diagonal critical point, maximality unused | **CONFIRMED** |

## Conventions adopted, stated because [conventions.md](../findings/conventions.md) is under repair

Read [conventions.md](../findings/conventions.md) in full first, per the brief, and treated as unreliable. The readings this review runs in, each pinned by an anchor rather than taken on trust:

- **The pairing** is the half-trace one at the $\Lambda^2$ level, under which $\{\varphi_{ab}\}_{a<b}$ is orthonormal and $\lVert W\rVert^2=\sum_{a<b}w_{ab}^2=1$. *Pinned independently below*: it is the only pairing under which the contraction of the pair equation reproduces this file's own cubic $\theta(w)$, and hence the only one under which $\lambda=\theta$.
- **$K$** is the symmetric **hollow** $n\times n$ sectional matrix, $K_{ab}=W_{abab}$ for $a\ne b$ and $K_{aa}=0$. On the diagonal locus $K$ *is* the matrix $M$ of pair-basis eigenvalues of $W$: $W\varphi_{ab}=K_{ab}\varphi_{ab}$. Hollowness is a definition, not a hypothesis, and it is used four separate times below.
- **$t=\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2$, the ORDERED sum**, so $t=2$ on the diagonal locus and $\sum_{a<b}K_{ab}^2=1$.
- **$\lambda$ is $\theta$**, the Lagrange multiplier of $Q(W)=\theta W$ on the unit sphere, the record's $\theta$ of [conventions.md](../findings/conventions.md). It is **not** a $\Lambda^2$ eigenvalue, not $\lambda_{\max}(L_e)$, not [stratum-two-negative.md](../findings/stratum-two-negative.md)'s $\lambda_1$, and not $\lambda_{\min}(\mathring W)$. Derived, not assumed, see §4.
- **$K^{\circ2}$ is the Hadamard square**, $(K^{\circ2})_{ab}=K_{ab}^2$, entry by entry, with $(K^{\circ2})_{aa}=0$. **$K^2$ is the matrix square**, $(K^2)_{ab}=\sum_cK_{ac}K_{cb}$, with $(K^2)_{aa}=\sum_cK_{ac}^2\ne0$ in general. The two agree nowhere relevant, and every occurrence below is checked for which is meant.
- **$D=\operatorname{diag}(\operatorname{diag}K^2)$**: the inner $\operatorname{diag}$ extracts the diagonal vector of $K^2$, the outer rebuilds a diagonal matrix, so $D_{aa}=\sum_bK_{ab}^2$ and $D_{ab}=0$ for $a\ne b$. Under hollowness $D$ is the **row-mass** diagonal, this is what makes it the degree matrix of the weighted graph.

**The one trap in [conventions.md](../findings/conventions.md) that bears on this block**, and the block avoids it: *"On the diagonal locus the $\Lambda^2$ spectrum is the multiset of ENTRIES of $K$, not its eigenvalues."* Every spectral claim in L97 and its counting corollary is about $\operatorname{spec}(K)$, the eigenvalues of the $n\times n$ sectional matrix, and the block says so each time. Read as a $\Lambda^2$ statement the counting corollary would be false and would collide with [post F53](../findings/INDEX-traps.md), which records exactly that collision. **No defect here; recorded because the block's neighbours have paid for it.**

## 1. The criticality equation. Derived, and it is the pair equation twice over

**What the equation is.** $W$ is coordinate-diagonal, so $W\varphi_{ab}=K_{ab}\varphi_{ab}$ and $W$ is diagonal in the pair basis. Read the $((ab),(ab))$ entry of $Q(W)=W^2+W^{\#}=\lambda W$:

$$(W^2)_{(ab),(ab)}+(W^{\#})_{(ab),(ab)}=\lambda K_{ab},\qquad a\ne b .$$

- **$(W^2)_{(ab),(ab)}=K_{ab}^2$**, since $W$ is diagonal in this basis. Off the locus this is $K_{ab}^2+\lVert F_{(ab)}\rVert^2$, which is exactly where the lemma dies, and the block's own off-locus paragraph gets that split right.
- **$(W^{\#})_{(ab),(ab)}=(K^2)_{ab}$.** $\operatorname{ad}_{\varphi_{ab}}$ is the infinitesimal rotation of the $(a,b)$-plane, so the transported structure constants $c_{(ab)\mu\nu}^2$ are supported exactly on the pairs $\mu=(ac)$, $\nu=(cb)$ with $c\ne a,b$, with coefficient $1$, the "$c^2$ is $1$ on triangles" that opens this file. For diagonal $W$ this gives $(W^{\#})_{(ab),(ab)}=\sum_{c\ne a,b}K_{ac}K_{cb}$, and the restriction $c\ne a,b$ is **free by hollowness**: the excluded terms carry a factor $K_{aa}$ or $K_{bb}$. So the sum is the unrestricted $(K^2)_{ab}$.

Hence the **pair equation**, one per unordered pair:

$$K_{ab}^2+(K^2)_{ab}=\lambda K_{ab},\qquad a\ne b. \tag{P}$$

**(P) is exactly the off-diagonal part of $K^{\circ2}+K^2=\lambda K+D$**, because $(K^{\circ2})_{ab}=K_{ab}^2$ off the diagonal and $D$ is diagonal.

**The diagonal part is a tautology, and that is the whole role of $D$.** At $a=b$: $(K^{\circ2})_{aa}=0$ and $\lambda K_{aa}=0$, both by hollowness, so the row reads $(K^2)_{aa}=D_{aa}$, which is the definition of $D$. There is **no equation at $a=b$** ($\Lambda^2$ carries no $(aa)$ index) and $D$ is precisely the slack that turns $n(n-1)/2$ scalar equations into one matrix identity. The block does not say this, and it is worth a line, because a reader who supposes $D$ carries content will look for a hypothesis that is not there.

### Hypotheses consumed, and hypotheses not consumed

| hypothesis | used? | where |
| --- | --- | --- |
| **Diagonality** in coordinate $2$-planes | **yes, twice** | $(W^2)_{(ab),(ab)}=K_{ab}^2$ and the triangle form of $W^{\#}$ |
| **Criticality**, but only its **pair-diagonal** entries | **yes** | (P). The off-diagonal entries of $Q(W)-\lambda W$ are never read, so L97 consumes a proper subset of $Q(W)=\lambda W$ |
| **Hollowness** of $K$ | **yes, four times** | dropping $c\ne a,b$; the $a=b$ tautology; $D$ being the row mass; the Laplacian diagonal |
| **Unit norm** | **only to name $\lambda$** | (P) holds with $\lambda$ the Lagrange multiplier under any normalisation; $\lambda=\theta$ needs $\lVert W\rVert=1$ |
| **Trace-freeness / Ricci-flatness**, i.e. $K\mathbf1=0$ | **NO** | nowhere in (P), nowhere in §2, nowhere in §3. *This matters, see §5* |
| **First Bianchi** | **not separately** | a coordinate-diagonal $W$ satisfies it automatically; $W_{abcd}=0$ unless $\{a,b\}=\{c,d\}$, so every Bianchi triple vanishes term by term |
| **Maximality**, second-order or otherwise | **NO** | see §6 |
| **$\lambda>0$** | **NO** for the PSD statement; **yes** for both readings of it | see §5 and §7 |

**Independent corroboration, not relied on.** [r125](REVIEW_r125.md) confirms the same equation including the $D$ term (claim 1) and derives $(W^{\#})_{abab}=(K^2)_{ab}$ from the structure constants (claim 2), by a route that goes through $\langle A^a,A^b\rangle-\operatorname{tr}((B^{ab})^2)$ rather than through the triangle support. Two derivations, different intermediate objects, same equation.

## 2. The first equality. Confirmed, and the diagonal terms do vanish

$$v^{\mathsf T}Dv=\sum_aD_{aa}v_a^2=\sum_{a}\Big(\sum_bK_{ab}^2\Big)v_a^2=\sum_{a,b}K_{ab}^2\,v_a^2,\qquad v^{\mathsf T}K^{\circ2}v=\sum_{a,b}K_{ab}^2\,v_av_b .$$

Subtracting gives $\sum_{a,b}K_{ab}^2(v_a^2-v_av_b)$, which is the display's middle expression. **Confirmed.**

- **The sums are over ORDERED pairs**, the record's default fixed at [conventions.md](../findings/conventions.md) (*"Sums over pairs are over ORDERED pairs unless the line says otherwise"*). The block writes $\sum_{ab}$ and does not say; under the unordered reading the first equality is false by a factor $2$ on one side. **The convention rescues it, so this is a legibility defect rather than an error**, but it sits next to the factor $\tfrac12$, which is where this audit has repeatedly found real ones.
- **$a=b$ is included and contributes nothing**, because $K_{aa}=0$. Both $\sum_aK_{aa}^2v_a^2$ and $\sum_aK_{aa}^2v_a^2$ drop out identically. *This is what makes $D$ the right object*: the degree $D_{aa}=\sum_{b\ne a}K_{ab}^2$ and the unrestricted $\sum_bK_{ab}^2$ coincide, so $D$ is simultaneously the diagonal of $K^2$ (which is what criticality hands you) and the degree matrix of the graph (which is what the Laplacian needs). Confirmed as the brief asks.

## 3. The second equality and the factor $\tfrac12$. Confirmed

$$\tfrac12\sum_{a,b}K_{ab}^2(v_a-v_b)^2=\tfrac12\sum_{a,b}K_{ab}^2v_a^2-\sum_{a,b}K_{ab}^2v_av_b+\tfrac12\sum_{a,b}K_{ab}^2v_b^2 .$$

The third sum equals the first **by the symmetry $K_{ab}=K_{ba}$**, relabelling $(a,b)\mapsto(b,a)$ is a bijection of the ordered index set, and $K_{ab}^2$ is invariant under it. So the first and third combine to $\sum_{a,b}K_{ab}^2v_a^2$ and the total is $\sum_{a,b}K_{ab}^2(v_a^2-v_av_b)$. **Confirmed, and the factor $\tfrac12$ is correct.**

**Where a stray two would have entered.** The $\tfrac12$ is right precisely because the sum is ordered: each unordered edge $\{a,b\}$ is counted twice on the right and the $\tfrac12$ undoes it. Had $\sum_{ab}$ meant $a<b$, the correct constant would be $1$ and the correct left side $\sum_{a<b}K_{ab}^2(v_a-v_b)^2$. **The block's two unlabelled $\sum_{ab}$'s are consistent with each other**, which is what matters: the same convention is used on both sides of both equalities, so no factor can leak between them.

## 4. The conclusion. Exact, with nothing dropped, and $\lambda=\theta$ falls out of the same equation

**Nothing is dropped.** Rearranging the criticality equation as matrices, $K^2-\lambda K=D-K^{\circ2}$ **identically**, every entry, diagonal and off. So

$$v^{\mathsf T}(K^2-\lambda K)v=v^{\mathsf T}Dv-v^{\mathsf T}K^{\circ2}v=\tfrac12\sum_{a,b}K_{ab}^2(v_a-v_b)^2\ \ge 0$$

for every $v\in\mathbb R^n$, hence $K^2-\lambda K\succeq0$. **The quantity shown non-negative is exactly $v^{\mathsf T}(K^2-\lambda K)v$, not something differing from it by a dropped term.** Confirmed as the brief asks.

**The Laplacian reading is exact too.** With weights $w_{ab}=K_{ab}^2\ge0$, the Laplacian $L(w)$ has $L_{aa}=\sum_bK_{ab}^2$ and $L_{ab}=-K_{ab}^2$. The diagonal matches $(K^2-\lambda K)_{aa}=(K^2)_{aa}-0$ by hollowness alone, **with no criticality**; the off-diagonal matches $(K^2)_{ab}-\lambda K_{ab}=-K_{ab}^2$ **by (P), which is criticality**. The block's split of the two (hollowness carries the diagonal at every $W$, criticality carries the off-diagonal), is correct, and its $E$ paragraph states it.

**A remark the block should carry.** The arbitrary test vector is not what proves the lemma. $K^2-\lambda K=L(w)$ is a **matrix identity**, and PSD then follows from the weights being squares. The arbitrary $v$ is the standard proof that a nonneg-weighted Laplacian is PSD, nothing more. What the arbitrary $v$ genuinely buys is the non-spectral instances (the cut identity at $v=\mathbf1_S$), exactly as the file's own later paragraph says.

**$\lambda$ is $\theta$, and this is derivable rather than conventional.** Contract (P) against $K_{ab}$ over $a<b$:

$$\sum_{a<b}K_{ab}^3+\sum_{a<b}K_{ab}(K^2)_{ab}=\lambda\sum_{a<b}K_{ab}^2 .$$

The second sum is $3\sum_{a<b<c}K_{ab}K_{bc}K_{ca}$, each triangle being counted once per edge; the right side is $\lambda\cdot t/2=\lambda$ at $t=2$. So $\lambda=\sum_{a<b}w_{ab}^3+3\sum_{a<b<c}w_{ab}w_{bc}w_{ca}$, **which is verbatim this file's opening formula for $\theta(w)$**. So the block's $\lambda$ is the record's $\theta$, pinned by the block's own file and not by a naming convention, and the same computation pins the pairing, since the identification $\lambda=\theta$ holds only in the half-trace normalisation where $\sum_{a<b}w_{ab}^2=1$.

**Defect, minor but real: $\lambda$ is never declared, and this file writes the same equation under $\theta$.** [diagonal-half.md](../findings/diagonal-half.md) line 171 reads *"Criticality on the diagonal locus reads $M^{\circ2}+M^2=\theta M+\operatorname{diag}(s)$"*, the identical equation, 58 lines above L97, in $\theta$ and in $M$. The block's $\lambda$ is undefined at its point of use and the letter carries at least four other objects on this record. **The fix is one clause**, not a re-derivation.

## 5. The boxed "equivalently" is a GAP. The interval statement is strictly stronger than PSD

The box reads

$$\boxed{\ K^2-\lambda K\succeq0\ }\qquad\text{equivalently}\qquad\textbf{$K$ has no eigenvalue in }(0,\lambda] .$$

**These are not equivalent.** $K^2-\lambda K$ is a polynomial in $K$, so its eigenvalues are $\kappa(\kappa-\lambda)$ over $\kappa\in\operatorname{spec}(K)$, and

$$K^2-\lambda K\succeq0\iff \kappa(\kappa-\lambda)\ge0\ \forall\kappa\iff \operatorname{spec}(K)\cap(0,\lambda)=\varnothing\quad(\lambda>0).$$

The endpoint $\kappa=\lambda$ gives $\kappa(\kappa-\lambda)=0\ge0$ and is **permitted** by PSD. **Witness, purely linear-algebraic**: any symmetric $K$ with $\lambda\in\operatorname{spec}(K)$ satisfies the left side and fails the right. So the right side is strictly stronger and the two are joined by an implication in one direction only.

**What repairs it is [L129](../findings/diagonal-half.md), and the block knows this**, the note directly under the box says so and attributes the endpoint to L129. **But L129 is not a restatement of PSD; it consumes a hypothesis L97 does not.** Its proof needs $K\mathbf1_{C_t}=0$ for each component indicator, which needs **$K\mathbf1=0$, i.e. Ricci-flatness** (a hypothesis §1's table records as unused by L97) and it needs $\lambda>0$ at the last step ($\lambda x=0\Rightarrow x=0$). [INDEX-results.md](../findings/INDEX-results.md) row 129 lists exactly those hypotheses.

**Consequence for citation, which is what the record needs to know.** $K^2-\lambda K\succeq0$ is available at every symmetric hollow $K$ satisfying the pair equations, Ricci-flat or not; the half-open gap is available only with $K\mathbf1=0$ and $\lambda>0$, and only through L129. A consumer citing the box alone imports L129's hypotheses without seeing them.

**This defect was introduced by an edit, and the edit is identifiable.** Commit `6d0b5bf4` (2026-08-27) wrote the box with the **open** interval $(0,\lambda)$, where "equivalently" was **correct**. Commit `d15e4be0`, which added L129, changed the interval to $(0,\lambda]$ and left the word "equivalently" standing. The diff is one character.

**Suggested minimal repair** (not applied, this review writes no findings file): replace "equivalently" with "and, by [L129](../findings/diagonal-half.md) which additionally uses $K\mathbf1=0$ and $\lambda>0$,". **The boxed inequality itself needs no change.**

## 6. "Strictly stronger", the clause is TRUE, and the file contradicts it 70 lines below

The block defines its own comparison: *"The scalar Poincaré inequality below is the single instance $v=$ top eigenvector."* Call it

- **S1** (scalar): $\mu_1(\mu_1-\lambda)\ge0$, i.e. $\mu_1\notin(0,\lambda)$;
- **M** (matrix): $\kappa(\kappa-\lambda)\ge0$ for **every** $\kappa\in\operatorname{spec}(K)$.

**M $\Rightarrow$ S1 trivially. S1 $\not\Rightarrow$ M**: a symmetric $K$ with spectrum containing $2\lambda$ and $\lambda/2$ satisfies S1 and fails M. So **M is strictly stronger than S1**, and the clause as written is correct.

**And the gap between them is load-bearing, not decorative.** The counting corollary $r\le2/\lambda^2$ needs *every* positive eigenvalue to be $\ge\lambda$; S1 bounds only the top one and yields no bound on $r$ at all. The corollary is the block's only downstream consumer, so the strictly-stronger step is exactly the step the block spends.

**The file then contradicts itself in headline form.** Seventy lines below, in bold: *"**And the matrix statement is not stronger than the scalar one.**"* Its body is correct, $K^2-\lambda K$ is a polynomial in $K$, so PSD is equivalent to the scalar inequality at every eigenvector of $K$, but that is a comparison of M against the **family** $\{$scalar at each eigenvector$\}$, not against S1, which is what the earlier line defines "the scalar one" to be. **The paragraph silently changes the referent of "the scalar one" and then negates the earlier sentence.**

**Both sentences are defensible about different comparisons and cannot both be cited.** The record needs one line, and the accurate one is: *M is strictly stronger than the top-eigenvector instance S1, and equivalent to the family of scalar instances over all eigenvectors of $K$; the arbitrary test vector adds nothing spectral beyond the eigenvectors, and what it genuinely buys is non-spectral, the cut identity at $v=\mathbf1_S$.* The later paragraph's own last sentence already says the second half of this, correctly. **The defect is that its headline over-corrects a true clause into a false one.**

## 7. Scope

- **Every diagonal critical point, not only maximisers.** The derivation reads (P) and nothing else. No second-order condition, no $\lambda_{\max}(L_e)$, no band, no $\theta>0$: the PSD statement holds at diagonal saddles and at $\theta<0$ critical points alike. **The heading is right and the derivation does not quietly use maximality.** *Caveat, and it belongs to the readings rather than to the matrix statement*: the interval form of §5 and the counting corollary $r\le2/\lambda^2$ both need $\lambda>0$, which the block does not state. At $\lambda<0$ the PSD statement reads $\operatorname{spec}(K)\cap(\lambda,0)=\varnothing$ instead.
- **The kernel, and consistency with the block below.** $\ker(K^2-\lambda K)=\ker K\oplus E_\lambda(K)$, and it equals $\ker L(w)$, which is spanned by the indicators $\mathbf1_{C_t}$ of the connected components of $\{K_{ab}\ne0\}$, the same graph as $\{w_{ab}>0\}$, since $w_{ab}=K_{ab}^2$. **The two statements are consistent, and their combination is a corollary worth having**: with $E_\lambda(K)=0$ by [L129](../findings/diagonal-half.md), $\ker K$ is *exactly* the component-indicator span at a diagonal critical point. That is what [L99](../findings/diagonal-half.md) and line 171's $\dim\ker M=\#\text{components}$ use, and what [L130](../findings/diagonal-half.md) leans on downstream. **No inconsistency found between L97 and the block below it.** *Note the direction of dependence*: L129's proof uses L97's identity, so the two must not be cited as independent confirmations of each other.
- **Off the diagonal locus, in one sentence.** The pair equation acquires $\lVert F_{(ab)}\rVert^2$ from $(W^2)_{(ab),(ab)}$ and loses $(W^{\#})_{(ab),(ab)}=(K^2)_{ab}$, so the off-diagonal entry of $K^2-\lambda K$ is no longer $-K_{ab}^2$, the weights are no longer squares, and nothing keeps them non-negative, **the diagonal, being hollowness alone, survives untouched**, which is why the whole failure is carried off-diagonal, exactly as the block's $E$ paragraph states.

## 8. Provenance, hedges and pointers

- **The Reviewer 125 note is TRUE**, and unusually checkable. [r125](REVIEW_r125.md) says at its claim-3 closure: *"A **general** unit $v$ is the most informative choice and is not used … which on the diagonal locus is the full matrix statement $K^2-\lambda K\succeq0$ rather than one scalar. **That generalisation is free and the record does not record it.**"* The `git` timing matches to the minute: `146039bd`, which adds [REVIEW_r125.md](REVIEW_r125.md), is timestamped 2026-08-27 06:43:57; `6d0b5bf4`, which adds this block, is 06:48:03, four minutes later, and its commit body repeats the attribution. **Accurate, and one of the clean ones.**
- *One nuance in the other direction.* "Pointed out that … a general vector is available" **understates** r125: it stated the conclusion $K^2-\lambda K\succeq0$ and the empty $(0,\lambda)$ gap itself, in its bullet on $D$ as a graph Laplacian. The credit is if anything too small, and the substance is unaffected.
- **"Gate 2 owed on this section" is accurate for L97**, matching [INDEX-results.md](../findings/INDEX-results.md) row 97's "no verdict on the record". *It is stale for the section around it*: reviewers 127–132 are recorded as Gate 2 verdicts within the same section, one of them (the "not stronger" paragraph) amending L97's own rider. **The note should be narrowed to the lemma rather than the section**, or a reader takes the surrounding paragraphs as unaudited when they are not.
- **"Arbitrary $v$"**, correct, no constraint on $v$ is used anywhere, unit norm included.
- **Pointers all resolve.** The two anchors into this block, `#lemma-l97--the-vertex-laplacian-is-psd-at-a-diagonal-critical-point-k2-lambda-ksucceq0` at line 479 and `#lemma-l129--the-spectral-gap-is-half-open-lambda-is-never-an-eigenvalue` at lines 171 and 243, both match live headings under GitHub's slug rules. **No empty `(#)` target in this file.**
- **Does the file already settle it?** Partly, and in both directions. Line 171 states the same criticality equation and the same Laplacian identification in $\theta$, 58 lines *above* L97 and without citing it; the "not stronger" paragraph *below* settles (and over-corrects), the "strictly stronger" clause. **Both are inside the same file and neither is cross-referenced from L97's block.**

## Screen, labelled as such and carrying no positive claim

By hand at $S^3\times S^3$, $n=6$, to check the pair equation is not off by a constant: $K_{ab}=\alpha$ within blocks, $\beta$ across; $2\alpha+3\beta=0$ and $t=20\alpha^2=2$ give $\alpha=0.316228$, $\beta=-0.210819$, $\lambda=\theta_0(6)=1.054093$. At the within pair $(1,2)$: $K_{12}^2+(K^2)_{12}=0.1+(\alpha^2+3\beta^2)=0.333333$ against $\lambda\alpha=0.333333$. At the cross pair $(1,4)$: $0.044444+4\alpha\beta=-0.222222$ against $\lambda\beta=-0.222222$. Spectrum of $K$ is $(1.264911,\,0,\,-0.316228^{\times4})$, so $\operatorname{spec}(K^2-\lambda K)=(0.2667,\,0,\,0.4333^{\times4})\succeq0$ with a one-dimensional kernel at $\mathbf1$, $r=1$, and an empty $(0,\lambda]$. **This confirms nothing that §1–§4 did not already derive**; it is recorded because it also fixes the pairing, the same numbers under plain Frobenius would put $\lambda$ off by $\sqrt2$.

## What the record may cite, and what it may not

1. **$K^2-\lambda K=L(K_{ab}^2)\succeq0$ at every diagonal critical point**, citable as written. Hypotheses: coordinate-diagonality, the pair-diagonal entries of criticality, hollowness. **Not** Ricci-flatness, **not** maximality, **not** $\lambda>0$.
2. **$\operatorname{spec}(K)\cap(0,\lambda)=\varnothing$ at $\lambda>0$**, citable, equivalent to 1.
3. **$\operatorname{spec}(K)\cap(0,\lambda]=\varnothing$**, citable **through [L129](../findings/diagonal-half.md)**, which additionally needs $K\mathbf1=0$ and $\lambda>0$. **Not** as an equivalent form of 1.
4. **The counting corollary $r\le2/\lambda^2$**, and its contrapositive reducing diagonal branch 1 to $r=1$, citable; it needs 1 at every eigenvector plus $t\le2$, and $t=2$ holds on the locus. Arithmetic re-checked: $2/\theta_0(n)^2=n^2/((n-1)(n-2))<2$ iff $n>3+\sqrt5$, so at every $n\ge6$; $r\le1.309$ at $n=12$.
5. **"Strictly stronger than the scalar one"**, citable **against the top-eigenvector instance**, which is the file's own definition. **Not** citable as "constrains the whole spectrum rather than one Rayleigh quotient" without the rider that the whole spectrum here means the eigenvector instances and nothing more.
