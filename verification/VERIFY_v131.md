# Lemma L36, the isotropy cap $\lfloor n^2/4\rfloor$, its Casimir lower bound, its maximiser at both parities, and the $S=0$ bridging clause

*Verifier v131, [ROUND_L36](ROUND_L36.md), 2026-09-07. Worked cold from the brief as dispatched, and from the sources it names: [findings/isotropy-cap.md](../findings/isotropy-cap.md), [results.md](../results.md):158 and :489, [Lemma L153](../findings/bounds.md), [conventions.md](../findings/conventions.md), [ungraded-slack.md](../findings/ungraded-slack.md), [ATTEMPTS.md](../ATTEMPTS.md)'s slack decomposition, and [lean/INDEX.md](../lean/INDEX.md). **No numerical work: no script was run, and every value below is an exact hand evaluation.** Log: [agent_logs/verify-L36-v131.log](../agent_logs/verify-L36-v131.log). No other verifier's report was read.*

## Claim table

| # | claim, as the block states it | verdict |
| --- | --- | --- |
| 1 | $\dim\mathfrak m\le\lfloor n^2/4\rfloor$ for every isotropic $\mathfrak m\subseteq\mathfrak{so}(n)$, at every $n\ge3$ | **PROVEN**, rebuilt here from the two steps, both correct |
| 2 | the Killing block identity $2\mu+\gamma=2(n-2)d$, "which is [Lemma L153](../findings/bounds.md) summed over the $d$ rows of $\mathfrak m$" | **PROVEN**, provenance correct, but the identity **consumes isotropy** and the block's sentence credits isotropy to the following inequality instead |
| 3 | $T(A)=-\sum_k\mathrm{ad}(f_k)A\,\mathrm{ad}(f_k)=2(n-2)\mathrm{Id}-\tfrac12\mathrm{Cas}$ | **CONFIRMED**, derived here in three lines |
| 4 | the spectrum $2n-4,\ n-4,\ -2,\ 4$ on $\mathbb R\oplus\mathrm{Sym}^2_0\oplus\mathrm{Weyl}_n\oplus\Lambda^4$ | **CONFIRMED at every $n\ge3$** by $c(\lambda)=\langle\lambda,\lambda+2\rho\rangle$, including the four low ranks where $\Lambda^4$ is not $\epsilon_1{+}\epsilon_2{+}\epsilon_3{+}\epsilon_4$ |
| 5 | $\mu\ge4d^2/n-2d$ for **every** $d$-dimensional subspace | **PROVEN**, and it is an **equality** at $d=\binom n2$, at the maximal torus when $n$ is even, and at the cap when $n$ is even |
| 6 | equality attained by the mixed planes $\mathbb R^p\otimes\mathbb R^q$, $p=\lceil n/2\rceil$; sharpness at both parities | **PROVEN**, isotropy is $K_{p,q}$ triangle-free, and $\lceil n/2\rceil\lfloor n/2\rfloor=\lfloor n^2/4\rfloor$ identically |
| 7 | "$-2$ is $T$'s only negative eigenvalue" | **FALSE at $n=3$** ($T=-1$ on $\mathrm{Sym}^2_0$, and $\mathrm{Weyl}_3=0$). The cap survives. **The correction stands 20 lines below, outside the citable block**, the record's named trap, live |
| 8 | "isotropic, **which the negative eigenspace of a Weyl operator with $S=0$ is**" | **HYPOTHESIS-DEBT, criticality.** The argument is on file ([ATTEMPTS.md](../ATTEMPTS.md), $S=T_1+2T_2+T_3$) and holds **only at critical points**; all three forms of L36 omit $Q(W)=\theta W$ |
| 9 | the converse fails at $n=3$ | **CONFIRMED**, and **no consumer needs it**, every use runs forward |
| 10 | equality forces $\gamma=0$ at even $n$; odd $n$ open | **CONFIRMED**, and the odd-$n$ slack is exactly $\gamma\le2d/n$ |
| 11 | [results.md](../results.md):158, read alone: "attained by the balanced symmetric pair" | **GAP**, it is the one surviving form that names no admissible object at odd $n$, and carries no correction |
| 12 | [lean/INDEX.md](../lean/INDEX.md):267, L36 row, **partial**, "the cap itself is owed" | **row is accurate**, it claims the parity identity and the maximiser's inadmissibility, not the cap |

**Summary.** The cap and everything the proof does with isotropic subspaces is correct and I rebuilt all of it by hand; what the block owes is the hypothesis on its one non-cap sentence, the clause carrying $S=0$ into isotropy needs $Q(W)=\theta W$, which is on the record at [ATTEMPTS.md](../ATTEMPTS.md) and stated in none of the three forms, plus an $n\ge4$ on the "one eigenvalue" gloss and a maximiser at odd $n$ in [results.md](../results.md):158.

**Verdict: PROVEN, hypotheses corrected.**

## 0. Conventions, fixed once

Everything below is in the record's own normalisation, which is [conventions.md](../findings/conventions.md)'s.

