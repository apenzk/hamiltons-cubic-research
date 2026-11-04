# Review r433, Lemma L135 and post F59

*Adversarial audit, cold brief, 2026-09-03. Analysis only: no search, sweep or census was run; the one numerical act is a seconds-long arithmetic screen of the lemma's own constants and of the competitor's spectrum, reported as a screen. Log: [agent_logs/r433-L135.log](../agent_logs/r433-L135.log).*

## Verdicts

| Claim | Verdict |
| --- | --- |
| L135(a), $c_2=\Delta_2-\tfrac19$ for every $H\in T_uS$ | **CONFIRMED** |
| L135(a), "two proofs, sharing nothing" | **REFUTED**: they are one proof, and the first is the second done non-rigorously |
| L135(b), arithmetic and the reduction to $\Delta_2\le\tfrac14$ | **CONFIRMED**, but **tautological**: $\tfrac5{36}$ was *defined* as $\tfrac14-\tfrac19$ |
| L135(b), the identification with "the record's own universal ceiling" | **REFUTED** as a mathematical statement; it is a coincidence of numbers except on the padded flat |
| L135(c), the cross term $2\langle g_0,g_2\rangle=-a\langle\star,Y_2\rangle$ | **REFUTED**: sign inverted by a convention collision internal to L135 |
| L135(c), the branch structure, $s(D_s)_-$, the Schur complement | **PLAUSIBLE**, with the mechanism ill-defined on the set it serves |
| L135, hyper-Kähler class $c_2\le0$ | **CONFIRMED** (reproved here by hand) |
| L135, "the orbit directions are a sub-case" of it | **REFUTED** for $4(n-4)$ of the $4n-14$ orbit directions |
| L135, padded-flat recovery of L134(c) | **CONFIRMED** |
| F59, the slack argument | **CONFIRMED** |
| F59, "$\delta$ is even because $\lvert-W\rvert=\lvert W\rvert$" | **REFUTED as stated**; conclusion survives for a different reason |
| F59, concavity impossible | **CONFIRMED** for global concavity, **over-reaching** as an answer to the shortcut |
| F59, $u$ is not a local max of $\delta^2$ on $\{F=0\}$ | **CONFIRMED**, with a better witness available in the record |
| F59, "the direct second-order expansion is therefore forced" | **REFUTED**: does not follow from what is proved |

---

## 1. The live defect: a convention collision inside L135(c) itself

This is the finding that matters, and it is the same error class that refuted [Lemma L137](../findings/route-a.md) at [r425](REVIEW_r425.md) / [r426](REVIEW_r426.md).

**L135's Setting fixes $g_0=\mathrm{Alt}(u_-)=+a\star$ with $a=\tfrac1{3\sqrt6}>0$.** That sign is available only under $W_-:=\tfrac12(\lvert W\rvert-W)\succeq0$, the convention [Lemma L136](../findings/route-a.md) states first "because the refutation turned on it".

**L135(c) then writes, verbatim, $W_-=\tfrac12(W-\lvert W\rvert)$** (the opposite convention) and reads the cross term off it:

$$2\langle g_0,g_2\rangle=2a\langle\star,X_2\rangle=-a\langle\star,Y_2\rangle .$$

Under the operative convention the path being affine gives $X_2=+\tfrac12Y_2$, hence

$$2\langle g_0,g_2\rangle=2a\cdot\tfrac12\langle\star,Y_2\rangle=\boxed{+a\langle\star,Y_2\rangle},$$

so **the displayed sign is inverted**. [Lemma L136](../findings/route-a.md) carries the cross term in the $2a\langle\star,X_2\rangle$ form and is therefore correct; L135(c)'s $Y_2$ form contradicts it by a sign. Anyone who computes $Y_2$, the $t^2$-coefficient of $\lvert u+tH\rvert$, which is the natural thing to compute, the line being affine, and substitutes into L135(c) turns L136's *nonpositive* cross term into a positive one, i.e. reverses the entire content of L136.

**The same wrong sign is propagated in [results.md](../results.md)** ("the single scalar $-a\langle\star,Y_2\rangle$"), so the defect is live in two files.

