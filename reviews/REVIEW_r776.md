# Gate 2, reviewer r776, L181, Ricci and Bianchi as the two halves of one matrix

**The brief was cold: I worked from [BRIEF-g2-l181.md](BRIEF-g2-l181.md) alone and did not open [findings/](../findings/). No numerical work was done, every value in this report is exact and was derived by hand in closed form; no machine screen was run at all, so nothing below rests on one.** Log: [agent_logs/g2-l181-r776.log](../agent_logs/g2-l181-r776.log). No reference folder was fetched, so there is nothing uncommitted on that account.

## Claim table

| # | Claim | Verdict |
| --- | --- | --- |
| main | Simultaneously block-diagonal $W\in\mathcal W_n$ is $0$ | **SOUND**, the proof is correct as written and complete |
| 2 | $MM^{\mathsf T}=I_r$; $M$ real; $r\le m$ | **SOUND**, orthonormality of rows is exactly this, $M$ is real, and $r\le m$ is derived rather than assumed |
| 3 | Ricci half: $\omega_i\omega_i^{\mathsf T}=\bigoplus_j M_{ij}^2\mathrm{Id}_{P_j}$ | **SOUND, NO FACTOR**, cross terms vanish because $E_jE_k=0$ for $j\ne k$; a sign convention differs from Given A and is immaterial |
| 4 | Bianchi half: $\omega_i\wedge\omega_i=2\sum_{j<k}M_{ij}M_{ik}\varepsilon_j\wedge\varepsilon_k$, the $\varepsilon_j\wedge\varepsilon_k$ independent | **SOUND**, they are distinct members of the standard basis of $\Lambda^4$, for every $m$, with no interaction with $P_0$ |
| 5 | $M^{\mathsf T}\Lambda M=0$ and $MM^{\mathsf T}=I_r$ give $\Lambda=0$, $M$ non-square | **SOUND, AND IT AVOIDS THE TRAP**, the step uses $MM^{\mathsf T}=I_r$ and never $M^{\mathsf T}M=I_m$, which is false whenever $r<m$; all three products conform |
| 6 | Block-diagonality under a repeated eigenvalue | **WELL POSED**, the hypothesis is $\mathop{\mathrm{im}}W\subseteq\mathop{\mathrm{span}}(\varepsilon_j)$, which no choice of eigenbasis can affect |
| 7 | $P_0\ne0$, odd $n$ | **HARMLESS**, the $P_0$ block of the Ricci equation is $0=0$ and is never used |
| 8 | The kernel | **NO STEP ASSUMES $\ker W=0$**, dropping the zero eigenvalues is legitimate under both givens, and the hypothesis constrains nothing in the kernel |
| 9a | Non-vacuity: $W_{\mathbb{CP}^2}$, "self-dual eigenforms $\tfrac1{\sqrt2}(\varepsilon_1\pm\varepsilon_2)$" | **MIS-STATED**, $\tfrac1{\sqrt2}(\varepsilon_1-\varepsilon_2)$ is anti-self-dual and lies in $\ker W_{\mathbb{CP}^2}$, so it is an eigenform but not a self-dual one |
| 9b | Non-vacuity: "not block-diagonal in that splitting or any other" | **`HYPOTHESIS-DEBT`**, a quantification over all splittings with no argument on file |
| 9c | Non-vacuity: coordinate-diagonal $W$ escapes | **UNDER-SPECIFIED**, the reason given is about all the $e_{ab}$, whereas the hypothesis is only about those with nonzero eigenvalue |
| 10 | Scope: every $n$, every rank, every number of blocks | **ENTAILED** |
| 11 | Boundaries $m=1$, $r=1$, $r=m$, $n=4$, odd $n$, $n<12$ | **ALL CLEAN**, $m=1$ is carried by the Ricci half alone, which is what makes $\Lambda^4=0$ at $n<4$ harmless |
|, | Do the conjecture's constants appear? | **NO**, $n\ge12$, $\sqrt{3/2}$, $\theta_0(12)$ and $6+2\sqrt7$ appear nowhere in the proof, correctly |

**One-line action.** The theorem and its proof stand exactly as written and need no repair; the two non-vacuity checks in the closing block do, strike "self-dual" from the $\mathbb{CP}^2$ sentence, and either argue "or any other splitting" or mark it as debt, because as written the block asserts something over all splittings for which it offers nothing.

## 0. Conventions, fixed once

