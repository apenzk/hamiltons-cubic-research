# Gate 2 review r957, I106 batches 15 to 27 and the Lean file

Reviewer **r957**, working [BRIEF_I106_batches15_27.md](BRIEF_I106_batches15_27.md) independently of r958. Log: `agent_logs/r957-I106.log`.

| # | claim | verdict |
| --- | --- | --- |
| 1 | batch 18's factor of two, $\mu\ge2\beta\lambda_{\max}(\mathcal L)$ | **CONFIRMED**, with a Lean gap |
| 2 | the Jordan spectrum, $\lambda_{\max}=\lvert\hat U\rvert/\sqrt6$ | **CONFIRMED**, equality clause corrected |
| 3 | batch 20's identity $\Phi=2\mu T-2P_3$ | **CONFIRMED** |
| 4 | batch 21's second variation and the acceleration argument | **CONFIRMED**, two unstated steps |
| 5 | batch 22's tangency, subspace dimension and $a<0$ | **CONFIRMED**, one real gap at $a=0$ |
| 6 | batch 25's elimination, divided difference and lost solutions | algebra **CONFIRMED**, the commutativity reading **REFUTED** |
| 7 | batch 25's count of two remaining independent combinations | **PLAUSIBLE**, the informative residue is one |
| 8 | batch 26's parity and the group action | **CONFIRMED**, the reason given is wrong |
| 9 | batches 23 and 24, scope of the negative results | **PLAUSIBLE**, one overstatement each |
| 10 | batch 27's block, cost claim and saturation | cost **CONFIRMED**, the payoff claim **REFUTED** |
| 11 | the Lean file, 21 declarations, vacuity, axioms | **PLAUSIBLE**, sound but three rows overstated |
| 12 | scope across the record, lean/INDEX.md and plan.md | **CONFIRMED**, two stale rows |

## Method

Every step below was read against the definitions first and rederived by hand second. Three symbolic screens were run on objects constructed for the purpose, each a few seconds, and they are labelled as screens wherever they appear. [I106Criticality.lean](../lean/HamiltonsCubic/Results/I106Criticality.lean) was built (`lake build`, exit 0) and every theorem in it was put through `#print axioms`.

## 1. Batch 18's factor of two, CONFIRMED

**The factor is two.** The Lagrange form of the $V$ equation is $\beta\{\hat U,V\}+C\equiv\mu V$, and $\{\hat U,V\}=\hat UV+V\hat U=2\mathcal LV$, so the equation reads $2\beta\mathcal LV+C=\mu V$. At a global maximum $V$ maximises $f(V)=\beta\langle V,\mathcal LV\rangle+\langle V,C\rangle$ over the sphere $\lvert V\rvert=r$ of traceless symmetric matrices, since replacing $V$ by any $V'$ of the same norm keeps the pair admissible and changes only $f$. Stationarity on that sphere is $\nabla f=2\beta\mathcal LV+C=2\nu V$, so $\nu=\mu/2$, and the necessary condition for a *global* sphere maximum is $\nu\ge\lambda_{\max}(\beta\mathcal L)$. Hence $\mu\ge2\beta\lambda_{\max}(\mathcal L)$.

**Cross-checked in the trust-region normal form**, which fixes the convention independently. Minimising $\tfrac12\langle x,Hx\rangle+\langle g,x\rangle$ on $\lVert x\rVert\le\Delta$ is solved globally exactly when $(H+\lambda I)x=-g$ with $H+\lambda I\succeq0$. Here $H=-2\beta\mathcal L$ and $g=-C$, so the stationarity reads $\lambda V=2\beta\mathcal LV+C$, giving $\lambda=\mu$, and $H+\lambda I\succeq0$ is $\mu\ge2\beta\lambda_{\max}(\mathcal L)$. The two conventions agree. It is two, not one and not four.

**Both stated hypotheses are load-bearing and both are stated.** Globality is needed, since a merely local maximum in $V$ gives only the weaker $\nu I\succeq\beta\mathcal L$ on the tangent space at $V$. The compression to traceless symmetric matrices is needed, since $\mathcal L$ does not preserve tracelessness, and batch 18 says so.

**Finding, the factor is not kernel-checked.** [mu_ge_of_rayleigh](../lean/HamiltonsCubic/Results/I106Criticality.lean) takes `hso : 2 * β * (U * X * X).trace ≤ μ * (X * X).trace` as a **hypothesis**. The whole content of the correction is that hypothesis, and what Lean proves from it is the division by $\operatorname{tr}(X^2)>0$. So the one constant in this body of work that was already wrong once is the one thing in the file that is assumed rather than derived, and the file's docstring calls it "the second-order condition in the form the `V` equation actually carries" without typing that form.

## 2. The Jordan spectrum, CONFIRMED, with the equality clause corrected

**The diagonal block.** Identify traceless diagonal matrices with $\{d\in\mathbb R^3:\sum d_i=0\}$, which is an isometry for $\langle X,Y\rangle=\operatorname{tr}(XY)$. There $\mathcal L$ acts as $d\mapsto P(u\circ d)$ with $P=I-\tfrac13J$. Its trace is $\operatorname{tr}(MP)=\operatorname{tr}M-\tfrac13\operatorname{tr}(MJ)=0-\tfrac13\sum u_i=0$, and its squared norm is $\operatorname{tr}(MPMP)=\sum u_i^2-\tfrac13\sum u_i^2-\tfrac13\sum u_i^2+\tfrac19(\sum u_i)^2=\tfrac13\lvert\hat U\rvert^2$. A symmetric $2\times2$ matrix of trace $0$ and squared norm $\tfrac13\lvert\hat U\rvert^2$ has eigenvalues $\pm\lvert\hat U\rvert/\sqrt6$. Both of batch 18's assertions about this block hold.

