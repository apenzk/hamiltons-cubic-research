# Gate 2 review r373, [Lemma L128](../findings/second-order.md), the branching clause

Brief: attack parts (i), (ii), (iii), the novelty accounting, and the boxed non-reinstatement claim, working from the definitions and re-deriving before reading the author's proof. **Analysis only**, no run was made, and the two places below where a computation would decide something are named and stopped at.

**Verdicts.**

| claim | verdict | one line |
|---|---|---|
| (i) orbit tangent lies in the pair blocks; four-set blocks and $\mathcal D_n$ orbit-free | **CONFIRMED** | re-derived from $\rho(E_{jk})$; the negative half is immediate from directness of the sum. Three defects, all fillable: a sign inconsistency, "fixes" for "annihilates", and a silent Ricci-flatness step |
| (ii) the block criterion, stated as an **iff** | **REFUTED as stated** | witness $S^2\times S^4$: pure, critical, Morse–Bott **nondegenerate**, four-set blocks at $\tfrac23>\tfrac12$. The repair is one character: $\tfrac12$ **absent**, not spectrum $<\tfrac12$ |
| (iii) nondegeneracy $\Rightarrow$ the orbit is isolated | **CORRECTED** | the conclusion is true and the self-adjointness step is exactly right; the slice as defined is an **affine** subspace that meets $S(\mathcal W_n)$ only at $W$, so the IFT conclusion is vacuous and the covering fails. Repair: take the slice inside the sphere |
| (iv) novelty accounting | **REFUTED** | the one thing (i) is billed as contributing (the negative half), is already on the record in **three** places, one of them ten lines above L128 in its own file |
| (v) the boxed "this does not reinstate [L127](../findings/second-order.md)'s withdrawn clause" | **REFUTED** | the two hypotheses are the same condition, so the distinction drawn is not a distinction; (iii) **does** reinstate the clause, and that is the lemma's best news |

The lemma's substantive contribution (part (iii)), survives, repaired. What fails is the iff in (ii), the novelty accounting, and the boxed self-assessment.

---

## Part (i), CONFIRMED

**Re-derived independently.** With $E_{jk}=e_j\otimes e_k-e_k\otimes e_j$ acting as $Ex=e_j\langle e_k,x\rangle-e_k\langle e_j,x\rangle$, the induced derivation on $\Lambda^2$ gives

- $\rho(E)(e_j\wedge e_k)=(Ee_j)\wedge e_k+e_j\wedge(Ee_k)=-e_k\wedge e_k+e_j\wedge e_j=0$;
- $\rho(E)(e_a\wedge e_b)=0$ for $a,b\notin\{j,k\}$;
- $\rho(E)e_{ki}=e_{ji}$ and $\rho(E)e_{ji}=-e_{ki}$ for $i\notin\{j,k\}$.

Nothing maps *into* $e_{jk}$ either, since the only nonzero images are $e_{ji}$ and $e_{ki}$ with $i\notin\{j,k\}$. So $\rho(E_{jk})$ is a direct sum of elementary rotations of the $2$-planes $\operatorname{span}(e_{ji},e_{ki})$, and its only nonzero matrix elements join $e_{ji}$ to $e_{ki}$, the lemma's claim, confirmed.

For $W$ pure, $We_{ab}=M_{ab}e_{ab}$, the commutator has entries $[\rho,W]_{\alpha\beta}=(M_\beta-M_\alpha)\rho_{\alpha\beta}$, so the two surviving entries are $[\rho,W]_{ji,ki}=[\rho,W]_{ki,ji}=M_{ki}-M_{ji}$, equal, as they must be, the bracket of an antisymmetric with a symmetric operator being symmetric. Hence

$$[\rho(E_{jk}),W]\ \in\ \operatorname{span}\{f_i=e_{ji}\odot e_{ki}\ :\ i\notin\{j,k\}\},\qquad o^{jk}_i=M_{ki}-M_{ji},$$

and linearity over $A=\sum a_{jk}E_{jk}$ puts each summand in its own pair block. **The negative half then costs nothing**: [Lemma L120](../findings/second-order.md)'s decomposition is a *direct* sum, so a vector lying in $\bigoplus_{\{j,k\}}V_{jk}$ has zero component in every four-set block and in $\mathcal D_n$, and $T_W\mathcal O\cap V_{ijkl}=T_W\mathcal O\cap\mathcal D_n=0$. Confirmed.

