# Review r515, Lemma L7

**Target:** Lemma L7, "a bound at every critical point, and the symmetric-pair equality class", `findings/bounds.md`, `#### Lemma L7` heading (line 43) to next heading.

**Reviewer:** r515, independent adversarial audit, cold. Analysis-only footing: no searches, sweeps, censuses or falsifier hunts; screening a claim before recording it is permitted and reported as a screen.

**Phase plan**
1. Setup (log + this report).
2. Fix conventions against the record's anchors.
3. Read L7 verbatim; read L15 verbatim.
4. Derive the inequality cold from criticality compressed onto the negative spectral part; audit the four stated ingredients, the constant 6, and rank-one positivity of #.
5. Pin what `W_-` is from the proof; check the block states it.
6. Equality case: is bracket-grading equivalent to symmetric pair, or only implied? Cross-check L23 / `findings/ungraded-slack.md`.
7. The 11 citations: inequality, equality case, or a strengthening.
8. Sweep `findings/` for restatements with a different constant; check later sections of `bounds.md` do not contradict.

**VERDICT: PLAUSIBLE**, inequality confirmed; the equality-case sentence carries a false clause on the kernel. Full verdict at the end.

---

## 1. The block, verbatim (`findings/bounds.md`, lines 43–50)

> Compressing the criticality equation onto the negative spectral part gives, at every critical point,
> $$\theta\mathop{\mathrm{tr}}(W_-)+\mathop{\mathrm{tr}}(W_-^2)\;\le\;\|\mathrm{Ric}(W_-)\|^2+6\,\delta^2,$$
> with $\delta^2$ the defect of Observation L15; the proof needs only bilinearity of $\#$, its rank-one positivity, a partial trace, and the polarized identity of Observation L15. The value is in the equality case: equality holds precisely when the eigenspace ranges are graded by the Lie bracket, which is exactly the condition defining a compact symmetric pair with $E_+$ the isotropy algebra. …

## 2. Conventions I pinned before deriving

Anchors checked first: $\theta_0(6)^2=2\cdot5\cdot4/36=10/9$, so $\theta_0(6)=\sqrt{10}/3$ ✓; $\dim\mathcal W_6=6\cdot3\cdot7\cdot8/12=84$ ✓.

Two further normalisations are load-bearing for L7 and are **not** in [conventions.md](../findings/conventions.md). I pinned them from the record's own anchors rather than assuming them:

