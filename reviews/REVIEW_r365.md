# Gate 2 review r365, Lemma L124, the four-set invariant $\Sigma$

Reviewer **r365**, cold brief, arguing from the definitions in [findings/second-order.md](../findings/second-order.md), [adversarial_check1.py](../scripts/lib/adversarial_check1.py) and [b_cp2_nondegenerate.py](../scripts/lib/b_cp2_nondegenerate.py). Analysis-only footing observed: every number below is a screen of a claim stated first and derived first, on objects constructed for the purpose, and no screen is the warrant for any positive claim here.

## Verdicts

| | claim | verdict |
|---|---|---|
| **V1** | $A+B+C=0\Rightarrow\Sigma=\tfrac32(A^2+B^2+C^2)$ | **CONFIRMED**, and it is an identity in three real numbers that says nothing about $W$ |
| **V2** | half-flat $\Rightarrow$ $A,B,C$ are the self-dual eigenvalues and $A^2+B^2+C^2=\rho^2$ | **REFUTED**, $A,B,C$ are the self-dual **diagonal entries**; the truth is $A^2+B^2+C^2\le\rho^2$, and the deficit is unbounded relative to the claim |
| **V3** | padded $\mathbb{CP}^2$ gives $(A,B,C)\propto(2,-1,-1)$, $\rho^2=1$, $\Sigma=\tfrac32=\theta^2$ | **PLAUSIBLE** as arithmetic in the constructor's frame; the derivation of it is **REFUTED**, and the same $W$ in another frame gives $(A,B,C)=(0,0,0)$ |
| **V4** | the equality is two independent facts meeting, not a coupling | **REFUTED**, $\theta=9\det W^+$ on the half-flat family, so $\theta$ is a function of the very spectrum that fixes $\Sigma$, and $\Sigma\le\theta^2$ there **is** the extremality of $\det W^+$ |
| **V5** | $\rho^2\le\tfrac23\theta^2$, vacuous exactly for $n\ge12$, binding for $n\le11$ | **REFUTED** three times over, the implication needs V2, its hypothesis is vacuous where L121 is proved, and at a maximiser $\theta^2\ge\tfrac32$ at **every** $n\ge4$ |
| **V6** | the I12 slack sits in $\rho$, not in $t_F$ | **REFUTED**, the two $\rho$'s are different objects, and at padded $\mathbb{CP}^2$ the $t_F$ budget is **exactly saturated**, so the slack is in neither |

**One thing the brief asked about that survives: the anti-self-dual signs are right.** With the standard orientation of $\langle S\rangle$ and $\ast e_{ij}=e_{kl}$, $\ast e_{ik}=-e_{jl}$, $\ast e_{il}=e_{jk}$, the anti-self-dual vectors are $e_{ij}-e_{kl}$, $e_{ik}+e_{jl}$, $e_{il}-e_{jk}$, which is L124's $(1,-1)$, $(1,1)$, $(1,-1)$ exactly. The two-by-two algebra that follows it is also correct: $(1,\mp1)$ in the kernel forces $m_1=m_2=\pm r$, the surviving eigenvalue is $m_1+m_2=\pm2r$, and $m_1^2+m_2^2+2r^2=4r^2$. **Every step of the proof of (ii) is right except the one that is never stated.**

---

## V2, the plane decomposition is assumed, not proved, and it is false

### The citation does not say what it is used for

L124's proof opens: *"Each opposite pair spans a $W$-invariant plane ([Lemma L121](../findings/second-order.md))."* [Lemma L121](../findings/second-order.md) is a statement about $L_M$ (the multiplication operator $M\circ(\cdot)$), restricted to the two-dimensional four-set summand of $\mathcal W_n\subset\mathrm{Sym}^2(\Lambda^2)$. **It contains no statement about the invariant subspaces of $W$ acting on $\Lambda^2$.** The two live in different spaces: $L_M$ acts on $\mathrm{Sym}^2(\Lambda^2)$, $W$ acts on $\Lambda^2$. The block-diagonality that L121 inherits from [Lemma L120](../findings/second-order.md) is block-diagonality of $L_M$ over sign characters, not of $W$ over opposite pairs. The reference supplies nothing.

### What is actually true, computed from the definitions