- **The algebra and its pairing.** $\mathfrak{so}(n)\cong\Lambda^2\mathbb R^n$ with $\langle X,Y\rangle=-\tfrac12\operatorname{tr}(XY)$, so $\varphi_{ij}=E_{ij}-E_{ji}$ has $\lVert\varphi_{ij}\rVert=1$ and $\operatorname{tr}(v^2)=-2\lVert v\rVert^2$. Write $N=\dim\mathfrak{so}(n)=\binom n2$.
- **The bracket in coordinates.** $[\varphi_{12},\varphi_{23}]=\varphi_{13}$, computed from $E_{ab}E_{cd}=\delta_{bc}E_{ad}$: $\varphi_{12}\varphi_{23}=E_{13}$, $\varphi_{23}\varphi_{12}=E_{31}$, difference $\varphi_{13}$.
- **The Cartan 3-form and structure constants.** $\omega(x,y,z)=\langle[x,y],z\rangle$; in an orthonormal basis $\{x_a\}$ of $\mathfrak{so}(n)$, $c_{abc}=\langle[x_a,x_b],x_c\rangle$ is **totally antisymmetric**, and $T_{abc}=c_{abc}^2$ totally symmetric. Sums run over **ordered** tuples, which is [conventions.md](../findings/conventions.md)'s standing default.
- **Isotropic** means $c_{abc}=0$ whenever all three indices lie in $\mathfrak m$.
- **The block masses.** With $\mathfrak h=\mathfrak m^\perp$, write $T_{mmm}=\sum_{a,b,c\in\mathfrak m}c_{abc}^2$, $T_{mmh}=\sum_{a,b\in\mathfrak m,\,c\in\mathfrak h}c_{abc}^2$, $T_{mhh}=\sum_{a\in\mathfrak m,\,b,c\in\mathfrak h}c_{abc}^2$. Against the record's unordered $S_{XYZ}$ of [Lemma L114](../findings/bounds-relaxations.md) these are $T_{mmm}=6S_{\mathfrak{mmm}}$, $T_{mmh}=2S_{\mathfrak{mmh}}$, $T_{mhh}=2S_{\mathfrak{mhh}}$, by counting orderings, 6, 2 and 2 respectively.
- **The block's two letters.** $\mu(\mathfrak m)=\sum_{a,b\in\mathfrak m}\lVert[e_a,e_b]\rVert^2$ and $d=\dim\mathfrak m$; $\gamma$ is the $\mathfrak{hhm}$ mass, which is $T_{mhh}$, the two agree because $c$ is antisymmetric, so $c_{aij}=\langle[e_a,h_i],h_j\rangle=\langle[h_i,h_j],e_a\rangle$ and $T_{mhh}=\sum_{i,j\in\mathfrak h}\lVert P_{\mathfrak m}[h_i,h_j]\rVert^2$.
- **$\mathrm{Sym}(\mathfrak{so}(n))$** means the symmetric endomorphisms of $\mathfrak{so}(n)$, paired by $\langle A,B\rangle=\operatorname{tr}(AB)$; $\lVert\mathrm{Id}\rVert^2=N$.
- **Casimir normalisation.** $\mathrm{Cas}=-\sum_k\rho(f_k)^2$ over an orthonormal basis $\{f_k\}$ of $\mathfrak{so}(n)$, which puts $\mathrm{Cas}=2(n-2)$ on the adjoint, the same $\kappa=2(n-2)$ [conventions.md](../findings/conventions.md) records.
- **Weights.** $\rho_i=(n-2i)/2$ for $\mathfrak{so}(n)$ at either parity, and $c(\lambda)=\langle\lambda,\lambda+2\rho\rangle$ in the $\epsilon$-orthonormal form. This is calibrated, not assumed: at $\lambda=\epsilon_1+\epsilon_2$ it returns $2+(n-2)+(n-4)=2n-4$, which is the adjoint value above.
- **$S(W)$** is [ungraded-slack.md](../findings/ungraded-slack.md)'s gradedness slack $S(W)=\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2-\theta\operatorname{tr}(W_-)-\operatorname{tr}(W_-^2)$, and $E_-$ the **strictly** negative eigenspace, $Wv_i=-\mu_iv_i$ with $\mu_i>0$.

## 1. The hypothesis inventory

**What the block carries in its own statement.** One hypothesis only: $\mathfrak m\subseteq\mathfrak{so}(n)$ isotropic for the Cartan 3-form. The block adds "Sharp, every $n\ge3$, no genericity hypothesis", so $n\ge3$ is a range and not a hypothesis, and there is no unit-norm, criticality, Bianchi or trace condition anywhere in the statement of the cap.

| import | its hypotheses, as its own source states them | does the object satisfy them? |
| --- | --- | --- |
| [Lemma L153](../findings/bounds.md), $\sum_\beta\lVert[v,v_\beta]\rVert^2=2(n-2)\lVert v\rVert^2$ | $\{v_\beta\}$ an orthonormal basis of all of $\mathfrak{so}(n)$; $v\in\mathfrak{so}(n)$ arbitrary; every $n\ge2$; ad-invariance of the pairing. Explicitly **no** criticality, Bianchi, trace-freeness or unit norm | **yes.** L36 applies it at the $d$ basis vectors of $\mathfrak m$, which are unit and hence inside even the narrow basis form. The general-$v$ repair L153's own audit made is not needed here. **Import clean** |
| the Casimir spectrum on $\mathrm{Sym}(\mathfrak{so}(n))$ | that $\mathrm{Sym}^2(\Lambda^2\mathbb R^n)=\mathbb R\oplus\mathrm{Sym}^2_0\oplus\mathrm{Weyl}_n\oplus\Lambda^4$ as $\mathfrak{so}(n)$-modules, and that each summand is irreducible so Schur pins one eigenvalue per summand | **yes for the use made**, with two range caveats §3 spells out: at $n=3$ two summands are **empty** and at $n=4$ two summands **coincide** in eigenvalue, and irreducibility fails at $n=4$ where $\mathrm{Weyl}_4$ splits, harmlessly, both halves carrying $-2$ |
| $\gamma\ge0$ | that $\gamma$ is a sum of squares | **yes**, and manifestly so once $\gamma$ is read as $T_{mhh}$; the block's own italic aside is right that reading $\gamma$ as the residual $2(n-2)d-2\mu$ would make the step a tautology |
| $P$ is the orthogonal projection onto $\mathfrak m$ | $P=P^{\mathsf T}=P^2$, $\operatorname{tr}P=d$ | **yes**, by construction |
| **the bridging clause**: an $S=0$ negative eigenspace is isotropic | see §5, the only argument on the record is [ATTEMPTS.md](../ATTEMPTS.md)'s $S=T_1+2T_2+T_3$, whose hypothesis is $Q(W)=\theta W$ | **unstated.** This is the debt |

**Which of these the written proof uses.** All four of the first four, each exactly once: L153 to get the block identity, $\gamma\ge0$ to turn it into $\mu\le(n-2)d$, the projection to write $\mu=\langle T(P),P\rangle$, and the spectrum to bound that below. **The bridging clause is used by nothing inside the proof**, the cap is proved for isotropic subspaces and never mentions $W$ again. It is load-bearing only for the consumers, which is exactly why it can sit unhypothesised without the proof noticing.

## 2. Step 1, the Killing block identity, and where isotropy actually enters

**The identity, rebuilt.** Fix an orthonormal basis $\{e_a\}_{a\le d}$ of $\mathfrak m$ and extend by $\{h_i\}$ to all of $\mathfrak{so}(n)$. [Lemma L153](../findings/bounds.md) at each $e_a$ gives $\sum_{b,c}c_{abc}^2=\sum_\beta\lVert[e_a,v_\beta]\rVert^2=2(n-2)$. Summing over the $d$ rows and splitting the two free indices by whether they lie in $\mathfrak m$ or $\mathfrak h$,

$$T_{mmm}+2T_{mmh}+T_{mhh}=2(n-2)d,$$

the factor $2$ on the middle term counting the two slots the single $\mathfrak h$-index can occupy. And $\mu=\sum_{a,b\in\mathfrak m}\lVert[e_a,e_b]\rVert^2=\sum_{a,b\in\mathfrak m}\sum_{c}c_{abc}^2=T_{mmm}+T_{mmh}$.

