# REVIEW r786, the pair statement flagged beside L184

*Cold brief: [BRIEF-g2-pair.md](BRIEF-g2-pair.md) and nothing else. [findings/](../findings/) was not opened, and no other review was read. **No numerical work was done, not a sweep, not a screen, not a single evaluation. Every value below is exact and derived by hand.** Log: [agent_logs/g2-pair-r786.log](../agent_logs/g2-pair-r786.log).*

## Claim table

| # | Claim | Verdict |
|---|---|---|
| 2 | The pair statement itself: no orthonormal pair with common $6$-dimensional support has equal squares and equal self-wedges | **TRUE** |
| (| Direct attack: a closed-form falsifier exists | **NONE EXISTS**), the fibre is exactly $\{\omega,-\omega\}$ in all three strata |
| 3 | The case split still exhausts with two forms; spectrum still doubled, positive definite, trace $2$ | **INTACT** |
| 4 | Case 1 for a pair; the sign count $s_{1j}s_{1k}=s_{2j}s_{2k}\Rightarrow\omega_2=\eta\omega_1$ | **SOUND**, two of the three equations suffice |
| 5 | Case 2 for a pair; $\star_V$ injective gives $\omega_2=\pm\omega_1$ | **SOUND** |
| 6 | Case 3 for a pair; cross term survives, $4{+}2$ splitting still forced | **SOUND**, and closes twice over |
| 7 | Unit norm genuinely available, not assumed | **AVAILABLE**, but only $\lVert\omega_1\rVert\ne0$ is used; the value $1$ and $\operatorname{tr}A=2$ are **STATED-AND-UNUSED** |
| 8 | Pair statement implies triple statement | **YES, NOTHING LOST** |
| 9 | "Common six-dimensional support" for a pair | **SAME HYPOTHESIS**, and its "common" half is redundant given equal squares |
| 10 | Overreach: a case that closes a triple but needs the third form | **TWO**, case 2's and case 3's *stated* endgames; both replaced, validly, by orthogonality |
|, | $\{\varepsilon_j\wedge\varepsilon_k\}_{j<k}$ linearly independent (case 1) | **HYPOTHESIS-DEBT**, used, no argument on file |
|, | $\alpha\mapsto\alpha\wedge\varepsilon_P$ injective on $\Lambda^2Q$ (case 3) | **HYPOTHESIS-DEBT**, used, no argument on file |
| (| $\star_V:\Lambda^2V\to\Lambda^4V$ an isomorphism (case 2) | **HYPOTHESIS-DEBT**), asserted as "injective", no reason on file |
| (| Normalisation $\star_V(J\wedge J)=2\epsilon_JJ$ (case 2) | **HYPOTHESIS-DEBT**), the orbit/connectedness gloss is on file, the base value $2$ is not |
|, | Case 3's "three signs with all pairwise products equal force the constant to be $+1$" | **REDUNDANT**, $\rho_i=1$ identically, by construction, for any number of forms |
|, | Weyl tensors, even $n$, $n\ge12$, $\sqrt{3/2}$, $6+2\sqrt7$ | **NONE APPEAR**, as the brief asked me to confirm |

**Overall verdict: UPHELD-WITH-DEBT.** The pair statement is true, and the traced argument proves it; four steps it leans on have no argument on file, and two of the block's three case bodies close on a step that a pair does not have.

## Actionable summary

Fold the pair statement as proved, but fold with it the fact that cases 2 and 3 close on **orthogonality** for a pair rather than on the rank-three and three-signs steps the case bodies state, and record the four unstated steps as debt rather than treating the block as self-contained.

## 0. Conventions, fixed once