Let $\Pi$ be the compression of $W$ to $\Lambda^2\langle S\rangle$, let $\omega^\pm_1=(e_{ij}\pm e_{kl})/\sqrt2$ and its two relatives be the orthonormal self-dual and anti-self-dual frames, and suppose $\Pi$ annihilates $\Lambda^2_-\langle S\rangle$. Since $\Pi$ is symmetric, its image then lies in $\Lambda^2_+\langle S\rangle$, so $\Pi$ is carried by a symmetric $3\times3$ matrix $P_{ab}=\langle\omega^+_a,\Pi\,\omega^+_b\rangle$ and $\rho^2=\lVert\Pi\rVert^2=\lVert P\rVert_F^2$.

Now read off $M_{ij}$. With $e_{ij}=(\omega^+_1+\omega^-_1)/\sqrt2$ and $\Pi e_{ij}=\Pi\omega^+_1/\sqrt2\in\Lambda^2_+$,

$$M_{ij}=\langle e_{ij},\Pi e_{ij}\rangle=\tfrac12\langle\omega^+_1,\Pi\omega^+_1\rangle=\tfrac12P_{11},\qquad M_{kl}=\tfrac12P_{11},\qquad\textbf{so } A=P_{11},$$

and likewise $B=P_{22}$, $C=P_{33}$. **The opposite-pair sums are the diagonal entries of the self-dual block in the opposite-pair frame, not its eigenvalues.** Hence

$$A^2+B^2+C^2=\sum_aP_{aa}^2\;=\;\rho^2-2\sum_{a<b}P_{ab}^2\;\le\;\rho^2,$$

with equality **iff $P$ is diagonal in the opposite-pair frame**, a third hypothesis L124 never states and which does not follow from the other two. Equivalently: $\Sigma\le\tfrac32\rho^2$, and the inequality runs the wrong way for everything L124 builds on it.

Note also $A+B+C=\operatorname{tr}P=\operatorname{tr}\Pi=\sum_{a<b\in S}M_{ab}$, so hypothesis (i) is exactly *within-$S$ tracelessness of the compression*. Ricci-flatness gives $\sum_bM_{ab}=0$ over **all** $b$, never within a four-subset, so (i) is a genuine extra hypothesis wherever the support of $W$ is not contained in $S$.

### The hypothesis is vacuous in the only place L121 applies

Suppose one repairs the citation by importing L121's own setting, a **coordinate-diagonal** $W$. Then $We_{ab}=M_{ab}e_{ab}$, so $W(e_{ij}-e_{kl})=M_{ij}e_{ij}-M_{kl}e_{kl}$, and annihilation forces $M_{ij}=M_{kl}=0$; the same on the other two planes gives all six $M_{ab}=0$, hence $\Pi=0$, $\rho=0$, $\Sigma=0$. **Under diagonality, (ii) says $0=\tfrac32\cdot0$.** So the lemma has to be read for non-diagonal $W$, precisely the case where the plane decomposition it borrows is false.

### The counterexample, in two forms

*Stated before it was screened.* Take $S=\{1,2,3,4\}$ and put $W^+=P$ on $\Lambda^2_+$, zero on $\Lambda^2_-$, padded by zero to $\mathcal W_n$. Any traceless symmetric $P$ gives a genuine Weyl operator: in four dimensions the self-dual/anti-self-dual splitting of trace-free curvature is exactly $W^+\oplus W^-$ with each block symmetric and trace-free, first Bianchi being the equality of the two traces and Ricci-flatness their vanishing.

- **Form 1, the two hypotheses hold and the conclusion fails by the whole of $\rho^2$.** $P=\tfrac1{\sqrt2}(E_{12}+E_{21})$ is traceless with $\lVert P\rVert_F=1$ and zero diagonal, so $A=B=C=0$, hypothesis (i) holds, hypothesis (ii)'s half-flatness holds, and $\rho^2=1$. L124(ii) asserts $\Sigma=\tfrac32$; the truth is $\Sigma=0$.
- **Form 2, the record's own witness, in a different frame.** $W_{\mathbb{CP}^2}$ has $W^+=\tfrac3{\sqrt6}uu^{\mathsf T}-\tfrac1{\sqrt6}\mathrm{Id}$ with $u$ the Kähler direction in $\Lambda^2_+$, so in **any** opposite-pair frame $P_{aa}=\tfrac1{\sqrt6}(3u_a^2-1)$. The rotation $u=(1,1,1)/\sqrt3$ is realised by an honest $SO(4)$ frame rotation of $\mathbb R^4$, since $SO(4)\to SO(3)_+$ is onto and $W$ is zero on $\Lambda^2_-$. In that frame **all six sectional curvatures of padded $\mathbb{CP}^2$ on $S$ vanish**: $(A,B,C)=(0,0,0)$, $\Sigma=0$, while $\rho^2=1$, $\theta=\sqrt{3/2}$ and the self-dual spectrum is still $(2,-1,-1)/\sqrt6$.

