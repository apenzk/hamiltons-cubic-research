# Gate 2, Reviewer r155: the gap floor closed form, the calibration defect, the 3a/3b split

Cold review, derivation only. Every entry, multiplicity, norm and asymptotic below was rebuilt from the definitions in [run_graded_gap_at_fixed_n.py](../scripts/runs/run_graded_gap_at_fixed_n.py), which is the convention of record. One rational-arithmetic evaluation appears, flagged where it is used, and it is used only to refute.

## Verdict

| claim | verdict |
|---|---|
| 1. entries and multiplicities at $p=3$ | **CONFIRMED**, derived independently |
| 1. normalisation / the factor of two | **CONFIRMED**, by a third anchor the derivation did not use |
| 1. the floor sits at $p=3$ | **REFUTED**, $p=2$ is admissible, graded, critical, already on the record's own graded table, and gives a strictly smaller gap at every $n\ge7$ |
| 1. $\mathrm{floor}(n)\sim2/n^{3/2}$ | **REFUTED**, it is $\sim2\sqrt3/n^2$; the wrong power came from dropping the dominant term of the norm |
| 1. "positive at every $n$" | **SCOPE ERROR**, the closed form is the gap only for $n\ge7$ |
| 2. $\operatorname{tr}\mathring W=0$ | **CONFIRMED and DERIVED** in three lines |
| 2. Lemma 3.2 degenerates | **CONFIRMED, and the record understates it**, the hypothesis set is $\{W=0\}$, so the lemma is vacuous, not merely uncalibrated |
| 2. "both sides carry $\bar\lambda$, check the ratio" | **the premise is false**, the left side carries no $\bar\lambda$; there is no ratio |
| 2. the demotion of 3a | **WRONG DIRECTION**, the defect is repaired by an identity shift that keeps the published constants |
| 3. the 3a/3b tie-break | **INVERTED**, on the corrected findings 3a is the one whose obligation is a single named estimate |
| 3. 3b's grade | **both factors unsupported** |

---

## CLAIM 1, the closed form

### The convention, rebuilt

`sphere_product(p,q,n)` builds the hollow symmetric vertex matrix $\Lambda$ with $\Lambda_{ij}=-q/(p-1)$ inside the first block, $-p/(q-1)$ inside the second, $+1$ across, and returns the diagonal Weyl tensor $-\,W_{ijkl}=-\Lambda_{ij}(\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk})$. `toM` indexes by **unordered pairs $i<j$**, so the operator is diagonal with entries $-\Lambda_{ij}$, one per pair. `gap` divides by the Frobenius norm of that matrix and reports the smallest nonzero modulus. So the whole object is three numbers with three multiplicities, and nothing else.

The three-value structure is forced, not fitted. A hollow symmetric matrix constant on the three block types has values $(x_1,x_2,y)$ obeying the two Ricci-flatness row sums $(p-1)x_1+qy=0$ and $(q-1)x_2+py=0$ (one equation per block) so the block-structured Weyl vertex matrices form a **one-dimensional** space, spanned by $\Lambda$. Normalising $y=1$ gives $x_1=-q/(p-1)$, $x_2=-p/(q-1)$ exactly as recorded.

### Entries and multiplicities at $p=3$, CONFIRMED

Moduli and multiplicities are $q/(p-1)$ on $\binom p2$ pairs, $p/(q-1)$ on $\binom q2$, $1$ on $pq$. At $p=3,\ q=n-3$:

$$\tfrac{n-3}2\times3,\qquad \tfrac3{n-4}\times\tbinom{n-3}2,\qquad 1\times3(n-3),$$

and $\binom{n-3}2\cdot\frac9{(n-4)^2}=\frac{9(n-3)}{2(n-4)}$, which is the record's middle term. All three entries, all three multiplicities and the squared norm

$$\|M\|_F^2=\tfrac34(n-3)^2+\tfrac{9(n-3)}{2(n-4)}+3(n-3)$$

reproduce the record exactly. **Confirmed.**

### Which entry is smallest, for every $n$, a scope error

