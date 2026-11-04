# Review r602, Lemma L45, off the slice: five surviving triples, and one new coupling

**Reviewer B of an independent pair on identical briefs. Target: [findings/target.md](../findings/target.md) line 694, `#### Lemma L45, off the slice: five surviving triples, and one new coupling`. Analysis only; no computation was run and none was needed.**

## Verdict

**CONFIRMED, every mathematical assertion of L45 holds, and I rebuilt all of it by hand.** Four record defects sit around it, none of them in the mathematics:

| # | defect | severity |
| --- | --- | --- |
| 1 | The provenance note's pointer is **false**. The named section holds none of this, and the argument is not in [target.md](../findings/target.md) at all, it is in [problem.md](../findings/problem.md), lines 76–94 | **the seventh such note, and it is false** |
| 2 | [results.md](../results.md) line 288 says the survivors carry "multiplicities $1,3,3,6$". They carry $1,3,1,3,1$, which is what its own displayed formula in the same sentence shows. No survivor has multiplicity $6$ | wrong number on the record |
| 3 | The [target.md](../findings/target.md) block drops the attribution its source carries: the expansion is **Xu Lemma 2.8, eq. (2.34), attributed there to Huisken**. [problem.md](../findings/problem.md) says so at length and [results.md](../results.md) says "the expansion is Huisken's, term for term"; the block cites nobody | priority, in a record whose ledger tracks this exact failure |
| 4 | The block drops the scope caveat. [results.md](../results.md): "It is a bookkeeping identity for the general criterion and proves no case of the conjecture by itself." The block presents the two-sided bound with no such line | overclaim by omission |

And one convention gap that is upstream of all of it: **$\Phi$ is defined nowhere in [findings/](../findings/)**, while the letter carries two other unrelated objects in the same folder.

---

## 1. The pointer

**False, and the argument is in a different file.**

The named section is [target.md](../findings/target.md) line 68, `#### What fence post F29 closes, and what it leaves open`. Read end to end it is seven lines about $\lambda\le\mu_{\max}(K)$ in a fixed frame, about upgrading the scalar vertex-equation statement to $K^2-\lambda K\succeq0$ with a general test vector, and about the bottom eigenvector giving the vacuous $\lambda\ge\mu_{\min}$. It contains no $R=cI+Y+W$, no $\Phi$, no $\Omega_0$, no triple and no parity argument. It cannot prove L45 because it is not about L45's objects.

Nor is the argument anywhere else in that file. The only two lines in all of [target.md](../findings/target.md) carrying `cI+Y`, `R_{\mathrm{ric}_0}` or `\Omega_0` are the block's own 698 and 703.

**Where it actually lives**: [findings/problem.md](../findings/problem.md) lines 76–94, under **"OFF THE SLICE: exactly one new coupling, explicitly identified"** and **"The parity argument, and it is two-sided"**. That text is the block's text, near verbatim, plus the two things the block leaves behind, the Xu/Huisken attribution and the scope caveat.

**The history.** The mathematics entered [problem.md](../findings/problem.md) on 2026-08-26 in `49a8d3c6`, *feat(problem): the off-slice criterion has exactly one new coupling*. The [target.md](../findings/target.md) block was created on 2026-08-31 in `86621751`, *docs(findings): number the 24 results that only the report had numbered*, five days later and in a different file from its source. So the note's clause "the mathematics has always been in this file" is false twice over: it was never in this file, and it is five days old rather than always.

**Consequence beyond the note.** [INDEX-results.md](../findings/INDEX-results.md) line 60 files result 45 at [target.md](../findings/target.md). The result is a statement about the Böhm–Wilking cone criterion off the Einstein slice, which is [problem.md](../findings/problem.md)'s subject; [target.md](../findings/target.md) is the non-diagonal census file and contains nothing else on the cone. **The result is filed in the wrong file, and the false pointer is a symptom of that rather than a typo.**

## 2. The count: ten triples, five vanishing

**Confirmed, with the mechanisms.** $\Phi$ is symmetric bilinear, so $\Phi(R)=\sum_{i,j}\Phi(A_i,A_j)$ for $R=\sum A_i$ and $\langle R,\Phi(R)\rangle=\sum_{i,j,k}T(A_i,A_j,A_k)$ with $T(A,B,C)=\langle A,\Phi(B,C)\rangle$ totally symmetric ([BW08](../references/boehm-wilking-2008-space-forms/notes.md) eq. (5)). That is $3^3=27$ ordered triples collapsing onto $10$ multisets with multinomial multiplicities $1$ / $3$ / $6$.