These are the brief's own; I add nothing beyond making two identifications explicit, both of which the brief's normalisations force.

- Fix an orthonormal frame adapted to the splitting: $f_{2j-1},f_{2j}$ span $P_j$ for $j=1,\dots,m$, and the remaining $f_a$ span $P_0$. Then $\varepsilon_j=f_{2j-1}\wedge f_{2j}$, up to the sign fixed by the chosen orientation of $P_j$.
- A $2$-form $\omega=\sum_{a<b}\omega_{ab}f_a\wedge f_b$ is read as the skew matrix with entries $\omega_{ab}$ extended antisymmetrically. Under this reading $\varepsilon_j$ is the matrix $E_j$ with $(E_j)_{2j-1,2j}=1$, $(E_j)_{2j,2j-1}=-1$ and every other entry $0$. Since $\mathop{\mathrm{tr}}(E_j^2)=-2$, the brief's $\lVert\omega\rVert^2=-\tfrac12\mathop{\mathrm{tr}}(\omega^2)$ gives $\lVert\varepsilon_j\rVert=1$, agreeing with $\{f_a\wedge f_b\}_{a<b}$ being orthonormal. **The unit area form is the $\pm1$ matrix, with no $\tfrac1{\sqrt2}$.**
- $\omega\otimes\omega$ is $\eta\mapsto\langle\omega,\eta\rangle\omega$; for orthonormal $\omega_i$ the spectral form $W=\sum_i\lambda_i\,\omega_i\otimes\omega_i$ satisfies $W\omega_i=\lambda_i\omega_i$.
- $V:=\mathop{\mathrm{span}}(\varepsilon_1,\dots,\varepsilon_m)\subseteq\Lambda^2\mathbb R^n$, of dimension $m$.
- $\Lambda=\mathop{\mathrm{diag}}(\lambda_1,\dots,\lambda_r)$, all $\lambda_i\ne0$; $M\in\mathbb R^{r\times m}$; $S:=M^{\mathsf T}\Lambda M\in\mathbb R^{m\times m}$, symmetric.

## Hypothesis inventory

### Used and stated

| Hypothesis | Where it does work |
| --- | --- |
| $W$ self-adjoint on $\Lambda^2$ (the Riemann pair symmetry) | The real spectral theorem, hence the orthonormal eigenbasis and the existence of $M$ at all |
| Total trace-freeness, as Given A | The $m$ diagonal equations $S_{jj}=0$ |
| First Bianchi, as Given B | The $\binom m2$ off-diagonal equations $S_{jk}=0$, $j<k$ |
| The $P_j$ are **planes** ($\dim 2$) | $\varepsilon_j$ exists as a unit area form at all, and $-E_j^2=\mathrm{Id}_{P_j}$ is a rank-two identity |
| The $P_j$ are **mutually orthogonal** | Three separate jobs: $\varepsilon_j$ orthonormal (so $MM^{\mathsf T}=I_r$); $E_jE_k=0$ (no cross terms in the Ricci half); disjoint index quadruples (independence of $\varepsilon_j\wedge\varepsilon_k$) |
| $\varepsilon_j$ of unit norm | The factor in front of $\mathrm{Id}_{P_j}$ is exactly $M_{ij}^2$ |
| Block-diagonality of the nonzero eigenforms | Defines $M$; nothing else in the proof |
| $\lambda_i\ne0$ for the $r$ listed terms | Only in the last line, to turn $\Lambda=0$ into $r=0$ |
| $0\in\mathcal W_n$ | Makes the conclusion land inside the space; used silently and correctly |

### Stated and unused

- **$P_0$ itself.** The splitting is allowed to leave a remainder, and the proof never touches it. Its only trace is a block of zeros on both sides of Given A.
- **The conjecture's numerology.** $n\ge12$, the threshold $\sqrt{3/2}=1.224745$, $\theta_0(12)=1.236033$ and the crossover $6+2\sqrt7$ appear nowhere in the argument. The brief asked me to say if one did; **none does**, and this is right, L181 is dimension-free algebra.
- **The Riemann skew-symmetries beyond what self-adjointness and the two givens carry.** The proof reaches $\mathcal W_n$ only through Given A, Given B, and self-adjointness.

### Used and unstated