$\frac3{n-4}\le1$ requires $n\ge7$, and $\frac{n-3}2\ge\frac3{n-4}$ likewise. At $n=6$ the smallest modulus is the cross entry $1$, not $3/(n-4)=3/2$, so the closed form overstates the gap there; at $n=5$ the ordering inverts entirely ($p=3>q=2$); at $n=4$ it divides by zero. The tabulated values start at $n=8$ so no recorded number is affected, but **"it is positive at every $n$" is stated without its range and the range is $n\ge7$.**

### The normalisation, CONFIRMED by a third anchor

The brief is right that two agreeing data points is a weak check after a factor-of-two slip. There is a third anchor the derivation did not use. Running the same convention at $p=q=n/2$:

$$\|M\|_F^2=2\tbinom{n/2}2\tfrac{n^2}{(n-2)^2}+\tfrac{n^2}4=\tfrac{n^3}{4(n-2)}+\tfrac{n^2}4=\tfrac{n^2(n-1)}{2(n-2)},$$

and the smallest modulus at the balanced product is $1$, so the gap is $\frac{\sqrt{2(n-2)}}{n\sqrt{n-1}}=\frac{\sqrt2(n-2)}{n\sqrt{(n-1)(n-2)}}$, **character for character the record's balanced-product formula**, which was independently verified at $n=6,8,10,12,16$. Two different closed forms in the same convention, agreeing with two independently recorded results, fixes the normalisation. **The factor of two is right.**

### The floor is NOT at $p=3$, REFUTED

Calling $p=3$ "the most unbalanced product" presupposes $p=2$ is inadmissible. It is not, on four counts:

1. **Admissible as a Weyl tensor.** The row-sum system above is solvable at $p=2$: one interior pair with $\Lambda_{12}=-q$, row sum $-q+q\cdot1=0$. Only $p=1$ fails (no interior pair, row sum $q\ne0$). So $p=2$ is the genuine extreme of the family.
2. **Critical, and provably so.** With $E$ the $p\times q$ all-ones block, $(J_p-I_p)^2=(p-2)J_p+I_p$, $EE^{\mathsf T}=qJ_p$, $(J_p-I_p)E=(p-1)E$, $E(J_q-I_q)=(q-1)E$, so $\Lambda^2$ is again constant on the three block types. Its off-diagonal part therefore lies in the block-structured hollow symmetric space, whose Weyl projection (row sums and total sum, both block-respecting), lands in the **one-dimensional** space spanned by $\Lambda$. Hence $\Pi_{\mathrm{Weyl}}(\Lambda^2)=\theta\Lambda$ automatically, for **every** $p,q\ge2$. Criticality at $p=2$ is not weaker than at $p=3$; it is the same one-line argument.
3. **Graded.** The isotropy is $\mathfrak{so}(2)\oplus\mathfrak{so}(n-2)$, a symmetric subalgebra of $\mathfrak{so}(n)$, with $\mathfrak m=\mathbb R^2\otimes\mathbb R^{n-2}$ the strictly-negative eigenspace of the record's $M$ (entries $-1$ on the $pq$ cross pairs) and $\mathfrak h$ the two $\mathfrak{so}$ factors. Both $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ and $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ hold, so $S_{\mathfrak{mmm}}=S_{\mathfrak{hhm}}=0$.
4. **Already on the record as such.** [graded-half.md](../findings/graded-half.md) tabulates the $n=12$ graded critical points solved from the full three-parameter family, and its first row is $2+10$, $\theta=0.994987437$, matched to $S^2\times S^{10}$ and reproducing Nienhaus Proposition 2.25. [nondegeneracy.md](../findings/nondegeneracy.md) carries the whole $S^2\times S^k$ family as critical and nondegenerate at its own dimension, and [fence-posts.md](../findings/fence-posts.md) lists $S^2\times S^6$, $S^2\times S^8$ among the nondegenerate two-block products.

The gap at $p=2$, from the same derivation:

$$g(2,n-2)=\frac{2/(n-3)}{\sqrt{(n-2)^2+2(n-2)+\frac{2(n-2)}{n-3}}}.$$

**It is strictly below the recorded floor at every $n\ge7$**, and here is the proof rather than the table. Write $D_2,D_3$ for the two squared norms. $D_2>(n-2)^2$. For $n\ge7$, $\frac{9(n-3)}{2(n-4)}\le\frac32(n-3)$, so $D_3<\frac34(n-3)^2+\frac92(n-3)=\frac34(n-3)(n+3)$. Hence