*Screened* (both forms, $n=6$, structure constants and $Q$ copied verbatim from [adversarial_check1.py](../scripts/lib/adversarial_check1.py)): Ricci residual $\le1.7\times10^{-16}$, Bianchi residual $\le1.7\times10^{-16}$, $\lVert W\Lambda^2_-\rVert=0$ exactly, $\lVert W\rVert=1$, $\Sigma=0$ against L124(ii)'s $\tfrac32$. **The screen confirms an argument that stands without it.**

> **CORRECTION.** (ii) is true with the hypothesis *"and $W|_{\Lambda^2_+\langle S\rangle}$ is diagonal in the opposite-pair frame"* added, equivalently *"$W_{ab,cd}=0$ for pairs $ab,cd\subset S$ sharing exactly one index"*. Without it the correct statement is the inequality $\Sigma\le\tfrac32\rho^2$.

**Two smaller scope defects, recorded so a repair does not reopen them.** $\Lambda^2_-\langle S\rangle$ needs an orientation of $\langle S\rangle$, which L124 does not fix; the two choices are exchanged by an odd permutation of $S$ and the conclusion is invariant, so this is a wording gap rather than an error. And "the restriction of $W$ to $\Lambda^2\langle S\rangle$" must mean the compression $\Pi_SW\Pi_S$, since $W$ does not preserve $\Lambda^2\langle S\rangle$ for $n>4$; the counterexamples above satisfy the stronger reading $Wv=0$, so the refutation holds under either.

---

## V1, true, and it earns nothing

$(A+B+C)^2=0$ gives $AB+BC+CA=-\tfrac12(A^2+B^2+C^2)$, hence $\Sigma=\tfrac32(A^2+B^2+C^2)$. **CONFIRMED.** It is an identity in three reals with no input from $W$, from criticality, or from the Weyl conditions, so all of the lemma's content sits in (ii) and in whether $A+B+C=0$ is ever available. On the latter, see above: it is within-$S$ tracelessness, and Ricci-flatness does not supply it.

---

## V3, the numbers are right in one frame, the derivation is wrong in every frame

The corollary reads *"self-dual spectrum $\propto(2,-1,-1)$, **so** at unit norm $(A,B,C)=\tfrac1{\sqrt6}(2,-1,-1)$"*. **That "so" is the invalid step**, and Form 2 above is the counterexample: same tensor, same spectrum, same $\theta$, $(A,B,C)=(0,0,0)$.

What is true is that the record's constructor happens to build the adapted frame. [b_cpm_closed_form.py](../scripts/lib/b_cpm_closed_form.py) sets $J_{2k,2k+1}=1$, so the Kähler form is $e_{12}+e_{34}$ (one of the three opposite-pair self-dual vectors) and since the other two self-dual eigenvalues coincide, $P$ is diagonal in that frame. *Screened at $n=6$ with the same closed-form spectrum:* $(A,B,C)=(0.816497,-0.408248,-0.408248)$, $\rho^2=1$, $\theta=1.224744871392$, $\theta^2=\Sigma=1.500000000000$, $t_F=1$, reproducing the record's $n=8,10,12$ screen and [DERIVE-mx1.md](DERIVE-mx1.md)'s table. **So V3's arithmetic is sound and V3's warrant is a property of the constructor's frame, not of $\mathbb{CP}^2$.**

---

## V4, the two facts are one fact, and the coincidence reading is the error

### $\theta$ is a function of the self-dual spectrum