**Stress tests, all passed.** *Repeated entries in $M$*: some $o^{jk}$ vanish, the orbit is smaller, the containment is untouched. *$W$ with kernel* (some $M_{ab}=0$): the commutator computation never divides by $M$, so nothing changes. *Frame not an eigenframe*: outside the hypothesis, and there [Lemma L120](../findings/second-order.md)'s block-diagonality of $L_W$ fails anyway, so (ii) is not evaluable, which [post F44](../findings/second-order.md) already records.

**The corollary is correct and worth keeping as stated.** Because the $V_{jk}$ are independent, $\sum a_{jk}o^{jk}=0$ forces $a_{jk}=0$ whenever $o^{jk}\ne0$. So $\dim\mathcal O=\#\{\{j,k\}:o^{jk}\ne0\}$, and the isotropy algebra is spanned by those $E_{jk}$ with $M_{ji}=M_{ki}$ for all $i\notin\{j,k\}$, the lemma's "rows of $M$ agree off $\{j,k\}$". Both halves check out. *The sentence carrying them is garbled ("the corollary that $\dim\mathcal O=\#\{\dots\}$'s span" is not a sentence) and should be rewritten.*

**Three defects, none fatal.**

1. **The stated $\rho$ action contradicts the stated coefficient.** The proof writes "$e_{ji}\mapsto e_{ki}$, $e_{ki}\mapsto-e_{ji}$", which is the negative of what $E_{jk}=e_j\otimes e_k-e_k\otimes e_j$ gives, and then quotes the coefficient $M_{ki}-M_{ji}$, which belongs to the *other* convention, the one [DERIVE-df1](DERIVE-df1.md) §DF1b step 4(ii) writes down correctly. With L128's own $\rho$ the coefficient is $M_{ji}-M_{ki}$. Span- and spectrum-neutral, so nothing downstream moves, but it is evidence the proof was transcribed rather than recomputed, and this record has already paid once for exactly that ([DERIVE-df1](DERIVE-df1.md)'s $\sigma_i$ artefact).
2. **"$\rho(E_{jk})$ fixes $e_{jk}$" should read "annihilates".** $\rho$ here is the Lie *algebra* action, and $\rho(E_{jk})e_{jk}=0$. What the argument uses is the vanishing, so the conclusion is unaffected.
3. **Ricci-flatness is used silently, and the block it lands in is misnamed.** $\operatorname{span}\{f_i\}$ has dimension $n-2$ and is the $\varepsilon_j\varepsilon_k$ *character space*; [Lemma L120](../findings/second-order.md)'s $V_{jk}$ is the $(n-3)$-dimensional Weyl cut $\mathbf 1^\perp$ inside it. The proof calls the $(n-2)$-dimensional span "[Lemma L122](../findings/second-order.md)'s basis of $V_{jk}$", conflating the two. The gap closes at once, $\sum_{i\notin\{j,k\}}(M_{ki}-M_{ji})=(-M_{jk})-(-M_{jk})=0$ by the row sums, so $o^{jk}\in\mathbf 1^\perp$, but Ricci-flatness is what closes it and the proof does not say so.

## Part (ii), REFUTED as an iff, and the repair is one character

**The kernel identification is right.** [Lemma L24](../findings/second-order.md) gives $\mathrm{Hess}(P|_S)_W=6\theta(L_e-\tfrac12\mathrm{Id})$ on $T_WS=W^\perp$, so $\ker\mathrm{Hess}=E_{L_e}(\tfrac12)\cap W^\perp$. Confirmed, and the intersection is in fact free: $L_e$ is self-adjoint with $L_eW=W$ (since $W\circ W=Q(W)=\theta W$ and $e=W/\theta$), so eigenspaces at $\tfrac12$ and $1$ are orthogonal and $E_{L_e}(\tfrac12)\subseteq W^\perp$ automatically. The lemma's "$W\in\mathcal D_n$ is removed by the restriction to $W^\perp$" is still needed for the *phrasing* of the $\mathcal D_n$ clause (otherwise the eigenvalue $1$ would breach it) and $\mathcal D_n\cap W^\perp$ is $L_e$-invariant, so that clause is well posed.