**That the convention is $\tfrac12(\lvert W\rvert-W)$ is not a matter of taste, it is forced, and I checked it independently.** With $u$'s spectrum $\tfrac1{\sqrt6}(2,-1,-1)$ on $E$: $u_-$ has eigenvalues $(0,\tfrac1{\sqrt6},\tfrac1{\sqrt6})$, trace $\tfrac2{\sqrt6}$, and $\mathrm{Alt}(S)=\tfrac16\big(\mathop{\mathrm{tr}}S|_{\Lambda^+}-\mathop{\mathrm{tr}}S|_{\Lambda^-}\big)\star$ then returns $a=\tfrac16\cdot\tfrac2{\sqrt6}=\tfrac1{3\sqrt6}$ and $\lVert a\star\rVert^2=6a^2=\tfrac19$ exactly. Running the same normalisation through the first order reproduces L135(c)'s own cross-check: the Daleckii–Krein multipliers $(0,-1,-1)$ on the $E$-diagonal give $\mathop{\mathrm{tr}}(\mathcal D_u[H]|_{\Lambda^+})=-(H_{22}+H_{33})$ and hence $2\langle g_0,\mathrm{Alt}(\mathcal D_u[H])\rangle=-2a(H_{22}+H_{33})$, and the kink branch gives $-2a\mathop{\mathrm{tr}}(\Pi_AD_-)\le0$, summing to [Lemma L17](../findings/route-a.md)'s $d^+\delta^2=-2aF(H)$ with $F\ge0$. **Every one of those signs fails under $\tfrac12(W-\lvert W\rvert)$.** So (c) is internally inconsistent, and the inconsistency lands exactly on the one scalar the lemma exists to isolate.

## 2. (a) is true, and is one proof, not two

**The claim is correct.** The cleanest route uses nothing but positive homogeneity and needs no derivative at the kink:

$$\cos t\,u+\sin t\,H=\cos t\,(u+\tan t\,H)\ \Longrightarrow\ \delta^2(t)=\cos^2t\cdot d(\tan t),\quad d(s):=\delta^2(u+sH),$$

valid for $\cos t>0$ since $W\mapsto W_-$ is positively $1$-homogeneous and $\delta^2$ is $2$-homogeneous. With $\cos^2t=1-t^2+O(t^4)$ and $\tan t=t+O(t^3)$,

$$\delta^2(t)=\big(1-t^2\big)\big(\tfrac19+d_1t+\Delta_2t^2\big)+O(t^3)=\tfrac19+d_1t+\big(\Delta_2-\tfrac19\big)t^2+O(t^3).$$

