# VERIFY_v204, Observation L22, cold read

*Verifier v204, verification loop. The brief [BRIEF_L22.md](BRIEF_L22.md) was read cold, before any other file. **No numerical work was done**, no script, no Sage, no Python, no numeric evaluation; the two places where hand arithmetic appears are labelled `SCREEN` and are seconds of pencil arithmetic on objects I constructed, reported as screens and never as evidence for a positive claim. Log: [agent_logs/verify-L22-v204.log](../agent_logs/verify-L22-v204.log).*

## Claim table

| # | claim, as the record states it | verdict |
| --- | --- | --- |
| 1 | $f'(\varphi)=3\sin\varphi\,\tilde f(\varphi)$ with $\tilde f(\pi/6)=(5\alpha+\sqrt3\gamma-3)/4$ | **PROVEN**, re-derived from Nienhaus's own $f$ |
| 2 | the required estimate is *exactly* $\gamma_{\max}(\alpha)<\frac{3-5\alpha}{\sqrt3}$ for every $\alpha<\tfrac13$ | **PROVEN, hypotheses corrected**: true, and two load-bearing steps are absent from the record |
| 3 | at $\alpha=\tfrac13$ the right side is $4/(3\sqrt3)$, borderline by construction | **PROVEN** |
| 4 | the exact identity $\alpha=\tfrac{1-s^2}3+s^2c_-^2\mu_N$, giving $s^2\le6\varepsilon/(3-c_0^2)$ | **PROVEN**, and the stated range $\mu_N\in[-1,-\tfrac16]$ uses only its upper end |
| 5 | "the configuration is forced": the maximiser has $c_0=1$ | **GAP**, asserted; and it is the *bound's* maximiser, not the estimate's |
| 6 | given $c_0=1$, $s^2=3\varepsilon$ is an **equality** | **PROVEN**, the equality is forced, not an inequality read as one |
| 7 | $M_{W_1}\Pi_{\ker}Q(W_1)=0$ makes the inner problem a hard-case trust region, globally solvable | **PROVEN**, and the import is dispensable; two lines give it directly |
| 8 | $V(t)$, $t^*=\tfrac34\sqrt{5/6}=\sqrt{30}/8$, $\alpha^*=32/141$, $A$ pinned at $\sqrt{5/6}$ | **PROVEN**, conditional on three measured inputs |
| 9 | "$V=\min$ of the two [branches] and a minimum has zero slope" | **BROKEN**, false as written, in two files; not load-bearing |
| 10 | the two branches cover complementary intervals, overlapping for **every $n\ge12$** | **GAP**, no closed form, no monotonicity, and the printed intervals miss the record's own worst-margin point |
| 11 | the sphere-product constant makes the estimate "conditional on the conjecture at critical points" | **HYPOTHESIS-DEBT**, the hypothesis is Conjecture A's entire non-trivial half, and the scope line names the wrong set |
| 12 | $M_{W_1}\Pi_{\ker}Q(W_1)=0$ verified at $n=12,14,16$; $n=20,24$ by zero-padding | **HYPOTHESIS-DEBT**, and the padding caveat is attached to the wrong object |
| 13 | the two constants $\sqrt{5/6}$ and $2/3$, which fix $t^*$ and $\alpha^*$ | **HYPOTHESIS-DEBT**, measured at $n=10$, below the claimed range, where padding makes them lower bounds |
| 14 | what a consumer may cite: [Lemma L20](../findings/route-a.md) and the tube argument "consume this block" | **the brief's premise is false**, they are one object, and it consumes neither L22 nor L102 |

**Verdict: HYPOTHESIS-DEBT.** The algebra of L22 is sound and I re-derived every displayed quantity independently and exactly; what the block calls an estimate that "holds for every $n\ge12$" is a conditional whose hypothesis is the inequality half of Conjecture A (the whole of its non-trivial content), resting further on two constants measured one dimension-family below the range they are used in, and on an interval-covering claim that has no closed form, no monotonicity proof, and whose two printed intervals fail to contain the block's own worst-margin point.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated:

- "**The competitor's operator and its blocks**: $u=W_{\mathbb{CP}^2}$ padded to unit norm, $\theta^*=P(u)=\sqrt{3/2}$, $F_u(h)=\tfrac12(uh+hu)+u\#h$, and $F_\lambda$ its restriction to the multiplicity space $M_\lambda$ of the $SO(n-4)$-isotypic $M_\lambda\otimes V_\lambda$. **$\alpha$ in [L21](../findings/route-a.md) and [L20](../findings/route-a.md) is $\sqrt{2/3}\langle F_uV,V\rangle$**, a Rayleigh quotient transverse to $\mathbb Ru$ and the orbit, *not the $\alpha$ parametrising the competitor family $W_{\mathcal S^4(\alpha)}$ in the same file.*"
- "$T$, third sense | **the fully symmetric trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ on $\mathcal W_n$**".
- "$\theta_0(n)$ | **the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.** *It is the value at the balanced sphere product **at even $n$ only**…*; the target of Problem P is $\Theta_n$."
- "**$m$ carries two objects inside [route-a.md](../findings/route-a.md), forty-seven lines apart**: the complementary dimension $n-4$ in the $SO(m)$-branching, and $\sqrt{2/3}\max P$ (the attained maximum), in the tube proof's own bootstrap."
- "**The letter $M$ carries two objects, and their norms differ by $\sqrt2$.**"