**The block reduction is right.** $\ker\mathrm{Hess}=\bigoplus_B\big(E_{L_e}(\tfrac12)\cap B\big)$ over the blocks $B$ of [Lemma L120](../findings/second-order.md), and $T_W\mathcal O=\bigoplus_{\{j,k\}}\operatorname{span}(o^{jk})$ by (i). So $\ker\mathrm{Hess}=T_W\mathcal O$ **iff**, block by block, $E_{L_e}(\tfrac12)\cap B=T_W\mathcal O\cap B$. That is the right shape, and it disposes of one of the brief's worries immediately: *several pair blocks sharing the eigenvalue $\tfrac12$ is harmless*, precisely because the criterion is per-block and the blocks are independent summands.

**But the four-set and $\mathcal D_n$ clauses are stated too strongly.** What the block reduction requires there is $E_{L_e}(\tfrac12)\cap B=0$, i.e. $\tfrac12\notin\sigma(L_e|_B)$. The lemma demands $\sigma(L_e|_B)<\tfrac12$, which additionally forbids eigenvalues **above** $\tfrac12$. Those two conditions coincide at a *maximiser*, by [Lemma L24](../findings/second-order.md); L128's hypothesis is only "pure critical point with $\theta>0$", where they do not.

> **WITNESS, entirely from the record: $S^2\times S^4$ at $n=6$.** It is a pure critical point with $\theta>0$. It is **Morse–Bott nondegenerate**, [Lemma L11](../findings/nondegeneracy.md) covers all two-block sphere products with $k,l\ge2$ up to $n=14$ except $(3,3)$, and [nondegeneracy.md](../findings/nondegeneracy.md) states separately that "the whole $S^2\times S^k$ family is nondegenerate natively". And its $(2,2)$-split four-set blocks carry $L_e$-eigenvalues $\pm\mu_{2,4}=\pm\tfrac23$, [Lemma L121](../findings/second-order.md) prints the value $\tfrac23$ at $S^2\times S^4$ by name, and [Lemma L126](../findings/second-order.md) has $\mu_{2,q}=\tfrac q{2(q-1)}>\tfrac12$ at every $q$. So $\ker\mathrm{Hess}=T_W\mathcal O$ holds while "every four-set block has $L_e$-spectrum $<\tfrac12$" fails. **The "only if" direction is false.**

**The repair.** Replace the four-set and $\mathcal D_n$ clauses by "$\tfrac12$ is not an eigenvalue", equivalently, by [Lemma L121](../findings/second-order.md), $A^2+B^2+C^2-AB-BC-CA\ne\theta^2$ at every four-subset. Nothing else in the lemma moves, and **(iii) is unaffected**, since it consumes (ii) only as a sufficient condition.

**Two further consequences of the repair, both in the lemma's favour.**

- **The lemma's own corollary in (iii) becomes correct.** "A critical point outside $\mathcal O$ can approach $\mathcal O$ only if some block violates (ii), *that is, only where a non-orbit block eigenvalue equals exactly $\tfrac12$*" is a non-sequitur under the stated (ii), where violation also covers eigenvalues above $\tfrac12$. Under the repaired (ii) the gloss is exact. Together with L127's own table, which asks "reaches $\tfrac12$?" rather than "stays below $\tfrac12$?", this reads as a slip introduced at L128 rather than an intended strengthening.
- **[I18](../plan.md) inherits the slip and should be restated.** L128's closing paragraph asks for the **strict** inequality $A^2+B^2+C^2-AB-BC-CA<\theta^2$ at every four-subset. What isolation needs is $\ne\theta^2$. At a point already known to be a maximiser the two agree by [Lemma L24](../findings/second-order.md), but I18 is posed over *every* pure critical point with $\theta>\sqrt{3/2}$, where maximality is exactly what is not known. The strict form is a strictly harder question than the one the route needs.

**The $o^{jk}=0$ clause is right but ill-formed.** Where $o^{jk}=0$ the pair block carries no orbit direction, so the correct requirement is that $\tfrac12$ be absent from it; "simple with eigenvector $o^{jk}$" cannot be satisfied by the zero vector, so the disjunction does collapse to the right thing, but it should be written as two cases rather than left to the reader to notice that an eigenvector is nonzero by definition.

## Part (iii), CORRECTED

**What is right, including the step the brief singled out.**