1. **The adapted frame** of §0. "As a skew matrix $\varepsilon_j$ is supported on $P_j$" and "the $\varepsilon_j\wedge\varepsilon_k$ are linearly independent" are both frame statements; they need $f_{2j-1},f_{2j}$ spanning $P_j$, which mutual orthogonality supplies. One sentence repairs the presentation. **Presentational.**
2. **The matrix normalisation** of §0, that the unit $\varepsilon_j$ is the $\pm1$ matrix. Without it the $\mathrm{Id}_{P_j}$ in the Ricci half carries a factor. It is forced by the brief's two norm conventions, which agree, so the proof is right; it is nonetheless an unstated step. **Presentational.**
3. **A sign.** Given A is stated as $\sum_i\lambda_i\omega_i^2=0$; the proof computes with $\omega_i\omega_i^{\mathsf T}=-\omega_i^2$. The two differ by an overall $-1$, which is immaterial to a vanishing statement, exactly as the brief says of Given B's projection constant. **Presentational.**
4. **Uniqueness of the coefficients $M_{ij}$**, which needs $\varepsilon_1,\dots,\varepsilon_m$ linearly independent. They are, being orthonormal, so $M$ is well defined. **Presentational.**

Nothing in this list changes a single equation. I record them because the brief asks for used-and-unstated, not because any of them is a defect.

## 1. The hypotheses, item by item

Covered by the inventory above. The one point worth pulling out: **the hypothesis of the statement is used exactly once**, to write $\omega_i\in V$. Everything after that is linear algebra on $M$ and $\Lambda$ plus the two givens. That is a strength (the theorem is not sensitive to how the block-diagonality arises) and it is also why the proof transfers verbatim to any $n$, $r$ and $m$ (item 10).

## 2. $MM^{\mathsf T}=I_r$, realness, and $r\le m$

**Orthonormality is exactly $MM^{\mathsf T}=I_r$.** With $\omega_i=\sum_jM_{ij}\varepsilon_j$ and $\langle\varepsilon_j,\varepsilon_k\rangle=\delta_{jk}$,

$$\langle\omega_i,\omega_{i'}\rangle=\sum_{j,k}M_{ij}M_{i'k}\langle\varepsilon_j,\varepsilon_k\rangle=\sum_jM_{ij}M_{i'j}=(MM^{\mathsf T})_{ii'},$$

so $\langle\omega_i,\omega_{i'}\rangle=\delta_{ii'}$ is $MM^{\mathsf T}=I_r$. **It does need the $\varepsilon_j$ orthonormal, and they are**: in the adapted frame $\varepsilon_j=f_{2j-1}\wedge f_{2j}$, and distinct $j$ give distinct members of the orthonormal basis $\{f_a\wedge f_b\}_{a<b}$, because mutual orthogonality of the planes makes the index pairs disjoint. Each has unit norm by §0. Orthogonality of the planes is doing real work here: for planes merely in general position the $\varepsilon_j$ would be independent but not orthonormal, and $MM^{\mathsf T}=I_r$ would become $MGM^{\mathsf T}=I_r$ for the Gram matrix $G$.

**$M$ is real.** $W$ is a self-adjoint operator on the real inner product space $\Lambda^2\mathbb R^n$, so it has a real orthonormal eigenbasis, and the hypothesis says "real combination" in any case. Since the $\varepsilon_j$ are a basis of $V$, the coefficients are unique, and they are real.

**$r\le m$ is derived, not assumed.** $MM^{\mathsf T}=I_r$ forces $\mathop{\mathrm{rank}}M=r$, and $\mathop{\mathrm{rank}}M\le\min(r,m)$, so $r\le m$. Equivalently: $r$ orthonormal vectors sit in the $m$-dimensional $V$. Note the proof never needs to invoke this (it is a consequence that becomes useful in §9) so there is no risk of it being smuggled in as a hypothesis.

## 3. The Ricci half

Write $\omega_i=\sum_jM_{ij}E_j$ as matrices. Since $P_j\perp P_k$ for $j\ne k$, the supports are disjoint index blocks and $E_jE_k=0$ for $j\ne k$. Hence

$$\omega_i\omega_i^{\mathsf T}=-\omega_i^2=-\sum_{j,k}M_{ij}M_{ik}E_jE_k=-\sum_jM_{ij}^2E_j^2=\sum_jM_{ij}^2\,\mathrm{Id}_{P_j},$$

using $E_j^2=-\mathrm{Id}_{P_j}$, which is immediate from the $2\times2$ block $\begin{pmatrix}0&1\\-1&0\end{pmatrix}^2=-I_2$. **So yes: block-diagonal, exactly $M_{ij}^2\mathrm{Id}_{P_j}$ on $P_j$, zero on $P_0$, no cross terms and no factor.** The disappearance of the cross terms is not a symmetry accident, it is $E_jE_k=0$, which is orthogonality of the planes again.

