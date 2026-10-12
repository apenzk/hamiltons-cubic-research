# Review r752, L170, the half-eigenspace at a local maximum, and the two claims around it

**Cold Gate 2.** I worked from [BRIEF-g2-l170.md](BRIEF-g2-l170.md) alone and derived every step from the definitions before opening any part of the record; I did not read [second-order.md](../findings/second-order.md) until the derivations of §§1–3 and §6 were fixed, and then only through greps, disclosed in §5. **No numerical work was done**: there is no run, no sweep and no search behind anything below, every value is exact rational or symbolic, and the two spectral values I quote are recomputed by hand from the record's own closed form as a cross-check on my reading of it. Log at [agent_logs/g2-l170-r752.log](../agent_logs/g2-l170-r752.log).

| # | claim | verdict |
|---|---|---|
| 1 | $\mathrm{Hess}(P\vert_S)_W=6\theta(L_e-\tfrac12\mathrm{Id})$ on $W^\perp$, as quoted | **CONFIRMED**, re-derived cold, with $\lambda=3\theta$ from Euler |
| 2 | $L_eW=W$, hence $E(\tfrac12)\subseteq W^\perp$ | **CONFIRMED, one step missing**, the implication needs $L_e$ self-adjoint, which is true and unstated |
| 3 | $\ker\mathrm{Hess}(P\vert_S)_W=E(\tfrac12)\cap W^\perp$ | **CONFIRMED, and the hypothesis is wrong**, this holds at every critical point with $\theta\ne0$; **maximality is unused** |
| 4 | $E(\tfrac12)=\ker\mathrm{Hess}(P\vert_S)_W$ (the displayed equality) | **PROVEN, understated**, true under $\theta\ne0$ alone, so the "local maximum" hypothesis is redundant |
| 5 | $E(\tfrac12)=T_W\mathcal O\iff W$ Morse–Bott nondegenerate | **CONFIRMED**, but *"by definition"* is a stipulation; agreement with the standard notion is a short theorem, supplied in §4 |
| 6 | (a) $S^3\times S^3$ is degenerate and not a local maximum | **CONFIRMED**, degeneracy from claim 4; non-maximality has a recorded cubic-order reason that I re-derive independently in §6 |
| 7 | (a) $S^2\times S^3\times S^3$ is degenerate and not a local maximum | **HYPOTHESIS-DEBT**, degeneracy follows; **no argument for non-maximality is on file**, and the two-block reason does not transfer |
| 8 | (a) a degenerate local maximum *"would contradict nothing on the record"* | **CORRECTED**, it would have to satisfy $P\vert_{E(1/2)}\equiv0$ with $\dim E(\tfrac12)>\dim T_W\mathcal O$, a testable constraint, so the right word is *"no contradiction has been derived"* |
| 9 | (a) *"no proof of it is available"* | **OVERREACH, repairable**, unprovable as stated; §6 proves the defensible form, that analyticity, Łojasiewicz, compactness and equivariance are each closed, with a counterexample |
| 10 | (b) four-set blocks lie in $W^\perp$ | **CONFIRMED, and not merely generically**, supports are disjoint, §7 |
| 11 | (b) at a maximum the exclusion of $\tfrac12$ is $\mu<\tfrac12$ | **CONFIRMED**, and the same sharpening reaches the pair blocks and $\mathcal D_n\cap W^\perp$, which the claim does not say |
| 12 | (b) the $\Sigma<\theta^2\to\Sigma\ne\theta^2$ repair is *"unnecessary at maxima"* | **UNVERIFIED HERE**, needs the orientation of $\Sigma\leftrightarrow\mu$, which the brief does not carry; §7 states what must hold |
| 13 | [L170.lean](../lean/HamiltonsCubic/Results/L170.lean)'s docstring account of where maximality enters | **REFUTED**, a non-sequitur; the kernel is the whole eigenspace whether or not $\tfrac12$ is the top eigenvalue |

**Actionable summary.** Keep the lemma and delete its hypothesis: the displayed equality holds at **every** critical point with $\theta\ne0$, so restate it that way, strike the sentence in [L170.lean](../lean/HamiltonsCubic/Results/L170.lean) that makes maximality load-bearing, add the one-line self-adjointness step, and either supply or withdraw *"$S^2\times S^3\times S^3$ is not a local maximum"*.

## 0. Conventions, fixed once