$F(X)=3(Q(X)-P(X)X)$ is the gradient of $P|_S$: $\nabla P=3Q$ in $\mathcal W_n$, and subtracting the radial part at $\lVert X\rVert=1$ gives exactly $F$. It is a genuine vector field **on $\mathcal W_n$**, which needs $Q(\mathcal W_n)\subseteq\mathcal W_n$, true, and on the record at [problem.md](../findings/problem.md) from [BW08](../references/boehm-wilking-2008-space-forms/) eq. (6) together with $\Phi$ preserving first Bianchi, cited as load-bearing at [bounds.md](../findings/bounds.md). **L128 uses this silently**; it should be cited, because without it the criticality equation carries a Weyl projection and $F$ is not what is written. So $S(\mathcal W_n)$ is the right ambient manifold, the objection dissolves, but only against a record fact the lemma does not name.

$dF_W$ on $W^\perp$: differentiating in a direction $v\perp W$ gives $3(2W\circ v-3\langle Q(W),v\rangle W-\theta v)=6\theta(L_e-\tfrac12\mathrm{Id})v$, the Hessian, self-adjoint, kernel $T_W\mathcal O$ under (ii). $\mathcal O$ is compact, $SO(n)$ acts by isometries, and $F$ is equivariant since $\circ$ is $O(n)$-equivariant and $P$ invariant. All confirmed.

**The self-adjointness step is exactly right, and it is doing real work.** Write $H=dF_W$ on $W^\perp$, $K=\ker H=T_W\mathcal O$, $V=K^\perp\cap W^\perp$. Self-adjointness gives $\operatorname{im}H\subseteq(\ker H)^\perp=V$, so $H(V)\subseteq V$ and therefore $\Pi_V\circ H|_V=H|_V$, the projection is a no-op on the slice tangent, which is what the lemma asserts. And $H|_V$ is injective because $\ker H\cap V=K\cap K^\perp=0$. Invertible. **Confirmed, and it genuinely fails without self-adjointness**: a general operator with kernel $K$ need not preserve $K^\perp$, and then $\Pi_V\circ H|_V$ can be singular while $H$ has kernel exactly $K$.

**What is wrong: the slice is not in the sphere.**

> $N=W+\big((T_W\mathcal O)^\perp\cap W^\perp\big)$ is an **affine subspace** of $\mathcal W_n$ with direction space $V\perp W$. For $v\in V$, $\lVert W+v\rVert^2=1+\lVert v\rVert^2$. Hence $N\cap S(\mathcal W_n)=\{W\}$, the affine slice is *tangent* to the unit sphere at $W$ and touches it nowhere else.

Three things break, in order.

1. **"Hence no critical point in $U$ other than $W$" is vacuously true and carries no information.** Critical points of $P|_S$ live on $S$, and $U\cap S=\{W\}$ already, before any inverse function theorem is invoked. The IFT step is sound and its conclusion is empty.
2. **The covering step fails outright.** $\bigcup_{g}g\cdot N$ is a hypersurface in $\mathcal W_n$ containing $\mathcal O$ and tangent to $S$ along it; its intersection with $S$ is $\mathcal O$ itself. It contains no neighbourhood of $\mathcal O$ *in $S$*, so "the translated slices $g\cdot U$ cover a neighbourhood of the compact orbit" is false as written, and the brief's worry (critical points near the orbit but off every slice), is not merely unaddressed, it is where **every** nearby critical point sits.
3. Consequently the proof as printed establishes nothing about $\mathrm{Crit}(P|_S)$ near $\mathcal O$.

**The repair, which costs nothing.** Take the slice **inside the sphere**: $N_S=\{(W+v)/\lVert W+v\rVert : v\in V,\ \lVert v\rVert<\varepsilon\}$, or equivalently $\exp_W(V\cap B_\varepsilon)$. Then $N_S\subseteq S$ is a submanifold with $T_WN_S=V$, the radial normalisation has derivative $\mathrm{Id}_V$ at $W$, and $G=\Pi_V\circ F|_{N_S}$ has $dG_W=\Pi_V\circ H|_V=H|_V$, invertible by the paragraph above. The IFT then gives a genuine neighbourhood $U\subseteq N_S\subseteq S$ with $F^{-1}(0)\cap U=\{W\}$.

**And the covering step then works, but needs the argument the lemma omits.** Define $\Psi:SO(n)\times U\to S$, $(g,u)\mapsto g\cdot u$. Its differential at $(e,W)$ is $(A,v)\mapsto[\rho(A),W]+v$, whose image is $T_W\mathcal O+V=T_WS$, surjective. So $\Psi$ is a submersion near $(e,W)$ and its image contains an open $\Omega\ni W$ in $S$; then $\bigcup_g g\Omega$ is an open neighbourhood of $\mathcal O$ in $S$, and any critical $X$ in it satisfies $X=gh\cdot u$ with $u\in U$ critical, hence $u=W$ and $X\in\mathcal O$. **This is the step that answers the brief's question, and it is exactly what the printed proof asserts without proving.**