Given A then reads $\sum_j\big(\sum_i\lambda_iM_{ij}^2\big)\mathrm{Id}_{P_j}=0$ in $S^2(\mathbb R^n)$. The $\mathrm{Id}_{P_j}$ have disjoint supports, hence are linearly independent, so each coefficient vanishes:

$$\sum_i\lambda_iM_{ij}^2=0\qquad(j=1,\dots,m),$$

which is $S_{jj}=(M^{\mathsf T}\Lambda M)_{jj}=0$, since $(M^{\mathsf T}\Lambda M)_{jk}=\sum_iM_{ij}\lambda_iM_{ik}$. Correct.

The only blemish is the sign already recorded: Given A is $\sum_i\lambda_i\omega_i^2=0$, the proof uses $\omega_i\omega_i^{\mathsf T}$, and these differ by an overall $-1$. For a vanishing statement that is nothing.

## 4. The Bianchi half

$\varepsilon_j$ is decomposable, so $\varepsilon_j\wedge\varepsilon_j=0$. Two-forms commute under $\wedge$, so $\varepsilon_j\wedge\varepsilon_k=\varepsilon_k\wedge\varepsilon_j$ and

$$\omega_i\wedge\omega_i=\sum_{j,k}M_{ij}M_{ik}\,\varepsilon_j\wedge\varepsilon_k=2\sum_{j<k}M_{ij}M_{ik}\,\varepsilon_j\wedge\varepsilon_k.$$

**The factor $2$ is right.** And **the $\varepsilon_j\wedge\varepsilon_k$ for $j<k$ are linearly independent**: in the adapted frame

$$\varepsilon_j\wedge\varepsilon_k=f_{2j-1}\wedge f_{2j}\wedge f_{2k-1}\wedge f_{2k},$$

and distinct pairs $j<k$ give distinct four-element index sets, so these are $\binom m2$ distinct members of the standard basis $\{f_a\wedge f_b\wedge f_c\wedge f_d\}_{a<b<c<d}$ of $\Lambda^4\mathbb R^n$. Independence therefore holds for **every** $m$, nothing degrades as $m$ grows, because the map $\{j<k\}\mapsto\{2j-1,2j,2k-1,2k\}$ is injective for all $m$ at once, not merely for small $m$. **There is no interaction with $P_0$**: no basis vector of $P_0$ occurs in any $\varepsilon_j\wedge\varepsilon_k$, so the $P_0$ directions contribute extra basis $4$-forms that simply do not appear in the equation.

Given B then gives $\sum_i\lambda_iM_{ij}M_{ik}=0$ for each $j<k$, i.e. $S_{jk}=0$ off the diagonal. Correct.

**The structural point, which I think is the lemma's real content.** $S=M^{\mathsf T}\Lambda M$ is the matrix of $W|_V$ in the basis $\varepsilon_1,\dots,\varepsilon_m$: from $W\varepsilon_k=\sum_i\lambda_i\langle\omega_i,\varepsilon_k\rangle\omega_i=\sum_i\lambda_iM_{ik}\sum_jM_{ij}\varepsilon_j=\sum_jS_{jk}\varepsilon_j$. Ricci supplies the $m$ diagonal entries, Bianchi the $\binom m2$ off-diagonal ones, and a symmetric matrix has exactly $\binom{m+1}2=m+\binom m2$ entries. **The two givens together are precisely a complete set of equations for $W|_V$, with nothing left over and nothing missing.** That is the honest reading of "Ricci and Bianchi as the two halves of one matrix", and it is correct.

## 5. The final step, with $M$ non-square

Sizes: $\Lambda$ is $r\times r$; $M$ is $r\times m$; $M^{\mathsf T}$ is $m\times r$. Then

- $M^{\mathsf T}\Lambda M$: $(m\times r)(r\times r)(r\times m)=m\times m$. Conformable.
- $M\,(M^{\mathsf T}\Lambda M)\,M^{\mathsf T}$: $(r\times m)(m\times m)(m\times r)=r\times r$. Conformable.

Matrix multiplication is associative for any conformable shapes, square or not, so

$$M(M^{\mathsf T}\Lambda M)M^{\mathsf T}=(MM^{\mathsf T})\,\Lambda\,(MM^{\mathsf T})=I_r\Lambda I_r=\Lambda.$$