**The off-diagonal block.** $\mathcal L(E_{ij}+E_{ji})=\tfrac12(u_i+u_j)(E_{ij}+E_{ji})$, so the eigenvalue is $-u_k/2$ for traceless $u$. The domination identity $2\lvert\hat U\rvert^2-3u_k^2=2(u_i^2+u_j^2)-(u_i+u_j)^2=(u_i-u_j)^2$ is right, and it is [jordan_gap](../lean/HamiltonsCubic/Results/I106Criticality.lean). Hence $\lambda_{\max}(\mathcal L)=\lvert\hat U\rvert/\sqrt6$.

**Correction, the equality clause is stated for the wrong inequality.** What the identity gives is $3u_k^2\le2\lvert\hat U\rvert^2$, that is $\lvert u_k\rvert/2\le\lvert\hat U\rvert/\sqrt6$, with equality exactly when $u_i=u_j$. The inequality actually used is the **signed** one $-u_k/2\le\lvert\hat U\rvert/\sqrt6$, and equality there needs $u_i=u_j$ **and** $u_k\le0$. At $u\sim(t,t,-2t)$ with $t<0$ the other two eigenvalues agree and yet $-u_k/2=t<0<\lvert\hat U\rvert/\sqrt6$, strictly. So batch 18's "with equality exactly when the other two eigenvalues agree, that is at $u\sim(t,t,-2t)$" should read $t>0$, and batch 19's opening, which calls that spectrum the one where the bound is tight, inherits the same restriction.

**A second correction to batch 19's opening.** It states batch 18's bound as $\mu\ge\beta\lvert\hat U\rvert/\sqrt6$, the superseded halved form, and only later says "with the sharp constant of batch 18 the bound is $\mu\ge2\beta\lvert t\rvert$". The first sentence is stale text carrying the refuted constant.

**Batch 19's arithmetic is right under the corrected constant**, rederived here. With $\alpha=\tfrac{15}4$ and $\beta=\tfrac94$, $Q(\mu)=\tfrac{405}{16}t^2+18\mu t+3\mu^2-\tfrac{81}{32}n$. For $t>0$, $\partial_\mu Q=18t+6\mu>0$ on $\mu\ge\tfrac92t$, so the floor is $Q(\tfrac92t)=\tfrac{2673}{16}t^2-\tfrac{81}{32}n$ and $Q\le0$ asks $n\ge66t^2$. For $t<0$ the vertex is at $\mu^\ast=-3t=3\lvert t\rvert<\tfrac92\lvert t\rvert$, so the floor is again at the endpoint, $Q=\tfrac{81}{16}t^2-\tfrac{81}{32}n$, and $Q\le0$ asks $n\ge2t^2$. Both displayed numbers and both thresholds check out, and the conclusion that no contradiction follows is correct.

**Finding, the Lean file types the superseded constant.** [Q_floor](../lean/HamiltonsCubic/Results/I106Criticality.lean) evaluates $q$ at $\mu=\beta t$, giving $81t^2-\tfrac{81}{32}n$ and the threshold $n\ge32t^2$. That is a true identity at an **inadmissible** multiplier: batch 19's corrected floor is at $\mu=2\beta t$ and reads $\tfrac{2673}{16}t^2$ with threshold $n\ge66t^2$. Since $q$ increases in $\mu$ there, $81t^2$ sits below the true floor, which is precisely the failure mode batch 18 diagnosed, a bound stated below the truth that no screen can violate. [lean/INDEX.md](../lean/INDEX.md) repeats the claim as "the floor of $q$ on the degenerate spectrum" without naming the multiplier.

## 3. Batch 20's identity, CONFIRMED

**Both pairings check.** Pairing $3\alpha\hat U^2+\beta V^2+A=3\mu\hat U+c_1I$ with $\hat U$ gives $3\alpha\operatorname{tr}\hat U^3+\beta\operatorname{tr}(\hat UV^2)+\langle\hat U,A\rangle=3\mu\lvert\hat U\rvert^2+c_1\operatorname{tr}\hat U$, and pairing $\beta\{\hat U,V\}+C=\mu V+c_2I$ with $V$ gives $\beta\operatorname{tr}(V\{\hat U,V\})+\langle V,C\rangle=\mu\lvert V\rvert^2+c_2\operatorname{tr}V$. The two undetermined multiples of $I$ drop because $\operatorname{tr}\hat U=\operatorname{tr}V=0$, exactly as claimed, and for no other reason.

**The trace identity is right.** $\operatorname{tr}(V\{\hat U,V\})=\operatorname{tr}(V\hat UV)+\operatorname{tr}(V^2\hat U)=2\operatorname{tr}(\hat UV^2)$ by cyclicity alone, no symmetry needed.

**The substitution.** $\langle\hat U,A\rangle=3\mu\lvert\hat U\rvert^2-3\alpha\operatorname{tr}\hat U^3-\beta\operatorname{tr}(\hat UV^2)$ and $\langle V,C\rangle=\mu\lvert V\rvert^2-2\beta\operatorname{tr}(\hat UV^2)$ sum to $\mu(3\lvert\hat U\rvert^2+\lvert V\rvert^2)-3P_3=2\mu T-3P_3$, using $2T=3\lvert\hat U\rvert^2+\lvert V\rvert^2$. Adding $P_3$ gives $\Phi=2\mu T-2P_3$. Both the boxed identity and the stated linear part are right.

