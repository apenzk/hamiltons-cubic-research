# Review r366, Lemma L124, the four-set invariant $\Sigma$

Gate 2, cold brief, arguing from the definitions in [second-order.md](../findings/second-order.md), [adversarial_check1.py](../scripts/lib/adversarial_check1.py) and [b_cp2_nondegenerate.py](../scripts/lib/b_cp2_nondegenerate.py). Analysis-only footing observed: every number below comes from a screen of a claim being recorded, on objects constructed for that purpose, and no positive claim rests on one.

| Claim | Verdict |
|---|---|
| **V1** $A+B+C=0\Rightarrow\Sigma=\tfrac32(A^2+B^2+C^2)$ | **CONFIRMED**, with a wrong attribution of the hypothesis |
| **V2** half-flat $\Rightarrow$ $A,B,C$ the self-dual eigenvalues, $A^2+B^2+C^2=\rho^2$ | **REFUTED**, a hypothesis is missing, and under the one L121 actually supplies the statement is vacuous |
| **V3** padded $\mathbb{CP}^2$: $(A,B,C)\propto(2,-1,-1)$, $\rho^2=1$, $\Sigma=\tfrac32=\theta^2$ | **CONFIRMED in the record's frame only**, the statement is frame-dependent and is stated without a frame |
| **V4** the equality is two independent facts meeting, not a coupling | **REFUTED**, it is the equality case of a sharp inequality, twice over |
| **V5** $\rho^2\le\tfrac23\theta^2$, vacuous exactly for $n\ge12$, binding for $n\le11$ | **REFUTED**, the implication fails, and the vacuity direction is backwards |
| **V6** the I12 slack is in $\rho$, not $t_F$ | **REFUTED**, on L124's own family $t_F=\tfrac23\Sigma$ while $\rho^2\equiv1$; $\rho$ is the constant |

---

## The core defect: $A,B,C$ are diagonal entries, not eigenvalues

**Set-up, from the definitions.** For $S=\{i<j<k<l\}$ put $V:=W|_{\Lambda^2\langle S\rangle}$, a $6\times6$ symmetric block of the pair-basis matrix, and orient $\langle S\rangle$ by $e_i\wedge e_j\wedge e_k\wedge e_l$. Then

$$\omega_1=\tfrac1{\sqrt2}(e_{ij}+e_{kl}),\quad \omega_2=\tfrac1{\sqrt2}(e_{ik}-e_{jl}),\quad \omega_3=\tfrac1{\sqrt2}(e_{il}+e_{jk})$$

is an orthonormal basis of $\Lambda^2_+$, and the anti-self-dual partners are $(1,-1)$, $(1,+1)$, $(1,-1)$ in the three planes. **The sign pattern in L124's proof is correct**, the brief's first hunt comes back clean. (It is orientation-dependent; reversing the orientation swaps the roles and the conclusion is unchanged by symmetry, but the lemma should name an orientation.)

**Now compute $A$, $B$, $C$ without assuming anything about $W$ beyond half-flatness.** $V\Lambda^2_-=0$ and $V$ symmetric give $\Lambda^2_+$ $V$-invariant, so $V=V_+\oplus0$. Writing $e_{ij}=\tfrac1{\sqrt2}(\omega_1+\omega_1^-)$ and $e_{kl}=\tfrac1{\sqrt2}(\omega_1-\omega_1^-)$,

$$M_{ij}=\langle e_{ij},Ve_{ij}\rangle=\tfrac12\langle\omega_1,V\omega_1\rangle,\qquad M_{kl}=\tfrac12\langle\omega_1,V\omega_1\rangle,\qquad\text{so } A=(V_+)_{11},$$

and identically $B=(V_+)_{22}$, $C=(V_+)_{33}$ (the sign of $\omega_2$ squares away). **So $A,B,C$ are the *diagonal entries* of $V_+$ in the frame-induced basis $\{\omega_1,\omega_2,\omega_3\}$, not its eigenvalues**, and