**So the general identity is $2\mu+\gamma=2(n-2)d+T_{mmm}$, and isotropy is what removes the last term.** With $T_{mmm}=0$ one gets $\mu=T_{mmh}$ and the block's boxed $2\mu+\gamma=2(n-2)d$; $\gamma=T_{mhh}\ge0$ then gives $\mu\le(n-2)d$. **The provenance clause is correct**: this is L153 summed over the $d$ rows of $\mathfrak m$, and nothing else enters.

**The one imprecision, located.** The block writes

> "Isotropy gives $\mu\le(n-2)d$ from the Killing block identity $2\mu+\gamma=2(n-2)d$"

which reads as though the identity were unconditional and isotropy supplied the inequality. It is the other way round: **isotropy is consumed by the identity**, and the inequality is then $\gamma\ge0$ alone. *The most charitable reading the words support* is that "isotropy gives [the conclusion] from [the identity]" means isotropy is an ingredient of the whole implication without saying which step it feeds, which is true. I therefore record this as a **precision note, not a discrepancy**: the conclusion is right, the chain is right, and only the attribution of the hypothesis to a step is loose. *It matters only because [Lemma L78](../findings/isotropy-cap.md) then advertises the same identity as "hypothesis-free ... **No isotropy**", which is consistent only because L78 restores the $\alpha=T_{mmm}$ term the box drops, and a reader who takes the box's version as the hypothesis-free one has an identity that is false off the isotropic locus.*

**Cross-check against a second file.** [Lemma L114](../findings/bounds-relaxations.md) states $6S_{\mathfrak{mmm}}+4S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}}=2d(n-2)$. Under §0's ordering counts that is $T_{mmm}+2T_{mmh}+T_{mhh}=2(n-2)d$, **the same identity, digit for digit**, which is what [bounds-relaxations.md](../findings/bounds-relaxations.md):138 and [Lemma L153](../findings/bounds.md)'s "five guises" note both assert. The two files agree.

## 3. Step 2, $\mu=\langle T(P),P\rangle$, the operator, and the spectrum

**(a) $\mu$ is a quadratic form in $P$.** Write $A_k=\mathrm{ad}(f_k)$, skew because the pairing is ad-invariant. Then

$$\langle T(P),P\rangle=-\sum_k\operatorname{tr}(A_kPA_kP)=\sum_k\operatorname{tr}(A_k^{\mathsf T}PA_kP)=\sum_k\lVert PA_kP\rVert^2=\sum_k\sum_{a,b\in\mathfrak m}\langle[f_k,e_b],e_a\rangle^2=\sum_{a,b\in\mathfrak m}\lVert[e_a,e_b]\rVert^2=\mu,$$

the fourth equality by total antisymmetry of $c$ and the third by $P^2=P$ with cyclicity. **Confirmed.** $T$ is self-adjoint and preserves $\mathrm{Sym}$, since $T(A)^{\mathsf T}=-\sum A_k^{\mathsf T}A^{\mathsf T}A_k^{\mathsf T}=T(A)$.

**(b) $T=2(n-2)\mathrm{Id}-\tfrac12\mathrm{Cas}$.** On $\mathrm{Sym}(\mathfrak{so}(n))\subseteq\mathfrak{so}(n)\otimes\mathfrak{so}(n)$ the action is $\rho(f_k)A=[A_k,A]$, so

$$\mathrm{Cas}(A)=-\sum_k[A_k,[A_k,A]]=-\sum_k\bigl(A_k^2A-2A_kAA_k+AA_k^2\bigr)=4(n-2)A-2T(A),$$

using $\sum_kA_k^2=-2(n-2)\mathrm{Id}$, which is $\mathrm{Cas}=2(n-2)$ on the adjoint. Rearranged, $T=2(n-2)\mathrm{Id}-\tfrac12\mathrm{Cas}$. **Confirmed as written.**

**(c) The four eigenvalues, by hand.** With $c(\lambda)=\langle\lambda,\lambda+2\rho\rangle$ and $\rho_i=(n-2i)/2$:

| summand | highest weight | $\langle\lambda,\lambda\rangle$ | $2\langle\lambda,\rho\rangle$ | $\mathrm{Cas}$ | $T=2n-4-\tfrac12\mathrm{Cas}$ |
| --- | --- | --- | --- | --- | --- |
| $\mathbb R\cdot\mathrm{Id}$ | $0$ | $0$ | $0$ | $0$ | $2n-4$ |
| $\mathrm{Sym}^2_0(\mathbb R^n)$ | $2\epsilon_1$ | $4$ | $2n-4$ | $2n$ | $n-4$ |
| $\mathrm{Weyl}_n$ | $2\epsilon_1+2\epsilon_2$ | $8$ | $4n-12$ | $4n-4$ | $-2$ |
| $\Lambda^4\mathbb R^n$ | $\epsilon_1+\epsilon_2+\epsilon_3+\epsilon_4$ | $4$ | $4n-20$ | $4n-16$ | $4$ |

**Every entry of the block's list $2n-4,\ n-4,\ -2,\ 4$ is confirmed.**

**(d) The low ranks, where the $\Lambda^4$ weight above does not exist.** $\epsilon_1+\epsilon_2+\epsilon_3+\epsilon_4$ needs rank $\ge4$, i.e. $n\ge8$. I checked the value $\mathrm{Cas}=4n-16$ separately at each smaller $n$, and it holds at all of them:

- $n=7$ ($B_3$): $\Lambda^4\mathbb R^7\cong\Lambda^3\mathbb R^7$, $\lambda=\epsilon_1+\epsilon_2+\epsilon_3$, $\rho=(\tfrac52,\tfrac32,\tfrac12)$, so $3+9=12=4n-16$.
- $n=6$ ($D_3$): $\Lambda^4\mathbb R^6\cong\Lambda^2\mathbb R^6$, the adjoint, $\mathrm{Cas}=2n-4=8=4n-16$.
- $n=5$ ($B_2$): $\Lambda^4\mathbb R^5\cong\mathbb R^5$, $\lambda=\epsilon_1$, $\rho=(\tfrac32,\tfrac12)$, so $1+3=4=4n-16$.
- $n=4$: $\Lambda^4\mathbb R^4$ is the determinant line, trivial, $\mathrm{Cas}=0=4n-16$.
- $n=3$: $\Lambda^4\mathbb R^3=0$, and so is $\mathrm{Weyl}_3$.

Likewise $\mathrm{Weyl}_4$ splits as $\mathcal W_4^+\oplus\mathcal W_4^-$ with weights $(2,2)$ and $(2,-2)$ against $\rho=(1,0)$; both give $8+4=12=4n-4$, so **the $-2$ survives the loss of irreducibility at $n=4$**.

