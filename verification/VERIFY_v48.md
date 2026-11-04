# VERIFY v48, Lemma L145: the $\Theta$ is one-sided, the box carries no dimension hypothesis and fails at $S^2\times S^2$ and $S^3\times S^3$, and the $n^{-3/2}$ step is an uncomputed infimum

*Verifier v48, cold brief, [ROUND_L145](ROUND_L145.md), source [findings/second-order.md](../findings/second-order.md):1098–1124. **No numerical work was done**: no script was run, and every value below is an exact hand evaluation from closed forms the record itself states. Log: [agent_logs/verify-L145-v48.log](../agent_logs/verify-L145-v48.log).*

## Claim table

| # | claim as written in L145 | verdict |
|---|---|---|
| C1 | box: at $W^*=S^m\times S^m$, $n=2m$, the tube radius is $r_n=\Theta(n^{-3/2})$ | **HYPOTHESIS-DEBT**, the upper half has no argument anywhere on the record, and the entry's own step-4 row withdraws it |
| C2 | the box's quantification over $m$ (no dimension hypothesis is stated) | **BROKEN at $m=2$ and $m=3$**, $r_4=r_6=0$ in closed form; correct hypothesis is $m\ge5$ (equivalently even $n\ge10$), and the programme's own range is $n\ge12$ |
| C3 | step 1: the spectrum is two-valued with no kernel and $g_n=\lvert\lambda_-\rvert=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}=\Theta(1/n)$ | **REPRODUCED**, derived cold below from trace-freeness and $\mathop{\mathrm{tr}}(W^2)=1$ |
| C4 | step 2: $W\mapsto W_-$ is analytic on the ball of radius $g_n$ in the record's Frobenius norm, with complex radius $\rho<g_n/2$ | **REPRODUCED**, and the strictness correction is right |
| C5 | step 3: $C_\delta=O(n)$, from $M=O(g_n)$, $\lVert A^{(k)}\rVert=O(n^{k-1})$ and $(\delta^2)'''=2\langle A''',A\rangle+6\langle A'',A'\rangle$ with $\mathrm{Alt}(W^*_-)=0$ | **ARITHMETIC REPRODUCED; GAP in what it establishes**, the vanishing is shown at the base point only, and a third-order remainder constant needs a bound on the segment |
| C6 | step 4: $r_n=\Omega(n^{-3/2})$, being $\inf_H c(H)/C(H)$ | **HYPOTHESIS-DEBT**, no derivation in the entry; the infimum is named and never computed; the chain as written yields only $\Omega(n^{-2})$ |
| C7 | the three exponents $n^{-4}$, $n^{-2}$, $n^{-3/2}$ are three different quantities | **PROVEN, and it is the entry's best paragraph**, the ordering $\inf_H c/C\ge c_n/\sup_H C$ is the right way round |
| C8 | the norm-spending paragraph: $\sqrt{\binom n2}\asymp1/g_n$, $M=O(1)\Rightarrow A'''=O(n^3)\Rightarrow r_n=n^{-4}$ | **REPRODUCED exactly**, the ratio is $\sqrt{n/(n-2)}$, which is $\sqrt{6/5}$ at $n=12$ |
| C9 | the per-direction-to-neighbourhood trap is not committed; geodesic segments fill the tube | **NO FINDING**, the conclusion holds; the stated reason is half of the reason |
| C10 | "$\Theta(n^{-1})$ is reachable" | **CONTRADICTS THE ANCESTOR PARAGRAPH** at [second-order.md](../findings/second-order.md):973, and is reconciled only by [Lemma L146](../findings/second-order.md), which post-dates L145 |
| C11 | [results.md](../results.md) carries no L145 entry | **THE ABSENCE IS CORRECT for the statement as written**, and incorrect for what survives |
| C12 | [findings/INDEX-results.md](../findings/INDEX-results.md):164 records the headline as "$\Theta(n^{-3/2})$ … Gate 2 passed" | **BROKEN**, the index carries a claim the entry it indexes withdraws |

**One line the round can act on:** L145 proves a constant chain and does not prove its own headline, the upper half of the $\Theta$ is withdrawn inside the entry and argued nowhere, the lower half of $n^{-3/2}$ is an infimum the entry names but never computes (its written chain gives $n^{-2}$), and the box needs $m\ge5$ written into it because it is false at $S^2\times S^2$ and $S^3\times S^3$.

## 0. Conventions, fixed once

- **The norm.** $\lVert W\rVert^2=\mathop{\mathrm{tr}}(W^2)=\sum_\alpha\lambda_\alpha^2$ over the $\binom n2$ eigenvalues of $W$ as an operator on $\Lambda^2\mathbb R^n$, at unit norm equal to $1$, [findings/conventions.md](../findings/conventions.md):122. This is the normalisation every value below is read in, and it is the one L145's $g_n$ needs.
- **$\theta_0(n)$.** $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$. Fixed in this report by three independent checks against the record: it gives $\theta_0(6)^2=10/9$, the value [findings/nondegeneracy.md](../findings/nondegeneracy.md):546 records at $S^3\times S^3$; it gives $\theta_0(n)=\sqrt{3/2}$ exactly at $n^2-12n+8=0$, i.e. $n=6+2\sqrt7$, the threshold [results.md](../results.md) states; and with $c_p=3\theta_0/(n-2)$ it gives $\kappa=nc_p=3\sqrt{2(n-1)/(n-2)}$, the constant [Lemma L158](../results.md) states.
- **$\kappa_n=9(\sqrt{3/2}-\theta_0(n))$**, from [I4](../plan.md). It is negative exactly for $n>6+2\sqrt7$.
- **The blocks at $W^*$.** $\mathbb R^n=V_1\oplus V_2$ with $\dim V_i=m$; $\Lambda^2=\Lambda^2V_1\oplus\Lambda^2V_2\oplus(V_1\wedge V_2)$ of dimensions $\binom m2,\binom m2,m^2$.
- **$\mathrm{Alt}$** is the first-Bianchi alternation; $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$; $A(t)=\mathrm{Alt}(W(t)_-)$.
- **$M$.** L145 uses $M$ for the Cauchy supremum $\sup_{\lvert z\rvert=\rho}\lVert A(z)\rVert$. [findings/conventions.md](../findings/conventions.md):122 already warns that $M$ carries two objects whose norms differ by $\sqrt2$; this is a third, and the entry does not say so.
- **$c_n$ and $c_p$ are one quantity under two names.** [second-order.md](../findings/second-order.md):955 writes $c_n=3\theta_0/(n-2)$; [Lemma L146](../findings/second-order.md) writes "L145's $c_p$: $3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$". L145 uses $c_n$ in one paragraph and $c_p$ in another without saying they are the same number.

## The hypothesis inventory

**Hypotheses the statement carries, as written.** Exactly two: the base point is $W^*=S^m\times S^m$, and $n=2m$. Nothing else, no lower bound on $m$, no $n\ge12$, no $\lVert W^*\rVert=1$, no definition of "tube radius", no definition of $c(H)$, $C(H)$, $C_\delta$, $c_n$, $c_p$, $M$ or $A$.

**Hypotheses the written proof actually uses, and where each is checked.**

| input | needed for | stated in L145? | holds at the object? |
|---|---|---|---|
| $\lVert W^*\rVert=1$ in the $\Lambda^2$ operator norm | the numeral $g_n$ | no | yes, by convention |
| trace-freeness of $W^*$ on $\Lambda^2$ | $\lambda_+/\lvert\lambda_-\rvert=m/(m-1)$, hence $g_n$ | no | yes, $\mathrm{Ric}(W)=0$ gives $\mathop{\mathrm{tr}}_{\Lambda^2}W=0$ |
| $m\ge2$, so that both blocks are non-empty | the two-valued spectrum | no | fails at $m=1$; vacuous there |
| spectral gap at $0$, i.e. $\ker W^*=0$ | analyticity of $W\mapsto W_-$ | **yes**, and correctly | yes at $W^*$; **fails at $W_{\mathbb{CP}^2}$**, see §5 |
| $\mathrm{Alt}$ annihilates Bianchi tensors | $\mathrm{Alt}(W^*_-)=0$ | yes, by naming "three Bianchi tensors" | yes, verified in §4 |
| $\lVert ABC\rVert_2\le\lVert A\rVert_\infty\lVert B\rVert_2\lVert C\rVert_\infty$ | $M=O(g_n)$ | yes | yes, the Frobenius norm is unitarily invariant |
| [Lemma L27](../findings/nondegeneracy.md) and [Lemma L26](../findings/nondegeneracy.md): where the off-orbit margin sits, and its value | $c_p=3\theta_0/(n-2)$, hence every quotient in the chain | **no, cited nowhere in the entry** | **needs $m\ge5$**, see §2 |
| [Lemma L133](../findings/second-order.md)'s support table: $D(\mathrm{Alt}\,W_-)[H]=0$ on pair blocks | that margin and remainder do not bind together | **no** | yes, and it is what [post F60](../findings/second-order.md) turns on |
| a bound on $\sup\lvert P\rvert$ | step 4's exponent | **no** | [Lemma L107](../findings/bounds.md) gives $\le n-1$, [Lemma L143](../findings/bounds.md) gives $\le1+\sqrt{n-2}$; **the two give different exponents**, see §6 |
| $\kappa_n<0$, i.e. $n>6+2\sqrt7$ | that $\Phi=P-\kappa_n\delta^2$ is the object the tube is about | **no** | fails at $n=4,6,8,10$ |
| uniformity of $c(H)/C(H)$ over the normal sphere | the infimum in step 4 | asserted, not derived | **repaired only at [Lemma L149](../findings/second-order.md)**, which post-dates L145 |

**No finding on one head:** the proof uses no hypothesis about the *direction* $H$ beyond $\lVert H\rVert=1$, which is what the trap box claims, and I could not find a place where it silently uses more.

## 1. The two pre-registered questions, answered first

### 1.1 Is $\Theta(n^{-3/2})$ proved in both directions? No, and the entry distinguishes them, then states the undistinguished form in its box.

- **Lower, $r_n=\Omega(n^{-3/2})$.** Claimed, marked "CONFIRMED as a lower bound", derived nowhere in the entry. §6 shows what the entry's own chain yields instead.
- **Upper, $r_n=O(n^{-3/2})$.** Nothing in the entry argues it. The step-4 row says in terms: *"The equality reading is withdrawn … and $\Theta(n^{-1})$ is reachable"*. So the entry asserts a two-sided bound in its box and retracts the second side four lines below it.
- **Does the entry distinguish them?** In the table, yes, explicitly. In the box, no. The box is what [findings/INDEX-results.md](../findings/INDEX-results.md):164 propagated and what eight later entries inherited.
- **What the constant chain actually establishes.** A lower bound and nothing else. Every ingredient ($g_n$, the analyticity ball, $M$, $\lVert A^{(k)}\rVert$, $C_\delta$), is an upper bound on a denominator or a lower bound on a numerator, so the chain can only push $r_n$ up. An upper bound on $r_n$ would need a *witness direction* along which the inequality fails just past $n^{-3/2}$, and the entry exhibits none.

### 1.2 What does L145 need from L146–L158?

**Three things, and they are not decoration.**

1. **Its step-4 withdrawal is L146's.** The row reads "*The equality reading is withdrawn: [Lemma L146] removes its support*". The withdrawal of a claim by a later entry is sound in file order (a later entry may remove support) so this is a *dependency*, not a circularity.
2. **Its closing box is L146's outright**: "DECIDED BY LEMMA L146, FOR r446". L145 as printed does not resolve its own recorded disagreement.
3. **Its uniformity over directions is L149's.** [plan.md](../plan.md) I33 records that the infimum over the mixed directions is what "nothing prices", and that L149 is where "*the quantifier error is gone*". The object L145 names in its key sentence ($\inf_H c(H)/C(H)$), is therefore not known to be $\Theta(n^{-3/2})$ at the time L145 states it.

**What L145 stands on alone**, with no later entry: the spectrum and $g_n$ (§3); the analyticity ball and its strictness (§4); the identity $(\delta^2)'''=2\langle A''',A\rangle+6\langle A'',A'\rangle$ with $\mathrm{Alt}(W^*_-)=0$ and the Cauchy orders $\lVert A^{(k)}\rVert=O(n^{k-1})$, hence $C_\delta=O(n)$ *at the base point* (§4); the three-exponent distinction (§6); and the observation that margin and defect response live on orthogonal $L_e$-eigenspaces, which it inherits from [post F60](../findings/second-order.md) rather than proves. **Nothing else.** In particular the headline number is not among them.

**No circularity found.** L146–L158 cite L145; L145's *positive* content cites none of them. The dependencies run only through the withdrawal and the decision box, both of which weaken L145 rather than support it.

## 2. Discrepancy D1, the box carries no dimension hypothesis, and it is false at two named objects

**Locate.** [findings/second-order.md](../findings/second-order.md):1102, "*At the balanced product $W^*=S^m\times S^m$, $n=2m$, the penalised functional's tube radius about $SO(n)\cdot W^*$ is $r_n=\Theta(n^{-3/2})$.*" There is no restriction on $m$ in the box, in the migration note, or anywhere in the entry.

**Exhibit, in closed form, at two named objects.** [Lemma L26](../findings/nondegeneracy.md) gives the dangerous eigenvalue of the two-block spectrum as $\mu=\dfrac{n-2}{2(p-1)(q-1)}$. At the balanced product $p=q=m$, $n=2m$:
$$\mu=\frac{2m-2}{2(m-1)^2}=\frac1{m-1}.$$
The off-orbit margin in the entry's own currency is $c(H)=3\theta_0\big(\tfrac12-\lambda(H)\big)$ with $\lambda(H)$ the $L_e$-eigenvalue of the normal direction, and $\mu$ is an $L_e$-eigenvalue on a direction outside the orbit ([Lemma L27](../findings/nondegeneracy.md), $+\mu$ on $\Lambda^2\otimes\Lambda^2$).

- **$m=3$, $n=6$, $W^*=S^3\times S^3$.** $\mu=\tfrac1{3-1}=\tfrac12$ exactly. So there is a direction normal to the orbit carrying the orbit's own eigenvalue: $c(H)=3\theta_0(\tfrac12-\tfrac12)=0$, hence $\inf_H c(H)/C(H)=0$ and $r_6=0$, against the box's $\Theta(6^{-3/2})>0$. This is not an artefact of my reading: [findings/nondegeneracy.md](../findings/nondegeneracy.md):442 states the same fact ("*at $(3,3)$, $\mu=\tfrac12$ and the point is degenerate*") and line 546 adds that $S^3\times S^3$ "*is not a local maximum either, by Lemma L3 at cubic order*", so the tube radius is $0$ for a second, independent reason.
- **$m=2$, $n=4$, $W^*=S^2\times S^2$.** $\mu=\tfrac1{2-1}=1>\tfrac12$, so $c(H)=3\theta_0(\tfrac12-1)=-\tfrac32\theta_0<0$: the second variation is strictly *positive* on a normal direction, and no tube of any positive radius exists. Again the record agrees at [findings/nondegeneracy.md](../findings/nondegeneracy.md):442, "*at $\min(p,q)=2$, $\mu>\tfrac12$*".

**Where the true floor is, exactly.** [Lemma L27](../findings/nondegeneracy.md) gives $\tfrac12-\mu=\dfrac{(p-2)(q-2)-1}{2(p-1)(q-1)}$, which at $p=q=m$ is $\dfrac{(m-2)^2-1}{2(m-1)^2}=\dfrac{m-3}{2(m-1)}$, while the margin on the $S^2_0$ summands is $\tfrac12-\lambda_m=\dfrac1{2(m-1)}=\dfrac1{n-2}$ with $\lambda_m=\dfrac{m-2}{2(m-1)}$. The minimum of the two is $\dfrac{1}{n-2}$ exactly when $m-3\ge1$, i.e. $m\ge4$; the two are equal at $m=4$ and the $S^2_0$ branch is strictly smaller from $m=5$. **So $c_p=3\theta_0/(n-2)$ (the constant the whole chain runs on), is the correct margin only for $m\ge4$, and is the strict minimum only for $m\ge5$**, which reproduces by hand the $m\ge5$ that [Lemma L146](../findings/second-order.md) states and L145 does not.

**Argue the opposite.** The most charitable reading is that the programme's standing range is $n\ge12$: [I2](../plan.md) states its theorem "for every $n\ge12$", [Lemma L133](../findings/second-order.md) clears $\kappa_n$ "for every $n\ge12$", and $\kappa_n<0$ only above $n=6+2\sqrt7$. On that reading the box is true in its intended domain and the defect is an omitted hypothesis rather than a false theorem. **I accept that reading, and the finding stands as an omitted hypothesis**, because eight later entries inherited the box, because its two sibling entries carry *three different floors* ($m\ge3$ at L146, none at L145, $m\ge6$ at L149), and because a statement whose constants are silently invalid at four admissible-looking dimensions is not one a reader can check.

## 3. Step 1, $g_n$, reproduced cold

Two-valued spectrum: $\lambda_-$ on the $m^2$ mixed planes $V_1\wedge V_2$ and $\lambda_+$ on the $m(m-1)$ in-block planes, which is what the entry's own $W^*_-=\lvert\lambda_-\rvert(\mathrm{id}-P_{\Lambda^2V_1}-P_{\Lambda^2V_2})$ asserts. Trace-freeness on $\Lambda^2$:
$$m^2\lambda_-+m(m-1)\lambda_+=0\quad\Longrightarrow\quad \frac{\lambda_+}{\lvert\lambda_-\rvert}=\frac{m}{m-1}>1 .$$
Unit norm, $\sum_\alpha\lambda_\alpha^2=1$, with $g:=\lvert\lambda_-\rvert$:
$$m^2g^2+m(m-1)\frac{m^2}{(m-1)^2}g^2=m^2g^2\Big(1+\frac m{m-1}\Big)=m^2g^2\,\frac{2m-1}{m-1}=1,$$
$$g=\frac1m\sqrt{\frac{m-1}{2m-1}}\;\overset{m=n/2}{=}\;\frac2n\sqrt{\frac{n-2}{2(n-1)}} .$$
**Exactly the entry's formula.** Consequences I could check: $\lambda_+>\lvert\lambda_-\rvert$, so the distance from the spectrum to $0$ is $g_n$ and "no kernel" holds; $g_n\to\sqrt2/n$, so $g_n=\Theta(1/n)$; and the corroborating $D=\tfrac{2m-1}{m-1}=(\lambda_+ +\lvert\lambda_-\rvert)/\lvert\lambda_-\rvert$ that [Lemma L156](../results.md) uses is the same computation. At $n=12$, $g_{12}=\sqrt{55}/66$ exactly. **Reproduced; no finding.**

## 4. Steps 2 and 3, what the arithmetic gives, and the one thing it does not

**The analyticity ball.** $W\mapsto W_-$ is analytic while no eigenvalue crosses $0$; Weyl's inequality gives that for $\lVert E\rVert_{op}<g_n$, and $\lVert E\rVert_{op}\le\lVert E\rVert_F$ puts the Frobenius ball of radius $g_n$ inside it. **The entry's own sentence "on the input side nothing is lost" is this inequality, used in the correct direction.** The reviewer's correction $\rho<g_n/2$ rather than $\rho=g_n/2$ is right: with a contour at distance $g_n/2$ from $\lambda_-$ the Neumann series needs $\lvert z\rvert\lVert H\rVert_{op}<g_n/2$ strictly. **Candidate withdrawn:** I considered charging an inconsistency between the ball of radius $g_n$ and the disc of radius $g_n/2$; withdrawn, because the first is in $W$-space and the second in $z$-space with a contour interposed, and the two are compatible.

**$\mathrm{Alt}(W^*_-)=0$, checked independently.** $\mathrm{id}_{\Lambda^2}$ is the curvature operator of the constant-curvature tensor $\tfrac12 g\owedge g$ and $P_{\Lambda^2V_i}$ that of $\tfrac12 g_i\owedge g_i$; each satisfies the first Bianchi identity, so $\mathrm{Alt}$ annihilates each, hence their combination. **The entry's parenthesis (that this is genuinely about $W^*_-$ and not merely about $W^*$), is correct and is the sharpest observation in the entry.**

**The Leibniz identity.** With $\delta^2=\langle A,A\rangle$: $(\delta^2)'=2\langle A',A\rangle$, $(\delta^2)''=2\langle A'',A\rangle+2\langle A',A'\rangle$, $(\delta^2)'''=2\langle A''',A\rangle+2\langle A'',A'\rangle+4\langle A'',A'\rangle=2\langle A''',A\rangle+6\langle A'',A'\rangle$. **Exactly as printed.**