$$\frac{g(2,n-2)^2}{g(3,n-3)^2}=\frac{4(n-4)^2}{9(n-3)^2}\cdot\frac{D_3}{D_2}<\frac{4(n-4)^2}{9(n-3)^2}\cdot\frac{\tfrac34(n-3)(n+3)}{(n-2)^2}=\frac{(n-4)^2(n+3)}{3(n-3)(n-2)^2},$$

and $(n-4)^2<(n-2)^2$ together with $n+3\le3(n-3)$ for $n\ge6$ makes the right side $<1$. **QED.**

*One rational-arithmetic evaluation, because the record's claim is about specific tabulated numbers and only recomputing them can show which entry the table missed.* Exact fractions over $2\le p\le n/2$ give, at $n=8,10,12,14,16,20$: the recorded $p=3$ column $0.119523$, $0.062994$, $0.038925$, $0.026444$, $0.019139$, $0.011358$ reproduced digit for digit, and the $p=2$ column $0.056344$, $0.031497$, $0.020101$, $0.013937$, $0.010230$, $0.006182$. The gap is **monotone increasing in $p$** at every $n$ tested, so the minimiser is $p=2$, not $p=3$, and the floor is roughly halved.

The corrected floor over the two-block family is therefore

$$\mathrm{floor}(n)=\frac{2/(n-3)}{\sqrt{(n-2)^2+2(n-2)+\frac{2(n-2)}{n-3}}}\ \sim\ \frac2{n^2}.$$

### The asymptotic, REFUTED

$3/(n-4)\sim3/n$ and $\|M\|_F\sim\sqrt{\tfrac34}\,n=\tfrac{\sqrt3}2n$, so

$$\mathrm{floor}_{p=3}(n)\ \sim\ \frac{3/n}{(\sqrt3/2)n}=\frac{2\sqrt3}{n^2},$$

**not $2/n^{3/2}$.** At $n=100$ the closed form gives $3.6445\times10^{-4}$; $2\sqrt3/n^2$ gives $3.464\times10^{-4}$, while $2/n^{3/2}$ gives $2\times10^{-3}$, off by a factor of $5.5$ and diverging. The origin of the error is identifiable: $\sqrt{3(n-3)}\approx\sqrt3\,n^{1/2}$ is what you get by keeping **only** the $3(n-3)$ cross-pair term, and $(3/n)/(\sqrt3 n^{1/2})=\sqrt3/n^{3/2}\approx2/n^{3/2}$. The dropped term $\tfrac34(n-3)^2$ is the **dominant** one (three entries of size $O(n)$ beat $O(n)$ entries of size $1$) so the derivation discarded exactly the piece that sets the rate. The general two-block asymptotic is $g(p,n-p)\sim\sqrt{2p(p-1)}/n^2$, increasing in $p$, which is the structural reason the minimiser sits at the smallest admissible $p$.

For the record's *general-$p$* mechanism sentence, note also that $p/(q-1)$ is the smallest modulus only when $p<q$; at $p=q$ it exceeds $1$ and the cross entry wins. The record's balanced-product line is consistent with this but the mechanism sentence does not say it.

### Does the "decays polynomially, which a per-$n$ statement can absorb" reading hold?

**It is decoration.** A per-$n$ statement needs $\mathrm{floor}(n)>0$ for each $n$ and nothing more; the rate enters nothing downstream on the record. Worse, the rate as stated is wrong by a full power of $n$, so the one sentence where the rate is load-bearing-looking is the one sentence that is false. If a rate is ever needed (for instance to compare against a perturbation size in the closedness argument), it must be $n^{-2}$, and the constant depends on which $p$ the family is allowed to reach.

### A contradiction in the record that this claim sits on top of

The step that motivates the whole "smallest **nonzero** modulus" repair reads: *"Since paddings of graded points are graded, the infimum over the set is $0$ and the statement is vacuous."* Two paragraphs earlier the same file states the opposite: *"So every block sum and every padded critical point is **ungraded** with $S$ inherited"*, with a derivation, $\mathfrak h$ picks up the kernel directions $e_a\wedge e_z$, $e_b\wedge e_z$ and their bracket $\pm e_a\wedge e_b$ falls back into $\mathfrak m$, so $\mathfrak h$ stops being a subalgebra. The same file also says $W_{\mathbb{CP}^2}$'s *"ungradedness at larger $n$ is manufactured by padding"*.