- $\Lambda^2\mathbb R^n$ carries $\{f_a\wedge f_b\}_{a<b}$ orthonormal; $\langle\alpha,\beta\rangle=-\tfrac12\operatorname{tr}(\alpha\beta)$, so $\lVert\omega\rVert^2=-\tfrac12\operatorname{tr}(\omega^2)$.
- A $2$-form is read as a skew matrix; its **support** is that matrix's image. For skew $\omega$, $\ker\omega=(\operatorname{im}\omega)^\perp$.
- $\varepsilon_W$ denotes the area form of an oriented $2$-plane $W$; $f_{ab\cdots}$ abbreviates $f_a\wedge f_b\wedge\cdots$.
- $\Phi(\omega)=(\omega^2,\omega\wedge\omega)$. The pair statement says no fibre of $\Phi$ over a rank-$6$ point contains an orthonormal pair.
- $V$ is the common support, $\dim V=6$; $A:=-\omega_1^2=-\omega_2^2$; $\star_V$ is $V$'s star for a chosen orientation of $V$.
- Everything below is over $\mathbb R$, and $\Lambda^4V\subset\Lambda^4\mathbb R^n$ is the natural inclusion, so equality of wedges in $\Lambda^4\mathbb R^n$ and in $\Lambda^4V$ are the same statement.

## 1. Hypothesis inventory

**Stated, and used.**

| Hypothesis | Where it does work | Status |
|---|---|---|
| $\omega_1^2=\omega_2^2$ | Defines $A$; forces the common eigenspace decomposition; forces the block-diagonal shape of both forms | **ESSENTIAL** |
| $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2$ | Pins the sign pattern in all three cases; the whole content of the argument | **ESSENTIAL** |
| $\dim V=6$ | Gives exactly three values $c_1^2,c_2^2,c_3^2$, so exactly three cases; and case 2's $\star_V(J\wedge J)\in\Lambda^2V$ | **ESSENTIAL** |
| $V$ is the support, i.e. $A|_V\succ0$ | $c_j>0$ in case 1, $\sqrt{ab}\ne0$ in case 3, $c>0$ in case 2 | **ESSENTIAL** |
| $\langle\omega_1,\omega_2\rangle=0$ | The contradiction, in **all three** cases, for a pair | **ESSENTIAL** |
| $\lVert\omega_i\rVert=1$ | Only through $\lVert\omega_1\rVert\ne0$, converting $\omega_2=\pm\omega_1$ into $\langle\omega_1,\omega_2\rangle=\pm1\ne0$ | **PARTLY USED** |

**Stated and unused.** The *value* $\lVert\omega_i\rVert=1$, and with it $\operatorname{tr}A=2$, and with it case 2's $c=\tfrac13$ and case 3's $2a+b=1$. Every case closes on positivity alone. I record this as hypothesis accounting, not as a proposed strengthening, the brief asked for used/unused, and the fold is not mine to make.

**Used and unstated.** Four steps carry weight and have no argument anywhere in the block or in the traced paragraph. They are true, and I say so, but I am not writing their proofs into the record:

- **U1.** $\{\varepsilon_j\wedge\varepsilon_k\}_{j<k}$ is linearly independent in $\Lambda^4V$ (case 1's "equal wedges force $s_{ij}s_{ik}c_jc_k$ to be independent of $i$" is exactly this).
- **U2.** $\alpha\mapsto\alpha\wedge\varepsilon_P$ is injective on $\Lambda^2Q$ (case 3's "equating it across $i$ gives $\tau_iJ_i$ all equal").
- **U3.** $\star_V:\Lambda^2V\to\Lambda^4V$ is an isomorphism. The block says "$\star$ is injective" with no reason; the reason is the dimension count $\binom64=\binom62=15$, which the block cites for a *different* purpose (that the identity is six-dimensional) and never for injectivity.
- **U4.** The normalisation $\star_V(J\wedge J)=2\epsilon_JJ$. The block supplies the *structure* of the argument (two $SO(6)$-orbits, $\star$ equivariant, $SO(6)$ connected so $\epsilon_J$ is locally constant) but never the base value on one orbit. Without it the identity could read $\star_V(J\wedge J)=\lambda\epsilon_JJ$ for an unknown $\lambda$, which happens to leave the injectivity conclusion intact provided $\lambda\ne0$; that $\lambda\ne0$ is itself uncomputed on file.

Also unstated and used silently: $\varepsilon_W\wedge\varepsilon_W=0$ for a plane $W$ (case 1 for each $\varepsilon_j$, case 3 for $\varepsilon_P$, the latter is stated, the former is not), and the fact that an orientation of $V$ must be **chosen** before $\star_V$ exists, the conclusion being orientation-independent because $\epsilon_J$ and $\star_V$ flip together.

**Not used, and confirmed absent as the brief requested.** No algebraic Weyl tensor, no parity condition on $n$, no $n\ge12$, no $\sqrt{3/2}$, no $6+2\sqrt7$. Nothing in the pair argument constrains $n$ at all beyond $n\ge6$.

## 2. Item 2, the direct attack, made before reading the argument

I took the pair statement cold and tried to build the counterexample, by describing the **whole fibre** of $\Phi$ over a rank-$6$ point rather than by hunting. Fix $\omega_1$ of rank $6$ with support $V$ and put $A=-\omega_1^2$. Any $\omega_2$ in the fibre has $\omega_2^2=\omega_1^2$, hence $\operatorname{im}\omega_2=\operatorname{im}\omega_2^2=\operatorname{im}\omega_1^2=V$, so $\omega_2$ lives in the same $\Lambda^2V$ and commutes with $A$. The description then splits by $A|_V$'s multiplicities, which are $(2,2,2)$, $(6)$ or $(4,2)$.

**Stratum $(2,2,2)$.** $A|_V$ has eigenplanes $P_1,P_2,P_3$; the square condition alone gives $\omega=\sum_js_jc_j\varepsilon_j$, $s_j=\pm1$, a fibre of $8$ forms. Wedging, and using $\varepsilon_j\wedge\varepsilon_j=0$,
$$\omega\wedge\omega=2\sum_{j<k}s_js_kc_jc_k\,\varepsilon_j\wedge\varepsilon_k .$$
So the wedge records exactly the three products $s_1s_2,s_1s_3,s_2s_3$, which determine $(s_1,s_2,s_3)$ up to a global flip. The fibre of $\Phi$ is $\{\omega,-\omega\}$: **two** elements, and $\langle\omega,-\omega\rangle=-1\ne0$. No counterexample here.

**Stratum $(6)$, $A|_V=c\,\mathrm{Id}$.** The square condition says $J:=\omega/\sqrt c$ is orthogonal and skew, i.e. a compatible complex structure; the fibre of the square alone is $\sqrt c\cdot O(6)/U(3)$, two copies of $\mathbb{CP}^3$, and is very large. The wedge collapses it: $\omega\wedge\omega=c\,J\wedge J$ and $\star_V(J\wedge J)=2\epsilon_JJ$, so equal wedges give $\epsilon_1J_1=\epsilon_2J_2$, hence $J_2=\pm J_1$, and the sign is forced to be the one that flips the orientation class, since $\epsilon_{-J}=-\epsilon_J$. The fibre of $\Phi$ is again exactly $\{\omega,-\omega\}$. This is the stratum where a counterexample would most plausibly hide, the square's own fibre being $6$-dimensional; it does not.

**Stratum $(4,2)$.** $\omega=\sqrt a\,J\oplus\tau\sqrt b\,\varepsilon_P$ with $J$ a compatible complex structure on the $4$-plane $Q$ and $\tau=\pm1$; the square's fibre is $\{\pm\}\times O(4)/U(2)$. The wedge is $a\,J\wedge J+2\tau\sqrt{ab}\,J\wedge\varepsilon_P$ and its cross term records $\tau J$ exactly. So $(J,\tau)$ is determined up to $(J,\tau)\mapsto(-J,-\tau)$, which is $\omega\mapsto-\omega$. Fibre $\{\omega,-\omega\}$ once more.

**Conclusion of the direct attack.** At $\dim V=6$ the fibre of $\Phi$ is $\{\omega,-\omega\}$ in every stratum. Two forms in one fibre satisfy $\omega_2=\pm\omega_1$, so $\langle\omega_1,\omega_2\rangle=\pm\lVert\omega_1\rVert^2\ne0$ and they cannot be orthogonal. **The pair statement is TRUE.** There is no falsifier to exhibit, and I looked for one only in this closed form, no search, no sweep, no evaluation.

**Non-vacuity, in closed form, so the statement is not true for the wrong reason.** $\omega_1=(f_{12}+f_{34}+f_{56})/\sqrt3$ and $\omega_2=(f_{12}+f_{34}-2f_{56})/\sqrt6$ are both unit ($3/3=1$, $(1+1+4)/6=1$), orthogonal ($(1+1-2)/\sqrt{18}=0$), and both have support $\operatorname{span}(f_1,\dots,f_6)$. So the hypotheses other than the two coincidences are jointly satisfiable, and the lemma has content.

## 3. Item 3, does the case split still exhaust with two forms

**Yes, and no step in it involves a second form at all, let alone a third.** Taking each ingredient in turn:

- **Doubling.** $\omega_1$ is skew and invertible on $V$, so its nonzero eigenvalues are $\pm\mathrm ic_j$ in conjugate pairs and $A|_V=-\omega_1^2|_V$ has every eigenvalue with even multiplicity. This is a statement about $\omega_1$ alone. $\omega_2$ contributes nothing except that its square is the same matrix.
- **Positive definiteness.** $A=\omega_1^{\mathsf T}\omega_1\succeq0$ with kernel $\ker\omega_1=V^\perp$, so $A|_V\succ0$. One form.
- **Trace.** $\operatorname{tr}A=2\lVert\omega_1\rVert^2=2$. One form. (And, per §7, never used again.)
- **Preservation of eigenspaces.** $\omega_1$ commutes with $\omega_1^2=-A$, and $\omega_2$ commutes with $\omega_2^2=-A$, so **each separately** preserves each eigenspace. The shared hypothesis is what makes it the *same* $A$; there is no step requiring three preservers rather than two.
- **Exhaustiveness.** The split is a trichotomy on the multiset $\{c_1^2,c_2^2,c_3^2\}$ of positive reals: all distinct, all equal, exactly two equal. Three is the number of values because $\dim V=6$ and the multiplicities are even. This is combinatorics on a $3$-element multiset and is indifferent to how many forms are in play.

One caveat, which the block already carries and I confirm rather than raise as new: the doubling is a statement about $A|_V$, not about $A$ on $\mathbb R^n$, where $0$ appears with multiplicity $n-6$ of unconstrained parity. The traced pair paragraph hedges this correctly by saying "on the common support $V$".

## 4. Item 4, case 1 for a pair, and the sign count

Write $t_j:=s_{1j}s_{2j}\in\{\pm1\}$. Equal wedges give, for each $j<k$, $s_{1j}s_{1k}c_jc_k=s_{2j}s_{2k}c_jc_k$, and $c_jc_k>0$ cancels, leaving $s_{1j}s_{1k}=s_{2j}s_{2k}$. Multiplying both sides by $s_{1j}s_{1k}$ turns this into
$$t_jt_k=1\qquad(j<k).$$
Three equations, in three sign unknowns of which only the two ratios $t_2/t_1$ and $t_3/t_1$ are free once a global sign is factored out, the count the brief asked me to check. **Two of the three equations already close it**: $t_1t_2=1$ gives $t_2=t_1$ and $t_1t_3=1$ gives $t_3=t_1$, whereupon $t_2t_3=t_1^2=1$ holds automatically. So the system is consistent, not over-determined, and its solution set is exactly $t_1=t_2=t_3=\eta\in\{\pm1\}$, i.e. $s_{2j}=\eta s_{1j}$ for every $j$, i.e. $\omega_2=\eta\omega_1$.

The triple version's $\eta_i=s_{i1}s_{11}$ specialises to $\eta=t_1$ with no loss. Then $\operatorname{tr}(\omega_1\omega_2)=\eta\operatorname{tr}(\omega_1^2)=-2\eta\lVert\omega_1\rVert^2=-2\eta\ne0$, against orthogonality. **Case 1 for a pair: SOUND.** The one silent step is U1, the independence of $\{\varepsilon_j\wedge\varepsilon_k\}$, without which "equal wedges force the products" does not follow; it is not on file.

## 5. Item 5, case 2 for a pair

$A|_V=c\,\mathrm{Id}_6$ imposes nothing on which subspaces are preserved, so the whole argument is the star's. $\omega_i=\sqrt c\,J_i$ with $J_i$ compatible complex structures; $\omega_i\wedge\omega_i=c\,J_i\wedge J_i$; applying $\star_V$ and the identity $\star_V(J\wedge J)=2\epsilon_JJ$ gives $2c\,\epsilon_1J_1=2c\,\epsilon_2J_2$, and $c>0$ gives $\epsilon_1J_1=\epsilon_2J_2$, hence $J_2=\pm J_1$ and $\omega_2=\pm\omega_1$. **SOUND for a pair**, resting on U3 and U4.

But note what changes. **The block's stated contradiction in case 2 is not available to a pair.** The case body closes with "the contradiction is then linear independence rather than orthogonality: $J_i=\pm K$ leaves the three forms spanning a line, so the rank cannot be three", and adds that "the trace condition $\operatorname{tr}(J_iJ_j)\ne0$ is not needed at all". Two forms spanning a line is not a contradiction; the trace condition, i.e. orthogonality, is exactly what a pair needs, and r780's remark that it is "not needed at all" is scoped to the triple and must not be carried across. The traced pair argument does make the substitution correctly, so nothing is broken; but the case body as written does not prove the pair statement, and a reader taking case 2 verbatim would find no contradiction at all.

## 6. Item 6, case 3 for a pair, and whether $4{+}2$ is still forced

**The splitting is forced, by one form.** "Exactly two of $c_1^2,c_2^2,c_3^2$ agree" means $A|_V$ has two distinct eigenvalues with multiplicities $4$ and $2$; $Q$ and $P$ are then *defined* by $A$, which is $-\omega_1^2$. Both $\omega_i$ preserve both, being skew and commuting with $A$. On $Q$, $-\omega_i^2=a\,\mathrm{Id}_4$ makes $J_i:=\omega_i|_Q/\sqrt a$ orthogonal and skew, a complex structure; on $P$, a skew map is a multiple of $\varepsilon_P$ and $-\omega_i^2=b$ fixes it to $\tau_i\sqrt b\,\varepsilon_P$. No step counts forms. The labelling $(a,a,b)$ versus $(a,b,b)$ is a naming choice (the $4$-plane is whichever eigenvalue repeats) and the argument is symmetric under it.

**The cross term survives with two indices.** $\varepsilon_P\wedge\varepsilon_P=0$, so
$$\omega_i\wedge\omega_i=a\,J_i\wedge J_i\;+\;2\tau_i\sqrt{ab}\,J_i\wedge\varepsilon_P,$$
the two summands lying in the independent subspaces $\Lambda^4Q$ and $\Lambda^2Q\wedge\Lambda^2P$ of $\Lambda^4V$. Equality for $i=1,2$ gives, in the second summand, $\tau_1J_1\wedge\varepsilon_P=\tau_2J_2\wedge\varepsilon_P$ after dividing by $2\sqrt{ab}\ne0$ (this is where positive definiteness earns its keep) and U2 gives $\tau_1J_1=\tau_2J_2$. Hence $J_2=\tau_1\tau_2J_1$ and
$$\omega_2=\sqrt a\,\tau_1\tau_2J_1\oplus\tau_2\sqrt b\,\varepsilon_P=\tau_1\tau_2\bigl(\sqrt a\,J_1\oplus\tau_1\sqrt b\,\varepsilon_P\bigr)=\tau_1\tau_2\,\omega_1 .$$
Orthogonality then fails. **SOUND for a pair.**

**Case 3 in fact closes twice over for a pair, and this exposes a redundancy in the block.** Set $J:=\tau_1J_1$; then $\tau_iJ_i=J$ gives $J_i=\tau_iJ$, so $\sigma_i=\tau_i$ and $\rho_i=\sigma_i\tau_i=\tau_i^2=1$ **identically**. The block reaches "$\rho_i$ is constant" from the cross term and then spends a further step ("three signs with all pairwise products equal force that constant to be $+1$"), to fix the value. That step is unnecessary: the cross term hands over $\rho_i=1$ directly, for any number of forms. Feeding it into the block's own trace identity,
$$\operatorname{tr}(\omega_1\omega_2)=-4a\sigma_1\sigma_2-2b\tau_1\tau_2=-(4a+2b)\tau_1\tau_2,$$
so orthogonality demands $4a+2b=0$, i.e. $\operatorname{tr}A=0$, which is impossible for $a,b>0$. The arithmetic endgame therefore transfers to a pair verbatim once the redundant step is dropped, but as the block stands, its final flourish is a genuinely three-index count, so §10's remark applies here as it does to case 2.

## 7. Item 7, is unit norm genuinely available

**Available, in all three cases, and assumed nowhere.** $\lVert\omega_1\rVert=\lVert\omega_2\rVert=1$ is part of "orthonormal pair"; nothing in the argument derives it, and nothing derives a contradiction *from* it that would make it self-supporting.

What it is actually used for is narrower than the block suggests. The closing move in every case is $\omega_2=\pm\omega_1$ against $\langle\omega_1,\omega_2\rangle=0$, and $\langle\omega_1,\pm\omega_1\rangle=\pm\lVert\omega_1\rVert^2$, which needs only $\omega_1\ne0$, guaranteed already by $\dim V=6$. The consequences the block draws from the value $1$, $\operatorname{tr}A=2$, $c=\tfrac13$ in case 2, $2a+b=1$ in case 3, $c_1^2+c_2^2+c_3^2=1$ in case 1, are never consumed. Case 3's arithmetic route needs $4a+2b\ne0$, which is positivity, not the value $2$. I record this as an accounting fact; folding a weakened hypothesis into the statement is not a reviewer's call, and I have not made it.

## 8. Item 8, does the pair statement imply the triple statement

**Yes, verbatim, and nothing is lost.** Let $\omega_1,\omega_2,\omega_3$ be an orthonormal triple with coincident squares and self-wedges. Then $\omega_1,\omega_2$ is an orthonormal pair; $\omega_1^2=\omega_2^2$ and $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2$ by restriction of the hypothesis; and their common support is $V$, of dimension $6$, because equal squares force equal supports (below). The pair statement applies and the triple cannot exist.

The implication is strict in the other direction (a pair is not a triple) so the pair statement is genuinely stronger, and this is the sense in which the observation was right to flag it. What the triple statement retains that the pair does not *state* is the corollary's shape: L184's consumer wants a rank-three Weyl tensor excluded, and that consumer is served through the triple. Nothing mathematical is lost; only the phrasing has to be routed through §8's one-line specialisation.

## 9. Item 9, the kernel and the support

**"Common six-dimensional support" is the same hypothesis for a pair as for a triple, and its "common" half is redundant.** For skew $\omega$, $-\omega^2=\omega^{\mathsf T}\omega$, and $\ker(\omega^{\mathsf T}\omega)=\ker\omega$, so $\operatorname{im}\omega^2=\operatorname{im}\omega$ by rank. Hence $\omega_1^2=\omega_2^2$ already gives $\operatorname{im}\omega_1=\operatorname{im}\omega_2$, and the content of the hypothesis is only that this common image has dimension $6$. The block says as much ("equal squares already force a common support") and asserts it without the rank argument; I note the assertion is correct.

No step needs more than this. In particular nothing needs $V$ to be $\omega_i$-invariant beyond what skewness gives, nothing needs $V^\perp$ to have even dimension, and nothing needs the ambient $n$.

Where $\dim V=6$ is genuinely load-bearing, as against decorative: (i) the trichotomy has three values only because $6=2\cdot3$; (ii) case 2's $\star_V(J\wedge J)$ lands back in $\Lambda^2V$ only in six dimensions. Both are hypotheses on $\dim V$, not on $n$, the same conflation the block records having made twice.

## 10. Item 10, overreach

**Yes, in two places, and they matter for exactly this audit.**

- **Case 2's stated contradiction is three-index.** "$J_i=\pm K$ leaves the three forms spanning a line, so the rank cannot be three" is a statement about three forms and is empty for two. For a pair the contradiction must be orthogonality, which the block elsewhere calls "not needed at all".
- **Case 3's stated endgame is three-index.** "Three signs with all pairwise products equal force that constant to be $+1$" counts three indices. §6 shows the constant is $+1$ by construction, so the count was never needed, but as written, the case body's last step does not run on two forms.

Case 1 is free of this: its conclusion $\omega_2=\eta\omega_1$ and its contradiction $\operatorname{tr}(\omega_1\omega_2)=-2\eta$ are already two-index, which is presumably why the observation was noticed there first.

The consequence for the fold: **the pair statement is true, but the block's three case bodies do not, as written, prove it.** The proof of the pair statement is the traced paragraph in the observation box, which substitutes orthogonality for the two three-index endgames. That substitution is valid and I have checked it in §5 and §6. It is nonetheless a different argument from the one the cases record, and a ledger row saying "L184's cases prove the pair statement" would be wrong in cases 2 and 3.

## 11. What would break it, and what I did to look

**The falsifier.** An orthonormal pair $\omega_1,\omega_2$ of $2$-forms, both of rank $6$ with the same image $V$, with $\omega_1^2=\omega_2^2$ and $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2$ and $\omega_2\ne\pm\omega_1$. Equivalently, and more usefully: **a second element of $\Phi$'s fibre besides $\pm\omega_1$**. Concretely that would be one of

- a sign vector $(s_{2j})$ with all three products $s_{2j}s_{2k}$ equal to $s_{1j}s_{1k}$ but $(s_{2j})\ne\pm(s_{1j})$, case 1;
- a compatible complex structure $J'$ on $\mathbb R^6$ with $J'\wedge J'=J\wedge J$ but $J'\ne\pm J$, case 2, the widest fibre and the likeliest hiding place, the square alone leaving a $6$-dimensional family;
- a pair $(J',\tau')$ on $Q\oplus P$ with $\tau'J'=\tau J$ failing while the wedges agree, case 3.

**What I did to look.** I described each of the three fibres in closed form, as in §2, and each collapses to $\{\omega,-\omega\}$: the first by the sign identity $t_jt_k=1$, the second by $\star_V$ being an isomorphism, the third by $\alpha\mapsto\alpha\wedge\varepsilon_P$ being injective. **No computation of any kind was run**, the analysis-only footing was honoured to the letter, including the screening allowance, which I did not use. A falsifier would have to escape the trichotomy, and §3 shows the trichotomy is exhaustive for any three positive reals.

## Verdict

**UPHELD-WITH-DEBT.**

The pair statement is **true**. I established it independently of the block, by exhibiting the fibre of $\Phi$ over every rank-$6$ point as exactly $\{\omega,-\omega\}$, and the traced argument proves it too. The strengthening the observation declined to fold is therefore real, and the discipline that deferred it was cheap rather than costly.

Three things go with the fold, and the row should not be written without them. **First**, cases 2 and 3 close, as written in the block, on steps that only three forms possess; the pair proof substitutes orthogonality, validly, but that substitution lives in the observation box and not in the case bodies. **Second**, four steps carry the argument and have no argument on file (U1 through U4 of §1) and I have named them rather than repaired them, this round having been convened over exactly that. **Third**, the hypothesis $\lVert\omega_i\rVert=1$ is consumed only as $\omega_1\ne0$, so $\operatorname{tr}A=2$, $c=\tfrac13$ and $2a+b=1$ are stated-and-unused; what the cases actually need from the support hypothesis is positivity.

No Weyl tensor, no parity of $n$, no $n\ge12$, and neither threshold appears anywhere in the pair argument or in my verification of it.