**(e) Independent corroboration on the record.** [Lemma L79](../findings/isotropy-cap.md) is this same operator negated: $\mathcal A=\tfrac12\mathrm{Cas}-2(m-2)\mathrm{Id}=-T$, with tabulated eigenvalues $+2,\ -(m-4),\ -2(m-2),\ -4$ on $\mathrm{Weyl}_m,\ \mathrm{Sym}^2_0,\ \mathbb R\cdot\mathrm{Id},\ \Lambda^4$, the exact negatives of the four above, and [L79](../findings/isotropy-cap.md) passed Gate 2 at every $m\ge3$ with two closure checks. **The two blocks are one theorem and neither cites the other**, which [INDEX-results.md](../findings/INDEX-results.md):94 already records.

**(f) The bound.** $P=\tfrac dN\mathrm{Id}+P'$ with $P'$ orthogonal to the trivial line; $\lVert\tfrac dN\mathrm{Id}\rVert^2=d^2/N$ since $\operatorname{tr}P=d$, and $\lVert P'\rVert^2=d-d^2/N$ since $\operatorname{tr}(P^2)=d$. Since $T\ge-2$ on the orthogonal complement of the trivial summand,

$$\mu=\langle T(P),P\rangle\ \ge\ (2n-4)\frac{d^2}N-2\Bigl(d-\frac{d^2}N\Bigr)=\frac{(2n-2)d^2}{N}-2d=\frac{2(2n-2)d^2}{n(n-1)}-2d=\frac{4d^2}{n}-2d.$$

**Confirmed, and the constant is exactly right**, the $(n-1)$ in $N$ cancels against the $2n-2$, which is the whole reason the answer is $n$ and not $n-1$. *I checked this cancellation specifically, because getting $2n-4+2=2n$ instead of $2n-2$ produces $4d^2/(n-1)-2d$ and a cap of $n(n-1)/4$, which is $3$ at $n=4$ and would contradict the block's own maximiser.*

**(g) $n=3$ and $n=4$, where the eigenvalue list is not what the block says.** At $n=3$ the summands $\mathrm{Weyl}_3$ and $\Lambda^4\mathbb R^3$ are **both zero**, so $T$ has spectrum $\{2,-1\}$ and $-2$ is not an eigenvalue at all. The bound survives because $T\ge-1>-2$ there, so $\mu\ge4d^2/3-2d$ holds *a fortiori*; the sharp version is $\mu\ge d^2-d$, and chained against $\mu\le(n-2)d=d$ it gives $d\le2=\lfloor9/4\rfloor$, the same cap. At $n=4$ the list reads $4,\ 0,\ -2,\ 4$ and $-2$ is still the minimum. **So the bound and the cap hold at every $n\ge3$**, and only the block's gloss in §7 below is damaged.

**(h) Closing the chain.** $4d^2/n-2d\le\mu\le(n-2)d$ gives $4d^2/n\le nd$, hence $d\le n^2/4$, hence $d\le\lfloor n^2/4\rfloor$ since $d$ is an integer. **The integrality step is not written in the block**; it is one word and I record it only for completeness, since the block's *statement* is the floor and its proof's last line is $d\le n^2/4$.

## 4. Quantifier order, scope, and every edge of the range, pre-registered question 2

**The quantifier order in the two steps is opposite, and the block gets it right.** Step 1 is $\forall\,\mathfrak m$ **isotropic**: $\mu\le(n-2)d$. Step 2 is $\forall\,\mathfrak m$ **whatsoever**: $\mu\ge4d^2/n-2d$. The universal in step 2 is genuinely universal (nothing in §3 used isotropy, only $P=P^{\mathsf T}=P^2$) so the chaining is legitimate at every isotropic $\mathfrak m$. There is no hidden $\exists$: no basis is chosen whose existence needs argument, since $\mu$, $\gamma$ and $\langle T(P),P\rangle$ are all basis-independent.

| edge | value | verdict |
| --- | --- | --- |
| $d=0$ | $\mu=0$; the bound reads $0\ge0$ | **equality**, vacuously fine |
| $d=1$ | $\mu=\lVert[e,e]\rVert^2=0$; the bound reads $0\ge4/n-2<0$ | **true and vacuous.** The bound is negative for every $d<n/2$, so it constrains nothing below the maximal torus |
| $d=\lfloor n^2/4\rfloor$, $n$ **even** | $4d^2/n-2d=(n-2)d$ exactly | **both inequalities are equalities**; the sandwich closes with zero slack |
| $d=\lfloor n^2/4\rfloor$, $n$ **odd** | $(n-2)d-(4d^2/n-2d)=\tfrac dn(n^2-4d)=\tfrac dn$ | **slack exactly $d/n$**, so $\gamma\le2d/n$ rather than $\gamma=0$ |
| $d=N=\binom n2$, the whole algebra | $\mu=2(n-2)N$ by [Lemma L153](../findings/bounds.md); the bound gives $4N^2/n-2N=n(n-1)^2-n(n-1)=n(n-1)(n-2)=2(n-2)N$ | **equality**, exactly. $P=\mathrm{Id}$ lies wholly in the trivial summand, so the $-2$ is never spent |
| $n=3$ | cap $2$; $T$'s minimum is $-1$, not $-2$ | **holds**, §3(g) |
| $n=4$ | cap $4$; spectrum $4,0,-2,4$ | **holds**, and the maximiser $\mathbb R^2\otimes\mathbb R^2$ attains it, checked in §5 |

**So the step-2 bound is tight at three separate places** ($d=0$, the maximal torus at even $n$ (§7), and $d=N$), besides the cap itself at even $n$. That is a strong internal consistency check on the constant $4/n$, and I ran it precisely because a wrong constant would still have to pass $d=N$, which pins it uniquely: $4N^2/n-2N=2(n-2)N$ forces the coefficient.

## 5. The maximiser, and sharpness at both parities, pre-registered question 1

**The object.** $\mathfrak m=\mathbb R^p\otimes\mathbb R^q\subset\Lambda^2\mathbb R^n$, $p+q=n$, is the span of $\{\varphi_{ij}:i\le p<j\}$, the mixed block of $\Lambda^2\mathbb R^n=\Lambda^2\mathbb R^p\oplus(\mathbb R^p\otimes\mathbb R^q)\oplus\Lambda^2\mathbb R^q$. Its dimension is $pq$, and $\binom{p+q}2=\binom p2+\binom q2+pq$ identically, the same rank identity [Lemma L76](../findings/isotropy-cap.md) is built on.