**It holds at every critical point, not only at maximisers.** Only the two Lagrange equations enter, and no second-order or globality input appears anywhere in the derivation. Batch 20 says "at every critical point" and that is the correct scope.

**The Lean statement matches and is not vacuous.** [value_at_critical](../lean/HamiltonsCubic/Results/I106Criticality.lean) carries both Lagrange equations with their own $c_1,c_2$, both tracelessness hypotheses and the definition of $T$, and concludes the identity. Machine-checked witness: $\hat U=\operatorname{diag}(1,1,-2)$, $V=E_{13}+E_{31}$, $\alpha=\beta=\mu=1$, $c_1=c_2=0$, $A=\operatorname{diag}(-1,0,-19)$, $C=2V$, $T=10$. Both hypotheses hold, the pair is genuinely non-commuting since $(\hat UV-V\hat U)_{13}=3$, and both sides of the conclusion equal $34$. So the theorem is neither vacuous in its hypotheses nor trivial in its conclusion.

**One note on the Lean form.** The statement writes $\operatorname{tr}(UA)$ and $\operatorname{tr}(VC)$ rather than $\operatorname{tr}(U^{\mathsf T}A)$ and never uses symmetry of any argument. That is sound, since the two agree on the symmetric matrices the theorem is applied to, and it makes the declaration slightly more general than the prose claim.

## 4. Batch 21's second variation, CONFIRMED, with two unstated steps

**The order-two coefficient is right.** $\operatorname{tr}(\hat U+sX)^3=\operatorname{tr}\hat U^3+3s\operatorname{tr}(\hat U^2X)+3s^2\operatorname{tr}(\hat UX^2)+s^3\operatorname{tr}X^3$, and $\operatorname{tr}\big((\hat U+sX)(V+sY)^2\big)$ has $s^2$ part $\operatorname{tr}(\hat UY^2)+\operatorname{tr}\big(X(VY+YV)\big)$. So the coefficient is $3\alpha\operatorname{tr}(\hat UX^2)+\beta\big(2\operatorname{tr}(XVY)+\operatorname{tr}(\hat UY^2)\big)$ as displayed.

**An unstated step.** $\operatorname{tr}\big(X(VY+YV)\big)=\operatorname{tr}(XVY)+\operatorname{tr}(XYV)$, and $\operatorname{tr}(XYV)=\operatorname{tr}(XVY)$ is **not** cyclicity. It holds because $X,V,Y$ are all symmetric, so $\operatorname{tr}(XYV)=\operatorname{tr}\big((XYV)^{\mathsf T}\big)=\operatorname{tr}(VYX)=\operatorname{tr}(XVY)$. The prose collapses the two orderings without saying why. The Lean docstring on [second_variation_expansion](../lean/HamiltonsCubic/Results/I106Criticality.lean) does name it, so the gap is in the written chain only.

**The tangency form and the factor of two are right.** The norm expands as $T+s\big(3\operatorname{tr}(\hat UX)+\operatorname{tr}(VY)\big)+s^2\big(\tfrac32\lvert X\rvert^2+\tfrac12\lvert Y\rvert^2\big)$, and $g''(0)$ is twice the $s^2$ coefficient, which is what turns $3\alpha,2\beta,\beta$ and $\mu(\tfrac32,\tfrac12)$ into the displayed $6\alpha,4\beta,2\beta$ against $\mu(3\lvert X\rvert^2+\lvert Y\rvert^2)$.

**The acceleration argument is stated correctly.** At a critical point $D(\Phi-\mu T)=0$, so for any curve $\gamma$ on the surface, $\tfrac{d^2}{ds^2}(\Phi-\mu T)(\gamma)=D^2(\Phi-\mu T)[\gamma',\gamma']+D(\Phi-\mu T)[\gamma'']$ loses its second term. Taking $\gamma$ to be the straight line is then legitimate even though the line leaves the surface, because $\Phi-\mu T$ is a polynomial and its second Taylor coefficient along a line is $\tfrac12D^2$ regardless.

**The manifold question, answered and unstated.** The condition does need the constraint set to be a manifold near the point, both for the Lagrange multiplier to exist and for every tangent vector to be realised by a curve. It is automatic here and nowhere said: the constraint gradient is $(3\hat U,V)$, which vanishes only at $(0,0)$, excluded by $T>0$, so the level set is a smooth sphere and every tangent vector is realised. A gap in the writing, with nothing behind it.

**The specialisation is right.** With $Y=0$ and $X=E_{ij}+E_{ji}$, tangency is $3\operatorname{tr}(\hat UX)=0$, true because $\hat U$ is diagonal, and $\operatorname{tr}(\hat UX^2)=u_i+u_j=-u_k$ with $\lvert X\rvert^2=2$, giving $6\alpha(-u_k)\le6\mu$, that is $\mu\ge-\alpha u_k$ for every $k$ and so $\mu\ge\alpha\lvert u_{\min}\rvert$.

**Finding, this bound beats batch 18's on batch 19's own slice, and batch 19 was not updated.** At $u=(t,t,-2t)$ with $t>0$, batch 21 gives $\mu\ge\alpha\cdot2t=7.5t$ while batch 18 gives $\mu\ge2\beta\lvert t\rvert=4.5t$. Batch 19's arithmetic, and its closing remark that the test is recorded "so it is not run twice", both use $4.5\lvert t\rvert$. Recomputing at $7.5t$ moves the floor to $Q=\tfrac{5265}{16}t^2-\tfrac{81}{32}n$ and the threshold to $n\ge130t^2$, which the norm constraint still grants, so **batch 19's conclusion survives** and only its numbers are stale.