Writing $A_1=cI$, $A_2=Y$, $A_3=W$:

| multiset | mult. | value | verdict and mechanism |
| --- | --- | --- | --- |
| $(I,I,I)$ | $1$ | $c^3(n-1)\lVert I\rVert^2$ | **survives**. $\Phi(I)=I^2+I^\#=I+(n-2)I=(n-1)I$ |
| $(I,I,Y)$ | $3$ | $3c^2(n-1)\langle Y,I\rangle$ | **vanishes**, orthogonality. $\Phi(I,I)\in\langle I\rangle$ and $Y\perp I$ |
| $(I,I,W)$ | $3$ | $3c^2(n-1)\langle W,I\rangle$ | **vanishes**, orthogonality, $W\perp I$. Equally $3c^2\langle I,\Phi(I,W)\rangle=0$ |
| $(I,Y,Y)$ | $3$ | $3c\langle I,\Phi(Y)\rangle$ | **survives**. Closed form below |
| $(I,Y,W)$ | $6$ | $6c\langle W,\Phi(I,Y)\rangle$ | **vanishes**, $\Phi(I,Y)\in\langle\mathrm{Ric}_0\rangle\perp\langle W\rangle$ (Xu (2)); or directly $\Phi(I,W)=0$ (Xu (3)) |
| $(I,W,W)$ | $3$ | $3c\langle I,Q(W)\rangle$ | **vanishes**, $\Phi(I,W)=0$, equivalently $Q(W)$ is Weyl so $Q(W)\perp I$ |
| $(Y,Y,Y)$ | $1$ | $\langle Y,\Phi(Y)\rangle$ | **survives** |
| $(Y,Y,W)$ | $3$ | $3\langle W,\Phi(Y)\rangle$ | **survives**, the new coupling |
| $(Y,W,W)$ | $3$ | $3\langle Y,Q(W)\rangle$ | **vanishes**, $\Phi$ preserves Weyl ([BW08](../references/boehm-wilking-2008-space-forms/notes.md) eq. (6)), so $Q(W)\perp Y$; or Xu (5) |
| $(W,W,W)$ | $1$ | $\langle W,Q(W)\rangle$ | **survives** |

**Five vanish, five survive.** Arithmetic check on the partition: vanishers carry $3+3+6+3+3=18$ ordered triples, survivors $1+3+1+3+1=9$, total $27$. Nothing is double-counted and nothing is dropped. The displayed $W$-even bracket carries the three survivors with no $W$ and the $W$-odd bracket the two with $W$; that is $3+2=5$, and it matches the table row for row.

**On the brief's question about the two $I$–$W$ pairings.** The brief expects two different reasons. **One reason covers three vanishers.** By total symmetry of $T$, $\Phi(I,W)=0$ kills $(I,I,W)$, $(I,Y,W)$ and $(I,W,W)$ simultaneously, since each has an $I$ and a $W$ that can be moved into $\Phi$'s two slots. $\Phi(I,W)=\tfrac12(IW+WI)+W\#I=W-W=0$ **is** $W\#I=-W$, which is [BW08](../references/boehm-wilking-2008-space-forms/notes.md) Lemma 2.1 with $\langle W\rangle$ in the kernel, so the record's two named facts are one fact, not two, and the block's "every $I$–$W$ pairing vanishes" is a single-mechanism claim that is correct.

Independent routes exist for each and I checked them: $(I,I,W)$ also falls to plain orthogonality of $W$ to $I$, and $(I,W,W)$ also falls to $\Phi$ preserving Weyl. **$(I,W,W)$ genuinely vanishes and is not absorbed into $\langle W,Q(W)\rangle$**, the two are distinct multisets with distinct multiplicities, and $\langle W,Q(W)\rangle$ carries multiplicity $1$, exactly the multiplicity of $(W,W,W)$ alone. Had $(I,W,W)$ been absorbed, the coefficient would read $1+3c\cdot(\ldots)$, and it does not.

The two vanishers **not** covered by the $I$–$W$ mechanism are $(I,I,Y)$ and $(Y,W,W)$. The block's prose says "the five that vanish **include** every $I$–$W$ pairing", which is honest (it claims containment, not exhaustion) but the block never names the other two, so the count as printed is asserted rather than shown. That is the brief's charge and it stands: **the count is correct and the block does not demonstrate it.**