**One presentational upgrade the record should take.** The conclusion is better stated as "$\mathcal O$ is open in $\mathrm{Crit}(P|_S)$, hence (being compact, connected and closed), a connected component of it". That is verbatim the statement [Lemma L28](../findings/nondegeneracy.md)'s preamble uses ("a nondegenerate orbit is open in $\mathrm{Crit}(P)$ and $S=0$ is closed, so the graded set would then be a union of connected components") and that [findings/INDEX.md](../findings/INDEX.md) records as settled. So (iii) discharges an assumption the record leans on in at least three places.

## Part (iv), the novelty accounting is REFUTED

The lemma bills as new: "the negative half of (i), that the four-set blocks and $\mathcal D_n$ are orbit-free, which is what turns nondegeneracy into a finite list of strict block inequalities". **It is on the record in three places.**

| where | what it says |
|---|---|
| [Lemma L126](../findings/second-order.md), ten lines above L128 in the same file | "The four-set blocks are orbit-free: the orbit tangent for the $(j,k)$ generator lies in the $\{j,k\}$ pair block, so the orbit's tangent space lies in the span of the pair blocks." |
| [DERIVE-df1](DERIVE-df1.md) §DF1b step 4(ii), the section L128 cites for the *positive* half | "**So the whole orbit lies in the sum of the pair blocks**, and the $4$-set and diagonal blocks contain no orbit direction, no counting needed, and the statement holds whatever the isotropy is." |
| [r370](REVIEW_r370.md) | verdict row Y2, "four-set blocks orbit-free (**CONFIRMED**), re-derived from $[\rho(\xi),M]$" |

The negative half is in the *same paragraph* of DERIVE-df1 that L128 cites for the positive half, and in the *same file* one lemma earlier. The isotropy corollary is likewise on record, [DERIVE-df1](DERIVE-df1.md) carries "the isotropy algebra of a diagonal critical point is spanned by coordinate rotations $E_{jk}$", credited to [r347](REVIEW_r347.md); L128 adds only the unpacking of $o^{jk}=0$ into "rows of $M$ agree off $\{j,k\}$", which is one substitution.

**So the header's "three of its four ingredients are on the record" undercounts by one, and the "New here" list should be cut to two items.** What survives as new:

- the **iff** of (ii) at an arbitrary pure critical point, assembled from [L24](../findings/second-order.md), [L120](../findings/second-order.md), [L121](../findings/second-order.md), [L122](../findings/second-order.md), genuinely not on record, though [Lemma L126](../findings/second-order.md) already has $\ker DF=E_{L_e}(\tfrac12)$ and the four-set half of it, and it is the half this review refutes as stated;
- **(iii)**, which is the lemma's real content. That [Lemma L11](../findings/nondegeneracy.md) asserts "such an orbit is isolated in the critical set" with no argument is **confirmed**, I read the paragraph, and there is none.

*Nothing the lemma calls "on record" turned out to be absent: [L24](../findings/second-order.md)'s normalisation, [L120](../findings/second-order.md)'s block-diagonality and [L122](../findings/second-order.md)'s $L_eo^{jk}=\tfrac12o^{jk}$ are all where it says they are.*

## Part (v), the boxed non-reinstatement claim is REFUTED

The box argues: "The withdrawn clause read a branch statement off $\ker DF=T_M\mathcal O$ alone, which gives tangency and no more. (iii) is a statement about a **nondegenerate** orbit."

**Those are the same condition.** [Lemma L126](../findings/second-order.md) defines $DF(M)=\theta(2L_e-\mathrm{Id})$, so $\mathrm{Hess}=6\theta(L_e-\tfrac12\mathrm{Id})=3\,DF(M)$ and $\ker DF=\ker\mathrm{Hess}$. "$\ker DF=T_M\mathcal O$" **is** Morse–Bott nondegeneracy, it is L128(ii)'s conclusion, written out. So the box's distinction of hypothesis is not a distinction, and the contrapositive gloss ("degeneracy is necessary for a branch, not sufficient") describes both statements equally.