With $M^{\mathsf T}\Lambda M=0$ this gives $\Lambda=0$, so every $\lambda_i=0$, contradicting $\lambda_i\ne0$ unless the list is empty; $r=0$ makes the spectral sum empty and $W=0$. **The step is legitimate.**

**And it is legitimate for the reason that matters.** The one thing that could have gone wrong with a non-square $M$ is using $M^{\mathsf T}M=I_m$, which is **false** whenever $r<m$: $M^{\mathsf T}M$ is then the orthogonal projection of $\mathbb R^m$ onto the row space of $M$, of rank $r<m$. The proof multiplies on the outside, so only $MM^{\mathsf T}=I_r$ is ever invoked, and that is the identity orthonormality of the *rows* actually gives. I checked the two orders against each other and the written one is the correct one. Had the sandwich been $M^{\mathsf T}(M\Lambda' M^{\mathsf T})M$ the argument would have collapsed for $r<m$.

Two remarks, neither a defect. First, $r=0$ has to be read as "the empty spectral sum", and the brief's convention $0\in\mathcal W_n$ makes that a legitimate element rather than a degenerate non-object. Second, the step is avoidable: $S=0$ is already the vanishing of the matrix of $W|_V$, and $W$ kills $V^\perp$ because every $\omega_i\in V$, so $S=0\iff W=0$ directly. The written route is correct; the direct route needs no matrix identity at all.

## 6. Degenerate eigenvalues, and whether the hypothesis is well posed

**It is well posed, and the proof does need it to be.** The reason is one line: the condition "is a real combination of the $\varepsilon_j$" is membership in the linear subspace $V$, and a subspace is closed under linear combination.

Precisely. Let $E_\lambda$ be an eigenspace with $\lambda\ne0$. If *some* orthonormal basis of $E_\lambda$ lies in $V$, then $E_\lambda=\mathop{\mathrm{span}}$ of that basis $\subseteq V$, so *every* eigenform in $E_\lambda$ lies in $V$. Conversely if every eigenform lies in $V$ then so does any chosen basis. The existential and universal readings therefore coincide, and the hypothesis is equivalent to the basis-free statement

$$\mathop{\mathrm{im}}W=\bigoplus_{\lambda\ne0}E_\lambda\subseteq V.$$

So the answer to the brief's question is: **no, the hypothesis does not depend on which basis of a degenerate eigenspace is chosen**, and it would have mattered if it did, because the proof fixes one particular orthonormal eigenbasis to build $M$ and would otherwise be proving something about that choice rather than about $W$. Nothing downstream depends on the choice either: a different basis of $E_\lambda$ replaces the corresponding rows of $M$ by $QM$-rows for an orthogonal $Q$ acting within the $\lambda$-block, which preserves $MM^{\mathsf T}=I_r$ and preserves $M^{\mathsf T}\Lambda M$ because $Q$ commutes with the scalar block $\lambda I$. The conclusion $\Lambda=0$ is invariant.

Two smaller degeneracy points, both clean. The multiplicity of $\lambda$ is counted in $r$, so $r=\mathop{\mathrm{rank}}W$ throughout. And the sign ambiguity in each $\varepsilon_j$ (the orientation of $P_j$ is not fixed by the hypothesis) flips a column of $M$: $M\mapsto MD$ for a diagonal sign matrix $D$, under which $MM^{\mathsf T}$ is unchanged and $M^{\mathsf T}\Lambda M\mapsto DM^{\mathsf T}\Lambda MD$, so both equations are unaffected.

## 7. $P_0$, and odd $n$

**Nothing breaks.** In the Ricci half, $\sum_i\lambda_i\omega_i\omega_i^{\mathsf T}$ is supported on $P_1\oplus\dots\oplus P_m$; its $P_0$ block is identically zero on the left of Given A, so that block of the equation reads $0=0$ and contributes no information and no obstruction. In the Bianchi half, no index from $P_0$ appears, as noted in §4. $P_0$ may have any dimension $\ge0$.

**Odd $n$ is the case $\dim P_0$ odd**, and in particular $\dim P_0\ge1$, so the splitting cannot exhaust $\mathbb R^n$. Since nothing in the argument uses exhaustion, odd $n$ is exactly as clean as even $n$. The bound $m\le\lfloor n/2\rfloor$ follows from orthogonality of the planes and is used nowhere except in the non-vacuity discussion.

## 8. The kernel

**No step assumes $\ker W=0$, and I looked at each.** The zero eigenvalues never enter: the spectral sum is over the nonzero ones by the brief's convention, the hypothesis constrains only eigenforms with $\lambda\ne0$, $M$ is built from those alone, and $r=\mathop{\mathrm{rank}}W$ is allowed to be anything from $0$ to $\dim\Lambda^2$.

**Dropping the zero eigenvalues is legitimate under both givens.** Under Given A, a term with $\lambda_i=0$ contributes $\lambda_i\omega_i^2=0$ to a sum in $S^2(\mathbb R^n)$; under Given B, $\lambda_i\omega_i\wedge\omega_i=0$ in $\Lambda^4$, and the brief states this explicitly for B. In both cases the omitted terms are the zero vector, not terms whose smallness is being argued. So the record's recurring obstruction does not bite here.

Indeed the lemma is unusually kernel-friendly: it permits $\ker W$ to be enormous and to contain $2$-forms entirely outside $V$, and still concludes $W=0$. The eigenforms in the kernel are simply never mentioned.

## 9. The two non-vacuity checks

This is where the block is weakest. The theorem is untouched by any of what follows (these are claims *about examples*, made to show the hypothesis is restrictive) but they are stated as facts in the record and two of the three do not hold up as written.

### 9a. $W_{\mathbb{CP}^2}$: the self-duality label is wrong

Take $n=4$ with the orientation $f_1\wedge f_2\wedge f_3\wedge f_4$ and $\varepsilon_1=e_{12}$, $\varepsilon_2=e_{34}$. The Hodge star acts on $\Lambda^2\mathbb R^4$ by $*e_{12}=e_{34}$, $*e_{13}=-e_{24}$, $*e_{14}=e_{23}$, so

$$\Lambda^+=\mathop{\mathrm{span}}\Big\{\tfrac1{\sqrt2}(e_{12}+e_{34}),\ \tfrac1{\sqrt2}(e_{13}-e_{24}),\ \tfrac1{\sqrt2}(e_{14}+e_{23})\Big\},\qquad \tfrac1{\sqrt2}(e_{12}-e_{34})\in\Lambda^-.$$

The block says "two of its self-dual eigenforms are $\tfrac1{\sqrt2}(\varepsilon_1\pm\varepsilon_2)$". **$\tfrac1{\sqrt2}(\varepsilon_1-\varepsilon_2)=\tfrac1{\sqrt2}(e_{12}-e_{34})$ is anti-self-dual.** For $\mathbb{CP}^2$ the Weyl tensor is self-dual, $W^-=0$, so the whole of $\Lambda^-$ is in the kernel; $\tfrac1{\sqrt2}(\varepsilon_1-\varepsilon_2)$ is an eigenform, but with eigenvalue $0$, and it is not a self-dual one. **The sentence should read that one of $\tfrac1{\sqrt2}(\varepsilon_1\pm\varepsilon_2)$ is the self-dual eigenform carrying the distinguished eigenvalue, the other being anti-self-dual and in the kernel.** As it stands the record contains a false statement about $\mathbb{CP}^2$'s self-dual forms. Verdict **MIS-STATED**; the escape conclusion itself is not damaged by it, since the two forms $\tfrac1{\sqrt2}(e_{13}-e_{24})$ and $\tfrac1{\sqrt2}(e_{14}+e_{23})$ named next really are self-dual, really are eigenforms with nonzero eigenvalue, and really are not in $\mathop{\mathrm{span}}(e_{12},e_{34})$.

### 9b. "in that splitting or any other": no argument on file

The block asserts that $W_{\mathbb{CP}^2}$ is block-diagonal for **no** splitting whatever. That is a quantification over every orthogonal decomposition of $\mathbb R^4$ into planes (a set with the dimension of a flag manifold) and **the block gives no argument for it at all**. Exhibiting that two particular forms fail to lie in $\mathop{\mathrm{span}}(e_{12},e_{34})$ settles one splitting and says nothing about the rest.

Following the brief's instruction, I do not supply the missing argument. **This claim has no argument on file: `HYPOTHESIS-DEBT`.** I will record only that the debt looks cheap rather than deep (the block's own §2 machinery bounds $r$ by $m$, and $m\le2$ at $n=4$) but cheapness is not discharge, and the sentence as written is an assertion, not a proof.

