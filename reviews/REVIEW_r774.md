# Gate 2, reviewer r774, L179's support reduction and L180's PSD form of Ricci-flatness

**The brief was cold: I worked from [BRIEF-g2-l179-l180.md](BRIEF-g2-l179-l180.md) alone and did not open [findings/](../findings/). No numerical work was done, every value in this report is exact, derived by hand in closed form, and the one machine step is a rational-arithmetic screen of an object I had already constructed and derived, reported as a screen and never as evidence.** Log: [agent_logs/g2-l180-r774.log](../agent_logs/g2-l180-r774.log).

## Claim table

| # | Claim | Verdict |
| --- | --- | --- |
| L179(a) | $W$ is supported on $\Lambda^2V$ | **SOUND**, with one convention used and unstated |
| L179(b) | First Bianchi $\iff\sum_{\lambda_\alpha\ne0}\lambda_\alpha\,\omega_\alpha\wedge\omega_\alpha=0$ | **SOUND**, the map is $2\times$ the Bianchi sum, harmless for a vanishing statement |
| L179(c) | Rank one is impossible | **SOUND** |
| L179(d) | All decomposable $\Rightarrow$ (b) free and $\dim V\le6$; the three planes are not mutually orthogonal | **SOUND BUT WEAKER THAN IT READS**, orthogonality is excluded, $\dim V=6$ is not |
| L180(1) | Ricci-flatness $\iff\sum_i\lambda_iA_i=0$, $A_i\succeq0$, $\mathop{\mathrm{tr}}A_i=2$ | **SOUND** |
| L180(2) | Tracelessness is the trace of (1) | **SOUND** |
| L180(3) | $V$ is the minority-sign form's support; $\dim V$ even and $\ge4$ | **SOUND, AND IT DOES NOT CIRCLE** |
| L180(4) | Rank two forces $A_1=A_2$ | **SOUND** |
| item 2 | Normalisation $W_{abcd}=\sum_i\lambda_i(\omega_i)_{ab}(\omega_i)_{cd}$ | **NO FACTOR, CLEAN.** No $2$, no $\tfrac12$ |
| item 5 | Range additivity of PSD sums | **TRUE, AND UNARGUED ON FILE, `HYPOTHESIS-DEBT`.** Now sourced and proved here |
| item 11 | Does any step assume $\ker W=0$? | **NO STEP DOES** |
| item 13 | "$\dim V\ge6$ is the whole of what remains" | **REFUTED IN CLOSED FORM** |

**One-line action.** L179 and L180 stand as written and need only two citations and one convention sentence; the record's downstream "$\dim V\ge6$ is the whole of what remains" must be struck, because $W=\omega_1\otimes\omega_1+\omega_2\otimes\omega_2-2\,\omega_3\otimes\omega_3$ on the self-dual forms of an $\mathbb R^4\subseteq\mathbb R^n$ is a rank-three algebraic Weyl tensor with $\dim V=4$.

## 0. Conventions, fixed once

Everything below is in the brief's own conventions and adds nothing to them.

- $\{f_a\wedge f_b\}_{a<b}$ is orthonormal in $\Lambda^2\mathbb R^n$; $\omega=\sum_{a<b}\omega_{ab}f_a\wedge f_b$; $\langle\omega,\eta\rangle=\sum_{a<b}\omega_{ab}\eta_{ab}$; $\lVert\omega\rVert^2=\sum_{a<b}\omega_{ab}^2$.
- $(\omega_{ab})$ is extended antisymmetrically to all index pairs, so $\omega_{ba}=-\omega_{ab}$ and $\omega_{aa}=0$. Under that extension $\mathop{\mathrm{tr}}(\omega\omega^{\mathsf T})=\sum_{a,b}\omega_{ab}^2=2\lVert\omega\rVert^2$ and $\omega^{\mathsf T}=-\omega$, so $-\mathop{\mathrm{tr}}(\omega^2)=2\lVert\omega\rVert^2$, consistent with the brief's $\lVert\omega\rVert^2=-\tfrac12\mathop{\mathrm{tr}}(\omega^2)$.
- $W(f_a\wedge f_b)=\sum_{c<d}W_{abcd}f_c\wedge f_d$, hence $W_{abcd}=\langle W(f_a\wedge f_b),f_c\wedge f_d\rangle$ for $a<b$, $c<d$.
- $\omega\otimes\omega$ is $\eta\mapsto\langle\omega,\eta\rangle\,\omega$.
- $A_i=-\omega_i^2=\omega_i\omega_i^{\mathsf T}$; $\mathop{\mathrm{supp}}\omega=\mathop{\mathrm{Im}}(\omega)$; $V=\sum_{\lambda_\alpha\ne0}\mathop{\mathrm{supp}}\omega_\alpha$.
- $B_{abcd}:=W_{abcd}+W_{acdb}+W_{adbc}$ is the Bianchi sum. $\mathfrak b:S^2\Lambda^2\to\Lambda^4$, $\omega\odot\eta\mapsto\omega\wedge\eta$.
- "Rank" always means $\Lambda^2$-rank, the number of nonzero eigenvalues of $W$ as a self-adjoint operator on $\Lambda^2\mathbb R^n$.

## Hypothesis inventory

### Used and stated

| Hypothesis | Where it does work |
| --- | --- |
| Riemann pair symmetry $W_{abcd}=W_{cdab}$ | Self-adjointness of $W$ on $\Lambda^2$, hence the spectral form; and the second half of L179(a) |
| Skewness in each pair | The antisymmetric extension in the Ricci contraction (item 3) |
| Total trace-freeness $\sum_bW_{abcb}=0$ | L180(1) is its restatement; L180(2), (3), (4) and L179(c) all descend from it |
| First Bianchi identity | L179(b) only. **L180 never uses it** |
| $\omega_i$ orthonormal | $\mathop{\mathrm{tr}}A_i=2$; linear independence, which is what makes the $\dim V=2$ step in L180(3) bite |
| $\lambda_i\ne0$ for the listed terms | The whole of L179(a)'s definition of $V$, and L180's setup |
| Rank exactly three | L179(d); L180(3) |
| $W\ne0$ | L180's setup; without it $V=0$ and "$\dim V\ge4$" is false |
| The imported fact: coordinate-diagonal nonzero $\Rightarrow$ rank $\ge4$ | L179(d), and only there |

### Stated and unused