And from [nienhaus notes](../references/nienhaus-2023-second-best-einstein/notes.md), the object the whole block is about, which appears nowhere in [route-a.md](../findings/route-a.md) or [results.md](../results.md):

> "Let $10\le n\le11$. Then for any unit Weyl curvature operator $W\in\mathrm{Weyl}(n)$ that is perpendicular to $\mathbb R W_{\mathbb{CP}^2}\oplus T_{W_{\mathbb{CP}^2}}(SO(n).W_{\mathbb{CP}^2})$, the function $f(\varphi)=\sqrt{2/3}\,P(\cos\varphi\,W_{\mathbb{CP}^2}+\sin\varphi\,W)$ is strictly decreasing on $(0,\pi/6]$ with $f(\pi/6)<\sqrt{2/3}\,\Theta$."

## Hypothesis inventory

Everything the block's chain consumes, with where it is discharged. **H1–H4 are algebra I re-derived; H5–H10 are debts.**

| tag | hypothesis | where used | status |
| --- | --- | --- | --- |
| H1 | $T$ totally symmetric, $T(X,Y,Z)=\langle X\circ Y,Z\rangle$, $Q(X)=X\circ X$ | $A=\langle Q(W_1),K\rangle$; $M_{W_1}$ symmetric; the whole cubic expansion | [conventions.md](../findings/conventions.md), $T$ third sense, **cited at neither place in the block** |
| H2 | $u$ critical: $Q(u)=\theta^*u$ | kills the $3\cos^2\varphi\sin\varphi\,T(u,u,W)$ term of $f$ | true for the competitor; **stated nowhere in the block** |
| H3 | $W\perp\mathbb Ru\oplus T_u\mathcal O$, unit | the admissible set of 4.17 | Nienhaus's hypothesis, carried |
| H4 | $F_uW_1=\tfrac13\theta^*W_1$ and $W_1\perp W_2$ | the exact $\alpha$-identity's vanishing cross term | stated ✓ |
| H5 | $\mathrm{spec}(F_u/\theta^*)$ on the strictly negative part lies in $[-1,-\tfrac16]$ | $s^2\le6\varepsilon/(3-c_0^2)$ | [Lemma L21](../findings/route-a.md)'s census; **only the upper end $-\tfrac16$ is used, the $-1$ never** |
| H6 | $P\equiv0$ on $V_{1/3}$ | the closed form has **no** $\cos^3\beta\,P(W_1)$ term, and "this branch vanishes at $\tfrac13$" is exactly this | measured, $\le8\times10^{-16}$, at $n=10$; **unproven, and unnamed at the point of use** |
| H7 | $\sup T(W_1,W_1,K)=\sqrt{5/6}$, i.e. $\max\{\lVert Q(x)\rVert:x\in V_{1/3}\}=1$ | $a$ in $V(t)$; fixes $t^*$ and $\alpha^*$ | measured at $n=10$ over 78 basis vectors; **a supremum over a 78-sphere, not settled on a basis** ([L101](../findings/route-a.md) audit) |
| H8 | $\sup T(W_1,K,K)=2/3$ | $\lambda$ in $V(t)$; fixes $t^*$ and $\alpha^*$ | same, same objection |
| H9 | $M_{W_1}\Pi_{\ker}Q(W_1)=0$ for **every** $W_1\in V_{1/3}$ | the hard-case reduction; without it $V(t)$ is not the value | 40 random draws at $n=12$, fewer at $14,16$ ([L102](../findings/route-a.md) audit) |
| H10 | $\sup\{P(K):K\in\ker F_u\cap(\mathbb Ru\oplus T_u\mathcal O)^\perp,\ \lVert K\rVert=1\}\le\theta_0(n)$ | the third term $(3\varepsilon)^{3/2}\theta_0(n)$ | **Conjecture A's inequality half**; nothing on the record proves it |
| H11 | $a$ and $\lambda$ are attained at the same $W_1^*$ | licenses plugging both suprema into one $V(t)$ | asserted; this is precisely the coupling loss the block claims to have removed |
| H12 | Nienhaus's branch endpoint $E(n)$ falls with $n$ to a limit $\ge\alpha^*$ | the "every $n\ge12$" coverage | **no closed form for $E$ anywhere on the record**; three sampled values |

Two steps are used and stated nowhere, both true, both supplied in §1 below: the transfer of $\tilde f(\pi/6)<0$ to the whole interval $(0,\pi/6]$, and the second clause $f(\pi/6)<\sqrt{2/3}\Theta_n$.

## 1. The reduction, derived

With $X(\varphi)=\cos\varphi\,u+\sin\varphi\,W$ and $T$ the polarization of $P$,

$$P(X)=\cos^3\varphi\,P(u)+3\cos^2\varphi\sin\varphi\,T(u,u,W)+3\cos\varphi\sin^2\varphi\,T(u,W,W)+\sin^3\varphi\,P(W).$$