**The Cauchy orders.** With $\rho=\Theta(g_n)=\Theta(1/n)$ and $M=\sup_{\lvert z\rvert=\rho}\lVert A(z)\rVert=O(g_n)$: $\lVert A^{(k)}(0)\rVert\le k!M/\rho^k=O(g_n^{1-k})=O(n^{k-1})$. So $\lVert A'\rVert=O(1)$, consistent with [Lemma L140](../results.md)'s $\tfrac12$-contraction, an independent check that the order is right, $\lVert A''\rVert=O(n)$, $\lVert A'''\rVert=O(n^2)$, and $6\langle A'',A'\rangle=O(n)$. **Arithmetic reproduced.**

### Discrepancy D2, $C_\delta=O(n)$ is established at the base point, and used as a constant on a segment

**Locate.** [findings/second-order.md](../findings/second-order.md):1113, "*$C_\delta$ is $(\delta^2)'''=2\langle A''',A\rangle+6\langle A'',A'\rangle$, whose first term **vanishes at $A(0)=\mathrm{Alt}(W^*_-)=0$***.

**Exhibit.** A third-order Taylor remainder is controlled by $\sup_{s\in[0,t]}\lvert(\delta^2)'''(s)\rvert$, not by $(\delta^2)'''(0)$. At $s\ne0$ the first term is $2\langle A'''(s),A(s)\rangle$ with $A(s)\ne0$, and the entry's own orders give $\lVert A'''\rVert=O(n^2)$, so the term is not visibly below $O(n)$ without a bound on $\lVert A(s)\rVert$ and without Cauchy estimates at centres $s\ne0$. Neither appears in the entry, nor in [post F60](../findings/second-order.md) above it. Concretely: the entry offers nothing that rules out $\lvert(\delta^2)'''(s)\rvert=\Theta(n^2)\lVert A(s)\rVert$ growing past $\Theta(n)$ before $s$ reaches the claimed radius.

**Argue the opposite.** The charitable reading is that this is a routine step: Cauchy at a shifted centre on a disc of half the radius gives the same orders uniformly on $\lvert s\rvert<\rho/2$, and $\lVert A(s)\rVert=O(s)$ then makes the first term $O(n^2 s)$, which is below $O(n)$ throughout $s\lesssim n^{-1}$, a range containing the claimed radius $n^{-3/2}$. So the constant is very likely repairable at the same order. **The finding stands as a gap, not as an error**: the repair is a bootstrap on the very radius being derived, and neither the shifted-centre estimate nor the bootstrap is on file. *What would have to be proved: $\sup_{\lvert s\rvert\le r_n}\lvert(\delta^2)'''(s)\rvert=O(n)$, with the Cauchy estimates stated at centres other than $0$.*

