# Gate 2 review, reviewer r799, can three decomposable image forms span six dimensions?

**Cold brief.** I worked from the coordinator's brief and read [L185Statement.lean](../lean/HamiltonsCubic/Results/L185Statement.lean) line by line, then [Lemma L178](../findings/diagonal-half.md#L614), [Lemma L179](../findings/diagonal-half.md#L636) and [Lemma L180](../findings/diagonal-half.md#L652) in full, and the conventions they are read in, [inner2](../lean/HamiltonsCubic/Base/WeylReal.lean#L39), [Ric](../lean/HamiltonsCubic/Base/WeylReal.lean#L106), [areaForm](../lean/HamiltonsCubic/Base/SelfDual.lean#L200) and [areaForm_sq_of_orthonormal](../lean/HamiltonsCubic/Base/SelfDual.lean#L292). **The programme is on an analysis-only footing and I opened no search, sweep, census or falsifier hunt.** One screen was run (an elaboration of the file under review, reported as a screen in §6) and no positive claim here rests on it. Log: [agent_logs/g2-l185-r799.log](../agent_logs/g2-l185-r799.log).

## The claim table

| # | Claim attacked | Verdict |
| --- | --- | --- |
| 1 | Step 2, Ricci-flatness is $\sum_i\lambda_i\omega_i\omega_i^{\mathsf T}=0$ | **CONFIRMED EXACTLY, factor $1$**, [Ric](../lean/HamiltonsCubic/Base/WeylReal.lean#L106) contracts through [inner2_phi](../lean/HamiltonsCubic/Base/WeylReal.lean#L67), whose two minus signs cancel; the $\tfrac12$ of [inner2](../lean/HamiltonsCubic/Base/WeylReal.lean#L39) is consumed by the ordered-pair sum and leaves no constant |
| 2 | Step 3, $\omega\omega^{\mathsf T}=\Pi$ for a unit decomposable form | **CONFIRMED EXACTLY under this record's $\tfrac12$, and already machine-checked**, [areaForm_sq_of_orthonormal](../lean/HamiltonsCubic/Base/SelfDual.lean#L292) is $\varepsilon^2=-\Pi$; a constant would have changed nothing anyway, being the same constant at all three unit forms |
| 3 | Step 5 ($\dim(P_1+P_2+P_3)=6$ forces directness | **CONFIRMED**), two planes meeting put the span at $\le5$, so equality in $\dim\sum P_i\le\sum\dim P_i$ is exactly directness |
| 4 | Step 6 (the decomposition of $0$ is unique | **CONFIRMED**), it is the definition of the direct sum, and the three summands are placed in the three planes correctly |
| 5 | The scope, is "all three decomposable" stated? | **CONFIRMED AS STATED, with one omission from the file's own list**, the counting bridge $\dim V=6\Rightarrow$ [RangeIndependent](../lean/HamiltonsCubic/Results/L185Statement.lean#L48) is a third untyped step and the file lists two |
| 6 | **Vacuity, is the hypothesis set inhabited?** | **REFUTED, IT IS EMPTY, BY [L180](../findings/diagonal-half.md#L652)(3), AND NOT AT SIX DIMENSIONS BUT AT THREE**, Ricci-flatness alone forces $P_1=P_2=P_3$, so the span is $2$; orthonormality then fails in the one-dimensional $\Lambda^2P$ |
| 7 | The headline "cannot span six dimensions" and the conclusion $\dim V\le5$ | **CONFIRMED AS TRUE, REFUTED AS THE STRONGEST AVAILABLE**, both hold, vacuously; the record proves the branch empty two lemmas earlier |
| 8 | The Lean docstring's account of what the base layer carries | **REFUTED IN TWO PARTICULARS**, the fact cited is [areaForm_mul_apply](../lean/HamiltonsCubic/Base/SelfDual.lean#L270) where the record has the exact statement as [areaForm_sq_of_orthonormal](../lean/HamiltonsCubic/Base/SelfDual.lean#L292), and the missing bridge is Gram–Schmidt in a plane rather than the real skew normal form |

## One-line summary

**Every step of the chain is sound and the theorem is true and machine-checked, but the geometric class it bounds is empty, by the record's own [L180](../findings/diagonal-half.md#L652)(3), so "cannot span six" is a vacuous truth about a case that Ricci-flatness closes at $\dim V=3$ and above.**

## 0. Conventions, fixed once

- The $\Lambda^2$ pairing is [inner2](../lean/HamiltonsCubic/Base/WeylReal.lean#L39), $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$. A $2$-form is a skew matrix; $\mathop{\mathrm{supp}}\omega$ is $\mathop{\mathrm{im}}\omega$.
- $\Pi_P$ is the orthogonal projection onto $P$. For $u,v$ orthonormal, [areaForm](../lean/HamiltonsCubic/Base/SelfDual.lean#L200) $u\wedge v$ has matrix $uv^{\mathsf T}-vu^{\mathsf T}$ up to the file's index order.
- A **screen** is seconds of elaboration on the file under review, reported as a screen.

## 1. Step 2 is exact in this record's own $\mathop{\mathrm{Ric}}$

**The brief warns that the pairing carries a $\tfrac12$ and asks whether that survives into $\mathop{\mathrm{Ric}}$. It does not, and the reason is that it is spent twice.**

[Ric](../lean/HamiltonsCubic/Base/WeylReal.lean#L106) is $\mathop{\mathrm{Ric}}(R)_{ab}=\sum_c\langle R(\varphi_{ac}),\varphi_{bc}\rangle$. For $R=\sum_i\lambda_i\,\omega_i\otimes\omega_i$ the operator is $R(X)=\sum_i\lambda_i\langle\omega_i,X\rangle\,\omega_i$, and [inner2_phi](../lean/HamiltonsCubic/Base/WeylReal.lean#L67) gives $\langle Y,\varphi_{ij}\rangle=-Y_{ij}$ at skew $Y$, *with the $\tfrac12$ already absorbed, since $\varphi_{ij}$ has two nonzero entries.* So

$$\mathop{\mathrm{Ric}}(R)_{ab}=\sum_c\sum_i\lambda_i\big(-(\omega_i)_{ac}\big)\big(-(\omega_i)_{bc}\big)=\Big(\sum_i\lambda_i\,\omega_i\omega_i^{\mathsf T}\Big)_{ab}.$$

**The two minus signs cancel and no constant is left**, matching [L180](../findings/diagonal-half.md#L652)(1) exactly. *Step 2 is confirmed against the record's own definition and not against a remembered formula, which is what the brief asked for.*

## 2. Step 3 is exact, and a factor would have been inert in any case

**Two things had to be separated here: whether the constant is $1$, and whether it could have mattered.**

*The constant is $1$.* A unit decomposable $\omega$ is $u\wedge v$ with $u,v$ orthonormal, Gram–Schmidt inside the plane gives $a\wedge b=\lvert a\rvert\,\lvert b-\langle b,u\rangle u\rvert\,u\wedge v$ with a positive factor, which unit norm pins to $1$ once $\lVert u\wedge v\rVert=1$, and [inner2_areaForm_self_of_orthonormal](../lean/HamiltonsCubic/Base/SelfDual.lean#L257) is that norm. Then $\omega^2=-(uu^{\mathsf T}+vv^{\mathsf T})=-\Pi$, which is [areaForm_sq_of_orthonormal](../lean/HamiltonsCubic/Base/SelfDual.lean#L292), **already in the record and already machine-checked**. Hence $\omega\omega^{\mathsf T}=-\omega^2=\Pi$.

*And it could not have mattered.* Had the pairing been plain Frobenius, every unit $\omega_i$ would carry the **same** positive constant $c$, so $\sum_i\lambda_i\,c\,\Pi_i=0$ and $\sum_i\lambda_i\Pi_i=0$ are the same equation. **The brief's "changes nothing or changes everything" resolves as: nothing**, *and the reason is uniformity across $i$, which unit norm supplies and which would fail if the three forms were normalised differently.*

## 3. Steps 5 and 6 hold, and the meeting-planes case is the wrong place to look

$\dim(P_1+P_2+P_3)\le\dim P_1+\dim P_2+\dim P_3=6$ always, with equality **exactly** when the sum is direct. *The brief's "consider the planes meeting" is the contrapositive and confirms rather than breaks the step*: if $P_1\cap P_2\ne0$ then $\dim(P_1+P_2)\le3$ and the total span is at most $5$, so a meeting pair is already outside the hypothesis. **Step 6 is then the definition of a direct sum**, and the three summands $\lambda_1x$, $\lambda_2\Pi_2x$, $\lambda_3\Pi_3x$ are correctly placed in $P_1$, $P_2$, $P_3$, the first because $x\in P_1$, the other two because $\mathop{\mathrm{im}}\Pi_i=P_i$.

**Nothing in the chain uses orthogonality of the planes, the first Bianchi identity, or the rank**, exactly as the file claims, and the Lean statement is right to be about idempotents and independent ranges rather than about planes.

## 4. The finding, the class is empty, and $\dim V=6$ is not where it fails

**Located.** The file's reading paragraph, [lines 17–23](../lean/HamiltonsCubic/Results/L185Statement.lean#L17), and its closing sentence *"a rank-three Weyl tensor with three decomposable image forms has `dim V ≤ 5`"*.

**Exhibited, in closed form, using no hypothesis the file does not already grant.** Let $W=\sum_{i=1}^3\lambda_i\,\omega_i\otimes\omega_i$ be a rank-three Weyl tensor with $\omega_i$ orthonormal, every $\lambda_i\ne0$, and every $\omega_i$ decomposable with plane $P_i$. Step 4 of the chain gives $\lambda_1\Pi_1+\lambda_2\Pi_2+\lambda_3\Pi_3=0$. Taking the trace gives $2\sum_i\lambda_i=0$, so the signs are mixed; relabel to $(+,+,-)$, the pattern $(+,-,-)$ being the same argument with the roles exchanged. Then

$$\lambda_1\Pi_1+\lambda_2\Pi_2=\lvert\lambda_3\rvert\,\Pi_3,$$

a sum of positive semidefinite matrices with positive coefficients equal to a positive semidefinite matrix. **For PSD $A,B$ one has $\ker(A+B)=\ker A\cap\ker B$**, since $x^{\mathsf T}(A+B)x=0$ forces both terms to vanish and a PSD matrix kills its own null quadratic form; taking orthogonal complements, $\mathop{\mathrm{range}}(A+B)=\mathop{\mathrm{range}}A+\mathop{\mathrm{range}}B$. *This is the same fact [L180](../findings/diagonal-half.md#L652)(3) imports from [Fillmore–Williams](../references/fillmore-williams-1971-operator-ranges/), here in two lines because the matrices are finite and symmetric.* So

$$P_1+P_2=P_3,$$

and $P_3$ is two-dimensional, so $P_1=P_2=P_3=:P$. **All three forms then lie in $\Lambda^2P$, which is one-dimensional, and three orthonormal vectors do not fit in a line.** $\square$

**So the hypotheses of L185's geometric instance are contradictory, and $\dim V=6$ is not the width at which they fail, every width above $2$ fails, and $2$ fails on orthonormality.** *Read through [L180](../findings/diagonal-half.md#L652)(3) the same conclusion is one line: that lemma says $V$ is the minority-sign form's support, which under decomposability is a plane, against its own $\dim V\ge4$.*

**Argued the opposite, which is where the finding stops short of a refutation.** *Vacuous truth is truth*: the theorem is not wrong, the six steps are not wrong, and "three decomposable image forms cannot span six dimensions" is a true sentence. Three further readings favour the file:

- **It closes the clause it says it closes.** [L179](../findings/diagonal-half.md#L636)'s box ends *"THAT EXCLUDES ORTHOGONALITY AND NOT $\dim V=6$"*, and that clause is now closed. The box is where a later reader would look, and it does not currently point at [L180](../findings/diagonal-half.md#L652)(3).
- **It is independent of the imported range fact.** L185 uses linear independence and nothing else, so it does not inherit [Fillmore–Williams](../references/fillmore-williams-1971-operator-ranges/) or the three steps [L180](../findings/diagonal-half.md#L652)(3) had to name at audit. *A second route that shares no hypothesis with the first is worth having even when it proves less.*
- **The abstract theorem is not vacuous.** As a statement about idempotents with independent ranges it has content and satisfiable hypotheses; only its three-plane instance is empty.

**What the finding therefore is: a correction to the framing, not to the mathematics.** The file's *"The question this closes"* is accurate about the clause and silent about the fact that the branch was already empty, and a reader taking $\dim V\le5$ as the state of the decomposable case would be reading a strictly weaker fact than the record holds. *A remark of two sentences repairs it, and [L179](../findings/diagonal-half.md#L636)'s box is the place that most needs one, since it still frames $\dim V\le6$ as the decomposable case's bound.*

## 5. Two smaller corrections, both concrete

**The untyped list is one item short.** [Lines 28–34](../lean/HamiltonsCubic/Results/L185Statement.lean#L28) name two things not typed, $\omega\omega^{\mathsf T}=\Pi$, and that rank three forces decomposability. **A third is missing: the counting bridge from $\dim(P_1+P_2+P_3)=6$ to [RangeIndependent](../lean/HamiltonsCubic/Results/L185Statement.lean#L48).** *The docstring asserts it ("forced by counting, `2 + 2 + 2 = 6`") and the theorem takes it as a hypothesis, so the file's own accounting of what is asserted rather than checked omits the step that carries the geometry into the algebra.* It is elementary, which is why it was asserted; it is not typed, which is what the list is for.

**The base-layer citation names the wrong lemma and overstates the gap.** The docstring says [areaForm_mul_apply](../lean/HamiltonsCubic/Base/SelfDual.lean#L270) *"is that fact for `areaForm`"* and that *"the bridge from a general decomposable `ω` to an `areaForm` is the real skew normal form, which the layer does not carry"*. Two corrections: the exact fact is [areaForm_sq_of_orthonormal](../lean/HamiltonsCubic/Base/SelfDual.lean#L292), $\varepsilon^2=-\Pi$, which the layer **does** carry, [areaForm_mul_apply](../lean/HamiltonsCubic/Base/SelfDual.lean#L270) is the general entrywise product it is proved from; and the bridge needed is **Gram–Schmidt inside the plane**, as in §2, since a decomposable $\omega=a\wedge b$ has its plane in front of it. *The real skew normal form is the tool for an arbitrary $2$-form, and naming it here prices a two-line step as a missing structure theorem.*

## 6. The screen

**One screen, reported as a screen.** [L185Statement.lean](../lean/HamiltonsCubic/Results/L185Statement.lean) elaborates under `lake env lean` at `leanprover/lean4:v4.33.1`, exit $0$, no `sorry` and no warning. *This says the kernel accepts the abstract theorem; it says nothing about whether the theorem is the record's claim, which is §§1–5.*

## 7. The falsifier

**The object that would break the claim.** Three planes $P_1,P_2,P_3\subseteq\mathbb R^n$ with $\dim(P_1+P_2+P_3)=6$, unit area forms $\omega_1,\omega_2,\omega_3$ orthonormal in $\Lambda^2$, and nonzero reals $\lambda_1,\lambda_2,\lambda_3$ with $\sum_i\lambda_i\Pi_i=0$. *Its abstract shadow would be a family of idempotents with independent ranges, weights summing to zero in the matrix sense, and some weight nonzero on a nonzero range.*

**What I did to look for it.** No search and no numerics. The abstract shadow is refuted by the file's own proof, which the kernel accepts. The geometric object is refuted analytically, and more strongly than asked: the PSD-range argument of §4 shows that **every** solution of $\sum_i\lambda_i\Pi_i=0$ with $\lambda_i\ne0$ and $\Pi_i$ of rank two has $P_1=P_2=P_3$, so the span is $2$ and never $6$, *and then orthonormality fails independently, in the one-dimensional $\Lambda^2P$.* **There is nothing to find at six dimensions because there is nothing to find at three.**

## Verdict

**CONFIRMED.** *The claim is true, its six steps are individually sound against this record's own $\mathop{\mathrm{Ric}}$ and $\Lambda^2$ pairing, and the Lean theorem is the right abstraction of it.*

**Corrections owed, in order of weight:**

1. **Record that the all-decomposable branch is empty outright**, by [L180](../findings/diagonal-half.md#L652)(3), and that L185's $\dim V\le5$ is therefore a vacuous truth about it. *The two sentences belong in [L179](../findings/diagonal-half.md#L636)'s box, which still presents $\dim V\le6$ as the decomposable case's bound, and in [L185Statement.lean](../lean/HamiltonsCubic/Results/L185Statement.lean)'s opening paragraph.*
2. **Add the counting bridge to the file's "What is NOT typed here" list.**
3. **Cite [areaForm_sq_of_orthonormal](../lean/HamiltonsCubic/Base/SelfDual.lean#L292) rather than [areaForm_mul_apply](../lean/HamiltonsCubic/Base/SelfDual.lean#L270), and name the missing bridge as Gram–Schmidt in a plane rather than the real skew normal form.**

**What is untouched.** *I38's non-decomposable branch (at least one image form of support four or more), is where the question actually lives, and neither L185 nor this finding reaches it.*
