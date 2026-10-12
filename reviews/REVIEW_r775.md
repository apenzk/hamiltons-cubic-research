# Gate 2, reviewer r775, L181, Ricci and Bianchi as the two halves of one matrix

**The brief was cold: I worked from [BRIEF-g2-l181.md](BRIEF-g2-l181.md) alone and did not open [findings/](../findings/). No numerical work was done at all this round, not even a screen. Every value in this report is exact and derived by hand in closed form, and the one counterexample I exhibit is a change of orthonormal basis written out in full.** Log: [agent_logs/g2-l181-r775.log](../agent_logs/g2-l181-r775.log).

## Claim table

| # | Claim | Verdict |
| --- | --- | --- |
| 2 | $MM^{\mathsf T}=I_r$; the $\varepsilon_j$ are orthonormal; $M$ real; $r\le m$ | **SOUND**, orthonormality of the $\varepsilon_j$ is used and unstated, and it does hold |
| 3 | $\omega_i\omega_i^{\mathsf T}$ block-diagonal with exactly $M_{ij}^2\,\mathrm{Id}_{P_j}$ | **SOUND, NO FACTOR**, but Given A is about $\omega_i^2$, which is $-\omega_i\omega_i^{\mathsf T}$; the sign switch is unremarked and harmless |
| 4a | $\omega_i\wedge\omega_i=2\sum_{j<k}M_{ij}M_{ik}\,\varepsilon_j\wedge\varepsilon_k$ | **SOUND**, the factor $2$ is right |
| 4b | The $\varepsilon_j\wedge\varepsilon_k$ are linearly independent in $\Lambda^4$ | **SOUND**, they are in fact orthonormal; $m$ large and $P_0$ are both inert |
| 5 | $M^{\mathsf T}\Lambda M=0$ with $MM^{\mathsf T}=I_r$ gives $\Lambda=0$, $M$ non-square | **SOUND**, every size composes, $m\times m$ in and $r\times r$ out; the step is one associativity move and nothing is inverted |
| 6 | The block-diagonality hypothesis under a repeated eigenvalue | **WELL POSED, AND BASIS-FREE**, the two readings coincide, but the proof does not say why and owes one sentence |
| 7 | $P_0\ne0$, odd $n$ | **NOTHING BREAKS** |
| 8 | The kernel; dropping the zero eigenvalues at the outset | **LEGITIMATE UNDER BOTH GIVENS**, no step assumes $\ker W=0$ |
| 9a | Non-vacuity check 1, coordinate-diagonal $W$ | **NON-SEQUITUR AS ARGUED, plus `HYPOTHESIS-DEBT`**, it argues from the eigenforms of eigenvalue $0$, which the hypothesis does not constrain, and the existence of a nonzero coordinate-diagonal Weyl tensor has no argument on file |
| 9b | Non-vacuity check 2, $W_{\mathbb{CP}^2}$ block-diagonal for no splitting | **CONCLUSION TRUE, STATED REASON REFUTED IN CLOSED FORM**, $\tfrac1{\sqrt2}(e_{13}-e_{24})$ *is* block-diagonal, for the splitting $\langle f_1,f_3\rangle\oplus\langle f_2,f_4\rangle$; and "two of its self-dual eigenforms are $\tfrac1{\sqrt2}(\varepsilon_1\pm\varepsilon_2)$" is false, exactly one of them is |
| 10 | Scope: every $n$, every rank, every number of blocks | **ENTAILED**, the argument is uniform in $n,r,m$ and no constant of the conjecture appears anywhere in it |
| 11 | Boundaries $m=1$, $r=1$, $r=m$, $n=4$, odd $n$, $n<12$ | **ALL CLEAR**, $m=1$ is the only one where a half of the argument goes empty, and Ricci alone closes it |
|, | **The theorem and its proof** | **SOUND** |

**One-line action.** The theorem stands exactly as written and needs only three clarifying sentences (orthonormality of the $\varepsilon_j$, the $\omega_i^2$ versus $\omega_i\omega_i^{\mathsf T}$ sign, and why the hypothesis does not depend on the choice of eigenbasis); the two-sentence non-vacuity block must be rewritten, because check 2's stated reason is false and check 1's does not entail its conclusion, both conclusions survive, on the proof's own $r\le m$.

## 0. Conventions, fixed once

These are the brief's, restated so that nothing below is ambiguous. I add no convention of my own.

- $\{f_a\wedge f_b\}_{a<b}$ is orthonormal in $\Lambda^2\mathbb R^n$, and I write $e_{ab}:=f_a\wedge f_b$.
- A $2$-form read as a skew matrix: $e_{ab}\mapsto E_{ab}-E_{ba}$. This is the identification consistent with the brief's two normalisations at once: for $\omega=\sum_{a<b}\omega_{ab}e_{ab}$ one has $\operatorname{tr}(\omega^2)=-2\sum_{a<b}\omega_{ab}^2$, so $-\tfrac12\operatorname{tr}(\omega^2)=\sum_{a<b}\omega_{ab}^2=\lVert\omega\rVert^2$. There is therefore no free factor to hide in.
- $\omega^{\mathsf T}=-\omega$ for every $2$-form, hence $\omega\omega^{\mathsf T}=-\omega^2$.
- $\Lambda=\operatorname{diag}(\lambda_1,\dots,\lambda_r)$, all $\lambda_i\ne0$; $M\in\mathbb R^{r\times m}$ with $\omega_i=\sum_jM_{ij}\varepsilon_j$.
- After an orthogonal change of basis I may and do assume $P_j=\langle f_{2j-1},f_{2j}\rangle$ and $\varepsilon_j=e_{2j-1,2j}$; $P_0=\langle f_{2m+1},\dots,f_n\rangle$, of dimension $n-2m\ge0$.
- $V:=\operatorname{span}_{\mathbb R}\{\varepsilon_1,\dots,\varepsilon_m\}\subseteq\Lambda^2\mathbb R^n$, a subspace of dimension exactly $m$.