## 5. The edge of every range

| edge | what L145 asserts there | finding |
|---|---|---|
| smallest admissible dimension | nothing, no floor in the box | §2: false at $n=4$ and $n=6$; the entry's constant $c_p$ is right only for $m\ge4$ and strict only for $m\ge5$. The block's three entries carry three different floors: none here, $m\ge3$ at L146, $m\ge6$ at L149 |
| odd $n$ | nothing, and correctly | $n=2m$ is in the statement; the balanced product does not exist at odd $n$. **No finding**, but the record should not read the box as covering odd $n$ |
| the crossover $n=6+2\sqrt7$ | nothing | $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$ changes sign there. Exactly: $\theta_0(6)=\sqrt{10}/3$, so $\kappa_6=9\sqrt{3/2}-3\sqrt{10}>0$, while $\theta_0(12)=\sqrt{55}/6$ gives $\kappa_{12}=9\sqrt{3/2}-\tfrac32\sqrt{55}<0$. **$\Phi=P-\kappa_n\delta^2$ is a differently-signed object on the two sides of the crossover**, so "the penalised functional" in the box does not name one thing across the range the box quantifies over. A second reason $n\ge12$ is load-bearing and omitted |
| $\ker W\ne0$, witness $W_{\mathbb{CP}^2}$ with $\dim\ker W=3$ | nothing about it, and step 1 asserts no kernel **at $W^*$ only** | **No finding against L145.** Its step-1 claim is local at the balanced product, where I verified $\lambda_\pm\ne0$. The witness matters to the entry only as the reason the scenario is split: at $W_{\mathbb{CP}^2}$ the gap at $0$ closes, $W\mapsto W_-$ is not analytic and $\delta^2$ has a kink ([Lemma L17](../findings/route-a.md)), which is [I3](../plan.md)'s problem and not this one. *Sibling entries were less careful, [ROUND_L147](ROUND_L147.md) records "$\ker W^*=0$ has a named witness against it at $W_{\mathbb{CP}^2}$", so the correctness here is worth stating rather than assuming* |

