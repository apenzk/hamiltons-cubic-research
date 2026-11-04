# Gate 2 review r798, L185, three decomposable image forms and $\dim V=6$

*Cold brief. **No numerical work was done in the sense the standing rule reserves**, no search, sweep, census, optimisation or falsifier hunt. Every derivation below is closed form and every constant exact. Two **screens** were run and are reported as screens in section 7, cited for nothing positive: a typecheck of [L185Statement.lean](../lean/HamiltonsCubic/Results/L185Statement.lean), and seconds of floating-point arithmetic on five plane triples I wrote down myself, re-checking by machine an emptiness I had already derived by hand. Log: [agent_logs/g2-l185-r798.log](../agent_logs/g2-l185-r798.log).*

## The claim table

| # | Claim under audit | Verdict |
|---|---|---|
| 1 | Step 1, spectral form $W=\sum_i\lambda_i\,\omega_i\otimes\omega_i$ over an orthonormal eigenbasis | **CORRECT**, it is [L179](../findings/diagonal-half.md#lemma-l179-the-support-of-a-low-rank-weyl-tensor-and-the-first-bianchi-identity-read-on-the-spectrum)(a)'s own setup |
| 2 | Step 2, Ricci-flatness is $\sum_i\lambda_i\,\omega_i\omega_i^{\mathsf T}=0$ | **CORRECT, EXACTLY**, in the record's own pairing and with no stray factor |
| 3 | Step 3, $\omega\omega^{\mathsf T}=\Pi$ for a unit decomposable $\omega$ | **CORRECT, EXACTLY**, under this record's normalisation; and any competing one changes nothing |
| 4 | Step 4, Ricci-flatness reads $\sum_i\lambda_i\Pi_i=0$ | **CORRECT** |
| 5 | Step 5, $\dim(P_1+P_2+P_3)=6$ forces the sum DIRECT | **CORRECT**, and directness is independence rather than orthogonality |
| 6 | Step 6, the zero decomposition is unique, so $\lambda_1=0$ | **CORRECT** |
| 7 | The scope, three decomposable eigenforms is an assumption | **STATED IN THE LEAN, ABSENT FROM THE ONE-LINE CLAIM** |
| 8 | The Lean theorem `lam_eq_zero_of_rangeIndependent` proves what its docstring says | **CORRECT**, typechecks, no `sorry` |
| 9 | `RangeIndependent` is what $\dim V=6$ supplies | **CORRECT** |
| 10 | **Vacuity, is there any configuration satisfying the hypotheses?** | **NONE, AT ANY $\dim V$**, the whole branch is empty, by two independent routes |
| 11 | "So a rank-three Weyl tensor with three decomposable image forms has $\dim V\le5$" | **TRUE BUT VACUOUS, AND THE FRAMING UNDERSTATES BY THE WHOLE BRANCH** |
| 12 | L185 has a row in [lean/INDEX.md](../lean/INDEX.md) or a block in [findings/](../findings/) | **NEITHER, the claim lives only in the Lean file** |
|, | **The claim as posed: three decomposable image forms cannot span six dimensions** | **CONFIRMED** |

**Actionable in one line:** the lemma is right and its six-dimensional framing is two dimensions too timid, the all-decomposable branch of [I38](../plan.md) is EMPTY, not capped at five, and one line of [L180](../findings/diagonal-half.md#lemma-l180-ricci-flatness-is-a-signed-psd-identity-and-it-names-the-support)(3) already said so before L185 was written.

## 0. Conventions, fixed once

I use the record's own, taken from [L180](../findings/diagonal-half.md#lemma-l180-ricci-flatness-is-a-signed-psd-identity-and-it-names-the-support) and nothing else.

- A $2$-form and a real skew matrix are the same object; $\lVert\omega\rVert^2=-\tfrac12\mathop{\mathrm{tr}}(\omega^2)=\tfrac12\sum_{a,b}\omega_{ab}^2$. This is the pairing that carries the $\tfrac12$, and L180's proof states it in the form $\mathop{\mathrm{tr}}(\omega\omega^{\mathsf T})=\sum_{a,b}\omega_{ab}^2=2\lVert\omega\rVert^2$.
- **Support** of $\omega$ is the image of its matrix; $V$ is the span of the supports of the eigenforms with nonzero eigenvalue, which is [L179](../findings/diagonal-half.md#lemma-l179-the-support-of-a-low-rank-weyl-tensor-and-the-first-bianchi-identity-read-on-the-spectrum)(a)'s definition.
- $\Pi_P$ is the orthogonal projection onto a plane $P$; $\varepsilon_P$ a unit area form of it.
- $A_i=-\omega_i^2=\omega_i\omega_i^{\mathsf T}$, L180's symbol.

## 1. Step 2, Ricci-flatness, checked against the record's own contraction

**The claim is exact and there is no factor to lose.** [L180](../findings/diagonal-half.md#lemma-l180-ricci-flatness-is-a-signed-psd-identity-and-it-names-the-support)(1) computes the contraction in coordinates: with $W_{abcd}=\sum_i\lambda_i(\omega_i)_{ab}(\omega_i)_{cd}$, the Ricci trace is $\sum_bW_{abcb}=\sum_i\lambda_i\sum_b(\omega_i)_{ab}(\omega_i)_{cb}=\big(\sum_i\lambda_i\,\omega_i\omega_i^{\mathsf T}\big)_{ac}$. So Ricci-flatness is $\sum_i\lambda_i\,\omega_i\omega_i^{\mathsf T}=0$, which is $\sum_i\lambda_iA_i=0$ and, by $\omega^{\mathsf T}=-\omega$, is L180's $\sum_i\lambda_i\omega_i^2=0$ up to an overall sign that kills nothing.

**Where the $\tfrac12$ could have bitten, and why it does not.** The pairing on $\Lambda^2$ carries a $\tfrac12$, so one might expect the passage between the operator $W$ on $\Lambda^2$ and the tensor $W_{abcd}$ to carry one too. It does, and it cancels. Writing the operator as $(W\eta)_{ab}=\tfrac12\sum_{cd}W_{abcd}\eta_{cd}$ and the spectral form as $W\eta=\sum_i\lambda_i\langle\omega_i,\eta\rangle\,\omega_i$ with $\langle\omega,\eta\rangle=\tfrac12\sum\omega_{cd}\eta_{cd}$, the two halves are the same half and $W_{abcd}=\sum_i\lambda_i(\omega_i)_{ab}(\omega_i)_{cd}$ with coefficient one, which is the line L180 writes. **A record whose $\Lambda^2$ pairing had no $\tfrac12$ would put a $2$ on one side and a $2$ on the other.** Either way the equation is homogeneous in the $\lambda_i$ and the conclusion is untouched.

*Argued the opposite:* the strongest reading against step 2 is that "Ricci-flatness" for a Weyl tensor is a definition rather than a condition, $W$ is totally trace-free by membership in $\mathcal W_n$, so the equation is automatic. That reading does not weaken the step; it strengthens it, since then $\sum_i\lambda_i\Pi_i=0$ holds for every $W$ in the family with no hypothesis at all. **Not a discrepancy.**

## 2. Step 3, $\omega\omega^{\mathsf T}=\Pi$, and which of the two things a factor would do

**Under this record's normalisation the identity is exact, with no constant.** Let $\omega$ be decomposable and of unit norm. Decomposability gives $\omega=u\wedge v$; choosing an orthonormal basis $e_1,e_2$ of the plane $P=\langle u,v\rangle$ makes $\omega=c\,(e_1\wedge e_2)$, and as a matrix $\omega=c\,(E_{12}-E_{21})$ in that basis. Then

$$\omega\omega^{\mathsf T}=-\omega^2=c^2\big(e_1e_1^{\mathsf T}+e_2e_2^{\mathsf T}\big)=c^2\,\Pi_P,\qquad \lVert\omega\rVert^2=\tfrac12\sum_{a,b}\omega_{ab}^2=c^2 .$$

So unit norm is $c^2=1$ and $\omega\omega^{\mathsf T}=\Pi_P$ on the nose, the sign of $c$ dropping out because the expression is quadratic. **The record's own $\mathop{\mathrm{tr}}A_i=2$ is the same statement read at the trace**, $\mathop{\mathrm{tr}}\Pi_P=2$.

**And a factor would change nothing, which is the branch the brief asks me to name.** Had the pairing been $\langle\alpha,\beta\rangle=\mathop{\mathrm{tr}}(\alpha^{\mathsf T}\beta)$ without the $\tfrac12$, unit norm would read $c^2=\tfrac12$ and each $\omega_i\omega_i^{\mathsf T}$ would be $\tfrac12\Pi_i$. **The constant is the same $c^2$ for all three $i$ precisely because all three are unit**, so it factors out of $\sum_i\lambda_i\,\omega_i\omega_i^{\mathsf T}=0$ and the equation $\sum_i\lambda_i\Pi_i=0$ survives verbatim. A factor here could only change everything if it were $i$-dependent, and unit norm is what forbids that.

**One step is genuinely unproved and the Lean file says so.** "Decomposable and unit $\Rightarrow$ area form of a plane" needs the real skew normal form (or, equivalently, the choice of an orthonormal basis of $\langle u,v\rangle$ above); [L185Statement.lean](../lean/HamiltonsCubic/Results/L185Statement.lean)'s "What is NOT typed here" lists exactly this as the missing bridge from a general decomposable $\omega$ to `areaForm`. **The honesty is on file, so this is debt and not a defect.**

## 3. Step 5, does $\dim=6$ force directness, with the planes meeting?

**Yes, and the planes meeting is precisely what it rules out.** For any finite family of subspaces $\dim(P_1+\dots+P_k)\le\sum_j\dim P_j$, with equality if and only if the sum is direct. Here $\sum_j\dim P_j=2+2+2=6$ and the hypothesis is $\dim(P_1+P_2+P_3)=6$, so equality holds and the sum is direct.

**The brief's "consider the planes meeting" is the contrapositive, not a counterexample.** If $P_1\cap P_2\ne0$, or more generally if some $x\in P_1$ lies in $P_2+P_3$, the sum drops: $\dim(P_1+P_2+P_3)\le5$. So a meeting configuration is one where the hypothesis $\dim V=6$ fails, and the lemma says nothing about it, correctly, since at $\dim V=4$ [L178](../findings/diagonal-half.md#lemma-l178-every-weyl-tensor-of-lambda2-rank-at-most-three-has-thetalesqrt32-with-equality-exactly-at-w_mathbbcp2) already governs.

**Directness here is independence and not orthogonality, and the Lean is right to type it that way.** Three pairwise non-orthogonal planes can be independent, the record's own sentence "three pairwise non-orthogonal planes can still span six dimensions" is true, and it is exactly the case L185 kills. `RangeIndependent` in the Lean file quantifies over families $x_i$ fixed by $\Pi_i$ summing to zero, which for idempotent $\Pi_i$ is $x_i\in\mathop{\mathrm{range}}\Pi_i$, that is independence of the three ranges and nothing more. **No orthogonality, no first Bianchi identity and no rank enter, exactly as the file claims.**

## 4. Step 6, is the decomposition of $0$ unique?

**Uniqueness of the zero decomposition IS directness; the two are the same sentence.** In a direct sum $P_1\oplus P_2\oplus P_3$, $x_1+x_2+x_3=0$ with $x_j\in P_j$ forces every $x_j=0$; that is the definition. Applying $\sum_i\lambda_i\Pi_i=0$ to $x\in P_1$ gives $\lambda_1\Pi_1x+\lambda_2\Pi_2x+\lambda_3\Pi_3x=\lambda_1x+\lambda_2\Pi_2x+\lambda_3\Pi_3x=0$ with the three summands in $P_1$, $P_2$, $P_3$ respectively, since an orthogonal projection lands in its own plane. Hence $\lambda_1x=0$ and, $x\ne0$ being available because $\dim P_1=2>0$, $\lambda_1=0$.

*Argued the opposite:* one could object that $\Pi_2x$ and $\Pi_3x$ need not be nonzero, so nothing is being decomposed. That is irrelevant, directness forces each summand to vanish whether or not it was going to, and only the $P_1$ summand is used. **A second objection, that $x$ might have components outside $V$: it cannot, $x\in P_1\subseteq V$.** Not a discrepancy.

## 5. The scope, is the decomposability assumption carried?

**In the Lean file, yes; in the one-line claim, no.** [L185Statement.lean](../lean/HamiltonsCubic/Results/L185Statement.lean) lists under "What is NOT typed here" that "$\Lambda^2$-rank three forces three decomposable forms" is false and that the non-decomposable branch is a different case, citing the record's own "a non-decomposable image form has support of dimension at least four on its own". **That is the assumption stated.** The headline sentence "three decomposable image forms of a rank-three Weyl tensor cannot span a six-dimensional subspace" carries it in the word "decomposable", so nothing is silent.

**One ambiguity the record does not address and which my section 6 happens to resolve.** "All three image forms are decomposable" is a property of a CHOSEN orthonormal eigenbasis, and the choice is not unique when two eigenvalues coincide, which is not hypothetical here, since [L178](../findings/diagonal-half.md#lemma-l178-every-weyl-tensor-of-lambda2-rank-at-most-three-has-thetalesqrt32-with-equality-exactly-at-w_mathbbcp2)'s equality case has spectrum $\tfrac1{\sqrt6}(2,-1,-1)$. Read literally, the case split "all decomposable, or some form non-decomposable" is a split on a choice rather than on $W$. **Section 6 makes the ambiguity inert**: no choice of orthonormal eigen-triple can be all-decomposable, so the non-decomposable branch holds for every choice.

## 6. Vacuity, the finding

**There is no configuration at all, and not merely none at $\dim V=6$.** The hypotheses of the decomposable branch, a rank-three $W\in\mathcal W_n$ whose three eigenforms $\omega_1,\omega_2,\omega_3$ are orthonormal, decomposable, with all $\lambda_i\ne0$, are unsatisfiable at every dimension. I give two routes; the first is one line of the record's own L180, the second uses nothing but idempotence and traces.

### 6a. The route the record already owns

[L180](../findings/diagonal-half.md#lemma-l180-ricci-flatness-is-a-signed-psd-identity-and-it-names-the-support)(3): at rank three the $\lambda_i$ are nonzero and sum to zero, so up to relabelling the sign pattern is $(+,+,-)$, and moving the minority term across gives $\mathop{\mathrm{supp}}\omega_1+\mathop{\mathrm{supp}}\omega_2=\mathop{\mathrm{supp}}\omega_3$; **the minority form's support is therefore $V$ itself.** In the all-decomposable branch every support is a plane, so $V=P_3$ and $\dim V=2$. But at $\dim V=2$ the space $\Lambda^2V$ is one-dimensional and the rank is at most one, which is L180(3)'s own reason for $\dim V\ge4$. **Contradiction, in one line, with no dimension hypothesis anywhere.**

### 6b. An independent route, free of the PSD range-sum import

L180(3) rests on "the range of a sum of PSD matrices is the sum of their ranges", sourced to [Fillmore–Williams](../references/fillmore-williams-1971-operator-ranges/). The following needs none of it. Write $\Pi_i$ for the three plane projections, so Ricci-flatness is $\sum_i\lambda_i\Pi_i=0$ and its trace is $2\sum_i\lambda_i=0$.

Set $A:=\lambda_2\Pi_2+\lambda_3\Pi_3=-\lambda_1\Pi_1$. Squaring the right-hand side, $A^2=\lambda_1^2\Pi_1^2=\lambda_1^2\Pi_1=-\lambda_1A$. Squaring the left,

$$A^2=\lambda_2^2\Pi_2+\lambda_3^2\Pi_3+\lambda_2\lambda_3\{\Pi_2,\Pi_3\},$$

so, using $\lambda_1=-\lambda_2-\lambda_3$ to rewrite $\lambda_2(\lambda_2+\lambda_1)=-\lambda_2\lambda_3$ and $\lambda_3(\lambda_3+\lambda_1)=-\lambda_2\lambda_3$,

$$\lambda_2\lambda_3\big(\{\Pi_2,\Pi_3\}-\Pi_2-\Pi_3\big)=0 .$$

Every $\lambda_i\ne0$, so $\{\Pi_2,\Pi_3\}=\Pi_2+\Pi_3$. Put $S:=\Pi_2+\Pi_3$; then $S^2=\Pi_2+\Pi_3+\{\Pi_2,\Pi_3\}=2S$, so $S$ is symmetric with spectrum in $\{0,2\}$ and $\mathop{\mathrm{tr}}S=4$ makes its $2$-eigenspace exactly two-dimensional. **And that eigenspace is $P_2\cap P_3$**: $\langle Sx,x\rangle=\lVert\Pi_2x\rVert^2+\lVert\Pi_3x\rVert^2\le2\lVert x\rVert^2$ with equality only when $\Pi_2x=x$ and $\Pi_3x=x$. So $\dim(P_2\cap P_3)=2$ and $P_2=P_3$. Feeding that back, $\lambda_1\Pi_1+(\lambda_2+\lambda_3)\Pi_2=0$ with $\lambda_2+\lambda_3=-\lambda_1\ne0$ gives $\Pi_1=\Pi_2$, hence

$$P_1=P_2=P_3=:P .$$

**Then all three $\omega_i$ lie in $\Lambda^2P$, which is one-dimensional, and three orthonormal vectors do not fit in a line.** $\square$

**The mechanism is the same one L184 names** (*the hypotheses force $\omega_i=\pm\omega_1$, which three orthonormal forms cannot satisfy*), reached here without $\dim V=6$, without the case split on $A$'s spectrum, and without the `HYPOTHESIS-DEBT` identity $\star_V(J\wedge J)=2\epsilon_JJ$.

### 6c. Argued the opposite, three ways

- *"The emptiness proof smuggles in $\dim V=6$."* It does not: sections 6a and 6b use no dimension hypothesis, only $\mathop{\mathrm{rank}}\Pi_i=2$, $\Pi_i^2=\Pi_i$ and $\lambda_i\ne0$. The trace step gives $\sum_i\lambda_i=0$ from Ricci-flatness alone.
- *"The method is too strong, it would empty everything."* It would not, and the boundary is exact. **At four planes such dependencies exist**: in $\mathbb R^4$, $\Pi_{\langle e_1,e_2\rangle}+\Pi_{\langle e_3,e_4\rangle}=\mathrm{Id}=\Pi_{\langle e_1+e_3,\,e_2+e_4\rangle}+\Pi_{\langle e_3-e_1,\,e_4-e_2\rangle}$, a fully supported dependence with $\lambda=(1,1,-1,-1)$. So the emptiness is a rank-three fact, matching L180's own "(3) is a rank-three statement and not the first case of a pattern".
- *"Then some known rank-three Weyl tensor must be a counterexample."* The one the record carries is padded $W_{\mathbb{CP}^2}$, whose eigenforms span $\Lambda^+$; a self-dual $2$-form satisfies $\omega\wedge\omega=\lVert\omega\rVert^2\mathrm{vol}\ne0$ and is therefore **non-decomposable**. It corroborates the emptiness rather than contradicting it, and it is why the surviving branch of [I38](../plan.md) is the non-decomposable one.

### 6d. What this does to the claim

**The claim as posed is true, and true for a reason strictly stronger than the one given.** Its conclusion "$\dim V\le5$ in the all-decomposable case" holds vacuously, there is no all-decomposable case. So:

- **L185's argument is valid and its conclusion stands**; nothing in sections 1–4 is wrong, and the verdict is not a refutation.
- **The framing understates.** "The decomposable case is bounded at six" and its repair "cannot span six, so $\dim V\le5$" both leave a reader expecting a surviving decomposable configuration at $\dim V=4$ or $5$. There is none. The row the record should carry is **the all-decomposable branch of I38 is EMPTY**, which retires the branch outright.
- **The record's own sentence that L185 sets out to correct ("THAT EXCLUDES ORTHOGONALITY AND NOT $\dim V=6$"), is correct as a criticism of the orthogonality argument and is superseded on the substance.** What excludes $\dim V=6$ there is not orthogonality and not independence either; it is that the branch is empty before dimension is mentioned.

**Impact on what is built on it.** [L183](../findings/diagonal-half.md#lemma-l183-a-rank-three-weyl-tensor-is-an-orthonormal-triple-whose-images-are-collinear) puts every rank-three tensor into "all coincide" or "distinct and collinear" for $\Phi(\omega)=(\omega^2,\omega\wedge\omega)$. In the decomposable branch $\Phi(\omega_i)=(-\Pi_i,0)$, and section 6 says $\Pi_1=\Pi_2=\Pi_3$, so the branch sits inside L183's coincident case, but **not** inside [L184](../findings/diagonal-half.md#lemma-l184-the-coincident-case-at-dim-v6-is-empty), which needs $A$ positive definite on a six-dimensional $V$ and here has $A=\Pi_1$ of rank two. The contradiction is the cheaper one, $\dim\Lambda^2P=1$. **So this closes a sliver L184 does not reach, and closes it at every $n$.**

## 7. The two screens

**Screen 1, the Lean.** `lake env lean HamiltonsCubic/Results/L185Statement.lean` returns exit $0$ with no output, and the file contains no `sorry`. I read `lam_eq_zero_of_rangeIndependent` line by line before running it: `hfix` uses `hidem` to put each summand in its own range, `hzero` applies `hsum` to $v$, and `hind` then kills $\lambda_i\cdot v$ with $v\ne0$. **The theorem is correct and is what its docstring says.** It also assumes less than the geometry supplies (only idempotence, never symmetry) so it is genuinely a statement about projections rather than planes, as the file claims.

**Screen 2, the emptiness.** Seconds of floating-point arithmetic on five plane triples I constructed by hand (orthogonal $2+2+2$; three planes pairwise meeting in a line; two planes equal; one arbitrary triple; three members of the $\theta$-family of section 6c), computing the Gram matrix $G_{ij}=\mathop{\mathrm{tr}}(\Pi_i\Pi_j)$ whose kernel is exactly the space of dependences, since $\lVert\sum_i\lambda_i\Pi_i\rVert_F^2=\lambda^{\mathsf T}G\lambda$. $G$ came back nonsingular on every triple except the one with two equal planes, whose kernel is $(1,-1,0)$, a dependence with a zero entry, which the hypothesis $\lambda_i\ne0$ excludes. **Reported as a screen of section 6, evidence for nothing; the emptiness rests on 6a and 6b, both closed form.**

## 8. Where L185 sits in the record

**It sits nowhere yet.** `L185` appears in no file under [findings/](../findings/), not in [results.md](../results.md), not in [plan.md](../plan.md) and not in [lean/INDEX.md](../lean/INDEX.md), [L185Statement.lean](../lean/HamiltonsCubic/Results/L185Statement.lean) is committed and unindexed. Whatever is folded in should be section 6d's row and not the six-dimensional one, and the Lean file's narrative paragraph ("They cannot, and orthogonality is not what rules it out") wants the same correction: **the sharper answer is that there is nothing there to rule out.**

## 9. The falsifier

**The object that would refute the claim is a triple $(\omega_1,\omega_2,\omega_3)$ of orthonormal decomposable $2$-forms on $\mathbb R^n$ with nonzero reals $\lambda_1,\lambda_2,\lambda_3$ satisfying $\sum_i\lambda_i\,\omega_i\omega_i^{\mathsf T}=0$ and $\dim(P_1+P_2+P_3)=6$**, equivalently, three rank-two orthogonal projections in linear dependence with all three coefficients nonzero and independent ranges.

**What I did to look for it.** No search: the standing rule forbids one and none was needed. I reduced the object to a linear-algebra normal form and closed it in the negative twice (once through the record's own L180(3), once through the anticommutator identity of section 6b) and each closure proves more than the falsifier's absence at $\dim V=6$: **no such triple exists at any dimension, independent or not.** I then checked that the argument has a real boundary rather than being an artefact, by exhibiting the four-plane dependence of section 6c in closed form, and that the record's one concrete rank-three tensor lands on the non-decomposable side. The only compute spent was the two screens of section 7.

## Verdict

**CONFIRMED.** Every step of the chain is correct, step 2 exactly, step 3 exactly and with the record's own normalisation, step 5 by the equality case of a subadditivity, step 6 by the definition of directness, and the Lean theorem is sound, typechecked and `sorry`-free.

**With one correction, on reach rather than on truth.** The hypotheses are unsatisfiable, so the conclusion $\dim V\le5$ is vacuously true and two dimensions too weak: the all-decomposable branch of [I38](../plan.md) is empty at every $\dim V$, by one line of [L180](../findings/diagonal-half.md#lemma-l180-ricci-flatness-is-a-signed-psd-identity-and-it-names-the-support)(3) and independently by section 6b. **Record the emptiness, not the bound**, and keep the abstract Lean theorem, which is a general fact about weighted projections with independent ranges and stands whatever the geometry does.