**The derivation is right and the motivating sentence is wrong: paddings of graded points are not graded.** The repair's *conclusion* survives on other grounds, $W_{\mathbb{CP}^2}$ is graded in its native dimension $4$ with $\Lambda^2$-spectrum $(2,-1,-1,0,0,0)$, i.e. $W^-\equiv0$ on the anti-self-dual half, so a graded critical point carries a three-dimensional kernel with no padding at all, and $\min|\lambda|=0$ over the graded set regardless. But the *reason* on file is false, and it is the reason the quantity was changed. Anyone re-deriving from that sentence will conclude that paddings must be excluded from the graded set, which is the opposite of what the file's own algebra says.

---

## CLAIM 2, the calibration defect

### $\operatorname{tr}\mathring W=0$, CONFIRMED, and it is derivable, not measurable

Two lines, no numerics. On $S^2(\mathbb R^n)$, the diagonal basis vectors $e_a\otimes e_a$ contribute $R_{aaaa}=0$ and the off-diagonal ones $(e_a\otimes e_b+e_b\otimes e_a)/\sqrt2$ contribute $R_{abba}$, so $\operatorname{tr}\mathring R|_{S^2}$ is a fixed multiple of the scalar curvature. And $\mathring R(g)_{ij}=\sum_kR_{ikjk}=\mathrm{Ric}_{ij}$, so $\mathring R$ preserves the splitting $S^2=S^2_0\oplus\mathbb R g$ with $\mathring R(g)=\mathrm{Ric}$. For $W$ both traces vanish identically, hence $\mathring W(g)=0$ and $\operatorname{tr}\mathring W|_{S^2_0}=0$, so $\bar\lambda=0$. **The record's $10^{-16}$ at $n=5,6,7,8$ was measuring a theorem.**

### The lemma does not merely lose its constants, it is VACUOUS

Sharper than the record. Let $\mathring W$ be traceless with $\lambda_1\le\cdots\le\lambda_N$ and suppose $\lambda_1+\lambda_2\ge0$. If $\lambda_1\ge0$ then all are and the trace forces $\mathring W=0$. If $\lambda_1<0$ then $\lambda_j\ge\lambda_2\ge-\lambda_1>0$ for all $j\ge2$, so

$$0=\lambda_1+\sum_{j\ge2}\lambda_j\ \ge\ \lambda_1+(N-1)(-\lambda_1)=-(N-2)\lambda_1>0$$

for $N>2$, a contradiction. **So for a Weyl tensor the hypothesis $\lambda_1+\lambda_2\ge0$ holds only at $W=0$**, at every $n\ge3$. The record's "the $\theta(n,k)$ constants multiply zero" is true and too kind: the collapsed statement has an empty hypothesis set, so it is not a weaker theorem, it is no theorem.

### The brief's ratio question has a false premise

The right-hand side of Lemma 3.2 carries $\bar\lambda$ in every term; **the left-hand side, $\sum_j\lambda_j|S^jW|^2$, does not.** There is no common factor and therefore no ratio to take in the limit. The correct reading is not "$0\ge0$" but "a non-trivial inequality over an empty domain".

### The demotion is the WRONG DIRECTION, the defect repairs in one line, constants intact

$\bar\lambda$ is not an accident of Cheng–Wang's proof; it is the coordinate along which the Weyl tensor was projected out. Restore it. Let $R_1$ be the constant-curvature tensor, $(R_1)_{ikjl}=\delta_{ij}\delta_{kl}-\delta_{il}\delta_{kj}$; then $\mathring R_1h=\delta\operatorname{tr}h-h=-h$ on $S^2_0$, so $\mathring R_1=-\mathrm{Id}$ there. Set $R_s=W-sR_1$ for $s>0$. Then