## 6. Discrepancy D3, the load-bearing step is an infimum that is named and never computed, and the chain as written gives $n^{-2}$

**Locate.** [findings/second-order.md](../findings/second-order.md):1115, "*$n^{-2}$ is the direction-uniform quotient $c_n/\sup_H C(H)$; and $n^{-3/2}$ is $\inf_H c(H)/C(H)$, **which is what a tube radius is***", together with the step-4 row, "*$r_n=\Omega(n^{-3/2})$ … CONFIRMED as a lower bound*".

**Exhibit.** Take the entry's own constants. $c_n=3\theta_0/(n-2)=\Theta(1/n)$; $C_\delta=O(n)$ by step 3; $C_P=\sup\lvert P\rvert$. The direction-uniform quotient is then
$$\frac{c_n}{\sup_H C(H)}=\frac{\Theta(1/n)}{O(C_P+n)}=\Omega(n^{-2}),$$
which is the entry's own second exponent. **That is the only lower bound the entry's written chain yields**, because the entry never states $c(H)$ or $C(H)$ as functions of $H$, never states which directions attain the extremes, and never performs a minimisation. The one place on the record where the minimisation is written is [post F60](../findings/second-order.md):967, immediately above this entry:
$$r_n\ge6\min_v\frac{c_{\mathrm{pair}}+(c_4-c_{\mathrm{pair}})v^2}{C_P+Knv},$$
and F60 states its outcome as a **dichotomy in $C_P$**: "*at $C_P=\Theta(n)$ the minimum sits at $v=0$ and returns $\Theta(n^{-2})$, but at $C_P=\Theta(1)$ it sits at $v^*=\Theta(n^{-1/2})$ and returns $\Theta(n^{-3/2})$*". Following that algebra: with $f(u)=(c_p+u^2)/(S+au)$, $f'=0$ gives $au^2+2Su-ac_p=0$, so $u^*=(-S+\sqrt{S^2+a^2c_p})/a$ and $f(u^*)=2u^*/a$. With $a=\Theta(n)$ and $c_p=\Theta(1/n)$ one has $a^2c_p=\Theta(n)$, so
- $S=\Theta(1)$: $u^*=\Theta(n^{-1/2})$, $f(u^*)=\Theta(n^{-3/2})$;
- $S=\Theta(\sqrt n)$: $S^2=\Theta(n)$ is comparable, $u^*=\Theta(n^{-1/2})$, $f(u^*)=\Theta(n^{-3/2})$;
- $S=\Theta(n)$: $S^2=\Theta(n^2)$ dominates, $u^*=\Theta(1/n)$, $f(u^*)=\Theta(n^{-2})$.