**It is isotropic.** In the $\varphi_{ij}$ basis, $c_{abc}\ne0$ requires the three index pairs to form a triangle of $K_n$: $\{i,j\},\{j,k\},\{k,i\}$. The edge set of $\mathbb R^p\otimes\mathbb R^q$ is the complete bipartite graph $K_{p,q}$, which is triangle-free, so every $c_{abc}$ with all three indices in $\mathfrak m$ vanishes. **Verified directly at the smallest even case**, $n=4$, $p=q=2$, $\mathfrak m=\operatorname{span}\{\varphi_{13},\varphi_{14},\varphi_{23},\varphi_{24}\}$: the nonzero brackets are $[\varphi_{13},\varphi_{14}]=-\varphi_{34}$, $[\varphi_{13},\varphi_{23}]=-\varphi_{12}$, $[\varphi_{14},\varphi_{24}]=-\varphi_{12}$, $[\varphi_{23},\varphi_{24}]=-\varphi_{34}$, and $[\varphi_{13},\varphi_{24}]=[\varphi_{14},\varphi_{23}]=0$, **every one of them lands in $\mathfrak{so}(2)\oplus\mathfrak{so}(2)=\mathfrak m^\perp$**, so $\mathfrak m$ is isotropic and $d=4=\lfloor16/4\rfloor$.

**Its masses close the sandwich at $n=4$.** Four unordered bracketing pairs at $\lVert\cdot\rVert^2=1$ each, doubled for ordered pairs, gives $\mu=8$; and $(n-2)d=2\cdot4=8$, $4d^2/n-2d=16-8=8$. **All three coincide, so $\gamma=0$**, which is the symmetric pair.

**The dimension at each parity.**

- $n$ even: $p=\lceil n/2\rceil=n/2$, $q=n/2$, $pq=n^2/4=\lfloor n^2/4\rfloor$. **Equality.**
- $n$ odd, $n=2k+1$: $p=k+1$, $q=k$, $pq=k(k+1)=\dfrac{n^2-1}4=\lfloor n^2/4\rfloor$. **Equality.**

Both are the single identity $\lceil n/2\rceil\lfloor n/2\rfloor=\lfloor n^2/4\rfloor$, which [lean/INDEX.md](../lean/INDEX.md):267 records as the L36 row's content. **Sharpness at both parities is confirmed.** At $n=3$ it gives $p=2,q=1$ and the isotropic $2$-plane $\operatorname{span}\{\varphi_{13},\varphi_{23}\}$, whose only bracket $[\varphi_{13},\varphi_{23}]=-\varphi_{12}$ is orthogonal to both generators, so the claim "sharp, every $n\ge3$" holds down to its stated floor.

**The refuted maximiser, re-checked at both of the correction box's charges.** $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ at $p=q=n/2$ has dimension $2\binom{n/2}2=\tfrac n2\bigl(\tfrac n2-1\bigr)=\tfrac{n(n-2)}4$, short of $\tfrac{n^2}4$ by exactly $\tfrac n2$, **the box's figure**, and $6$ against $9$ at $n=6$ as it says. And it is inadmissible: $\langle[\varphi_{12},\varphi_{23}],\varphi_{13}\rangle=\langle\varphi_{13},\varphi_{13}\rangle=1\ne0$ inside the first $\mathfrak{so}(3)$, **the box's witness, recomputed here from the matrix entries**. The general reason the box gives is also correct: an isotropic subalgebra is abelian, since $[u,v]\in\mathfrak m$ and $\langle[u,v],w\rangle=0$ for all $w\in\mathfrak m$ force $[u,v]=0$. **The correction box is right on every count I could check.**

**What equality reaches, and what it does not.** At even $n$ and $d=n^2/4$ the sandwich forces $\mu=(n-2)d$, hence $\gamma=T_{mhh}=0$, hence $\mathfrak h=\mathfrak m^\perp$ is a subalgebra; with $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ from isotropy and $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$ automatic from ad-invariance, $(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair. **The block's "equality forces $\gamma=0$" is correct at even $n$.** At odd $n$ the sandwich leaves slack $d/n$, so $\gamma\le2d/n$ and nothing forces $\gamma=0$, **the block's own "odd $n$ ... is open" is accurate, and I confirm the slack is exactly $d/n$, which the block does not state.**

## 6. Which implication is used, and the hypothesis the bridging clause omits, pre-registered question 3

**Which direction the consumers need.** Every consumer runs **forward**: it has an $S=0$ point in hand and wants $\dim\mathfrak m\le\lfloor n^2/4\rfloor$. [bounds.md](../findings/bounds.md):204 feeds the cap into a relaxation and reports "the optimum sitting at $\dim\mathfrak m=\lfloor n^2/4\rfloor$"; [bounds-relaxations.md](../findings/bounds-relaxations.md):166 uses the proof's internal sandwich $4d^2/n-2d\le2S_{\mathfrak{mmh}}\le(n-2)d$ on $\{S=0\}$; [target.md](../findings/target.md):526 and :546 use "$\dim\mathfrak m$ against the cap" to place a family inside or outside the band; [Lemma L78](../findings/isotropy-cap.md) takes the block-form identity and not the clause at all. **Nothing needs the converse.**

**Whether anything uses the failing direction.** I swept every occurrence of the identifier across [findings/](../findings/), [results.md](../results.md), [plan.md](../plan.md), [lean/INDEX.md](../lean/INDEX.md) and [ATTEMPTS.md](../ATTEMPTS.md), the twenty-odd sites at [conventions.md](../findings/conventions.md):28, [bounds.md](../findings/bounds.md):204/325/368, [INDEX-results.md](../findings/INDEX-results.md):91/94/132, [bounds-relaxations.md](../findings/bounds-relaxations.md):138/166, [LEDGER.md](../findings/LEDGER.md):654/1286/1320/1572, [lean/INDEX.md](../lean/INDEX.md):142/161/267, [ATTEMPTS.md](../ATTEMPTS.md):2208/2610, and the three [results.md](../results.md) lines. **No finding: not one of them uses the converse**, and the $n=3$ failure the correction box records therefore propagates nowhere. *The nearest thing to a converse on the record is [target.md](../findings/target.md):280's "$S\equiv0$ on the $\mathfrak{so}(6)\oplus\mathfrak{so}(6)$-graded subspace, since $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k\perp\mathfrak m$ holds identically there", that is a statement about a **full grading** producing $S=0$, not about an isotropic subspace being realised as an $S=0$ negative eigenspace, so it is a different implication and L36's failing one stays unused.*

**The $n=3$ failure itself, re-checked.** $\dim\mathcal W_n=\tfrac1{12}n(n+1)(n+2)(n-3)$ gives $0$ at $n=3$, so the only Weyl operator there is $0$ and no negative eigenspace exists; meanwhile $\operatorname{span}\{\varphi_{13},\varphi_{23}\}$ is isotropic of dimension $2=\lfloor9/4\rfloor$. **The box's two witnesses are both correct.** (The same dimension formula returns $10,35,84,168$ at $n=4,5,6,7$, confirming the block's multiplicity list without computation.)

