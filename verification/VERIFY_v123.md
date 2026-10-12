# VERIFY v123, Observation L15: the Bianchi defect identity $\operatorname{scal}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2$, its constant, its two normalisations, and the clause that survives uncorrected at [results.md](../results.md):645

**Cold brief.** Verifier v123 on round [L15](ROUND_L15.md). Sources: [problem.md](../findings/problem.md):200–204, [results.md](../results.md):218 and :643–649, [isotropy-cap.md](../findings/isotropy-cap.md) ([L79](../findings/isotropy-cap.md), [L131](../findings/isotropy-cap.md)), [bounds.md](../findings/bounds.md) ([L7](../findings/bounds.md), [L154](../findings/bounds.md), [L155](../findings/bounds.md)), [conventions.md](../findings/conventions.md), [ATTEMPTS.md](../ATTEMPTS.md):605–625, [REVIEW_r469.md](../reviews/REVIEW_r469.md), [REVIEW_r470.md](../reviews/REVIEW_r470.md), [lean/INDEX.md](../lean/INDEX.md):183, [L15.lean](../lean/HamiltonsCubic/Results/L15.lean), and the stored [Böhm–Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md) and [Jäger notes](../references/jaeger-2016-diagonal-case/notes.md). **No numerical work was done and no script was run**; every value below is an exact hand evaluation, including the four named-object checks and the Fox arithmetic. Log: [agent_logs/verify-L15-v123.log](../agent_logs/verify-L15-v123.log).

## Verdict, `PROVEN, hypotheses corrected`

The identity is true at every $n\ge2$ in the record's conventions, the constant $6$ is right and dimension-free, and every downstream number in the block ($24$, the factor of three at Fox, saturation, zero defect at sphere products) is exact, I rebuilt all of them by hand. **What fails is the writing of the canonical form.** [results.md](../results.md):645 carries a universally quantified clause that is false at every sphere product, its display drops the sentence that defines $\mathrm{Alt}$ and quantifies $R$, and its `Proof:` pointer aims at a file that carries no proof.

## Claim table

| # | claim, as written | where | verdict |
| --- | --- | --- | --- |
| C1 | $\operatorname{scal}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2$ | [problem.md](../findings/problem.md):203, [results.md](../results.md):647 | **PROVEN, HYPOTHESES CORRECTED** (needs *$R$ symmetric on $\Lambda^2\mathbb R^n$*, stated at neither site) |
| C2 | "the constant exactly $6$ in every dimension" | [problem.md](../findings/problem.md):204 | **PROVEN** for $n\ge4$; vacuously true at $n\le3$ where $\Lambda^4=0$ |
| C3 | "and no cross-term" | [problem.md](../findings/problem.md):204 | **PROVEN**, but the record's Schur argument needs $O(n)$-equivariance, and at $n=4$ $SO(4)$ alone does not suffice |
| C4 | the master inequality "carries an extra $+24\lVert\mathrm{Alt}(W_-)\rVert^2$" | [problem.md](../findings/problem.md):204 | **PROVEN** as $6\cdot 4\delta^2$; the master inequality it corrects rests on an **unread source** (Jäger §3.2) |
| C5 | Fox's $\mathcal S^4(\alpha)$: fails "by a factor of three", corrected version "saturated there" | [problem.md](../findings/problem.md):204 | **PROVEN**, $4$ against $4/3$, both derived exactly by hand here |
| C6 | "Every sphere product, in any frame, has defect zero" | [problem.md](../findings/problem.md):204 | **PROVEN**; "in any frame" is vacuous under the record's own spectral $W_-$ |
| C7 | "$\lvert W\rvert$ and the spectral parts $W_\pm$ **do not** satisfy the first Bianchi identity" | [results.md](../results.md):645 | **BROKEN**, false at every sphere product, by the same block's own last sentence. [problem.md](../findings/problem.md):202 says "need not" and is right |
| C8 | "Every step of that transfer survives … with one exception" | [results.md](../results.md):645 | **BROKEN**, the 2026-09-04 correction landed at [results.md](../results.md):218 and [problem.md](../findings/problem.md):192–194 and **not** on the canonical form |
| C9 | the heading's second obstruction, $X_{\mathrm{inv}}\succeq0$ | [problem.md](../findings/problem.md):194, [results.md](../results.md):218 | **HYPOTHESIS-DEBT**, established nowhere; refuted off the diagonal locus, with only $\operatorname{tr}X_{\mathrm{inv}}\ge0$ proven |
| C10 | "**Proof:** [problem.md](../findings/problem.md)" | [results.md](../results.md):649 | **BROKEN**, [problem.md](../findings/problem.md) carries no argument; the proof is [L131](../findings/isotropy-cap.md) plus [L79](../findings/isotropy-cap.md) |
| C11 | "the identity … **is [Lemma L131](../findings/isotropy-cap.md) polarised**" | [results.md](../results.md):218, [lean/INDEX.md](../lean/INDEX.md):183 | **REVERSED**, L131 is the polarised form and L15 its contraction; [isotropy-cap.md](../findings/isotropy-cap.md):414 and [problem.md](../findings/problem.md):198 have the direction right |

**One-line summary.** The mathematics is sound and I reproduced every constant by hand; the defect is that the canonical form at [results.md](../results.md):643–649 is a truncation carrying a false clause, an undefined $\mathrm{Alt}$, an unquantified $R$ and a proof pointer to a file with no proof.

## 0. Conventions, fixed once

Every one of these is quoted from [conventions.md](../findings/conventions.md) or from a stored reference; none is restated from memory, and **each is load-bearing for the constant $6$**.