**So the $n^{-3/2}$ branch requires $\sup\lvert P\rvert=O(\sqrt n)$, and under the bound F60 itself cites, [Lemma L107](../findings/bounds.md), $\sup\lvert P\rvert\le n-1$, the same computation returns $n^{-2}$.** The input that makes step 4 come out is [Lemma L143](../findings/bounds.md), $\sup\lvert P\rvert\le1+\sqrt{n-2}$, and **L145 cites neither L107 nor L143 nor any bound on $\sup\lvert P\rvert$ at all**, while using $\lVert P\rVert_\infty$ in its own disagreement paragraph.

**Argue the opposite.** Two charitable readings, and I grant both partially. First, L143 is Lemma 143, it predates L145, so the input exists on the record and the entry could have cited it; the defect is a missing citation rather than a missing fact, and with it the exponent does come out. Second, F60's line at [second-order.md](../findings/second-order.md):973 asserts a *different* route to the same number, "*per-direction bookkeeping using the record's own Cauchy estimate $\lVert A^{(k)}\rVert=O(n^{k-1})$ and the block-additivity of $Q$ gives $r_n=\Omega(n^{-3/2})$*", so the claim is not unsupported on the record as a whole.

**The finding stands, in this exact form.** That second route is a single sentence with no computation attached, and the quantifier it needs (the infimum over *every* normal direction, including the mixed ones), is precisely what [plan.md](../plan.md) I33 records as unpriced and what [Lemma L149](../findings/second-order.md) was written to repair, "*and the quantifier error is gone*". **So at the moment L145 states it, the infimum in its key sentence is not known to be $\Theta(n^{-3/2})$; the entry contains no derivation of it; and its own written constants give $\Omega(n^{-2})$.** *What would have to be proved for step 4 as stated: a lower bound $c(H)\ge c_p+\rho w^2$ and an upper bound $C(H)\le\sup\lvert P\rvert+Kn w$ valid for every unit normal $H$ with mixed-component weight $w$, together with $\sup\lvert P\rvert=O(\sqrt n)$, none of which is in this entry.*