### The discrepancy: the forward implication is stated without the hypothesis its only proof needs

**Located exactly.** The words are in all three forms. [findings/isotropy-cap.md](../findings/isotropy-cap.md):22 and [results.md](../results.md):489,

> "Let $\mathfrak m\subseteq\mathfrak{so}(n)$ satisfy $\langle[u,v],w\rangle=0$ for all $u,v,w\in\mathfrak m$, *isotropic*, **which the negative eigenspace of a Weyl operator with $S=0$ is**."

and [results.md](../results.md):158, "Slack zero says the negative eigenspace is isotropic for the Cartan 3-form". **No form says the operator is critical.**

**The failure exhibited, at a named source.** The only argument on the record for that implication is the slack decomposition at [ATTEMPTS.md](../ATTEMPTS.md), $S=T_1+2T_2+T_3$ with $T_3=\tfrac12G_1=\tfrac12\sum_{i,j}\mu_i\mu_j\lVert P_{E_-}[v_i,v_j]\rVert^2$; since all three terms are nonnegative, $S=0$ forces $T_3=0$, and $\mu_i>0$ on the strictly negative eigenspace then forces $P_{E_-}[v_i,v_j]=0$, which is isotropy of $E_-$. **That derivation is sound and it is exactly what the clause needs. Its hypothesis is criticality.** The same file states the theorem's residual form, "the theorem is equivalent to the single identity $S-(T_1+2T_2+T_3)=-\operatorname{tr}(P_-(Q(W)-\theta W)P_-)$", so the decomposition is off by precisely the compressed criticality residual; and its Result 2 is titled "**it is a consequence of criticality, not an identity**". [target.md](../findings/target.md):3 says the same in its own words: "*criticality is part of the statement, and the record carried it without for a long time*."

**Argued the opposite, most charitably.** $S(W)$ is defined with a $\theta$ in it, and $\theta$ is the criticality parameter, so "a Weyl operator with $S=0$" might be read as presupposing $Q(W)=\theta W$, making the omission cosmetic. **The record refuses that reading**: [ungraded-slack.md](../findings/ungraded-slack.md)'s own correction box says "$S\ge0$ is printed with $W$ free and **is false off the critical set**, the record's own witness gives margin $-0.18$ at $n=6$", which only makes sense if $S$ is evaluated at non-critical $W$. So $S$ is a function on the whole Weyl space in this record's usage, and the clause quantifies over more operators than its proof covers.

**What this is, and what it is not.** I am **not** claiming the conclusion is false off the critical set, I have no witness for that and constructing one would need computation this footing forbids. The finding is that the implication L36's consumers rely on has, on the record, exactly one proof, that proof carries a hypothesis, and **no form of L36 states it**. Verdict on this clause: **HYPOTHESIS-DEBT**. *What would have to be shown to discharge it as written: that $S(W)=0$ forces $E_-$ isotropic for a Weyl operator that is not assumed critical, or, far more cheaply, that the word "critical" be added to all three forms, which is what every consumer's own setting already supplies.*

**One thing the debt does not include.** [Trap W4](../findings/INDEX-traps.md) marks the $S=0$ screen vacuous wherever $\ker W\ne0$. That trap bites the conclusion "**graded**", which needs $T_1=T_2=0$ as well and is about brackets among $E_+$; it does **not** reach isotropy of $E_-$, which follows from $T_3=0$ alone whatever the kernel does. So a consumer citing L36 at a point with a Weyl kernel is safe on this clause, and unsafe only if it slides from isotropy to gradedness. *That distinction is stated nowhere at L36.*

## 7. The universal claim, tried against every structured family the record names

The claim under test is step 2, "**every** $d$-dimensional subspace satisfies $\mu\ge4d^2/n-2d$". Each row is an exact hand evaluation; $\mu$ is computed as twice the number of adjacent edge-pairs of the underlying graph, since $[\varphi_{ij},\varphi_{jk}]=\pm\varphi_{ik}$ has unit norm and disjoint edges commute.

| family | $d$ | $\mu$, exactly | bound $4d^2/n-2d$ | step 2 | isotropic? | inside the cap? |
| --- | --- | --- | --- | --- | --- | --- |
| Cartan subalgebra $\operatorname{span}\{\varphi_{12},\varphi_{34},\dots\}$ | $\lfloor n/2\rfloor$ | $0$ (abelian) | $0$ at even $n$; $-2k/n$ at $n=2k+1$ | **equality at even $n$**, strict at odd | **yes**, trivially | yes, $\lfloor n/2\rfloor\le\lfloor n^2/4\rfloor$ |
| $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$, $p=q=n/2$ | $\tfrac{n(n-2)}4$ | (|), |, | **no**, $\langle[\varphi_{12},\varphi_{23}],\varphi_{13}\rangle=1$ once $\max(p,q)\ge3$ | inadmissible; and $n/2$ short of the cap |
| its complement, the mixed planes $\mathbb R^p\otimes\mathbb R^q$, any $p+q=n$ | $pq$ | $\sum_v\binom{\deg v}2\cdot2=2\cdot\tfrac{pq(n-2)}2=(n-2)pq$ | $\tfrac{2pq(2pq-n)}n$ | holds, **iff $pq\le n^2/4$**, which is AM–GM, equality at $p=q$ | **yes**, $K_{p,q}$ triangle-free | **at the cap when balanced**, below it otherwise |
| $\mathfrak m$ of $SO(2m)/U(m)$ inside $\mathfrak{so}(2m)$ | $m(m-1)$ | $(n-2)d=2m(m-1)^2$ ($\gamma=0$, symmetric pair) | $2m(m-1)(m-2)$ | holds with slack $2m(m-1)$ | **yes**, $[\mathfrak m,\mathfrak m]\subseteq\mathfrak u(m)\perp\mathfrak m$ | **strictly below**: $m(m-1)<m^2=\lfloor n^2/4\rfloor$ |
| any **coordinate** subspace | $\#$edges | $2\sum_v\binom{\deg v}2$ |, | holds | **iff the graph is triangle-free** | **Mantel**: $\le\lfloor n^2/4\rfloor$, extremal $K_{\lceil n/2\rceil,\lfloor n/2\rfloor}$ |
| whole algebra $\mathfrak{so}(n)$ | $\binom n2$ | $2(n-2)N$ ([L153](../findings/bounds.md)) | $2(n-2)N$ | **equality** | no, for $n\ge3$ | not isotropic, so no cap claim |