**Corroboration that closes the count from outside.** Xu's eq. (2.34), quoted at [problem.md](../findings/problem.md) line 88, has exactly five terms, in bijection with my five survivors, with the multiplicities $1,3,3,1,1$ visible in its coefficients. A published identity with five terms and no sixth is a check on the vanishing set as a whole.

## 3. The new coupling's closed form

**Confirmed, $\tfrac3{n-2}$ and all.**

$T(W,Y,Y)=\langle W,\Phi(Y,Y)\rangle=\langle W,(\Phi(Y))_W\rangle$, since $W$ lies in the Weyl block and the decomposition $S^2_B=\langle I\rangle\oplus\langle\mathrm{Ric}_0\rangle\oplus\langle W\rangle$ is orthogonal. With $(\Phi(Y))_W=\tfrac1{n-2}(\mathrm{Ric}_0\wedge\mathrm{Ric}_0)_W$ this gives $T(W,Y,Y)=\tfrac1{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$, and the **term** in the cubic carries multiplicity $3$, hence $\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$.

**The factor $3$ is combinatorial and the convention in force is settled by the block's own display.** Its $(I,I,I)$ term is $c^3(n-1)\lVert I\rVert^2$ and its $(W,W,W)$ term is $\langle W,Q(W)\rangle$, both all-same multisets, both carrying coefficient $1$. That fixes the convention as "coefficient = multinomial multiplicity of the multiset", under which $(Y,Y,W)$ takes $3$. The display is internally consistent and the $3$ is right.

**Wording hazard.** The block says "the triple $(Y,Y,W)$, equal to $\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$". If "the triple" names the symmetric trilinear value $T(Y,Y,W)$, the constant is $\tfrac1{n-2}$; if it names the term of the expansion, it is $\tfrac3{n-2}$. The display's $3\langle W,\Phi(Y)\rangle$ shows the second is meant, but the sentence alone is ambiguous by exactly the factor the brief warned about.

**Two independent normalisation checks that the constant survives the crossing to Xu.**

- **$(I,I,I)$.** Xu's first term is $\tfrac n{2(n-1)}\bar\lambda^3$. Under $R_I=\tfrac{\bar\lambda}{n-1}I$, the record's term is $\big(\tfrac{\bar\lambda}{n-1}\big)^3(n-1)\cdot\tfrac{n(n-1)}2=\tfrac{n\bar\lambda^3}{2(n-1)}$, identical. So Xu's $\bar\lambda$ is the record's $c(n-1)$, which is $\theta_0(n)$ on $\partial\Omega_0$, and **the two $Q$'s have the same normalisation**. The $\tfrac3{n-2}$ therefore transfers verbatim.
- **$(I,Y,Y)$.** I get this one in closed form without either source. [BW08](../references/boehm-wilking-2008-space-forms/notes.md) Lemma 2.1 makes $\#I$ act by $\tfrac{n-4}2$ on $\langle\mathrm{Ric}_0\rangle$, so $\Phi(I,Y)=\tfrac12(IY+YI)+Y\#I=Y+\tfrac{n-4}2Y=\tfrac{n-2}2Y$ and hence $$\langle I,\Phi(Y)\rangle=T(I,Y,Y)=\tfrac{n-2}2\lVert Y\rVert^2,$$ making the term $3c\cdot\tfrac{n-2}2\lVert Y\rVert^2$. Xu's is $\tfrac3{2(n-1)}\bar\lambda\lvert\mathrm{Ric}_0\rvert^2=\tfrac{3c}2\lvert\mathrm{Ric}_0\rvert^2$. The two agree exactly when $\lvert\mathrm{Ric}_0\rvert^2=(n-2)\lVert Y\rVert^2$, and [problem.md](../findings/problem.md) line 38 gives $\lVert\mathrm{ric}\rVert^2=\tfrac{n-1}2\lVert R_I\rVert^2+\tfrac{n-2}4\lVert R_{\mathrm{ric}_0}\rVert^2$, i.e. $\lvert\mathrm{ric}_0\rvert^2=\tfrac{n-2}4\lVert Y\rVert^2$ in Beitz's normalisation, and **Xu's $\mathrm{Ric}$ is twice Beitz's $\mathrm{ric}$**, so $\lvert\mathrm{Ric}_0\rvert^2=4\cdot\tfrac{n-2}4\lVert Y\rVert^2=(n-2)\lVert Y\rVert^2$. Exact agreement, factor of $4$ included.

**Where the real convention risk sits, and it is not the $3$.** $\wedge$ is bilinear, so $\mathrm{Ric}_0\wedge\mathrm{Ric}_0$ scales by $4$ between the BW08/Xu and Beitz Ricci normalisations. **The constant $\tfrac3{n-2}$ is right in BW08's/Xu's and would read $\tfrac{12}{n-2}$ in Beitz's.** The record is in BW08's, consistently, but [conventions.md](../findings/conventions.md) tables neither the Ricci normalisation nor $\wedge$, and the only place the factor-two-in-$\mathrm{ric}$ hazard is written down is [problem.md](../findings/problem.md), a dozen lines above the source paragraph and in a different file from the block. **A reader of L45 in [target.md](../findings/target.md) has no way to fix the scale of $\mathrm{Ric}_0$ from the record.**

**One input the record does not hold.** $(\Phi(Y))_W=\tfrac1{n-2}(\mathrm{Ric}_0\wedge\mathrm{Ric}_0)_W$ is cited to **BW08 Lemma 2.2**, and [references/boehm-wilking-2008-space-forms/notes.md](../references/boehm-wilking-2008-space-forms/notes.md) transcribes Lemma 2.1 and equation (6) but **not** Lemma 2.2, the string does not occur in the notes or the README. I did not open the stored PDF to settle it, because the coefficient is independently pinned by Xu's published (2.34) at the normalisation I verified above. **The claim is safe; its named citation is untranscribed.**

## 4. The reflection argument

**Confirmed on all three sub-questions.**

**Parity bookkeeping, correct, including the term the brief flagged.** Under $W\mapsto-W$: the three even terms contain no $W$ at all, so they are fixed trivially. $3\langle W,\Phi(Y)\rangle$ is linear in $W$, so it negates. And $\langle W,Q(W)\rangle$ **is** odd: $Q(-W)=(-W)^2+(-W)^\#=W^2+W^\#=Q(W)$ is even, but the pairing carries one more factor of $W$, so $\langle -W,Q(-W)\rangle=-\langle W,Q(W)\rangle$. The cubic is homogeneous of degree $3$ in $R$, so every term is odd or even in $W$ according to its $W$-degree $3,1$ or $0,2$, and here the $W$-degree-$2$ triples, $(I,W,W)$ and $(Y,W,W)$, are precisely two of the five vanishers, which is why the split is clean two-way rather than a genuine four-way grading. **That is the structural reason the reflection works at all, and the block does not say it.**

**The $\Omega_0$ premise, holds, and it needs the boundary version.** $\Omega_0=\{\mathop{\mathrm{scal}}(R)>0\}\cap\{\tfrac{n-2}n\lVert R_W\rVert^2\le\lVert R_I\rVert^2\}$. The inequality sees $W$ only through $\lVert W\rVert$; and $\mathop{\mathrm{scal}}$ annihilates both $\langle W\rangle$ and $\langle\mathrm{Ric}_0\rangle$, so $\mathop{\mathrm{scal}}(cI+Y+W)=\mathop{\mathrm{scal}}(cI)$ is $W$-independent outright. **Both clauses are $W$-even, so the premise is true and the reflection is valid.** I found no dependence on $W$ beyond its norm.

One imprecision: the criterion is demanded at points of $\partial\Omega_0$, and the block asserts only $cI+Y-W\in\Omega_0$. The stronger statement is equally true (the boundary equation $\tfrac{n-2}n\lVert W\rVert^2=\lVert R_I\rVert^2$ is $W$-even too) but it is the one the argument uses and the block states the weaker one. Smoothness at the reflected point is also fine: $\mathrm{ric}(R)\ne0$ since $c>0$, so $F$ is defined and differentiable there.

**The parity of the right-hand side, which the block treats in one clause and which is the step that makes the split two-sided.** Invariance is $G(R)=dF_R(\Phi(R))\le0$, and the quotient rule on $F=\lVert R\rVert^2/\lVert\mathrm{ric}(R)\rVert^2$ turns it into $$\underbrace{\langle R,\Phi(R)\rangle}_{\mathrm{LHS}}\ \le\ \underbrace{F(R)\,\langle\mathrm{ric}(R),\mathrm{ric}(\Phi(R))\rangle}_{\mathrm{RHS}}.$$ On the right, $\mathrm{ric}(R)=\mathrm{ric}(cI+Y)$ is $W$-independent and $F(R)$ is $W$-even. Of $\Phi(R)$'s $W$-dependent blocks, $2\Phi(cI,W)=0$ and $\Phi(W,W)=Q(W)$ has $\mathrm{ric}=0$, so **the only $W$-dependent piece of $\mathrm{ric}(\Phi(R))$ is $2\,\mathrm{ric}(\Phi(Y,W))$, which is $W$-odd and lands in $\langle\mathrm{Ric}_0\rangle$ by Xu (5)**. The block's clause is right, and the two reasons it needs ($\Phi(I,W)=0$ and $Q(W)$ Weyl), are the same two that killed $(I,W,W)$ and $(Y,W,W)$ on the left.

Then, with $E:=\mathrm{RHS}_{\rm even}-\mathrm{LHS}_{\rm even}$ and $D:=\mathrm{LHS}_{\rm odd}-\mathrm{RHS}_{\rm odd}$, the criterion at $+W$ reads $D\le E$ and at $-W$ reads $-D\le E$, so $\lvert D\rvert\le E$. **The displayed inequality is exactly right.**

**The direction.** $E\ge0$ is not an extra hypothesis and does not need checking: $\lvert D\rvert\le E$ forces it. Equivalently, adding the two criteria gives $\mathrm{LHS}_{\rm even}\le\mathrm{RHS}_{\rm even}$ directly. **So the inequality is never vacuous in the sign sense wherever it holds**, but that is because it is derived *from* invariance rather than toward it. There is no configuration where $E<0$ and the inequality fails; if $E<0$ at some boundary point then invariance itself fails there, which is the $4\le n\le11$ regime and already known by [L44](../findings/problem.md)'s witness.

## 5. What it buys

**It names the debt; it does not pay it.** Stated in the terms the brief asks for:

- **What it licenses beyond the on-slice statement.** Nothing yet provable. Off the slice the $a=0$ criterion is *not* $P(W)\le\theta_0(n)$: $\langle W,Q(W)\rangle$ is one of two terms in an odd part that must be bounded on both sides against an even part. The Lemma's content is that the off-slice criterion has exactly **one** new coupling (a finiteness statement about how much worse the general case is than the slice) and that the coupling is explicit.
- **Is the extra coupling controlled, or merely named?** **Merely named.** $\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$ is written in closed form and bounded by nothing. No estimate for it appears in the block, in [problem.md](../findings/problem.md), or in [results.md](../results.md).
- **Can the inequality be used?** **Not as it stands, and the obstruction is on the even side rather than the sign.** $\mathrm{LHS}_{\rm even}$ is fully explicit, $c^3(n-1)\lVert I\rVert^2+\tfrac{3c(n-2)}2\lVert Y\rVert^2+\langle Y,\Phi(Y)\rangle$, using my closed form from §3, but $\mathrm{RHS}_{\rm even}=F(R)\langle\mathrm{ric}R,\mathrm{ric}\Phi(R)\rangle_{\rm even}$ is expanded nowhere on the record. **Until it is, $E$ is an unevaluated symbol and $\lvert D\rvert\le E$ constrains nothing numerically.** [problem.md](../findings/problem.md) line 92 says as much: what a general-$R_{\mathrm{ric}_0}$ proof still owes is a bound on $\mathrm{LHS}_{\rm odd}-\mathrm{RHS}_{\rm odd}$.
- **It is a consequence of the conjecture, not a step toward it.** Both halves of the derivation assume the criterion holds at the two boundary points. Using $\lvert D\rvert\le E$ as an input to proving invariance would be circular.
- **The two-sidedness adds nothing on the slice, and the reason is structural.** At $Y=0$ it reads $\lvert P(W)\rvert\le c(n-1)\lVert W\rVert^2$. But $\mathcal W_n$ is a linear space and $P(-W)=-P(W)$, so "$P\le\theta_0$ for every unit Weyl $W$" already contains "$P\ge-\theta_0$". The reflection recovers the bridge exactly (the record's own consistency check) and recovers nothing more. **Off the slice the same objection has less force**, because $Y$ is held fixed while $W$ flips, so the pair of inequalities does couple two genuinely different boundary points; but the content is still a rearrangement of the criterion at points it already quantifies over.

## Hedging clauses checked

| clause | conceals something? |
| --- | --- |
| "the mathematics **has always been** in this file" | **yes**, false on both counts, see §1 |
| "five of the ten distinct triples **vanish**" | no, true, and I enumerated all ten |
| "**Against the slice** exactly one new coupling appears" | no, $(Y,Y,W)$ is the unique multiset present here and absent at $Y=0$, and the other two $Y$-triples, $(I,Y,Y)$ and $(Y,Y,Y)$, also vanish on the slice but are $W$-even and so are not couplings to $W$. The wording is exact |
| "**every** $I$–$W$ pairing vanishes" | no, true, and one mechanism covers all three |
| "the $\Omega_0$ constraint depends **only** on $\lVert W\rVert$" | no, both defining clauses verified $W$-even |
| "**demanding** the criterion at both signs gives" | mild, "demanding" hides that this assumes the conclusion; the bound is necessary-condition bookkeeping. [results.md](../results.md) says so, the block does not |

## Pointers

| pointer | resolves? |
| --- | --- |
| "the argument is in this file under *What fence post F29 closes…*" | **no**, §1 |
| [BW08](../references/boehm-wilking-2008-space-forms/notes.md) Lemma 2.1, eq. (5), eq. (6) | yes, all three transcribed in the notes |
| **BW08 Lemma 2.2** (cited from [problem.md](../findings/problem.md) line 76 for the $\tfrac1{n-2}$) | **not transcribed**, absent from both [notes.md](../references/boehm-wilking-2008-space-forms/notes.md) and [README.md](../references/boehm-wilking-2008-space-forms/README.md); the PDF is stored |
| [Xu](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) Prop. 2.7 items (1)–(5), Lemma 2.8 / eq. (2.34) | yes, both in the notes |
| [scripts/route-b/b_cone_offslice.py](../scripts/route-b/b_cone_offslice.py) | yes, file exists |
| [conventions.md](../findings/conventions.md) for $\Phi$, $I$, $R_{\mathrm{ric}_0}$, $\Omega_0$, $\wedge$, $S^2_B=\langle I\rangle\oplus\langle\mathrm{Ric}_0\rangle\oplus\langle W\rangle$ | **none of the six is there**, see below |

## The convention gap, which is upstream of the block

[conventions.md](../findings/conventions.md) opens with "definitions and conventions are quoted, never restated" and tables $Q(W)=W^2+W^\#$ and $P(W)=\langle W,Q(W)\rangle$. **It defines none of the symbols L45 is written in**: $\Phi$, $I$, $R_{\mathrm{ric}_0}$, $\Omega_0$, the Kulkarni–Nomizu $\wedge$, the Ricci normalisation, and the three-block decomposition are all absent.

The sharpest instance: **$\Phi$ has no definition anywhere in [findings/](../findings/), and the letter already carries two other objects there**, a quadratic map in $v$ at [nondegeneracy.md](../findings/nondegeneracy.md) line 574, and $\Phi=P-\kappa_n\delta^2$ at [route-a.md](../findings/route-a.md) line 170. L45's $\Phi$ is Hamilton's $Q$, polarised; the block's own displayed formula uses **$\Phi$ and $Q$ for the same map in the same equation** ($3\langle W,\Phi(Y)\rangle$ beside $\langle W,Q(W)\rangle$), with the identification stated nowhere. This is the same class as the $B$, $M$, $\mu$ and $d$ collisions [conventions.md](../findings/conventions.md) already tables, and it is not tabled.

## What is owed, and whether it is reachable

| owed | reachable |
| --- | --- |
| Correct the provenance note, and move the result to [problem.md](../findings/problem.md) where its argument is, or point the note at that file | **yes**, editorial |
| Fix "multiplicities $1,3,3,6$" at [results.md](../results.md) line 288 to $1,3,1,3,1$ | **yes**, one line |
| Restore the Xu/Huisken attribution and the "proves no case by itself" caveat to the block | **yes**, editorial; both sentences exist verbatim elsewhere on the record |
| Table $\Phi$, $\Omega_0$, $\wedge$ and the Ricci normalisation in [conventions.md](../findings/conventions.md), with $\Phi=Q$ stated | **yes** |
| Transcribe BW08 Lemma 2.2 into the reference notes | **yes**, PDF is stored |
| An expansion of $\mathrm{RHS}_{\rm even}$ in $c$, $Y$, $\lVert W\rVert$, without which $\lvert D\rvert\le E$ is unusable | **yes analytically**, the quotient rule plus the block structure already used; it is the natural next derivation, and it is what would turn L45 from bookkeeping into an instrument |
| A bound on $\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$ | **open**, Cauchy–Schwarz gives $\lVert\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rVert$ in terms of $\lVert\mathrm{Ric}_0\rVert$, but a bound useful against $\theta_0(n)$ needs the projection onto $\langle W\rangle$ and is not in hand |

**No computation was performed for this review, and none was required, every check above is an identity or an enumeration.**