So $c_2=\Delta_2-\tfrac19$, and the first-order coefficients agree too. **The $O(t^3)$ in $\tau=\arctan t$ cannot feed the $t^2$ coefficient** (the brief's worry) because it enters $d_1\tau$ at order $t^3$ and $\Delta_2\tau^2$ at order $t^4$. Only $H\perp u$ and $\lVert H\rVert=1$ are used, both of which hold on $T_uS$. The hypotheses check.

**$c_2$ is well defined and Rellich does apply.** $t\mapsto W(t)$ is entire, so Rellich gives analytic eigenvalues $\lambda_i(t)$ and an analytic orthonormal eigenbasis. Each $\lambda_i$ is either identically zero or has isolated zeros, so on $(0,\varepsilon)$ each has constant sign and $f(\lambda_i(t))=\max(-\lambda_i(t),0)$ equals $0$ or $-\lambda_i(t)$ there, in every case the restriction of a function analytic on a full neighbourhood of $0$. Hence $W(t)_-$ agrees on $[0,\varepsilon)$ with a real-analytic matrix function and $\delta^2$ has **one-sided derivatives of all orders** at $0^+$. Same for $u+tH$. So neither side of (a) is vacuous, and the identity is an equivalence: $c_2$ exists iff $\Delta_2$ does.

**But the independence claim is false.** "This route shares nothing with the block expansion, no spectral perturbation theory, no branch analysis" is not sustainable. The first proof's engine is the sentence *"$W\mapsto W_-$ is positively homogeneous of degree one, so its derivative at $u$ in the direction $u$ is $u_-$"*, that **is** Euler's relation, the same homogeneity the second proof uses, and it is the only thing carrying the $-\tfrac19$. The block expansion in the first proof is used solely to argue the sliver contributes at $O(t^3)$, a step the homogeneity route never needs. Two proofs sharing their only load-bearing hypothesis are one proof.

**And the first proof, as written, is not rigorous.** It applies a linearisation $\mathcal D_u$ *at $u$* to the second-order perturbation $-\tfrac{t^2}2u$ while the base point has already moved to $u+tH$. At a point where the map is not differentiable, "$\Psi(u+tH+t^2V)=\Psi(u+tH)+t^2\mathcal D_u[V]+o(t^2)$" is not a licensed step; the correct linearisation point is $u+tH$, and $W\mapsto W_-$ has no derivative there either in the directions that matter. The conclusion is right, reached by the second proof; the first proof should be deleted or replaced by the two-line $\cos t\,(u+\tan t\,H)$ identity above. *The sliver estimate itself does survive: $\lVert\sin t(D-\tan t\,M)_--t(D-tM)_-\rVert\le\lvert\sin t-t\rvert\lVert(D-tM)_-\rVert+\sin t\cdot\lvert\tan t-t\rvert\lVert M\rVert=O(t^3)$ by nonexpansiveness.*

## 3. (b), arithmetic clean, insight tautological

**Every number checks.** $\theta^*=1.2247449$; $\lvert\kappa_{12}\rvert=0.1015939$ and $\theta^*/(2\lvert\kappa_{12}\rvert)=6.0277$; $\lvert\kappa_n\rvert\uparrow9(\sqrt2-\sqrt{3/2})=1.7052182$ and $\theta^*/(2\lvert\kappa_\infty\rvert)=0.3591168$; $\tfrac19+0.3591168=0.4702279$, cleared by $\tfrac14$ with ratio $1.8809$; and $\tfrac19+\tfrac5{36}=\tfrac9{36}=\tfrac14$ exactly. $\lvert\kappa_n\rvert$ is increasing in $n$, so the threshold decreases and the $n\to\infty$ case genuinely binds.

**The insight is circular.** $\tfrac5{36}$ is not an independently arrived-at target: [Lemma L134](../findings/route-a.md)(c) produced it as $\tfrac14-\tfrac19$, and (d) adopted it because "it is the ceiling the padded flat's own identity is bounded by". Given (a)'s $c_2=\Delta_2-\tfrac19$, "$c_2\le\tfrac5{36}$ is *exactly* $\Delta_2\le\tfrac14$" is the definition of $\tfrac5{36}$ read backwards. Nothing is learned.

**And the identification is refuted by F59, in the same file.** The lemma's title ("the target is the record's own universal ceiling"), asserts that the $\tfrac14$ asked of $\Delta_2$ *is* the $\tfrac14$ of $\delta^2\le\tfrac14$. Post F59 proves the opposite: $\delta^2\le\tfrac14$ has no consequence whatever for $\Delta_2$, because $\tfrac14>\tfrac19$. The lemma's own hedge, "on the padded flat $\Delta_2$ **is** a defect value, so the ceiling applies to it as a statement about the same quantity", is correct **on the padded flat only**, which is the one class already closed. Off it, $\Delta_2$ is not a defect value of anything and the coincidence is numerical. *The record's $\delta^2\le\tfrac14$ is Cauchy–Schwarz on $\delta^2=\tfrac12\langle\mathrm{Alt}(W_-),\lvert W\rvert\rangle$, equivalently $\lVert\mathrm{Alt}(W_-)\rVert=\lVert\mathrm{Alt}(W_-+\tfrac12W)\rVert\le\tfrac12\lVert W\rVert$; I verified the identity returns $\tfrac19$ at $u$. That this is the **same recentring trick** [Lemma L140](../findings/route-a.md) later uses for $\lVert g_1\rVert^2\le\tfrac14$ is the real relation between the two $\tfrac14$'s, and it is not the relation L135(b) asserts.*

## 4. (c), structure plausible, mechanism ill-defined where it is needed

Beyond the sign defect of §1:

- **"The whole second order sits in $\lvert W\rvert$" is right.** For the affine path $u+tH$, $W_-=\tfrac12(\lvert W\rvert-W)$ has its $-\tfrac12W$ half affine in $t$, contributing nothing at $t^2$. ✔
- **$\langle g_0,X\rangle=a\langle\star,X\rangle$ is right**, given that $\mathrm{Alt}$ is an orthogonal projection of $S^2(\Lambda^2)$ onto its $\Lambda^4$ summand and $\star$ lies in the image: $\langle a\star,\mathrm{Alt}(X)\rangle=a\langle\mathrm{Alt}(\star),X\rangle=a\langle\star,X\rangle$. Both premises are the record's own conventions and both are consistent with $\lVert\star\rVert^2=6$ and $\delta^2(u)=\tfrac19$. ✔
- **The Schur-complement structure is right**, $tD-t^2C^\top\Lambda^{-1}C+O(t^3)=t\big(D-tC^\top\Lambda^{-1}C\big)+O(t^3)$, with the $E$-block's spectrum bounded away from $0$ so its negative part is analytic. ✔
- **But the stated mechanism does not exist on $\{F=0\}$.** (c) says the sliver's second order is "the Schur complement $C^\top\Lambda^{-1}C$ fed through the derivative of $N\mapsto N_-$ at $D$". [Lemma L136](../findings/route-a.md) records that this derivative **exists nowhere on the cone**, the equality case forcing $A\subseteq\ker D$. So (c) describes the second-order term of $\Delta_2$ by an object that is undefined on the entire set $\Delta_2$ is being computed on. The coefficient itself survives, $t\mapsto(D-tM)_-$ is one-sidedly analytic by the Rellich argument of §2, so the one-sided directional derivative exists, but it is **not** a Fréchet derivative of $N\mapsto N_-$ and is not linear in $M$. The sentence needs rewriting; as it stands it invites a successor to differentiate something that is not differentiable.
- **Minor.** "$\mathcal D_u$ the Daleckii–Krein derivative … on the $E$-branch" understates its own scope: [Lemma L140](../findings/route-a.md)'s multiplier table assigns multipliers to the $(\hat\omega_1,K)$ and $(\hat\omega_{2,3},K)$ blocks as well. $g_1=\mathrm{Alt}(\mathcal D_u[H]+D_-)$ is correct only if $\mathcal D_u$ covers every block except $K\times K$.

## 5. The hyper-Kähler claim, CONFIRMED, reproved by hand

I did not take this on the record's word. Within the one-$\mathbb R^4$ ansatz $W$ is supported on $\Lambda^2\mathbb R^4$ with $W|_{\Lambda^-}=0$, which is a **linear** subspace of $\mathrm{Weyl}_n$ (the padding is Ricci-flat and Bianchi because the $\mathbb R^4$ tensor is). With $\mathrm{Alt}(S)=\tfrac16(\mathop{\mathrm{tr}}S|_{\Lambda^+}-\mathop{\mathrm{tr}}S|_{\Lambda^-})\star$ and $\lVert\star\rVert^2=6$,

$$\delta^2(W)=\tfrac16\Big(\mathop{\mathrm{tr}}W_-|_{\Lambda^+}\Big)^2=\tfrac1{24}\Big(\textstyle\sum_i\lvert\lambda_i\rvert\Big)^2,\qquad \textstyle\sum\lambda_i=0,\ \sum\lambda_i^2=1 .$$

Maximising $\sum\lvert\lambda_i\rvert$ on that circle: with $\lambda_1\ge\lambda_2\ge\lambda_3$, either $\lambda_2\ge0$ and the sum is $-2\lambda_3\le4/\sqrt6$, or $\lambda_2<0$ and it is $2\lambda_1\le4/\sqrt6$. **Maximum $4/\sqrt6=1.6330$, attained exactly at $u$'s $2{:}1{:}1$ spectrum** (against $2/\sqrt2=1.4142$ at $(1,-1,0)$), giving $\max\delta^2=\tfrac1{24}\cdot\tfrac{16}6=\tfrac19$. ✔ The ansatz is a linear space, so $\cos t\,u+\sin t\,H$ stays inside it for $H$ tangent, $u$ is a global max there, $c_1=0$ on $\{F=0\}$, and $c_2\le0$ follows from the Peano expansion. **The claim is sound and the record's numerical provenance is unnecessary.**

**One defect in the surrounding sentence.** "*The orbit directions are a sub-case, where $\Phi$ is constant outright.*" Only the $\mathfrak{so}(4)/\mathfrak{stab}$ part of $T_u\mathcal O$ ($2$ of $4n-14$ dimensions), is tangent to the ansatz; the $4(n-4)$ vector-isotype directions rotate the distinguished $\mathbb R^4$ and leave it at once. And $\Phi$ is constant along the **orbit**, not along the great circle $\cos t\,u+\sin t\,H$ for $H\in T_u\mathcal O$, which is a different curve from second order on. Harmless downstream, since [Lemma L134](../findings/route-a.md)(d) quantifies only over $H\perp T_u\mathcal O$, but it is a false statement sitting next to a true one.

**Scope, stated plainly:** the class this closes is at most $4$-dimensional inside a $\dim\mathcal W_n-1$ sphere ($1637$ at $n=12$). Calling it, in F59, "the one instrument that *does* work" oversells a measure-zero sliver.

## 6. Post F59

**The slack argument: CONFIRMED, and trivially so.** $\delta^2\le C$ with $C>\tfrac19$ gives $c_2t^2\le C-\tfrac19+O(t^3)$, satisfied by every real $c_2$ for small $t$. The three instruments it names by name are correctly killed.

**"$\delta$ is even because $\lvert-W\rvert=\lvert W\rvert$": REFUTED as stated.** $\lvert-W\rvert=\lvert W\rvert$ is true and irrelevant, because $(-W)_-=\tfrac12(\lvert W\rvert+W)=W_+\ne W_-$. So $\delta(-W)=\lVert\mathrm{Alt}(W_+)\rVert$, and evenness needs $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$, i.e. $\mathrm{Alt}(W)=0$, **the first Bianchi identity**, which is the record's own by-product ([ATTEMPTS.md](../ATTEMPTS.md), Result 7). *Off $\mathrm{Weyl}_n$ the claim is false: for $W=\mathrm{diag}(2,-1)$ and $\mathrm{Alt}$ replaced by the projection onto $\mathrm{span}(I/\sqrt2)$, $\lVert\mathrm{Alt}(W_-)\rVert=1/\sqrt2$ against $\lVert\mathrm{Alt}(W_+)\rVert=\sqrt2$.* The conclusion ($\delta$ is even on $\mathrm{Weyl}_n$, hence not concave), **survives**, on a hypothesis F59 never states.

**Concavity: over-reaching.** The two-line proof kills *global* concavity of $\delta$ on $\mathrm{Weyl}_n$. The shortcut it needs to kill is far weaker: **local** concavity of the single scalar $t\mapsto\delta^2(u+tH)$ near $0$, which with $c_1=0$ would give $\Delta_2\le0$ at once. The global argument says nothing about it. What actually kills it is the padded flat, where $\delta^2(u+tH)=\tfrac19+\delta^2(H)t^2$ is strictly **convex**, F59's own second bullet. So bullet 1 is redundant rather than load-bearing. *(A cleaner form of the intended argument: $h(t)=\delta^2(u+tH)$ is nonnegative on $\mathbb R$ with $h(t)/t^2\to\delta^2(H)$, and no nonnegative concave function on $\mathbb R$ grows quadratically unless $\delta^2(H)=0$.)*

**"$u$ is not a local max of $\delta^2$ on $\{F=0\}$": CONFIRMED, with a better witness in the record.** The padded flat lies in the cone ([Lemma L17](../findings/route-a.md)'s equality cases include every Weyl tensor of the complementary $\mathbb R^{n-4}$) and is orthogonal to $T_u\mathcal O$, and along it $\delta^2(t)=\cos^2t\cdot\tfrac19+\sin^2t\cdot\delta^2(H)$ exceeds $\tfrac19$ whenever $\delta^2(H)>\tfrac19$. **But F59 cites $\max\delta^2=0.125$ on $\mathbb R^8$, which is a numerical census maximum.** The record already contains an exact witness for the same job: $W=\tfrac3{2\sqrt{15}}\Pi_4-\tfrac1{\sqrt{15}}\Pi_6$ on a $10$-dimensional subalgebra of $\Lambda^2\mathbb R^8$, with $\delta^2=\tfrac3{25}=0.12>\tfrac19$ ([ATTEMPTS.md](../ATTEMPTS.md), Result 7). Its unit norm and vanishing trace are exact, I checked, $4\big(\tfrac3{2\sqrt{15}}\big)^2+6\big(\tfrac1{\sqrt{15}}\big)^2=1$ and $\tfrac{4\cdot3}{2\sqrt{15}}=\tfrac6{\sqrt{15}}$. **Citing $\tfrac3{25}$ instead of $0.125$ removes the last numerical dependency from an impossibility claim.** *Worth noting separately: a witness on $\mathbb R^4$ cannot serve, the hyper-Kähler computation of §5 shows the $\mathbb R^4$ maximum is exactly $\tfrac19$, so the witness must live in $\mathbb R^5$ or larger, and the record's $n=8$ object is the natural one.*

**"The direct second-order expansion is therefore forced": REFUTED.** The argument is *(i)* no non-sharp ceiling works, *(ii)* concavity is impossible, *(iii)* sharpness at $u$ fails on the cone. But (iii) is established by a witness in the **padded-flat** class, and the padded flat is one of the two classes already closed. **The only open class is the mixed one, and F59 exhibits nothing there.** A bound of the form "$\delta^2\le\tfrac19$ on $\{F=0\}\cap T_u\mathcal O^\perp\cap(\text{mixed})$ near $u$" (precisely the instrument that would close what remains), is untouched by all three legs, and by F59's own logic it would deliver $c_2\le0$ there. So the fence is not the fence F59 claims.

*Two smaller over-reaches of the same kind.* The headline "no bound on $\delta^2$ **alone**" is broader than the proof, which concerns **constant** ceilings $C>\tfrac19$ on a neighbourhood; a non-constant bound sharp at $u$ (the hyper-Kähler bound is one, as F59 itself notes), is a bound on $\delta^2$ alone and does constrain $c_2$. And the sentence "the slack argument kills every non-sharp bound" is the honest version; the headline is not.

## 7. One inconsistency in the record, noted in passing

[ATTEMPTS.md](../ATTEMPTS.md) Result 3 asserts that "$\delta^2$ *decreases* first-order in **every** tangent direction, $\delta^2(t)\approx\tfrac19-c\lvert t\rvert$, the point is a local maximizer of the defect functional". Post F59 asserts the negation. **F59 is right**: Result 3's "every" is an artifact of a random fan, which misses the measure-zero cone $\{F=0\}$ where the first order vanishes and the padded flat then climbs. Result 3's wording should be narrowed to "every direction off $\{F=0\}$".

## What the author should change

1. **Fix L135(c)'s convention and the sign of the cross term**: $W_-=\tfrac12(\lvert W\rvert-W)$ throughout, and $2\langle g_0,g_2\rangle=+a\langle\star,Y_2\rangle$. Fix the same sign in [results.md](../results.md). *Until this is done, L135(c) and [Lemma L136](../findings/route-a.md) disagree by a sign on the one scalar both are about.*
2. **Delete the first proof of (a)** and replace it with $\cos t\,u+\sin t\,H=\cos t\,(u+\tan t\,H)$; drop the independence claim.
3. **Retire the "record's own universal ceiling" framing** of (b), or restrict it explicitly to the padded flat.
4. **Rewrite (c)'s last clause** so that it names a one-sided directional derivative, and record there (rather than only in L136) that no Fréchet derivative of $N\mapsto N_-$ at $D$ exists on the cone.
5. **Correct "the orbit directions are a sub-case"** to the $\mathfrak{so}(4)$ part.
6. **In F59**: state the Bianchi hypothesis behind evenness; swap $0.125$ for the exact $\tfrac3{25}$; and narrow "no bound on $\delta^2$ alone" and "the direct expansion is forced" to what the three legs actually prove, the mixed class carries no witness.