On the half-flat cone $\{W^-=0\}$ the cubic $P(W)=\langle W,Q(W)\rangle$ restricts to an $SO(3)$-invariant cubic polynomial in the traceless symmetric $3\times3$ matrix $W^+$. The space of such polynomials is one-dimensional, spanned by $\operatorname{tr}(P^3)=3\det P$. Hence $P(W)=\alpha\det W^+$ with $\alpha$ a universal constant, and it is $n$-independent because $(W^\#)_{ab}$ for $a,b\subset S$ contracts two copies of $W$, both of which vanish off $S$. One evaluation fixes $\alpha=9$.

$$\boxed{\ \theta\;=\;9\det W^+\quad\text{on unit-norm half-flat }W\ }$$

*Screened*, five random traceless unit-norm $P$ at $n=6$, agreement to nine digits every time: $+0.903673180$, $-0.704833068$, $-0.040449176$, $+0.601169424$, $+0.473680554$, each equal to $9\det W^+$. **The invariant-theory argument is the proof; the screen is a transcription check on $\alpha$.**

### What that does to the "independent facts" claim

On the adapted-frame half-flat family with $\lVert W\rVert=1$: $\Sigma=\tfrac32\lVert P\rVert_F^2=\tfrac32$, **constant**, while $\theta^2=81(\det P)^2$ **varies**. So

$$\Sigma\le\theta^2\quad\Longleftrightarrow\quad\lvert\det W^+\rvert\ \ge\ \tfrac1{3\sqrt6},$$

and $\tfrac1{3\sqrt6}$ is the **maximum** of $\lvert\det\rvert$ over traceless symmetric $3\times3$ of unit Frobenius norm, attained exactly at spectrum $\propto(2,-1,-1)$. The equality at padded $\mathbb{CP}^2$ is therefore the statement that $\mathbb{CP}^2$ is the unique extremiser of $\det W^+$ on that family, **one mechanism, read twice**, not two facts colliding.

> **CORRECTION, stated positively.** Among unit-norm half-flat Weyl operators supported on a single four-set, $\Sigma\ge\theta^2$ holds identically, with equality exactly at the extremisers of $\det W^+$, which are $\pm W_{\mathbb{CP}^2}$. So [Lemma L121](../findings/second-order.md)'s bound is saturated at $\mathbb{CP}^2$ **because** $\mathbb{CP}^2$ maximises the cubic on that family, and every other member of the family violates the bound and is thereby excluded from being a maximiser. *That is a sharpening the coincidence reading throws away.*

L124's sentence *"$\Sigma=\tfrac32\rho^2$ is forced with no reference to $\theta$"* is true and misleading: on the family $\Sigma$ is a **constant**, so the whole content of the equality is that $\theta$ attains its own maximum there.

---

## V5, the concentration bound fails on three independent grounds

**First, it inherits V2.** The corollary chains $\Sigma\le\theta^2$ with $\Sigma=\tfrac32\rho^2$ to get $\rho^2\le\tfrac23\theta^2$. With the corrected $\Sigma\le\tfrac32\rho^2$, the chain gives $A^2+B^2+C^2\le\tfrac23\theta^2$ and **no bound on $\rho^2$ at all**, since $\rho^2\ge A^2+B^2+C^2$. Form 2 is the witness: $\Sigma=0$ and $\rho^2=1$ at a genuine critical point.

**Second, its two hypotheses cannot hold together where L121 is proved.** $\Sigma\le\theta^2$ is [Lemma L121](../findings/second-order.md) plus [Lemma L24](../findings/second-order.md), and L24 needs $X\perp W$, which holds on a four-set plane only in the eigenframe, [DERIVE-mx1.md](DERIVE-mx1.md) records this and replaces the bound off the eigenframe by $\Sigma\le\theta^2(1+c^2)^2$. In the eigenframe $W$ is diagonal, and diagonality plus half-flatness forces $\rho=0$ (above). **So on the diagonal locus the corollary reads $0\le\tfrac23\theta^2$, and off it the inequality it starts from is unavailable.**

**Third, and fatally for the threshold, the vacuity direction is right but the threshold is not.** Vacuity: $\rho^2\le\lVert W\rVert^2=1$ always, so the bound bites only when $\tfrac23\theta^2<1$, i.e. $\theta^2<\tfrac32$, the stated direction is correct. And $\theta$ at a maximiser is bounded **below** by any achieved value, which is the direction L124 uses. But the value it uses is wrong: padded $\mathbb{CP}^2$ is an admissible unit-norm Weyl operator at every $n\ge4$ with $P(W)=\sqrt{3/2}$, so

$$\theta(\text{maximiser})\;\ge\;\max\big(\theta_0(n),\sqrt{3/2}\big)\;\ge\;\sqrt{3/2}\qquad\text{for every }n\ge4 .$$

**Hence $\tfrac23\theta^2\ge1\ge\rho^2$ and the concentration bound is vacuous at every $n$, not only $n\ge12$.** L124 substitutes $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ (the value at $S^{n/2}\times S^{n/2}$) for $\theta$ at the maximiser. Those agree only where Conjecture A is known, and below $n=12$ they demonstrably disagree: $\theta_0(11)=1.219875<\sqrt{3/2}=1.224745<1.236033=\theta_0(12)$, which is why [b_cp2_nondegenerate.py](../scripts/lib/b_cp2_nondegenerate.py)'s own docstring says $\mathbb{CP}^2$ is "harmless" only for $n\ge12$. **The regime L124 calls binding, $n\le11$, is exactly the regime where $\mathbb{CP}^2$ beats the sphere product and drives the maximiser's $\theta$ above $\sqrt{3/2}$.** The threshold arithmetic itself is right ($\theta_0(n)^2\ge\tfrac32\iff n^2-12n+8\ge0\iff n\ge6+2\sqrt7$), it is applied to the wrong quantity.

---

## V6, two different $\rho$'s, and the frame budget is exactly saturated where the slack is claimed

**The symbol is overloaded.** [DERIVE-mx1.md](DERIVE-mx1.md) defines $\rho=\langle X,W\rangle=\langle X,R\rangle$, the overlap of $W$ with the four-set **character block of $\mathrm{Sym}^2(\Lambda^2)$**, built from the off-diagonal entries $W_{ij,kl}$ on opposite pairs, obeying $\sum_S\rho_S^2\le\lVert R\rVert^2=1-t_F/2$. L124 defines $\rho^2=\lVert W|_{\Lambda^2\langle S\rangle}\rVert^2$, the mass of the **compression of $W$ to $\Lambda^2\langle S\rangle$**, which includes the six sectional entries $M_{ab}$. These are different functions of $W$; V6 attributes I12's slack to the second while I12's derivation uses the first. **A claim about where a bound's slack lives cannot be made by substituting a different quantity under the same letter.**

**And on I12's own $\rho$, $t_F$ carries no slack at padded $\mathbb{CP}^2$.** The route's chain is $\Sigma\le\theta^2(1+c^2)^2$ with $c^2\le\rho_{\mathrm{I12}}^2\le\lVert R\rVert^2=1-t_F/2$. *Screened at the constructor's frame:* the four-set character components of $W$ are $(0.577350,\,0.288675,\,-0.288675)$ (signed as $(2,-1,-1)/\sqrt6\cdot\tfrac1{\sqrt2}$, Bianchi-alternating sum zero), with squared total $0.500000000$, against $\lVert R\rVert^2=1-t_F/2=0.500000000$. **The budget is saturated exactly.** The whole of the $2.25$ slack in $\theta^2(2-t_F/2)^2=\tfrac{27}8$ against $\Sigma=\theta^2$ therefore sits in the projection step $\langle X,L_eX\rangle\le\tfrac12(1+c^2)$, which permits $\tfrac34$ where the truth is $\tfrac12$. Neither $\rho$ nor $t_F$ is the culprit.

**The stated mechanism is false as well.** V6 says *"$\Sigma$ scales with the four-set's share of the norm"*. Form 2 holds that share fixed at $\rho^2=1$ and moves $\Sigma$ from $\tfrac32$ to $0$ by a frame rotation. In the same rotation $t_F$ moves $1\to0$, so what little the data supports points the **opposite** way from V6, toward $t_F$.

> **CORRECTION.** The slack at padded $\mathbb{CP}^2$ is in the projection correction $\tfrac12(1+c^2)$, and a sharpening should attack that term. $\rho_{\mathrm{I12}}$ and $t_F$ are related by an identity that is tight at this point, so choosing between them is not a finding.

---

## What survives of L124

- Part (i), as an identity in three reals, with the standing note that $A+B+C=0$ is within-$S$ tracelessness and is not supplied by Ricci-flatness.
- The anti-self-dual sign assignment and the two-by-two algebra in the proof of (ii).
- Part (ii) with the added hypothesis that the self-dual block is diagonal in the opposite-pair frame; without it, $\Sigma\le\tfrac32\rho^2$.
- The arithmetic of the padded $\mathbb{CP}^2$ corollary in the constructor's frame, restated as a frame-dependent evaluation.
- **A replacement for the corollary that is stronger than the withdrawn one:** $\theta=9\det W^+$ on the half-flat family, so $\Sigma\ge\theta^2$ there with equality exactly at $\pm W_{\mathbb{CP}^2}$.

Withdrawn: the concentration bound $\rho^2\le\tfrac23\theta^2$ and its $n\ge12$ threshold; the "two independent facts" reading; the relocation of the I12 slack from $t_F$ to $\rho$.

---

*Screens: [screen365.py](../agent_logs/screen365.py) reproduces every number quoted, at $n=6$, using [structure_constants](../scripts/lib/adversarial_check1.py#L39) and [Q_full](../scripts/lib/adversarial_check1.py#L62) copied verbatim from [adversarial_check1.py](../scripts/lib/adversarial_check1.py). Each screen was written after the argument it checks and none is offered as warrant.*