$T(u,u,W)=\langle Q(u),W\rangle=\theta^*\langle u,W\rangle=0$ by H2 and H3; $T(u,W,W)=\langle u\circ W,W\rangle=\langle F_uW,W\rangle$ by H1 and the convention's $F_u$. Multiplying by $\sqrt{2/3}$ and using $\sqrt{2/3}\,\theta^*=1$:

$$f(\varphi)=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma,\qquad\alpha=\sqrt{\tfrac23}\langle F_uW,W\rangle,\quad\gamma=\sqrt{\tfrac23}P(W),$$

which is [Lemma L20](../findings/route-a.md)'s expansion with $(\varphi,V)$ renamed. Differentiating,

$$f'(\varphi)=3\sin\varphi\Big[-\cos^2\varphi+\alpha(2\cos^2\varphi-\sin^2\varphi)+\gamma\sin\varphi\cos\varphi\Big],$$

so the factorisation $f'=3\sin\varphi\,\tilde f$ is exact with $\tilde f$ the bracket. At $\varphi=\pi/6$, $\cos^2=\tfrac34$, $\sin^2=\tfrac14$, $\sin\cos=\tfrac{\sqrt3}4$:

$$\tilde f(\pi/6)=-\tfrac34+\tfrac54\alpha+\tfrac{\sqrt3}4\gamma=\frac{5\alpha+\sqrt3\gamma-3}{4}.$$

**Claim 1 holds exactly.** And $\tilde f(\pi/6)<0\iff\sqrt3\gamma<3-5\alpha\iff\gamma<\frac{3-5\alpha}{\sqrt3}$, so the estimate is the sign of $f'$ at the single point $\pi/6$.

**The two steps the record needs and does not state.** Writing $c_2=\cos2\varphi$, $s_2=\sin2\varphi$, the bracket is $\tilde f=\tfrac12\big[(\alpha-1)+c_2(3\alpha-1)+\gamma s_2\big]$. For $\alpha<\tfrac13$ the coefficient $3\alpha-1$ is negative while $c_2$ decreases on $(0,\pi/6]$, so that term increases in $\varphi$; if $\gamma\ge0$ then $\gamma s_2$ increases too, whence $\tilde f(\varphi)\le\tilde f(\pi/6)$ on the whole interval and one point controls it. If $\gamma<0$, then $c_2\ge\tfrac12$ and $s_2>0$ give $\tilde f<\tfrac12\big[(\alpha-1)+\tfrac{3\alpha-1}2\big]=\tfrac{5\alpha-3}4<0$ outright. Either way $f$ is strictly decreasing on $(0,\pi/6]$. The second clause of 4.17 then follows for free: $f(0)=1$ and $f$ decreasing give $f(\pi/6)<1$, while $\sqrt{2/3}\Theta_n>1$ exactly for $n>6+2\sqrt7$, the crossover, so exactly for $n\ge12$. **So "exactly" in the block is right**, and the two steps that make it right are absent; the second of them is the same crossover the block never connects to its own range.

**The borderline.** At $\alpha=\tfrac13$: $\frac{3-5/3}{\sqrt3}=\frac{4/3}{\sqrt3}=\frac4{3\sqrt3}$. Nienhaus's $c=1$ cap gives $\gamma\le1$ and the requirement at $\alpha\to\tfrac13$ reads $1<\tfrac4{3\sqrt3}=0.7698$, which fails, the estimate is zero-margin there by construction, and with $c_n=\sqrt{2/3}\theta_0(n)>1$ from $n=12$ it fails strictly. **Claim 3 holds**, and the "$c=1$" is $\sqrt{2/3}\theta^*$, so the crossover $n=6+2\sqrt7\approx11.29$ is exactly where the premise dies. No integer sits on it.

## 2. "The configuration is forced", what is derived and what is asserted

**The $\alpha$-identity is exact.** With $W=cW_1+sW_2$, $W_2=c_0K+c_-N$, $K\in\ker F_u$, $F_uW_1=\tfrac13\theta^*W_1$:

$$\alpha=\sqrt{\tfrac23}\big[c^2\tfrac13\theta^*+s^2c_-^2\langle F_uN,N\rangle\big]=\frac{1-s^2}3+s^2c_-^2\mu_N,$$

the $K$-terms dying because $F_uK=0$ and the cross terms because $W_1\perp W_2$. Then $\varepsilon=\tfrac13-\alpha=s^2\big(\tfrac13+c_-^2\lvert\mu_N\rvert\big)$, and $\lvert\mu_N\rvert\ge\tfrac16$ minimises the bracket at $(3-c_0^2)/6$, giving $s^2\le6\varepsilon/(3-c_0^2)$. **Claim 4 holds**, and only the $-\tfrac16$ end of H5 is used, the $-1$ end is stated and never used.

**Claim 6 holds, and the brief's suspicion resolves in the record's favour.** At $c_0=1$ one has $c_-=0$, so the $\mu_N$ term is not *bounded* but *absent*: $\varepsilon=s^2/3$ identically. The equality is forced by the configuration, not an inequality misread.