## 7. Discrepancy D4, "$\Theta(n^{-1})$ is reachable" contradicts the paragraph twenty lines above it

**Locate.** Step-4 row, [second-order.md](../findings/second-order.md):1111: "*$\Theta(n^{-1})$ is reachable*". Against [second-order.md](../findings/second-order.md):973: "*still inside the analyticity ball $g_n=\Theta(1/n)$, **which $\Theta(n^{-1})$ would not be***".

**Exhibit.** Both sentences are about the same quantity at the same base point in the same file. The second says a radius of order $n^{-1}$ is excluded because it exceeds the analyticity ball $g_n=\Theta(1/n)$ used throughout; the first says it is attainable. On L145's own direction-blind radius $\rho=\Theta(\min(1,g_n/\lVert H\rVert_{op}))$, with $\lVert H\rVert_{op}$ allowed to be $\Theta(1)$, the second sentence is the correct one and the first is false.

**Argue the opposite.** The reconciliation is real, and it is [Lemma L146](../findings/second-order.md): on the summand carrying the margin $\lVert H\rVert_{op}=O(n^{-1/2})$, so the disc is $\Omega(n^{-1/2})$ ("*a factor $\sqrt n$ larger than the direction-blind $g_n$*") and $\Theta(n^{-1})$ is then comfortably inside it. **So the sentence is true, and true only with L146.** The finding is therefore reclassified from a contradiction to a dependency, and it is the sharpest single instance of the answer to question 2: **L145 cannot justify its own step-4 annotation from its own contents.**

