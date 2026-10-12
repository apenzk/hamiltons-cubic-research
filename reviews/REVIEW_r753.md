# r753, L171, the inner maximisation's constants: $V(t)$ has two, not three (Gate 2)

**Cold review.** I worked from [BRIEF-g2-l171.md](BRIEF-g2-l171.md) alone and from mathematics I derived myself; I opened [findings/route-a.md](../findings/route-a.md) only after every verdict below was fixed, and then only for the provenance question the brief's item 8 asks. **No numerical work of any kind was done**, no search, no sweep, no census, and not even a screen: every value below is exact and every arithmetic step is by hand, in rationals and closed-form radicals. Log: [agent_logs/g2-l171-r753.log](../agent_logs/g2-l171-r753.log).

## Claim table

| # | Claim as written | Verdict |
|---|---|---|
| C1 | The closed form $V(t)=a$ for $t\le t^*$, $=\tfrac{a^2}{4\lambda t}+\lambda t$ for $t\ge t^*$, $t^*=\tfrac a{2\lambda}$ | **PROVEN on $t\ge0$; REFUTED as written on $t<0$**, the first branch's range is unbounded below and the claim fails there, in closed form, under every stated hypothesis |
| C2 | The planar ansatz $K=\cos\varphi\,\hat q+\sin\varphi\,v$ captures the maximum | **GAP IN THE WRITE-UP, CLOSED HERE**, true for $t\ge0$, $\lambda>0$, but the proof asserts it by choosing coordinates; the missing two lines are §1 |
| C3 | A top eigenvector is orthogonal to $q$ | **CONFIRMED, and stronger**, $q\perp\operatorname{im}M$ entirely, so the whole eigenspace $E_\lambda$ is orthogonal to $q$ at any multiplicity; the proof's $\lambda\ne0$ is exactly the needed exclusion |
| C4 | $\langle MK,K\rangle=\lambda\sin^2\varphi$, "the $\hat q$ term vanishing and the cross term with it" | **CONFIRMED**, both vanish from $M\hat q=0$ alone; symmetry is not used here, and the proof's placement of it is loose but harmless |
| C5 | The interior point $c^*=\tfrac a{2t\lambda}$ with value $\tfrac{a^2}{4\lambda t}+\lambda t$ | **CONFIRMED as arithmetic; INCOMPLETE as an argument**, it is a maximum only when $t\lambda>0$, which the proof never says; for $t\lambda<0$ the same point is the *minimum* |
| C6 | $c^*\le1\iff t\ge\tfrac a{2\lambda}$, and below it the max is $f(1)=a$ | **CONFIRMED**, both, exactly; $f(1)=a$ identically in $t$ and $\lambda$ |
| C7 | $\tfrac{a^2}{4\lambda}=\tfrac5{16}$ and $t^*=\tfrac{\sqrt{30}}8$ each pin $\lambda=\tfrac23$, independently and in agreement | **CONFIRMED**, all four evaluations redone from scratch; no slip, and the agreement is real arithmetic |
| C8 | Claim (a): the tangency is structural | **CONFIRMED, and for a second reason the block does not give**, $V$ is a max of affine functions of $t$, hence convex, so a $C^1$ join is forced |
| C9 | Claim (b): the record's internal agreement among the three constants is not evidence | **CONFIRMED**, and the provenance checked: [route-a.md:562](../findings/route-a.md) records $\sqrt{5/6}$ and $\tfrac23$ as the *measured* pair and the display at [route-a.md:552](../findings/route-a.md) is built from them, so $\tfrac5{16}$ and $t^*$ are computed, never measured |
| C10 | Claim (c): $c_0=1$ is a hypothesis, not a constant to derive | **CONFIRMED in its load-bearing half**; the trailing clause *"neither the reduction nor the closed form survives"* is an assertion about a computation nobody has done, **UNARGUED**, though harmless, since it is a caveat rather than a step |
| C11 | *(unstated in the block)* $\lambda\ge0$ is automatic | **NEW FINDING**, $Mq=0$ with $q\ne0$ forces $\lambda_{\max}\ge0$, so the brief's "$\lambda<0$" edge cannot occur |
| C12 | *(unstated in the block)* $M$'s symmetry is free | **NEW FINDING**, it follows from the symmetry of $T$ via $\langle M_{W_1}X,Y\rangle=T(W_1,X,Y)$, so it is a consequence of the setting rather than a hypothesis to carry |
| C13 | *(the record's L22, not this block)* "$V$ is monotone in both constants" | **NEW FINDING, CONFIRMED in one line**, and it matters: $V$ is nondecreasing in $a$ and in $\lambda$ on $t\ge0$, so the record's display is an **upper** bound on $V$ at every $W_1$ whether or not both suprema are attained at the same $W_1$ |

**Actionable summary.** The lemma is true and the pinning is exact; make two edits, restrict the first branch to $0\le t\le t^*$ (it is false at $t=-1$ for an admissible $(q,M)$ exhibited in §11), and insert §1's two-line reduction, which is the only step the whole lemma rests on and the one the written proof replaces with a choice of coordinates.

## 0. Conventions, fixed once

Write $E:=\ker F_u$, a real inner product space of finite dimension $d\ge1$, and $M:=M_{W_1}\colon E\to E$ for the operator with $\langle MX,Y\rangle=T(W_1,X,Y)$. Write $q:=\Pi_EQ(W_1)\in E$, $a:=\lVert q\rVert$, $\hat q:=q/a$ when $a>0$, and $\lambda:=\lambda_{\max}(M)$, the top eigenvalue of $M$ **on all of $E$**. The object under review is

$$V(t)\ :=\ \max_{K\in E,\ \lVert K\rVert=1}\ \big[\langle q,K\rangle+t\langle MK,K\rangle\big],$$

a maximum rather than a supremum because the integrand is continuous and the unit sphere of $E$ is compact, this is used silently by the block and is sound. Write $f(c):=ac+t\lambda(1-c^2)$ for the one-variable function the proof reduces to, and $q^\perp$ for the orthogonal complement of $q$ **inside $E$**. In the application $t$ is [Lemma L165](../findings/route-a.md)'s $t=\sigma/c$ with $\sigma\in[0,1]$ and $c=\sqrt{1-\sigma^2}>0$, so $t\in[0,\infty)$ there; the lemma as stated carries no such restriction, which is §11's finding.

## Hypothesis inventory

| | Hypothesis | Stated? | Used where |
|---|---|---|---|
| H1 | $E$ a real inner product space, $\dim E<\infty$ | implicit | attainment of the max; the spectral theorem in §1 and §2 |
| H2 | $M$ symmetric | yes | §1 (invariance of $q^\perp$) and §2 (eigenvector orthogonality), **and it is free**, see §12 |
| H3 | $Mq=0$ | yes, as [Observation L102](../findings/route-a.md), measured at $n=12,14,16$ | §1, §2, §3, the hypothesis the whole lemma turns on |
| H4 | $a>0$ | no | forming $\hat q$; the value of the constant branch; $t^*$ finite and nonzero |
| H5 | $\lambda>0$ | partly, the proof says $\lambda\ne0$ | dividing by $\lambda$; identifying $\lambda_{\max}(M\vert_{q^\perp})$ with $\lambda$ |
| H6 | $t\ge0$ | **no** | §1's inner maximisation over $q^\perp$; the constant branch. **The missing hypothesis** |
| H7 | $T(W_1,W_1,K)=\langle q,K\rangle$ for $K\in E$ | upstream ([L101](../findings/route-a.md)'s row) | identifying $A$ with a linear functional on $E$ |
| H8 | $K$ ranges over $E$ alone, i.e. $c_0=1$ | upstream, in the parametrisation | the *domain* of the maximisation, before the proof starts, §9 |

**Stated and unused.** $\theta^*=\sqrt{3/2}$; $W_1\in V_{1/3}$ and $P(W_1)=0$; the dimensions $n=12,14,16$; $\dim E$; the sphere-product constant $\theta$; and the specific value $a=\sqrt{5/6}$, which enters only at §6's pinning and plays no part in the derivation of the closed form. The lemma is a statement about one symmetric operator and one vector in its kernel, and nothing about $\mathcal W_n$ reaches it.

## 1. The ansatz, the step the lemma rests on, and it is not argued

**The objection is correct as stated.** A unit $K\in E$ has $d-1$ free parameters and the proof gives it two; nothing in the two lines before it excludes a maximiser with a component in $\{q,v\}^\perp$. As written the proof *chooses coordinates in which the answer is the one displayed*, and that is the one step whose failure would sink everything downstream.

**The reduction is nevertheless true for $t\ge0$ and $\lambda>0$, and here is the argument the block owes.**

**Step 1, $q^\perp$ is $M$-invariant, indeed $\operatorname{im}M\subseteq q^\perp$.** For any $x\in E$, symmetry and $Mq=0$ give $\langle Mx,q\rangle=\langle x,Mq\rangle=0$. So every vector in the image of $M$ is orthogonal to $q$; in particular $M(q^\perp)\subseteq\operatorname{im}M\subseteq q^\perp$, and $M\vert_{q^\perp}$ is a symmetric operator on $q^\perp$ in its own right.

**Step 2, the decomposition of an arbitrary unit $K$.** Every unit $K\in E$ is $K=c\,\hat q+s\,w$ with $c=\langle K,\hat q\rangle\in[-1,1]$, $s=\sqrt{1-c^2}\ge0$ and $w$ a unit vector of $q^\perp$ (any $w$ when $s=0$). This is a decomposition, not an ansatz: it costs nothing.

**Step 3, the objective in those variables.** Expanding and using $M\hat q=0$,

$$\langle q,K\rangle=ac,\qquad \langle MK,K\rangle=c^2\langle M\hat q,\hat q\rangle+cs\big(\langle M\hat q,w\rangle+\langle Mw,\hat q\rangle\big)+s^2\langle Mw,w\rangle=s^2\langle Mw,w\rangle,$$

since $M\hat q=0$ kills the first two brackets outright and $\langle Mw,\hat q\rangle=\langle w,M\hat q\rangle=0$ kills the third summand of the middle term. So the objective is $ac+t(1-c^2)\langle Mw,w\rangle$, and $w$ enters **only** through the Rayleigh quotient $\langle Mw,w\rangle$ on the unit sphere of $q^\perp$.

**Step 4, the inner maximisation, and this is where $t\ge0$ enters.** Fix $c$. Then $t(1-c^2)\ge0$, so maximising over $w$ means maximising $\langle Mw,w\rangle$, whose maximum over the unit sphere of $q^\perp$ is $\Lambda:=\lambda_{\max}(M\vert_{q^\perp})$, attained at a top eigenvector of $M\vert_{q^\perp}$.

**Step 5, $\Lambda=\lambda$ when $\lambda>0$.** By Step 1 and the spectral theorem, $E=\langle q\rangle\oplus q^\perp$ splits $M$, so $\operatorname{spec}(M)=\{0\}\cup\operatorname{spec}(M\vert_{q^\perp})$ and $\lambda=\max(0,\Lambda)$. Hence $\lambda>0$ forces $\Lambda=\lambda$, and the maximising $w$ is a top eigenvector $v$ of $M$ itself, which lies in $q^\perp$, so $K=c\hat q+sv$ is exactly the proof's $K=\cos\varphi\,\hat q+\sin\varphi\,v$.

**Conclusion.** $V(t)=\max_{c\in[-1,1]}\big[ac+t\lambda(1-c^2)\big]=\max_{c\in[-1,1]}f(c)$ for $t\ge0$ and $\lambda>0$, with the maximum attained inside $\operatorname{span}\{\hat q,v\}$. The plane is a conclusion, not a hypothesis, **but only because $q$ is an eigenvector of $M$**, which is what $Mq=0$ says, and that is exactly the fact the write-up spends and does not spend visibly. **Verdict: the ansatz is sound and the write-up is a gap.** Five lines fix it, and they should go in, because a reader cannot reconstruct them from what is on the page: the proof's sentence *"a top eigenvector $v$ … is orthogonal to $q$"* justifies the *shape* of the plane and says nothing about why the maximiser lies in it.

**One remark on how much stronger this setting is than the trust-region hard case the block invokes.** The classical hard case of $\max\{\langle g,K\rangle+t\langle MK,K\rangle:\lVert K\rVert=1\}$ is $g\perp E_\lambda$, which permits $g$ to spread over the remaining eigenspaces and leaves the solution implicit in a secular equation. Here $g=q$ is itself an eigenvector of $M$, which is strictly stronger and is what collapses the secular equation to the quadratic $f$. So the block's "hard-case trust-region problem and so globally solvable" understates its own hypothesis; the closed form comes from $Mq=0$, not from hard-case theory.

## 2. $Mq=0$, the image, multiplicity, and $\lambda=0$

**"Restricted how, exactly?"**, the answer is *not restricted at all*. $\langle q,Mx\rangle=\langle Mq,x\rangle=0$ for **every** $x\in E$, so $q\perp\operatorname{im}(M)$ as an operator on all of $E$, not merely on some invariant piece. This is stronger than the proof's stated consequence and is what Step 1 above uses.

**Multiplicity $>1$.** Let $E_\lambda=\ker(M-\lambda)$ with $\lambda\ne0$. Every $v\in E_\lambda$ satisfies $v=\lambda^{-1}Mv\in\operatorname{im}M$, hence $v\perp q$. So the **entire** top eigenspace is orthogonal to $q$ at any multiplicity, and the proof's choice of *a* top eigenvector is arbitrary in a harmless way, every choice gives the same $\lambda\sin^2\varphi$ and the same $V$. Degeneracy of $\lambda$ costs nothing.

**$\lambda=0$.** Here the proof's argument genuinely fails: $q$ is *itself* a top eigenvector, "top eigenvector $\perp q$" is false for the choice $v=\hat q$, and $t^*=a/(2\lambda)$ and $a^2/(4\lambda t)$ are undefined. The proof excludes this by writing $\lambda\ne0$, which is correct practice. The *conclusion* survives as a limit (see §11) but the *proof* does not, and the statement as displayed does not carry the $\lambda\ne0$ that the proof carries. **Move $\lambda>0$ into the statement.**

## 3. The cross term, and where symmetry is actually used

The expansion needs two vanishings, and both follow from $M\hat q=0$ alone:

- $\langle M\hat q,\hat q\rangle=\langle 0,\hat q\rangle=0$, the "$\hat q$ term".
- $\langle M\hat q,v\rangle=\langle 0,v\rangle=0$, half the cross term.

The remaining half, $\langle Mv,\hat q\rangle$, is where the two available routes differ: **either** symmetry, $\langle Mv,\hat q\rangle=\langle v,M\hat q\rangle=0$, **or** the eigenvalue relation plus §2's orthogonality, $\langle Mv,\hat q\rangle=\lambda\langle v,\hat q\rangle=0$. So the cross term dies twice over and no hypothesis beyond $Mq=0$ is needed for §3 in isolation.

**Where symmetry is genuinely load-bearing** is elsewhere, and the block never says so: (i) §1's Step 1, $\operatorname{im}M\subseteq q^\perp$, which is what makes $q^\perp$ an $M$-invariant subspace and the reduction possible at all; (ii) §2's orthogonality of $E_\lambda$ to $q$; (iii) the spectral theorem behind Step 4's "the maximum of the Rayleigh quotient is the top eigenvalue, attained". Without symmetry $M$ need not be diagonalisable, $\lambda$ need not be real, and $\max_w\langle Mw,w\rangle$ is $\lambda_{\max}$ of the symmetric part rather than of $M$. **The proof's sentence attributes symmetry to the step that does not need it.** That is presentational, and I record it as such.

## 4. The one-variable maximisation, with signs

$f(c)=ac+t\lambda(1-c^2)$ on $[-1,1]$, with $f'(c)=a-2t\lambda c$ and $f''(c)=-2t\lambda$ constant. Three regimes, exhaustively:

- **$t\lambda>0$.** $f$ is strictly concave; the unique critical point $c^*=\dfrac a{2t\lambda}$ is the global **maximum** of $f$ on $\mathbb R$, and the constrained maximum is $f(c^*)$ if $c^*\le1$ and $f(1)$ otherwise ($c^*>-1$ always, since $c^*>0$ for $a>0$).
- **$t\lambda<0$.** $f$ is strictly convex and $c^*$ is the global **minimum**. The maximum over $[-1,1]$ sits at an endpoint: $\max\{f(1),f(-1)\}=\max\{a,-a\}=a$ for $a\ge0$, attained at $c=1$.
- **$t\lambda=0$.** $f(c)=ac$ is affine, maximised at $c=1$ with value $a$ (or constant $0$ if also $a=0$).

**So the proof's "gives the interior point" is a maximum precisely on $t\lambda>0$, and the proof does not say so.** Under the statement's intended hypotheses ($\lambda>0$, $t>0$) it is the right regime, so this is an unstated side condition rather than an error, but it is the same missing $t\ge0$ as §1's Step 4, arriving by a second route, which is a fair sign that the hypothesis is real.

## 5. The threshold, and $f(1)$

**The equivalence.** For $t>0$, $\lambda>0$, $a>0$: $c^*=\dfrac a{2t\lambda}\le1\iff a\le 2t\lambda\iff t\ge\dfrac a{2\lambda}=t^*$, every step a multiplication by a positive number. Confirmed, and it is what [interior_admissible](../lean/HamiltonsCubic/Results/L171.lean) checks over $\mathbb Q$.

**The interior value.** With $c^*=\dfrac a{2t\lambda}$,

$$f(c^*)=\frac{a^2}{2t\lambda}+t\lambda-t\lambda\cdot\frac{a^2}{4t^2\lambda^2}=\frac{a^2}{2t\lambda}-\frac{a^2}{4t\lambda}+t\lambda=\frac{a^2}{4\lambda t}+\lambda t,$$

matching the display exactly.

**The boundary.** $f(1)=a\cdot1+t\lambda(1-1)=a$, identically in $t$ and $\lambda$, the brief's own check, and it holds. On $0\le t<t^*$ the concave $f$ has its unconstrained maximiser at $c^*>1$, so $f$ is increasing throughout $[-1,1]$ and the constrained maximum is $f(1)=a$. Both branches confirmed, and they agree at $t=t^*$, where $c^*=1$ and both formulas return $a$, so the "$t\le t^*$" and "$t\ge t^*$" of the statement overlapping at the endpoint is consistent rather than a clash.

## 6. The two pinnings

All four evaluations redone from scratch at $a^2=\tfrac56$, $\lambda=\tfrac23$, exactly.

**Forward, the coefficient.** $\dfrac{a^2}{4\lambda}=\dfrac{5/6}{4\cdot\tfrac23}=\dfrac{5/6}{8/3}=\dfrac56\cdot\dfrac38=\dfrac{15}{48}=\dfrac5{16}$. ✔ matches the record's $\tfrac{5}{16t}$.

**Forward, the branch point.** $t^*=\dfrac a{2\lambda}=\dfrac{\sqrt{5/6}}{4/3}=\tfrac34\sqrt{\tfrac56}$, and $\sqrt{5/6}=\dfrac{\sqrt5}{\sqrt6}=\dfrac{\sqrt{30}}6$, so $t^*=\dfrac34\cdot\dfrac{\sqrt{30}}6=\dfrac{3\sqrt{30}}{24}=\dfrac{\sqrt{30}}8$. ✔ matches, as does $t^{*2}=\tfrac{30}{64}=\tfrac{15}{32}$ against $\dfrac{a^2}{4\lambda^2}=\dfrac{5/6}{16/9}=\dfrac56\cdot\dfrac9{16}=\dfrac{15}{32}$.

**Backward from $\tfrac5{16}$, independently.** $\dfrac{a^2}{4\lambda}=\dfrac5{16}\Rightarrow\lambda=\dfrac{16a^2}{20}=\dfrac{4a^2}5=\dfrac{4}{5}\cdot\dfrac56=\dfrac23$. One equation, one unknown, unique solution. ✔

**Backward from $t^*$, independently.** $\lambda=\dfrac a{2t^*}=\dfrac{\sqrt{30}/6}{2\cdot\sqrt{30}/8}=\dfrac{\sqrt{30}/6}{\sqrt{30}/4}=\dfrac46=\dfrac23$. ✔ (The positive root is the right one because $\lambda>0$ and $a>0$; the squared form $t^{*2}=a^2/(4\lambda^2)$ has the spurious root $\lambda=-\tfrac23$, which [branch_point_pins_lambda](../lean/HamiltonsCubic/Results/L171.lean) excludes by hypothesis $0<\lambda$, correctly.)

**No slip, and the agreement is real.** Each of the two record constants determines $\lambda$ on its own given $a$, and the two answers coincide. What that agreement *is* is §8's question; that it *holds* is confirmed.

**One correction of arithmetic bookkeeping, in the block's own favour.** The record's display carries $\lambda$ in **three** places, not two: $\tfrac5{16}=\tfrac{a^2}{4\lambda}$, $t^*=\tfrac a{2\lambda}$, and the linear coefficient $\tfrac23$ of $\tfrac{2t}3=\lambda t$, which *is* $\lambda$ read off directly. The block's own annotation at [route-a.md:693](../findings/route-a.md) says exactly this ("one constant read three ways"), so the statement's headline *"three constants are two"* and the annotation are counting different things, the headline counts $\{\tfrac5{16},\tfrac23,t^*\}$ collapsing to $\{a,\lambda\}$. Both are right; a reader meeting the headline first will miscount. Worth one clarifying clause.

## 7. Claim (a), the tangency

For $\alpha,\beta>0$, $g(t)=\alpha/t+\beta t$ on $t>0$ has $g'(t)=-\alpha/t^2+\beta$, vanishing at $t=\sqrt{\alpha/\beta}$, with $g''=2\alpha/t^3>0$, so that point is the minimum, of value $\alpha\sqrt{\beta/\alpha}+\beta\sqrt{\alpha/\beta}=2\sqrt{\alpha\beta}$. **Signs check**: $\alpha=\dfrac{a^2}{4\lambda}>0$ and $\beta=\lambda>0$ under $a>0$, $\lambda>0$, so the formula applies. Then $\sqrt{\alpha/\beta}=\sqrt{\dfrac{a^2}{4\lambda^2}}=\dfrac a{2\lambda}=t^*$ (the positive root, correct) and $2\sqrt{\alpha\beta}=2\sqrt{\dfrac{a^2}{4\lambda}\cdot\lambda}=2\cdot\dfrac a2=a$. **Both confirmed**, and with them the $C^1$ join: the constant branch has slope $0$ and the frontier branch has slope $0$ at its minimum, which is $t^*$.

**And there is a second, better reason the block does not give.** $V(t)=\max_K[A(K)+tB(K)]$ is a pointwise maximum of **affine** functions of $t$, hence convex on all of $\mathbb R$, and differentiable wherever the maximiser is unique. A convex function that is constant on $[0,t^*]$ and smooth past $t^*$ *must* leave the constant branch with zero slope: tangency is forced by the variational form of $V$ before any formula is computed. This makes claim (a) structural in a stronger sense than the block claims, and it is a useful check, had the two branches met transversally, the closed form would have been wrong somewhere.

**A consistency test the two readings pass together.** On $0<t<t^*$ the frontier expression exceeds $a$ strictly (AM–GM, with equality only at $t^*$) while $V=a$ there, so $V$ is neither the max nor the min of its two branches. The record states precisely this at [route-a.md:558](../findings/route-a.md), it is aware of the trap, and it is right.

## 8. Claim (b), the epistemics, and what I checked

**The claim is that mutual agreement among $\tfrac5{16}$, $\tfrac23$ and $t^*$ is not evidence. That is right, and the reason is provenance, so I checked the provenance rather than reasoning about it.**

**What the record says.** [route-a.md:562](../findings/route-a.md): *"The two suprema $\sqrt{5/6}$ and $\tfrac23$ were measured at $n=10$, below the range they are used to cap"*. And the display is introduced at [route-a.md:550–552](../findings/route-a.md) as built from those two suprema, *"Its value is monotone in both constants … giving, with $t=s/\cos\beta$, [the display]"*. So on the record the measured objects are the pair $(a,\lambda)=(\sqrt{5/6},\tfrac23)$, and $\tfrac5{16}$ and $\sqrt{30}/8$ are **arithmetic consequences** of them, computed when the display was written.

**Therefore.** Their agreement is a restatement of $\tfrac{a^2}{4\lambda}$ and $\tfrac a{2\lambda}$ being functions of the same two numbers. It carries no independent confirmation of anything, it cannot fail while the arithmetic is right, and a defect in the measured $\lambda$ moves all three together, exactly as the block says.

**The counterfactual the brief asks about is real, and it is worth stating in the block.** *If* $\tfrac5{16}$ and $t^*$ had been obtained separately (by fitting the numerically computed $V(t)$ on its two branches, say) then their agreement **would** be evidence, and specifically evidence *for this lemma*, since the relation $t^{*2}\lambda=\tfrac{a^2}{4\lambda}\cdot\lambda^{-1}\cdot\lambda^2$, i.e. $\tfrac{a^2}{4\lambda}=\lambda t^{*2}$, is a nontrivial constraint linking them that only the hard-case solution predicts. It is not what happened here. **Verdict: claim (b) confirmed, with the provenance cited rather than assumed.**

## 9. Claim (c), what $c_0=1$ buys

**Does the derivation use $W_2\in\ker F_u$, and where?** Yes, and *before its first line*: the maximisation is written over $\lVert K\rVert=1$ with $K\in\ker F_u$, so the restriction sits in the **domain** of $V$, not in any displayed step. That is why no line of the proof can be pointed at, and it is also why the hypothesis is easy to lose sight of, which is the point claim (c) is making. The block is right to name it.

**Would a component in $N$ break it or merely complicate it?** More than complicate, and by two independent mechanisms:

- **The objective gains terms.** With $W_2=\sigma(c_0K+s_0N)$, $P(W)$ acquires $3c^2\sigma s_0^2\,T(W_1,N,N)$ and $6c^2\sigma c_0s_0\,T(W_1,K,N)$ beyond the displayed $A+tB$, so the bracket is no longer a linear-plus-quadratic form in a single unit vector, and the reduction of §1 (which turns on $q$ being an eigenvector of a *single* symmetric operator on a *single* sphere), has nothing to act on.
- **The change of variable dies with it.** $N\notin\ker F_u$ contributes $\sigma^2s_0^2\langle F_uN,N\rangle<0$ to $\alpha$, so the equality $s^2=3\varepsilon$ that [L165](../findings/route-a.md) uses to define $\sigma$, and hence $t=\sigma/c$ itself, no longer holds. There is no $t$ left for $V(t)$ to be a function of.

**But the clause as written overreaches slightly.** *"Neither the reduction nor the closed form survives"* asserts the non-existence of a closed form for a problem nobody has set up. What is established is the weaker and sufficient statement: **the reduction as performed does not survive, and no closed form for the enlarged problem is on the record.** Since the clause is a caveat rather than a step, nothing downstream moves; I record it as an unargued assertion and suggest the weaker wording. The rest of claim (c) (that $c_0=1$ is a hypothesis rather than a constant awaiting derivation), is **correct and well put**, and it is the honest reading of where the block's remaining debt lies.

## 10. Hypothesis inventory

Given above, before §1. The two findings from it:

- **$t\ge0$ is used twice and stated nowhere** (§1 Step 4, §4's sign of $t\lambda$). It is satisfied in the application, where $t=\sigma/c\ge0$.
- **$M$'s symmetry is not an extra hypothesis at all** (§12), and the specific values $a=\sqrt{5/6}$, $\lambda=\tfrac23$ are unused until §6, the closed form is a fact about an arbitrary symmetric operator with $q$ in its kernel.

## 11. The edges

**$t<0$, the one live defect.** The statement's first branch reads "$t\le t^*$" with no lower bound, and it is **false** there. Exhibited concretely: take $E=\mathbb R^3$, $q=(1,0,0)$ so $a=1$, and $M=\operatorname{diag}(0,1,-1)$. Then $M$ is symmetric, $Mq=0$, $\lambda=\lambda_{\max}(M)=1>0$ and $t^*=a/(2\lambda)=\tfrac12$. At $t=-1\le t^*$, take $K=(\tfrac12,0,\tfrac{\sqrt3}2)$:

$$\langle q,K\rangle+t\langle MK,K\rangle=\tfrac12+(-1)\cdot\big(-\tfrac34\big)=\tfrac12+\tfrac34=\tfrac54\ >\ 1=a.$$

So $V(-1)\ge\tfrac54>a$, contradicting the branch. **Located**: the statement's first case, its range. **The mechanism**: for $t<0$ the inner maximisation of §1 Step 4 selects $\lambda_{\min}(M\vert_{q^\perp})$, not $\lambda_{\max}$, and $t\lambda_{\min}>0$ reopens the interior maximum. **The opposite reading**, argued as fairly as I can: the block's $t$ is $\sigma/c$ with $\sigma\in[0,1]$, so $t<0$ never arises in use and the defect is one of scope. That is true, and it is why the verdict below is *hypotheses corrected* rather than broken, but a lemma stated for arbitrary symmetric $M$ and quoted by number should not have a false range. **Repair**: write $0\le t\le t^*$, or add $M\succeq0$, which is not on the record.

**$\lambda=0$.** Then $M\preceq0$, $q^\perp$ carries no positive Rayleigh quotient, and for $t\ge0$ the maximum is at $c=1$: $V\equiv a$. The statement reads $t^*=a/(2\lambda)=+\infty$ and the constant branch covers everything, so the **conclusion degrades gracefully**; the **proof does not** (division by zero, and $v\perp q$ fails). Excluded by the proof's $\lambda\ne0$, which should be lifted into the statement.

**$\lambda<0$ cannot occur.** $Mq=0$ with $q\ne0$ exhibits $0$ as an eigenvalue, so $\lambda=\lambda_{\max}(M)\ge0$ always. The brief's edge is empty, and that is a small strengthening of the block: the only degenerate case on the $\lambda$ side is $\lambda=0$.

**$a=0$, equivalently $q=0$.** $\hat q$ is undefined and the proof's construction collapses, but the *formula* survives: $A\equiv0$, so $V(t)=t\lambda$ for $t\ge0$, while the statement gives $t^*=0$ and the frontier branch $\tfrac{0}{4\lambda t}+\lambda t=\lambda t$. Agreement. Note also that $Mq=0$ is vacuous at $q=0$, so this edge carries no information.

**$t=0$.** $V(0)=\max_{\lVert K\rVert=1}\langle q,K\rangle=\lVert q\rVert=a$, attained at $K=\hat q$, the constant branch, consistent since $t^*>0$. This is also the sanity check that $a=\lVert q\rVert$ is the right constant: it is Cauchy–Schwarz with equality, and it needs $q\in\ker F_u$, which holds because $q$ is defined as the projection.

**$\dim\ker F_u=1$.** Then $E=\langle q\rangle$ (for $q\ne0$), $M=0$ by $Mq=0$, $\lambda=0$, no $v$ exists and the proof cannot be written down; $V\equiv a$ for $t\ge0$, which the $\lambda=0$ reading returns. Consistent, and again outside the proof's $\lambda\ne0$.

**A structural check across all edges.** $V$ is convex on $\mathbb R$ (max of affine functions of $t$), nonnegative-slope on $t\ge0$, and equals $a$ at $t=0$. The displayed piecewise function has all three properties on $t\ge0$ and only there, which is a second, independent signal that $t\ge0$ is the true domain.

## 12. What would break it, and two things that would not

**Would break it.**

1. **$M_{W_1}q\ne0$.** This is the whole lemma. It is [Observation L102](../findings/route-a.md), measured at $n=12,14,16$ and proven nowhere. With $Mq\ne0$ the cross term $2cs\langle M\hat q,w\rangle$ returns, $q^\perp$ is no longer $M$-invariant, the problem becomes the genuine trust-region subproblem with an implicit secular equation, and **no closed form of this shape is available**. Every constant in the display then loses its derivation, including $t^*$ and $\tfrac5{16}$, the collapse claim (b) describes runs in this direction too.
2. **$t<0$ admitted into the range**, as §11 shows in closed form.
3. **$\lambda\le0$**, the frontier branch is undefined at $\lambda=0$ and the pinning of §6 divides by it.
4. **$c_0<1$**, per §9: the domain of the maximisation changes and the reduction has nothing to reduce.
5. **A different measured $(a,\lambda)$.** Since the lemma is exact, any correction to the measured pair propagates to $\tfrac5{16}$ and $t^*$ *without* any warning from internal consistency, which is claim (b) stated as a risk rather than as an epistemic point, and is the block's real contribution.

**Would not break it.** Multiplicity of $\lambda$ (§2); non-uniqueness of the maximising $K$; any value of $\dim\ker F_u\ge2$; and (this is the useful one), **the two suprema being attained at different $W_1$**, see below.

**$V$ is nondecreasing in $a$ and in $\lambda$, and this discharges a separate worry the record carries.** For $t\ge0$ write $V(t;a,\lambda)=\max_{c\in[-1,1]}[ac+t\lambda(1-c^2)]$. The maximum is attained at some $c\ge0$, since $f(c)-f(-c)=2ac\ge0$ for $c\ge0$ and $a\ge0$. On $c\in[0,1]$ each function $(a,\lambda)\mapsto ac+t\lambda(1-c^2)$ is nondecreasing in both arguments, and a pointwise maximum of nondecreasing functions is nondecreasing. Hence $V(t;a,\lambda)\le V(t;a',\lambda')$ whenever $a\le a'$ and $\lambda\le\lambda'$. **Consequence**: the record's display, evaluated at the *suprema* $\sqrt{5/6}$ and $\tfrac23$, is an **upper bound** on $V$ at every $W_1$, whether or not both suprema are attained at the same $W_1$. Since [L165](../findings/route-a.md)'s $H_\theta$ subtracts $3c^2\sigma V(t)$ and needs an upper bound on $\gamma_{\max}$, this is the direction the record needs, and it confirms the L22 sentence *"Its value is monotone in both constants and both suprema are attained at the same $W_1$"* in its first half while making the second half unnecessary for the bound. I offer this as a strengthening, outside the brief.

## 13. What the Lean file reaches

[L171.lean](../lean/HamiltonsCubic/Results/L171.lean) is seven `norm_num`/`field_simp` facts over $\mathbb Q$: the two forward evaluations, the two backward pinnings, the interior value identity, the admissibility equivalence and the tangency identity. Every one of them I re-derived by hand above and every one is right, including the hypotheses attached, [interior_admissible](../lean/HamiltonsCubic/Results/L171.lean) carries $0<\lambda$, $0<t$, $0<a$, and [branch_point_pins_lambda](../lean/HamiltonsCubic/Results/L171.lean) carries $0<\lambda$ to kill the spurious root. **Its own docstring is accurate about its reach**: it says the reduction "is what $c_0=1$ asserts and the block does not derive". The file contains no inner product space, no operator and no sphere, so it touches §1 not at all, which is the brief's warning, and the warning is correct. **The arithmetic of §6 is therefore machine-checked; the mathematics of §1 is not, here or anywhere.**

## Verdict

**PROVEN, hypotheses corrected.**

The closed form is true, and true for a better reason than the page gives: with $q$ in the kernel of the symmetric $M$, the image of $M$ lies in $q^\perp$, the objective depends on the off-$q$ direction only through a Rayleigh quotient, and the whole problem collapses to one concave quadratic on $[-1,1]$. The pinning of $\lambda=\tfrac23$ by each of $\tfrac5{16}$ and $\sqrt{30}/8$ is exact, and their agreement is arithmetic rather than evidence, as the block says, and now with the provenance checked at [route-a.md:562](../findings/route-a.md).

**Three corrections owed.**

1. **Range**: the first branch holds on $0\le t\le t^*$, not on $t\le t^*$; §11 exhibits an admissible $(q,M)$ and a $t<t^*$ where the stated value is exceeded.
2. **Statement hypotheses**: $a>0$ and $\lambda>0$ belong in the statement, the proof carries $\lambda\ne0$ and the display does not.
3. **The reduction**: insert §1's Steps 1–5, five lines, in place of *"Write a unit $K=\cos\varphi\,\hat q+\sin\varphi\,v$"*. As it stands the only step the lemma rests on is asserted by a choice of coordinates, and that is what a reader will challenge first.

**One clause to weaken** (§9): *"neither the reduction nor the closed form survives"* asserts more than has been shown about a problem not set up; *"the reduction as performed does not survive, and no closed form for the enlarged problem is on the record"* is what is established and is enough.