**Claim 5 is asserted, and it is not obvious.** With the table's rows, the objective is
$$\sqrt{\tfrac32}\,\gamma=3c^2s\,c_0A_0+3cs^2\big[c_0^2B_0+c_-^2C_0\big]+s^3P(W_2),\qquad A_0\le\sqrt{\tfrac56},\ B_0\le\tfrac23,\ C_0\le\sqrt{\tfrac23},$$
the cross terms $T(W_1,W_1,N)$ and $T(W_1,K,N)$ vanishing by two more measured rows. Pushing $c_-$ up costs the leading term its factor $c_0$ and shrinks the admissible $s$, but **gains** in the middle term, because $\sup T(W_1,N,N)=\sqrt{2/3}$ is strictly larger than $\sup T(W_1,K,K)=2/3$. So $c_0=1$ is a genuine optimisation with a competing term, and the block's own sentence ("the two pull against each other"), describes a different tension (independent suprema) and supplies no argument for the maximiser. `SCREEN`: a first-derivative check in $x=c_-^2$ at $x=0$, at the worst $\varepsilon$ of the branch's range, makes all three terms decreasing in $x$; that is a screen at one endpoint of one variable, not a proof, and I record it only to say the claim is not obviously false. **The record's own earlier copy is more careful than the block**: [route-a.md](../findings/route-a.md) line 480 says "*The bound*, in closed form. Its maximiser is always $c_0=1$" (a property of the upper bound) while the L22 block promotes this to "**the maximiser** has $W_2$ lying entirely in $\ker F_u$" and "the configuration is forced", which asserts a property of the extremal configuration of $\gamma$ itself. **That promotion is unsupported**, and it is the sentence a consumer would read.

## 3. The frontier, the import checked, then bypassed

**The imported theorem, hypothesis by hypothesis.** The standard trust-region result maximises $\langle q,K\rangle+t\langle MK,K\rangle$ over a ball in a finite-dimensional real inner-product space with $M$ symmetric, the "hard case" being $q\perp$ the top eigenspace. Against this object: the space is $\ker F_u\subset\mathcal W_n$, finite-dimensional ✓; $M_{W_1}$ is symmetric **because $T$ is totally symmetric** (H1, cited at neither place) ✓; the constraint is the *sphere* $\lVert K\rVert=1$, not the ball, and the two agree because $\lambda_{\max}(M_{W_1})=\tfrac23>0$ puts the maximum on the boundary ✓; and the record's condition $M_{W_1}q=0$ is **strictly stronger** than the hard-case condition, since annihilation implies orthogonality to every eigenspace with nonzero eigenvalue ✓. So the import survives, unlike the unital-algebra import that killed an earlier route.

**And it is dispensable, which is the better answer.** Put $q=\Pi_{\ker}Q(W_1)$, $a=\lVert q\rVert$, $\hat q=q/a$. For unit $K=x\hat q+yw$ with $w\perp\hat q$,
$$A+tB=\langle q,K\rangle+t\langle M_{W_1}K,K\rangle=ax+t\big[y^2\langle M_{W_1}w,w\rangle+2xy\langle M_{W_1}\hat q,w\rangle\big]=ax+ty^2\langle M_{W_1}w,w\rangle,$$
the last step by $M_{W_1}\hat q=0$. Maximising over $w\perp\hat q$ gives $\lambda:=\lambda_{\max}$, whose eigenvector is automatically $\perp\hat q$; so with $x^2+y^2=1$ the value is $\max_{x\in[-1,1]}\{ax+t\lambda(1-x^2)\}$. The interior stationary point $x=a/(2t\lambda)$ is admissible exactly when $t\ge a/(2\lambda)$, and then the value is $\frac{a^2}{4t\lambda}+t\lambda$; below that, $x=1$, $K=\hat q$, and the value is $a$ with $B=\langle M_{W_1}\hat q,\hat q\rangle=0$. With $a=\sqrt{5/6}$ and $\lambda=\tfrac23$:

$$t^*=\frac a{2\lambda}=\frac34\sqrt{\tfrac56}=\frac{\sqrt{30}}8,\qquad \frac{a^2}{4t\lambda}+t\lambda=\frac{5/6}{8t/3}+\frac{2t}3=\frac5{16t}+\frac{2t}3 .$$

**Both of the block's displayed quantities fall out exactly, and $A$ is pinned at $a=\sqrt{5/6}$ on the flat branch.** Two structural checks pass: $V$ is a maximum of functions affine in $t$, hence convex, and the piecewise formula is convex ✓; its slope is the maximiser's $B$, rising from $0$ to $\lambda=\tfrac23=\sup B$ ✓.

**Where $M\hat q=0$ is load-bearing, precisely.** It is used twice, to kill the cross term $2xy\langle M\hat q,w\rangle$, and to give $B=0$ on the flat branch. Mere orthogonality to the top eigenspace does neither; that is the same point [Observation L102](../findings/route-a.md)'s audit makes, and my derivation confirms it independently.

**$\alpha^*$, exactly.** With $s^2=3\varepsilon$ and $c^2=1-3\varepsilon$, $t^2=3\varepsilon/(1-3\varepsilon)$, so $t\le t^*\iff32\cdot3\varepsilon\le15(1-3\varepsilon)\iff141\varepsilon\le15\iff\varepsilon\le\tfrac5{47}$, i.e. $\alpha\ge\tfrac{47}{141}-\tfrac{15}{141}=\tfrac{32}{141}$. **Claim 8 holds**, conditional on H7, H8, H9 and on claim 5's $c_0=1$, since $\alpha^*$ is computed from $s^2=3\varepsilon$ as an equality.