| quantity | value forced | how pinned |
| --- | --- | --- |
| $\mathop{\mathrm{scal}}(R)$ vs $\mathop{\mathrm{tr}}_{\Lambda^2}(R)$ | $\mathop{\mathrm{scal}}=2\mathop{\mathrm{tr}}_{\Lambda^2}$ | $R=\mathrm{Id}_{\Lambda^2}$: $\mathop{\mathrm{Ric}}=(n-1)\mathrm{Id}$, $\|\mathrm{Ric}\|^2=n(n-1)^2$, and $\mathop{\mathrm{scal}}(R^2+R^\#)=(n-1)\mathop{\mathrm{scal}}(\mathrm{Id})$ matches only with the factor $2$ |
| $\mathrm{Id}^\#$ | $(n-2)\mathrm{Id}$ | same anchor, $Q(\mathrm{Id})=(n-1)\mathrm{Id}$ |
| $W_-$ | $\tfrac12(\lvert W\rvert-W)\succeq0$, as an operator on **all** of $\Lambda^2$ | [conventions.md](../findings/conventions.md); and confirmed below, the opposite sign turns the block's own equality points into strict inequalities |

**I re-derived Observation L15's identity independently** rather than taking it: for $T=\Pi_{\text{mixed}}$ on $\Lambda^2\mathbb R^{2m}$ I get $\mathop{\mathrm{Ric}}(T)=m\,\mathrm{Id}$, $\mathrm{Alt}(T)=0$, $T^2=T$, $\mathop{\mathrm{tr}}(T^\#)=m^2(m-1)$, so $\mathop{\mathrm{scal}}(T^2+T^\#)=2m^2+2m^2(m-1)=2m^3=\|\mathop{\mathrm{Ric}}(T)\|^2$ ✓. For $W_{\mathbb{CP}^2}$: $\mathop{\mathrm{scal}}(W_-^2+W_-^\#)=2(\tfrac13)+2(\tfrac13)=\tfrac43=\tfrac23+6\cdot\tfrac19$ ✓. **The identity is confirmed, in both anchors, with the constant $6$.**

## 3. The inequality, CONFIRMED, with the proof reconstructed cold

The block gives no proof; I rebuilt one, and the four named ingredients are **exactly** the ones needed and **sufficient**. Write $\Pi_-$ for the orthogonal projection onto the negative eigenspace $E_-$, so $W_-=\lvert W\rvert\Pi_-$ and $W=W_+-W_-$ with $W_\pm\succeq0$, $W_+W_-=0$.

**Step 1, the partial trace.** Apply $\mathop{\mathrm{tr}}(\Pi_-\,\cdot\,)$ to $Q(W)=\theta W$. Since $\mathop{\mathrm{tr}}(\Pi_-W)=-\mathop{\mathrm{tr}}(W_-)$ and $\mathop{\mathrm{tr}}(\Pi_-W^2)=\mathop{\mathrm{tr}}(W_-^2)$,
$$\theta\mathop{\mathrm{tr}}(W_-)+\mathop{\mathrm{tr}}(W_-^2)=-\mathop{\mathrm{tr}}(\Pi_-W^\#).\qquad(\star)$$
*This identity is what fixes the reading of $W_-$: no other compression produces the block's left-hand side.*

**Step 2, bilinearity.** $W^\#=W_+^\#-2\,W_+\#W_-+W_-^\#$, so
$$-\mathop{\mathrm{tr}}(\Pi_-W^\#)=-\mathop{\mathrm{tr}}(\Pi_-W_+^\#)-\mathop{\mathrm{tr}}(\Pi_-W_-^\#)+2\mathop{\mathrm{tr}}\big(\Pi_-(W_+\#W_-)\big).$$

**Step 3, rank-one positivity.** $vv^{\mathsf T}\#ww^{\mathsf T}=[v,w][v,w]^{\mathsf T}$, so $X,Y\succeq0\Rightarrow X\#Y\succeq0$. Hence the first two terms are $\le0$, and $\mathop{\mathrm{tr}}(\Pi_-A)\le\mathop{\mathrm{tr}}(A)$ for $A=W_+\#W_-\succeq0$ gives
$$-\mathop{\mathrm{tr}}(\Pi_-W^\#)\;\le\;2\mathop{\mathrm{tr}}(W_+\#W_-)=\mathop{\mathrm{scal}}(W_+\#W_-).$$

**Step 4, L15 polarized, at $(W_+,W_-)$.** Polarizing $\mathop{\mathrm{scal}}(R^2+R^\#)=\|\mathop{\mathrm{Ric}}R\|^2+6\|\mathrm{Alt}R\|^2$ and using $W_+W_-=0$,
$$\mathop{\mathrm{scal}}(W_+\#W_-)=\langle\mathop{\mathrm{Ric}}W_+,\mathop{\mathrm{Ric}}W_-\rangle+6\langle\mathrm{Alt}W_+,\mathrm{Alt}W_-\rangle=\|\mathop{\mathrm{Ric}}W_-\|^2+6\delta^2,$$
the last step by $\mathop{\mathrm{Ric}}(W)=0\Rightarrow\mathop{\mathrm{Ric}}W_+=\mathop{\mathrm{Ric}}W_-$ and $\mathrm{Alt}(W)=0\Rightarrow\mathrm{Alt}W_+=\mathrm{Alt}W_-$. $\square$

**Rank-one positivity is a theorem here, not an assumption**, it is the standard $\#$-identity on rank-one operators plus bilinearity over a psd spectral decomposition. The block is right to list it as an ingredient rather than a hypothesis; it carries no citation, which is the one thing owed.

**Where the $6$ comes from.** It is inherited whole from L15's identity at Step 4 and is never re-derived, so it cannot be wrong independently of L15. And the brief's worry is answered positively: I checked it at a point with **nonzero** defect.

### The two numerical anchors, both equalities

| point | $\theta\mathop{\mathrm{tr}}W_-+\mathop{\mathrm{tr}}W_-^2$ | $\|\mathop{\mathrm{Ric}}W_-\|^2$ | $6\delta^2$ | verdict |
| --- | --- | --- | --- | --- |
| $S^m\times S^m$, $n=2m$ | $(m-1)+\frac{m-1}{2m-1}=\frac{2m(m-1)}{2m-1}$ | $\frac{2m(m-1)}{2m-1}$ | $0$ | **equality** |
| $W_{\mathbb{CP}^2}$, $n=4$ | $1+\tfrac13=\tfrac43$ | $\tfrac23$ | $6\cdot\tfrac19=\tfrac23$ | **equality** |

*Both computed by hand from the definitions, not taken from the record.* The $\mathbb{CP}^2$ row is the one that tests the constant: $\tfrac43-\tfrac23=\tfrac23=6\cdot\tfrac19$ exactly, so **any constant other than $6$ breaks the block's own named equality point.** The sphere-product row alone would not have seen it, exactly as the brief warned.

*The sign of $W_-$ is confirmed by the same two rows*: under $W_-\preceq0$ the left side at $S^m\times S^m$ becomes $-(m-1)+\frac{m-1}{2m-1}<0$, a strict inequality, and the block's equality claim would be false at its own leading example.

**Verdict on the inequality: CONFIRMED.**

## 4. What $W_-$ is, pinned from the proof, and NOT stated in the block

The brief's worry is real but resolves cleanly, in a direction the block should state:

- **$\mathop{\mathrm{tr}}(W_-)$ and $\mathop{\mathrm{tr}}(W_-^2)$ do not distinguish the two readings.** $W_-$ vanishes on $E_+\oplus E_0$, so its trace and its square's trace are the same whether taken over $\Lambda^2$ or over $E_-$.
- **$\mathop{\mathrm{Ric}}(W_-)$ and $\mathrm{Alt}(W_-)$ admit only one reading.** Both are contractions of $W_-$ *as a $4$-tensor on $\mathbb R^n$*; a restriction to the subspace $E_-\subset\Lambda^2$ is not a curvature-type tensor and has no $\mathop{\mathrm{Ric}}$ and no $\mathrm{Alt}$. So $W_-$ must be the operator $\tfrac12(\lvert W\rvert-W)$ on all of $\Lambda^2$, which is [conventions.md](../findings/conventions.md)'s definition.
- **Step 1 confirms it independently.** $\theta\mathop{\mathrm{tr}}(W_-)+\mathop{\mathrm{tr}}(W_-^2)$ arises from exactly one compression, $\mathop{\mathrm{tr}}(\Pi_-\,\cdot\,)$ against $Q(W)=\theta W$; no other produces it.

**The block states none of this**, and does not name $\Pi_-$ at all, so a reader cannot recover Step 1 from the text. *This is the "hypothesis shared between claims of different strength" pattern only in the weak form: the two readings agree on the left side, so nothing downstream is corrupted.*

## 5. Exactly what the inequality needs, and the block's ingredient list is one item short

| ingredient | used? | stated? |
| --- | --- | --- |
| bilinearity of $\#$ | ✓ Step 2 | ✓ |
| rank-one positivity of $\#$ | ✓ Step 3, three times | ✓, and it is a **theorem**, not an assumption |
| a partial trace | ✓ Step 1, $\mathop{\mathrm{tr}}(\Pi_-\,\cdot\,)$ | ✓ |
| L15's polarized identity | ✓ Step 4, at $(W_+,W_-)$ | ✓ |
| $\mathop{\mathrm{Ric}}(W)=0$ and $\mathrm{Alt}(W)=0$ | ✓ Step 4, the whole reduction of the polarized identity to $\|\mathop{\mathrm{Ric}}W_-\|^2+6\delta^2$ | ✗ |
| unit norm | ✓ implicit in "critical point" per [conventions.md](../findings/conventions.md) | ✗ (acceptable, it is the record's definition) |

**Criticality is all it needs beyond membership in $\mathcal W_n$.** No sign condition on the spectrum, no Ricci-flatness *beyond* what $\mathcal W_n$ already carries, no diagonality, no $n\ge12$.

**Two sharpenings of the hypothesis question, both checkable and both true.**
- **The bracket form is not enough.** [conventions.md](../findings/conventions.md) records that $[W,Q(W)]=0$ is strictly weaker than $Q(W)=\theta W$. Step 1 takes a trace of the *equation*, so the bracket form does not support it. The block's "at every critical point" is therefore exactly right and not loose.
- **Only the left-hand side needs criticality.** Polarizing at $(W,W_+)$ instead gives $\mathop{\mathrm{scal}}(W_+^2+W_+^\#)=\mathop{\mathrm{scal}}(W_+\#W_-)$, so the right-hand side equals $\tfrac12[\mathop{\mathrm{scal}}(W_+^2+W_+^\#)+\mathop{\mathrm{scal}}(W_-^2+W_-^\#)]\ge\mathop{\mathrm{tr}}(W_+^2)+\mathop{\mathrm{tr}}(W_-^2)=\lVert W\rVert^2$ by rank-one positivity alone. *That reproduces [ATTEMPTS.md](../ATTEMPTS.md)'s Result 3 by-product, $\lVert\mathop{\mathrm{Ric}}(W_-)\rVert^2+6\delta^2\ge\lVert W\rVert^2$ with no criticality hypothesis, and I confirm it.*

## 6. The dependence on Observation L15, clean

L15 was relabelled and its consequence refuted; what survives is $\mathop{\mathrm{scal}}(R^2+R^\#)=\|\mathop{\mathrm{Ric}}R\|^2+6\|\mathrm{Alt}R\|^2$.

- **L7 uses only the surviving identity.** Step 4 needs the identity and nothing else. The refuted half, *that the Bianchi defect is the only obstruction to lifting*, the second obstruction being $X_{\mathrm{inv}}\succeq0$, is never invoked. **Confirms [LEDGER.md](../findings/LEDGER.md)'s "no Lemma rests on the refuted half".**
- **$\delta^2$ means the same thing in both.** $\delta^2=\|\mathrm{Alt}(W_-)\|^2$, which is L15's $\|\mathrm{Alt}(R)\|^2$ at $R=W_-$; my $\mathbb{CP}^2$ row, where $\delta^2=\tfrac19$ enters and equality comes out exactly, is the check.
- **A pleasing relation the record already spots and I confirm.** With $X_{\mathrm{inv}}=4W_+\#W_--2\theta W_--2W_-^2$, my Steps 1–4 give $\mathop{\mathrm{tr}}(X_{\mathrm{inv}})=2S$, so **L7 is exactly the trace shadow of the operator inequality $X_{\mathrm{inv}}\succeq0$ that L15's refuted half needed**, L7 proves the trace unconditionally, which is why the refutation upstream costs it nothing. This matches [ATTEMPTS.md](../ATTEMPTS.md) line 3962 ($S=\tfrac12\mathop{\mathrm{tr}}X_{\mathrm{inv}}$, $\mathop{\mathrm{scal}}(X_{\mathrm{inv}})=4S$) and is a third independent confirmation of $\mathop{\mathrm{scal}}=2\mathop{\mathrm{tr}}$.

## 7. The equality case, where the block overstates, and where its own file contradicts it

From the proof, equality holds **iff all three slack terms vanish**:

$$S=T_1+2T_2+T_3,\qquad T_1=\mathop{\mathrm{tr}}(\Pi_-W_+^\#),\quad T_2=\mathop{\mathrm{tr}}\big((I-\Pi_-)(W_+\#W_-)\big),\quad T_3=\mathop{\mathrm{tr}}(\Pi_-W_-^\#),$$

each a compression of a psd operator. Expanding each in the eigenbasis via $vv^{\mathsf T}\#ww^{\mathsf T}=[v,w][v,w]^{\mathsf T}$:

| term | vanishes iff |
| --- | --- |
| $T_1$ | $[E_+,E_+]\perp E_-$ |
| $T_2$ | $[E_+,E_-]\subseteq E_-$ |
| $T_3$ | $[E_-,E_-]\perp E_-$ |

*This decomposition, with the same coefficient $2$ on $T_2$, is already on the record at [ungraded-slack.md](../findings/ungraded-slack.md)'s Lemma L132 withdrawal notice, reached independently; my derivation agrees with it term for term.*

### 7a. The gap: the conditions are "$\perp E_-$", not "$\subseteq E_+$"

Write $E_0=\ker W$. The three conditions say $[E_+,E_+]\subseteq E_+\oplus E_0$ and $[E_-,E_-]\subseteq E_+\oplus E_0$ and $[E_+,E_-]\subseteq E_-$. **They are the $\mathbb Z_2$-grading relations that involve no kernel direction, and only those.**

- **When $\ker W=0$** they collapse to $[E_+,E_+]\subseteq E_+$, $[E_-,E_-]\subseteq E_+$, $[E_+,E_-]\subseteq E_-$, so $\mathfrak{so}(n)=E_+\oplus E_-$ is a $\mathbb Z_2$-grading and $(\mathfrak{so}(n),E_+)$ *is* a compact symmetric pair. **The block is exactly right here.**
- **When $\ker W\ne0$** three further relations ($[E_+,E_0]\perp E_-$, $[E_0,E_0]\perp E_-$, $[E_0,E_-]\subseteq E_-$), are **neither implied by equality nor stated by the block**. Without them $E_+\oplus E_-$ need not even be a subalgebra, so there is no pair to speak of. Jacobi buys only $\mathop{\mathrm{ad}}([E_+,E_+])E_-\subseteq E_-$, which does not force the $E_0$-component to vanish.

**So "precisely … which is exactly the condition defining a compact symmetric pair" is proved in one direction (graded $\Rightarrow$ equality) and, in the other, only under a hypothesis the block does not carry.**

### 7b. The contradiction: the block's own file, 75 lines below

This is not a hypothetical. [bounds.md](../findings/bounds.md) line 124 (same file, below the L7 block), reads:

> "$\{\lambda>0\}$ does not make the padded operator graded *in $\mathfrak{so}(n)$*: at $n=8$, $\mathfrak p\oplus\mathfrak m\cong\mathfrak{su}(2)$ is a graded **3-dimensional subalgebra** while $\mathfrak{so}(8)$ is $28$-dimensional and the $25$-dimensional kernel is unassigned … **$S_{\mathfrak{mpp}}=0$ certifies a grading of the span of the nonzero eigenvectors, not of $\mathfrak{so}(n)$.** So *outside the subalgebra family, slack zero does not imply a $\mathbb Z_2$-grading* stands."

And [trap W4](../findings/INDEX-traps.md) says the same of L7's own slack, which traces only over $E_\pm$: *"a point whose kernel carries most of $\mathfrak{so}(n)$ reports $S=0$ while admitting no grading; padded $W_{\mathbb{CP}^2}$ has kernel $63$ of $66$ at $n=12$."*

**The witness is one of the block's own five named equality points.** At $W_{\mathbb{CP}^2}$, $E_+$ is one-dimensional ($\mathbb R\omega_1$) and $E_0=\Lambda^-$ is half of $\Lambda^2\mathbb R^4$, I computed this directly in §3. So:

- **The clause "$(\mathfrak{so}(n),E_+)$ is a compact symmetric pair with $E_+$ the isotropy algebra" is FALSE at padded $W_{\mathbb{CP}^2}$**, the block's own example: $E_+$ is $1$-dimensional inside a $28$- or $66$-dimensional algebra, and $[E_0,E_0]\not\subseteq E_+$.
- **The clause is TRUE if "symmetric pair" means the abstract pair $(E_+\oplus E_-,\,E_+)$**, at $W_{\mathbb{CP}^2}$ that is $(\mathfrak{su}(2),\mathfrak u(1))$, which is what [ATTEMPTS.md](../ATTEMPTS.md) line 952 actually lists ("Fox $=(\mathfrak{su}(2),\mathfrak u(1))$"). **But under this reading the "precisely" is unproven**, per §7a: equality does not force $E_+\oplus E_-$ closed.

**Both readings fail, in different places.** The block never says which it means, and the record uses the second while the block's wording ("with $E_+$ the isotropy algebra", against the ambient $\mathfrak{so}(n)$ of the statement) reads as the first.

### 7c. "Symmetric pair" is also the wider class the brief warns of

[Lemma L23](../findings/ungraded-slack.md) establishes that **a symmetric pair is critical only at the cap $r=n(n-2)/4$** ("$S_{\mathfrak{mmm}}=0$ turns the closed form into $r=n(n-2)/4$ exactly") and that unbalanced splits such as $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ are symmetric pairs strictly over it, at $r=31$ against $30$. This does **not** falsify L7, whose equality case is asserted only at critical points. But it does mean the equality class is *not* "the symmetric pairs" as a set, and the block's sentence, read as a characterisation of a class of objects rather than of a subset of the critical set, names a strictly larger family than it can deliver.

### 7d. The unsourced empirical sentence

*"Every known critical point with value above $1$ satisfies it … and it fails strictly at the low-value ones."* This is a claim about the catalogue, with no citation and no script named, in a block that carries no other evidence. It is **consistent** with what I could check by hand, the $k$-block balanced products have $\theta=\sqrt{(n-1)(n-3)}/n<1$ at $k=3$, so the ungraded ones fall below $1$ automatically, but the general form is not established in the block. *Under the analysis-only footing I did not run the catalogue; what a run would decide is whether an ungraded critical point exists with $\theta>1$, which would refute this sentence outright while leaving the inequality untouched.*

## 8. The citations, what each one takes

| site | what it takes | verdict |
| --- | --- | --- |
| [ungraded-slack.md:290](../findings/ungraded-slack.md) | "Lemma L7's inequality $S\ge0$ is untouched" | ✓ inequality only, and correct |
| [ungraded-slack.md:288](../findings/ungraded-slack.md) (Obs. L12) | "L7 splits the critical points by whether its inequality is an equality" | ✓ the dichotomy, which survives; L12 also records that **L8 is scoped to the balanced splits** ([r503](REVIEW_r503.md), [r504](REVIEW_r504.md)), so the equality side is not settled generally |
| [ungraded-slack.md:296](../findings/ungraded-slack.md) (L132 withdrawal) | the $T_1+2T_2+T_3$ decomposition | ✓ agrees with my derivation term for term |
| [ungraded-slack.md:178](../findings/ungraded-slack.md) | $\theta\mathop{\mathrm{tr}}(W_-)=\dots-S$, "ungradedness mechanically subtracts from $\theta$" | ✓ a rearrangement of the inequality |
| [nondegeneracy.md:407](../findings/nondegeneracy.md) | $S=0$ at $\mathbb{CP}^3,\mathbb{CP}^4,\mathbb{CP}^5$; the $6\delta^2$ term is not droppable | ✓ inequality + equality points |
| [nondegeneracy.md:430](../findings/nondegeneracy.md) | warns that rearranging $S$'s definition is a tautology | ✓ a correct guard |
| [results.md:366](../results.md) | the split, the slack, "$(S^m)^3$ … on the strict side" | ✓ consistent, three-block products are ungraded, so strictness is what L7 predicts |
| [ATTEMPTS.md:3962](../ATTEMPTS.md) | $S=\tfrac12\mathop{\mathrm{tr}}(X_{\mathrm{inv}})$, $\mathop{\mathrm{scal}}(X_{\mathrm{inv}})=4S\ge0$ | ✓ inequality, and independently confirms my normalisation |
| [report/sections/03-setup.tex:37](../report/sections/03-setup.tex) | the definition of $S$ | ✓ |
| [results.md:122](../results.md) | **"with equality exactly on the compact symmetric pairs"** | ✗ **repeats the overstated clause of §7**, in the summary line a reader meets first |
| [graded-half.md:201](../findings/graded-half.md) | **"matching Lemma L7's closed form, which puts it at the family's peak"** | ✗ **MISCITE, L7 contains no closed form**, and no statement about the Ricci-flat Kähler family's peak. The closed form pinning a point by its pair's dimensions is [Lemma L23](../findings/ungraded-slack.md)'s $\theta=\tfrac2n\sqrt{rN/(N-r)}$ |

**No citation rests on the refuted half of L15**, confirming [LEDGER.md](../findings/LEDGER.md). **One citation rests on the clause §7b refutes** (results.md:122) and **one cites content L7 does not contain** (graded-half.md:201).

## 9. Cross-file sweep

**Constant.** Every restatement in the record carries $6\delta^2$, [ungraded-slack.md](../findings/ungraded-slack.md) lines 178 and 286, [results.md](../results.md) lines 334 and 366, [ATTEMPTS.md](../ATTEMPTS.md) lines 941 and 1112, [nondegeneracy.md](../findings/nondegeneracy.md) lines 407 and 430, [report/sections/03-setup.tex](../report/sections/03-setup.tex) line 37. **No competing constant anywhere**, and §3's $\mathbb{CP}^2$ row proves $6$ is the only one that works.

**Later sections of [bounds.md](../findings/bounds.md).** Nothing below the block contradicts the *inequality*. Line 124 contradicts the *equality sentence*, as §7b sets out, and line 130's $\theta=1.088948$ witness (graded, trivial kernel, $S_{\mathfrak{mmm}}=1.4\times10^{-28}$, pair $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$) is the trivial-kernel case where the block's sentence is exactly right, which sharpens rather than weakens the diagnosis: **the sentence is true where $\ker W=0$ and false where it is not.**

**Anchors re-checked at the end**, as a guard against a drifted normalisation: $\mathop{\mathrm{tr}}W^\#=-1$ is consistent with $\mathop{\mathrm{scal}}=2\mathop{\mathrm{tr}}$ and $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ used throughout; $\theta_0(6)=\sqrt{10}/3$; $\dim\mathcal W_6=84$; $Q_{ab}=M_{ab}^2+(M^2)_{ab}$ on the diagonal locus is not touched by this block.

## 10. What is owed

1. **Split the equality sentence in two.** *"Equality holds iff $[E_+,E_+]\perp E_-$, $[E_-,E_-]\perp E_-$ and $[E_+,E_-]\subseteq E_-$. When $\ker W=0$ these say $\mathfrak{so}(n)=E_+\oplus E_-$ is a $\mathbb Z_2$-grading and $(\mathfrak{so}(n),E_+)$ is a compact symmetric pair; when $\ker W\ne0$ they certify a grading of the span of the nonzero eigenvectors only ([trap W4](../findings/INDEX-traps.md), [bounds.md:124](../findings/bounds.md))."*
2. **Add the missing hypothesis to the ingredient list**: $\mathop{\mathrm{Ric}}(W)=0$ and $\mathrm{Alt}(W)=0$ are used in Step 4, and are what reduce the polarized identity to $\|\mathop{\mathrm{Ric}}W_-\|^2+6\delta^2$.
3. **Put the proof in the block.** The heading says "canonical statement and proof" and there is no proof; §3 above is four lines and can be transcribed.
4. **Name $W_-$ and $\Pi_-$**, quoting [conventions.md](../findings/conventions.md), so Step 1 is recoverable.
5. **Fix [graded-half.md:201](../findings/graded-half.md)** to cite [Lemma L23](../findings/ungraded-slack.md) rather than L7's non-existent closed form.
6. **Fix [results.md:122](../results.md)**, which carries the overstated clause into the summary.
7. **Source or drop the "every known critical point above $1$" sentence.**

---

## VERDICT: PLAUSIBLE

**The displayed inequality is CONFIRMED outright**, proved cold in four steps from the definitions, the four named ingredients exactly right and exactly sufficient, rank-one positivity a theorem rather than an assumption, and verified as an *equality* by hand at two independent anchors ($S^m\times S^m$ and $W_{\mathbb{CP}^2}$), the second of which pins the constant $6$ because $\delta^2=\tfrac19\ne0$ there. It takes only L15's surviving identity, and $\delta^2$ means in L7 what it means in L15. Its hypothesis is honest: criticality in the strong form $Q(W)=\theta W$, plus membership in $\mathcal W_n$, and nothing else.

**The equality sentence (which the block itself calls "the value"), carries one false clause and one unproven "precisely".** Equality is equivalent to three bracket conditions of the form "$\perp E_-$", which are the grading relations *that involve no kernel direction*. With $\ker W=0$ the block's sentence is exactly right. With $\ker W\ne0$ its natural reading ($(\mathfrak{so}(n),E_+)$ a symmetric pair with $E_+$ the isotropy algebra), **is false at padded $W_{\mathbb{CP}^2}$, one of the block's own five named equality points**, and is contradicted by [bounds.md:124](../findings/bounds.md) seventy-five lines below it in the same file and by [trap W4](../findings/INDEX-traps.md); under the record's other reading, the abstract pair $(E_+\oplus E_-,E_+)$, the forward direction is simply unproven, since equality does not force $E_+\oplus E_-$ closed.

**Not REFUTED**, because the lemma's displayed mathematics is true, sharp, and correctly used by nine of its eleven citations; **not CONFIRMED**, because the clause the block advertises as its whole value is wrong on the kernel and the fix is a rewrite, not a clarification. The downstream framing (*"the graded one becomes a classification problem"*), inherits the gap, since it needs the direction that is unproven.