- $\mathcal W_n\subseteq\mathrm{Sym}^2(\Lambda^2\mathbb R^n)$ is the space of symmetric operators satisfying first Bianchi and Ricci-flatness, a real vector space with the trace inner product $\langle A,B\rangle=\mathrm{tr}(AB)$. $S=\{W\in\mathcal W_n:\lVert W\rVert=1\}$ is its unit sphere, so $T_WS=W^\perp$ with the complement taken **inside $\mathcal W_n$**. Every orthogonality below is inside $\mathcal W_n$.
- $Q(X):=\Pi_{\mathcal W_n}(X^2+X^{\#})$ is the criticality map, $\Pi$ the orthogonal projection. $P(X)=\langle X,X^2+X^{\#}\rangle=\langle X,Q(X)\rangle$ for $X\in\mathcal W_n$, a homogeneous cubic; $T$ is its polarisation, $P(X)=T(X,X,X)$ with $T$ totally symmetric.
- $\theta=P(W)$ at $\lVert W\rVert=1$; $\mathcal O=SO(n)\cdot W$ under conjugation on $\Lambda^2$; $L_e=\frac1{2\theta}DQ_W$, the normalisation the brief describes, justified in §2.
- $E(\mu)$ is the $\mu$-eigenspace of $L_e$ acting on all of $\mathcal W_n$.
- $\mathcal D_n$ is the frame-diagonal subspace: operators diagonal in the basis $\{e_i\wedge e_j\}$. **Pure** means $W\in\mathcal D_n$.

## Hypothesis inventory

| hypothesis | where it is used | verdict |
|---|---|---|
| $W$ critical for $P\vert_S$ | $\nabla P(W)=3\theta W$, hence the Hessian identity and $Q(W)=\theta W$ | **used, essential** |
| $\lVert W\rVert=1$ | fixes $\lambda=3\theta$ in the second fundamental form term; a normalisation only | **used, removable by rescaling** |
| $\theta\ne0$ | $L_e$ exists at all; and $6\theta\ne0$ so the form and the operator have the same kernel | **used, essential** |
| $\theta>0$ (the sign) | **nowhere in the displayed equality**; used in claim (b), to orient $\mathrm{Hess}\preceq0$ into $L_e\preceq\tfrac12$ rather than $L_e\succeq\tfrac12$ | **unused for the statement, used for (b)** |
| $W$ a local maximum | **nowhere**, see §3 | **UNUSED** |
| $W$ pure | claim (b) and the closing clause only | **used there, correctly flagged there** |
| $L_e$ self-adjoint | turns $L_eW=W$ into $E(\tfrac12)\perp W$ | **used and unstated**, §2 supplies it |
| $L_e$ preserves $W^\perp$ | the kernel computation of §3 | **used and unstated**, a corollary of the previous line |

## 1. The Hessian identity, and how much of $6\theta$ is used

$P$ is homogeneous of degree $3$, so $T(X,X,B)=\langle Q(X),B\rangle$ (this *is* $\nabla P=3Q$ restated) and differentiating in $A$ gives

$$2\,T(X,A,B)=\langle DQ_X(A),B\rangle .$$

The ambient Hessian of a cubic is $\mathrm{Hess}^{\mathrm{amb}}P_X(A,B)=6\,T(X,A,B)=3\langle DQ_X A,B\rangle$. Criticality of $P\vert_S$ at $W$ is $\nabla P(W)=\lambda W$, and pairing with $W$ gives $\lambda=\langle\nabla P(W),W\rangle=3P(W)=3\theta$ by Euler at $\lVert W\rVert=1$. The unit sphere has second fundamental form $\mathrm{II}(A,B)=-\langle A,B\rangle W$ against the outward normal, so for $A,B\in W^\perp$

$$\mathrm{Hess}(P\vert_S)_W(A,B)=\mathrm{Hess}^{\mathrm{amb}}P_W(A,B)-\lambda\langle A,B\rangle=3\langle DQ_WA,B\rangle-3\theta\langle A,B\rangle=6\theta\Big\langle\big(\tfrac1{2\theta}DQ_W-\tfrac12\mathrm{Id}\big)A,B\Big\rangle .$$

(The calibration check: $f(X)=\tfrac12\lVert X\rVert^2$ is constant on $S$, and the formula returns $\langle A,B\rangle-1\cdot\langle A,B\rangle=0$.) With $L_e=\frac1{2\theta}DQ_W$ this is exactly the recorded identity, so **the identity is confirmed, and the constant $6\theta$ is not an input but an output** of $\lambda=3\theta$ and the factor $6$ in a cubic's Hessian.

**What the argument uses of $6\theta$.** Only that it is **nonzero**. The kernel of the bilinear form $c\cdot\langle MA,B\rangle$ on a subspace is independent of the scalar $c\ne0$, so $\theta\ne0$ is enough for the displayed equality; the *sign* of $\theta$ is used nowhere in it. The sign is used in claim (b), where $\mathrm{Hess}\preceq0$ has to be turned into $L_e\preceq\tfrac12$ rather than $L_e\succeq\tfrac12$: with $\theta<0$ a local maximum would force the blocks **above** $\tfrac12$ and (b)'s strict inequality would reverse to $\mu>\tfrac12$. And $\theta\ne0$ is not a convenience: at $\theta=0$ one has $DQ_W(W)=2Q(W)=0$, so **no** normalisation makes $W$ a $1$-eigenvector and $L_e$ does not exist.

## 2. $L_eW=W$, and the step the proof skips

$Q$ is quadratic homogeneous, so Euler gives $DQ_W(W)=2Q(W)$; criticality gives $Q(W)=\theta W$ (pair $\nabla P=3Q$ with $\nabla P(W)=3\theta W$). Hence

$$L_eW=\tfrac1{2\theta}DQ_W(W)=\tfrac1{2\theta}\cdot2\theta W=W .$$

The same normalisation delivers the orbit at $\tfrac12$, which confirms that $\frac1{2\theta}DQ_W$ is the record's $L_e$ and not some other scaling: $Q$ is $SO(n)$-equivariant, $Q(gWg^{-1})=gQ(W)g^{-1}$, and differentiating along $g=e^{sX}$ gives $DQ_W([X,W])=[X,Q(W)]=\theta[X,W]$, so $L_eo=\tfrac12o$ for every $o\in T_W\mathcal O$. **Both normalisation conditions in the brief are met by one and the same operator**, which is the check that my $L_e$ is the record's.

**Now the step the proof compresses.** *"$L_eW=W$, so $E(\tfrac12)\perp W$"* is not an implication on its own. For $v\in E(\tfrac12)$ one wants $\tfrac12\langle v,W\rangle=\langle L_ev,W\rangle=\langle v,L_eW\rangle=\langle v,W\rangle$, forcing $\langle v,W\rangle=0$, and the middle equality is **self-adjointness of $L_e$**, which the written proof never states. It is true: $\langle L_eA,B\rangle=\frac1{2\theta}\langle DQ_WA,B\rangle=\frac1\theta T(W,A,B)$ by §1, and $T$ is totally symmetric, so $\langle L_eA,B\rangle=\langle A,L_eB\rangle$ on all of $\mathcal W_n$.

I checked whether the recorded facts alone suffice without it, and they do not. Suppose only that $L_eW=W$ and that the compression $\Pi_{W^\perp}L_e\vert_{W^\perp}$ is symmetric, which is all the quoted identity *"on $W^\perp$"* gives. Write $v=cW+v^\perp\in E(\tfrac12)$ and $L_ev^\perp=aW+u$ with $u\in W^\perp$. Then $L_ev=(c+a)W+u=\tfrac12cW+\tfrac12v^\perp$ forces $a=-\tfrac c2$ and $u=\tfrac12v^\perp$, and **nothing in the hypotheses kills $c$**; only $a=\langle L_ev^\perp,W\rangle=\langle v^\perp,L_eW\rangle=0$ does, and that is the full self-adjointness. So the omission is real, one line long, and repaired above. Since $L_e$ is self-adjoint with $L_eW=W$, it also **preserves $W^\perp$**: $\langle L_eA,W\rangle=\langle A,W\rangle=0$ for $A\in W^\perp$. That is used in §3 and is likewise unstated.

## 3. Second-order optimality, and the finding that maximality is unused

**The tangent space is right.** $S$ is the unit sphere of the linear space $\mathcal W_n$, so $T_WS=W^\perp\cap\mathcal W_n$, and the second-order necessary condition at a local maximum of $P\vert_S$ is $\mathrm{Hess}(P\vert_S)_W\preceq0$ on exactly that space. With $\theta>0$ and §1 this is $L_e\preceq\tfrac12$ on $W^\perp$, and since $T_W\mathcal O\subseteq E(\tfrac12)$ is nonzero (§10) the bound is attained: **at a local maximum with $\theta>0$, $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$ exactly.** So maximality does deliver that $\tfrac12$ is the top eigenvalue on $W^\perp$, which is the brief's question.

**But the argument does not need it.** Here is the passage in full, and it uses only $\theta\ne0$.

$L_e$ preserves $W^\perp$ (§2), and $L_e-\tfrac12\mathrm{Id}$ restricted to $W^\perp$ is self-adjoint. The kernel of the form is

$$\ker\mathrm{Hess}=\{A\in W^\perp:\ \langle(L_e-\tfrac12)A,B\rangle=0\ \ \forall B\in W^\perp\}.$$

For such an $A$ the vector $(L_e-\tfrac12)A$ lies in $W^\perp$ **and** is orthogonal to $W^\perp$, hence lies in $W^\perp\cap\mathbb RW=0$. So $\ker\mathrm{Hess}=\ker(L_e-\tfrac12)\vert_{W^\perp}=E(\tfrac12)\cap W^\perp$, and by §2 that is $E(\tfrac12)$ entire. **The displayed equality $E(\tfrac12)=\ker\mathrm{Hess}(P\vert_S)_W$ therefore holds at every critical point of $P\vert_S$ with $\theta\ne0$, whether or not it is a local maximum, and whether or not $\tfrac12$ is the top eigenvalue.**

Located exactly: the failure is in the word *"and"* in the proof's sentence *"a local maximum has $L_e\preceq\tfrac12$ there **and** $\ker\mathrm{Hess}=E(\tfrac12)\cap W^\perp$"*, which reads as though the second clause were consequent on the first. Exhibited concretely: take any self-adjoint $M$ on a Euclidean space with eigenvalues $\{2,0,-1\}$ (indefinite, so no maximality) and $\ker M$ is still exactly its $0$-eigenspace; the statement *"the kernel of a self-adjoint operator is its $0$-eigenspace"* has no sign hypothesis, and the passage uses nothing else. The opposite reading, argued at its strongest: one might intend maximality to rule out $E(\tfrac12)$ having a component along $W$, i.e. to make the intersection the whole eigenspace. But the proof's **own next sentence** does that job by $L_eW=W$, and does it without maximality; so on the strongest reading the hypothesis is still redundant, being a second and unnecessary route to a conclusion already obtained.

**Three independent corroborations that this is the truth and not my slip.** (i) The record's own block criterion, quoted in the brief, is stated *for pure critical points with no maximality* and reads *"$W$ is Morse–Bott nondegenerate ($\ker\mathrm{Hess}=T_W\mathcal O$), iff $\tfrac12$ is not an $L_e$-eigenvalue of any four-set block or of $\mathcal D_n\cap W^\perp$, and in every pair block $\tfrac12$ is absent or simple with eigenvector $o^{jk}$"*: that criterion is precisely *"$E(\tfrac12)=T_W\mathcal O$"* read blockwise, so the record already asserts the equivalence at critical points. (ii) [INDEX.md](INDEX.md) records reviewer r552 as *"showing $E(\tfrac12)=$ orbit tangent **is** Morse–Bott nondegeneracy"*, again without a maximality rider. (iii) Claim (a) itself infers *degeneracy* of $S^3\times S^3$ from $18>9$, which requires $\ker\mathrm{Hess}=E(\tfrac12)$ at a point the same claim says is **not** a local maximum, so the record uses the maximality-free version in the very paragraph that states the maximality-bound one.

That last point is worth isolating: **under the lemma as written, claim (a)'s degeneracy conclusion does not follow**, because the lemma only licenses $\ker\mathrm{Hess}=E(\tfrac12)$ at maxima and both witnesses are declared non-maxima. Under the corrected statement it follows immediately. So dropping the hypothesis does not merely generalise the lemma, it repairs an inference the record is already making.

## 4. The definitional step

*"Morse–Bott nondegeneracy is $\ker\mathrm{Hess}=T_W\mathcal O$ by definition"* is **the definition in use on this record** (the block criterion quoted in the brief writes the two as apposites) so the equivalence is internally sound, and I record no defect. But the phrase overstates: the standard notion carries more, namely that the critical set is locally a manifold and $\mathcal O$ is a whole connected component of it, and *"by definition"* invites the reader to think that content is free.

It is not free, and it is also not missing; it is a short theorem, which I give so that the record can cite it rather than the word *"definition"*. Suppose $\ker\mathrm{Hess}(P\vert_S)_W=T_W\mathcal O$. Let $F=\nabla(P\vert_S)$, a smooth section of $TS$ vanishing on $\mathcal O$, with $DF_W=\mathrm{Hess}(P\vert_S)_W$ at a zero. Take a slice $N\subseteq S$ through $W$ transverse to $\mathcal O$, so $T_WN$ is a complement to $T_W\mathcal O=\ker DF_W$; then $D(F\vert_N)_W$ is injective, $F\vert_N$ is an immersion at $W$, and hence injective near $W$, so $W$ is the only zero of $F$ on a neighbourhood in $N$. Sliding along $\mathcal O$ by equivariance, $\mathrm{Crit}(P\vert_S)$ coincides with $\mathcal O$ on a tube around it. **So the stipulative definition and the standard one agree at any point where the stipulative one holds**, and the equivalence is exactly as strong as claimed. (The converse direction of the *standard* definition needs $\ker\supseteq T_W\mathcal O$, which is the record's own $\tfrac12$-inclusion.)

One caution for the record rather than a defect: the tangent-cone argument alone is **not** enough here. Differentiating $F(\gamma(t))=0$ along a curve in the critical set gives only $\mathrm{tangent\ cone}\subseteq\ker\mathrm{Hess}$, which does not by itself separate $\mathcal O$ from a set tangent to it; the constant-rank/immersion step above is what does.

## 5. Claim (a), the two witnesses

**Disclosure on method.** My verdicts in §§1–4 and §6 were fixed before I opened the record. To answer *"how was it decided"* I then grepped the record for the two witnesses. That grep returned one line of [second-order.md](../findings/second-order.md) (its line 794, the source paragraph) together with lines of [nondegeneracy.md](../findings/nondegeneracy.md), [curvature-invariants.md](../findings/curvature-invariants.md) and [results.md](../results.md); I read no more of the source file than that line, and nothing below rests on it.

**Degeneracy.** Both witnesses are degenerate, and this needs nothing beyond §3: $\ker\mathrm{Hess}=E(\tfrac12)$ at any critical point with $\theta\ne0$, so $\dim\ker\mathrm{Hess}=18>9=\dim T_W\mathcal O$ at $S^3\times S^3$ and $60>21$ at $S^2\times S^3\times S^3$, taking the two dimension pairs as recorded. **CONFIRMED**, with the caveat of §3 that the lemma as *written* does not license this inference at a non-maximum.

**$S^3\times S^3$ is not a local maximum: CONFIRMED, with the mechanism re-derived.** I derived the criterion before finding it in the record. For unit $v\in W^\perp$ put $\gamma(t)=(W+tv)/\lVert W+tv\rVert$, a curve in $S$. Then $\lVert W+tv\rVert^2=1+t^2$ and $T(W,W,v)=\langle Q(W),v\rangle=\theta\langle W,v\rangle=0$, so

$$P(\gamma(t))=(1+t^2)^{-3/2}\big[\theta+3t^2T(W,v,v)+t^3P(v)\big]=\theta+\tfrac12\,\mathrm{Hess}(P\vert_S)_W(v,v)\,t^2+P(v)\,t^3+O(t^4).$$

If $v\in\ker\mathrm{Hess}$ the quadratic term vanishes and the leading term is $P(v)t^3$, which changes sign with $t$. Hence:

> **At a local maximum, $P$ vanishes identically on $\ker\mathrm{Hess}(P\vert_S)_W$**, and therefore, by the lemma under review, identically on $E(\tfrac12)$, hence on $T_W\mathcal O$.

[nondegeneracy.md](../findings/nondegeneracy.md) line 346 records exactly this mechanism at $S^3\times S^3$, *"a degenerate saddle, not a local maximum: zero positive Hessian directions, but $\theta$ takes both signs at cubic order on the $9$ null directions transverse to the orbit"*, as does [results.md](../results.md) line 114 under Lemma L3. So the first witness is settled, by a recorded argument I independently reconstruct.

**$S^2\times S^3\times S^3$ is not a local maximum: HYPOTHESIS-DEBT.** I located no argument for it anywhere. The three places the pair $60/21$ appears, [second-order.md](../findings/second-order.md) line 225, [curvature-invariants.md](../findings/curvature-invariants.md) line 82, and the source paragraph, all **assert** non-maximality and none derives it. The obvious candidate reason does not transfer as it stands:

- The record's two-block closed form is $\tfrac12-\mu_{p,q}=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$. At $p=2$ this is $-\frac1{2(q-1)}$, so $\mu_{2,q}=\tfrac12+\frac1{2(q-1)}>\tfrac12$ for every $q\ge2$, exceeding the maximality ceiling of §3, so **$S^2\times S^q$ is not a local maximum, and that much is proved** by the record's own formula plus §3's contrapositive. As an exact check on my reading of the formula it returns $\mu_{2,4}=\tfrac12+\tfrac16=\tfrac23$, the brief's recorded witness, and $\mu_{2,5}=\tfrac12+\tfrac18=\tfrac58$, [nondegeneracy.md](../findings/nondegeneracy.md) line 457's value; both exact, both agreeing.
- But $S^2\times S^3\times S^3$ is a **three**-block point, and it is degenerate where every $S^2\times S^q$ on the record is nondegenerate, so it is not a member of that family, its diagonal entries are not the two-block ones, and the closed form above is not evaluable at it without recomputing the three-block spectrum. **That is a computation, which this brief forbids me**, and I do not open it.

So the finding is: *this sub-claim has no argument on file*. What would have to be proved is either $\lambda_{\max}(L_e\vert_{W^\perp})>\tfrac12$ at $S^2\times S^3\times S^3$, or $P\not\equiv0$ on its $E(\tfrac12)$ by §5's cubic-order criterion. **Either would settle it, and the second needs only a single nonzero value of $P$ on a $60$-dimensional space.** Until one is on file the sentence should read *"$S^3\times S^3$ is not a local maximum; $S^2\times S^3\times S^3$ is degenerate, and its non-maximality is asserted and not derived."*

This matters, contained though it is. The lemma's conclusion is that L13's clause is *a hypothesis*, i.e. open and possibly true. If either witness were in fact a local maximum, the clause would be **false**, not hypothetical, and the framing would change. So claim (a) is load-bearing for the framing, and half of it is unsupported.

**Is *"would contradict nothing on the record"* checkable?** Partly, and as stated it is an absence of evidence dressed as a fact, nobody can quantify over everything the record entails. What *is* checkable is the contrapositive constraint I derived above: a degenerate local maximum must carry $\dim E(\tfrac12)>\dim T_W\mathcal O$ **and** $P\equiv0$ on the whole of $E(\tfrac12)$. That is a nontrivial testable condition, so the honest wording is *"no contradiction has been derived, and here is the condition such a point would have to satisfy"*.

## 6. Claim (a)'s strong form, attacking *"no proof of it is available"*

As written this is a claim about the non-existence of proofs and **cannot be established**; I mark it an overreach. But the defensible version is provable, and I prove it: **none of the general structural features of this problem forces nondegeneracy at a local maximum.** Taking the brief's four candidates in turn.

1. **Real-analyticity of $P$.** $P$ is a polynomial, so $P\vert_S$ is real-analytic. Analyticity constrains the *critical set* (it is an analytic set, with locally finite topology) but says nothing about the rank of the Hessian at a maximum. Concretely: $f(x,y)=-x^2-y^4$ is a polynomial with a strict local (indeed global) maximum at the origin whose Hessian has a one-dimensional kernel while the critical set is a single point, so $\ker\mathrm{Hess}\supsetneq T(\mathrm{Crit})$ at an analytic maximum. **Closed.**
2. **The Łojasiewicz inequality.** For analytic $f$ it gives $\lvert f-f(W)\rvert^{\alpha}\le C\lVert\nabla f\rVert$ near $W$ with some $\alpha\in[\tfrac12,1)$, hence finite length of gradient trajectories and convergence of the flow. Nondegeneracy is the statement $\alpha=\tfrac12$ with the Hessian rank maximal transverse to $\mathcal O$; Łojasiewicz *asserts the existence* of some exponent and never that it is $\tfrac12$. The same $-x^2-y^4$ has $\alpha=\tfrac34$. **Closed**, it gives the conclusion nondegeneracy would give (convergence), not nondegeneracy.
3. **Compactness of $S$.** It yields existence of a global maximum and, via §3, that $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$ there. It gives no lower bound on the *gap* below $\tfrac12$, and the record itself records that no such gap can be uniform: [nondegeneracy.md](../findings/nondegeneracy.md) line 370 has the padding law $\min\lvert\lambda-\tfrac12\rvert=\frac1{2(n_0-1)}\to0$. **Closed.**
4. **The $O(n)$-action.** Equivariance gives exactly $T_W\mathcal O\subseteq E(\tfrac12)$ (§2), the *inclusion*, which is the direction that is free. Forcing equality would require the isotypic decomposition of $\mathcal W_n$ under the stabiliser $\mathrm{Stab}(W)$ to be multiplicity-free **and** the resulting scalars to be distinct; the record's own $(3,3)$ analysis ([nondegeneracy.md](../findings/nondegeneracy.md) lines 130 and 459) shows multiplicity-freeness holds there and the scalars collide anyway. **Closed, with the record's own counterexample.**
5. **A route the claim does not mention, which is genuinely open.** §5's cubic-order condition ($P\equiv0$ on $E(\tfrac12)$ at a local maximum), is *specific to the cubic* and is a real obstruction: a degenerate local maximum needs a cubic form to vanish on a subspace strictly larger than the orbit tangent, and on the orbit tangent the vanishing is already forced. **Whether $P$ can vanish on a strictly larger $L_e$-invariant subspace containing $T_W\mathcal O$ is not settled by anything above**, and it is where a proof, if there is one, would come from. Naming it is what turns *"no proof is available"* from a shrug into a plan item.

So the repaired claim is: *"nothing on the record proves it; analyticity, Łojasiewicz, compactness and equivariance are each closed for the reasons above; the live route is the cubic-order vanishing condition."* That is a defensible sentence, and it is what should replace the one on file.

## 7. Claim (b), the simplification

**Four-set blocks lie in $W^\perp$, always, not generically. CONFIRMED.** Index the entries of a symmetric operator on $\Lambda^2\mathbb R^n$ by unordered pairs of $2$-sets. A pure $W$ is supported on the **diagonal** positions $(\{ij\},\{ij\})$; a four-set block for a $4$-subset $\{i,j,k,l\}$ is spanned by operators supported on the **off-diagonal** positions $(\{ij\},\{kl\})$ with $\{i,j\}\cap\{k,l\}=\emptyset$. The trace pairing of two symmetric operators is the sum of products of entries in matched positions, and these two supports are disjoint, so $\langle W,A\rangle=0$ identically, not for generic $W\in\mathcal D_n$ but for **every** element of $\mathcal D_n$, since the vanishing is positionwise. The same argument puts every pair block in $W^\perp$ too, its support being the off-diagonal positions $(\{jl\},\{kl\})$ sharing one index. **This is exactly why the criterion treats $\mathcal D_n$ asymmetrically**, writing $\mathcal D_n\cap W^\perp$ where it writes the blocks bare: $\mathcal D_n$ is the only piece meeting $\mathbb RW$. The criterion's own shape therefore corroborates the reading.

**The exclusion becomes strict. CONFIRMED, and it is trivial once §3 is in place.** At a local maximum with $\theta>0$, $L_e\preceq\tfrac12$ on $W^\perp$; the blocks lie in $W^\perp$ and $L_e$ preserves them, so every block eigenvalue $\mu$ satisfies $\mu\le\tfrac12$, and *"$\tfrac12$ is not an eigenvalue"* is then *"$\mu<\tfrac12$"*, the equivalence $\mu\ne\tfrac12\iff\mu<\tfrac12$ under $\mu\le\tfrac12$. So *"the $\Sigma<\theta^2$ to $\Sigma\ne\theta^2$ repair is right for critical points and unnecessary at maxima"* is the right shape: at a critical point a block **can** sit above $\tfrac12$, which the brief's own recorded witness $S^2\times S^4$ at $\mu_{2,4}=\tfrac23$ exhibits, and maximality is exactly what closes that branch.

**Two things the claim understates and one it does not check.**

- The sharpening is **not confined to four-set blocks**. Pair blocks and $\mathcal D_n\cap W^\perp$ also lie in $W^\perp$, so their eigenvalues are $\le\tfrac12$ too. Nothing in the pair-block half of the criterion is *disturbed* (I checked and found no defect) but it is likewise sharpened: *"$\tfrac12$ absent or simple with eigenvector $o^{jk}$"* becomes *"the top eigenvalue is $<\tfrac12$, or equals $\tfrac12$ simply with eigenvector $o^{jk}$"*, and since $o^{jk}\in T_W\mathcal O\subseteq E(\tfrac12)$ the second alternative is the generic one at any point with a nontrivial orbit. Claim (b) names only the four-set blocks, which reads as though the pair blocks were untouched.
- The equivalence needs $L_e$ to **preserve** each block, which claim (b) does not say. It follows from $\mathrm{Stab}(W)$-equivariance of $L_e$ at a pure $W$ where the blocks are the isotypic pieces, and is elsewhere on the record; I flag it as an unstated input rather than a defect.
- **The $\Sigma$/$\theta^2$ half is unverified here.** The brief gives no dictionary between $\Sigma\lessgtr\theta^2$ and $\mu\lessgtr\tfrac12$, and the conclusion depends on its **orientation**: the argument is sound iff $\Sigma<\theta^2\iff\mu<\tfrac12$ and $\Sigma=\theta^2\iff\mu=\tfrac12$. If the correspondence were orientation-reversing, then $\mu\le\tfrac12$ would read $\Sigma\ge\theta^2$ and the strict form would be $\Sigma>\theta^2$, inverting the repair rather than making it unnecessary. I report this as *not checked*, with the exact condition that has to hold, rather than as a defect.

## 8. Scope, where purity is assumed and where it is not

| step | needs purity? |
|---|---|
| §1 Hessian identity | **no**, holds at every critical point |
| §2 $L_eW=W$, self-adjointness, orbit at $\tfrac12$ | **no** |
| §3 $\ker\mathrm{Hess}=E(\tfrac12)$ | **no** |
| §4 equivalence with Morse–Bott nondegeneracy | **no** |
| §5 the cubic-order criterion | **no** |
| claim (b), and *"at a pure $W$ it is decided by the block criterion"* | **yes**, and both say so |

So the lemma nowhere *silently* assumes purity: the displayed equality and the equivalence are purity-free, and the two places that need it flag it. The one wrinkle is presentational, claim (b)'s sentence *"four-set blocks lie in $W^\perp$"* is true only because $W\in\mathcal D_n$, and (b) does state *"$W$ is pure, hence in $\mathcal D_n$"*, so no finding. Conversely, the block criterion being pure-only means the **closing clause is strictly narrower than the statement it closes**: the equivalence holds at every critical point, and only its blockwise *decision procedure* is restricted to pure ones.

## 9. Unused hypotheses

Recorded in the inventory above. The headline: **"$W$ is a local maximum" is unused** for the displayed equality and for the equivalence, and **the sign of $\theta$ is unused** there as well, $\theta\ne0$ sufficing. Both are used by claim (b), which is the part of the lemma that genuinely lives at a maximum. $\lVert W\rVert=1$ is a normalisation; removing it replaces $3\theta$ by $3P(W)/\lVert W\rVert^2$ and changes nothing.

## 10. The edges

- **$\theta=0$.** Excluded, and essentially so, in two independent ways: $L_e=\frac1{2\theta}DQ_W$ does not exist, and no rescaling of $DQ_W$ makes $W$ an eigenvector at all since $DQ_W(W)=2Q(W)=0$. The Hessian is then identically zero on $W^\perp$ and its kernel is everything. The lemma's $\theta>0$ covers this; $\theta\ne0$ would too.
- **$\ker W\ne0$.** No step above refers to $W$ being invertible as an operator on $\Lambda^2$: §1 uses homogeneity and criticality, §2 uses Euler and equivariance, §3 uses self-adjointness. **No hypothesis is hiding here**, and this matters because the record's padded points all have large $\ker W$.
- **A local maximum that is not global.** Nothing above uses globality, the second-order condition is local and §5's cubic-order condition is local. The lemma is correctly stated for local maxima.
- **$E(\tfrac12)=T_W\mathcal O$ trivially, both zero.** This cannot happen. $T_W\mathcal O=0$ means $W$ is fixed by all of $SO(n)$ acting by conjugation on $\Lambda^2\mathbb R^n$. For $n\ge5$, $\Lambda^2\mathbb R^n$ is $SO(n)$-irreducible, so the invariant symmetric operators are $\mathbb R\,\mathrm{Id}$, and $\mathrm{Id}$ is not trace-free, hence not in $\mathcal W_n$; so $W=0$, contradicting $\lVert W\rVert=1$. At $n=4$, $\Lambda^2=\Lambda^+\oplus\Lambda^-$ and the invariants are $a\Pi_++b\Pi_-$; tracelessness forces $b=-a$, leaving $a\cdot{*}$ with $*$ the Hodge star, whose first-Bianchi component is $\propto\langle{*},{*}\rangle=\mathrm{tr}({*}^2)=6\ne0$, so $a=0$. And $\mathcal W_n=0$ for $n\le3$. **So $T_W\mathcal O\ne0$ at every unit $W\in\mathcal W_n$**, both sides of the equality are nonzero, and the degenerate reading of the equivalence never arises. (This is also what makes $\tfrac12$ genuinely *attained* in §3.)
- **Odd $n$.** Nothing above uses the parity of $n$: the Hessian identity, the Euler relations, the equivariance and the block supports are all parity-free. The record's parity caveats attach to the *balanced maximiser* $S^{n/2}\times S^{n/2}$, which is a statement about which points exist, not about this lemma.

## 11. What would break it, and what I did to look

**The falsifier would be a critical point with $\theta>0$ at which some $v\in E(\tfrac12)$ has $\langle v,W\rangle\ne0$**, since that is the single point where the intersection could fail to be the whole eigenspace; equivalently, a point where $L_e$ fails to be self-adjoint or where $L_eW\ne W$. §2 rules all three out from the definitions, $L_eW=W$ is Euler plus criticality, and self-adjointness is total symmetry of the polarisation of a cubic, so **no such object exists, and the displayed equality is not falsifiable given the Hessian identity**. What I did to look: I did not search, sweep or hunt; I attacked the two structural inputs directly, re-deriving each from the definitions (§§1–2) and then testing whether the conclusion survives their weakest form (§2's counter-derivation showing self-adjointness on $W^\perp$ alone is *not* enough). That is the whole of the search, and it is analytic.

The object that would break the *surrounding narrative* is different and does not touch the lemma: a **degenerate local maximum**, which would make L13's clause false rather than hypothetical. §5 gives the constraint it must satisfy and §6 gives the reason no general principle excludes it. I opened no search for one; that would be a falsifier hunt, which this brief forbids.

## 12. The machine-checked file

[L170.lean](../lean/HamiltonsCubic/Results/L170.lean) is honest about its reach (it formalises the pointwise arithmetic and names the operator-level content it cannot express) and the four theorems are correct as arithmetic. Two remarks.

- **`kernel_is_half_eigenspace` carries no maximality hypothesis**, only $\theta>0$, which is the correct statement and is §3's finding in miniature. Its **docstring is wrong**: *"maximality enters only as $\lambda\le\tfrac12$, which makes $\tfrac12$ the top eigenvalue on $W^\perp$ and so makes the kernel the whole eigenspace rather than a part of it"* is a non-sequitur. Being the top eigenvalue has no bearing on whether $\ker(L_e-\tfrac12)$ is all of $E(\tfrac12)$; that is settled by $L_eW=W$ and self-adjointness, both of which the file correctly lists under *"what is not checked here"*. The sentence should be replaced by *"maximality is not used; $\theta\ne0$ suffices"*.
- `witnesses_are_degenerate` proves $9<18$ and $21<60$. That is the arithmetic of degeneracy and it is fine, but its docstring's claim that *"neither is a local maximum"* is exactly the unsupported half identified in §5, and the file states it as settled.

---

## Verdict: **PROVEN, hypotheses corrected**

The displayed equality and the equivalence are **true and proved**, and proved under a strictly weaker hypothesis than the one on file: *$W$ critical for $P\vert_S$ with $\theta\ne0$*, with maximality and the sign of $\theta$ both unused. One step of the written proof (that $L_eW=W$ puts $E(\tfrac12)$ in $W^\perp$), needs self-adjointness of $L_e$, which is true, unstated, and shown here to be unavailable from the recorded facts alone. Claim (b) is correct where it is checkable, understates its own reach across the pair blocks and $\mathcal D_n\cap W^\perp$, and leaves the $\Sigma$/$\theta^2$ orientation unverified. Claim (a) is half-supported: **HYPOTHESIS-DEBT on *"$S^2\times S^3\times S^3$ is not a local maximum"*, which has no argument on file**, and would be discharged by either $\lambda_{\max}(L_e\vert_{W^\perp})>\tfrac12$ or a single nonzero value of $P$ on its $E(\tfrac12)$. Claim (a)'s *"no proof is available"* is repaired in §6 into a statement that can be defended, with the live route named.