## 5. Batch 22's discriminant form, CONFIRMED, with one real gap

**The tangency claim is right.** The tangency form at $(X,Y)=(Z,tZ)$ is $3\operatorname{tr}(\hat UZ)+t\operatorname{tr}(VZ)$, a polynomial of degree one in $t$, so it vanishes for every $t$ exactly when both coefficients vanish, that is $\operatorname{tr}(\hat UZ)=\operatorname{tr}(VZ)=0$.

**The dimension, with the exceptional case identified.** Traceless symmetric $3\times3$ matrices form a five-dimensional space on which the trace form is nondegenerate, so $Z\mapsto\operatorname{tr}(\hat UZ)$ and $Z\mapsto\operatorname{tr}(VZ)$ are independent functionals exactly when $\hat U$ and $V$ are linearly independent, and then $\dim W=3$. The only failure is $V\parallel\hat U$, which is $[\hat U,V]=0$, the commuting case that is settled anyway. So on the stratum batch 22 is aimed at, the subspace is three-dimensional with no exception.

**The coefficients are right**, by substituting $(Z,tZ)$ into the joint condition: $t^2\big(2\beta\operatorname{tr}(\hat UZ^2)-\mu\lvert Z\rvert^2\big)+t\cdot4\beta\operatorname{tr}(VZ^2)+\big(6\alpha\operatorname{tr}(\hat UZ^2)-3\mu\lvert Z\rvert^2\big)\le0$, matching $a$, $b$, $c$ exactly. And $a$ is indeed the $X=0$ case, whose tangency requirement $\operatorname{tr}(VZ)=0$ holds on $W$, while $c$ is three times the $Y=0$ case, whose requirement $\operatorname{tr}(\hat UZ)=0$ also holds on $W$. Both are therefore $\le0$.

**The gap: what is available is $a\le0$, and [disc_of_nonpos](../lean/HamiltonsCubic/Results/I106Criticality.lean) requires $a<0$ strictly.** Nothing on the record rules out $a=0$, which happens exactly when $\mu=2\beta\lambda_{\max}(\mathcal L)$ and $Z$ is a top eigendirection of $\mathcal L$ lying in $W$. Batch 22's own screen reports $\min(-a)=8.8\cdot10^{-4}$, so the boundary is nearly met and the case cannot be waved away.

**The conclusion survives, by an argument not on the record.** If $a=0$ then $bt+c\le0$ for all $t$ forces $b=0$, so $b^2=0=4ac$ and the inequality holds with equality. The boxed inequality is therefore true for every $Z\in W$, but its stated justification covers only part of its range. The repair is two lines and belongs either in the prose or as a second branch in the Lean lemma.

**The division by four is right**, and the sign remark is right: both factors on the right are nonpositive, so their product is nonnegative and the inequality is not vacuous on sign grounds.

## 6. Batch 25's elimination, the algebra CONFIRMED and the reading of it REFUTED

**The divided difference carries no extra factor.** For $q$ of degree two with leading coefficient $A$, $\sum_kq(u_k)/\prod_{m\ne k}(u_k-u_m)=A$ exactly, which is the standard Newton divided difference. Here $A=3\alpha\beta$, free of $\mu$ and of $\lvert V\rvert^2$ because those sit only in the lower coefficients. Screen: the sum evaluates to $3\alpha\beta$ symbolically, with no residue.

**The displayed equation is right, and I reached it by my own route.** Multiplying the divided-difference identity through by $D_1D_2D_3w_1w_2w_3$ and cancelling one $\beta$ gives
$$3\alpha\,w_1w_2w_3D_1D_2D_3=\beta\big[w_2w_3(VKV)_{23}-w_1w_3(VKV)_{13}+w_1w_2(VKV)_{12}\big],$$
the alternating sign on the middle term coming from $\prod_{m\ne2}(u_2-u_m)=-D_1D_3$. Screen: batch 25's displayed bracket minus this combination is identically zero. The $\alpha$-part factorisation is right too, $D_1D_2D_3-(2u_1^3+3u_1^2u_2-3u_1u_2^2-2u_2^3)=0$ on the traceless slice.

**The system it eliminates is faithful.** Screen: with $u_3=-u_1-u_2$ and $a_3=-a_1-a_2$, the commutator $[A,C]$ has zero diagonal, is skew, and each of its three entries equals $(u_i-u_j)V_{ij}q(u_k)-\beta^2(VKV)_{ij}$ on the nose, ratio exactly $1$. Batch 16's regrouping of $(VKV)_{12}$ and batch 16's shared-eigenvector collapse to $3\alpha\beta u_3^2+3\mu(\alpha+\beta)u_3+3\mu^2=\beta^2a_3^2$ also come out exact.

**Yes, the elimination loses solutions, and the loss is not where batch 25 says it is.** It divides by each $w_k$ and by each gap, so it is valid only where the spectrum is simple and **all three** $w_k$ are nonzero. Batch 25 states both hypotheses. What it then says is that the open question is "whether this equation together with those two forces $w_1w_2w_3=0$, **which is commutativity on this stratum**". That last clause is false.

**Commutativity at a simple spectrum is $w_1=w_2=w_3=0$, not $w_1w_2w_3=0$.** By batch 16's own criterion, $\hat U$ and $V$ share an eigenvector exactly when at most one $w_k$ is nonzero, so the stratum with no shared eigenvector is "at least two nonzero" and it strictly contains the case of **exactly two** nonzero. On that sub-stratum $w_1w_2w_3=0$ holds while the pair neither commutes nor shares an eigenvector.