**Claim 9 is false as written.** The block ends the paragraph: "*so $V=\min$ of the two and a minimum has zero slope*", and [L22.lean](../lean/HamiltonsCubic/Results/L22.lean)'s docstring repeats it: "*So `V = min(√(5/6), 5/(16t) + 2t/3)`*".

- **Located**: [route-a.md](../findings/route-a.md) line 556, and the Lean docstring's line after its bullet list.
- **Exhibited in closed form**: by AM–GM, $\frac5{16t}+\frac{2t}3\ge2\sqrt{\frac5{16}\cdot\frac23}=\sqrt{5/6}$ for every $t>0$, so $\min$ of the two is the constant $\sqrt{5/6}$ *identically*, contradicting the piecewise definition. Concretely at $t=\tfrac34$, which the record itself evaluates: $\frac5{12}+\frac12=\frac{11}{12}$, and $\left(\frac{11}{12}\right)^2=\frac{121}{144}>\frac{120}{144}=\frac56$. Exact, rational, strict.
- **Argued the opposite**: the immediately preceding clause ("the constant branch is the minimum of the other"), states the true fact, and the Lean file's *theorems* are all correct rational arithmetic. So this is a restatement slip, and nothing downstream uses it: $t^*$ and $\alpha^*$ come from $a/b$ and $4ab$, both independently correct.
- **Verdict**: real, reported, **non-load-bearing**. The correct sentence is that the hyperbola's minimum value equals the constant branch and is attained at $t^*$, so the branches meet there with both slopes zero. $V$ is neither the min nor the max of the two; it is below the hyperbola on $t<t^*$ and equal to it after.

## 4. The circularity, which is the central question

**Exactly which quantity the sphere-product value stands in for.** The third term of the closed form is $\sin^3\!\beta\;\sqrt{2/3}\,P(W_2)$ with $W_2=K$ a **unit Weyl operator in $\ker F_u\cap(\mathbb Ru\oplus T_u\mathcal O)^\perp$**. The block replaces $P(K)$ by $\theta_0(n)$. So the borrowed quantity is

$$\sup\{P(K):K\in\ker F_u\cap(\mathbb Ru\oplus T_u\mathcal O)^\perp,\ \lVert K\rVert=1\}\ \le\ \theta_0(n),$$

equivalently $\gamma(K)\le c_n=\sqrt{2/3}\,\theta_0(n)$. **The weaker statement that would suffice** is any upper bound $C$ on that restricted supremum for which the resulting cubic in $\sigma=\sqrt{3\varepsilon}$ stays positive on the branch's range, the requirement enters only through the coefficient $(\sqrt5-C)\sigma^3$ of

$$\Phi(\sigma)=\frac4{3\sqrt3}+\frac5{3\sqrt3}\sigma^2-\sqrt5\,\sigma+(\sqrt5-C)\,\sigma^3>0 ,$$

so any $C\le2/\sqrt3=\lim_n c_n$ that keeps $\Phi>0$ does the job for every $n$ at once, since $c_n$ is increasing in $n$ with that limit and $\Phi$ is decreasing in $C$. **Three genuine weakenings are available and the record takes none of them**: the restriction to $\ker F_u$ rather than all of $\mathcal W_n$; an inequality rather than Conjecture A's equality; and a constant looser than $\theta_0(n)$, since the requirement carries slack away from the branch endpoint.

**What it is, of the three the brief names.** Not a theorem. Not a conditional a reader could discharge independently either, in any useful sense: $\max P\ge\Theta_n$ is free from the sphere-product witness, so the *entire* non-trivial content of Conjecture A is the inequality $\max P\le\Theta_n\le\theta_0(n)$, which is what H10 borrows, weakened only by the subspace restriction, whose bite is nowhere quantified on the record. **It is a conditional statement whose hypothesis is the goal**, and it is an assumption of the conclusion the moment anything aiming at Conjecture A consumes it.

**And the scope line names the wrong set.** The block says "conditional on the conjecture **at critical points** past $n=12$". H10 quantifies over a *linear subspace*, whose supremum is attained at a critical point of $P|_{\ker F_u}$, not at a critical point of $P$. To get H10 from a statement about critical points of $P$ one must go through the global bound $P\le\theta_0(n)$ on the whole unit sphere, i.e. Conjecture A entire. So the scope sentence understates its own hypothesis on the restricted reading and is Conjecture A on the unrestricted one; either way it is not "the conjecture at critical points".

**Is it deductively circular on this record?** No, because nothing consumes it, see §6. But the direction of the dependence is fixed and must be recorded: **a proof of Conjecture A may not route through L22**, and neither may anything L22 would be used to establish. Note further that repairing 4.17 does **not** make Nienhaus's Theorem 4.19 unconditional: its second case invokes Conjecture A by name ([notes.md](../references/nienhaus-2023-second-best-einstein/notes.md), L4854–4860), so the localization theorem is conditional on the conjecture whatever happens to 4.17. The block's opening sentence ("what stops it above $11$ is a single estimate"), is therefore wrong about 4.19 and right only about 4.17.

## 5. The two branches, and the gap