- **The whole of the conjecture's numerology.** $n\ge12$, the threshold $\sqrt{3/2}$, $\theta_0(12)=1.236033$, the crossover $n=6+2\sqrt7$, and $\theta=P/\lVert W\rVert^3$ with $P(W)=\langle W,W^2+W^\#\rangle$ appear in the conventions and are used nowhere in either claim. L179 and L180 are dimension-free algebra valid for every $n\ge3$. That is a strength of the two lemmas, and it is also why nothing in them can be leaned on to import a dimension restriction.
- **$0\in\mathcal W_n$**, stated in the conventions. It is never invoked; L180 excludes $W=0$ by hypothesis.
- **The first Bianchi identity, for the whole of L180.** L180(1)–(4) hold for any self-adjoint trace-free operator on $\Lambda^2$ whether or not it satisfies Bianchi. Worth recording, because it means L180 cannot be tightened by "but Bianchi also holds" without a fresh argument.

### Used and unstated

1. **An orthonormal frame adapted to $V$**, in L179(a). "$W_{abcd}=0$ whenever any index leaves $V$" is not a frame-free statement, an index is a basis vector, and "$f_c\in V$" only partitions the frame when the frame is adapted. The proof silently needs $f_1,\dots,f_k$ spanning $V$ and $f_{k+1},\dots,f_n$ spanning $V^\perp$, which is what makes $\Lambda^2\mathbb R^n=\Lambda^2V\oplus(V\wedge V^\perp)\oplus\Lambda^2V^\perp$ an orthogonal splitting and hence makes $\langle\eta,f_c\wedge f_d\rangle=0$ for $\eta\in\Lambda^2V$ and $\{c,d\}\not\subseteq V$. One sentence repairs it. **Presentational, not an error.**
2. **$\mathop{\mathrm{supp}}\omega\subseteq V\Rightarrow\omega\in\Lambda^2V$**, in L179(a) and in L180(3)'s $\dim V=2$ step. True, for skew $\omega$, $\ker\omega=(\mathop{\mathrm{Im}}\omega)^\perp$, so $\mathop{\mathrm{Im}}\omega\subseteq V$ forces $V^\perp\subseteq\ker\omega$ and $\omega=P_V\omega P_V$, but it is a step, not a definition.
3. **Range additivity of PSD sums**, in L180(3). Named in the proof and asserted. §5 below.
4. **$\sum_i\lambda_i=0$**, in L180(3). The proof asserts "the $\lambda_i$ are nonzero and sum to zero"; the reason is L180(2), which is on file one item earlier, so this is a cross-reference to supply rather than a gap.

## 1. Every hypothesis, checked against the object

Covered in the inventory above. Two remarks that belong here rather than in a table.

**The name "Ricci-flatness" in L180(1) is a misnomer that costs nothing here.** For an element of $\mathcal W_n$ the condition $\sum_bW_{abcb}=0$ is part of the *definition* of the space, not a curvature condition on a metric, the Weyl tensor of any metric is trace-free whatever the Ricci tensor does. L180(1) is therefore not "Ricci-flatness is equivalent to a PSD identity" but "the defining trace-freeness of $\mathcal W_n$, read through the spectral decomposition, is a PSD identity". The mathematics is untouched; the label should be fixed so that a later reader does not think an extra geometric hypothesis has been imposed.

**Nothing in either claim is stated for $\mathcal W_n$ that needs $\mathcal W_n$.** L179(a), (c) and all of L180 hold for any self-adjoint $W$ on $\Lambda^2$ with $\mathop{\mathrm{tr}}_{\Lambda^2}W=0$. Only L179(b) and (d) reach outside that.

## 2. The normalisation of $W_{abcd}$, the line everything rests on

**Verdict: clean. There is no factor of $2$ and no factor of $\tfrac12$.**

Derive it. Fix $a<b$ and $c<d$. By the definition of $\omega\otimes\omega$,

$$W(f_a\wedge f_b)=\sum_i\lambda_i\,\langle\omega_i,f_a\wedge f_b\rangle\,\omega_i.$$

The basis $\{f_p\wedge f_q\}_{p<q}$ is orthonormal, so $\langle\omega_i,f_a\wedge f_b\rangle=(\omega_i)_{ab}$, with **no** factor $2$, precisely because the expansion $\omega=\sum_{p<q}\omega_{pq}f_p\wedge f_q$ runs over $p<q$ and not over all ordered pairs. Taking the $f_c\wedge f_d$ coefficient of the right-hand side, again with $c<d$ and again against an orthonormal basis vector,

$$W_{abcd}=\langle W(f_a\wedge f_b),f_c\wedge f_d\rangle=\sum_i\lambda_i(\omega_i)_{ab}(\omega_i)_{cd}.$$

The identity then extends to all four index positions at once: both sides are antisymmetric under $a\leftrightarrow b$ and under $c\leftrightarrow d$ (the left by the Riemann symmetry, the right by the antisymmetric extension of $\omega$), and both vanish when $a=b$ or $c=d$.

**Where a factor of two would have come from, and why it does not.** The classical trap is the pair of conventions $\omega=\sum_{p<q}\omega_{pq}f_p\wedge f_q$ versus $\omega=\tfrac12\sum_{p,q}\omega_{pq}f_p\wedge f_q$, and the pair $W(f_a\wedge f_b)=\sum_{c<d}W_{abcd}f_c\wedge f_d$ versus $\tfrac12\sum_{c,d}$. The brief fixes the first member of each pair, and (this is the point), **they are the same two choices**, so the two would-be halves are not present at all rather than cancelling. A record that had taken the "all pairs" convention on one side and the "$p<q$" convention on the other would carry exactly the factor of two this record has admitted twice. It does not carry it here.

**Would a factor change any conclusion?** A global constant $\kappa$ in $W_{abcd}=\kappa\sum_i\lambda_i(\omega_i)_{ab}(\omega_i)_{cd}$ would leave every conclusion under review intact, because each of them is a *vanishing* or a *range* statement: $\sum_i\lambda_iA_i=0$, $\sum_i\lambda_i\omega_i\wedge\omega_i=0$, $\mathop{\mathrm{range}}$ identities, $\mathop{\mathrm{tr}}W=0$. It would change $\mathop{\mathrm{tr}}A_i=2$ to $2\kappa$ and would change any downstream numerical quantity, $\lVert W\rVert$, $P(W)$, $\theta$. **So the normalisation is not load-bearing for L179 and L180, and is entirely load-bearing for anything that computes $\theta$ from a spectral presentation.** If the record has a $\theta$ computed from $\lambda_i$ and $\omega_i$, that is where this line must be re-checked, and it is outside this brief.