| object | the record's fixing | source |
| --- | --- | --- |
| $\Lambda^2$ inner product | $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, so $\lVert\varphi_{ab}\rVert^2=1$ and $\{\varphi_{ab}\}_{a<b}$ is orthonormal | [conventions.md](../findings/conventions.md), "Norms and pairings" |
| $\operatorname{scal}$ | $\operatorname{scal}=2\operatorname{tr}$ on $\Lambda^2$ | [conventions.md](../findings/conventions.md), "Norms and pairings" |
| $\mathrm{Alt}$ | the **orthogonal** projection of $S^2(\Lambda^2)$ onto $\Lambda^4$, carrying its $\tfrac13$: $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$ | [conventions.md](../findings/conventions.md), "Structure constants" |
| $\star$ at $n=4$ | $\mathrm{Alt}$ is the projection onto $\star=\Pi_{SD}-\Pi_{ASD}$, with $\lVert\star\rVert^2=6$ | [conventions.md](../findings/conventions.md) |
| $\#$ | $\langle(R\,\#\,S)h,h\rangle=\tfrac12\sum_{\alpha,\beta}\langle[R b_\alpha,S b_\beta],h\rangle\langle[b_\alpha,b_\beta],h\rangle$, $R^\#:=R\,\#\,R$; bilinear, symmetric, $O(n)$-equivariant | [Böhm–Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md), eq. (4) |
| $\mathrm{tri}$ | $\operatorname{tr}(2(R_1\#R_2)R_3)$ is fully symmetric in $R_1,R_2,R_3$, giving $\langle A\#B,C\rangle=\langle A\#C,B\rangle$ | [Böhm–Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md) |
| $\mathrm{Ric}$, $\mathrm{Ric}^*$ | $\mathrm{Ric}(R)_{ij}=\sum_kR_{ikjk}$ with $\lVert\cdot\rVert$ the plain $n\times n$ Frobenius norm; $\mathrm{Ric}^*=2(\,\cdot\wedge\mathrm{id})$ is its adjoint | [isotropy-cap.md](../findings/isotropy-cap.md):414, "Two conventions to carry" |
| $W_-$ | $W_-:=\tfrac12(\lvert W\rvert-W)\succeq0$, so $\lvert W\rvert=W+2W_-$ | [conventions.md](../findings/conventions.md), "Structure constants" |
| $\delta^2$ | $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$, and $\mathrm{Alt}(\lvert W\rvert)=2\,\mathrm{Alt}(W_-)$ so $\lVert\mathrm{Alt}(\lvert W\rvert)\rVert^2=4\delta^2$ | [isotropy-cap.md](../findings/isotropy-cap.md):414 |

Two consistency checks on this table, done by hand and both passing, are in §3: $\operatorname{scal}(I)=n(n-1)$ is the round unit sphere's scalar curvature under $\operatorname{scal}=2\operatorname{tr}$, and $\lVert\star\rVert^2=\operatorname{tr}(\star^{\mathsf T}\star)=\operatorname{tr}(\mathrm{Id}_{\Lambda^2\mathbb R^4})=6$ confirms that the pairing on $S^2(\Lambda^2)$ is the **plain** Hilbert–Schmidt trace, with the $\tfrac12$ living one level down at $\Lambda^2$, which is [conventions.md](../findings/conventions.md)'s "*the $\tfrac12$ goes at the $\Lambda^2$ level, not the operator level*".

## 1. Hypothesis inventory

### 1.1 What the identity actually needs

| hypothesis | needed? | stated where |
| --- | --- | --- |
| $R$ symmetric, i.e. $R\in S^2(\Lambda^2\mathbb R^n)$ | **yes**, otherwise $R^\#$ and $\mathrm{Alt}$ are not the objects named | **nowhere in either L15 block**; carried at [ATTEMPTS.md](../ATTEMPTS.md):622 and [REVIEW_r470.md](../reviews/REVIEW_r470.md) |
| $R\in\mathcal W_n$ (Weyl) | **no** (and the identity is *vacuous* on $\mathcal W_n$, both sides being $0$ |), |
| $R$ a curvature operator ($R\in S^2_B$, first Bianchi) | **no** (the identity's whole point is the $\Lambda^4$ term, which vanishes on $S^2_B$ |), |
| $\mathrm{Ric}(R)=0$ | **no** |, |
| criticality $Q(R)=\theta R$ | **no** |, |
| $\lVert R\rVert=1$ | **no** (both sides are homogeneous of degree $2$ |), |
| a dimension bound | **no**, see §2 for $n=4$ and $n<4$ | "in every dimension", [problem.md](../findings/problem.md):204 |

So the correct statement is: **for every symmetric $R$ on $\Lambda^2\mathbb R^n$, at every $n$.** This matches [REVIEW_r470.md](../reviews/REVIEW_r470.md):103 ("*none beyond $R$ symmetric on $\Lambda^2\mathbb R^n$*"). Neither of the record's two carrying sites says it. At [results.md](../results.md):647 the display stands alone with $R$ appearing for the first time in the file at that point, and with $\mathrm{Alt}$ never defined, see §6.

### 1.2 Hypotheses of the results the argument imports

| imported result | its hypothesis | checked against the object |
| --- | --- | --- |
| [Böhm–Wilking Lemma 2.1](../references/boehm-wilking-2008-space-forms/notes.md), $R+R\#I=\mathrm{Ric}(R)\wedge\mathrm{id}$ | **$R\in S^2_B(\mathfrak{so}(n))$**, the Bianchi subspace | applied only to $R_B=R-\mathrm{Alt}(R)$, which is in $S^2_B$ by construction; **the hypothesis is live and is exactly what the $3\,\mathrm{Alt}$ term pays for** |
| [L79](../findings/isotropy-cap.md)'s table / [L131](../findings/isotropy-cap.md)(i), $\#I=+2$ on $\Lambda^4$ | $m\ge3$; $O(m)$-equivariance of $\#$ | holds; I re-derive the $\Lambda^4$ value independently in §3.2 rather than import it |
| $\mathrm{Ric}$ annihilates $\Lambda^4$ | none | verified in §3.2 for $\star$ at $n=4$ and structurally for $\Lambda^4$ at every $n$ |
| $\mathrm{Ric}^*=2(\,\cdot\wedge\mathrm{id})$ is $\mathrm{Ric}$'s adjoint | none | anchored at $R=I$ in §3.1 |
| full symmetry of $\langle A\#B,C\rangle$ | none, it is Huisken's $\mathrm{tri}$, read at [Böhm–Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md) | used once, to turn $\operatorname{tr}(R^\#)$ into $\langle R\#I,R\rangle$ |
| $\mathrm{Alt}$ self-adjoint idempotent | it is an orthogonal projection | gives $\langle\mathrm{Alt}(R),R\rangle=\lVert\mathrm{Alt}(R)\rVert^2$ |

**What the written argument uses: nothing.** [problem.md](../findings/problem.md):198 *names* a route, "*verified three ways, by depolarising L131 and at the anchors $R=\mathrm{Id}$ and $R\in\Lambda^4$*", and displays none of it. The route is genuine and I rebuild it in §3; the two-line contraction is displayed in [REVIEW_r470.md](../reviews/REVIEW_r470.md), which [results.md](../results.md):218 cites. So the argument is **on the record but in neither of the two files a consumer is sent to.**

### 1.3 Sources: read, and unread

- **Read, and in [references/](../references/):** [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md), the definition of $\#$, the full symmetry of $\mathrm{tri}$, and Lemma 2.1 with its $S^2_B$ hypothesis and its three eigenvalues $n-2$, $\tfrac{n-4}2$, $-1$. Everything the derivation imports from the literature comes from this one page.
- **Unread, and load-bearing for C4 and C5 only:** Jäger's §3.2 master inequality itself. [references/jaeger-2016-diagonal-case/notes.md](../references/jaeger-2016-diagonal-case/notes.md) transcribes Theorem A, the vertex-matrix setup and the §3.5 quartics, and **carries neither Lemma 3.2.2 nor equation (1.6)**. The claim "*his inequality fails by a factor of three*" is therefore a claim about a lemma whose statement is not in the stored notes; [ATTEMPTS.md](../ATTEMPTS.md):610 gives the master inequality as $\theta\lVert\Lambda\rVert_{\ell^1}=\lVert\lvert\Lambda\rvert\mathbf1\rVert^2-2\lVert\Lambda_-\rVert_F^2-C_\#(W)$ and :622 gives the corrected invariant form, both from the project's own reading of the PDF rather than from the notes. **This does not touch C1–C3, C6 or the identity**, which are self-contained.

## 2. Question 1, the derivation, the constant, and what it is a constant *of*

### 2.1 The derivation, in full

Every step is an identity between symmetric operators on $\Lambda^2\mathbb R^n$, for an arbitrary symmetric $R$; no hypothesis enters.

**Step 1, the sharp trace is a pairing with $\#I$.** By the full symmetry of $\operatorname{tr}(2(R_1\#R_2)R_3)$ ([Böhm–Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md)),
$$\operatorname{tr}(R^\#)=\langle R\,\#\,R,\,I\rangle=\langle R\,\#\,I,\,R\rangle .$$

**Step 2, Böhm–Wilking's Lemma 2.1, carried off the Bianchi locus.** $S^2(\Lambda^2\mathbb R^n)=S^2_B\oplus\Lambda^4$ orthogonally, with $\mathrm{Alt}$ the projection onto the second summand. Write $R=R_B+\mathrm{Alt}(R)$. On $R_B$, Lemma 2.1 reads $R_B+R_B\#I=\mathrm{Ric}(R_B)\wedge\mathrm{id}$. On $\mathrm{Alt}(R)\in\Lambda^4$, $\mathrm{Ric}$ annihilates it and $\#I$ acts by $c_4=2$ (proved independently at §3.2), so $\mathrm{Alt}(R)+\mathrm{Alt}(R)\#I=(1+c_4)\mathrm{Alt}(R)=3\,\mathrm{Alt}(R)$. Adding, and using $\mathrm{Ric}(R)=\mathrm{Ric}(R_B)$,
$$R+R\,\#\,I=\mathrm{Ric}(R)\wedge\mathrm{id}+3\,\mathrm{Alt}(R)\qquad\text{for every symmetric }R,$$
which is [Lemma L131](../findings/isotropy-cap.md):414's display rearranged.

**Step 3, pair with $R$.** $\langle\mathrm{Alt}(R),R\rangle=\lVert\mathrm{Alt}(R)\rVert^2$ because $\mathrm{Alt}$ is a self-adjoint idempotent, and $\langle\mathrm{Ric}(R)\wedge\mathrm{id},R\rangle=\tfrac12\langle\mathrm{Ric}^*(\mathrm{Ric}(R)),R\rangle=\tfrac12\lVert\mathrm{Ric}(R)\rVert^2$ because $\mathrm{Ric}^*=2(\,\cdot\wedge\mathrm{id})$ is $\mathrm{Ric}$'s adjoint. So
$$\operatorname{tr}(R^2)+\operatorname{tr}(R^\#)=\langle R,R\rangle+\langle R\#I,R\rangle=\tfrac12\lVert\mathrm{Ric}(R)\rVert^2+3\lVert\mathrm{Alt}(R)\rVert^2 .$$

**Step 4, apply $\operatorname{scal}=2\operatorname{tr}$.** Doubling gives the display, with the constant $6=2\cdot3=2(1+c_4)$:
$$\operatorname{scal}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2 .\qquad\square$$

This is the record's own route ([problem.md](../findings/problem.md):198's "depolarising L131"), rebuilt rather than supplied: I add no step the record does not name. **What I do supply that the record only asserts is $c_4=2$ at every $n$** (§3.2), because [L79](../findings/isotropy-cap.md)'s proof of it, "*the standard Casimir values on the highest weights $0$, $[2]$, $[2,2]$, $[1^4]$ return $-2(m-2)$, $-(m-4)$, $+2$, $-4$ in four lines*", displays no Casimir value, and that is an assertion, not four lines.

### 2.2 What the constant $6$ depends on, none of it named in the block

The constant is a product of four independent normalisation choices. **The L15 block names one of them** ("$\mathrm{Alt}$ being the projection onto $\Lambda^4$") and [results.md](../results.md):647 names none.

| ingredient | the record's choice | value of the $\mathrm{Alt}$ coefficient under the record's alternative |
| --- | --- | --- |
| $\operatorname{scal}$ | $\operatorname{scal}=2\operatorname{tr}$ | under $\operatorname{scal}=\operatorname{tr}$ the identity becomes $\tfrac12\lVert\mathrm{Ric}\rVert^2+3\lVert\mathrm{Alt}\rVert^2$: **both** RHS constants halve, so the display as written is false |
| $\Lambda^2$ pairing | half-trace, $\lVert\varphi_{ab}\rVert^2=1$ | under plain Frobenius every $\#I$ eigenvalue halves ([isotropy-cap.md](../findings/isotropy-cap.md):285), so $c_4=1$ and $2(1+c_4)$ becomes $4$ |
| $\mathrm{Alt}$ | the orthogonal projection, carrying $\tfrac13$ | under the **unnormalised** Bianchi map $b(R)=3\,\mathrm{Alt}(R)$ (the commoner convention in the literature), $\lVert b(R)\rVert^2=9\lVert\mathrm{Alt}(R)\rVert^2$ and the constant is $\tfrac23$ |
| $\mathrm{Ric}$, $\mathrm{Ric}^*$ | $\mathrm{Ric}(R)_{ij}=\sum_kR_{ikjk}$, $n\times n$ Frobenius, $\mathrm{Ric}^*=2(\cdot\wedge\mathrm{id})$ | fixes the coefficient $1$ on $\lVert\mathrm{Ric}\rVert^2$; halving $\mathrm{Ric}^*$ would make it $\tfrac12$ and leave $6$ alone |

The two that matter most are the first and second, and **the first is the one the round's note points at**: [conventions.md](../findings/conventions.md) tables $\operatorname{scal}=2\operatorname{tr}$ with the remark that three verifiers pinned it on a consumer of this very identity, [Lemma L7](../findings/bounds.md), and "*found the convention tabled nowhere*". It is tabled now. **The $\Lambda^2$ half-trace is tabled too but its effect on this constant is not**: [isotropy-cap.md](../findings/isotropy-cap.md):285 records the halving for [L79](../findings/isotropy-cap.md)'s table and no site propagates it to L15's $6$. That propagation is the table row above and it is new here.

### 2.3 "No cross-term", and where the argument needs $O(n)$ rather than $SO(n)$

The claim is that the right-hand side is a sum of two squares with no $\langle\mathrm{Ric},\mathrm{Alt}\rangle$-type term. **Step 3 produces it directly** (no cross-term ever appears) so the claim needs no separate argument on the route above.

The record's *reason*, at [ATTEMPTS.md](../ATTEMPTS.md):622, is a Schur argument: "*$\Lambda^4$ occurs once in $S^2(\Lambda^2)$ and not at all in the Bianchi subspace*", so an invariant quadratic form has no cross terms. **That argument is incomplete at $n=4$ unless the group is $O(n)$.** At $n=4$, $\Lambda^4\mathbb R^4$ and $\mathbb R\cdot I$ are both one-dimensional and are **isomorphic as $SO(4)$-representations**, precisely the collision [L79](../findings/isotropy-cap.md)'s block records, where it writes that "*$SO(4)$-Schur licenses mixing between them and not merely a second scalar*". Under $SO(4)$-Schur alone the invariant quadratic form is licensed a cross-term $\propto\operatorname{tr}(R)\,\langle R,\star\rangle$.

It survives, for a reason the record does not state at this site: $\#$ and $\operatorname{scal}$ are $O(n)$-equivariant ([Böhm–Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md) calls $\#$ "*Hamilton's second natural $O(n)$-equivariant bilinear map*"), $\star$ changes sign under an orientation-reversing element of $O(4)$ while $\operatorname{tr}(R)$ does not, so the candidate cross-term is odd and cannot appear. **Recorded as a gap in the stated reason, not in the result.**

### 2.4 Quantifier order and scope, and the edges

The statement is $\forall n\;\forall R\in S^2(\Lambda^2\mathbb R^n)$. There is no quantifier alternation and no hidden dependence: $6$ does not depend on $n$, on $R$, or on a frame. Every edge:

- **$n\ge5$.** $\Lambda^4$ is $O(n)$-irreducible; nothing degenerates.
- **$n=4$.** $\Lambda^4$ is one-dimensional, spanned by $\star$ with $\lVert\star\rVert^2=6$. Two collisions occur and neither bites: (i) $\#I$'s eigenvalue on $\mathbb R\cdot I$ is $n-2=2$, **equal** to $c_4=2$, so the two summands are indistinguishable by the $\#I$ spectrum, but the derivation uses only the forward direction, summand to eigenvalue, exactly as [L79](../findings/isotropy-cap.md)'s block says every consumer does; (ii) the $SO(4)$ isomorphism of §2.3. **Verified directly at $n=4$ in §3.2.**
- **$n=3$.** $\Lambda^4=0$ and $\mathcal W_3=0$, so $S^2(\Lambda^2\mathbb R^3)=\mathbb R I\oplus S^2_0$ ($1+5=6$) and the identity reduces to $\operatorname{scal}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2$. It holds, checked at $R=I$ in §3.1 and on $S^2_0$ in §3.3. **The constant $6$ is vacuous here**, so "exactly $6$ in every dimension" is true but carries no content below $n=4$.
- **$n=2$.** $\Lambda^2\mathbb R^2$ is one-dimensional and $\mathfrak{so}(2)$ is abelian, so $\#\equiv0$; consistently, $I\#I=(n-2)I=0$. At $R=aI$: LHS $=2a^2$, and $\mathrm{Ric}(aI)=a\,\mathrm{Id}_2$ gives RHS $=2a^2$. Holds.
- **$n\le1$.** $\Lambda^2=0$; vacuous.

**No finding: there is no dimension at which the identity or its constant fails, and no dimension the block's "in every dimension" over-claims.**

## 3. Question 1 continued, the identity checked at named objects, by hand

### 3.0 The bracket data all five checks run on

With $\varphi_{ab}=E_{ab}-E_{ba}$ and the half-trace pairing, $\{\varphi_{ab}\}_{a<b}$ is orthonormal and $[\varphi_{ab},\varphi_{bc}]=\varphi_{ac}$ for distinct $a,b,c$ (computed from $[E_{12}-E_{21},E_{13}-E_{31}]=-E_{23}+E_{32}=-\varphi_{23}$, i.e. $[\varphi_{21},\varphi_{13}]=\varphi_{23}$). Two consequences used throughout:

- $\operatorname{tr}(A^\#)=\tfrac12\sum_{\alpha,\beta}\mu_\alpha\mu_\beta\lVert[\varphi_\alpha,\varphi_\beta]\rVert^2$ in an eigenbasis $A\varphi_\alpha=\mu_\alpha\varphi_\alpha$, directly from the definition of $\#$.
- At $n=4$, with $a_1=\tfrac1{\sqrt2}(\varphi_{12}+\varphi_{34})$, $a_2=\tfrac1{\sqrt2}(\varphi_{13}+\varphi_{42})$, $a_3=\tfrac1{\sqrt2}(\varphi_{14}+\varphi_{23})$ an orthonormal basis of $\Lambda^2_+$: $[a_1,a_2]=\tfrac12(-\varphi_{23}-\varphi_{14}-\varphi_{14}-\varphi_{23})=-(\varphi_{14}+\varphi_{23})=-\sqrt2\,a_3$, so $\lVert[a_i,a_j]\rVert^2=2$ for $i\ne j$. Same for the $b_i$ spanning $\Lambda^2_-$, and $[\Lambda^2_+,\Lambda^2_-]=0$.

### 3.1 The Kulkarni–Nomizu identity operator $R=I$, at every $n$

$I^2=I$ so $\operatorname{tr}(I^2)=\binom n2$. $I\#I=(n-2)I$ ([Böhm–Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md):75, and independently from $\sum_\alpha\lVert[\varphi_\alpha,\xi]\rVert^2=2(n-2)\lVert\xi\rVert^2$, which is [Lemma L153](../findings/bounds.md)), so $\operatorname{tr}(I^\#)=(n-2)\binom n2$. Hence
$$\operatorname{scal}(I^2+I^\#)=2(n-1)\binom n2=n(n-1)^2 .$$
$\mathrm{Alt}(I)=0$ since $I$ satisfies first Bianchi. $\mathrm{Ric}(I)=(n-1)\mathrm{Id}_n$, so $\lVert\mathrm{Ric}(I)\rVert^2=n(n-1)^2$. **Equal, at every $n$. This anchor fixes the coefficient on $\lVert\mathrm{Ric}\rVert^2$ at exactly $1$ and is blind to the $\mathrm{Alt}$ term.** It also confirms the convention block: $\operatorname{scal}(I)=2\binom n2=n(n-1)$ is the scalar curvature of the unit round $S^n$, and $\langle\mathrm{Ric}(I)\wedge\mathrm{id},I\rangle=\tfrac12\lVert\mathrm{Ric}(I)\rVert^2$ forces $\mathrm{Id}_n\wedge\mathrm{id}=I$, consistent with $\mathrm{Ric}^*=2(\cdot\wedge\mathrm{id})$.

### 3.2 $\star$ at $n=4$, and $c_4=2$ at every $n$

**At $n=4$.** For $\xi=a_3$, only pairs $(\alpha,\beta)$ inside $\Lambda^2_+$ contribute to $\langle(\star\#I)\xi,\xi\rangle$ (pairs inside $\Lambda^2_-$ bracket into $\Lambda^2_-\perp a_3$, mixed pairs bracket to zero), and $\star a_\alpha=a_\alpha$ there:
$$\langle(\star\#I)a_3,a_3\rangle=\tfrac12\sum_{\alpha,\beta\in\{1,2,3\}}\langle[a_\alpha,a_\beta],a_3\rangle^2=\tfrac12\big(2+2\big)=2 .$$
For $\xi=b_3$ only pairs inside $\Lambda^2_-$ contribute and $\star b_\alpha=-b_\alpha$, giving $-2$. Since $\Lambda^4\mathbb R^4=\mathbb R\star$ is one-dimensional and $\#I$ is $O(4)$-equivariant, $\star\#I=c_4\star$ with $c_4=\langle(\star\#I)a_3,a_3\rangle/\langle\star a_3,a_3\rangle=2$. Equivalently $\Pi_\pm^\#=2\Pi_\pm$ and $\star^\#=\star\#\star=\Pi_+^\#+\Pi_-^\#=2\,\mathrm{Id}$, the cross term $\Pi_+\#\Pi_-$ vanishing because $[\Lambda^2_+,\Lambda^2_-]=0$.

Then for $R=t\star$: $\operatorname{tr}(R^2)=t^2\operatorname{tr}(\mathrm{Id})=6t^2=\lVert R\rVert^2$ (confirming $\lVert\star\rVert^2=6$), $\operatorname{tr}(R^\#)=\langle R\#I,R\rangle=2\lVert R\rVert^2=12t^2$, so
$$\operatorname{scal}(R^2+R^\#)=2(6t^2+12t^2)=36t^2 .$$
$\mathrm{Ric}(\star)=0$ because $\star_{ijkl}\propto\epsilon_{ijkl}$ and $\sum_k\epsilon_{ikjk}=0$; $\mathrm{Alt}(R)=R$. RHS $=6\cdot6t^2=36t^2$. **Equal. This anchor fixes the $\mathrm{Alt}$ coefficient at exactly $6$ and is blind to the $\mathrm{Ric}$ term.**

**At every $n\ge5$.** $\Lambda^4\mathbb R^n$ is $O(n)$-irreducible and $\#I$ is $O(n)$-equivariant and self-adjoint, so $\#I$ acts on $\Lambda^4$ by a single scalar $c_4$, and one element determines it. Take $\star_4$, the Hodge star of a fixed $4$-plane padded by zero. For $\xi,\eta\in\mathfrak{so}(4)$, the sum defining $\langle(\star_4\#I)\xi,\eta\rangle$ has $\alpha$ confined to $\mathfrak{so}(4)$ by $\star_4$, and then $[\varphi_\alpha,\varphi_\beta]$ meets $\mathfrak{so}(4)$ only for $\beta\in\mathfrak{so}(4)$, since $[\mathfrak{so}(4),\text{mixed}]\subseteq\text{mixed}$ and $[\mathfrak{so}(4),\mathfrak{so}(n-4)]=0$. So the $\mathfrak{so}(4)$-block of $\star_4\#I_n$ equals $\star_4\#I_4=2\star_4$, and since $\star_4$ is supported there,
$$c_4\lVert\star_4\rVert^2=\operatorname{tr}\big((\star_4\#I_n)\,\star_4\big)=\operatorname{tr}(2\star_4\star_4)=2\lVert\star_4\rVert^2,\qquad c_4=2 .$$
**So $c_4=2$ at every $n\ge4$, with no Casimir value taken on trust**, and $6=2(1+c_4)$ is dimension-free. Two by-products, both confirming the record: the mixed block vanishes, for $\xi=\varphi_{15}$, $\sum_\alpha\langle\star_4\varphi_\alpha,\varphi_{1j}\rangle\langle\varphi_\alpha,\varphi_{1j}\rangle=\langle\star_4\varphi_{1j},\varphi_{1j}\rangle=0$, and the $\mathfrak{so}(n-4)$ block vanishes for want of any bracket reaching it.

### 3.3 The remaining two summands, closing the check

$\mathcal W_n$: $\mathrm{Ric}=0$ and $\mathrm{Alt}=0$, so the identity says $\operatorname{tr}(W^2)+\operatorname{tr}(W^\#)=0$, i.e. $\operatorname{tr}(W^\#)=-\lVert W\rVert^2$, which is $W\#I=-W$, [Böhm–Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md):74 boxed. **The identity is vacuous on $\mathcal W_n$, which is exactly [ATTEMPTS.md](../ATTEMPTS.md):610's "*vacuous on $W$ itself*".**

$S^2_0$: for traceless $h$ take $R=h\wedge\mathrm{id}=\tfrac12\mathrm{Ric}^*(h)$, which acts on $\varphi_{ij}$ by $\tfrac12(\eta_i+\eta_j)$ in $h$'s eigenframe ([post F54](../findings/second-order.md), quoted in [L154](../findings/bounds.md)). Then $\mathrm{Ric}(R)_{ii}=\tfrac12\sum_{j\ne i}(\eta_i+\eta_j)=\tfrac12\big((n-2)\eta_i+\operatorname{tr}h\big)=\tfrac{n-2}2\eta_i$, so $\mathrm{Ric}(R)=\tfrac{n-2}2h$ and $\mathrm{Ric}(R)\wedge\mathrm{id}=\tfrac{n-2}2R$. Against Step 2's $R+R\#I$ with $\#I=\tfrac{n-4}2$ on $S^2_0$: $R+\tfrac{n-4}2R=\tfrac{n-2}2R$. **Equal.** With §3.1, §3.2 and the $\mathcal W_n$ line this verifies Step 2 on all four summands at every $n$, independently of Lemma 2.1.

### 3.4 A named sphere product: $S^2\times S^2$ at $n=4$

Unit factors give $R_{1212}=R_{3434}=1$ and all other sectional curvatures zero, so $R$ is diagonal in the pair basis with $\operatorname{scal}=2\operatorname{tr}R=4$; the metric is Einstein, so the Weyl part is $W=R-\tfrac{4}{12}I$, i.e. $\operatorname{diag}(\tfrac23,-\tfrac13,-\tfrac13,-\tfrac13,-\tfrac13,\tfrac23)$ on $(12),(13),(14),(23),(24),(34)$. Row sums vanish: $\tfrac23-\tfrac13-\tfrac13=0$. Its negative spectral part is $W_-=\operatorname{diag}(0,\tfrac13,\tfrac13,\tfrac13,\tfrac13,0)$, **still diagonal in the pair basis**.

A pair-basis-diagonal operator $D$ has $D_{ijkl}=0$ unless $\{i,j\}=\{k,l\}$, while every component of $\mathrm{Alt}(D)$ carries four distinct indices; so $\mathrm{Alt}(D)=0$. Hence $\delta^2=0$ here, and the identity at $W_-$ reads $\operatorname{scal}(W_-^2+W_-^\#)=\lVert\mathrm{Ric}(W_-)\rVert^2$, which is exactly the Bianchi-free form Jäger's opening step uses. **The argument is uniform: it covers every $S^p\times S^q$ at every $n$, in the product frame; and since $W_-$ is spectral, $\delta^2$ is an $O(n)$-invariant of $W$, so "in any frame" adds nothing.** C6 confirmed, with the qualifier that its "in any frame" is vacuous under the record's own definition of $W_-$ and would only be substantive for Jäger's frame-dependent entrywise $\lvert W\rvert$, which the block does not say it means.

### 3.5 Fox's $\mathcal S^4(\alpha)$, every number in C4 and C5, derived by hand

$W$ is supported on $\Lambda^2_+$ of a fixed $4$-plane with spectrum proportional to $(2,-1,-1)$ ([ATTEMPTS.md](../ATTEMPTS.md):318's $\operatorname{diag}(2,-1,-1)$ orbit), padded by zero into $\mathbb R^n$ for any $n\ge4$. Unit norm: $\operatorname{tr}(W^2)=c^2(4+1+1)=6c^2=1$, so $c=1/\sqrt6$ and $W=c(2a_1a_1^{\mathsf T}-a_2a_2^{\mathsf T}-a_3a_3^{\mathsf T})$.

**(a) $\theta=\sqrt{3/2}$.** $\operatorname{tr}(W^3)=c^3(8-1-1)=6c^3=1/\sqrt6$. From §3.0, $\langle W^\#a_1,a_1\rangle=2\mu_2\mu_3=2c^2$ and $\langle W^\#a_2,a_2\rangle=\langle W^\#a_3,a_3\rangle=2\mu_1\mu_3=-4c^2$, so $\operatorname{tr}(W^\#W)=2c\cdot2c^2+(-c)(-4c^2)\cdot2=12c^3=2/\sqrt6$. Hence $\theta=1/\sqrt6+2/\sqrt6=3/\sqrt6=\sqrt{3/2}$. *And $\operatorname{tr}(W^\#)=2c^2-4c^2-4c^2=-6c^2=-1=-\lVert W\rVert^2$, so the identity at $R=W$ gives $0=0$ as §3.3 requires.*

**(b) $\delta^2=\tfrac19$, exactly.** $W_-=c(\Pi_+-a_1a_1^{\mathsf T})$ with $\Pi_+=\tfrac12(I_4+\star)$. Now $\mathrm{Alt}(I_4)=0$ and $\mathrm{Alt}(\star)=\star$, so $\mathrm{Alt}(\Pi_+)=\tfrac12\star$. For the rank-one piece, $(a_1a_1^{\mathsf T})_{1234}=(a_1)_{12}(a_1)_{34}=\tfrac12$ while $(a_1a_1^{\mathsf T})_{1342}=(a_1)_{13}(a_1)_{42}=0$ and $(a_1a_1^{\mathsf T})_{1423}=0$, so $\mathrm{Alt}(a_1a_1^{\mathsf T})_{1234}=\tfrac13\cdot\tfrac12=\tfrac16$; since $\star_{1234}=\star_{1342}=\star_{1423}=1$ gives $\mathrm{Alt}(\star)_{1234}=1$, this says $\mathrm{Alt}(a_1a_1^{\mathsf T})=\tfrac16\star$. Hence
$$\mathrm{Alt}(W_-)=c\big(\tfrac12-\tfrac16\big)\star=\tfrac{c}{3}\star=\tfrac{1}{3\sqrt6}\star,\qquad \delta^2=\tfrac{1}{54}\cdot6=\tfrac19 .$$
**The coefficient $\tfrac1{3\sqrt6}$ is [conventions.md](../findings/conventions.md)'s $a=1/(3\sqrt6)$ on the nose, sign included**, and $\tfrac19$ is [Conjecture L16](../results.md)'s "defect exactly $1/9$ in every ambient dimension". Independent of $n$, since nothing above sees an index above $4$.

**(c) $\theta\operatorname{scal}(\lvert W\rvert)=4$.** $\lvert W\rvert$ has spectrum $c\,(2,1,1)$ on $\Lambda^2_+$ and zero elsewhere, so $\operatorname{scal}(\lvert W\rvert)=2\operatorname{tr}\lvert W\rvert=8c=8/\sqrt6$ and $\theta\operatorname{scal}(\lvert W\rvert)=\sqrt{3/2}\cdot 8/\sqrt6=8\sqrt3/\sqrt{12}=4$.

**(d) Jäger's right-hand side is $\tfrac43$.** $\mathrm{Ric}(W)=0$ gives $\mathrm{Ric}(\lvert W\rvert)=2\,\mathrm{Ric}(W_-)$. Now $\mathrm{Ric}(I_4)=3P_4$ with $P_4=\operatorname{diag}(1,1,1,1,0,\dots)$, $\mathrm{Ric}(\star)=0$, so $\mathrm{Ric}(\Pi_+)=\tfrac32P_4$; and $\mathrm{Ric}(a_1a_1^{\mathsf T})_{ij}=\sum_k(a_1)_{ik}(a_1)_{jk}=\tfrac12P_4$. So $\mathrm{Ric}(W_-)=c(\tfrac32-\tfrac12)P_4=cP_4$, $\mathrm{Ric}(\lvert W\rvert)=2cP_4$, and $\lVert\mathrm{Ric}(\lvert W\rvert)\rVert^2=4c^2\cdot4=\tfrac{16}6=\tfrac83$. With $\lVert W_-\rVert_F^2=2c^2=\tfrac13$,
$$\lVert\mathrm{Ric}(\lvert W\rvert)\rVert^2-4\lVert W_-\rVert_F^2=\tfrac83-\tfrac43=\tfrac43 .$$

**(e) The factor of three, and the saturation.** $4$ against $\tfrac43$ is a failure by exactly $3$. The correction is $6\lVert\mathrm{Alt}(\lvert W\rvert)\rVert^2=6\cdot4\delta^2=24\cdot\tfrac19=\tfrac83$, and $\tfrac43+\tfrac83=4$ **exactly**: the corrected inequality is saturated. **C4 and C5 confirmed by hand, at every $n\ge4$.** The $24$ is $6\cdot4$ with the $4$ from $\mathrm{Alt}(\lvert W\rvert)=2\mathrm{Alt}(W_-)$, [isotropy-cap.md](../findings/isotropy-cap.md):414's warning that "*a constant stated at $\lvert W\rvert$ is not comparable with one stated at $W_-$*" is the whole of the difference between L15's $24$ and [L7](../findings/bounds.md)'s $6$, and both are right.

**(f) The identity itself at $\lvert W\rvert$, the only check where both terms are live.** $\operatorname{tr}(\lvert W\rvert^2)=1$, and from §3.0 with $\mu=c(2,1,1)$ and $\lVert[a_i,a_j]\rVert^2=2$,
$$\operatorname{tr}(\lvert W\rvert^\#)=\tfrac12\cdot 2\cdot 2\,(\mu_1\mu_2+\mu_1\mu_3+\mu_2\mu_3)=2c^2(2+2+1)=10c^2=\tfrac53 .$$
LHS $=2(1+\tfrac53)=\tfrac{16}3$. RHS $=\lVert\mathrm{Ric}(\lvert W\rvert)\rVert^2+6\lVert\mathrm{Alt}(\lvert W\rvert)\rVert^2=\tfrac83+\tfrac83=\tfrac{16}3$. **Equal.** This is the sharpest of the five checks: it is the only named object at which $\mathrm{Ric}$ and $\mathrm{Alt}$ are *simultaneously* non-zero, so it is the only one that could have exposed a cross-term, and it does not.

## 4. Question 2, is the displayed content this result's own? And the form comparison

### 4.1 L15 and L131 are the same statement, and each recovers the other

[Lemma L131](../findings/isotropy-cap.md):414 carries $\mathrm{Ric}(R)\wedge\mathrm{id}=R+R\#I-3\,\mathrm{Alt}(R)$ for every symmetric $R$. §2.1 Step 3 derives L15's display from it. The converse also holds, so nothing is lost either way: polarising L15 gives, for all symmetric $A,B$, $2\operatorname{tr}(AB)+2\operatorname{tr}(A\#B)=\langle\mathrm{Ric}A,\mathrm{Ric}B\rangle+6\langle\mathrm{Alt}A,\mathrm{Alt}B\rangle$; rewriting $\operatorname{tr}(A\#B)=\langle A\#I,B\rangle$ and $\langle\mathrm{Ric}A,\mathrm{Ric}B\rangle=\langle\mathrm{Ric}^*\mathrm{Ric}A,B\rangle=2\langle\mathrm{Ric}(A)\wedge\mathrm{id},B\rangle$ and cancelling the (nondegenerate) $B$ returns L131 exactly. **So the two are equivalent, and L15's display adds no mathematical content to L131's**, which is what [lean/INDEX.md](../lean/INDEX.md):183's row says.

**One direction is stated backwards in two places.** L131 is the *polarised* (equivalently, operator-valued) form and L15 is its *contraction against $R$*. [isotropy-cap.md](../findings/isotropy-cap.md):414 has it right, "*This is [Observation L15](../findings/problem.md) polarised*", and so does [problem.md](../findings/problem.md):198, which says the identity is obtained "*by depolarising L131*". But [results.md](../results.md):218 writes "*The identity below is confirmed and is [Lemma L131](../findings/isotropy-cap.md) polarised*", and [lean/INDEX.md](../lean/INDEX.md):183 repeats it as "*the displayed identity is L131 polarised*". A quadratic form is not the polarisation of anything. **Harmless to the mathematics, since the two are equivalent; a defect in the record's own dependency direction, and it is on the two sites a consumer reads first.**

### 4.2 What a consumer citing L15 gets that citing L131 would not

| content | at [L15](../findings/problem.md) | at [L131](../findings/isotropy-cap.md) |
| --- | --- | --- |
| the operator identity off the Bianchi locus |, | **yes**, with the $3=1+c_4$ named |
| the scalar/quadratic form, ready to contract | **yes** | recoverable in one line |
| "the constant exactly $6$ in every dimension" | **yes** | the $c_4=2$ input, not the assembled $6$ |
| "no cross-term" | **yes** |, |
| $\mathrm{Alt}(\lvert W\rvert)=2\mathrm{Alt}(W_-)$, hence $+24\delta^2$ | **yes** | **yes**, "Two conventions to carry" |
| the price in Jäger's §3.2, the Fox factor of three, the saturation | **yes** |, |
| zero defect at every sphere product | **yes** |, |
| $\mathcal A=-2(\cdot\#I)$ and [L79](../findings/isotropy-cap.md)'s table proved at every $n$ |, | **yes** |

**So L15's own content is the four riders, not the identity.** The identity belongs to L131 (and, on the Bianchi locus, to Böhm–Wilking's Lemma 2.1); L15 contributes the assembled constant, the absence of a cross-term, the transfer to $\lvert W\rvert$ with its factor $4$, and the two evaluations at Fox and at sphere products. That is real content, and it is what makes the block worth a number, but the block's *display*, the only thing [results.md](../results.md):647 carries, is the part that is not its own.

### 4.3 Comparing the forms across the record

| site | what it states | agrees? |
| --- | --- | --- |
| [problem.md](../findings/problem.md):203–204 | display **plus** the four riders; "need not satisfy"; $\mathrm{Alt}$ defined as "the projection onto $\Lambda^4$" | **the fullest and the most correct form on the record** |
| [results.md](../results.md):218 | landscape line: the TWO OBSTRUCTIONS correction, $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$, and the L131 pointer (direction reversed) | correction present; **no display** |
| [results.md](../results.md):647 | the display alone, ending in a dangling comma; no $\mathrm{Alt}$, no quantifier on $R$, no rider, no correction banner | **defective, see §6** |
| [isotropy-cap.md](../findings/isotropy-cap.md):414 | the operator form, with the $c_4$ and both conventions | agrees |
| [ATTEMPTS.md](../ATTEMPTS.md):622 | the display **with the quantifier** "for every symmetric $R$ on $\Lambda^2\mathbb R^n$", plus the Schur reason and the corrected master inequality | agrees; **the only site carrying the hypothesis** |
| [bounds.md](../findings/bounds.md):48, [ungraded-slack.md](../findings/ungraded-slack.md):188 and :333 | the polarised consequence, as $6\delta^2$ | agrees, §5.1 |
| [conventions.md](../findings/conventions.md) | $\operatorname{scal}=2\operatorname{tr}$, tabled for exactly this constant | agrees |

**No competing constant anywhere on the record.** Every restatement carries $6$ at $W_-$ or $24$ at $\lvert W\rvert$, and the two are one number under $\mathrm{Alt}(\lvert W\rvert)=2\mathrm{Alt}(W_-)$.

### 4.4 The Lean form

[L15.lean](../lean/HamiltonsCubic/Results/L15.lean) exists and its row is [lean/INDEX.md](../lean/INDEX.md):183, marked **partial**. What it proves is `polarisation_general` (that a symmetric additive $B$ satisfies $B(x+y,x+y)-B(x,x)-B(y,y)=2B(x,y)$ over $\mathbb Q$), plus `count_wrong : (1:ℕ) ≠ 2`. Its own `Owed` line reads "*the identity itself and its identification with L131*".

**So the identity is not machine-checked, and the row says so.** The row is honest about its reach; what it does not say is that the two theorems it does carry are about $\mathbb Q$ and about $\mathbb N$, neither of which mentions $\Lambda^2\mathbb R^n$, $\#$, $\mathrm{Ric}$ or $\mathrm{Alt}$. **A row that would carry L15 would have to claim:** for a finite-dimensional real inner-product space $V$ and $R\in S^2(\Lambda^2V)$, with $\#$ defined by Böhm–Wilking's eq. (4) and $\mathrm{Alt}$ the orthogonal projection onto $\Lambda^4V$, $2\operatorname{tr}(R^2+R\#R)=\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2$, and its owed list would be Böhm–Wilking's Lemma 2.1 on $S^2_B$ together with $\#I|_{\Lambda^4}=2$, which §3.2 shows is one $n=4$ bracket computation plus Schur.

## 5. Item 5 and Question 3, the gap between proven and used, the L7 import, and the second obstruction

### 5.1 [Lemma L7](../findings/bounds.md) imports this identity, and what it uses **is** what L15 establishes

[bounds.md](../findings/bounds.md):51 says: "*Polarising [L15](../findings/problem.md)'s identity at $(W_+,W_-)$, with $\mathrm{Ric}(W)=0$ and $\mathrm{Alt}(W)=0$, turns that into $\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2$ exactly.*" I checked the step in full.

Write $\Phi(A,B)$ for the symmetric bilinear form polarising the left side. Since $R^2$ polarises to $\tfrac12(AB+BA)$ and $R^\#=R\#R$ to $A\#B$,
$$\Phi(A,B)=\operatorname{scal}\big(\tfrac12(AB+BA)+A\#B\big)=2\operatorname{tr}(AB)+2\operatorname{tr}(A\#B),$$
and the right side polarises to $\Psi(A,B)=\langle\mathrm{Ric}A,\mathrm{Ric}B\rangle+6\langle\mathrm{Alt}A,\mathrm{Alt}B\rangle$. At $A=W_+$, $B=W_-$:

- $W_+W_-=0$, the spectral parts having orthogonal ranges, so $\Phi(W_+,W_-)=2\operatorname{tr}(W_+\#W_-)$, **exactly the quantity L7's chain arrives at**;
- $\mathrm{Ric}(W)=0$ with $W=W_+-W_-$ gives $\mathrm{Ric}(W_+)=\mathrm{Ric}(W_-)$, so the first term is $\lVert\mathrm{Ric}(W_-)\rVert^2$, a **square** rather than a cross term;
- $\mathrm{Alt}(W)=0$ gives $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$, so the second is $6\delta^2$.

$$2\operatorname{tr}(W_+\#W_-)=\lVert\mathrm{Ric}(W_-)\rVert^2+6\,\delta^2 .$$

**Verdict: L7's import is exact and its $6$ is L15's $6$.** The mechanism [conventions.md](../findings/conventions.md) records, "*a polarisation halves its cross term and $\operatorname{scal}=2\operatorname{tr}$ doubles it back*", is visible in the display: the $\tfrac12$ from polarising $R^2$ is cancelled by the $2$ in $\operatorname{scal}$, and the two RHS terms escape halving because $\mathrm{Ric}$ and $\mathrm{Alt}$ take the same value on $W_+$ and $W_-$. **Two hypotheses of the identity's *consumer* are live here and are stated at L7 (Ricci-flatness and first Bianchi, each used twice) while the identity itself needs neither.** [ungraded-slack.md](../findings/ungraded-slack.md):188 and :333 carry the same $6\delta^2$ and agree.

**One thing L7 uses that L15 does not state: the polarised form.** L15 displays a quadratic identity; L7 needs the bilinear one. Over $\mathbb R$ these determine each other ([L15.lean](../lean/HamiltonsCubic/Results/L15.lean)'s `polarisation_general` is exactly this), so the step is legitimate and costs one line, but **a consumer reading [results.md](../results.md):647 alone is given the quadratic form with no variable declared and would have to notice that $A\#B$, not $\tfrac12(A^\#+B^\#)$, is the polarisation of $R^\#$.**

### 5.2 Question 3, which obstruction the identity bears on, and where the second stands

The heading claims two obstructions. **The displayed identity bears on the first only.**

| obstruction | what it is | status |
| --- | --- | --- |
| **(1) Bianchi**, $\lvert W\rvert$ and $W_\pm$ leave $S^2_B$ | priced **exactly** by the identity: $+24\delta^2$ in Jäger's §3.2 master inequality | **established here** (§2, §3) |
| **(2) $X_{\mathrm{inv}}\succeq0$** | a coordinate mechanism, free on the diagonal locus by the entrywise triangle inequality | **established nowhere, and refuted off the diagonal locus** |

On (2) the record is consistent and negative. [problem.md](../findings/problem.md):194 says it "*is refuted off it*"; [ATTEMPTS.md](../ATTEMPTS.md):625 records a genuine $n=6$ critical point with $\min\operatorname{eig}\approx-2.4\times10^{-2}$ and adds the caveat that genericity of the failure "*is only moderately supported*"; [lean/INDEX.md](../lean/INDEX.md):190's [L154](../findings/bounds.md) row records as **owed** "*that $X_{\mathrm{inv}}$ *is* semidefinite at a critical point*".

What *is* proven is strictly weaker and is not the same statement:

- $\operatorname{tr}X_{\mathrm{inv}}\ge0$, the three spectral-diagonal blocks are separately PSD because $\#$ preserves the PSD cone ([L154](../findings/bounds.md), and [ATTEMPTS.md](../ATTEMPTS.md):625 "*Lemma 3.2.2 only needs $\operatorname{scal}(X)\ge0$, and that survives*");
- $\operatorname{tr}X_{\mathrm{inv}}=0\iff X_{\mathrm{inv}}=0$ ([L154](../findings/bounds.md)(i)), and $X_{\mathrm{inv}}=0$ exactly on the $\mathbb Z_2$-graded subalgebras ([L155](../findings/bounds.md)).

**A trace statement is not an operator statement**, the point [lean/INDEX.md](../lean/INDEX.md):179's L7 row makes with $\operatorname{diag}(2,0)$ against $\operatorname{diag}(0,1)$. So obstruction (2) is `HYPOTHESIS-DEBT`: **what would have to be shown is $X_{\mathrm{inv}}\succeq0$ at every critical point off the diagonal locus, and the record instead holds a counterexample to it.** The block is right to name it and right not to claim it.

### 5.3 What a consumer may cite

**Citable outright, from this round:**

1. For every symmetric $R$ on $\Lambda^2\mathbb R^n$ and every $n$: $\operatorname{scal}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2$, **under the four conventions of §0**, the half-trace $\Lambda^2$ pairing, $\operatorname{scal}=2\operatorname{tr}$, $\mathrm{Alt}$ the orthogonal projection with its $\tfrac13$, and $\mathrm{Ric}$ with $\mathrm{Ric}^*=2(\cdot\wedge\mathrm{id})$. **The quantifier and the conventions must travel with it.**
2. Its polarisation, and hence [L7](../findings/bounds.md)'s $2\operatorname{tr}(W_+\#W_-)=\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2$ at a Ricci-flat Weyl $W$.
3. $\mathrm{Alt}(\lvert W\rvert)=2\mathrm{Alt}(W_-)$ and the resulting $+24\delta^2$, at a Weyl $W$.
4. $\delta^2(\mathcal S^4(\alpha))=\tfrac19$ at every $n\ge4$, with $\mathrm{Alt}(W_-)=\tfrac1{3\sqrt6}\star$; $\theta\operatorname{scal}(\lvert W\rvert)=4$ and $\lVert\mathrm{Ric}(\lvert W\rvert)\rVert^2-4\lVert W_-\rVert_F^2=\tfrac43$ there; hence the factor of three and the saturation.
5. $\delta^2=0$ at every $S^p\times S^q$, by the four-distinct-indices argument, which also covers every operator that is diagonal in some coordinate pair basis.

**Not citable:** "with one exception" ([results.md](../results.md):645), the clause "$W_\pm$ **do not** satisfy the first Bianchi identity" ([results.md](../results.md):645), and any form of "$X_{\mathrm{inv}}\succeq0$" off the diagonal locus.

## 6. Item 6, the named trap: each citable claim read alone, as a consumer would

This record's signature failure is a correction landing **beside** the statement it corrects. I read [results.md](../results.md):643–649 cold, as a consumer following the record's own pointer chain, and it is a live instance.

### D1, `BROKEN`. "$\lvert W\rvert$ and the spectral parts $W_\pm$ **do not** satisfy the first Bianchi identity"

**Located.** [results.md](../results.md):645, verbatim: "*with one exception: $\lvert W\rvert$ and the spectral parts $W_\pm$ do not satisfy the first Bianchi identity, and the identity his opening step rests on is Bianchi-dependent.*" [problem.md](../findings/problem.md):202 is word-for-word identical **except** that it reads "*need not satisfy*".

**Exhibited concretely.** At $S^2\times S^2$, $n=4$ (§3.4), $W_-=\operatorname{diag}(0,\tfrac13,\tfrac13,\tfrac13,\tfrac13,0)$ in the pair basis, $\mathrm{Alt}(W_-)=0$, so $W_-$ **does** satisfy the first Bianchi identity. The same holds at every $S^p\times S^q$ at every $n$, and at every operator that is coordinate-diagonal in some frame, which is the whole diagonal locus, the setting Jäger's proof lives in. And the block's own last sentence, four lines later in [problem.md](../findings/problem.md):204, asserts exactly this: "*Every sphere product, in any frame, has defect zero.*" **A universally quantified "do not" is refuted by the block's own closing sentence, and refuted on the very locus the surrounding paragraph is about.**

**The opposite, argued.** The most charitable reading is that "do not" is a shorthand for "are not required to, and in general fail to" (a generic rather than a universal) which is what the surrounding clause "*the identity his opening step rests on is Bianchi-dependent*" is getting at. That reading is tenable in [problem.md](../findings/problem.md), which writes "need not" and makes the generic explicit. **It is not tenable at [results.md](../results.md):645**, because that site strips the four riders that would let a reader recover the generic sense: with the sphere-product sentence deleted, "do not" has nothing to soften it. And the two files were the *same sentence* before the split, so the divergence is a live edit, not a stylistic choice. **The candidate survives all three steps.**

### D2, `BROKEN`. "Every step of that transfer survives … with one exception"

**Located.** [results.md](../results.md):645, in the same sentence as D1. **Exhibited concretely.** The record's own 2026-09-04 relabelling, at [results.md](../results.md):218 and [problem.md](../findings/problem.md):192–194, says: "*there are two obstructions, not one, and the second is not Bianchi*", the second being $X_{\mathrm{inv}}\succeq0$, refuted off the diagonal locus. **Neither correction appears within [results.md](../results.md):643–649.** The canonical form and the landscape line sit in the same file, 425 lines apart, and only the landscape line was repaired. A consumer citing the numbered result (which is what "*canonical statement*" means), inherits the count the record has already withdrawn.

**The opposite, argued.** One could read the two clauses as being about different things: :645's "one exception" is about *steps of the transfer to $\lvert W\rvert$*, while :218's "two obstructions" is about *inputs to Jäger's Lemma 3.3.4*. If those are different lists, both can stand. They are not: [problem.md](../findings/problem.md):194 quotes the primary text as saying "*Lemma 3.2.2's proof has exactly two inputs, eq. (1.6) and '$X(W)\ge0$ is obvious by the definitions of $W_+$ and $W_-$'*", Lemma 3.2.2 **is** the opening step :645 is describing, and its second input is a step of the transfer that does *not* survive. **The candidate survives all three steps.**

### D3, `BROKEN`. The canonical display is a truncation: $\mathrm{Alt}$ undefined, $R$ unquantified

**Located.** [results.md](../results.md):647 ends `+6\|\mathrm{Alt}(R)\|^2,$$`, with a **comma**, the punctuation of a sentence continuing into [problem.md](../findings/problem.md):204's "*$\mathrm{Alt}$ being the projection onto $\Lambda^4$, with the constant exactly $6$ in every dimension and no cross-term*", which [results.md](../results.md) does not carry. The very next line is `**Proof:**`.

**Exhibited concretely.** $\mathrm{Alt}$ appears nowhere else in [results.md](../results.md), and it is not in [conventions.md](../findings/conventions.md)'s symbol table (it is in that file's "Structure constants" bullet, one section down). Under the commoner literature convention in which the Bianchi map is the **unnormalised** $b(R)_{ijkl}=R_{ijkl}+R_{iklj}+R_{iljk}=3\,\mathrm{Alt}(R)$, the displayed constant is wrong by a factor of $9$: the true constant is then $\tfrac23$. **A consumer who reads "$\mathrm{Alt}$" as the Bianchi map (the reading the symbol invites, and the one every classical text uses), gets a false identity from the canonical form.** Separately, $R$ is bound by nothing at that site; the correct hypothesis, *$R$ symmetric on $\Lambda^2\mathbb R^n$*, appears only at [ATTEMPTS.md](../ATTEMPTS.md):622.

**The opposite, argued.** [results.md](../results.md) is an index that "*carries the statement and points here*" ([problem.md](../findings/problem.md):200), so perhaps a display without its definitions is by design and the pointer discharges it. That defence fails on its own terms: the file carries the *display*, which is the one thing a reader will copy, and withholds the sentence that makes it well posed, while carrying the surrounding narrative paragraph in full. **Nothing was saved by the truncation; a clause was lost.** And the pointer, D4, does not land. **The candidate survives all three steps.**

### D4, `BROKEN`. "**Proof:** [problem.md](../findings/problem.md)"

**Located.** [results.md](../results.md):649. **Exhibited concretely.** [problem.md](../findings/problem.md):190–204 contains no derivation of the identity. What it contains is a pointer of its own, at :198: "*The identity is confirmed: verified three ways, by depolarising L131 and at the anchors $R=\mathrm{Id}$ and $R\in\Lambda^4$*", a route named, in a correction banner, with no step displayed. The actual argument is [Lemma L131](../findings/isotropy-cap.md):414 (three lines, itself resting on [L79](../findings/isotropy-cap.md)) plus a one-line contraction that is displayed only in [REVIEW_r470.md](../reviews/REVIEW_r470.md). **So the record's chain is `results.md → problem.md → (a banner) → isotropy-cap.md`, and a consumer following the labelled `Proof:` link lands one file short.**

**The opposite, argued.** [problem.md](../findings/problem.md):198 does name L131 by link, so the chain is followable in two hops rather than one, and the mathematics is entirely present on the record. **That is why this is a citation defect and not a hypothesis debt**: I record it as `BROKEN` for the pointer, not for the result. But it is not cosmetic, the L15 block's own move-note claims [results.md](../results.md) "*now carries the statement and points here*" **for the argument**, and the argument is not here.

### D5, `CONFIRMED, minor`. The dependency direction is stated backwards in two places

**Located.** [results.md](../results.md):218, "*The identity below is confirmed and is [Lemma L131](../findings/isotropy-cap.md) polarised*"; [lean/INDEX.md](../lean/INDEX.md):183 repeats it. **Exhibited.** L15's display is a quadratic form; L131's is linear in $R$ and operator-valued. Polarisation maps quadratic to bilinear, so "L15 = L131 polarised" reverses the arrow. [isotropy-cap.md](../findings/isotropy-cap.md):414 ("*this is L15 polarised*") and [problem.md](../findings/problem.md):198 ("*by depolarising L131*") both have it right. **The opposite, argued.** The two are equivalent (§4.1), so no consequence is affected and either sentence identifies the right pair of blocks. **Recorded, not weighted.**

### D6, `CONFIRMED, in the stated reason only`. The "no cross-term" argument needs $O(n)$ and says $SO$-blind Schur

**Located.** [ATTEMPTS.md](../ATTEMPTS.md):622, "*as Schur forces, since $\Lambda^4$ occurs once in $S^2(\Lambda^2)$ and not at all in the Bianchi subspace*". **Exhibited concretely at $n=4$.** $\Lambda^4\mathbb R^4$ and $\mathbb R\cdot I$ are both one-dimensional and isomorphic as $SO(4)$-representations, [L79](../findings/isotropy-cap.md)'s own block says so and says $SO(4)$-Schur "*licenses mixing*". Under $SO(4)$-Schur alone a cross-term $\propto\operatorname{tr}(R)\langle R,\star\rangle$ is admissible, and the quoted reason does not exclude it. **The opposite, argued, and it wins for the result.** $\#$ is $O(n)$-equivariant ([Böhm–Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md)), the candidate term is odd under orientation reversal, so it vanishes; and §3.5(f) confirms the absence of a cross-term at Fox's $\lvert W\rvert$, the only named object where both terms are live. **So the conclusion stands and only the reason is short a word.**

### D7, `WITHDRAWN`. "in any frame"

Under the record's own $W_-=\tfrac12(\lvert W\rvert-W)$, a spectral object, $\delta^2$ is an $O(n)$-invariant of $W$ and "in any frame" is vacuous. It is not *wrong*, and there is a reading under which it is substantive, Jäger's entrywise $\lvert W\rvert$, which is frame-dependent and which the same paragraph names. **Fails the "exhibit the failure" step: I can produce no object at which the clause is false. Withdrawn, with the ambiguity noted at C6.**

### D8, `WITHDRAWN`. "the constant exactly $6$ in every dimension" below $n=4$

At $n\le3$, $\Lambda^4=0$ and the constant multiplies zero. **Fails the "exhibit" step**: the statement is true, merely empty there. Withdrawn.

## 7. What would break it, and what I did to look for it

**The object that would falsify the identity** is a single symmetric $R$ on some $\Lambda^2\mathbb R^n$ with $\operatorname{scal}(R^2+R^\#)\ne\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2$ in the §0 conventions. Since both sides are $O(n)$-invariant quadratic forms on $S^2(\Lambda^2)$, such an $R$ exists **iff** the two forms differ on one of the four isotypic summands or in a cross-pairing between two of them. So the search space is finite and I enumerated it by hand rather than sampling it:

| where a falsifier could live | what I did | outcome |
| --- | --- | --- |
| $\mathbb R\cdot I$ | $R=I$ at every $n$, §3.1 | both sides $n(n-1)^2$ |
| $S^2_0$ | $R=h\wedge\mathrm{id}$ for traceless $h$, §3.3 | both sides $\tfrac{n-2}2\lVert R\rVert^2$-consistent |
| $\mathcal W_n$ | $\operatorname{tr}(W^\#)=-\lVert W\rVert^2$, §3.3, and directly at Fox's $W$, §3.5(a) | $0=0$ |
| $\Lambda^4$ | $R=t\star$ at $n=4$, §3.2, and $c_4=2$ at every $n$ by Schur plus the $n=4$ bracket, §3.2 | both sides $36t^2$ |
| a cross-pairing $\mathbb RI\times\Lambda^4$ (the only one $SO(4)$-Schur licenses) | parity under an orientation-reversing element of $O(4)$, §2.3; and Fox's $\lvert W\rvert$, where $\mathrm{Ric}$ and $\mathrm{Alt}$ are simultaneously non-zero, §3.5(f) | both sides $\tfrac{16}3$ |
| a dimension edge | $n=2,3,4$ worked separately, §2.4 | no failure, and the two $n=4$ eigenvalue collisions do not bite |

**No falsifier exists, and the enumeration is exhaustive** because it is a decomposition of the representation rather than a sample of it. The one input I could not close by an independent hand computation at general $n$ was going to be $\#I|_{\Lambda^4}=2$, which [L79](../findings/isotropy-cap.md) asserts through Casimir values it does not display; §3.2 closes it instead with Schur on $\Lambda^4$ plus the $n=4$ bracket, and the padding argument that the $\mathfrak{so}(4)$-block of $\star_4\#I_n$ is the $n=4$ one.

**The object that would falsify C4 and C5** is a determination of Jäger's Lemma 3.2.2 differing from [ATTEMPTS.md](../ATTEMPTS.md):622's transcription. I looked for it in [references/jaeger-2016-diagonal-case/notes.md](../references/jaeger-2016-diagonal-case/notes.md), which carries Theorem A, the vertex-matrix setup, the §3.5 quartics and a §3.2–3.6 summary, and **not** Lemma 3.2.2 or equation (1.6). So C4 and C5 rest on an unread source for the *shape* of the inequality; every number inside them is exact and is derived here (§3.5).

**The object that would falsify obstruction (2)** would be a proof that $X_{\mathrm{inv}}\succeq0$ at every critical point. The record holds the opposite, an $n=6$ critical point with $\min\operatorname{eig}\approx-2.4\times10^{-2}$ ([ATTEMPTS.md](../ATTEMPTS.md):625), so the debt is not that a proof is missing but that the statement is false as an unrestricted claim. No search was needed.

## 8. Verdict

### `PROVEN, hypotheses corrected`

**The identity, with its constant $6$, holds at every $n$ for every symmetric $R$ on $\Lambda^2\mathbb R^n$**, in the conventions of §0. The hypotheses that must be added to the record's two carrying sites are:

1. **$R$ symmetric on $\Lambda^2\mathbb R^n$**, stated at neither [problem.md](../findings/problem.md):203 nor [results.md](../results.md):647, the identity needs no Weyl condition, no Bianchi identity, no Ricci-flatness, no criticality, no unit norm and no dimension bound.
2. **$\operatorname{scal}=2\operatorname{tr}$ and the half-trace $\Lambda^2$ pairing.** Under $\operatorname{scal}=\operatorname{tr}$ both RHS constants halve; under plain Frobenius on $\Lambda^2$ the $6$ becomes $4$. Neither site names either.
3. **$\mathrm{Alt}$ the orthogonal projection, carrying its $\tfrac13$.** Named at [problem.md](../findings/problem.md):204; **absent from [results.md](../results.md):647**, where reading $\mathrm{Alt}$ as the unnormalised Bianchi map turns the constant into $\tfrac23$.

**Two clauses are `BROKEN` and both sit on the canonical form**, where the 2026-09-04 correction did not reach: "$W_\pm$ **do not** satisfy the first Bianchi identity" (D1, refuted at every sphere product by the block's own closing sentence) and "with one exception" (D2, the count the record withdrew). The `Proof:` pointer at [results.md](../results.md):649 lands on a file with no argument (D4).

**One item is `HYPOTHESIS-DEBT`**: the heading's second obstruction, $X_{\mathrm{inv}}\succeq0$. What would have to be shown is $X_{\mathrm{inv}}\succeq0$ at every critical point off the diagonal locus; the record holds a counterexample, and only $\operatorname{tr}X_{\mathrm{inv}}\ge0$ with its equality locus is proven. **The displayed identity bears on the first obstruction and on it alone**, which the block says correctly.

**The identity is not machine-checked**; [L15.lean](../lean/HamiltonsCubic/Results/L15.lean) proves polarisation over $\mathbb Q$ and $1\ne2$, and [lean/INDEX.md](../lean/INDEX.md):183 records the identity as owed. §4.4 states what a row that carried it would have to claim.

**Nothing in this report supplies a step the record lacks.** The derivation of §2 is the record's own route ([problem.md](../findings/problem.md):198's "depolarising L131"), rebuilt to check it; §3.2's $c_4=2$ replaces an assertion by a check of the same claim, not by a new one.