## 8. Two candidates I could not sustain

- **Withdrawn, "the geodesic segments fill the tube by invariance".** I considered charging that invariance is not what fills the tube: what fills it is that a point within distance $r$ of the compact orbit has a nearest point on it, and the minimising segment meets the orbit orthogonally by first variation. **Withdrawn on the third step**: the conclusion is true, and $SO(n)$-invariance of $P$ and $\delta^2$ *is* what the entry needs it for, namely that the constants do not depend on which base point the segment starts from. The reason given is half the reason, and the half given is the half the entry uses.
- **Withdrawn, the $\inf$/$\sup$ distribution.** I checked whether the entry distributes a $\min$ across terms sharing a variable, which is the failure the brief names. It does not: it states $\inf_H c(H)/C(H)$ and $c_n/\sup_H C(H)$ as *different* quantities, and the inequality between them, $\inf_H c/C\ge(\inf_H c)/(\sup_H C)$, runs the way the entry's numerals do ($n^{-3/2}\ge n^{-2}$). **This paragraph is correct and is the entry's most valuable content.**

## 9. Every numeral in the entry, and which I could reproduce

| numeral | reproduced? |
|---|---|
| $g_n=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}$ | **Yes, exactly**, §3, from trace-freeness and $\mathop{\mathrm{tr}}(W^2)=1$ |
| $g_n=\Theta(1/n)$ | **Yes**, $g_n\to\sqrt2/n$ |
| $\rho<g_n/2$ | **Yes**, as the strict Neumann condition at a contour at distance $g_n/2$ |
| $\lVert A^{(k)}\rVert=O(n^{k-1})$ from $M=O(g_n)$ | **Yes**, $k!M/\rho^k$ with $\rho=\Theta(g_n)$ |
| $(\delta^2)'''=2\langle A''',A\rangle+6\langle A'',A'\rangle$ | **Yes, exactly**, §4 |
| $C_\delta=O(n)$ | **Yes at $t=0$; not on a segment**, D2 |
| $M=O(1)\Rightarrow A'''=O(n^3)\Rightarrow r_n=n^{-4}$ | **Yes**, $3!\,O(1)/\Theta(g_n^3)=O(n^3)$, and $\Theta(1/n)/O(n^3)=\Theta(n^{-4})$ |
| $\sqrt{\binom n2}\asymp1/g_n$ | **Yes, and the ratio is exact**: $\dfrac{1/g_n}{\sqrt{\binom n2}}=\sqrt{\dfrac n{n-2}}$, which is $\sqrt{6/5}$ at $n=12$ |
| $\lVert W_-\rVert_{op}=O(g_n)$, and $\lVert W^*_-\rVert_F=\Theta(1)$ | **Yes**, $\lVert W^*_-\rVert_F=g_n m=\sqrt{(m-1)/(2m-1)}\to1/\sqrt2$ |
| $c_p=\Theta(1/n)$ | **Yes**, $c_p=3\theta_0/(n-2)$ with $\theta_0\uparrow\sqrt2$; and $\tfrac12-\lambda_m=\tfrac1{2(m-1)}=\tfrac1{n-2}$ exactly |
| $c_p/\lVert P\rVert_\infty=\Theta(n^{-1})$ | **Only under $\sup\lvert P\rvert=\Theta(1)$**, which no entry proves; under [Lemma L143](../findings/bounds.md) it is $\Omega(n^{-3/2})$. The r446 position as recorded assumes the unproven reading |
| $\lVert A''\rVert=O(1)$ where $\lVert H\rVert_{op}\asymp g_n$ | **Consistent** with $k!M/\rho^k$ at $\rho=\Theta(1)$, but the disc radius $\Theta(\min(1,g_n/\lVert H\rVert_{op}))$ is asserted and derived nowhere in the entry |
| $\inf_H c(H)/C(H)=n^{-3/2}$ | **No**, §6; nothing in the entry computes it |
| $r_n=O(n^{-3/2})$ (the upper half of the box) | **No**, nothing anywhere computes it, and the entry withdraws it |

**Against the block's history**: I found no constant read at an $n\to\infty$ value and used at finite $n$ *inside this entry*, it states orders only, which is why the trap does not bite here. The failure mode this entry has instead is the opposite one: orders with no constants and no derivations.

## 10. What a reader may take from this entry, item 4 of the brief

**May be taken as proved by the entry itself, at even $n\ge12$:**

1. $W^*$ has two-valued spectrum, no kernel, and $g_n=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}$.
2. $W\mapsto W_-$ is analytic on the open Frobenius ball of radius $g_n$ at $W^*$, with the complex disc strictly inside $g_n/2$ on directions of unit operator norm.
3. $\mathrm{Alt}(W^*_-)=0$, as a fact about $W^*_-$ and not only about $W^*$.
4. $\lVert A^{(k)}(0)\rVert=O(n^{k-1})$ and $(\delta^2)'''(0)=6\langle A'',A'\rangle=O(n)$, given the shifted-centre step of D2.
5. The three exponents $n^{-4}$, $n^{-2}$, $n^{-3/2}$ are three different quantities, and the correct one for a tube radius is $\inf_H c(H)/C(H)$.
6. Margin and defect response sit on orthogonal $L_e$-eigenspaces, so they do not bind together, inherited from [post F60](../findings/second-order.md).