### 9c. The coordinate-diagonal check is under-specified

The block says: "A coordinate-diagonal $W$ escapes, its eigenforms being the $e_{ab}$, which no splitting into $\lfloor n/2\rfloor$ planes contains."

Two problems with the reason, in ascending order of seriousness.

- **"its eigenforms being the $e_{ab}$" is not exact under degeneracy.** If two coordinate eigenvalues coincide, the eigenspace is larger than the span of one $e_{ab}$ and contains forms that are not coordinate $2$-forms. This is harmless to the conclusion, since one only needs some eigenform outside $V$, but it is loose.
- **The hypothesis is about eigenforms with nonzero eigenvalue, and the reason given is about all $\binom n2$ of the $e_{ab}$.** These are different statements. "No splitting into $\lfloor n/2\rfloor$ planes contains all the $e_{ab}$" is true and easy, $\mathop{\mathrm{span}}(\varepsilon_1,\dots,\varepsilon_m)$ contains at most $m\le\lfloor n/2\rfloor$ of the $e_{ab}$ up to sign, because a rank-two form in that span must be a multiple of a single $\varepsilon_j$, while $\binom n2>\lfloor n/2\rfloor$ for $n\ge3$. But that is not what has to be ruled out. What has to be ruled out is that the $e_{ab}$ **with $\lambda_{ab}\ne0$** all lie in the span, and the block never restricts to those. The gap is real, not pedantic: the set of $e_{ab}$ with nonzero eigenvalue can be small, Given A forces $\sum_{b\ne a}\lambda_{ab}=0$ for each $a$, and a four-cycle of alternating signs, $\lambda_{12}=\lambda_{34}=t$ and $\lambda_{23}=\lambda_{14}=-t$, satisfies it with only four nonzero entries, which is fewer than $m=6$ at $n=12$. So the counting the block offers does not reach the case it needs.