**The claim.** Nienhaus's branch covers $\alpha\le E(n)$ with $E(12)=0.322271$, $E(16)=0.290168$, $E(100)=0.234970$, "falling with $n$"; the frontier branch covers $\alpha\ge\alpha^*=32/141=0.226950$, independent of $n$; "the two overlap for **every $n\ge12$**, with worst margin $+0.0074$ at $\alpha\approx0.223$ in the limit".

**What is on the record for $E$.** Three sampled values, all at **even** $n$. **No closed form for $E(n)$ appears anywhere in [route-a.md](../findings/route-a.md), [results.md](../results.md), or the Nienhaus notes.** No proof that $E$ falls. No value for $\lim E$. The union covers $(0,\tfrac13)$ at a given $n$ iff $E(n)\ge\alpha^*$, so the whole "every $n\ge12$" rests on $\inf_{n\ge12}E(n)\ge\alpha^*$, a statement about a quantity with no definition on file. **This is the GAP, and it is where the estimate lives or dies, exactly as the brief says.**

**The printed intervals do not contain the block's own worst-margin point.** $0.223<32/141$ exactly ($141\cdot223=31443<32000$), and the block places its worst margin there. As printed, $\alpha\approx0.223$ in the limit is covered by neither branch, so "they overlap for every $n\ge12$" and "worst margin at $\alpha\approx0.223$" cannot both be read at face value. The block's own audit note reaches this far and stops at "either the margin is between quantities other than the two coverage endpoints, or one figure is off".

**I can say which horn, and it is the first.** `SCREEN`, pencil arithmetic on the record's own closed forms, reported as a screen: at $c=\lim c_n=2/\sqrt3$ and $\alpha=0.223$, the frontier bound $\sqrt{2/3}\big[3c^2sV(t)+s^3\theta_0\big]$ evaluates to about $1.081$ against a requirement of about $1.088$, a margin of about $+0.008$. So $+0.0074$ is a **margin in $\gamma$, at the handover point, in the limit**, not a margin between coverage endpoints in $\alpha$. Two consequences follow, and both are findings rather than repairs:

- **The printed coverage table understates the frontier branch.** $\alpha^*$ is where $B$ turns *on*, not where the branch fails; the same screen still clears the requirement below $\alpha^*$ and turns negative only near $\alpha\approx0.19$. The block conflates "where $B=0$" with "where the estimate is established", and states the first while claiming the second.
- **The margin figure implies $\lim E\approx0.223<\alpha^*$.** Under the printed coverage that is an uncovered interval $[\lim E,\alpha^*)$ at large $n$; it is harmless only under the unstated extended reach. **The record never states which of its own two sentences is the operative one.**

**The cheapest repair, named without doing it.** The frontier branch reduces to a one-variable cubic positivity statement, $\Phi(\sigma)>0$ on $\sigma\in(0,\sigma_{\max}]$ at the single constant $C=2/\sqrt3$, whose coefficients are $\tfrac4{3\sqrt3},\tfrac5{3\sqrt3},-\sqrt5,\sqrt5-\tfrac2{\sqrt3}$. Because $c_n$ increases to $2/\sqrt3$ and $\Phi$ decreases in $C$, one such statement covers **every** $n\ge12$ at both parities, and it is decidable by exact means over a real closed field. That converts H12 for one branch into analysis. It does nothing for H7–H10, and nothing for $E(n)$, which needs Nienhaus's own bound written down in closed form as a function of $c$ first.

## 6. What a consumer may cite, and the brief's own premise is false

The brief states that "[Lemma L20](../findings/route-a.md) and the tube argument both consume this block". **They are the same object** (L20 *is* the tube argument, the heading of Route R1) and it consumes neither L22 nor L102. Its proof, which I read in full, uses $\alpha\le\tfrac13$ from [Lemma L21](../findings/route-a.md) and the self-bootstrap $\gamma_V\le m$ with $m=\sqrt{2/3}\max P$ the *attained* maximum; the record states this explicitly ("**Nine inputs, of which one is not proved**: $\alpha\le\tfrac13$… *It invokes neither [Observation L22] nor [Observation L102] nor any a priori cap*"). The block's own canonical entry says the same. **So nothing on this record consumes L22, and its blast radius is zero.**

What a consumer may legitimately cite is therefore narrow: *for even $n\in\{12,14,16\}$, and granting H6–H11 at that $n$ together with H10's bound $P\le\theta_0(n)$ on $\ker F_u$, the closing estimate of Nienhaus's Theorem 4.17 holds on $[\alpha^*,\tfrac13)$, and Theorem 4.17's monotonicity and value clauses follow.* It may **not** be cited for every $n\ge12$, nor at odd $n$, nor as an input to anything whose conclusion is Conjecture A or which is itself consumed by such an argument.

**The record's three copies disagree, and none is right.** [results.md](../results.md) line 725 says flatly "**For every $n\ge12$ that estimate holds**", contradicting its own heading "at $n=12,14,16$" four words earlier. Line 236 carries the conditionality correctly. Line 41 attributes the conditionality to "**the eigenvalue bound $\alpha\le\tfrac13$**", that is [Lemma L21](../findings/route-a.md)'s debt, which L20 carries and **L22's constant has nothing to do with**; L22's condition is H10. So the summary line names the wrong hypothesis, and it also bundles L22 into "Lemmas 20–22" while the same file relabels it an Observation.