## Hypothesis inventory

### Used and stated

| Hypothesis | Where it does work |
| --- | --- |
| The $P_j$ are mutually orthogonal | Twice, and both times essentially: orthonormality of the $\varepsilon_j$ (hence $MM^{\mathsf T}=I_r$), and disjointness of the matrix supports (hence no cross terms in the Ricci half) |
| Each $P_j$ has dimension exactly $2$ | $\varepsilon_j$ is decomposable, which is what makes $\varepsilon_j\wedge\varepsilon_j=0$ and $\varepsilon_j\varepsilon_j^{\mathsf T}=\mathrm{Id}_{P_j}$ true |
| $\varepsilon_j$ is a *unit* area form | The $\varepsilon_j$ are then an orthonormal set, without which $MM^{\mathsf T}=I_r$ fails |
| Every eigenform of nonzero eigenvalue lies in $V$ | The whole of the proof; it is the definition of $M$ |
| Given A | The $m$ diagonal entries of $M^{\mathsf T}\Lambda M$ |
| Given B | The $\binom m2$ off-diagonal entries. **Load-bearing, and demonstrably so**, see §1.1 |
| Spectral form with the sum over nonzero eigenvalues only | $\Lambda$ is invertible-by-hypothesis, so $\Lambda=0$ is a contradiction rather than a triviality; and $r=0$ delivers $W=0$ |

### Stated and unused

- **$P_0$.** It is stated and it does nothing: it contributes the trivial equation $0=0$ to the Ricci half and nothing at all to the Bianchi half. That is a virtue, not a defect, see §7.
- **$n\ge12$, $\sqrt{3/2}$, $\theta_0(12)=1.236033$, $n=6+2\sqrt7$.** The brief asks that I say so if one of these appears. **None appears.** The proof is uniform in $n$ and mentions no numerical constant whatever. This is the correct state of affairs and I record it as a positive check, not an omission.

### Used and unstated

1. **The $\varepsilon_j$ are an orthonormal set of $\Lambda^2$.** The proof asserts $MM^{\mathsf T}=I_r$ "the $\varepsilon_j$ being orthonormal", which states the fact but not its ground. It is true: with $P_j=\langle f_{2j-1},f_{2j}\rangle$ the $\varepsilon_j$ are $m$ distinct members of the orthonormal basis $\{e_{ab}\}_{a<b}$. It needs the planes orthogonal, the same hypothesis that makes the Ricci half work.
2. **The spectral theorem.** That a self-adjoint real $W$ on $\Lambda^2$ admits a *real orthonormal* eigenbasis is used to have the $\omega_i$ at all, and to have $M$ real. The brief's conventions supply self-adjointness; the proof does not name the theorem.
3. **$\omega_i^2$ versus $\omega_i\omega_i^{\mathsf T}$.** Given A is $\sum_i\lambda_i\omega_i^2=0$; the proof computes $\omega_i\omega_i^{\mathsf T}$ and then says "Given A then reads". The two differ by a global sign. For a vanishing statement that is immaterial, and the conclusion $\sum_i\lambda_iM_{ij}^2=0$ is the same either way. It should still be said in one clause, because a reader checking the factor will otherwise stop here.
4. **The choice of orientation on each $P_j$.** "The unit area form of $P_j$" is determined only up to sign. Immaterial: flipping $\varepsilon_j$ flips the $j$-th column of $M$, which changes neither $MM^{\mathsf T}$ nor the vanishing of $M^{\mathsf T}\Lambda M$.
5. **That any orthonormal eigenbasis of the nonzero part will do.** See §6. It is true, and the reason is short, but the proof leans on it silently.

### 1.1 Given B is not decoration, an exact witness

It is worth recording that the Bianchi half carries real weight, because a proof in which one of two givens were redundant would be suspect. Take $n=4$, $m=r=2$, $\varepsilon_1=e_{12}$, $\varepsilon_2=e_{34}$, and

$$\omega_1=\tfrac1{\sqrt2}(\varepsilon_1+\varepsilon_2),\qquad \omega_2=\tfrac1{\sqrt2}(-\varepsilon_1+\varepsilon_2),\qquad \lambda_1=1,\ \lambda_2=-1 .$$

Then $MM^{\mathsf T}=I_2$, and $\omega_1^2=\omega_2^2=-\tfrac12(\mathrm{Id}_{P_1}+\mathrm{Id}_{P_2})$, so $\lambda_1\omega_1^2+\lambda_2\omega_2^2=0$: **Given A holds and $W\ne0$.** But $\omega_1\wedge\omega_1=\varepsilon_1\wedge\varepsilon_2$ and $\omega_2\wedge\omega_2=-\varepsilon_1\wedge\varepsilon_2$, so $\sum_i\lambda_i\,\omega_i\wedge\omega_i=2\,\varepsilon_1\wedge\varepsilon_2\ne0$ and Given B fails. This is exactly $(M^{\mathsf T}\Lambda M)_{12}=1$. So the diagonal half alone does not force $\Lambda=0$, and the theorem is a genuine two-identity result.