Verdict **UNDER-SPECIFIED**. The conclusion may well survive (I am not asserting a counterexample and I did not hunt for one) but the reason printed in the record does not establish it, and the record should not read as though it did.

## 10. Scope

**Entailed.** Reading §§2–5 back: no step uses the value of $n$, no step uses the value of $r$ beyond $\lambda_i\ne0$, and no step uses the value of $m$ beyond the existence of the orthonormal $\varepsilon_j$. Every equation is an identity in the entries of $M$ and $\Lambda$. So "at every $n$, every rank and every number of blocks" is exactly what has been proved, with the trivial reading at $m=0$ ($V=0$ forces $r=0$).

The scope claim is in fact *stronger* than the record needs and worth saying so: the argument never uses that $W$ satisfies the Riemann skew-symmetries beyond self-adjointness, so it applies to any self-adjoint operator on $\Lambda^2\mathbb R^n$ satisfying Givens A and B.

## 11. The boundary

| Case | Behaviour |
| --- | --- |
| $m=1$ | $MM^{\mathsf T}=I_r$ in $\mathbb R^{r\times1}$ forces $r\le1$. For $r=1$, $M=(\pm1)$ and the single Ricci equation is $\lambda_1=0$. **The Bianchi half is empty here** (there is no pair $j<k$) so $m=1$ is carried by Ricci alone |
| $r=1$ | Ricci gives $\lambda_1M_{1j}^2=0$ for every $j$, so every $M_{1j}=0$, contradicting $\sum_jM_{1j}^2=1$. Clean, and independent of $m$ |
| $r=m$ | $M$ is a genuine orthogonal matrix and $M^{\mathsf T}\Lambda M=0$ gives $\Lambda=0$ by conjugation. This is the only case where the sandwich is a similarity; §5 shows the general case does not need it to be |
| $n=4$ | $m\le2$. Both halves are live at $m=2$ ($\varepsilon_1\wedge\varepsilon_2$ spans $\Lambda^4\mathbb R^4$), and $r\le2$ |
| $n=2,3$ | $m\le1$ and $\Lambda^4\mathbb R^n=0$, so Given B is vacuous. **This is exactly the case the $m=1$ row covers**, and the proof survives because it needs Bianchi only for off-diagonal entries that do not exist. Had the argument been organised the other way round it would have failed here |
| odd $n$ | $\dim P_0\ge1$; see §7. No effect |
| $n<12$ | No step consults $n$, so the lemma holds below the conjecture's range as well as inside it. That is correct and should stay correct: nothing here may be cited as evidence that anything special happens at $n\ge12$ |

## What would break it, and what I did to look