**And that sub-stratum is populated.** Screen, exact and symbolic. Fix the simple spectrum $(u_1,u_2,u_3)=(3,1,-4)$ and set $w_3=0$. The $(1,2)$ equation collapses to $\beta^2w_1w_2(a_1D_2-a_2D_1)=0$, so with $w_1w_2\ne0$ it reads $a_1D_2=a_2D_1$, that is $(a_1,a_2,a_3)=(5s,7s,-12s)$. Taking $w_1=w_2=1$, the remaining two equations in $(s,\mu)$ have **four exact real solutions**, $\mu=-24.4386964721\ldots$ with $s=\pm2.35496436401\ldots$ and $\mu=-6.06130352786\ldots$ with $s=\pm0.317338448339\ldots$, at each of which $[A,C]=0$ identically, the symbolic residual being an exact zero. No $e_k$ is an eigenvector of $V$ there, since every row of $V$ carries a nonzero off-diagonal entry, and $\lVert K\rVert_F=12.166$. **So the criticality system admits non-commuting solutions on the very stratum I106 has left open.**

**What that does and does not mean.** It says nothing against Conjecture A. At all four points $\mu<0$, far below batch 18's necessary $\mu\ge2\beta\lvert\hat U\rvert/\sqrt6=9.367$ and batch 21's $\mu\ge\alpha\lvert u_{\min}\rvert=15$, so none of them is a global maximum and $G(2)$ is untouched. What it refutes is the premise of the route: **the criticality system on its own does not force commutativity**, so no purely first-order argument can close this stratum, and the closure must consume a maximality condition. Batch 25's closing question needs restating before it can be worked.

## 7. Batch 25's count, PLAUSIBLE as a raw count and misleading as a statement of what is owed

**The clean way to see the count.** Where the spectrum is simple and all three $w_k$ are nonzero, each equation solves for one value $q(u_k)=R_k$, with $R_k=\beta^2(VKV)_{ij}/\big((u_i-u_j)w_k\big)$ a function of the **block data alone**. The three equations are therefore equivalent to saying that the interpolating quadratic through $(u_k,R_k)$ is $q$, that is to its three coefficients matching:

| coefficient of $q$ | what the matching equation does |
| --- | --- |
| leading, $3\alpha\beta$ | batch 25's equation, a constraint on the block data |
| linear, $3\mu(\alpha+\beta)$ | **determines $\mu$**, imposing nothing on the block data |
| constant, $3\mu^2-\tfrac12\beta^2\lvert V\rvert^2$ | one further constraint, once $\mu$ is substituted |

**So the raw count is right and the useful one is not.** Three equations produced one combination, and two more are needed to recover the system, which is what batch 25 says. But one of those two only fixes $\mu$, a free unknown, so after the elimination there is exactly **one** further equation binding the block data, not two. That the third line is a genuine constraint rather than a definition is because $\lvert V\rvert^2=\sum a_k^2+2\sum w_k^2$ is itself a function of the block data, so nothing absorbs it.

**Are they independent?** Generically yes. The three interpolation functionals are linearly independent on the coefficients of a quadratic, and the $R_k$ are independent functions of the block data, so no two of the three matchings coincide. I found no defect in the independence claim itself.

**What should be said instead.** "The elimination consumed the three equations to produce one, and what remains unused is one further equation in the block data, obtained by eliminating $\mu$ between the linear and constant coefficients." Batch 25's version overstates the residue by one and so overstates how much is still in hand for the closing question.

## 8. Batch 26's parity, CONFIRMED on the mathematics, with the reason given for it wrong

**The transcription is faithful.** [elimPoly](../lean/HamiltonsCubic/Results/I106Criticality.lean) inlines $u_3=-u_1-u_2$, $a_3=-a_1-a_2$, $D_1=u_1+2u_2$, $D_2=2u_1+u_2$, $D_3=u_1-u_2$, and I checked all five bracket terms and every sign against batch 25's display: $a_1^2D_2+2a_1a_2D_3-a_2^2D_1$, then $a_1D_2-a_2D_1$, then $-(a_3D_1+a_1D_3)$, then $a_3D_2-a_2D_3$, then $w_1^2D_1-w_2^2D_2+w_3^2D_3$. No error.

**The group action is correctly identified, on both generators.** $w_k$ is the entry opposite axis $k$, so it is indexed by the complementary **pair**, and a permutation $\pi$ of the axes sends the pair $\{i,j\}$ to $\{\pi(i),\pi(j)\}$, hence sends $w_k$ to $w_{\pi(k)}$, permuting exactly as $u$ and $a$ do. Flipping $e_1$ conjugates by $\varepsilon=\operatorname{diag}(-1,1,1)$, sending $V_{ij}\mapsto\varepsilon_i\varepsilon_jV_{ij}$, which fixes the diagonal, fixes $w_1=V_{23}$ and flips $w_2=V_{13}$ and $w_3=V_{12}$. Exactly two, as claimed, and that is what [elimPoly_signFlip](../lean/HamiltonsCubic/Results/I106Criticality.lean) states.

**The sign character is real and the statement of it is not vacuous.** Screen, at $\alpha=\tfrac{15}4$, $\beta=\tfrac94$ and $(u_1,u_2,a_1,a_2,w_1,w_2,w_3)=(3,1,1,0,1,1,1)$: `elimPoly` takes the value $765$, the transposed argument list gives $-765$, and the three-cycle and the sign flip both give $765$. So [elimPoly_antisymm](../lean/HamiltonsCubic/Results/I106Criticality.lean) is not the trivial $0=-0$, and the two values are machine-checked in Lean as well. Transpositions negating and three-cycles fixing is the sign character, and "the equation $P=0$ is invariant because a sign does not move a zero set" is correct.