## 7. The traps, each answered by name

- **$\ker W\ne0$ and padded objects.** Bites, and twice. $u$ is a padded $W_{\mathbb{CP}^2}$, so $\ker u$ and $\ker F_u$ are large and grow with $n$, and the entire inner problem lives in $\ker F_u$. **What zero-padding can establish**: the embedding $\mathcal W_{12}\hookrightarrow\mathcal W_m$ is compatible with $Q$, $T$ and $F_u$ on index-disjoint blocks, so for a *padded pair* $(W_1,K)$ every displayed identity transfers verbatim to $m=14,16,20,24$, including $M_{W_1}\Pi_{\ker}Q(W_1)=0$, the new components of $Q(W_1)$ and of $M_{W_1}q$ vanish because their third slot is supported outside the $12$-block. **What it cannot**: (i) it says nothing about the $W_1\in V_{1/3}(\mathcal W_m)$ that are not padded, which are the overwhelming majority of a space whose dimension grows with $m$, while H9 is a *universal* claim over that space; (ii) for a *supremum* it gives only $\sup_m\ge\sup_{12}$, a lower bound, and H7/H8 are used as **caps**. **The block's scope paragraph attaches the caveat to the wrong object**: it writes the "monotonicity in $n$ as a lower bound" gloss against the vanishing, where the right caveat is (i), and never states it against the two constants, where (ii) is exactly what bites.
- **The boundary of every stated range.** $n=12$: the first integer past $6+2\sqrt7\approx11.29$, so $c_n>1$ from there and no integer sits on the crossover ✓. $\alpha=\tfrac13$: requirement $4/(3\sqrt3)>0$ while the bound $\to0$, but "this branch vanishes at $\tfrac13$" is precisely H6, $P\equiv0$ on $V_{1/3}$, which is measured and unproven; at $\varepsilon=0$ the bound is $\sqrt{2/3}\,P(W_1)$ and nothing else, so the block's cleanest sentence is carried entirely by its least visible hypothesis. $\alpha=\alpha^*$: both branch formulas agree and $V$ is $C^1$, no discontinuity ✓. $t=t^*$: verified exactly, twice ✓. $\varphi=\pi/6$: handled in §1, the single-point estimate does transfer to the interval, by an argument the record does not give. $n=6+2\sqrt7$: the crossover is the reason the $f\le1$ premise dies and the reason the second clause of 4.17 is free; the block never connects it to either.
- **Proven on a subfamily, used in general.** Three instances. H7 and H8 are measured at $n=10$, *below* the range $n\ge12$ in which they are used as caps, with padding monotonicity pointing the wrong way. H9 is measured on 40 random draws and asserted for every $W_1$. And **every dimension quoted anywhere in the block is even** ($12,14,16,20,24,100$), while the claim runs over every $n\ge12$; at odd $n$, $\theta_0(n)>\Theta_n$, so H10's constant is conservative there, but the branch endpoints $E(n)$ have no odd-$n$ instance on the record. This is the same odd-$n$ hole that was caught in [Lemma L20](../findings/route-a.md)'s final step and not propagated here.
- **A hypothesis stated but never used.** $\mu_N\ge-1$: the range $[-1,-\tfrac16]$ is stated, only the $-\tfrac16$ end enters.
- **A step using a hypothesis never stated.** Six: total symmetry of $T$ (H1, needed for $M_{W_1}$ symmetric and for $A=\langle Q(W_1),K\rangle$); criticality of $u$ (H2); $P\equiv0$ on $V_{1/3}$ (H6, used by the *absence* of a term); $\lambda_{\max}>0$ for sphere-versus-ball; the monotone transfer off $\varphi=\pi/6$; and $f(\pi/6)<1<\sqrt{2/3}\Theta_n$ for 4.17's second clause.
- **A universal claim with no witness.** H9 ("for every $W_1$ in the eigenspace"), supported by 40 random draws at $n=12$ and fewer at $14,16$. H7 and H8 are suprema over a $78$-sphere read off $78$ basis vectors.
- **An imported theorem whose hypotheses were never checked.** Checked in §3 against this object; the trust-region import survives, unlike the unital-algebra import that killed an earlier route, and it turns out to be dispensable, the value function following in two lines from $M\hat q=0$.
- **Symbol collisions.** The block writes $W$ for the *transverse* direction where [conventions.md](../findings/conventions.md) fixes $V$ for it and $W$ for a Weyl operator, and the block then uses $W$ in both senses, since $\gamma=\sqrt{2/3}P(W)$ is the transverse one and $\gamma_{\max}$ ranges over Weyl operators. $\alpha$ collides with the competitor family $W_{\mathcal S^4(\alpha)}$ in the same file; $\gamma$ with the tabled $S^{\mathrm{ord}}_{\mathfrak{mhh}}-S^{\mathrm{ord}}_{\mathfrak{mmm}}$ and with $\gamma_V$; $A$ and $B$ are here the two couplings, a further pair of senses on letters the table already flags three times over, and $A$ is also $\Lambda^2\mathbb R^4$ in [Lemma L21](../findings/route-a.md)'s branching in this same file; $t$ is $\tan\beta$ here and the path parameter of L134–L136 there; $s$ collides with L134's $s_i$; $M$ is $M_{W_1}$, **defined nowhere**, against the tabled sectional matrix and against $M_\lambda$ the multiplicity space in this file; and $F$ appears bare in $\mu_N=\langle FN,N\rangle/\theta^*$ while $F$ is the scalar of L17's equality cone $\{F=0\}$ throughout the surrounding file, with $F_{W_1}$ used in the constants table for what the block calls $M_{W_1}$. **And $m$ carries a third sense here**, beyond the two [conventions.md](../findings/conventions.md) tables: "zero-padding the $n=12$ pair into $m=14,16,20,24$" makes $m$ the ambient dimension itself, where the table gives $n-4$ and $\sqrt{2/3}\max P$.