$$\rho^2=\lVert V\rVert^2=\lVert V_+\rVert^2=A^2+B^2+C^2+2\big[(V_+)_{12}^2+(V_+)_{13}^2+(V_+)_{23}^2\big]\;\ge\;A^2+B^2+C^2 .$$

The two coincide exactly when $V_+$ is diagonal in that basis, equivalently when the three opposite-pair planes are $V$-invariant. **That is the hypothesis L124(ii) needs and does not state.**

**Where the proof gets it wrong.** It writes *"Each opposite pair spans a $W$-invariant plane ([Lemma L121](../findings/second-order.md))"*. L121 says nothing of the kind: its subject is $L_M$ on the $2$-dimensional four-set summand $V_{ijkl}\subset\mathrm{Sym}^2(\Lambda^2)$, an operator on symmetric squares of bivectors. $W$-invariance of a plane inside $\Lambda^2\langle S\rangle$ is a different assertion about a different space, and L121 does not supply it.

**And L121's own hypothesis makes the lemma vacuous.** L121 (with the scope correction recorded below L123) holds *under diagonality*, $W$ diagonal in the pair basis. Then $V=\mathrm{diag}(M_{ij},M_{ik},M_{il},M_{jk},M_{jl},M_{kl})$ and half-flatness reads

$$V(e_{ij}-e_{kl})=M_{ij}e_{ij}-M_{kl}e_{kl}=0\ \Rightarrow\ M_{ij}=M_{kl}=0,$$

and the same in the other two planes: **$V=0$, so $\rho^2=\Sigma=0$ and L124(ii) says $0=0$.** This is a genuine pincer. Where L121's hypothesis holds, L124(ii) is empty; where L124(ii) has content, L121's hypothesis fails and the plane-invariance it was cited for is unproved.

### The counterexample is the record's own witness in a rotated frame

Rotate padded $\mathbb{CP}^2$ by a Givens rotation in the $(e_2,e_3)$ plane. Because the rotation lies in $SO(4)$ acting on $\langle S\rangle$, it preserves $\Lambda^2\langle S\rangle$, the orientation, the Hodge splitting, the norm, criticality and $\theta$. **Screened** at $n=8$ with [padded_cp2](../scripts/lib/b_cp2_nondegenerate.py) and [Q_full](../scripts/lib/adversarial_check1.py):

| | record frame | rotated by $30^\circ$ in $(e_2,e_3)$ |
|---|---|---|
| criticality residual | $2.1\times10^{-15}$ | $2.2\times10^{-15}$ |
| $\theta$ | $1.224744871$ | $1.224744871$ |
| anti-self-dual image on $S$ | $9.2\times10^{-16}$ | $9.1\times10^{-16}$ |
| $A+B+C$ | $9.4\times10^{-16}$ | $9.4\times10^{-16}$ |
| $(A,B,C)$ | $(0.816497,-0.408248,-0.408248)$ | $(0.510310,-0.102062,-0.408248)$ |
| $\rho^2$ | $1$ | $1$ |
| $A^2+B^2+C^2$ | $1$ | $\mathbf{0.4375}$ |
| $\Sigma$ | $1.5$ | $\mathbf{0.65625}$ vs $\tfrac32\rho^2=1.5$ |

**Both hypotheses of L124(ii) hold and both of its conclusions fail.** The eigenvalues of $V_+$ are of course still $\tfrac1{\sqrt6}(2,-1,-1)$; $(A,B,C)$ is its diagonal, $\propto(5,-1,-4)$. The screen is a check of an argument already complete above, not the argument.

### Repaired statement