**Correction, the reason given for the symmetry does not hold.** Batch 26 says the generators "are symmetries of the whole setup, since they are conjugations of $\hat U$ and $V$ by signed permutation matrices, which preserve $\Phi$, the norm and the diagonality of the fields". Conjugating $\hat U$ and $V$ while holding $A$ and $C$ fixed does **not** preserve $\Phi$, and the permutation being applied acts on $\hat U$'s eigenframe, which is not the frame $F$ in which $A$ and $C$ are diagonal. The correct reason is reparametrisation: $(u,a,w)$ are coordinates for the pair $(\hat U,V)$ relative to a **choice** of ordered, signed orthonormal eigenbasis of $\hat U$, and batch 25's equation expresses a frame-free condition on the pair, so it must be equivariant under any change of that choice. The conclusion stands on that reason and not on the one given.

**A smaller correction.** "S_3 times the sign flips" describes the group as a direct product. The group generated is the signed permutations modulo $\pm I$, a semidirect product $(\mathbb Z/2)^2\rtimes S_3$, since permuting the axes permutes which $w$ a given flip acts on.

**The three false alarms are handled correctly.** A numerator obtained by cancelling a rational function is defined only up to a unit, so comparing numerators is not well posed, and the ratio of the two equations is. Fixing the explicit polynomial and substituting into it is the well-posed test. The retraction of the earlier draft's claim that the sign was an artefact of the numerator convention is right: the antisymmetry is a property of the polynomial, as the Lean declarations now show.

## 9. Batches 23 and 24, PLAUSIBLE, with one overstatement in each

**Batch 23's spectrum is right.** $\mathcal L_V$ on traceless symmetric matrices has the three off-diagonal eigenvalues $-v_k/2$ and the two diagonal-plane eigenvalues $\pm\lvert V\rvert/\sqrt6$, by the computation of item 2 with $V$ in place of $\hat U$. The interlacing step is right too: $W$ has codimension two, so $\lambda_{\max}(\mathcal L_V\vert_W)=\lambda_1(\mathcal L_V\vert_W)\ge\lambda_3(\mathcal L_V)$.

**But "pinned near zero by construction" is an overstatement, and the sharp bound is worth having.** Write $\lambda=\lvert V\rvert/\sqrt6$. The three numbers $-v_k/2$ sum to zero and are bracketed by $\pm\lambda$, by the same gap identity applied to $V$, so the median of the five is the median $y$ of those three. Maximising $y$ subject to $x+y+z=0$, $x^2+y^2+z^2=\tfrac32\lambda^2$ and $z\le y\le x$ gives $x=y$, $z=-2y$ and $y=\lambda/2$. So
$$\lvert\lambda_3(\mathcal L_V)\rvert\ \le\ \tfrac12\lambda_{\max}(\mathcal L_V),$$
attained at $v\sim(-s,-s,2s)$. Half the unrestricted maximum is not "near zero", and the honest structural statement is that the interlacing lower bound cannot exceed half the unrestricted value while the cap it must beat is of the same order.

**And "the wrong direction of bound" is the wrong diagnosis.** A lower bound on $\lambda_{\max}(\mathcal L_V\vert_W)$ is exactly the right direction to contradict an upper cap on it. What fails is the **magnitude**, not the direction: the bound is at most $\lambda_{\max}/2$, and often negative, while the cap runs over $[0.59,1.16]$. The route is dead, and the measured numbers plus the bound above carry that, but the sentence "it is not accidentally slack, it is the wrong direction of bound" misnames the defect.

**Batch 24's algebra is right.** For skew $K$ and symmetric $M$, $[K,M]^{\mathsf T}=M^{\mathsf T}K^{\mathsf T}-K^{\mathsf T}M^{\mathsf T}=-MK+KM=[K,M]$, so $Z_1=[K,\hat U]$ is symmetric, it is traceless as a commutator, and $\operatorname{tr}(\hat UZ_1)=\operatorname{tr}(\hat UK\hat U)-\operatorname{tr}(\hat U^2K)=0$ by cyclicity.

**Batch 24's scope is correctly drawn.** The reduction is right: batch 22's cap holds for every $Z\in W$, so only the maximum over $W$ can contradict it, and that maximum is $\lambda_{\max}(\mathcal L_V\vert_W)$ whatever $Z$ one writes down. Refuting an inequality of the form "large commutator implies large $\operatorname{tr}(VZ^2)$ somewhere on $W$" needs **one** counterexample, so sampling generic pairs is the right instrument for this particular claim, and the batch states its limits explicitly, that the inequality is not shown useless and that a proof consuming the criticality equations is not ruled out.

**One clause overreaches.** "What is refuted is the route that would have worked for any pair, which is the only thing the second-order condition by itself can supply." The second-order condition at a critical point carries $\mu$, and $\mu$ is constrained by criticality through batches 18 and 21, so a second-order argument is not confined to pair-generic statements. The conclusion that the discriminant line is closed does not depend on that clause.

**A caution that item 6 adds.** Batch 24's consolation, that a proof "consuming the criticality equations" remains open, is now narrower than it reads: the criticality equations admit non-commuting solutions on the open stratum, so consuming them is necessary and cannot by itself be sufficient.

## 10. Batch 27's block, the cost claim CONFIRMED and the payoff claim REFUTED

**The cost claim is honest.** The cap was fixed before the run, the outcome is reported as information about cost alone, and the correct conclusion is drawn, that non-termination says nothing about whether non-commuting critical points exist. The decision to stop rather than to start the symbolic-spectrum version is right under the standing footing, since that run is strictly harder than the one that already failed to terminate and its cost is therefore not predictable.