**What actually separates them is the presence of an argument, and (iii) supplies it.** [L127](../findings/second-order.md)'s withdrawal reads: "a branch statement needs an equivariant slice and a Lyapunov–Schmidt reduction". (iii) is an equivariant slice argument, under the same hypothesis, reaching a *stronger* conclusion, no critical point at all near $\mathcal O$, not merely no non-diagonal branch. **So (iii) does reinstate the withdrawn clause, as a theorem.** That is the best thing in the lemma and the box talks the record out of it.

The $S^3\times S^3$ remark in the box is correct but does no separating work: the hypothesis fails there for the withdrawn clause and for (iii) alike, $\dim E(\tfrac12)=18$ against an orbit of $9$.

**The box should read**, in substance: *L127's clause was withdrawn for want of an argument, not because it was false. (iii) supplies that argument, so the clause is reinstated under the same hypothesis and in a stronger form; it remains silent at $S^3\times S^3$, where the hypothesis fails and where [Lemma L11](../findings/nondegeneracy.md) records the exception.*

## Scope hypotheses the lemma uses silently

1. **$Q$ maps $\mathcal W_n$ into $\mathcal W_n$.** Without it $F(X)=3(Q(X)-P(X)X)$ is not a vector field on $S(\mathcal W_n)$ and criticality carries a Weyl projection. On record at [problem.md](../findings/problem.md) and flagged as load-bearing at [bounds.md](../findings/bounds.md); uncited here.
2. **Ricci-flatness**, to put $o^{jk}$ in the $(n-3)$-dimensional Weyl block rather than the $(n-2)$-dimensional character space, see (i), defect 3.
3. **One fixed eigenframe.** [Lemma L120](../findings/second-order.md)'s decomposition, and hence the entire block criterion, is defined relative to the frame diagonalising $W$; when $M$ has repeated entries that frame is not unique. The *conclusion* $\ker\mathrm{Hess}=T_W\mathcal O$ is frame-independent, so no contradiction arises, but (ii) is a statement about a chosen frame and should say so.
4. **$\mathcal O=SO(n)\cdot W$, while the block decomposition is by the full sign group $\Gamma\subset O(n)$.** Consistent, $\Gamma$ enters only through the decomposition of $\mathcal W_n$, and [L120](../findings/second-order.md) requires the full $\Gamma$ precisely because $\Gamma\cap SO(n)$ fuses blocks at $n=4,6,8$, but the lemma mixes the two groups without comment.
5. **Purity is the whole domain.** L128 says nothing about the non-diagonal critical points that are the programme's live target; it is a tool for [I18](../plan.md), not for the target itself.

## What a computation would decide, and it was not run

- **Whether $S^2\times S^4$ satisfies the *repaired* (ii).** It must, if [Lemma L11](../findings/nondegeneracy.md) is right and this review is right, and confirming it would be a screen of the block table against a known nondegenerate point. Blocked under the analysis-only rule; and it is not needed, since the refutation of the "only if" direction follows from the record's own printed value $\tfrac23$ and needs no run.
- **Whether the padded $S^2\times S^k$ points, degenerate per [nondegeneracy.md](../findings/nondegeneracy.md), have their excess visible as extra $\tfrac12$-vectors in the repaired criterion's blocks.** That would test the criterion's completeness against a known degeneracy rather than a known nondegeneracy, which is the direction the record has been burned on before. Named and stopped at.

## Fixes owed, in priority order

1. **(ii): replace "$L_e$-spectrum $<\tfrac12$" by "$\tfrac12$ is not an eigenvalue"** in the four-set and $\mathcal D_n$ clauses, and restate [I18](../plan.md)'s four-set half as $A^2+B^2+C^2-AB-BC-CA\ne\theta^2$.
2. **(iii): replace the affine slice by a spherical one**, and add the submersion sentence that makes the covering step a proof.
3. **(iv): cut the negative half of (i) from the "New here" list** and cite [Lemma L126](../findings/second-order.md) and [DERIVE-df1](DERIVE-df1.md) for it.
4. **(v): rewrite the box** to say that (iii) reinstates L127's clause with the argument the withdrawal named as missing.
5. **(i): fix the $\rho(E_{jk})$ sign**, change "fixes" to "annihilates", name Ricci-flatness at the $\mathbf 1^\perp$ step, and repair the garbled corollary sentence.
6. **Cite $Q(\mathcal W_n)\subseteq\mathcal W_n$** where (iii) uses it.