## 8. What would break it, and what I did to look

Four objects, any one of which falsifies the statement:

1. **A unit $W_1\in V_{1/3}$ at some $n\ge12$ with $\lVert Q(W_1)\rVert>1$**, equivalently $\lVert\Pi_{\ker}Q(W_1)\rVert>\sqrt{5/6}$. It raises $a$, raises $V$ on both branches, moves $t^*$ and $\alpha^*$, and the branch's own margin at the handover is under one per cent, so a small excess suffices. Nothing on the record excludes it above $n=10$, and padding monotonicity says the supremum can only rise with $n$.
2. **A unit $W_1\in V_{1/3}$ with $M_{W_1}\Pi_{\ker}Q(W_1)\ne0$.** Then $K=\hat q$ gives $A+tB=a+t\langle M\hat q,\hat q\rangle$, which exceeds $V(t)$ on the flat branch whenever that quadratic form is positive; the closed form is not merely unproven but false.
3. **A unit $K\in\ker F_u\cap(\mathbb Ru\oplus T_u\mathcal O)^\perp$ with $P(K)>\theta_0(n)$.** This breaks H10, and is simultaneously a counterexample to Conjecture A, which is precisely why L22 must never feed an argument aimed at the conjecture.
4. **A finite $n\ge12$ with $E(n)<\alpha^*$** and the frontier bound failing below $\alpha^*$ at that $n$: an uncovered $\alpha$, and the estimate is false for that dimension. The record's own worst-margin location, $\alpha\approx0.223<32/141$, is where such an $n$ would first appear.

**What I did to look.** I read the block, both other copies, [Observation L102](../findings/route-a.md), [Lemma L101](../findings/route-a.md), the constants table, [Lemma L20](../findings/route-a.md)'s proof in full, [Lemma L21](../findings/route-a.md), [conventions.md](../findings/conventions.md), [L22.lean](../lean/HamiltonsCubic/Results/L22.lean) and the [Nienhaus notes](../references/nienhaus-2023-second-best-einstein/notes.md), for any exhibited witness, closed-form exclusion, or dimension-free argument bearing on 1–4. **There is none**: the only exclusions on file are an $n=10$ basis sweep for 1, 40 random draws for 2, Conjecture A itself for 3, and three sampled values of $E$ for 4. I ran **no search, sweep or census** for any of them, under this programme's analysis-only rule that work is reserved, and for 1 and 2 it is exactly the kind of search that would need the user's approval. The only arithmetic I did is the two passages labelled `SCREEN`, on objects I constructed from the record's own closed forms.

## Verdict

**HYPOTHESIS-DEBT.**

The displayed algebra is correct and I re-derived all of it independently: the factorisation $f'=3\sin\varphi\,\tilde f$ and $\tilde f(\pi/6)=(5\alpha+\sqrt3\gamma-3)/4$; the borderline $4/(3\sqrt3)$; the exact $\alpha$-identity and $s^2\le6\varepsilon/(3-c_0^2)$; the forced equality $s^2=3\varepsilon$ given $c_0=1$; the hard-case value function $V$, the breakpoint $t^*=\sqrt{30}/8$ and the threshold $\alpha^*=32/141$, all from $M\hat q=0$ in two lines without the imported theorem. **What the block does not have is a claim.** Its constant is Conjecture A's inequality half (H10); two more of its constants are measured at $n=10$ and used as caps at $n\ge12$ where padding makes them lower bounds (H7, H8); its central vanishing is 40 random draws standing for a universal claim (H9); the term that makes it "vanish at $\tfrac13$" is a fourth measured vanishing (H6); "the configuration is forced" is a property of the bound promoted to a property of the maximiser; and the interval-covering statement rests on a function $E(n)$ that is nowhere defined, with the record's own worst-margin point lying outside both printed intervals. One sentence is outright false ("$V=\min$ of the two"), in [route-a.md](../findings/route-a.md) and in [L22.lean](../lean/HamiltonsCubic/Results/L22.lean)'s docstring, and it is not load-bearing.

**Recommended record changes**, none of which needs computation: replace the two "$V=\min$" sentences with "the hyperbola's minimum value is the constant branch, attained at $t^*$"; move the padding caveat from the vanishing to the two constants and add the $n=10$ provenance where they are used; state H10 in the restricted form it is actually used in, and drop "at critical points"; correct [results.md](../results.md) line 41, which names the wrong hypothesis; reconcile line 725's "for every $n\ge12$" with its own heading; and say what the $+0.0074$ margin is a margin between.