**The saturation is set up correctly.** Adjoining $t$ with $tw_1w_2w_3-1$ is the standard Rabinowitsch trick, and it does turn "no solution with $w_1w_2w_3\ne0$" into an ideal membership question. A basis $\{1\}$ does mean the ideal is the whole ring, hence no solution over the algebraic closure, hence none over $\mathbb R$. That much is right.

**What is refuted is what such a basis would have bought.** Batch 27 says "a Groebner basis equal to $\{1\}$ would say no non-commuting critical point exists". It would say **no critical point with all three $w_k$ nonzero exists**, which is strictly less. By batch 16's own criterion the non-commuting stratum with no shared eigenvector is "at least two $w_k$ nonzero", and the sub-stratum with exactly two is untouched by the saturation. Item 6 exhibits four exact real critical points in that sub-stratum at the simple spectrum $(3,1,-4)$, so the case the formulation drops is **populated**, and the advertised payoff would not have been delivered even had the run terminated with $\{1\}$.

**A second, smaller overstatement.** "A non-trivial basis would hand over the solutions explicitly, to be tested for global maximality." A lexicographic basis gives a triangular form one can solve only when the ideal is zero-dimensional, and its zeros are complex, whereas only the real ones are critical points. A non-trivial basis is the beginning of that work, not the delivery of it.

**A bounded probe of my own, reported as a screen and deciding nothing.** At the same spectrum $(3,1,-4)$ with $w_1=w_2=w_3=1$ held fixed, the three equations become three polynomials of degree two in $(a_1,a_2,\mu)$, whose lexicographic basis is non-trivial, of three elements, with no real solution in those three unknowns. This fixes $w$, which the real question leaves free, so it bears on neither outcome. I record it only so it is not run again.

**What the item should say.** The question worth asking is whether the system admits a solution with **at least two** $w_k$ nonzero. Item 6 answers it: yes, and explicitly. So the Groebner run, whatever its cost, is no longer the decision procedure the plan wants, and the item's block should be rewritten around the maximality condition rather than around criticality alone.

## 11. The Lean file, PLAUSIBLE, sound in the kernel and overstated in three rows

**Axioms and `sorry`, clean.** `lake build HamiltonsCubic.Results.I106Criticality` exits $0$, and `#print axioms` on each of the twenty theorems returns exactly `[propext, Classical.choice, Quot.sound]`. No `sorryAx` anywhere. The file carries twenty theorems and three definitions, `Um`, `Vm` and `elimPoly`, and the brief's table names twenty-one declarations, which matches once the two matrix constructors are set aside.

**Nothing is vacuous, and three witnesses are machine-checked.** All three were built against the compiled file and compile without error:

| declaration | witness | why it is not vacuous |
| --- | --- | --- |
| [value_at_critical](../lean/HamiltonsCubic/Results/I106Criticality.lean) | $\hat U=\operatorname{diag}(1,1,-2)$, $V=E_{13}+E_{31}$, $A=\operatorname{diag}(-1,0,-19)$, $C=2V$, $\alpha=\beta=\mu=1$, $T=10$ | both Lagrange hypotheses hold, the pair is non-commuting with $(\hat UV-V\hat U)_{13}=3$, and both sides equal $34$ |
| [disc_of_nonpos](../lean/HamiltonsCubic/Results/I106Criticality.lean) | $a=-1$, $b=2$, $c=-1$, with $-t^2+2t-1=-(t-1)^2\le0$ | $b\ne0$ and the conclusion $4\le4$ is attained, so the bound is tight and not a sign triviality |
| [elimPoly_antisymm](../lean/HamiltonsCubic/Results/I106Criticality.lean) | $\alpha=\tfrac{15}4$, $\beta=\tfrac94$, $(3,1,1,0,1,1,1)$ | the value is $765$ and the transposed value $-765$, so the statement is not $0=-0$ |

**`elimPoly` transcribes batch 25's equation without error**, gaps inlined, checked term by term in item 8.

**Finding A, the module docstring is stale and contradicts its own file.** The header says "batches 15 to 19", the "What is proved" list names only seven declarations, and it closes with "**Not typed**: batch 17's pairing with `K`" while `paired_identity`, which is exactly that pairing, sits at the bottom of the same file. The file now types material from batches 15 to 26.

**Finding B, `Q_floor` types the superseded constant.** It evaluates $q$ at $\mu=\beta t$, the halved bound batch 18 withdrew, and reports the threshold $n\ge32t^2$ where batch 19's corrected arithmetic gives $\tfrac{2673}{16}t^2$ and $n\ge66t^2$. True identity, inadmissible multiplier. Detail in item 2.

**Finding C, batch 18's constant is not typed at all.** [mu_ge_of_rayleigh](../lean/HamiltonsCubic/Results/I106Criticality.lean) assumes the factor of two as the hypothesis `hso`, and no declaration computes the diagonal block's Rayleigh ratio, so the value $\lambda_{\max}(\mathcal L)=\lvert\hat U\rvert/\sqrt6$ is nowhere in the kernel. [jordan_gap](../lean/HamiltonsCubic/Results/I106Criticality.lean) and [jordan_gap_le](../lean/HamiltonsCubic/Results/I106Criticality.lean) prove the domination $3u_3^2\le2\lvert\hat U\rvert^2$ and nothing about the value, so the brief's row "putting the Jordan top eigenvalue on the diagonal block" claims more than the declarations deliver.

