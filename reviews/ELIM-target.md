# ELIM-target, elimination audit of findings/target.md

Auditor ELIM-target, 2026-09-01. Assigned file: [findings/target.md](../findings/target.md), 730 lines, read in full. Analytical only, no script was run, no value was evaluated, nothing numerical was checked. Every verdict below is a substitution carried out on paper.

The test applied to every bound, reduction, equivalence and "what a successor needs" in the file: substitute $W^{\#}=\theta W-W^{2}$, $\operatorname{Ric}(W)=0$, $\operatorname{tr}W=0$, first Bianchi, then ask what free variable is left. The file writes $\theta$ as $\lambda$ throughout; both are used below in whichever form the quoted claim uses.

---

## Survivors, what genuinely escapes (spectrum, $\theta$)

### S1. The bracket tensor $T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle^{2}$, and the exact list of what criticality pins in it

This is the deliverable. In an eigenframe of $W$ the whole problem is the pair $(\lambda,T)$ with $T$ totally symmetric, non-negative, and vanishing whenever two indices coincide (ad-invariance gives $\langle[x,y],x\rangle=0$). Every quantity in this file, $\theta$, the Rayleigh matrix $M$, the bracket Gram $R_{\alpha\beta}=\lVert[v_\alpha,v_\beta]\rVert^{2}=\sum_\gamma T_{\alpha\beta\gamma}$, the $g$-vector, the loss terms, is a contraction of $(\lambda,T)$.

The three structural hypotheses are exactly three families of $N=\binom n2$ linear conditions on $T$ at fixed $\lambda$, one per degree in $\lambda$:

| degree | condition, for every $\alpha$ | source |
|---|---|---|
| $0$ | $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ | Killing marginal, any unit $v_\alpha\in\mathfrak{so}(n)$ |
| $1$ | $\sum_{\beta\gamma}T_{\alpha\beta\gamma}\lambda_\beta=-2\lambda_\alpha$ | Ricci-flatness, i.e. the file's $W\#I=-W$ and its per-row form |
| $2$ | $\sum_{\beta\gamma}T_{\alpha\beta\gamma}\lambda_\beta\lambda_\gamma=2\lambda_\alpha(\theta-\lambda_\alpha)$ | **criticality** |

**Criticality contributes exactly one of these three rows, and it is the top one.** Everything the elimination kills in this file is a contraction that lands inside a row of that table; everything that survives is a contraction that does not. That is the whole audit in one line, and it gives a successor a mechanical filter: write the proposed quantity as a contraction of $T$ against $\lambda$-monomials; if every occurrence of $T$ is summed over two indices carried by $\lambda^{0}$, $\lambda^{1}$ or $\lambda\otimes\lambda$, the quantity is a function of $(\lambda,\theta)$ and the claim is the target rearranged.

Two consequences the file has in pieces and never assembles, both free:

- $R\mathbf1=2(n-2)\mathbf1$ and $R\lambda=-2\lambda$. The bracket Gram has two known eigenpairs at **every** Weyl tensor; distinctness of the two eigenvalues re-proves $\operatorname{tr}W=0$.
- The $\mathbf1$-contraction of criticality, $\langle\lambda,R\lambda\rangle=-2$, is already implied by the degree-1 row. So the criticality family carries at most $N-1$ independent conditions, not $N$.

### S2. $g_\gamma=\lVert[\operatorname{ad}(v_\gamma),W]\rVert^{2}$, survives, and its free part is now named exactly

Lemma L41 at [target.md:698](../findings/target.md#L698) is the file's live lead, and it passes. Expanding $[\operatorname{ad}(v_\gamma),W]v_\alpha=\sum_\beta c_{\gamma\alpha\beta}(\lambda_\alpha-\lambda_\beta)v_\beta$ with $c^{2}=T$,

$$g_\gamma=\sum_{\alpha\beta}T_{\gamma\alpha\beta}(\lambda_\alpha-\lambda_\beta)^{2}=2\underbrace{\sum_\alpha\lambda_\alpha^{2}R_{\gamma\alpha}}_{\textstyle\rho_\gamma}-4\lambda_\gamma(\theta-\lambda_\gamma).$$

The second term is the degree-2 row, dead. **The entire free content of $g_\gamma$ is $\rho_\gamma$, the second spectral moment of row $\gamma$ of the bracket Gram**, which no row of the table above touches. Its only constraints are $\sum_\gamma\rho_\gamma=2(n-2)$ and $\sum_\gamma\lambda_\gamma\rho_\gamma=-2\operatorname{tr}W^{3}$, both inherited from degrees 0 and 1.

Two checks of this decomposition against the file's own stated constants, done symbolically: summing it gives $\sum_\gamma g_\gamma=4(n-2)-4(\theta\cdot 0-1)=4(n-1)$, the file's constant; and $\sum_\gamma\lambda_\gamma g_\gamma=-4\operatorname{tr}W^{3}-4\langle W,W^{\#}\rangle=-4\theta$, the file's identity. Both fall out, which confirms the framework and confirms the identity is Ricci-flatness plus the definition of $P$, exactly as the file says at [target.md:575](../findings/target.md#L575).

Corollary worth carrying: $G_0=\sum_{\gamma\in\ker W}g_\gamma=2\sum_{\gamma\in\ker W}\rho_\gamma$ exactly, since $\lambda_\gamma=0$ there. $G_0$ is a **pure** survivor with no criticality content at all. $\Delta$ is mixed: $\Delta=2\sum_{\mathfrak p}\rho_\gamma-4\sum_{\mathfrak p}\lambda_\gamma(\theta-\lambda_\gamma)$, so part of it is already spoken for by $(\lambda,\theta)$ and only $\sum_{\mathfrak p}\rho_\gamma$ is new. A successor pushing Lemma L41 should push on $\rho$, not on $\Delta$.

### S3. $\mu$, the second-kind bottom eigenvalue, and the reason it survives is the file's own named obstruction

Branch 1, $\mathrm{CD}_n$ and the whole [target.md:107](../findings/target.md#L107) lift rest on $\mu=-\nu_{\min}(\mathring W)$ on $S^2_0$. It survives, and the mechanism is exact:

$$(W^{\#})^{\!\circ}=\theta\,\mathring W-(W^{2})^{\!\circ}\quad\text{at a critical point.}$$

So on $S^2_0$ criticality does **not** eliminate the sharp term, it trades it for $(W^{2})^{\!\circ}$, and $(W^{2})^{\!\circ}\ne(\mathring W)^{2}$. That inequality is precisely what the file names as THE OBSTRUCTION at [target.md:98](../findings/target.md#L99). The obstruction and the survival are the same fact seen from two sides: on $\Lambda^{2}$ the substitution closes because $W^{\#}$ becomes a polynomial in $W$ and eigenvectors diagonalise it; on $S^{2}_0$ it does not close because there is no algebra map carrying $\Lambda^{2}$ operator products down to $S^{2}_0$.

**The instruction this yields for a successor is sharp:** on $S^2_0$ every statement about $\#$ is a statement about $(W^{2})^{\!\circ}$ shifted by $\theta\mathring W$, so the *only* place criticality can enter the second-kind route is the defect $(W^{2})^{\!\circ}-(\mathring W)^{2}$. The file says as much in a half-sentence at [target.md:259](../findings/target.md#L259) ("So the work is the defect") and then does not act on it.

A structural certificate that $\mu$ is not a function of $(\mathrm{spec}\,W,\theta)$, needing no computation: triality at $n=8$ preserves the bracket and the inner product on $\Lambda^{2}=\mathfrak{so}(8)$, hence preserves the $\Lambda^{2}$ spectrum, $\theta$ and $S$, but it carries $S^{2}_0(\mathbb R^{8})$ to $S^{2}_0(\Delta_+)$, a different summand, so it need not preserve $\mathring W$'s spectrum. The file's own branch-1 mechanism says it does not: $S^{3}\times S^{5}$ is reducible, so its trace directions in $S^2_0$ force $\mu/\theta=n/(n-1)$; its triality partner $\mathbb{HP}^{2}$ is irreducible and has no such direction. **An isospectral pair with equal $\theta$ and unequal $\mu$ is the cleanest possible survivor certificate, and it is already in this file's tables.**

### S4. Genuine survivors, briefly

- $\lVert\operatorname{Ric}(W_-)\rVert^{2}$ in Observation L12, the Ricci of the truncated tensor depends on how the negative eigenvectors sit as bivectors, which no row of S1's table constrains.
- $\operatorname{tr}(P_{E_-}(W^{\#}-W_-^{\#})P_{E_-})$, the bracket mass coupling $E_-$ to $E_+\cup\ker W$. See T6 below: this difference is the *whole* of Observation L12's content, because the compression of the full $W^{\#}$ is dead.
- $\mu_{\max}(K)$ and $\lVert G_{\rm off}\rVert^2$, survivors, but frame-dependent, which is the separate and correct reason the file closes that route at [target.md:67](../findings/target.md#L67).
- $\lambda_{\max}(L_e|_{e^\perp})$, the second-order discriminator. It is a contraction of $T$ well outside the three rows, so nothing in the elimination touches it. The file's own separating argument for it ($\mathbb{CP}^{3}$ and $S^{3}\times S^{3}$ share $\theta$ and land on opposite sides), is weaker than stated, since those two have different spectra and the test is against $(\lambda,\theta)$, not $\theta$ alone. The isospectral triality pair would be the right test, and both members saturate, so it does not separate either. The survival verdict stands on the contraction argument, not on the file's table.
- $\ker\Phi_W$ (Lemma L37). Criticality never enters $\Phi_W(A)=[W,\delta_A]$. Survives, and the file already correctly restricts it to defining the target set rather than bounding $\theta$ on it.

---

## Tautologies found

### T1. The boxed lift is criticality contracted with $h\otimes h$

[target.md:93](../findings/target.md#L93) and [target.md:118](../findings/target.md#L121) box

$$\lambda\mu=-\big\langle(W^{2})^{\!\circ}h,h\big\rangle-\big\langle(W^{\#})^{\!\circ}h,h\big\rangle,\qquad \lambda\mu=\mu^{2}-\mathrm{LOSS}.$$

Substituting $(W^{\#})^{\!\circ}=\theta\mathring W-(W^{2})^{\!\circ}$ and $\mathring Wh=-\mu h$:

$$-\langle(W^{2})^{\!\circ}h,h\rangle-\big(-\theta\mu-\langle(W^{2})^{\!\circ}h,h\rangle\big)=\theta\mu .$$

The two $(W^{2})^{\!\circ}$ terms cancel and the identity reads $\theta\mu=\theta\mu$. It is $\langle\mathring{(Q(W)-\theta W)}h,h\rangle=0$ and nothing else, which is exactly how it was derived, apply a linear map to criticality, pair with a vector.

Reviewer 122's verdict at [target.md:204](../findings/target.md#L204) that $\mathrm{LOSS}=\mu(\mu-\lambda)$ identically is therefore **confirmed, and understated**. The file frames the collapse as an accident of rearrangement; it is structural. Independently: $\mathrm{LOSS}(h)=\mu^{2}+\langle Q(W)^{\!\circ}h,h\rangle$ is the criticality-free form the file itself records, and $\langle Q(W)^{\!\circ}h,h\rangle$ evaluates in one step to $-\theta\mu$ the moment criticality is imposed, because $h$ is an eigenvector of $\mathring W$ and $\mathring{(\cdot)}$ is linear. There is no route by which the three-term decomposition of a quantity equal to $\mu^{2}-\theta\mu$ becomes a reduction.

### T2. Unflagged. "So the whole route now rests on the $\#$ term alone" is the $W^{2}$ bound with $\lambda\mu$ added to both sides

At [target.md:257](../findings/target.md#L257):

> Combined with the criticality identity, $\ \lambda\mu\le\tfrac12\lambda_{\max}(N)-\langle(W^{\#})^{\!\circ}h,h\rangle$. *So the whole route now rests on the $\#$ term alone*

Substitute criticality into the right-hand side:

$$\tfrac12\lambda_{\max}(N)-\big(-\theta\mu-\langle(W^{2})^{\!\circ}h,h\rangle\big)=\tfrac12\lambda_{\max}(N)+\lambda\mu+\langle(W^{2})^{\!\circ}h,h\rangle .$$

The asserted inequality is therefore

$$\lambda\mu\ \le\ \tfrac12\lambda_{\max}(N)+\lambda\mu+\langle(W^{2})^{\!\circ}h,h\rangle \iff -\langle(W^{2})^{\!\circ}h,h\rangle\ \le\ \tfrac12\lambda_{\max}(N),$$

which is the inequality that had **already** been spent one line earlier by dropping the commutator mass. $\lambda\mu$ cancels from both sides; "combined with the criticality identity" adds nothing. This is Route R14's pattern verbatim (the same terms subtracted from both sides) and it is the one instance in the file that no reviewer has caught. The claim that the $\#$ term is a distinct remaining unknown is false at a critical point: on $S^{2}_0$ the $\#$ term and the $W^{2}$ term are the same unknown up to the constant $\theta\mu$.

### T3. Unflagged. "Identity 4" collapses to $M\mathbf1=0$ using the file's own per-row identity

At [target.md:316](../findings/target.md#L315), listed as the fourth of "Four identities, each proved" and screened at $10^{-16}$:

$$\sum_\beta M_{\alpha\beta}=\lambda_\alpha-\tfrac12\operatorname{tr}\big(W\operatorname{ad}(v_\alpha)^{2}\big).$$

Expand the second term: $-\operatorname{tr}(W\operatorname{ad}(v_\alpha)^{2})=\langle W,\sum_\beta b_{\alpha\beta}\otimes b_{\alpha\beta}\rangle=\sum_{\beta\gamma}T_{\alpha\beta\gamma}\lambda_\gamma$. By total symmetry of $T$ this is the same sum as the per-row identity's left side, $\sum_\beta\lambda_\beta R_{\alpha\beta}=-2\lambda_\alpha$, which this same file records at [target.md:663](../findings/target.md#L663) as a theorem valid on all of $\mathrm{Weyl}_n$. Hence

$$\sum_\beta M_{\alpha\beta}=\lambda_\alpha+\tfrac12(-2\lambda_\alpha)=0 .$$

So identity 4 is not an independent identity; it is $M\mathbf1=0$, and the "measurement" of $\operatorname{tr}(W\operatorname{ad}(v_\alpha)^{2})$ is Ricci-flatness. The upgrade is worth taking: $M$ is symmetric with $M_{\alpha\alpha}=\lambda_\alpha$, $M\mathbf1=0$ and $M\lambda=\theta\lambda$, so $\mathbf1$ and $\lambda$ are orthogonal eigenvectors with eigenvalues $0$ and $\theta$. That is the same hollow, zero-row-sum shape the file exploits for the vertex matrix $K$ at [target.md:61](../findings/target.md#L61), and the Cauchy–Schwarz norm-budget argument recorded there applies to $M$ on $\mathbf1^\perp$ verbatim. The file states only the weaker "$\operatorname{tr}M=0$, so $\lambda_{\max}(M)\ge0$".

### T4. $M\lambda=\theta\lambda$ is the diagonal of criticality; $\langle\lambda,M\lambda\rangle=P$ is the definition of $P$

Same section, "All four screen at $10^{-16}$, alongside $\langle\lambda,M\lambda\rangle=P$ and $M\lambda=\theta\lambda$ at a critical point." Expanding, $(M\lambda)_\alpha=\lambda_\alpha^{2}+\langle v_\alpha,W^{\#}v_\alpha\rangle=\langle v_\alpha,Q(W)v_\alpha\rangle$, so $M\lambda=\theta\lambda$ **is** $Q(W)=\theta W$ read on the diagonal of the eigenbasis, and it exhausts the diagonal information: any $\langle v_\alpha,W^{\#}v_\alpha\rangle$ is $\lambda_\alpha(\theta-\lambda_\alpha)$. Contracting once more, $\langle\lambda,M\lambda\rangle=\operatorname{tr}W^{3}+\langle W,W^{\#}\rangle=P$ holds at every $W$, critical or not, it is the definition of $P$. Screening either to $10^{-16}$ verifies arithmetic, not mathematics. Identities 2 ($M_{\alpha\alpha}=\lambda_\alpha$, from $[v,v]=0$) and 3 ($\operatorname{tr}M=\operatorname{tr}W=0$) are likewise definitional.

### T5. "$\sum_a\mathrm{LOSS}(h_a)=3$" and "LOSS depends on $h$ only through its eigenvalue" are the same tautology, plus normalisation

Both bullets sit at [target.md:236](../findings/target.md#L236) under "What survives, and two of it are upgrades". At a critical point $\mathrm{LOSS}(h_a)=\nu_a^{2}+\theta\nu_a$ for every eigenvector, which is the dependence-on-eigenvalue claim; summing gives $\sum\nu_a^{2}+\theta\sum\nu_a=3+0=3$, i.e. $\lVert\mathring W\rVert_F^{2}=3$ and $\operatorname{tr}\mathring W=0$. Neither bullet survives T1 as an independent gain.

### T6. Observation L12's slack: the compression of the *full* sharp is dead, and only the difference is content

At [target.md:41](../findings/target.md#L42) the claimed closed form is $S=\operatorname{tr}(P_{E_-}W_-^{\#}P_{E_-})$. Note first what happens with the full $W^{\#}$ rather than the sharp of the compression:

$$\operatorname{tr}\big(P_{E_-}W^{\#}P_{E_-}\big)=\sum_{\alpha\in E_-}\lambda_\alpha(\theta-\lambda_\alpha)=-\theta\textstyle\sum\mu_\alpha-\sum\mu_\alpha^{2},$$

a function of (spectrum, $\theta$) alone. In the $T$ picture, $\operatorname{tr}(P_-W^{\#}P_-)$ sums the degree-2 rows over $\gamma\in E_-$ with $\beta,\gamma$ free, whereas the claimed form $\tfrac12\sum_{i,j}\mu_i\mu_j\lVert P_{E_-}[v_i,v_j]\rVert^{2}$ restricts **all three** indices to $E_-$. So Observation L12's content is exactly the difference, the part of $\sum_{\gamma\in E_-}T_{\gamma ij}\lambda_i\lambda_j$ with at least one of $i,j$ outside $E_-$, i.e. the bracket mass $E_-$ fails to expel. That is the survivor S4 above, and stating the slack in that form rather than as a compressed trace would make the conditionality on the two bracket conditions visible in the formula instead of in a caveat.

### I28. Confirmed and self-flagged, listed for completeness

- The totally-summed vertex equation, $t/2+(1-t/2)=1$, the file catches this itself at [target.md:31](../findings/target.md#L31).
- The $(ab),(ab)$ vertex equation at [target.md:15](../findings/target.md#L15) is criticality's diagonal entry with $(W^{2})_{abab}=K_{ab}^{2}+R_{ab}$ expanded. It carries nothing beyond criticality; the file says this in words. Its $v\otimes v$ pairing is likewise criticality contracted, and all content sits in the combinatorial expansion of $(W^{\#})_{abab}$, which is why the route had to close on frame-dependence rather than on sign.
- The $\xi$-Gram form at [target.md:302](../findings/target.md#L302): since $\operatorname{tr}(WM)=-16\langle Q(W),W\rangle$, the displayed inequality is Conjecture A transcribed. The file grades it correctly as "neither easier nor harder".
- $\mathrm{CD}_n$ restricted to the target set reading as the target verbatim, [target.md:220](../findings/target.md#L220). Honestly labelled.

---

## Weak evidence

### W1. "Within the symmetric class, above $\sqrt{3/2}$ forces a two-factor round-sphere product" is called a theorem while its support is a catalogue sweep

[target.md:162](../findings/target.md#L162) asserts this is "a THEOREM the record already owns, not an enumeration", then supports it with a falsifier hunt that is three prongs, two of them catalogue-shaped: "numerically across the whole record", "symbolically over every closed-form family on its admissible range", and "by construction, orthogonal sums obey $1/\theta^{2}=\sum1/\theta_i^{2}$".

The third prong is vacuous for the purpose. A $\circ$-orthogonal sum is block-supported on $\Lambda^{2}V_1\oplus\Lambda^{2}V_2$; the objects that actually climb above $\sqrt{3/2}$ are Riemannian sphere products, whose Weyl tensors carry mass in $V_1\wedge V_2$ and are therefore **not** $\circ$-orthogonal sums, indeed each factor is conformally flat, so a genuine block sum of their Weyl parts is zero. The sum law excludes a class that provably contains no threat and says nothing about the class that contains all of them. What remains is prongs one and two: a sweep of the record and of the closed-form families it already holds.

A real theorem is within reach along the file's own dichotomy, irreducible symmetric gives $\theta\le\sqrt{3/2}$ by Petersen–Stanfield, so above the threshold forces reducible, but "reducible" to "two-factor round-sphere product" needs the missing step, which the file does not supply.

### W2. Tightness that follows from structure, not from mechanism, three instances

- "the reported projection estimate $\tfrac{n-1}n\mu\le\Theta_n$, *exactly tight at every balanced product here, ratio $1.0000$*" ([target.md:277](../findings/target.md#L277)). At a balanced product branch 1 is an equality by reducibility (the file proves this at [target.md:172](../findings/target.md#L172)) and $\theta=\theta_0(n)=\Theta_n$ there. Ratio $1.0000$ is the composition of two facts already known; it tests nothing about the projection estimate.
- "$\mathrm{CD}_n$ is an *equality* on both branches' extremal families ... so no lossy step is admissible anywhere" ([target.md:218](../findings/target.md#L218)). At $\mathbb{CP}^{2}$ equality holds because $\sqrt{3/2}$ **is** that point's value, the constant was defined from it. At $S^{6}\times S^{6}$ equality holds by reducibility plus $\theta(S^{k}\times S^{k})=\theta_0(2k)$, which is the algebraic identity $\tfrac{2(k-1)^2(2k-1)}{k^2(2k-2)}=\tfrac{2(2k-1)(2k-2)}{4k^2}$. Both equalities are definitional or structural; the methodological conclusion may be right, but not on this ground.
- The $\lambda$-weighted bound is "sharp at the conjectured maximiser" ([target.md:583](../findings/target.md#L583)). Equality holds iff $g$ is supported on the $\lambda_{\min}$ eigenspace, which is automatic at any two-eigenvalue graded point, since there $\mathfrak p=\mathfrak k$ consists of infinitesimal symmetries and $|\lambda_\gamma|=|\lambda_{\min}|$ on all of $\mathfrak m$. The file's own table shows the same equality at nine points spread from $0.986$ to $1.236$. Sharpness at the maximiser is gradedness, not extremality.

### W3. False independence: three "separate" results are one statement

"$\mathrm{LOSS}=\mu^{2}/n$ at $S^{p}\times S^{q}$ is now a THEOREM ... proved at Gate 2 twice over" ([target.md:235](../findings/target.md#L235)) and "branch 1 is an EQUALITY at every sphere product, a theorem rather than a table" ([target.md:170](../findings/target.md#L170)) are the same theorem: $\mathrm{LOSS}=\mu^{2}-\theta\mu$, so $\mathrm{LOSS}=\mu^{2}/n\iff\theta=\tfrac{n-1}{n}\mu$. The two elaborate proofs (three-scalar reduction; Cauchy–Schwarz on the diagonal locus) prove what the reducibility one-liner at [target.md:172](../findings/target.md#L172) gives in a sentence. Counting them as independent corroboration overstates the support.

The same section then says "the equality family is strictly larger than the sphere products, Reviewer 121 exhibits non-sphere-product, **non-critical** $4{+}4$ block tensors at $n=8$ with exact equality". The equivalence above requires criticality; at a non-critical tensor $\mathrm{LOSS}=\mu^{2}+\langle Q(W)^{\!\circ}h,h\rangle$ is a different statement. Non-critical witnesses cannot show that critical equality fails to characterise the products.

### W4. "Branch 1 fails on an open set, not at one point" conflates two statements

[target.md:214](../findings/target.md#L214). Branch 1 is a statement about critical points; the open neighbourhood of the padded $\mathbb{CP}^{2}$ orbit is almost entirely non-critical, where $\mathrm{LOSS}\ge\mu^{2}/n$ is the criticality-free inequality and not branch 1. The genuine refutations in that paragraph are the critical points (padded $\mathbb{CP}^{2}$ itself and the $n=5$ point at $\theta^{2}=24/35$) and those suffice. The "open set" headline is a scope slip, not an error of fact.

### W5. Catalogue-shaped evidence, listed

- Observation L40 ([target.md:692](../findings/target.md#L691)): "Three independent hunts agree: a $26$-space symmetric-space sweep, and closure sweeps at $n=6$ and $n=8$." A symmetric-space sweep is a biased sample by construction, and closures of catalogued points are the catalogue. Two of the three are not independent of each other, and the file's own verdict at [target.md:430](../findings/target.md#L430), random-start Newton on $\mathrm{Weyl}_6$ "does not reach the high-$\theta$ basin, so such an enumeration is evidence of completeness in neither direction", sits in tension with citing an $n=6$ sweep as corroboration.
- The $\mathrm{CD}_n$ branch table, "Branch two fires at $0$ of $11$" ([target.md:228](../findings/target.md#L228)). The file grades this correctly itself.
- Observation L12's ceiling: 239 converged points, ceiling moved twice, "observational, not structural" ([target.md:45](../findings/target.md#L46)). Correctly graded.

### W6. Random-Weyl screens

Used as **refutation**, one counterexample suffices, so these are legitimate and are not flagged: $v^{\mathsf T}Rv<0$ at random draws ([target.md:75](../findings/target.md#L75)); $\dim\ker\Phi_W=1$ at random tensors ([target.md:495](../findings/target.md#L495)); $N\ne\lvert W\rvert^{2}I/n$ from $n\ge5$ ([target.md:263](../findings/target.md#L263)).

Used as **positive evidence**, and flagged: "slack is $1.2$–$1.4$ at random Weyl tensors" and "at random points the bound exceeds $\sqrt{3/2}$, reaching $1.367$" ([target.md:583](../findings/target.md#L583)); "ratios $0.14$–$0.31$ at random Weyl tensors" for $\lambda_{\max}\le(n-2)|\lambda_{\min}|$ ([target.md:665](../findings/target.md#L665)). Random Weyl tensors are never diagonal and never symmetric-pair Casimirs, so wide slack there is uninformative about the structured families where the equality cases live. The file catches the second instance itself, noting the ratio reaches $0.99906$ under optimisation and that the claim is "untested rather than proved".

---

## Record integrity, four numbered blocks point at the wrong argument

Not part of the elimination brief, but found in the same pass and cheap to fix. The six numbered blocks appended on 2026-08-31 each say "the argument is in this file under X". Checked against the heading list:

| block | pointer | heading it resolves to | verdict |
|---|---|---|---|
| Lemma L37 | "What survives, because it was verified directly rather than taken from" | [target.md:394](../findings/target.md#L394), the $(\mathfrak{su}(m),\mathfrak{so}(m))$ family | **wrong**, the $\Phi_W$ argument is at [target.md:519](../findings/target.md#L519) |
| Lemma L39 | "...generalises to EV" | [target.md:348](../findings/target.md#L348) | correct |
| Observation L40 | "The totally-summed vertex equation is an identity, and the reason is p" | [target.md:25](../findings/target.md#L25), the $\operatorname{tr}(W^{\#})$ identity | **wrong**, the census bound is at [target.md:436](../findings/target.md#L436) |
| Lemma L41 | "The magnitude is convention-dependent; the sign is not" | [target.md:334](../findings/target.md#L334) | correct |
| Lemma L45 | "What fence post F29 closes, and what it leaves open" | [target.md:79](../findings/target.md#L79), the vertex equation | **wrong**, and the off-slice $R=cI+Y+W$ argument appears nowhere in this file |
| Lemma L49 | "The diagonal proof's ENGINE lifts... and its corr" | [target.md:9](../findings/target.md#L9), the vertex equation | **wrong**, and the collapse-space argument appears nowhere in this file |

Three further defects in the same blocks:

- **$\Delta$ is never defined in this file**, yet it is the free variable of Lemma L41's boxed bound and of the sharpened bound. Its meaning is recoverable only by reading [target.md:575](../findings/target.md#L575) and inferring $\Delta=\sum_{\gamma\in\mathfrak p}g_\gamma$ from "$B=0$ exactly when $\Delta=0$". A numbered lemma meant to travel must carry its own definition. $\mathfrak p$ and $\mathfrak m$ are likewise undefined here.
- The blocks use LaTeX macros that a markdown renderer has no definitions for (`\Weyl`, `\so`, `\su`, `\kk`, `\mm`, `\CP`, `\thstar`) and Observation L40 contains a broken fragment, `$W_{\CP^2**$ and at every padding of it}`, where the bold markup has swallowed the math delimiter.
- Lemma L49's closing claim, "constant $T$ is not realised by any $\mathfrak{so}(n)$", needs the qualifier "constant on distinct triples". Read over all triples it is vacuous, since $T$ vanishes identically whenever two indices coincide.

Three headings are also duplicated by a concatenation bug, at [target.md:85](../findings/target.md#L85), [target.md:232](../findings/target.md#L232) and [target.md:243](../findings/target.md#L243).

---

## Clean

Checked by substitution or by symbolic re-derivation; nothing collapses.

- The criticality-is-a-hypothesis refutation ([target.md:287](../findings/target.md#L287)), a dimension count, $834$ against $54$, with a non-critical perturbation as the witness. Sound.
- $W\#I=-W$ for every Weyl tensor, and $\operatorname{tr}(W^{\#})=-\lVert W\rVert^{2}$ derived from it by symmetry of $\mathrm{tri}$.
- The sum law $1/\theta^{2}=1/\theta_1^{2}+1/\theta_2^{2}$, including that criticality of the sum forces criticality of each summand. Re-derived: $a^{2}Q(W_1)=\theta aW_1$ gives $Q(W_1)=(\theta/a)W_1$.
- $\theta^{2}(S^{p}\times S^{q})=\frac{2(p-1)(q-1)(n-1)}{pq(n-2)}$, and its specialisation at $p=q=n/2$ to $\theta_0(n)^{2}=2(n-1)(n-2)/n^{2}$. Verified symbolically; the balanced product attains the cap identically.
- $\theta_0(2k)^{2}=2-3/k+1/k^{2}$ for $(\mathfrak{so}(2k),\mathfrak{so}(k)+\mathfrak{so}(k))$, and the crossing of $3/2$ between $k=5$ and $k=6$.
- $\theta^{2}\mu^{2}=1/(m-1)^{2}$ at $\mathbb{CP}^{m}$, from $\theta^{2}=\frac{(m+1)(2m-1)}{3m(m-1)}$ and $\mu^{2}=\frac{3m}{(m^{2}-1)(2m-1)}$. Verified symbolically.
- $\theta^{2}=\frac{m(m+1)}{(m-1)(m+2)}=\frac{T}{T-1}$ with $T=\binom{m+1}2$ for $(\mathfrak{su}(m),\mathfrak{so}(m))$, its monotone decrease in $m$, and its value $3/2$ at $m=2$. Verified symbolically.
- The $(S^{m})^{3}$ refutation of the companion bound's separation. The quoted $\theta^{2}=(3m-1)(m-1)/(3m^{2})$ fits the uniform shape $\theta^{2}=\frac{(km-1)(m-1)}{\binom k2 m^{2}}$, which reproduces the two-factor formula at $k=2$; the limit $4/3$ and the value at $S^{8}\times S^{8}\times S^{8}$ follow.
- $\sum_{pq}\langle C^{pq},h\rangle^{2}=\mu^{2}$, from $\langle C^{pq},h\rangle=-(\mathring Wh)_{pq}$. No criticality used.
- The unstated hypothesis correction ([target.md:239](../findings/target.md#L239)), $\Pi_{\mathcal W}$ does not commute with the ring map, and the step is saved by $Q(W)$ being automatically Ricci-flat. Correctly identified as load-bearing.
- $\Theta_3(W)=-2\theta(W)$, the convention table, and the observation that the sign survives $R\mapsto-R$ because $\Theta_3$ is cubic.
- $\lambda_{\max}\le(n-2)|\lambda_{\min}|$ as a valid three-step consequence of the per-row identity, with the file's own two caveats attached.
- The frame-dependence closure of the vertex-matrix route: $K=0$ at Fubini–Study in a skew-conference frame, and the $t\le2$ norm budget.
- Lemma L37's non-diagonality certificate, the $\mathbb{HP}^{2}$ refutation of the census characterisation, the triality identification, the Lemma L24 refutation in both directions, and the withdrawal of the $W_{\mathbb{CP}^{2}}$ standing filter.

---

## What a successor should take from this

1. Work in $(\lambda,T)$ and check every proposed quantity against the three-row table in S1 before deriving anything. Criticality is one row. A quantity built only from rows is the target rearranged.
2. Lemma L41's live lead is $\rho_\gamma=\sum_\alpha\lambda_\alpha^{2}R_{\gamma\alpha}$, the second spectral moment of the bracket Gram's rows, constrained only in its $\lambda^{0}$ and $\lambda^{1}$ totals. $G_0$ is pure $\rho$; $\Delta$ is $\rho$ plus a dead piece.
3. The second-kind route survives the elimination for exactly one reason, and its entire remaining content is the defect $(W^{2})^{\!\circ}-(\mathring W)^{2}$. Any estimate not aimed at that defect is aimed at $\theta\mu$.