**The falsifier is a nonzero $W\in\mathcal W_n$ with $\mathop{\mathrm{im}}W\subseteq V=\mathop{\mathrm{span}}(\varepsilon_1,\dots,\varepsilon_m)$** for some orthogonal family of planes, equivalently, by §4, a nonzero symmetric $m\times m$ matrix $S$ arising as the matrix of $W|_V$.

**What I did.** I did not search, sweep or run anything; the standing analysis-only rule forbids it, and here it is unnecessary, because the entry count in §4 closes the question in closed form. Ricci pins the $m$ diagonal entries of $S$, Bianchi the $\binom m2$ off-diagonal entries, and $m+\binom m2=\binom{m+1}2$ is the full dimension of the symmetric $m\times m$ matrices. There is no room left in which a falsifier could sit. **So there is nothing to look for, and that is a fact about the equations rather than the outcome of a hunt.**

**The near-miss, exhibited in closed form, to show which given is load-bearing.** Take $m=r=2$, $\Lambda=\mathop{\mathrm{diag}}(1,-1)$ and

$$M=\tfrac1{\sqrt2}\begin{pmatrix}1&1\\1&-1\end{pmatrix},\qquad\text{so}\qquad M^{\mathsf T}\Lambda M=\begin{pmatrix}0&1\\1&0\end{pmatrix}.$$

Its diagonal vanishes, so this configuration satisfies **Given A exactly**: $\omega_1=\tfrac1{\sqrt2}(\varepsilon_1+\varepsilon_2)$, $\omega_2=\tfrac1{\sqrt2}(\varepsilon_1-\varepsilon_2)$ and $W=\omega_1\otimes\omega_1-\omega_2\otimes\omega_2$ is a nonzero, simultaneously block-diagonal, self-adjoint, totally trace-free operator on $\Lambda^2$. It fails only Bianchi:

$$\omega_1\wedge\omega_1-\omega_2\wedge\omega_2=\tfrac12\big(2\,\varepsilon_1\wedge\varepsilon_2\big)-\tfrac12\big({-2}\,\varepsilon_1\wedge\varepsilon_2\big)=2\,\varepsilon_1\wedge\varepsilon_2\ne0.$$

Every number there is exact and was obtained by hand. It says something the block does not: **the Ricci half alone is far from sufficient** (it leaves the whole $\binom m2$-dimensional space of hollow symmetric $S$) so L181 genuinely consumes the first Bianchi identity and cannot be weakened to a trace-freeness argument.

## Overall verdict

**The main claim is SOUND and its proof is correct and complete as written.** I attacked the non-square matrix step, the degenerate-eigenvalue reading of the hypothesis, the kernel, $P_0$, odd $n$ and every boundary the brief names, and found no error in any of them; the step in §5 in particular avoids the one identity ($M^{\mathsf T}M=I_m$) that would have been false for $r<m$. The four used-and-unstated items in the inventory are presentational and change no equation. The result is genuinely dimension-free, and none of the conjecture's constants leaks into it.

**The closing non-vacuity block is a different matter and should not be folded at the same confidence as the theorem.** One sentence in it is false as written (**MIS-STATED**: $\tfrac1{\sqrt2}(\varepsilon_1-\varepsilon_2)$ is anti-self-dual and lies in the kernel of $W_{\mathbb{CP}^2}$, so it is not one of "two self-dual eigenforms"). One is an assertion over all splittings with nothing behind it (**`HYPOTHESIS-DEBT`**). One offers a reason that does not reach the statement it is meant to support (**UNDER-SPECIFIED**: the count is over all $e_{ab}$, the hypothesis is over those with nonzero eigenvalue, and the nonzero set can be smaller than $m$). My summary word for the item as a whole: **SOUND THEOREM, DEBT-BEARING EXAMPLES.**

## Housekeeping

No reference folder was fetched, so none is left uncommitted. I edited no file other than this report and my log, and I did not touch [INDEX.md](INDEX.md).

**The commit gate refused this report, so it is left uncommitted, as the brief directs.** The pre-commit structure gate at [structure_gate.py](../.claude/hooks/structure_gate.py) fails with `reviews_unindexed: [775, 776]`, my report is unindexed precisely because the brief forbids me to write my own row into [INDEX.md](INDEX.md) before both reports land. The other reviewer's report is in the same position. **The file is on disk at [REVIEW_r776.md](REVIEW_r776.md), unstaged; the fold should index it and commit.** Every other row of the structure check that the gate printed is clean or is marked reported-and-not-enforced, and none of them is mine.