**May NOT be taken from it:** $r_n=O(n^{-3/2})$, in any form; $r_n=\Omega(n^{-3/2})$ *as proved here*, since the infimum is never computed and the chain as written gives $\Omega(n^{-2})$; anything at $m\le3$; anything about $\sup\lvert P\rvert$; and the resolution of its own recorded disagreement, which is L146's.

## 11. The missing canonical form, item 5

**The absence is correct as things stand, and it is not correct as a resting state.**

- [results.md](../results.md)'s own rule is "*a result appears here once Gate 2 has passed*", and L145 passed Gate 2 ([r446](../reviews/REVIEW_r446.md), [r447](../reviews/REVIEW_r447.md)). By that rule an entry is owed. The gap is wider than L145: the canon carries L133 and L140 and then L154–L158, with **none of L141–L153**, so seven entries of this block, L145 through L149 among them, are outside the canon while the five that build on them are inside it.
- **But entering the box verbatim would put a withdrawn claim in the canon**, since the $\Theta$'s upper half is retracted in the entry itself and [findings/INDEX-results.md](../findings/INDEX-results.md):164 already propagates it. So the absence has protected the canon rather than damaged it.
- **What a canonical entry should say**, if one is written: at $W^*=S^m\times S^m$ with even $n\ge12$, $g_n=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}$, the defect remainder constant is $C_\delta=O(n)$, and the tube radius satisfies $r_n=\Omega(n^{-3/2})$, a lower bound only, with $\Theta(n^{-1})$ the ceiling of the method. **Not $\Theta$.**

## What would falsify the statement, and what I did to look for it

**The object that would break the surviving claim** is a unit direction $H$ at $W^*$, normal to both the orbit and the sphere, at some even $n\ge12$, with $c(H)/C(H)=o(n^{-3/2})$, a direction that is simultaneously low-margin and high-second-derivative.

**What I did.** I read the margin spectrum at the balanced product in closed form from [Lemma L26](../findings/nondegeneracy.md) and [Lemma L27](../findings/nondegeneracy.md) and computed the two candidate margins by hand, $\tfrac12-\lambda_m=\tfrac1{2(m-1)}$ on the $S^2_0$ summands and $\tfrac12-\mu=\tfrac{m-3}{2(m-1)}$ on $\Lambda^2\otimes\Lambda^2$; at $m\ge5$ both are positive and the smaller is the first, so no zero-margin direction exists in the block structure the record prices, and [post F60](../findings/second-order.md)'s orthogonality (margin on a pair block, defect response on the $(2,2)$ four-sets) keeps the two extremes apart. **I found no such direction at $n\ge12$, and the mixed directions remain unpriced by anything in this entry, [plan.md](../plan.md) I33 says so in terms.**

**What I did find** is the same object at small $m$, in closed form: at $m=3$ the direction in $\Lambda^2\mathbb R^3\otimes\Lambda^2\mathbb R^3$ carries $L_e$-eigenvalue $\mu=\tfrac12$ exactly, so $c(H)=0$ and $r_6=0$; at $m=2$, $\mu=1$ and $c(H)<0$, so $r_4=0$. **Both falsify the box as quantified, and neither touches it once $m\ge5$ is written in.**

## Verdict

**`HYPOTHESIS-DEBT`**

The entry's headline is not proved in either direction by anything the entry contains: the upper half of $\Theta(n^{-3/2})$ is withdrawn four lines below the box and argued nowhere on the record, and the lower half is an infimum the entry names, calls "*what a tube radius is*", and never computes, its written constants giving $\Omega(n^{-2})$, with the step to $n^{-3/2}$ needing $\sup\lvert P\rvert=O(\sqrt n)$ ([Lemma L143](../findings/bounds.md), uncited here) and a uniformity over directions repaired only at [Lemma L149](../findings/second-order.md). What the entry does prove, the spectrum, the analyticity ball, $\mathrm{Alt}(W^*_-)=0$, and $C_\delta=O(n)$ at the base point, I reproduced by hand, and it is worth keeping. **Three debts, named exactly:** (i) $\sup_{\lvert s\rvert\le r_n}\lvert(\delta^2)'''(s)\rvert=O(n)$, on the segment rather than at $0$; (ii) $\inf_H c(H)/C(H)=\Omega(n^{-3/2})$ over every unit normal direction, with $c(H)$ and $C(H)$ defined; (iii) either a proof of $r_n=O(n^{-3/2})$ or the removal of the $\Theta$ from the box and from [findings/INDEX-results.md](../findings/INDEX-results.md):164. **And one correction owed regardless of the debts:** the box needs $m\ge5$, and the programme's $n\ge12$, written into it.
