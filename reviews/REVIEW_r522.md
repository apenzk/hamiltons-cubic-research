# REVIEW r522, Lemma L37, "diagonality is decided by a single kernel"

**Target:** [findings/target.md:632](../findings/target.md#L632), `#### Lemma L37`, down to the next heading ([target.md:639](../findings/target.md#L639)).
**Reviewer:** r522, cold, adversarial. Analysis-only footing inherited; nothing below was computed, every number I quote against the record is derived by hand and compared to a number the record already holds.

**Statement audited, verbatim from the block.** *For $W\in\mathcal W_n$ let $\delta_A(X)=AX+XA$ for symmetric $A$, and let $\Phi_W(A)=[W,\delta_A]$. Then $W$ is diagonal in some orthonormal frame if and only if some $A\in\ker\Phi_W$ has pairwise-distinct sums $a_i+a_j$. In particular $\dim\ker\Phi_W<n$ certifies non-diagonality outright.*

## VERDICT: CONFIRMED

**The mathematics is right, in both directions and in the corollary, and I derived all three from the definitions without using the record.** The block is nonetheless defective in three ways that a reader would trip on, none of them touching the truth of the statement: its proof pointer names a section that contains no proof, two consumers cite a strengthening L37 does not contain, and two others under-read it as "silent" where it is not.

---

## 1. The pointer is FALSE, and the argument is not in `target.md` at all

The block says *"the argument is in this file under **'What survives, because it was verified directly rather than taken from'**"*.

- That section exists, at [target.md:383](../findings/target.md#L383), full title *"What survives, because it was verified directly rather than taken from the review"*. Its subject is the $(\mathfrak{su}(m),\mathfrak{so}(m))$ Kähler family and its closed-form $\theta^2=X/(X-2)$. It contains **one** occurrence of the operator, the parenthesis *"non-diagonal ($\dim\ker\Phi_W=1$)"*, a reported measurement. **No definition of $\delta_A$, no direction of the equivalence, no argument.**
- Where L37 actually lives in `target.md`: [Post F22, target.md:474](../findings/target.md#L474) *defines* $\Phi_W$ and $\delta_A$ and tabulates $\dim\ker\Phi_W$; [target.md:508–510](../findings/target.md#L510) *states* the equivalence and the corollary. **Neither derives either direction.** Nor does anything else in [findings/](../findings/), I grepped `Phi_W`, `delta_A`, "distinct sums" across `findings/`, `results.md`, `plan.md`, `ATTEMPTS.md`: every hit is a statement, a table row, or a citation.
- **The only argument in the repository is a docstring**: [b_frame_independent_diagonality.py:63-72](../scripts/lib/b_frame_independent_diagonality.py#L63), which carries both directions in two lines and is correct as far as it goes. A lemma the record grades **Proven** ([results.md:16](../results.md#L16)) has its whole proof inside a Python comment.
- [results.md:474](../results.md#L474) closes its L37 block with **`Proof: target.md`**. That pointer is dangling for the same reason.
- [ELIM-target.md:179](ELIM-target.md#L179) already flagged the pointer **wrong** and redirected to `target.md:519`. **That redirect is also wrong**, line 519 is blank, inside the *"band's hard stratum … RETRACTED"* section at [target.md:516](../findings/target.md#L516). The intended line is [target.md:510](../findings/target.md#L510), and even that is a statement, not an argument.

**Repair.** Replace the pointer with the two-line proof written out in the block (it is two lines; §2–§3 below are it), and change [results.md:474](../results.md#L474)'s `Proof:` to point at the block once it carries one. Do **not** repoint at [target.md:383](../findings/target.md#L383) or `:519`.

## 2. The easy direction, holds, and the genericity is achievable

Let $\{e_i\}$ be an orthonormal frame with every $\varphi_{ij}=e_i\wedge e_j$ a $W$-eigenvector, $W\varphi_{ij}=\mu_{ij}\varphi_{ij}$ (this is [conventions.md](../findings/conventions.md)'s sense of "diagonal": *diagonal in coordinate 2-planes of an orthonormal frame of $\mathbb R^n$*, which is the sense L37 needs, see §5).

For $A$ symmetric, $\delta_A(X)=AX+XA$ is well-defined **on $\Lambda^2$**: $X$ skew $\Rightarrow(AX+XA)^{\mathsf T}=X^{\mathsf T}A+AX^{\mathsf T}=-(AX+XA)$. With $A=\mathop{\mathrm{diag}}(a_1,\dots,a_n)$ in that frame, $\delta_A\varphi_{ij}=(a_i+a_j)\varphi_{ij}$, $\delta_A$ is the derivation extension of $A$ to $\Lambda^2$. So $\delta_A$ and $W$ are simultaneously diagonal in $\{\varphi_{ij}\}$, hence commute, hence $A\in\ker\Phi_W$.

**Achievability of distinctness, which the block leans on silently.** The $a_i$ are $n$ free reals and the constraints are $\binom{\binom n2}{2}$ hyperplanes $a_i+a_j=a_k+a_l$, $\{i,j\}\ne\{k,l\}$. Each is a *proper* hyperplane, because $a_i=3^i$ satisfies none (base-3 digits make $\{i,j\}$ recoverable from $3^i+3^j$). A finite union of proper hyperplanes has empty interior, so distinct-sum $A$'s are dense and of full measure in the frame's $n$-dimensional diagonal space. **The block's "*some* $A$" is the right quantifier and it is not vacuous.** Requiring distinctness of *every* $A$ in the kernel would make the lemma false at once ($A=\mathrm{Id}$ has all sums equal and is always in the kernel).

## 3. The hard direction, holds, and the mechanism is exactly as advertised

Let $A\in\ker\Phi_W$ have pairwise-distinct sums. Three steps.

1. **$\Phi_W(A)=0$ is literally $[W,\delta_A]=0$.** $\Phi_W$ is defined as that commutator, and $W,\delta_A$ are both linear endomorphisms of $\Lambda^2\mathbb R^n$, so there is no second reading. ($\Phi_W$ is also linear in $A$ ($\delta_A$ is) so $\ker\Phi_W$ is a genuine linear subspace of $\mathop{\mathrm{Sym}}(n)$, which §4 needs.)
2. **Distinct sums force $A$ to have simple spectrum, for $n\ge3$.** If $a_i=a_j$ with $i\ne j$, pick $k\notin\{i,j\}$; then $a_i+a_k=a_j+a_k$ with $\{i,k\}\ne\{j,k\}$. So $A$ has an orthonormal eigenframe $\{e_i\}$, unique up to order and sign.
3. **$\delta_A$ has simple spectrum on $\Lambda^2$ with eigenvectors exactly $e_i\wedge e_j$.** From step 2's frame, $\delta_A(e_i\wedge e_j)=(a_i+a_j)\,e_i\wedge e_j$, and the $\binom n2$ eigenvalues are pairwise distinct by hypothesis, so the eigen*lines* are exactly $\mathbb R\,e_i\wedge e_j$ and there are no others. $[W,\delta_A]=0$ then forces $W$ to preserve every eigenline of $\delta_A$, i.e. $W e_i\wedge e_j\in\mathbb R\,e_i\wedge e_j$. **$W$ is diagonal in $A$'s eigenframe.** $\square$

$\mathcal W_n$-membership is never used; the lemma holds for any symmetric operator on $\Lambda^2$. First Bianchi is no obstruction on the diagonal side either, for $\{i,j\}\ne\{k,l\}$-vanishing $W$, every term of $W_{ijkl}+W_{jkil}+W_{kijl}$ vanishes when $i,j,k$ are distinct.

## 4. The threshold $n$, exact, one-directional, and non-vacuous

**Why $n$.** $\ker\Phi_W\ni\mathrm{Id}$ always ($\delta_{\mathrm{Id}}=2\,\mathrm{Id}_{\Lambda^2}$). If $W$ is diagonal in a frame, §2 puts the whole $n$-dimensional space of matrices diagonal in that frame inside $\ker\Phi_W$, $\mathrm{Id}$ among them, so the count is $n$, not $n+1$. Contrapositive: $\dim\ker\Phi_W<n\Rightarrow$ non-diagonal. **Sound, with no hidden hypothesis**, "outright" is honest, and in particular needs no eigenvalue-multiplicity assumption, which is exactly where the rank tests of [b_frame_independent_diagonality.py](../scripts/lib/b_frame_independent_diagonality.py) need one.

**$n$ cannot be raised.** Take $W$ diagonal with all $\binom n2$ sectional values $\mu_{ij}$ distinct. Then $[W,\delta_A]=0$ forces $\delta_A$ diagonal in $\{\varphi_{ij}\}$; the $\varphi_{kj}$-coefficient of $\delta_A\varphi_{ij}$ is $A_{ki}$ for $k\ne i$, so $A$ is diagonal and $\dim\ker\Phi_W=n$ exactly. A threshold of $n+1$ would then wrongly certify this $W$ non-diagonal. *(Caveat I owe: such a $W$ needs $n\ge5$. At $n=4$ the hollow row-sum-zero conditions force $K_{12}=K_{34}$, $K_{13}=K_{24}$, $K_{14}=K_{23}$, so no diagonal Weyl tensor at $n=4$ has distinct sectional values. Sharpness of the threshold is therefore demonstrated from $n=5$ up; the lemma itself is unaffected.)*

**$n$ cannot be lowered** without weakening a valid certificate.

**One-directional, and the record knows it.** $\dim\ker\Phi_W\ge n$ does **not** imply diagonal. Padded $W_{\mathbb{CP}^2}$ at $n=8$ has kernel dimension $11>8$ and is non-diagonal, [target.md:510](../findings/target.md#L510) records exactly this trap. The block's "certifies … outright" is correctly one-way; §6 lists the two places the converse is nonetheless used.

**Non-vacuity, established here analytically, where the record has only measurements.** Take $W=W_{\mathbb{CP}^m}$ on $\mathbb R^{2m}$ with complex structure $J$, so $\Lambda^2=\mathbb R\omega\oplus\mathfrak{su}(m)\oplus\mathfrak m$ ($\omega=J$, $\mathfrak m=[\Lambda^{2,0}\oplus\Lambda^{0,2}]_{\mathbb R}$) with three *distinct* $W$-eigenvalues, at $m=2$ these are $2c,0,-c$, matching $W^+=\mathop{\mathrm{diag}}(2,-1,-1)c$, $W^-=0$. Split $\mathop{\mathrm{Sym}}(2m)=\{A:AJ=JA\}\oplus\{A:AJ=-JA\}$ via $A\mapsto\tfrac12(A\mp JAJ)$.
- $AJ=JA$: $\delta_A$ preserves $\mathfrak u(m)$ and $\mathfrak m$, but $\delta_A\omega=2AJ$, whose $\omega$-component is $\propto\mathop{\mathrm{tr}}A$ and whose $\mathfrak{su}$-component vanishes only for $A$ scalar. Since $[W,\delta_A]\omega=2(W-\lambda_\omega)(AJ)$ and $\lambda_\omega\ne\lambda_{\mathfrak{su}}$, the bracket is nonzero unless $A\in\mathbb R\,\mathrm{Id}$.
- $AJ=-JA$: $J\delta_A(X)=-\delta_A(X)J$ for $X\in\mathfrak u(m)$, so $\delta_A$ swaps $\mathfrak u(m)\leftrightarrow\mathfrak m$; with $\lambda_{\mathfrak u}\ne\lambda_{\mathfrak m}$, $[W,\delta_A]=0$ forces $\delta_A=0$, hence $A=0$.

So $\ker\Phi_{W_{\mathbb{CP}^m}}=\mathbb R\,\mathrm{Id}$, **dimension $1<n$: the criterion fires, analytically, at the record's flagship non-diagonal point.** This matches all four $\mathbb{CP}^m$ rows of [Post F22's table](../findings/target.md#L478).

**Three further rows of that table fall out of the same computation, which is the strongest independent check I can offer it.** For $W$ supported on $\Lambda^2V$, $\mathbb R^n=V\oplus V'$: a cross-block $A=\binom{0\;C^{\mathsf T}}{C\;\;0}$ has $\delta_A|_{\Lambda^2V}:X_0\mapsto CX_0$, so $[W,\delta_A]=0$ forces $C\cdot\mathop{\mathrm{im}}W_0=0$, and $\mathop{\mathrm{im}}W_0\ni J$ invertible gives $C=0$; the block-diagonal part contributes $\ker\Phi_{W_0}\oplus\mathop{\mathrm{Sym}}(V')$. Hence
- padded $\mathbb{CP}^2$ at $n=8$: $1+\dim\mathop{\mathrm{Sym}}(4)=1+10=\mathbf{11}$, **the recorded 11**;
- padded $\mathbb{CP}^3$ at $n=8$: $1+\dim\mathop{\mathrm{Sym}}(2)=1+3=\mathbf 4$, **the recorded 4**;
- $\mathbb{CP}^2{\oplus}\mathbb{CP}^2$ at $n=8$: $1+1=\mathbf 2$, and $\mathbb{CP}^2{}^{\times3}$: $\mathbf 3$, **the recorded 2 and 3**.

It also reproduces Reviewer 78's witness cited in the script: $\mathbb{CP}^2{\oplus}\mathbb{CP}^2$ inside $n=12$ has kernel $\mathbb R I_4\oplus\mathbb R I_4\oplus\mathop{\mathrm{Sym}}(4)$, dimension $1+1+10=12=n$, the corollary is silent, yet every kernel element has $a_1=a_2=a_3=a_4$, so $a_1+a_2=a_3+a_4$ and no distinct-sum $A$ exists: **non-diagonal by the equivalence, invisible to the corollary.** The script's comment reports exactly this ("spread 1.1e-16").

## 5. Frame-independence, delivered

$\delta$ is $O(n)$-equivariant: for $g\in O(n)$ and $\rho(g)=\Lambda^2g$, $\rho(g)\delta_A\rho(g)^{-1}(X)=g\big(A\,g^{\mathsf T}Xg+g^{\mathsf T}Xg\,A\big)g^{\mathsf T}=gAg^{\mathsf T}X+XgAg^{\mathsf T}=\delta_{gAg^{\mathsf T}}(X)$. Hence $\Phi_{\rho(g)W\rho(g)^{-1}}(gAg^{\mathsf T})=\rho(g)\Phi_W(A)\rho(g)^{-1}$, so $\ker\Phi_{gW}=g(\ker\Phi_W)g^{\mathsf T}$ and $\dim\ker\Phi_W$ is an $O(n)$-invariant. The distinct-sums condition is on $\mathop{\mathrm{spec}}(A)$, also invariant. **Both halves of the criterion are frame-free, and $\Phi_W$ is defined with no reference to a frame**, the quantification over $A$ is what carries the frame, and it is quantified away. This is the property [findings/INDEX.md:23](../findings/INDEX.md#L23) leans on ("well posed since the $\ker\Phi_W$ test") and [target.md:532](../findings/target.md#L532) demands after the census's frame-dependent $\max|W-\mathop{\mathrm{diag}}W|$ bug; **L37 supplies it.**

**The trap L37 could have fallen into and does not.** [conventions.md](../findings/conventions.md) warns that *"diagonal" means diagonal in coordinate 2-planes $e_i\wedge e_j$ of an orthonormal frame of $\mathbb R^n$, not diagonal as an operator on $\Lambda^2$*. The hard direction lands on the correct side: the basis it produces is $\{e_i\wedge e_j\}$ for $\{e_i\}$ an orthonormal frame of $\mathbb R^n$ (step 2's eigenframe of $A$), never a bare $\Lambda^2$ eigenbasis. Checked explicitly because this is the conflation the conventions file says "makes the diagonal case look liftable".

## 6. The citations, one strengthening, one under-reading, one broken link

| # | site | what it takes | verdict |
|---|---|---|---|
| 1 | [results.md:16](../results.md#L16) | status row, "**Proven** (Lemma L37)" | statement true; **"Proven" is unbacked in the record** (§1) |
| 2 | [results.md:160](../results.md#L160), [results.md:470](../results.md#L470) | the equivalence + the corollary, with the $n$-dimensional subspace spelled out | **correct**, and a better statement than the `target.md` block |
| 3 | [results.md:166](../results.md#L166), [:488](../results.md#L488), [target.md:654](../findings/target.md#L654) (Obs. L40) | the equivalence, as the decision procedure separating the census | **correct use**, L40 needs the iff, not the corollary, and says so |
| 4 | [ATTEMPTS.md:2564](../ATTEMPTS.md#L2564) | "returns $\dim\ker\Phi_W=8=n$ … proves nothing either way, the certificate only bites below $n$" | **corollary correctly read; the lemma under-read** (below) |
| 5 | [bounds.md:142](../findings/bounds.md#L142) | "$\dim\ker\Phi_W=8=n$ leaves Lemma L37 silent" | same under-reading |
| 6 | [REVIEW_r296.md:70](REVIEW_r296.md#L70), [:128](REVIEW_r296.md#L128) | *"Lemma L37's own sufficient test … if a **simple** eigenvalue has an eigenvector of bivector rank $>2$ …"*, called "the lemma's rank corollary" | **STRENGTHENING L37 DOES NOT CONTAIN** |
| 7 | [reviews/INDEX.md:460](INDEX.md#L460) | repeats it, "so Lemma L37 decides the case rather than being silent" | same misattribution, now in the review index |
| 8 | [reviews/plan-diagfam.md:45](plan-diagfam.md#L45), [:50](plan-diagfam.md#L50), [:55](plan-diagfam.md#L55), [:57](plan-diagfam.md#L57), [:59](plan-diagfam.md#L59) | the set characterisation $O=\{W:\ker\Phi_W\ni A$ with distinct sums$\}$, plus "$\dim\ker\Phi_W\ge n$ on $O$ and the kernel dimension is upper semicontinuous" | **correct**, the necessary condition, in the safe direction; semicontinuity is right, $\ker$ of a linear map depending continuously on $W$ |
| 9 | [ATTEMPTS.md:3713](../ATTEMPTS.md#L3713) | the same characterisation | **correct claim, broken link**, cites `findings/diagonal-half.md`; L37 lives in [findings/target.md](../findings/target.md) |
| 10 | [ELIM-target.md:60](ELIM-target.md#L60) | "criticality never enters $\Phi_W(A)=[W,\delta_A]$" | **correct**, I used no criticality anywhere above |

**Citation 6/7 is the real defect.** The rank criterion (*a simple eigenvalue whose eigenvector has bivector rank $>2$ certifies non-diagonality*), is a **different theorem** with a **different proof** (in a diagonalising frame a simple eigenline must *be* some $\mathbb R\,e_i\wedge e_j$, of rank 2). It is implemented separately, in [simple_eigen_ranks](../scripts/lib/b_frame_independent_diagonality.py) and [eigenspace_has_no_rank2](../scripts/lib/b_frame_independent_diagonality.py), and the script's own header presents it as *"A SUFFICIENT TEST"* distinct from *"REVIEWER 75'S TEST"*. It is true; **it is not L37, and L37 has no "rank corollary".** [REVIEW_r296.md:128](REVIEW_r296.md#L128) then uses the misattribution to *overturn* [bounds.md:142](../findings/bounds.md#L142), one wrong claim correcting another.

**Citations 4/5 are wrong in the opposite direction, and the correction is worth having.** L37 is *not* silent at $\dim\ker\Phi_W=n$. The equivalence is decidable at any kernel dimension: "some $A\in\ker\Phi_W$ has pairwise-distinct sums" is the non-vanishing on $\ker\Phi_W$ of the polynomial $p(A)=\prod_{\{i,j\}\ne\{k,l\}}\big((a_i+a_j)-(a_k+a_l)\big)^2$, a symmetric function of $\mathop{\mathrm{spec}}A$ and so a polynomial in the entries of $A$. Restricted to the *linear* subspace $\ker\Phi_W$, either $p\equiv0$ (no distinct-sum $A$; $W$ non-diagonal) or its non-vanishing locus is Zariski-open **and dense**. There is no third case, so **L37 never returns "undetermined"**, only its dimension corollary does. This is exactly the argument the script comment gives for its `prob. 1` branch, and it is sound; **it belongs in the block, not in a comment.** With it, the $n=8$ witness of [bounds.md:142](../findings/bounds.md#L142) is decided by L37 after all, by the equivalence, not by any rank test.

## 7. Contradictions from below and elsewhere, none found

- Everything after [target.md:632](../findings/target.md#L632) (L39, L40, L41, L45, L49), is consistent; L40 at [:654](../findings/target.md#L654) uses the criterion in the safe direction.
- [Post F22](../findings/target.md#L474) and [trap 22](../findings/INDEX-traps.md#L51) restrict L37 to *defining* the target set rather than bounding $\theta$, a restriction, not a contradiction, and correct: $\dim\ker\Phi_W=1$ at both $\mathbb{CP}^m$ and random Weyl tensors whose $\theta$ differ by an order of magnitude.
- [diagonality.md:57](../findings/diagonality.md#L57) calls $\ker\Phi_W$ "the one test that is necessary and sufficient", consistent.
- [conventions.md](../findings/conventions.md)'s independent frame-free diagonality test, $t=\max_F t_F=2$ iff coordinate-diagonal in some frame, agrees with L37 in verdict and does not compete with it (it is an optimisation over $O(n)$; L37 is linear algebra in a fixed presentation).

**One defect found outside the block, in the implementing script.** [b_frame_independent_diagonality.py:74](../scripts/lib/b_frame_independent_diagonality.py#L74), inside `ker_Phi_dim`'s docstring: *"the $C_5$ blow-up and its generic $SO(10)$ rotation both return $15\ge n=10$, i.e. **DIAGONAL**"*. That is the converse of the corollary and is invalid, it is the identical inference that [target.md:510](../findings/target.md#L510) records as having *"wrongly called padded $W_{\mathbb{CP}^2}$ diagonal"*. The verdict happens to be right for $C_5$, and the live function `diagonalisable` does **not** make this inference (it runs the distinct-sum search), so nothing downstream is wrong; the sentence should still be repaired.

## 8. What I would fix, in order

1. **[target.md:634](../findings/target.md#L634)**, delete the false pointer and inline the proof: §2 and §3 above are four sentences.
2. **[REVIEW_r296.md:70](REVIEW_r296.md#L70), [:128](REVIEW_r296.md#L128), [reviews/INDEX.md:460](INDEX.md#L460)**, the rank test is not L37's; name it as the separate criterion it is.
3. **[bounds.md:142](../findings/bounds.md#L142), [ATTEMPTS.md:2564](../ATTEMPTS.md#L2564)**, "$\dim\ker\Phi_W=n$ leaves L37 silent" → "leaves L37's *dimension corollary* silent; the equivalence still decides".
4. **Promote the Zariski argument of §6** into the block: it upgrades L37 from a criterion to a decision procedure, and it is what makes [INDEX.md:23](../findings/INDEX.md#L23)'s "well posed" claim actually well posed.
5. **[ATTEMPTS.md:3713](../ATTEMPTS.md#L3713)**, link `findings/target.md`, not `findings/diagonal-half.md`.
6. **[results.md:474](../results.md#L474)**, `Proof: target.md` is dangling until (1) lands.
7. **[b_frame_independent_diagonality.py:74](../scripts/lib/b_frame_independent_diagonality.py#L74)**, the "$15\ge n$, i.e. DIAGONAL" sentence uses the invalid converse.

## 9. Bearing on the abstract

The abstract's *"well posed"* rests on L37 supplying a frame-independent test for diagonality. **It does.** §5 shows both halves of the criterion are $O(n)$-invariant, §2–§3 show the equivalence is a theorem, and §6 shows it is decidable at every kernel dimension. **The abstract's claim survives this audit intact**, it is the *provenance* of the lemma inside the record, not the lemma, that is broken.

---

*No computation was run for this review. Every value quoted against the record ($1$ at $\mathbb{CP}^m$; $11$, $4$, $2$, $3$ at the paddings and sums; $a_1=a_2=a_3=a_4$ at $\mathbb{CP}^2{\oplus}\mathbb{CP}^2$ in $n=12$) is derived by hand in §4 and then compared with the number the record already carries.*