> **(0)** $A+B+C=\mathop{\mathrm{tr}}V$, and the first Bianchi component on $S$ ($W_{ijkl}+W_{iklj}+W_{iljk}=0$), is exactly $\mathop{\mathrm{tr}}V_+=\mathop{\mathrm{tr}}V_-$.
> **(ii$'$)** If $V_-=0$ then $A+B+C=0$ **automatically**; $(A,B,C)=\mathop{\mathrm{diag}}(V_+)$ in the basis $\{\omega_1,\omega_2,\omega_3\}$; and
> $$\Sigma=\tfrac32\big(A^2+B^2+C^2\big)\;\le\;\tfrac32\rho^2,$$
> with equality **iff** $V_+$ is diagonal in that basis, i.e. iff the three opposite-pair planes are $W$-invariant.

Two consequences for the write-up. First, **"if in addition" is wrong**: $A+B+C=0$ is implied by half-flatness plus Bianchi, so (i)'s hypothesis is not extra in (ii). Second, **the inequality runs the wrong way for every downstream use**, see V5.

---

## V1, CONFIRMED, but the hypothesis is attributed to the wrong axiom

The identity is right: $(A+B+C)^2=0$ gives $AB+BC+CA=-\tfrac12(A^2+B^2+C^2)$, hence $\Sigma=\tfrac32(A^2+B^2+C^2)$. It is pure algebra and says nothing about $W$; all of its content is in when $A+B+C=0$ holds.

**The corollary's attribution is false.** It says $\Sigma=\tfrac32\rho^2$ is *"forced by half-flatness and trace-freeness"*. Trace-freeness (Ricci-flatness) is $\sum_bM_{ab}=0$ over **all** $b$, and summing it over $a\in S$ gives

$$2(A+B+C)=-\sum_{a\in S,\;b\notin S}M_{ab},$$

so it forces $A+B+C=0$ only when the cross terms cancel, automatic for a $W$ supported on $S$, false in general. **Screened**: a random Ricci-flat Weyl tensor at $n=8$ (Ricci residual $1.5\times10^{-16}$) gives $A+B+C=+0.1326,\ +0.0222,\ -0.1134$ at three four-subsets. The correct source of $A+B+C=0$ is **first Bianchi plus half-flatness**, per (0) above.

---

## V3, CONFIRMED as arithmetic, with a frame the statement does not carry

Reproduced exactly at $n=8$: $\theta=\sqrt{3/2}$, half-flat at $S=\{1,2,3,4\}$, $(A,B,C)=\tfrac1{\sqrt6}(2,-1,-1)$, $\rho^2=1$, $\Sigma=\tfrac32=\theta^2$, and $t_F=1$, matching [DERIVE-mx1.md](DERIVE-mx1.md)'s table.

**The defect is that the corollary states this of "padded $\mathbb{CP}^2$" full stop.** $\Sigma$ is built from sectional curvatures and is *not* invariant under rotations of $\langle S\rangle$, while $\rho^2$ and half-flatness *are*. An identity between a frame-dependent and a frame-invariant quantity, under frame-invariant hypotheses, cannot hold, which is a one-line a priori refutation of V2 needing no computation at all, and it means V3 must read "in the frame where $V_+$ is diagonal". At other four-subsets of padded $\mathbb{CP}^2$ the hypotheses hold vacuously ($V=0$).

---

## V4, REFUTED. The equality is the equality case of a sharp inequality, by two independent routes

### Route 1: $\theta$ and $\Sigma$ are coupled on the family, and CP² is the equality point

Consider the family L124's corollary lives in: $W\in\mathcal W_n$ supported on $\Lambda^2_+\langle S\rangle$, i.e. $W\leftrightarrow V_+$ traceless symmetric $3\times3$. This is a genuine $5$-parameter family, Ricci-flatness is automatic, since $M_{ij}=M_{kl}=\tfrac A2$ etc. makes every row sum $\tfrac12(A+B+C)=0$, and Bianchi is $\mathop{\mathrm{tr}}V_+=0$.

On it, $\Lambda^2(\mathbb R^4)=\mathfrak{so}(3)_+\oplus\mathfrak{so}(3)_-$ with the bracket preserving each factor, so both $W^2$ and $W^{\#}$ stay in $\Lambda^2_+$ and $W^{\#}$ is the adjugate of $V_+$ up to a constant. Hence $P(W)=\mathop{\mathrm{tr}}(V_+^3)+\kappa\mathop{\mathrm{tr}}(V_+\mathop{\mathrm{adj}}V_+)=3(1+\kappa)\det V_+$ for traceless $V_+$, and the record's own catalogued $\theta=\sqrt{3/2}$ at the $\tfrac1{\sqrt6}(2,-1,-1)$ member pins the constant:

$$\boxed{\ \theta=9\det V_+\ }$$

**Screened** with [P_value](../scripts/lib/adversarial_check1.py) at $n=8$, spectra $(2,-1,-1)$, $(1,-1,0)$, $(3,-1,-2)$, $(1,1,-2)$, $(5,-2,-3)$, each normalised, each Ricci-flat and Bianchi to $0$ or $5.6\times10^{-17}$:

| $V_+$ spectrum | $\theta$ | $9\det V_+$ | $\Sigma$ | $\theta^2$ |
|---|---|---|---|---|
| $(2,-1,-1)$ | $1.224745$ | $1.224745$ | $1.5$ | $1.5$ |
| $(1,-1,0)$ | $0$ | $0$ | $1.5$ | $0$ |
| $(3,-1,-2)$ | $1.030865$ | $1.030865$ | $1.5$ | $1.06268$ |
| $(1,1,-2)$ | $-1.224745$ | $-1.224745$ | $1.5$ | $1.5$ |
| $(5,-2,-3)$ | $1.152626$ | $1.152626$ | $1.5$ | $1.32855$ |

Now apply the sharp bound $\lvert\det X\rvert\le\lVert X\rVert^3/(3\sqrt6)$ for traceless symmetric $3\times3$, whose equality case is spectrum $\propto\pm(2,-1,-1)$:

$$\theta^2=81(\det V_+)^2\;\le\;\tfrac{81}{54}\lVert V_+\rVert^6=\tfrac32\rho^6=\tfrac32\rho^2=\Sigma\quad\text{at }\rho=1 .$$

**So on this family $\theta^2\le\Sigma$ always, with equality exactly at $\pm(2,-1,-1)$, i.e. exactly at padded $\mathbb{CP}^2$.** $\Sigma$ is *constant* $=\tfrac32$ across the family while $\theta^2$ ranges over $[0,\tfrac32]$; the equality at $\mathbb{CP}^2$ is the statement that $\mathbb{CP}^2$ maximises $\lvert P\rvert$ on the family. That is a variational fact about one and the same $V_+$, not "a numerical collision of two independent facts". Note also the direction: on the family $\theta^2\le\Sigma$, which is the **reverse** of L121's $\Sigma\le\theta^2$, so the two together force $\theta^2=\Sigma$ and hence pin the spectrum to $\pm(2,-1,-1)$, a rigidity statement the corollary threw away by calling the equality a coincidence. (The $(1,1,-2)$ member has $\theta<0$, so [Lemma L24](../findings/second-order.md)'s $\theta>0$ excludes it.)

### Route 2: at CP² the block's top eigenvector is the direction L24 excludes

L121's block is $\tfrac12G$ with $G=\begin{pmatrix}A&C&B\\C&B&A\\B&A&C\end{pmatrix}$. With $A+B+C=0$,

$$G(A,B,C)^{\mathsf T}=\big(3A^2-\tfrac23\Sigma,\ 3B^2-\tfrac23\Sigma,\ 3C^2-\tfrac23\Sigma\big)^{\mathsf T},$$

which is proportional to $(A,B,C)$ **iff two of $A,B,C$ coincide** (three numbers cannot be roots of one quadratic otherwise). At $\tfrac1{\sqrt6}(2,-1,-1)$ they do, and **screened**: $G(A,B,C)=(1,-\tfrac12,-\tfrac12)=\theta\,(A,B,C)$, so $(A,B,C)$ is the *top* eigenvector, eigenvalue $\sqrt\Sigma=\theta$.

But $(A,B,C)/2$ is precisely $W$'s own component in that four-set block, $W_{ij,kl}=\tfrac12(V_+)_{11}=\tfrac A2$, and likewise for the other two pairings. **So at padded $\mathbb{CP}^2$ the eigenvector realising L121's bound is $W$'s own projection into the block, which [Lemma L24](../findings/second-order.md) excludes ($X\perp W$ fails maximally there).** Equality in L121 at a point is therefore not evidence of sharpness; it is the signature of the degenerate case in which the inequality was never derivable. This is the [DERIVE-mx1.md](DERIVE-mx1.md) projection defect showing up as the *cause* of the equality rather than as a separate correction.

---

## V5, REFUTED three ways, and the vacuity direction is backwards

**(a) The implication does not hold.** The concentration bound needs $\Sigma=\tfrac32\rho^2$ to turn $\Sigma\le\theta^2$ into $\rho^2\le\tfrac23\theta^2$. What is true is $\Sigma\le\tfrac32\rho^2$ (V2 above). Two upper bounds on $\Sigma$ compose to nothing: no bound on $\rho^2$ follows. **The concentration bound is not proved.**

**(b) The hypotheses of its two inputs are incompatible.** L121 requires $W$ pair-basis diagonal; a half-flat four-set with $\rho\ne0$ requires $W$ pair-basis non-diagonal (shown above). So no configuration satisfies both as stated. Bridging them is exactly the frame problem [DERIVE-mx1.md](DERIVE-mx1.md) is about, with its projection defect, and by Route 2, at the one witness on record that defect is not small but total.

**(c) The vacuity direction is inverted, because $\theta\ne\theta_0(n)$.** $\theta$ in [Lemma L24](../findings/second-order.md) is $P(W)$ **at the maximiser**, i.e. $\max P$; $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ is the *sphere-product* value, equal to $\max P$ only if Conjecture A holds. The record states at [problem.md](../findings/problem.md) and in [b_cp2_nondegenerate.py](../scripts/lib/b_cp2_nondegenerate.py) that **zero-padded $W_{\mathbb{CP}^2}$ keeps $\theta=\sqrt{3/2}$ at every $n$**. It is a unit Weyl operator, so

$$\max P\;\ge\;\max\big(\theta_0(n),\ \sqrt{3/2}\big)\;\ge\;\sqrt{3/2}\qquad\text{at every }n\ge4 .$$

Since $\rho^2\le\lVert W\rVert^2=1$ is free, the bound $\rho^2\le\tfrac23\theta^2$ is vacuous whenever $\theta^2\ge\tfrac32$, **which is every $n$**. It is never binding. Worse, $n\le11$ is precisely the range in which padded $\mathbb{CP}^2$ *beats* $\theta_0(n)$, so it is the range where $\max P\ge\sqrt{3/2}$ is most securely known; the write-up reads $\theta_0(n)<\sqrt{3/2}$ there as "binding" when it is the direct witness for vacuity. **The $n^2-12n+8$ threshold is not recovered from the second variation; it is imported by substituting $\theta_0$ for $\theta$ in the one range where they provably differ.**

---

## V6, REFUTED: on L124's own family $t_F$ *is* $\tfrac23\Sigma$, and $\rho$ is the constant

**First, the two $\rho$'s are different objects.** [DERIVE-mx1.md](DERIVE-mx1.md)'s $\rho=\langle X,W\rangle=\langle X,R\rangle$ is the four-set's overlap with the **off-diagonal** part; L124's $\rho^2=\lVert W|_{\Lambda^2\langle S\rangle}\rVert^2$ includes $\mathop{\mathrm{diag}}(M)$. At padded $\mathbb{CP}^2$ they are $\tfrac12$ and $1$. The paragraph "What this changes in I12" moves between them without saying so.

**Second, the attribution is a distinction without a difference.** For $W$ supported on one half-flat four-set, $M_{ij}=M_{kl}=\tfrac A2$ and its relatives give

$$t_F=2\lVert\mathop{\mathrm{diag}}(M)\rVert^2=2\cdot\tfrac{A^2+B^2+C^2}{2}=A^2+B^2+C^2=\tfrac23\Sigma .$$

**Screened**: $t_F=1$ with $\Sigma=1.5$ in the record frame, $t_F=0.4375$ with $\Sigma=0.65625$ after the rotation, the identity $\Sigma=\tfrac32t_F$ holds exactly in both. Meanwhile $\rho^2$ (L124's) is $1$ in *both* frames. **So on the very family the corollary reasons about, $t_F$ tracks $\Sigma$ perfectly and $\rho$ does not vary at all.** Attributing the effect to $\rho$ rather than $t_F$ is not a relocation of the slack; it renames the frame budget and then denies it.

**Third, the record's own datum contradicts the claim at the cited point.** At padded $\mathbb{CP}^2$, $\rho^2_{\mathrm{I12}}=\tfrac12=\lVert R\rVert^2=1-\tfrac{t_F}2$ **exactly**, so the step $\rho\le\lVert R\rVert$ is tight and contributes zero slack. [DERIVE-mx1.md](DERIVE-mx1.md) says the same in its own words, *"slack by $2.25$ there, all of it the correction"*. The residual factor $\big(1+\rho^2\big)^2=2.25$ is the looseness of the **projection correction** $\langle X,L_eX\rangle\le\tfrac12(1+c^2)$, which is a third thing, neither $\rho$-concentration nor $t_F$.

*What survives of V6*: at points where $W$ is spread over many four-sets, a single $\rho_S^2$ is far below the budget $1-t_F/2$ (DERIVE-mx1 records $0.03$–$0.12$ against $0.84$–$0.96$ at rotated $S^3\times S^3$), so there is real slack in using the total budget for one subset. That is a statement about **concentration within** the $t_F$ budget, not an alternative to it, and it is not what L124's paragraph asserts.

---

## Corrections owed

1. **L124(ii)**, add the hypothesis "the three opposite-pair planes are $W$-invariant", or restate as the inequality $\Sigma\le\tfrac32\rho^2$ with that as the equality case. Delete the citation of [Lemma L121](../findings/second-order.md) for plane-invariance; L121 is about $L_M$ on $\mathrm{Sym}^2(\Lambda^2)$.
2. **L124(ii)**, record that $A+B+C=0$ follows from half-flatness plus first Bianchi, and drop "if in addition"; correct the corollary's attribution of it to trace-freeness.
3. **The corollary**, qualify by frame. $\Sigma$ is frame-dependent, $\rho^2$ is not.
4. **The "two independent facts" box**, withdraw. Replace with $\theta^2\le\tfrac32\rho^2$ on the half-flat single-four-set family, sharp exactly at $\pm(2,-1,-1)$, plus the observation that at that point L121's extremal eigenvector is $W$'s own block component and so is L24-excluded.
5. **The concentration box**, withdraw. The implication needs the refuted equality; the two inputs have incompatible hypotheses; and the bound is vacuous at every $n\ge4$ because padded $\mathbb{CP}^2$ puts $\max P\ge\sqrt{3/2}$ at every $n$.
6. **The I12 paragraph**, withdraw. Distinguish the two $\rho$'s; record $t_F=\tfrac23\Sigma$ on the family; and note the $2.25$ at padded $\mathbb{CP}^2$ is entirely the projection correction, per that note's own table.
7. **The "Screened" line**, it reports $(A,B,C)=\tfrac1{\sqrt6}(2,-1,-1)$ and $\rho^2=1$ as if frame-free. Add the frame, and add that a rotation inside $\langle S\rangle$ preserves every hypothesis while moving $\Sigma$ to $0.656$.

## What survives

- **V1**, as an identity.
- The **sign pattern** $(1,-1),(1,1),(1,-1)$ for the anti-self-dual vectors, which is correct for $i<j<k<l$ and the standard orientation.
- The repaired **(ii$'$)** above, which is a real lemma: half-flatness makes $\Sigma$ a norm defect, $\Sigma=\tfrac32\lvert\mathop{\mathrm{diag}}V_+\rvert^2\le\tfrac32\lVert V_+\rVert^2$.
- The new coupling $\theta^2\le\Sigma$ on the half-flat single-four-set family, which is worth more than the claim it refutes: combined with L121 it says the only member of that family that could be a maximiser is padded $\mathbb{CP}^2$.