## 3. The Ricci contraction, index by index

**Verdict: the bookkeeping is right, and yes, $\sum_b(\omega)_{ab}(\omega)_{cb}=(\omega\omega^{\mathsf T})_{ac}$.**

$\sum_bW_{abcb}$ runs $b$ over $1,\dots,n$, so it needs $W_{abcd}$ at index quadruples with $a>b$, with $a=b$, and with $b=d$, all outside the range $a<b$, $c<d$ where the normalisation was derived. §2 established the extension to all quadruples, so the substitution is legitimate:

$$\sum_bW_{abcb}=\sum_i\lambda_i\sum_b(\omega_i)_{ab}(\omega_i)_{cb}.$$

Now $\sum_b(\omega)_{ab}(\omega)_{cb}=\sum_b\omega_{ab}(\omega^{\mathsf T})_{bc}=(\omega\omega^{\mathsf T})_{ac}$, this is the definition of the matrix product, with the second factor transposed exactly because the contracted index $b$ sits in the *second* slot of both copies. **Yes.** And $\omega^{\mathsf T}=-\omega$ gives $\omega\omega^{\mathsf T}=-\omega^2$, so the condition reads $\sum_i\lambda_i\omega_i^2=0$ and equally $\sum_i\lambda_iA_i=0$. The two diagonal degeneracies are harmless: the $b=a$ and $b=c$ terms contribute $0$ on both sides.

**One thing to note about which contraction this is.** $\sum_bW_{abcb}$ contracts the second and fourth slots. Contracting the first and third, $\sum_bW_{bacb}$, gives the same matrix by the two skew symmetries; contracting the first and second gives zero identically. So "the" Ricci contraction is unambiguous here, and $\sum_i\lambda_iA_i$ is symmetric in $a,c$, as it must be.

## 4. $A=\omega\omega^{\mathsf T}$, the three properties, each separately

**Positive semidefinite.** $x^{\mathsf T}\omega\omega^{\mathsf T}x=\lVert\omega^{\mathsf T}x\rVert^2\ge0$ for every $x$. **Yes**, and it needs nothing about $\omega$ beyond being a real matrix.

**$\mathop{\mathrm{range}}(A)=\mathop{\mathrm{supp}}\omega$.** **Yes.** The brief's own argument is correct and I reproduce it with the missing half supplied. If $\omega^2x=0$ then $0=-x^{\mathsf T}\omega^2x=x^{\mathsf T}\omega\omega^{\mathsf T}x=\lVert\omega^{\mathsf T}x\rVert^2$, so $\omega^{\mathsf T}x=0$, so $\omega x=0$: thus $\ker A=\ker(\omega^2)\subseteq\ker\omega$, and the reverse inclusion is immediate, so $\ker A=\ker\omega$. Both $A$ and $\omega$ are normal ($A$ symmetric, $\omega$ skew), so each has range equal to the orthogonal complement of its kernel: $\mathop{\mathrm{range}}A=(\ker A)^\perp=(\ker\omega)^\perp=\mathop{\mathrm{range}}\omega=\mathop{\mathrm{supp}}\omega$. The step the brief leaves implicit is $(\ker\omega)^\perp=\mathop{\mathrm{range}}\omega$, which for a skew matrix is $\mathop{\mathrm{range}}(\omega^{\mathsf T})=\mathop{\mathrm{range}}(-\omega)=\mathop{\mathrm{range}}\omega$.

**$\mathop{\mathrm{tr}}A=2\lVert\omega\rVert^2$.** **Yes.** $\mathop{\mathrm{tr}}(\omega\omega^{\mathsf T})=\sum_{a,b}\omega_{ab}^2=2\sum_{a<b}\omega_{ab}^2=2\lVert\omega\rVert^2$, the factor $2$ arising from the antisymmetric extension doubling each $a<b$ entry. At $\lVert\omega_i\rVert=1$ this is the brief's $\mathop{\mathrm{tr}}A_i=2$. Note this is the one place in L180 where a normalisation constant survives, and §2 shows it is the right one.

**Also true and worth recording**: $\dim\mathop{\mathrm{range}}A=\mathop{\mathrm{rank}}\omega=\dim\mathop{\mathrm{supp}}\omega$, which is even, because the rank of a real skew matrix is even. This is what will make $\dim V$ even in §7, but only after §6 has identified $V$ with a single support.

## 5. Range additivity, the load-bearing unargued step

**Verdict: the statement is TRUE. Its status on file is `HYPOTHESIS-DEBT`, L180(3) asserts it with no argument, and it is the step the whole of (3) turns on.** I have read it at a source and filed the source.

**Statement.** For positive semidefinite real matrices $A_1,\dots,A_k$, $\mathop{\mathrm{range}}\big(\sum_iA_i\big)=\sum_i\mathop{\mathrm{range}}(A_i)$.

**Proof.** For $A\succeq0$, $x^{\mathsf T}Ax=\lVert A^{1/2}x\rVert^2$, so $x^{\mathsf T}Ax=0\iff A^{1/2}x=0\iff Ax=0$. Let $x\in\ker\big(\sum_iA_i\big)$. Then $0=x^{\mathsf T}\big(\sum_iA_i\big)x=\sum_ix^{\mathsf T}A_ix$ is a sum of non-negative reals, so each $x^{\mathsf T}A_ix=0$, so each $A_ix=0$. The reverse inclusion is trivial, so $\ker\big(\sum_iA_i\big)=\bigcap_i\ker A_i$. Every $A_i$ and the sum are symmetric, so range is the orthogonal complement of kernel, and $\big(\bigcap_i\ker A_i\big)^\perp=\sum_i(\ker A_i)^\perp$. Hence $\mathop{\mathrm{range}}\big(\sum_iA_i\big)=\sum_i\mathop{\mathrm{range}}A_i$. $\square$

**Positivity is essential, not decorative.** $A=\mathop{\mathrm{diag}}(1,0)$ and $B=-A$ give $\mathop{\mathrm{range}}(A+B)=0$ while $\mathop{\mathrm{range}}A+\mathop{\mathrm{range}}B$ is a line. This matters for L180(3), where the argument must first *move* the minority term to the other side so that both sides are PSD; applying additivity to $\sum_i\lambda_iA_i$ as it stands would be exactly this error.