- $\mathring R_s=\mathring W+s\,\mathrm{Id}$, same eigenbasis $\{S^j\}$, eigenvalues $\lambda_j+s$, and $\bar\lambda(R_s)=s>0$;
- the Weyl part of $R_s$ is $W$ unchanged, so every $|S^jW|^2$ is untouched;
- $\sum_j\lambda_j(R_s)^2=\sum_j\lambda_j^2+Ns^2$, the cross term vanishing because $\sum\lambda_j=0$.

That last line is a check, not an assumption: substituting into Lemma 3.1 requires $\frac32n(n-1)-(n-1)^2=\frac{(n+2)(n-1)}2=N$, which is an identity. **The shift reproduces Lemma 3.1 exactly**, so $s$ is precisely the missing coordinate.

Feed $R_s$ into Lemma 3.2. The hypothesis becomes $\lambda_1+\lambda_2\ge-2(1+\theta)s$, non-vacuous for every $W$ once $s$ is large enough. The conclusion becomes, after the two $Ns^3$ terms **cancel exactly**,

$$\boxed{\ \sum_{j=1}^N\lambda_j|S^jW|^2\ \ge\ -s\sum_{j=1}^N|S^jW|^2-\frac{16(N-3)}{3n}\,\theta(n)\,s\sum_{j=1}^N\lambda_j^2\ }$$

valid whenever $\lambda_1+\lambda_2\ge-2(1+\theta)s$. Choosing the smallest admissible $s=\max\{0,-\frac{\lambda_1+\lambda_2}{2(1+\theta)}\}$ and using $\sum_j|S^jW|^2=\frac{4N-12}n|W|^2$ gives a partial-sum transfer **calibrated by $\lambda_1+\lambda_2$ and $\|W\|$ instead of $\bar\lambda$, with the published $\theta(n)$ surviving verbatim.** This is exactly the recalibration the record hoped "might survive as a mechanism"; it turns out to be a change of origin, not a re-proof.

This is legitimate because Lemma 3.2's proof, read at [paper.txt](https://arxiv.org/abs/2508.11226) L313–L360, is **pointwise algebra on an Einstein algebraic curvature tensor**: eigenvalue ordering, the cone hypothesis, the two identities $\sum_j|S^jW|^2=\frac{4N-12}n|W|^2$ and $|S^jW|^2\le\frac{8n-16}n|W|^2$ quoted from [9], and Lemma 3.1. No Bochner term, no integration. $R_s$ has Ricci a multiple of $g$ at the point, so it satisfies everything the lemma consumes.

### One defect in the source, which the route would inherit

Step (3.7). The paper sets $A=\sum_j|S^jW|^2-2|S^\alpha W|^2$, proves the **lower** bound $A\ge\frac{2(n^2-7n+8)}n|W|^2\ge0$, and then concludes $A\lambda_3\ge-\theta\bar\lambda\frac{2(n^2-7n+8)}n|W|^2$. For $\lambda_3\ge0$ that is immediate. For $\lambda_3<0$, which the hypothesis permits, since it gives only $\lambda_3\ge\lambda_2\ge\frac{\lambda_1+\lambda_2}2\ge-\theta\bar\lambda$, multiplying a **lower** bound on $A$ by a negative number reverses it, and the step needs an **upper** bound instead, $A\le\sum_j|S^jW|^2=\frac{2(n^2+n-8)}n|W|^2$. The repair is available and costs only a larger constant in that term, which then propagates into $\theta(n)$. **Anyone borrowing Lemma 3.2 must re-derive that constant.**

### Verdict on the demotion

The finding that $\bar\lambda=0$ is correct and is a theorem. The inference drawn from it (that the route loses the constants), is **wrong**. The route loses the *origin*, and restoring it is one line with the constants intact. 3a should not have been demoted; if anything the shift is the sub-step (2) the item asked for ("adapt the splitting argument to a critical $W$, pointwise algebra with no Bochner term"), now done.

---

## CLAIM 3, the split and the grades

### 3a, graded $3\times2\times1=6$ with *attackable* $=2$ "mechanism may survive, constants do not"