**Finding D, `w1_zero_forces` is spectrum-specific and is credited generally.** Its hypothesis `hi` is batch 19's equation (i), which arises only on the degenerate spectrum, where $D_3=0$ makes the $(1,2)$ equation lose its $q$ term. The brief's table and the docstring both credit it to "batches 16 and 19", but batch 16 proves no such exclusion, and on a **simple** spectrum the $(1,2)$ equation is not (i) at all. Item 6's exact solutions with $w_3=0$ and $w_1w_2\ne0$ at the spectrum $(3,1,-4)$ show the exclusion genuinely fails once the spectrum is simple. This is the row whose overstatement matters most, because the conclusion drawn from it, that two nonzero entries force $w_1w_2\ne0$, is what makes "all three nonzero" look like the whole open case.

**Finding E, minor.** [offdiag_rayleigh](../lean/HamiltonsCubic/Results/I106Criticality.lean) is stated for `Um u₁ u₂ u₃` with $u_3$ never appearing in the conclusion, so it carries no tracelessness, while the docstring's step "so it gives $\mu\ge-\beta u_3$" needs $u_1+u_2+u_3=0$, which is not a hypothesis of the declaration.

**One note on `second_variation_expansion`.** It takes the step at $s=1$ and groups the terms by hand into four blocks. That is an algebraic identity rather than a Taylor statement, and the reader must supply the separate homogeneity of each block in $(X,Y)$ to read it as the expansion. The docstring says so, which is the right place for it.

## 12. Scope across the record, CONFIRMED, with two stale rows

**Nothing claims either node closed, and that is right.** [plan.md](../plan.md)'s I106 item lists as **Open** "$G(2)$ on the stratum where the two free blocks share no eigenvector of the field frame, then the induction from $G(2)$ to $G(m)$", and records the item as BLOCKED. [lean/INDEX.md](../lean/INDEX.md)'s row closes with "**Owed**: any statement about maximisers, which is where the open question lives and which none of these identities reaches". Batch 25 and batch 26 each say in their own words that what they produce settles nothing on its own. I found no sentence anywhere in this body of work claiming $G(2)$ or the $\lvert J\rvert=3$ step is closed.

**Stale row one, the batch range.** [lean/INDEX.md](../lean/INDEX.md) opens its I106 row with "it types the claims of [batches 15 to 19]" and then, in the same row, describes `value_at_critical` from batch 20, `second_variation_expansion` and `constraint_expansion` from batch 21, `disc_of_nonpos` from batch 22, `alpha_part_factors` from batch 25 and the four `elimPoly` declarations from batch 26. The range should read 15 to 26. The file's own module docstring carries the same stale range and additionally declares batch 17's pairing "not typed" while proving it, per item 11.

**Stale row two, and this one is substantive.** [plan.md](../plan.md) records "**The route chosen 2026-09-16 is to solve that system directly with at least two $w_k$ nonzero**", and then records the block as "deciding whether it admits a solution with $w_1w_2w_3\ne0$". Those are not the same question. The route as stated covers "at least two nonzero"; the route as executed in batches 25 to 27 covers only "all three nonzero", because the elimination divides by every $w_k$. The gap between them is the exactly-two-nonzero sub-stratum, which shares no eigenvector, does not commute, and is **populated** by the four exact solutions of item 6. The plan's I106 item should record that the executed route is narrower than the chosen one, and that the missing case is non-empty.

## Summary

**Verdict.** The algebra of batches 15 to 26 is sound. I rederived every identity under attack and found no arithmetic error in any of them, including batch 18's corrected factor of two, batch 19's two thresholds, batch 20's value identity, batch 21's second variation, batch 22's coefficients, batch 25's divided difference and displayed equation, and batch 26's sign character. The Lean file is kernel-clean, on standard axioms, with no `sorry` and nothing vacuous.

**What breaks is not a computation but a reading.** Batch 25 identifies $w_1w_2w_3=0$ with commutativity on the open stratum, and batch 27 builds its saturation and its advertised payoff on that identification. It is false. By batch 16's own criterion the open stratum is "at least two $w_k$ nonzero", and the exactly-two sub-stratum is non-empty: at the simple spectrum $(3,1,-4)$ with $w_3=0$ and $w_1=w_2=1$ there are four exact real critical points. **The criticality system does not force commutativity**, so no purely first-order argument closes this node, and the Groebner run batch 27 is blocked on would not have decided the question even had it terminated.

**Conjecture A is untouched by that.** All four exhibited points have $\mu<0$, far below batch 18's necessary $9.367$ and batch 21's $15$ at that spectrum, so none of them is a global maximum.

**Ranked corrections owed.**

1. Batch 25's clause "which is commutativity on this stratum", and batch 27's "would say no non-commuting critical point exists", both withdrawn and restated around "at least two nonzero".
2. `w1_zero_forces` re-scoped to the degenerate spectrum, and its credit to batch 16 removed.
3. `Q_floor` restated at $\mu=2\beta t$, or labelled as the withdrawn constant.
4. Batch 22's $a=0$ branch added, since `disc_of_nonpos` needs $a<0$ strictly.
5. Batch 18's equality clause restricted to $t>0$, and batch 19's opening restated with the sharp constant.
6. Batch 26's reason for the symmetry replaced by reparametrisation equivariance.
7. Batch 25's residue corrected from two equations to one.
8. Batch 23's "pinned near zero" replaced by $\lvert\lambda_3\rvert\le\tfrac12\lambda_{\max}$, and "wrong direction" by "insufficient magnitude".
9. The stale batch ranges in [lean/INDEX.md](../lean/INDEX.md) and the module docstring.