## 2. $MM^{\mathsf T}=I_r$, reality, and $r\le m$

**Is orthonormality of the $\omega_i$ really $MM^{\mathsf T}=I_r$?** Yes, and only because the $\varepsilon_j$ are orthonormal:

$$\langle\omega_i,\omega_{i'}\rangle=\Big\langle\sum_jM_{ij}\varepsilon_j,\ \sum_kM_{i'k}\varepsilon_k\Big\rangle=\sum_{j,k}M_{ij}M_{i'k}\langle\varepsilon_j,\varepsilon_k\rangle=\sum_jM_{ij}M_{i'j}=(MM^{\mathsf T})_{ii'} .$$

Setting this to $\delta_{ii'}$ gives $MM^{\mathsf T}=I_r$. The middle equality is where orthonormality of the $\varepsilon_j$ enters; had the planes merely been transverse rather than orthogonal, $\langle\varepsilon_j,\varepsilon_k\rangle$ would be a Gram matrix $G\ne I$ and the identity would read $MGM^{\mathsf T}=I_r$, which does not close the final step. **So "orthogonal decomposition" in the statement is not stylistic; it is the hypothesis that makes the last line work.**

**Are the $\varepsilon_j$ orthonormal, given the $P_j$ are orthogonal planes?** Yes. Pick an orthonormal basis of $\mathbb R^n$ adapted to $P_1\oplus\dots\oplus P_m\oplus P_0$; then $\varepsilon_j=e_{2j-1,2j}$, and distinct $j$ give distinct index pairs, so the $\varepsilon_j$ are $m$ distinct elements of an orthonormal basis of $\Lambda^2$.

**Is $M$ real?** Yes, twice over: the hypothesis says *real* combination, and independently, a real self-adjoint operator on the real inner-product space $\Lambda^2\mathbb R^n$ has a real orthonormal eigenbasis, so the $\omega_i$ may be taken real to begin with.

**Is $r\le m$ forced?** Yes, and by the equation itself rather than by fiat: $\operatorname{rank}(M)\le\min(r,m)$, while $MM^{\mathsf T}=I_r$ has rank $r$ and $\operatorname{rank}(MM^{\mathsf T})\le\operatorname{rank}(M)$. Hence $r\le\operatorname{rank}(M)\le m$. Equivalently: the $\omega_i$ are $r$ orthonormal vectors inside the $m$-dimensional space $V$. **This bound is the one the proof never uses and the non-vacuity block should have used**, see §9.

## 3. The Ricci half

Write $\varepsilon_j$ as a matrix: $\varepsilon_j=E_{2j-1,2j}-E_{2j,2j-1}$, supported entirely in the $2\times2$ block indexed by $P_j$ and zero in every other row and column.

**Cross terms vanish.** For $j\ne k$, $\varepsilon_j\varepsilon_k^{\mathsf T}=-\varepsilon_j\varepsilon_k$. The image of $\varepsilon_k$ is $P_k$, and $\varepsilon_j$ annihilates $P_j^{\perp}\supseteq P_k$; so $\varepsilon_j\varepsilon_k=0$. **There are no cross terms between planes.**

**The diagonal term.** With $\varepsilon:=E_{ab}-E_{ba}$,

$$\varepsilon^2=E_{ab}E_{ab}-E_{ab}E_{ba}-E_{ba}E_{ab}+E_{ba}E_{ba}=0-E_{aa}-E_{bb}+0=-\mathrm{Id}_{P_j},$$

so $\varepsilon_j\varepsilon_j^{\mathsf T}=-\varepsilon_j^2=\mathrm{Id}_{P_j}$. **Exactly the identity, with no factor of $2$ and no $\tfrac12$.**

Hence $\omega_i\omega_i^{\mathsf T}=\sum_{j,k}M_{ij}M_{ik}\,\varepsilon_j\varepsilon_k^{\mathsf T}=\sum_jM_{ij}^2\,\mathrm{Id}_{P_j}$, which is precisely the claim: block-diagonal, $M_{ij}^2\,\mathrm{Id}_{P_j}$ on the $j$-th plane, $0$ on $P_0$.

**The sign.** Given A is $\sum_i\lambda_i\omega_i^2=0$, and $\omega_i^2=-\omega_i\omega_i^{\mathsf T}$, so Given A is equivalent to $\sum_i\lambda_i\omega_i\omega_i^{\mathsf T}=0$. Reading off the $P_j$ block: $\big(\sum_i\lambda_iM_{ij}^2\big)\mathrm{Id}_{P_j}=0$, and since $\mathrm{Id}_{P_j}\ne0$, $\sum_i\lambda_iM_{ij}^2=0$ for each $j=1,\dots,m$. That is $(M^{\mathsf T}\Lambda M)_{jj}=\sum_iM_{ij}\lambda_iM_{ij}=0$. **The identification of the diagonal is exact.** The only defect is that the passage from $\omega_i^2$ to $\omega_i\omega_i^{\mathsf T}$ is made silently.

**Completeness of the equations extracted.** Given A is an identity in $S^2(\mathbb R^n)$, so in principle it carries $\binom{n+1}2$ scalar equations. Because every $\omega_i$ lies in $V$, all but the $m$ recorded ones are $0=0$. **The proof extracts everything Given A has to give here, and nothing is left on the table.**

## 4. The Bianchi half

$\varepsilon_j$ is decomposable, $\varepsilon_j=f_{2j-1}\wedge f_{2j}$, so $\varepsilon_j\wedge\varepsilon_j=0$. Wedge of two $2$-forms is symmetric, $\varepsilon_j\wedge\varepsilon_k=\varepsilon_k\wedge\varepsilon_j$. Therefore

$$\omega_i\wedge\omega_i=\sum_{j,k}M_{ij}M_{ik}\,\varepsilon_j\wedge\varepsilon_k=\sum_{j\ne k}M_{ij}M_{ik}\,\varepsilon_j\wedge\varepsilon_k=2\sum_{j<k}M_{ij}M_{ik}\,\varepsilon_j\wedge\varepsilon_k .$$

**The factor $2$ is right**, and it is inconsequential in any case, since Given B is a vanishing statement.

**Linear independence of the $\varepsilon_j\wedge\varepsilon_k$, $j<k$.** In the adapted basis, $\varepsilon_j\wedge\varepsilon_k=f_{2j-1}\wedge f_{2j}\wedge f_{2k-1}\wedge f_{2k}$. Distinct unordered pairs $\{j,k\}$ give distinct $4$-element index sets, hence distinct members of the standard basis $\{f_a\wedge f_b\wedge f_c\wedge f_d\}_{a<b<c<d}$ of $\Lambda^4$. **They are not merely independent, they are orthonormal.**

- **Large $m$.** The count is $\binom m2\le\binom{\lfloor n/2\rfloor}2\le\binom n4=\dim\Lambda^4$ for $n\ge4$, and independence follows from distinctness of index sets regardless of the count. Nothing degrades as $m$ grows.
- **Interaction with $P_0$.** None. Every index appearing in any $\varepsilon_j\wedge\varepsilon_k$ lies in $\{1,\dots,2m\}$; the $P_0$ directions never occur. $P_0$ enlarges $\Lambda^4$ and leaves the spanned subspace alone.

So Given B gives $\sum_i\lambda_iM_{ij}M_{ik}=0$ for every $j<k$, i.e. $(M^{\mathsf T}\Lambda M)_{jk}=0$ off the diagonal, and by symmetry of $M^{\mathsf T}\Lambda M$ this covers $k<j$ too. **Correct.**

**One caveat that costs nothing.** For $m=1$ the set of pairs is empty and Given B yields no equation at all. §11 shows the case still closes on Given A alone.

## 5. The final step, with $M$ non-square

This is the item the brief flags, and it survives.

**Sizes.** $M$ is $r\times m$, $M^{\mathsf T}$ is $m\times r$, $\Lambda$ is $r\times r$, $I_r$ is $r\times r$.

| Product | Shape composition | Result |
| --- | --- | --- |
| $M^{\mathsf T}\Lambda M$ | $(m\times r)(r\times r)(r\times m)$ | $m\times m$ |
| $M(M^{\mathsf T}\Lambda M)M^{\mathsf T}$ | $(r\times m)(m\times m)(m\times r)$ | $r\times r$ |
| $MM^{\mathsf T}$ | $(r\times m)(m\times r)$ | $r\times r$, $=I_r$ |

Every adjacency matches; the multiplication is legitimate for non-square $M$. The two zero matrices in play have different shapes ($M^{\mathsf T}\Lambda M=0_{m\times m}$ going in, $\Lambda=0_{r\times r}$ coming out) and the proof does not confuse them.

**The step.** By associativity alone,

$$M\big(M^{\mathsf T}\Lambda M\big)M^{\mathsf T}=\big(MM^{\mathsf T}\big)\Lambda\big(MM^{\mathsf T}\big)=I_r\,\Lambda\,I_r=\Lambda .$$

The left side is $M\cdot 0_{m\times m}\cdot M^{\mathsf T}=0_{r\times r}$. Hence $\Lambda=0$.

**Nothing illegitimate is done.** In particular:

- **$M$ is never inverted, and never needs to be.** The rewriting is a regrouping of a four-fold product; it is valid for any $M$ whatever and does not ask $M$ to be square, invertible or of full rank.
- **The direction of the identity matters and is the right one.** $MM^{\mathsf T}=I_r$ holds ($M$ has orthonormal *rows*); $M^{\mathsf T}M=I_m$ does **not** hold unless $r=m$, and $M^{\mathsf T}M$ is instead the orthogonal projector of $\mathbb R^m$ onto the row space of $M$. **The proof uses only $MM^{\mathsf T}$, in both slots, and never the reverse.** This is the single place where a non-square argument of this shape usually breaks, and it does not break here.
- **The converse is not claimed and would be false.** From $\Lambda=0$ one gets $M^{\mathsf T}\Lambda M=0$ trivially; the content is the forward direction, which is what is proved. A reader might wonder whether the argument secretly proves the vacuous direction. It does not: the vanishing of the $m\times m$ matrix is the hypothesis and the vanishing of the $r\times r$ one is the conclusion, and the sandwich by an $I_r$-normalised $M$ is exactly what upgrades the smaller statement to the larger.
- **Conclusion.** $\Lambda=0$ contradicts $\lambda_i\ne0$ for every $i=1,\dots,r$, so $r=0$; the spectral sum is then empty and $W=0$. The logic "contradicting $\lambda_i\ne0$ unless there are no such eigenvalues" is exactly right and is not a slip: $r=0$ is the escape and it is the conclusion.

**Verdict on item 5: SOUND.** I looked for the standard failure (a proof that quietly needs $M^{\mathsf T}M=I$) and it is not present.

## 6. Degenerate eigenvalues, and whether the hypothesis is well posed

This is the item where I expected to find the defect, and I did not.

**The worry, stated precisely.** If $\lambda\ne0$ has multiplicity $\ge2$, the eigenspace $E_\lambda$ has many orthonormal bases. "Every eigen-$2$-form with nonzero eigenvalue is a real combination of the $\varepsilon_j$" could mean either

- **(strong)** every vector of every nonzero eigenspace lies in $V$; or
- **(weak)** *some* orthonormal eigenbasis consists of vectors of $V$.

If these differed, the hypothesis would be ill posed under (weak) and the proof would be applying it to a basis it has not been given.

**They do not differ.** (strong) $\Rightarrow$ (weak) is immediate. For (weak) $\Rightarrow$ (strong): suppose $\{\omega_i\}_{i\in I_\lambda}$ is a basis of $E_\lambda$ with every $\omega_i\in V$. Then $E_\lambda=\operatorname{span}\{\omega_i\}_{i\in I_\lambda}\subseteq V$, because **$V$ is a linear subspace and therefore closed under the real linear combinations that produce every other vector of $E_\lambda$**. So every vector of $E_\lambda$ is in $V$, which is (strong).

**Hence the hypothesis has a basis-free form:** $W$ is simultaneously block-diagonal for the splitting **iff** $\operatorname{im}(W)\subseteq V$, equivalently $\bigoplus_{\lambda\ne0}E_\lambda\subseteq V$. This depends on $W$ and the splitting alone and on no choice of basis.

**Does the proof need it not to depend on the choice?** Yes, and it gets it. The proof (i) invokes the spectral theorem to fix *some* orthonormal eigenbasis $\{\omega_i\}$ of the nonzero part, then (ii) asserts each $\omega_i\in V$. Step (ii) is licensed immediately by (strong), which is the literal reading of the statement, and by the equivalence above it is licensed by (weak) too. **Under either reading the proof is entitled to what it uses, and the choice of basis inside a degenerate eigenspace is free.**

**A second, independent reason the degeneracy is harmless.** Suppose one replaced $\{\omega_i\}_{i\in I_\lambda}$ by $\{\tilde\omega_i\}=Q$-rotated, $Q$ orthogonal of size $|I_\lambda|$. Then $M$ becomes $\tilde M$ with the rows in $I_\lambda$ left-multiplied by $Q$, i.e. $\tilde M=QM$ blockwise; $\Lambda$ restricted to those rows is $\lambda I$, which commutes with $Q$; so $\tilde M^{\mathsf T}\Lambda\tilde M=M^{\mathsf T}Q^{\mathsf T}\Lambda QM=M^{\mathsf T}\Lambda M$ and $\tilde M\tilde M^{\mathsf T}=QMM^{\mathsf T}Q^{\mathsf T}=I$. **Both equations of the proof are invariant under the rotation.** The proof's output cannot depend on the choice even formally.

**Verdict: WELL POSED, and the proof needs nothing it lacks.** What it owes is one sentence saying so; a reader is entitled to ask and the block does not answer.

## 7. $P_0$ and odd $n$

**$P_0\ne0$.** Nothing breaks, and I can say precisely why nothing breaks:

- Orthonormality of the $\varepsilon_j$ is unaffected, the $\varepsilon_j$ never involve a $P_0$ index.
- The Ricci identity is an identity on all of $\mathbb R^n$; on the $P_0$ block and on every $P_j\times P_0$ off-diagonal block both sides are $0$, so it reads $0=0$ and contributes no equation. **The proof needs no equation from there**, so losing them costs nothing.
- $\Lambda^4\mathbb R^n$ is larger when $P_0\ne0$, but the $\varepsilon_j\wedge\varepsilon_k$ still sit in the sub-$\Lambda^4$ of $\bigoplus_jP_j$ and are still orthonormal. A larger ambient space cannot destroy independence.
- $M$ is $r\times m$ throughout; $n$ and $\dim P_0$ enter no size.

**Odd $n$.** Then $n-2m$ is odd, so $P_0\ne0$ necessarily, with $\dim P_0\ge1$. By the previous paragraph this is inert. **The proof is genuinely independent of the parity of $n$.**

**The one thing worth naming.** The hypothesis becomes *stronger* (so the theorem weaker) as $m$ shrinks and $P_0$ grows, because $\dim V=m$ shrinks. That direction is harmless: the theorem is "no nonzero $W$ exists", so a stronger hypothesis is an easier theorem, and the proof does not exploit largeness of $m$ anywhere.

## 8. The kernel

**No step assumes $\ker W=0$.** I checked each:

| Step | Does it need $\ker W=0$? |
| --- | --- |
| $\omega_i=\sum_jM_{ij}\varepsilon_j$ | No, $i$ ranges over nonzero eigenvalues only, by construction |
| $MM^{\mathsf T}=I_r$ | No, orthonormality of $r$ vectors, whatever $r$ is |
| Ricci diagonal | No |
| Bianchi off-diagonal | No |
| $\Lambda=M(M^{\mathsf T}\Lambda M)M^{\mathsf T}$ | No, $r$ may be any value $0\le r\le m$ |

Indeed the theorem *permits* an arbitrarily large kernel: $r\le m\le\lfloor n/2\rfloor$ while $\dim\Lambda^2=\binom n2$, so any $W$ satisfying the hypothesis has $\dim\ker W\ge\binom n2-\lfloor n/2\rfloor$. **The hypothesis constrains only the image; the kernel is entirely free, and the proof is written so that this costs nothing.** That is the right design, and it is why this record's recurring obstruction does not bite here.

**Is dropping the zero eigenvalues at the outset legitimate under both givens?** Yes, and for two different reasons which should both be stated.

- **Given A**: the summand for $\lambda_i=0$ is $0\cdot\omega_i^2=0$, so it may be dropped from $\sum_i\lambda_i\omega_i^2$ with no hypothesis at all. The dropping is arithmetic.
- **Given B**: the brief's Given B says explicitly "the zero eigenvalues dropping out". So this is granted, not assumed. Note it is *not* the same triviality as in Given A: the passage from the first Bianchi identity to $\sum\lambda_i\,\omega_i\wedge\omega_i=0$ goes through a projection, and it is Given B (audited and passed, per the brief) that certifies the zero-eigenvalue terms play no role in that passage. **The proof is entitled to it, but only because the brief hands it over; the proof itself gives no argument, and would be incomplete without Given B's clause.** I record that as a dependency, not a defect.

There is a third, easy-to-miss place where the kernel could have entered and does not: the conclusion. From $\Lambda=0$ we get $r=0$, and the spectral form then sums over the empty set, giving $W=0$, which is a statement about the *whole* of $W$, kernel included. **No gap between "the nonzero part vanishes" and "$W=0$".**

## 9. The two non-vacuity checks, where this proof actually goes wrong

The theorem is sound. The two-sentence block that follows it is not, and both sentences are wrong in a different way.

### 9a. "A coordinate-diagonal $W$ escapes, its eigenforms being the $e_{ab}$, which no splitting into $\lfloor n/2\rfloor$ planes contains."

**Two things are true here.** (i) $\{e_{ab}\}_{a<b}$ spans $\Lambda^2$, of dimension $\binom n2$, whereas $\dim V=m\le\lfloor n/2\rfloor<\binom n2$ for $n\ge3$; so no splitting's $V$ contains **all** the $e_{ab}$. (ii) Restricting to $m=\lfloor n/2\rfloor$ is harmless, since $V$ is largest there.

**The thing that is false is the inference.** The hypothesis of the theorem does not ask $V$ to contain *all* eigenforms. It asks $V$ to contain the eigenforms **of nonzero eigenvalue**, and a coordinate-diagonal $W$ has $e_{ab}$ as an eigenform for every pair, including every pair whose eigenvalue is $0$. The check argues from a set the hypothesis does not constrain. Concretely: if a coordinate-diagonal $W$ had its nonzero eigenvalues only on, say, $e_{12}$ and $e_{34}$, it would satisfy the hypothesis for the splitting $\langle f_1,f_2\rangle\oplus\langle f_3,f_4\rangle$, and would **not** escape. **So the sentence as written does not establish what it claims.**

**Does the conclusion survive?** Only with a premise the block never supplies: that the coordinate-diagonal $W$ in question has more than $\lfloor n/2\rfloor$ nonzero eigenvalues. **The record contains no argument that a nonzero coordinate-diagonal algebraic Weyl tensor exists at all, still less one with that many nonzero eigenvalues.** Per the brief I do not supply it. Verdict: **`HYPOTHESIS-DEBT`** on the existence, and **NON-SEQUITUR** on the inference as written.

I add one observation that is a critique rather than a repair: the only route from the block's premise to its conclusion that I can see runs through the theorem itself, a coordinate-diagonal $W$ with $\le m$ nonzero eigenvalues *would* be block-diagonal and hence zero. Using the theorem to justify the theorem's own non-vacuity check would be circular, so the block cannot be rescued that way. It has to be rescued by exhibiting a witness, which the record does not do.

### 9b. "$W_{\mathbb{CP}^2}$ escapes, because two of its self-dual eigenforms are $\tfrac1{\sqrt2}(\varepsilon_1\pm\varepsilon_2)$ but $\tfrac1{\sqrt2}(e_{13}-e_{24})$ and $\tfrac1{\sqrt2}(e_{14}+e_{23})$ are not block-diagonal in that splitting or any other."

This sentence contains one false premise and one false claim. **The conclusion is nevertheless true.**

**First: the mislabel.** In $n=4$ with $\varepsilon_1=e_{12}$, $\varepsilon_2=e_{34}$ and the Hodge star normalised by $\ast e_{12}=e_{34}$, $\ast e_{13}=-e_{24}$, $\ast e_{14}=e_{23}$, the self-dual space $\Lambda^+$ is spanned by

$$\tfrac1{\sqrt2}(e_{12}+e_{34}),\quad \tfrac1{\sqrt2}(e_{13}-e_{24}),\quad \tfrac1{\sqrt2}(e_{14}+e_{23}),$$

and $\tfrac1{\sqrt2}(e_{12}-e_{34})=\tfrac1{\sqrt2}(\varepsilon_1-\varepsilon_2)$ is **anti**-self-dual. So of the pair $\tfrac1{\sqrt2}(\varepsilon_1\pm\varepsilon_2)$, exactly **one** is self-dual, not two. Since $W_{\mathbb{CP}^2}$ has $W^-=0$, the other carries eigenvalue $0$ and is therefore not among the $\omega_i$ at all. Reversing the orientation swaps $\Lambda^\pm$ and the count is still one, so the error is not a convention clash. **"Two of its self-dual eigenforms are $\tfrac1{\sqrt2}(\varepsilon_1\pm\varepsilon_2)$" is false under either orientation.**

**Second, and worse: "not block-diagonal in that splitting or any other" is false, exhibited in closed form.** Take the first of the two forms and the orthonormal basis $g_1=f_1$, $g_2=f_3$, $g_3=f_2$, $g_4=f_4$, a permutation of the original orthonormal basis, hence orthonormal. Then $e_{13}=f_1\wedge f_3=g_1\wedge g_2$ and $e_{24}=f_2\wedge f_4=g_3\wedge g_4$, so

$$\tfrac1{\sqrt2}(e_{13}-e_{24})=\tfrac1{\sqrt2}\big(g_1\wedge g_2-g_3\wedge g_4\big)=\tfrac1{\sqrt2}\big(\varepsilon_1'-\varepsilon_2'\big)$$

for the splitting $\mathbb R^4=\langle f_1,f_3\rangle\oplus\langle f_2,f_4\rangle$ with unit area forms $\varepsilon_1'=g_1\wedge g_2$, $\varepsilon_2'=g_3\wedge g_4$ of two **orthogonal** planes. **That is a real combination of the $\varepsilon'_j$, so this form is block-diagonal for that splitting.** The same works for $\tfrac1{\sqrt2}(e_{14}+e_{23})$ with $\langle f_1,f_4\rangle\oplus\langle f_2,f_3\rangle$.

**The general fact behind the refutation.** Every $2$-form on $\mathbb R^n$ is a real combination of the unit area forms of some orthogonal splitting into planes, that is the real skew normal form of a skew matrix under an orthogonal change of basis. **So "$\omega$ is not block-diagonal for any splitting" is false for every $2$-form $\omega$ whatever, and the block's reason cannot be right for any choice of forms.** The obstruction is never about one form; it is about several forms *simultaneously*, which is precisely what the word "simultaneously" in the statement of the theorem is doing and what the check overlooked.

**The conclusion is nonetheless true**, by the proof's own bound and not by the block's reason: $W_{\mathbb{CP}^2}$ has $W^+$ of rank $3$ (eigenvalues in the ratio $2:-1:-1$) and $W^-=0$, so $r=3$; while $n=4$ forces $m\le2$ and $\dim V=m\le2$. Then $\operatorname{im}(W)=\Lambda^+$ has dimension $3>2\ge\dim V$, so $\operatorname{im}(W)\not\subseteq V$ for **every** splitting, the quantification over all splittings is discharged by a dimension count, uniformly. Equivalently: $r\le m$ from §2 fails.

**Verdict on 9b: CONCLUSION TRUE, STATED REASON REFUTED.** As a claim quantified over all splittings, the block gives no argument, so on the brief's own rule the block's version is **`HYPOTHESIS-DEBT`**; I note that the debt is dischargeable from a step already inside the proof ($r\le m$, §2), which the block does not invoke.

**Net effect on non-vacuity.** The theorem's hypothesis is still non-vacuous in the sense that matters, it *is* restrictive, since $r\le m\le\lfloor n/2\rfloor$ excludes every $W$ of $\Lambda^2$-rank above $\lfloor n/2\rfloor$, which includes $W_{\mathbb{CP}^2}$. **But the block's two sentences are not a demonstration of it, and one of them is refutable.** They should be replaced by the rank bound, which proves both cases at once and quantifies over all splittings for free.

## 10. Scope

The block's "at every $n$, every rank and every number of blocks" **is entailed**, in the following precise sense: no step of the proof restricts $n$, $r$ or $m$, and each step has been checked above without such a restriction. Specifically,

- **$n$**: enters only through the ambient spaces $S^2(\mathbb R^n)$ and $\Lambda^4\mathbb R^n$, and only as "large enough to contain the objects", which is automatic. For $n\le3$ the statement is true but empty, since $\mathcal W_n=0$ there.
- **$r$**: appears as a size and nothing more; $r=0$ is the conclusion, and every $1\le r\le m$ is refuted uniformly.
- **$m$**: appears as a size; $m=1$ needs the separate remark of §11 but closes.

**And the check the brief asked for: none of $n\ge12$, $\sqrt{3/2}$, $\theta_0(12)$ or $n=6+2\sqrt7$ appears in the proof, and none is needed.** The result is an identity-level statement about $\mathcal W_n$ and is correctly stated without a threshold. I regard the phrase "every rank" as slightly misleading rhetoric rather than an error, the theorem's content is that the rank is $0$, so "every rank" means "the argument does not first fix a rank", which is true.

## 11. The boundary

| Case | What happens |
| --- | --- |
| $m=1$ | Bianchi contributes nothing ($\binom12=0$ pairs). $MM^{\mathsf T}=I_r$ with $M$ of size $r\times1$ forces $r\le1$. If $r=1$, $M=(\pm1)$ and Ricci gives $\lambda_1\cdot1=0$, contradiction. **Closes on Given A alone.** |
| $r=1$ | $M$ is a unit row vector, $\sum_jM_{1j}^2=1$, so some $M_{1j}\ne0$; the $j$-th Ricci equation is $\lambda_1M_{1j}^2=0$, so $\lambda_1=0$. **Closes on Given A alone**, for any $m$. |
| $r=m$ | $M$ is a genuine orthogonal matrix, $M^{\mathsf T}=M^{-1}$, and $M^{\mathsf T}\Lambda M=0\Rightarrow\Lambda=0$ by conjugation. This is the easy case; the proof's non-square handling specialises to it correctly. |
| $r>m$ | Cannot occur: excluded by $MM^{\mathsf T}=I_r$ (§2). Worth stating, since the final step's shapes would still compose and a reader may wonder. |
| $n=4$ | $m\le2$, $\dim V\le2$, $r\le2$. Both $m=1$ and $m=2$ are covered above. The Bianchi half is non-empty exactly when $m=2$, where $\Lambda^4\mathbb R^4$ is one-dimensional and $\varepsilon_1\wedge\varepsilon_2$ spans it, independence of a single vector, which holds since $\varepsilon_1\wedge\varepsilon_2\ne0$. |
| odd $n$ | $P_0\ne0$; §7. |
| $n<12$ | The proof never sees $n$; nothing changes. For $n\le3$, $\mathcal W_n=0$ and the statement is vacuously true. |
| $r=0$ | The hypothesis is satisfied vacuously by $W=0$, and the conclusion $W=0$ holds. **Consistent, and it is why $0\in\mathcal W_n$ in the brief's conventions is not a counterexample.** |

## What would break it, and what I did to look for it

**The falsifier.** A nonzero $W\in\mathcal W_n$ together with an orthogonal splitting $\mathbb R^n=P_1\oplus\dots\oplus P_m\oplus P_0$ into planes such that $\operatorname{im}(W)\subseteq\operatorname{span}\{\varepsilon_1,\dots,\varepsilon_m\}$. Equivalently, in coordinates: real $\Lambda=\operatorname{diag}(\lambda_1,\dots,\lambda_r)$ with all $\lambda_i\ne0$ and real $M\in\mathbb R^{r\times m}$ with $MM^{\mathsf T}=I_r$ and $M^{\mathsf T}\Lambda M=0$.

**What I did to look for it.** No search, no sweep, no numerical work of any kind, the brief's analysis-only footing forbids it and I did not need it. I did three things by hand:

1. **Checked the two-equation system for slack.** The $m$ diagonal equations alone leave room: §1.1 exhibits $\Lambda=\operatorname{diag}(1,-1)$, $M=\tfrac1{\sqrt2}\left(\begin{smallmatrix}1&1\\-1&1\end{smallmatrix}\right)$ with $MM^{\mathsf T}=I_2$ and $\operatorname{diag}(M^{\mathsf T}\Lambda M)=0$. **This is a Ricci-flat, non-Bianchi falsifier of the Ricci half in isolation**, which is the closest object to a falsifier that exists, and it dies on the off-diagonal.
2. **Checked whether the non-square shape leaves a gap.** It does not: §5. The one substitution that would open a gap, $M^{\mathsf T}M=I_m$, is never used.
3. **Checked whether the degenerate-eigenvalue freedom leaves a gap.** It does not: §6, and the rotation-invariance argument there shows both of the proof's equations are unchanged by any regauging inside a degenerate eigenspace.

**Nothing can exist**, and the reason is the one-line invariant: $M$ has orthonormal rows, so the symmetric form $\Lambda$ is recovered from its restriction to the row space of $M$ by $\Lambda=(MM^{\mathsf T})\Lambda(MM^{\mathsf T})=M(M^{\mathsf T}\Lambda M)M^{\mathsf T}$, and a vanishing restriction therefore forces a vanishing form. **I could not construct a falsifier and I can say why none exists.**

## Overall verdict

**SOUND, ANNEX REFUTED.**

- **The theorem and its proof: SOUND.** Every one of the eleven items the brief raised holds up. The non-square final step is legitimate and uses the correct one of the two Gram identities. The block-diagonality hypothesis is well posed under repeated eigenvalues and is in fact basis-free, equivalent to $\operatorname{im}(W)\subseteq V$. $P_0$, odd $n$ and a large kernel are all inert. No constant of the conjecture appears, and none is needed.
- **Owed, and cheap: three sentences.** Why the $\varepsilon_j$ are orthonormal; that Given A's $\omega_i^2$ is $-\omega_i\omega_i^{\mathsf T}$; and that the hypothesis does not depend on the eigenbasis chosen inside a degenerate eigenspace.
- **The non-vacuity block: must be struck and rewritten.** Check 2's stated reason is **refuted in closed form**, $\tfrac1{\sqrt2}(e_{13}-e_{24})=\tfrac1{\sqrt2}(g_1\wedge g_2-g_3\wedge g_4)$ is block-diagonal for $\langle f_1,f_3\rangle\oplus\langle f_2,f_4\rangle$, and indeed *every* $2$-form is block-diagonal for some splitting, and it also miscounts the self-dual forms. Check 1 is a **non-sequitur**, arguing from eigenforms of eigenvalue $0$ that the hypothesis does not constrain, and it carries a **`HYPOTHESIS-DEBT`**: the existence of a nonzero coordinate-diagonal algebraic Weyl tensor has no argument on file, and per the brief I have not supplied one.
- **Both conclusions survive** on $r\le m$, which is already inside the proof at §2 and which the block does not invoke.

## Process notes

- **No numerical work was done this round, not even a permitted screen.** Every quantity above is exact and hand-derived.
- **No reference folder was fetched**, so there is nothing uncommitted on that account.
- Per the brief I did **not** edit [reviews/INDEX.md](INDEX.md); the fold writes the row.
- **The commit gate refused this report, and it is therefore left uncommitted.** [structure_gate.py](../.claude/hooks/structure_gate.py) fails the commit on row C, `reviews_unindexed: [775, 776]`, because neither this report nor the co-reviewer's has an index row yet. The brief forbids me to add one, so I stopped rather than index it: the file sits untracked at [reviews/REVIEW_r775.md](REVIEW_r775.md) for the fold to index and commit. The gate reported no other row attributable to this round; its rows D, E, F and G were already failing or already flagged as reported-not-enforced before I began, and are not mine.
- I did not read [reviews/REVIEW_r776.md](REVIEW_r776.md), which appeared untracked in the tree while I worked.