**The stated reason is refuted.** Both mechanism and constants survive under the shift; what does not survive is the *unshifted* application. Under the rubric's own reading, attackable $=3$: the item now has a concrete inequality in hand and a named first computation, evaluate the boxed bound at $W_{\mathbb{CP}^2}$ and at the $n=5$ point $\theta^2=24/35$, which is verbatim sub-step (1). Against that, the $\lambda_3<0$ gap in (3.7) is real work. Net: **$3\times3\times1=9$, or $3\times2\times1=6$ if the (3.7) repair is counted as un-spent, but not with the recorded justification.**

### 3b, graded $3\times2\times1=6$, **both factors are unsupported**

*closes $=3$.* The item's deliverable is closedness of the graded critical set. The record's own text says: *"closedness may not be on the critical path at all: the compactness step needs only $G$ open."* An item that may close nothing cannot be scored $3$ on closing. **Owed before the grade stands: one sentence saying what closedness buys.** Note also the shape mismatch, item 3 is a supremum over **non-diagonal $S=0$ critical** points, and the record carries explicit $S=0$ **ungraded** critical points (Clebsch at $n=16$, the three $\theta=0.104886$ cone points with $S_{\mathfrak{mmm}}=7\times10^{-30}$, $S_{\mathfrak{hhm}}=17$), so a gap over the *graded* set does not obviously reach them.

*attackable $=2$, "obligation isolated to one estimate".* The sub-step-1 deliverable is a floor over a **finite hand-listed** family, and this review has just shown the list was missing a member the record itself tabulates, halving the answer. A quantity that moves by a factor when one more known member is admitted is not an estimate isolated to one step; it is a minimum over a list whose closure is unknown. The record already warns of this (61 distinct critical points inside a single grading at $n=6$) and multi-block products *interleave* rather than extending the trend, so the family is not even monotonically ordered. **Attackable $1$ until the graded critical set is characterised rather than enumerated.**

### The tie-break, INVERTED

3b was sorted above 3a because "its obligation is a single named estimate rather than a recalibration". On the corrected findings that is backwards:

- 3a's recalibration is **done** (one shift, constants intact), and its remaining obligation *is* a single named estimate: repair (3.7) at $\lambda_3<0$ and evaluate the boxed inequality at the two known non-diagonal points.
- 3b's obligation is **not** a single estimate. It is a bound over a set the project cannot yet describe, resting on a step whose necessity the record itself questions, whose motivating sentence about padding contradicts the same file's derivation, and whose one concrete output has just been shown to be a minimum over an incomplete list.

**3a should sort above 3b.**

---

## Answers to the brief's questions

**(a) Anything asserted as new that the record already holds.** Yes, and it is the *same failure mode for the third time*. Claim 1 asserts $p=3$ is "the most unbalanced product" while [graded-half.md](../findings/graded-half.md) tabulates $S^2\times S^{10}$ as a graded critical point at $n=12$ and [nondegeneracy.md](../findings/nondegeneracy.md) carries the entire $S^2\times S^k$ family. The record has already been burned twice by exactly this: [fence-posts.md](../findings/fence-posts.md) records *"The commit stated the analysis over integers $p,q\ge2$ … $S^2\times S^q$ is nondegenerate, but $c_B=3/(q-1)>0$ means it is not a local maximum, a live exception the blanket sentence hid"*, and [target.md](../findings/target.md) records *"The record's '$\sup_m\theta=\sqrt{6/5}$ at $m=3$' silently started the family at $m=3$ and never said why."* **A family silently started at index $3$, three times, at the same index.** The generating script makes it visible: `for p in range(3, n//2+1)` with `if q<3: continue`, an unexplained restriction that the prose then reported as a structural fact.

**(b) Is "whether the full graded critical set respects the floor is untouched" still the right statement of what 3b owes?** It is still true and it is now **weaker than what is owed**. The closed form has changed the position for the worse in two ways. First, the floor is not stable under widening the *named* list, which is the mildest possible widening, admitting one family the record already carries moved it by a factor of about $\sqrt3$. Second, the direction of that move is the dangerous one: the floor went **down**, and the family's asymptotic $\sqrt{2p(p-1)}/n^2$ is minimised at the smallest admissible $p$, so the recorded "floor" is really an artefact of where the enumeration was cut off. The honest statement is: **there is no floor over the named families until the family is closed, and there is currently no argument that the named list is closed under anything.** The falsifier is unchanged and remains the right one.