**Two of these are worth separating out.** The **mixed planes at unbalanced $(p,q)$** give step 1 as an *equality* at every split, $\mu=(n-2)pq$, not only at the balanced one, so the block's "equality forces $\gamma=0$" is not a characterisation of the maximiser, since $\gamma=0$ holds all along the family. What singles the balanced split out is step 2, which is tight only at $p=q$. And the **maximal torus at even $n$** makes step 2 an equality with $\mu=0$, which is a second, structurally unrelated tightness point. **No family beats the cap, and none violates step 2.** *The record's own "$\dim\mathfrak m$ is $9,20,6,12$ at $S^3\times S^3$, the $C_5$ blow-up, $\mathbb{CP}^3$ and $\mathbb{CP}^4$ against caps $9,25,9,16$" is consistent with all of this; I did not recompute those, and they are measurements rather than derivations.*

## 8. The named trap, applied, reading each citable claim alone

**A live instance, inside the block.** [findings/isotropy-cap.md](../findings/isotropy-cap.md):47, part of the canonical L36 block a consumer would quote:

> "**The whole content is one eigenvalue**, and it is the Weyl space's: $-2$ is $T$'s only negative eigenvalue, and its eigenspace is exactly $\mathrm{Weyl}_n$"

**That is false at $n=3$**, where $\mathrm{Weyl}_3=0$ and $T$'s only negative eigenvalue is $-1$ on $\mathrm{Sym}^2_0$ (§3(c),(g)). The correction exists, at :72, **twenty-five lines below and in a different section**, reading "$-2$ being its only negative eigenvalue **at $n\ge4$**" with the $n=3$ case spelled out. [LEDGER.md](../findings/LEDGER.md):1572 records the repair, and [INDEX-results.md](../findings/INDEX-results.md):94 says [Lemma L79](../findings/isotropy-cap.md) "repairs ... L36's $n\ge4$". **The repair never entered the block.** This is exactly the failure mode the brief names: a correction landing beside the statement it corrects, so a consumer quoting the block inherits the defect. *The cap itself is untouched (§3(g)) so the damage is to a gloss the block calls "the whole content", not to the theorem.*

**A second instance, in a different file.** [results.md](../results.md):158, the landscape line, read alone:

> "such a subspace of $\mathfrak{so}(n)$ has dimension at most $\lfloor n^2/4\rfloor$, **attained by the balanced symmetric pair**."

Two things go wrong for a reader who has only this line. **The object is ambiguous in exactly the direction that was refuted**, "the balanced symmetric pair" is $(\mathfrak{so}(n),\mathfrak{so}(p)\oplus\mathfrak{so}(q))$, and the attaining subspace is its *odd part*, not the subalgebra the phrase names first; the refuted first version of L36 named that subalgebra, and this line does nothing to exclude that reading. **And "balanced" has no referent at odd $n$**, where $p=q=n/2$ is not an integer, which is precisely the charge the correction box lays against the first version, "*it also left odd $n$ with a maximiser that does not exist there*". The line also drops the parity claim entirely. **[results.md](../results.md):158 carries no correction note of any kind**, while :489 carries all of them inline. **GAP**, and it is the one form a reader of the landscape list meets first.

**The forms that read correctly alone.** [results.md](../results.md):489 states the mixed planes, both parities, and both refutations in its own italic tail; [findings/isotropy-cap.md](../findings/isotropy-cap.md):17– carries the correction box **above** the statement, which is the right placement. Both still omit criticality from the bridging clause (§6).

## 9. Comparing the forms, and the Lean row

| clause | [findings/isotropy-cap.md](../findings/isotropy-cap.md):17– | [results.md](../results.md):489 | [results.md](../results.md):158 |
| --- | --- | --- | --- |
| the cap $\lfloor n^2/4\rfloor$ | yes | yes | yes |
| the maximiser | mixed planes $\mathbb R^p\otimes\mathbb R^q$, $p=\lceil n/2\rceil$ | identical | "**the balanced symmetric pair**", §8 |
| sharpness at both parities | yes, with both values | yes, with both values | **absent** |
| "sharp, every $n\ge3$, no genericity hypothesis" | yes | yes | **absent** |
| the refuted $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ | correction box, **above** the statement | italic tail, inline | **absent, and the wording admits it back** |
| the failing converse at $n=3$ | correction box | italic tail | **absent** |
| criticality on the bridging clause | **absent** | **absent** | **absent** |
| "$-2$ is $T$'s only negative eigenvalue" | present at :47, **unqualified**; qualified copy at :72, outside the block | absent | absent |
| the proof | in full | pointer to the findings file | none |

**The three forms agree on the theorem and diverge on the corrections**, in the direction the trap predicts: the further from the proof, the more of the repair has fallen off. :489 is the best of the three; :158 is the worst and is the entry point of the landscape list.

**The Lean row.** [lean/INDEX.md](../lean/INDEX.md):267 carries L36 against [HamiltonsCubic/Results/L36.lean](../lean/HamiltonsCubic/Results/L36.lean), status **partial**, and claims three things: the parity identity $\lceil n/2\rceil\lfloor n/2\rfloor=\lfloor n^2/4\rfloor$, the refuted maximiser's shortfall of exactly $n/2$, and its inadmissibility via $\langle[\varphi_{01},\varphi_{12}],\varphi_{02}\rangle\ne0$. **All three are among the things I verified in §5, and the row states them accurately.** It closes "the cap itself is owed", which is the honest split: what is formalised is the sharpness side, and the bound is not.

**What the row would have to claim to be complete.** The cap needs step 2, and step 2 needs the isotypic decomposition $\mathrm{Sym}^2(\Lambda^2\mathbb R^n)=\mathbb R\oplus\mathrm{Sym}^2_0\oplus\mathrm{Weyl}_n\oplus\Lambda^4$ together with $T\ge-2$ off the trivial summand, a representation-theoretic input of a different weight from anything else in that row. **And the row is silent on the bridging clause**: it formalises nothing about $S=0$, so a reader who takes the row as covering "L36" gets the extremal combinatorics and none of the implication the consumers use. *A complete row would have to say so.*

## 10. The gap between what is proven and what is used, and what a consumer may cite

**Proven, unconditionally, and rebuilt here from scratch:** for every subspace $\mathfrak m\subseteq\mathfrak{so}(n)$ isotropic for the Cartan 3-form, at every $n\ge3$, $\dim\mathfrak m\le\lfloor n^2/4\rfloor$; equality is attained by $\mathbb R^{\lceil n/2\rceil}\otimes\mathbb R^{\lfloor n/2\rfloor}$ at both parities; and, separately, $\mu\ge4d^2/n-2d$ at **every** $d$-dimensional subspace, isotropic or not.