**Source, read and filed.** P. A. Fillmore and J. P. Williams, *On operator ranges*, Advances in Mathematics **7** (1971), 254–281, [Theorem 2.2](https://home.agh.edu.pl/~rudol/Operat/FilmoreWilliams.pdf): $\mathcal R(A)+\mathcal R(B)=\mathcal R\big((AA^*+BB^*)^{1/2}\big)$ for bounded operators. Applying it to the pair $A^{1/2},B^{1/2}$, which are self-adjoint, gives $\mathcal R(A^{1/2})+\mathcal R(B^{1/2})=\mathcal R\big((A+B)^{1/2}\big)$; in finite dimensions $\mathcal R(M^{1/2})=\mathcal R(M)$ for $M\succeq0$, which is the matrix statement. A direct finite-dimensional statement, used without proof, is equation (A.7) of Hu–Im–Lin–Lütkenhaus–Wolkowicz, *Robust Interior Point Method for Quantum Key Distribution Rate Computation*, Quantum **6** (2022), [arXiv:2104.03847](https://arxiv.org/abs/2104.03847). Both are transcribed in [references/fillmore-williams-1971-operator-ranges/notes.md](../references/fillmore-williams-1971-operator-ranges/notes.md), **which I have left uncommitted for the parent to fold in.**

**What the record owes.** One citation and three lines. The debt is bibliographic, not mathematical; L180(3) does not fall.

## 6. L180(3)'s sign analysis, each pattern separately

**Verdict: the two patterns are the only ones, and the argument identifies $V$ with the minority-sign support in both. I checked them separately rather than by symmetry, as the brief asks, and they are genuinely different computations.**

$\mathop{\mathrm{tr}}_{\Lambda^2}W=\sum_i\lambda_i\lVert\omega_i\rVert^2=\sum_i\lambda_i$ at unit norm, and L180(2) makes this $0$. With three nonzero reals summing to zero the signs cannot all agree, so up to relabelling the pattern is $(+,+,-)$ or $(+,-,-)$, **these two and no others**, since a sign vector in $\{+,-\}^3$ that is neither constant has either one minus or one plus.

**Pattern $(+,+,-)$**, so $\lambda_1,\lambda_2>0>\lambda_3$; the minority sign is the negative one, carried by $\omega_3$. From $\sum_i\lambda_iA_i=0$,

$$\lambda_1A_1+\lambda_2A_2=|\lambda_3|A_3,$$

both sides now PSD. By §5, $\mathop{\mathrm{range}}(A_3)=\mathop{\mathrm{range}}(\lambda_1A_1+\lambda_2A_2)=\mathop{\mathrm{range}}(A_1)+\mathop{\mathrm{range}}(A_2)$, positive scalars do not move a range. So $\mathop{\mathrm{supp}}\omega_3\supseteq\mathop{\mathrm{supp}}\omega_1,\mathop{\mathrm{supp}}\omega_2$, hence $V=\mathop{\mathrm{supp}}\omega_1+\mathop{\mathrm{supp}}\omega_2+\mathop{\mathrm{supp}}\omega_3=\mathop{\mathrm{supp}}\omega_3$. ✔

**Pattern $(+,-,-)$**, so $\lambda_1>0>\lambda_2,\lambda_3$; the minority sign is the positive one, carried by $\omega_1$. Now

$$\lambda_1A_1=|\lambda_2|A_2+|\lambda_3|A_3,$$

and §5 gives $\mathop{\mathrm{range}}(A_1)=\mathop{\mathrm{range}}(A_2)+\mathop{\mathrm{range}}(A_3)$, hence $V=\mathop{\mathrm{supp}}\omega_1$. ✔

**The two are not the same computation.** In the first, the minority term is alone on the right and the additivity is applied to the *two-term* left side; in the second, the minority term is alone on the left and the additivity is applied to the *two-term* right side. Both directions of the range identity are used across the two cases, which is why §5 must be an equality and not merely the inclusion $\mathop{\mathrm{range}}(A+B)\supseteq\mathop{\mathrm{range}}A$. The record's one-sentence proof covers both, but only because it phrases the move abstractly; a reader checking one case will not have checked the other.

**A remark the record should carry.** In both patterns the conclusion is stronger than "$V$ equals a support": it says the *other two* supports are contained in the minority one. At rank three that is a real structural constraint, and it holds regardless of which of the two sign patterns obtains.

## 7. $\dim V\ge4$, and whether the evenness circles

**Verdict: $\dim V=2$ is impossible, $\dim V$ is even, and the argument does not circle.**

**The circularity worry, addressed head on.** A span of several even-dimensional subspaces need not be even-dimensional (two planes in $\mathbb R^3$ meeting in a line span a $3$-space) so evenness genuinely cannot be read off the definition of $V$, and it does depend on the claim that $V$ *is* a single form's support. The question is whether the derivation of that claim uses evenness. **It does not.** Trace the chain: $\sum_i\lambda_iA_i=0$ comes from §3, which uses only the normalisation and the trace-free definition; $\sum_i\lambda_i=0$ comes from its trace; the sign patterns come from three nonzero reals summing to zero; the identification $V=\mathop{\mathrm{supp}}\omega_{\text{minority}}$ comes from §5 applied to that identity. **No step in that chain mentions the dimension of $V$, of any support, or of $\Lambda^2V$.** Evenness is then a consequence, $\dim V=\dim\mathop{\mathrm{supp}}\omega_{\text{minority}}=\mathop{\mathrm{rank}}$ of a real skew matrix, which is even. The dependency is one-way and the circle the brief was worried about is not there.

**$\dim V\ne0$.** $W\ne0$ forces some $\omega_i\ne0$, so $V\ne0$, so $\dim V\ge2$.

**$\dim V\ne2$.** If $\dim V=2$ then every $\omega_i$ has $\mathop{\mathrm{supp}}\omega_i\subseteq V$ and hence lies in $\Lambda^2V$, which is $1$-dimensional. But $\omega_1,\omega_2,\omega_3$ are orthonormal, hence linearly independent, hence cannot all lie in a line. So the rank is at most one, and rank one is excluded outright by L179(c). ✔ The brief's phrasing "so the rank is at most one" is right, and the step it leans on is the implicit fact 2 of the inventory, $\mathop{\mathrm{supp}}\omega\subseteq V\Rightarrow\omega\in\Lambda^2V$.

**Conclusion.** $\dim V$ is even and $\ge4$. **This is exactly what is proved and no more: $\dim V\in\{4,6,8,\dots\}$, with $4$ live.** §13 shows $4$ is not merely live but occupied.

**A boundary the record should state.** Evenness of $\dim V$ is a *rank-three* conclusion, not a general one. At rank two it survives, via L180(4). At rank five and above the sign patterns admit two or more forms on each side and §5 no longer collapses $V$ onto one support, so $\dim V$ can be odd. Nothing here licenses "$\dim V$ is even" as a standing fact about $\mathcal W_n$.

## 8. L179(a), the support reduction

**Verdict: $\mathop{\mathrm{Im}}W\subseteq\Lambda^2V$ does follow, and the pair-symmetry step does cover all four indices.**

**The inclusion.** $W=\sum_{\lambda_\alpha\ne0}\lambda_\alpha\,\omega_\alpha\otimes\omega_\alpha$, and each summand has image inside $\mathbb R\omega_\alpha$, so $\mathop{\mathrm{Im}}W\subseteq\mathop{\mathrm{span}}\{\omega_\alpha:\lambda_\alpha\ne0\}$. Each such $\omega_\alpha$ has $\mathop{\mathrm{supp}}\omega_\alpha\subseteq V$ by the definition of $V$, hence $\omega_\alpha\in\Lambda^2V$ by inventory fact 2, and $\Lambda^2V$ is a linear subspace, so the span is inside it. ✔ Note that the definition of $V$ as the span of the supports is what makes this work with no further hypothesis, it is the smallest subspace that could.

**The frame.** As recorded in the inventory, "index leaves $V$" presupposes an orthonormal frame adapted to $V$. Fix one. Then $\Lambda^2\mathbb R^n=\Lambda^2V\oplus(V\wedge V^\perp)\oplus\Lambda^2V^\perp$ is an orthogonal decomposition and $f_c\wedge f_d\in\Lambda^2V$ exactly when both $c$ and $d$ index $V$.

**The two pairs.** For $\{c,d\}\not\subseteq V$: $W_{abcd}=\langle W(f_a\wedge f_b),f_c\wedge f_d\rangle$, and $W(f_a\wedge f_b)\in\Lambda^2V$ while $f_c\wedge f_d\in(V\wedge V^\perp)\oplus\Lambda^2V^\perp$, so the inner product vanishes. For $\{a,b\}\not\subseteq V$: $W_{abcd}=W_{cdab}=\langle W(f_c\wedge f_d),f_a\wedge f_b\rangle$ and the identical argument applies. **These two cases exhaust "any index leaves $V$"**, if $a\notin V$ or $b\notin V$ the second applies, if $c\notin V$ or $d\notin V$ the first does. So the reduction covers all four index slots and not two. ✔

**What the pair symmetry is doing, precisely.** It is not being used to move indices within a pair (the skew symmetries do that) but to exchange the roles of "argument" and "output" of the operator, which is the only way to see the $(a,b)$ pair, since $W$'s image is controlled and its domain is not. The step is exactly right and could not be replaced by the skew symmetries alone.

## 9. L179(b), the Bianchi map, read at a source

**Verdict: the equivalence holds. There is a constant, it is $2$, and it is harmless because the claim is a vanishing.**

**Computed by hand.** For $p<q<r<s$, expand $\omega\wedge\omega$ with $\omega=\sum_{a<b}\omega_{ab}f_a\wedge f_b$. The pairs of basis $2$-forms whose wedge lands on $f_p\wedge f_q\wedge f_r\wedge f_s$ are the three partitions of $\{p,q,r,s\}$, each occurring twice:

$$(\omega\wedge\omega)_{pqrs}=2\big(\omega_{pq}\omega_{rs}-\omega_{pr}\omega_{qs}+\omega_{ps}\omega_{qr}\big),$$

the signs being those of the permutations $(p,q,r,s)$, $(p,r,q,s)$, $(p,s,q,r)$. Meanwhile, with $W_{abcd}=\sum_i\lambda_i(\omega_i)_{ab}(\omega_i)_{cd}$,

$$B_{pqrs}=W_{pqrs}+W_{prsq}+W_{psqr}=\sum_i\lambda_i\big((\omega_i)_{pq}(\omega_i)_{rs}-(\omega_i)_{pr}(\omega_i)_{qs}+(\omega_i)_{ps}(\omega_i)_{qr}\big).$$

Hence $\big(\sum_i\lambda_i\,\omega_i\wedge\omega_i\big)_{pqrs}=2\,B_{pqrs}$.

**Why $p<q<r<s$ suffices.** $B$ is totally antisymmetric for any tensor with the Riemann skew and pair symmetries, before Bianchi is assumed. Checking the first transposition: $B_{bacd}=-W_{abcd}+W_{bcda}+W_{bdac}$, and $W_{bcda}=W_{dabc}=-W_{adbc}$, $W_{bdac}=W_{acbd}=-W_{acdb}$, giving $B_{bacd}=-B_{abcd}$; the remaining transpositions go the same way. A totally skew array vanishes identically iff it vanishes on strictly increasing quadruples, and vanishes automatically when indices repeat. So $\mathfrak b(W)=0\iff B_{abcd}=0$ for all $a,b,c,d$, which is the first Bianchi identity. ✔

**Read at a source.** Viaclovsky, *Math 865, Topics in Riemannian Geometry*, Fall 2007, §4.2, [notes](https://www.math.uci.edu/~jviaclov/courses/865_Fall_2007.pdf), equations (4.15)–(4.20): the Bianchi symmetrisation $b\,\mathrm{Rm}(x,y,z,t)=\tfrac13(\mathrm{Rm}(x,y,z,t)+\mathrm{Rm}(y,z,x,t)+\mathrm{Rm}(z,x,y,t))$ satisfies $S^2\Lambda^2=\ker b\oplus\mathop{\mathrm{Im}}b$, $b(\alpha\odot\beta)=\tfrac16\,\alpha\wedge\beta$, $\mathop{\mathrm{Im}}b=\Lambda^4$, and $\ker b=\mathcal C$ is the space of curvature-like tensors. **This is an independent confirmation of the constant**: $b=\tfrac13B$ by (4.15) and $\alpha\wedge\beta=6\,b(\alpha\odot\beta)$ by (4.17), so $\omega\wedge\omega=6\cdot\tfrac13B=2B$, matching the coefficient computation above exactly. Transcribed in [references/viaclovsky-2007-curvature-decomposition/notes.md](../references/viaclovsky-2007-curvature-decomposition/notes.md), **left uncommitted.**

**The brief's map versus the source's.** $\mathfrak b(\omega\odot\eta)=\omega\wedge\eta$ is $6b$ on symmetric products. Same kernel, so "the first Bianchi identity is $\sum_{\lambda_\alpha\ne0}\lambda_\alpha\,\omega_\alpha\wedge\omega_\alpha=0$ in $\Lambda^4$" is correct as written. **Anything that ever reads a magnitude off $\mathfrak b$ rather than its vanishing must carry the $6$, or the $2$ against $B$.**

**"The zero eigenvalues drop out."** ✔ trivially, $0\cdot\omega\wedge\omega=0$. **"At rank $r$ it constrains $r$ terms and no more"** is right about the number of *terms*; it is $\binom n4$ scalar equations on those $r$ terms, which at $n\ge12$ is a great many, so the phrasing should not be read as "the constraint is weak".

## 10. L179(c) and (d)

**(c), rank one.** ✔ $W=\lambda\,\omega\otimes\omega$ with $\lambda\ne0$, $\omega$ a unit eigenvector, gives $\mathop{\mathrm{tr}}_{\Lambda^2}W=\lambda\lVert\omega\rVert^2=\lambda\ne0$; total trace-freeness at $a=c$ gives $\sum_a\sum_bW_{abab}=2\mathop{\mathrm{tr}}_{\Lambda^2}W=0$. Contradiction. Two remarks: the proof uses only the $a=c$ diagonal of trace-freeness, a strictly weaker hypothesis than the full condition, which is a point in its favour; and it never touches Bianchi, so rank one is impossible in the larger space of trace-free self-adjoint $\Lambda^2$-operators too.

**(d), the decomposable case.** Two separate assertions, both correct.

*"(b) holds automatically."* ✔ Decomposable means $\omega_i=u_i\wedge v_i$, so $\omega_i\wedge\omega_i=u_i\wedge v_i\wedge u_i\wedge v_i=0$ term by term, and $\sum_i\lambda_i\omega_i\wedge\omega_i=0$ regardless of the $\lambda_i$. The Bianchi identity is then no constraint at all on the eigenvalues at rank three, that is the real content, and it is right.

*"$\dim V\le6$."* ✔ Each support is a plane, and three planes span at most $6$ dimensions.

*"The three planes cannot be mutually orthogonal."* ✔ If $P_1\perp P_2\perp P_3$ are pairwise orthogonal planes, pick an orthonormal frame with $f_1,f_2\in P_1$, $f_3,f_4\in P_2$, $f_5,f_6\in P_3$. A unit decomposable $2$-form with support $P_1$ is $\pm f_1\wedge f_2$, and likewise for the others, so $W=\sum_i\lambda_i\,\omega_i\otimes\omega_i$ has $W_{abcd}\ne0$ only for $\{a,b\}=\{c,d\}\in\{\{1,2\},\{3,4\},\{5,6\}\}$, coordinate-diagonal, nonzero, rank three, contradicting the imported fact.

**And here is what (d) does *not* say, which the record must not read into it.** Pairwise orthogonality of the planes is strictly stronger than $\dim V=6$. Three planes can span a $6$-space without being pairwise orthogonal, take $P_1=\langle e_1,e_2\rangle$, $P_2=\langle e_3,e_4\rangle$, $P_3=\langle e_5,e_6+e_1\rangle$, which are in direct sum, span $6$ dimensions, and have $P_3\not\perp P_1$. So **(d) excludes one configuration inside the decomposable rank-three case; it does not exclude $\dim V=6$ and it does not establish $\dim V=6$ either.** The word "mutually orthogonal" is doing a lot of quiet work and the statement is only as strong as it reads if a reader notices that.

## 11. The kernel

**Verdict: no step assumes $\ker W=0$, and no step is even mildly strained by a large kernel.**

- L179(a) is *built* on the kernel: $V$ is defined from the $\lambda_\alpha\ne0$ terms only, and the conclusion is precisely that $W$ dies outside $\Lambda^2V$. The larger the kernel the stronger the statement.
- L179(b) explicitly discards the zero eigenvalues, and correctly.
- L180's setup lists only the nonzero $\lambda_i$, so its $A_i$ are exactly the nonzero-eigenvalue ones.
- **§5's range additivity holds for singular PSD matrices**, indeed every $A_i$ here is singular whenever $\mathop{\mathrm{supp}}\omega_i\ne\mathbb R^n$, which at $n\ge12$ and rank three is always, since $\dim V\le6$ by (d) in the decomposable case and $\dim\mathop{\mathrm{supp}}\omega_i\le\dim V$ in general. Additivity needs no invertibility anywhere; my proof of it uses only $x^{\mathsf T}Ax=0\Rightarrow Ax=0$.
- §7's $\dim V=2$ exclusion is a statement about a $1$-dimensional $\Lambda^2V$, entirely within the kernel-heavy regime.
- L180(4) divides by $\lambda_1\ne0$ only.

**The one place a reader might suspect trouble** is §3: $\sum_i\lambda_iA_i=0$ is an $n\times n$ identity among matrices of rank at most $6$ each, so at $n\ge12$ it is an identity among matrices that are almost all kernel. That is fine, the identity is linear and does not require the $A_i$ to be faithful. **No repair needed anywhere.**

## 12. The boundary

| $n$ | Status |
| --- | --- |
| $n=3$ | $\dim\Lambda^2=3$, so rank three is conceivable dimensionally, but L180(3) forces $\dim V\ge4>3$. So **rank three is impossible at $n=3$**, and this is a consistency check that passes, since $\mathcal W_3=0$. Also Viaclovsky's $b\equiv0$ for $n=2,3$, so Bianchi is vacuous there and does the excluding on its own |
| $n=4$ | **Everything holds, and this is where the object of §13 lives.** $\dim\Lambda^4\mathbb R^4=1$, so L179(b) is a single scalar equation. L179(d) is vacuous at $n=4$ for a different reason worth noting: a decomposable $2$-form on $\mathbb R^4$ has a $2$-dimensional support, three pairwise orthogonal planes do not fit, so the orthogonal configuration it excludes does not arise |
| $n=5$ | Nothing special. $\dim V\in\{4\}$ at rank three with $\dim V\le5$; the §13 object embeds |
| odd $n$ | Nothing breaks. $V$ is even-dimensional and sits inside an odd-dimensional space, which merely means $V\ne\mathbb R^n$ and every $\omega_i$ has nontrivial kernel, §11 covers that |
| $n=6+2\sqrt7\approx11.2915$ | **Not an integer, and no claim under review references it.** The crossover is a statement about $\theta$, and neither L179 nor L180 computes $\theta$. It is stated-and-unused in this brief and must not be smuggled into a support argument |
| $n<12$ | The conjecture's range plays no role. **Both claims are dimension-free for $n\ge4$**, which is worth stating positively: it means they can be tested at $n=4$, where the §13 object lives, and it also means they cannot be strengthened by invoking $n\ge12$ without a fresh argument |

## 13. Overreach, "$\dim V\ge6$ is the whole of what remains"

**Verdict: REFUTED. Not merely unentailed, false, and I exhibit the counterexample in closed form.**

**Not entailed.** What is proved is $\dim V$ even and $\ge4$ (§7). Nothing on file excludes $\dim V=4$: L179(d) speaks only about the all-decomposable case and only excludes pairwise orthogonality; L179(b) is a vanishing in $\Lambda^4$; L180(3) stops at $\ge4$. The step from $\ge4$ to $\ge6$ has no argument on file, by the brief's own instruction that alone is `HYPOTHESIS-DEBT`.

**And false. The object.** Work in $\mathbb R^4$ spanned by $f_1,f_2,f_3,f_4$ and take the standard orthonormal basis of the self-dual $2$-forms:

$$\omega_1=\tfrac1{\sqrt2}(f_1\wedge f_2+f_3\wedge f_4),\qquad \omega_2=\tfrac1{\sqrt2}(f_1\wedge f_3+f_4\wedge f_2),\qquad \omega_3=\tfrac1{\sqrt2}(f_1\wedge f_4+f_2\wedge f_3),$$

and set

$$\boxed{\;W=\omega_1\otimes\omega_1+\omega_2\otimes\omega_2-2\,\omega_3\otimes\omega_3\;}$$

extended by zero to $\mathbb R^n$ for any $n\ge4$, in particular $n\ge12$.

**Everything verified in closed form.**

- *Orthonormal.* The three forms have components on the disjoint index sets $\{12,34\}$, $\{13,24\}$, $\{14,23\}$, so they are pairwise orthogonal, and each has norm $\big(\tfrac1{\sqrt2}\big)^2+\big(\tfrac1{\sqrt2}\big)^2=1$.
- *Riemann symmetries.* Automatic: $W_{abcd}=\sum_i\lambda_i(\omega_i)_{ab}(\omega_i)_{cd}$ is skew in each pair and pair-symmetric by construction.
- *Trace-free.* Each $\omega_i$ is $\tfrac1{\sqrt2}$ times an orthogonal matrix (a complex structure on $\mathbb R^4$) so $A_i=\omega_i\omega_i^{\mathsf T}=\tfrac12 I_4$ for all three. Hence $\sum_i\lambda_iA_i=\tfrac12(1+1-2)I_4=0$. ✔ by §3 this is exactly $\sum_bW_{abcb}=0$.
- *First Bianchi.* $\omega_1\wedge\omega_1=\tfrac12\cdot2\,(f_1\wedge f_2)\wedge(f_3\wedge f_4)=f_{1234}$, and likewise $\omega_2\wedge\omega_2=f_1\wedge f_3\wedge f_4\wedge f_2=f_{1234}$ (permutation $(1,3,4,2)$, two inversions) and $\omega_3\wedge\omega_3=f_1\wedge f_4\wedge f_2\wedge f_3=f_{1234}$ (permutation $(1,4,2,3)$, two inversions). So $\sum_i\lambda_i\,\omega_i\wedge\omega_i=(1+1-2)f_{1234}=0$. ✔ by §9 this is the first Bianchi identity.
- *Rank three.* The $\omega_i$ are orthonormal with nonzero eigenvalues $1,1,-2$; the orthogonal complement of their span in $\Lambda^2\mathbb R^n$ is annihilated.
- *$\dim V=4$.* $\mathop{\mathrm{range}}(A_i)=\mathop{\mathrm{range}}(\tfrac12I_4)=\mathbb R^4$ for each $i$, so $V=\mathbb R^4$ and $\dim V=4$.
- *Consistent with everything proved above.* L180(3): the minority sign is the single negative $\lambda_3=-2$, and indeed $\mathop{\mathrm{supp}}\omega_3=\mathbb R^4=V$. ✔ L179(d) does not apply: no $\omega_i$ is decomposable, since $\omega_i\wedge\omega_i=f_{1234}\ne0$. ✔ The imported fact is not contradicted: $W_{1234}=\lambda_1(\omega_1)_{12}(\omega_1)_{34}=\tfrac12\ne0$ with $\{1,2\}\ne\{3,4\}$, so $W$ is not coordinate-diagonal. ✔
- *The zero extension stays in $\mathcal W_n$.* All symmetries are index-local; the Bianchi sum vanishes when all four indices lie in the block and is identically zero otherwise; and $\sum_bW_{abcb}$ is the $4$-dimensional trace when $a,c\le4$ and zero otherwise.

**Screen.** Having derived all of the above by hand, I checked it once in exact rational arithmetic (no floating point), on the object I had constructed, at $n=4$ and again at $n=12$. Both returned: Gram matrix of the $\omega_i$ the identity; all Riemann symmetries; first Bianchi at every index quadruple; total trace-freeness at every $(a,c)$; $\Lambda^2$-rank exactly $3$; $A_i=\tfrac12P_V$; $W_{1234}=\tfrac12$ and not coordinate-diagonal. **This is a screen of a closed-form derivation and is reported as such, not as the evidence, the evidence is the paragraph above it.**

**What this costs the record.** The conclusion "$\dim V\ge6$ is the whole of what remains" is false as stated and must be struck. What remains after L179 and L180 is $\dim V\in\{4,6\}$, the upper bound $6$ holding in the all-decomposable case by (d), and unbounded above otherwise until something further is proved. **The $\dim V=4$ case is not a residual to be waved through: it is occupied, and by the self-dual Weyl tensors of $\mathbb R^4$, which are the best-understood rank-three objects there are.** Any argument that was resting on "$\dim V\ge6$" needs re-deriving.

## Name what would break each claim, and what I did to look

The standing rule forbids searches, sweeps and falsifier hunts, so in each case what I did was construct the falsifier's definition and try to derive a contradiction or an instance in closed form. Nothing below was found by search.

| Claim | The object that would falsify it | What I did |
| --- | --- | --- |
| L179(a) | $W\in\mathcal W_n$ with $W_{abcd}\ne0$ for some quadruple having an index outside $V$ | Derived the vanishing from $\mathop{\mathrm{Im}}W\subseteq\Lambda^2V$ and the orthogonal splitting; no such object can exist, the proof is two lines and complete |
| L179(b) | $W$ with the Riemann symmetries, $\mathfrak b(W)=0$, and $B_{abcd}\ne0$ somewhere, or the converse | Computed $(\omega\wedge\omega)_{pqrs}=2B_{pqrs}$ in closed form and confirmed the constant against Viaclovsky (4.15)/(4.17). The two vanish together; no such object |
| L179(c) | A nonzero rank-one $W$ with $\mathop{\mathrm{tr}}_{\Lambda^2}W=0$ | $\mathop{\mathrm{tr}}=\lambda\ne0$ identically; none exists |
| L179(d) | Three pairwise orthogonal planes carrying a rank-three Weyl tensor | Constructed the adapted frame; it forces coordinate-diagonality, which the imported fact forbids. Blocked, conditional on that imported fact, which I did not re-audit |
| L180(1), (3) | PSD matrices $A_i$ with $\sum\lambda_iA_i=0$ whose ranges violate additivity | Proved additivity outright (§5) and sourced it. No such object |
| L180(3) sign analysis | A third sign pattern, or a pattern where $V$ is not the minority support | Enumerated all of $\{+,-\}^3$ minus the two constant vectors and worked both survivors separately (§6). None |
| L180(4) | Rank two with $A_1\ne A_2$ | $\lambda_1(A_1-A_2)=0$ with $\lambda_1\ne0$. None |
| $\dim V\ge4$ | A rank-three Weyl tensor with $\dim V=2$ | $\Lambda^2V$ would be a line and the $\omega_i$ orthonormal. None |
| **"$\dim V\ge6$"** | **A rank-three Weyl tensor with $\dim V=4$** | **Exhibited in closed form in §13.** Built from the self-dual basis of $\Lambda^2\mathbb R^4$ with eigenvalues $(1,1,-2)$, verified by hand and screened exactly |

**On the object the brief called most valuable, a rank-three Weyl tensor with six-dimensional support.** I did not produce one and I did not hunt for one, because a hunt is a falsifier search and the rule reserves it. What I can say analytically is that the record's $\dim V\le6$ bound (L179(d)) applies only when all three eigenforms are decomposable, and that in the decomposable case with $\dim V=6$ the three planes must be in direct sum but not pairwise orthogonal, the configuration I exhibited abstractly in §10. Whether that configuration can be completed to a Weyl tensor is untouched by anything on file. **Failing to find it settles nothing, exactly as the brief says; but the $\dim V=4$ object I did find settles item 13 outright, and it settles it against the record.**

## Disclosure, what I saw outside the cold brief, and what it may cost §13

**I worked cold and did not open [findings/](../findings/).** But the repository's structure gate refuses a commit whose reviewer is not indexed, so to file this report I had to open [reviews/INDEX.md](INDEX.md), and its last rows are visible there. Two things follow and I state them rather than leave them.

- **A row for r774 was already present before I filed**, written by the fold, along with a row for r773 that describes my §13 object. My findings were reached before I saw either, the object of §13 was derived, screened and written into this report in full before the index was opened, but the reader should know the leak happened, exactly as [r772](REVIEW_r772.md) had to disclose the same hazard. The gate's requirement that a reviewer index its own report publishes findings where a concurrent reviewer will meet them.
- **That row says the brief withheld a result, L178, which disposes of the four-dimensional case.** If the record carries a bound of the form "rank three with four-dimensional support gives $\theta\le\sqrt{3/2}$", then $\dim V=4$ is settled *for the conjecture* elsewhere, and "$\dim V\ge6$ is the whole of what remains" is defensible as shorthand for *what remains unsettled*, rather than false.

**This changes the scope of §13 and not its content.** What I proved stands unaltered: the implication "L179 and L180 $\Rightarrow\dim V\ge6$" is invalid, and the object that shows it is a genuine rank-three algebraic Weyl tensor with $\dim V=4$ living in $\mathcal W_n$ for every $n\ge4$. Whether the record's sentence is *false* or merely *unsupported by the two lemmas it cites* turns on a result the brief did not give me, and I decline to rule on a result I have not read. **The repair is the same either way: the sentence must name what disposes of $\dim V=4$, because L179 and L180 do not.**

## Overall verdict

**PASS WITH REFUTATION.**

**The two lemmas stand.** L179(a)–(d) and L180(1)–(4) are correct as stated, and the line the brief was most worried about (the normalisation $W_{abcd}=\sum_i\lambda_i(\omega_i)_{ab}(\omega_i)_{cd}$), is clean, with no factor of $2$ and no factor of $\tfrac12$, because the brief's two conventions ($p<q$ expansion, $c<d$ operator sum) are the matched pair. The evenness of $\dim V$ does not circle: the identification of $V$ with a single support is derived without reference to any dimension.

**Three debts, all repairable in a paragraph each.** Range additivity is asserted with no argument (`HYPOTHESIS-DEBT` on the record, though the statement itself is true and now sourced to Fillmore–Williams Theorem 2.2); L179(a) needs one sentence fixing an orthonormal frame adapted to $V$; L180(1)'s label "Ricci-flatness" should say what it is, the defining trace-freeness of $\mathcal W_n$, read spectrally.

**One conclusion falls.** "$\dim V\ge6$ is the whole of what remains" is **not entailed** by L179 and L180, and on the brief as given it is false: $W=\omega_1\otimes\omega_1+\omega_2\otimes\omega_2-2\,\omega_3\otimes\omega_3$ on the self-dual forms of $\mathbb R^4\subseteq\mathbb R^n$ is a rank-three algebraic Weyl tensor with $\dim V=4$, exhibited in closed form in §13 and consistent with every claim under review. **What actually remains after L179 and L180 is $\dim V\in\{4,6,\dots\}$ with $4$ occupied.**

**References fetched for this review are left uncommitted, for the parent to fold in**: [references/fillmore-williams-1971-operator-ranges/](../references/fillmore-williams-1971-operator-ranges/) and [references/viaclovsky-2007-curvature-decomposition/](../references/viaclovsky-2007-curvature-decomposition/), each with a `README.md`, a `notes.md` and the source PDF. Neither is entered in [references/INDEX.md](../references/INDEX.md); that entry is the parent's to make.