**Used by the consumers:** that $S=0$ puts a Weyl operator's negative eigenspace under that cap. **That is the composite, and its second half is the clause of §6.**

**A consumer may cite, without further argument:**

1. The cap and its sharpness, for a subspace already known to be isotropic. Clean.
2. The lower bound $\mu\ge4d^2/n-2d$ at any subspace whatever. Clean, and tight at three named places (§4).
3. The block identity $2\mu+\gamma=2(n-2)d$ **only under isotropy**, §2. The hypothesis-free version needs the $T_{mmm}$ term restored, which is [Lemma L78](../findings/isotropy-cap.md)'s $\alpha$.
4. "$\dim E_-\le\lfloor n^2/4\rfloor$ at an $S=0$ point" **only with criticality supplied**, which every consumer's own setting does supply, but the citation should say so, because L36 does not.

**A consumer may not cite:** "$-2$ is $T$'s only negative eigenvalue" at $n=3$ (§8); "the balanced symmetric pair attains the cap" at odd $n$ (§8); the converse in any form (§6).

**One adjacent inconsistency, flagged and not adjudicated.** [Lemma L78](../findings/isotropy-cap.md) states the same identity as $\alpha+2S_{\mathfrak{mmh}}+S_{\mathfrak{mhh}}=2(n-2)d$ while [Lemma L114](../findings/bounds-relaxations.md) states it as $6S_{\mathfrak{mmm}}+4S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}}=2d(n-2)$; under one reading of $S_{XYZ}$ these differ by a factor $2$ on two terms. [isotropy-cap.md](../findings/isotropy-cap.md):118 already records the cause, "*a live cross-file normalisation collision in $S_{XYZ}$, which [conventions.md](../findings/conventions.md) does not carry*", and records that L36's own $2\mu+\gamma=2(n-2)d$ is the one written **correctly**. **L36 is on the right side of that collision** and I verified its form independently in §2; the collision is L78's and L114's to settle, and it is outside this verdict.

## 11. What would falsify this, and what I did to look

**For the cap.** The falsifier is a subspace $\mathfrak m\subseteq\mathfrak{so}(n)$, isotropic for the Cartan 3-form, of dimension $\lfloor n^2/4\rfloor+1$. What I did: (i) evaluated $\mu$ exactly on every structured family the record names, Cartan subalgebra, $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$, the mixed planes at every split, the $SO(2m)/U(m)$ odd part, arbitrary coordinate subspaces, and the whole algebra (§7), and none comes within reach; (ii) checked the two places where the chain is an equality, $d=\binom n2$ and the even-$n$ torus, since a falsifier must live where the chain is loose and those pin the constant; (iii) re-derived the step-2 constant twice, once forward and once by the $d=N$ equality which determines it uniquely; (iv) noted that any falsifier must be **non-coordinate**, since the coordinate case is Mantel's theorem, which is the block's own claim about where its content lies, and it is correct. **The only remaining escape is an eigenvalue of $T$ below $-2$**, and §3(c)–(d) rules that out at every $n\ge3$ by an exact weight computation, corroborated on the record by [Lemma L79](../findings/isotropy-cap.md)'s independently audited table for $\mathcal A=-T$. **No falsifier, and no route to one that I can see.**

**For the bridging clause.** The falsifier is a Weyl operator $W$ with $S(W)=0$, **not** critical, whose strictly negative eigenspace is not isotropic. **I did not look for one**, and I say so rather than leaving it implied: finding it is a search, and this programme is on an analysis-only footing where a search needs its own approval. Naming it is the point, it is what separates "the clause is unproven as stated" from "the clause is false", and this report claims only the first.

## 12. Sources

**Read for this report:** [findings/isotropy-cap.md](../findings/isotropy-cap.md), [results.md](../results.md):40/158/489, [Lemma L153](../findings/bounds.md), [conventions.md](../findings/conventions.md), [ungraded-slack.md](../findings/ungraded-slack.md), [nondegeneracy.md](../findings/nondegeneracy.md), [bounds-relaxations.md](../findings/bounds-relaxations.md), [target.md](../findings/target.md), [INDEX-traps.md](../findings/INDEX-traps.md), [INDEX-results.md](../findings/INDEX-results.md), [LEDGER.md](../findings/LEDGER.md), [ATTEMPTS.md](../ATTEMPTS.md)'s slack decomposition, [lean/INDEX.md](../lean/INDEX.md), and [references/turan-multilinear-2026/README.md](../references/turan-multilinear-2026/README.md).

**External sources.** The proof cites none and needs none, it runs on [Lemma L153](../findings/bounds.md) and a Casimir computation, both internal. The two external gestures are placement rather than steps: Mantel's theorem, and the Turán-for-alternating-forms literature. **The latter is in [references/](../references/)**, [turan-multilinear-2026](../references/turan-multilinear-2026/README.md) and [qiao-2020-turan-alternating-multilinear](../references/qiao-2020-turan-alternating-multilinear/README.md), and I read the first, which confirms the block's placement: those papers study the *isotropy index*, a **minimum over all alternating forms**, so they bound L36 from below and cannot supply its value. **Nothing in L36's proof rests on an unread source.** *Mantel's theorem itself has no note of its own in [references/](../references/); it is used only as a name for the coordinate case, which §7 verifies directly, so nothing rests on it either.*

**Gate 2 provenance.** The block's "two reviewers on identical briefs who proved the bound independently" is [r65](../reviews/REVIEW_r65.md) and [r66](../reviews/REVIEW_r66.md); the correction box's "both REFUTED as stated" is [r517](../reviews/REVIEW_r517.md) and [r518](../reviews/REVIEW_r518.md). **All four files exist**, and [reviews/INDEX.md](../reviews/INDEX.md):38 carries the r65/r66 row.

## Verdict

**PROVEN, hypotheses corrected.**

The cap, its proof, its lower bound and its maximiser at both parities are correct, and I rebuilt every step by hand. Three corrections are owed, none of them to the theorem:

1. **The bridging clause needs "critical".** "The negative eigenspace of a Weyl operator with $S=0$" should read "of a **critical** Weyl operator with $S=0$" in all three forms, that is the hypothesis of the only proof on the record ([ATTEMPTS.md](../ATTEMPTS.md)'s $S=T_1+2T_2+T_3$), and it is the hypothesis every consumer already has. **HYPOTHESIS-DEBT** until it is written down.
2. **The block's "one eigenvalue" gloss needs $n\ge4$**, which the same file already carries twenty-five lines below it. The cap is unaffected.
3. **[results.md](../results.md):158 needs the maximiser [results.md](../results.md):489 already states.** As written it names no admissible object at odd $n$ and readmits the refuted one at even $n$.
