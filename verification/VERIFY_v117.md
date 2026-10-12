# VERIFY v117, L7's compression inequality, its $6\delta^2$, and what its equality clause actually characterises

**Cold brief.** Verifier v117 on Round L07, checking the block at [findings/bounds.md](../findings/bounds.md):43–59 with the canonical form at [results.md](../results.md):326 and the landscape line at :122. **No numerical work was done: no script was run, and every value below is an exact hand evaluation** in rationals and surds. Log: [agent_logs/verify-L07-v117.log](../agent_logs/verify-L07-v117.log).

## Verdicts

| # | Claim, as a consumer would read it | Where | Verdict |
|---|---|---|---|
| 1 | The exact identity $\theta\operatorname{tr}(W_-)+\operatorname{tr}(W_-^2)=-\operatorname{tr}(\Pi_-W^\#)$ at a critical point | [bounds.md](../findings/bounds.md):51 | **PROVEN** |
| 2 | The inequality $\theta\operatorname{tr}(W_-)+\operatorname{tr}(W_-^2)\le\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2$ at every critical point | [bounds.md](../findings/bounds.md):47 | **PROVEN** |
| 3 | The coefficient $6$ is L15's, dimension-free, and sharp | [bounds.md](../findings/bounds.md):53 | **PROVEN, sharp, attained at $W_{\mathbb{CP}^2}$** |
| 4 | Hypotheses are criticality, Ricci-flatness, first Bianchi; the last two twice each in the final step | [bounds.md](../findings/bounds.md):53 | **PROVEN, count defensible; three unnamed uses** |
| 5 | The displayed rank-one formula $vv^{\mathsf T}\#ww^{\mathsf T}=[v,w][v,w]^{\mathsf T}$ | [bounds.md](../findings/bounds.md):51 | **BROKEN, factor $2$ wrong; inert for L7** |
| 6 | Equality $\iff$ the three bracket conditions | [bounds.md](../findings/bounds.md):57 | **PROVEN, no argument in the block; on file elsewhere** |
| 7 | "Equality … exactly where the eigenspace ranges form a symmetric pair" | [results.md](../results.md):326, :122, headings | **BROKEN at $W_{\mathbb{CP}^2}$** |
| 8 | "It fails strictly at the low-value ones" | [results.md](../results.md):326 | **BROKEN at $S^2\times S^4$ and $\mathbb{CP}^4$** |
| 9 | Lean row for L7 | [lean/INDEX.md](../lean/INDEX.md):179 | **STALE, carries the retired hedge** |

**One line.** *The inequality and its $6\delta^2$ are correct, sharp and hand-reproducible, and the equality clause as displayed in [bounds.md](../findings/bounds.md) is exactly right, but the canonical statement a consumer reads at [results.md](../results.md):326 carries two claims the record has refuted, with the refutation living in another file, and the displayed rank-one identity that the proof calls "a theorem" is off by a factor of two.*

**Verdict: GAP**, the inequality is proven; the citable statement at [results.md](../results.md):326 is not the proven one.

---

## 0. Conventions, fixed once

Everything below is in the record's own normalisation, read from [conventions.md](../findings/conventions.md) and cross-checked against [Lemma L131](../findings/isotropy-cap.md) rather than assumed.

- $\Lambda^2\mathbb R^n$ carries the orthonormal basis $\{e_i\wedge e_j\}_{i<j}$; operator pairing is the plain trace, $\langle X,Y\rangle=\operatorname{tr}(XY)$ for symmetric $X,Y$, so $\operatorname{tr}(W^2)=1$ at a unit Weyl tensor.
- The identification $\Lambda^2\cong\mathfrak{so}(n)$ sends $e_i\wedge e_j$ to $E_{ij}-E_{ji}$, so $\lVert\varphi\rVert^2_{\Lambda^2}=\tfrac12\lVert\Phi\rVert_F^2$ for the antisymmetric matrix $\Phi$ of $\varphi$. Brackets are matrix commutators.
- $\mathrm{Ric}(R)_{ik}=\sum_jR_{ijkj}$ on $n\times n$ matrices with plain Frobenius pairing; $\operatorname{scal}(R)=\sum_{ij}R_{ijij}=2\operatorname{tr}_{\Lambda^2}(R)$. On a rank one $\varphi\varphi^{\mathsf T}$ this gives $\mathrm{Ric}(\varphi\varphi^{\mathsf T})=\Phi\Phi^{\mathsf T}$.
- **Two independent checks that this is the record's normalisation and not mine.** (i) $\mathrm{Ric}(\mathrm{Id}_{\Lambda^2})=(n-1)\,\mathrm{id}$ and $\mathrm{Ric}^*(\mathrm{id})=2\,\mathrm{Id}$ ([post F54](../findings/second-order.md)'s eigenvalues $\eta_i+\eta_j$) pair as $\langle 2\mathrm{Id},\mathrm{Id}\rangle_{\Lambda^2}=n(n-1)=\langle\mathrm{id},(n-1)\mathrm{id}\rangle$, so $\mathrm{Ric}^*$ really is $\mathrm{Ric}$'s adjoint here. (ii) [L131](../findings/isotropy-cap.md)'s $\mathrm{Ric}(R)\wedge\mathrm{id}=R+R\#I-3\,\mathrm{Alt}(R)$ at $R=W$ Weyl gives $W\#I=-W$, hence $\operatorname{tr}(W^\#)=\operatorname{tr}((W\#I)W)=-1$, which is [conventions.md](../findings/conventions.md):122's recorded anchor.
- $W_-:=\tfrac12(\lvert W\rvert-W)\succeq0$ ([conventions.md](../findings/conventions.md):95), $W_+:=\tfrac12(\lvert W\rvert+W)\succeq0$, both **as operators on all of $\Lambda^2$**; $W=W_+-W_-$, $\lvert W\rvert=W_++W_-$, $W_+W_-=0$. $\Pi_-=P_-$ is the orthogonal spectral projection onto $E_-=\operatorname{ran}W_-$, $P_+$ onto $E_+=\operatorname{ran}W_+$, $P_0$ onto $E_0=\ker W$. Throughout, $\mathfrak p=E_+$, $\mathfrak m=E_-$, $\mathfrak k=E_0$ read inside $\mathfrak{so}(n)$.
- $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$ ([results.md](../results.md):362), $\mathrm{Alt}$ the orthogonal projection onto $\Lambda^4$ carrying its $\tfrac13$; inside $\Lambda^2\mathbb R^4$, $\mathrm{Alt}=\langle\cdot,\star\rangle\star/6$ with $\star=\Pi_{SD}-\Pi_{ASD}$, $\lVert\star\rVert^2=6$.
- Criticality is $Q(W)=W^2+W^\#=\theta W$, the equation and not the bracket form $[W,Q(W)]=0$.

**One derived constant I will use and the block gets wrong.** From [L131](../findings/isotropy-cap.md) at $R=I$: $\mathrm{Ric}(I)=(n-1)\mathrm{id}$, $\mathrm{Alt}(I)=0$, $\mathrm{id}\wedge\mathrm{id}=\mathrm{Id}$, so $(n-1)I=I+I\#I$ and $I^\#=(n-2)I$. Against the rank-one law $vv^{\mathsf T}\#ww^{\mathsf T}=c\,[v,w][v,w]^{\mathsf T}$ summed over an orthonormal basis of $\mathfrak{so}(n)$, $\langle(I\#I)\xi,\xi\rangle=c\sum_{\alpha\beta}\langle[b_\alpha,b_\beta],\xi\rangle^2=c\sum_\alpha\lVert\mathrm{ad}(\xi)b_\alpha\rVert^2=-c\operatorname{tr}(\mathrm{ad}\xi)^2=c\,(n-2)\lVert\xi\rVert_F^2=2c(n-2)\lVert\xi\rVert^2$, using the Killing form $B(X,Y)=(n-2)\operatorname{tr}(XY)$ of $\mathfrak{so}(n)$. So $c=\tfrac12$, not $1$.

---

## 1. The hypothesis inventory

**Carried by the block.** Criticality $Q(W)=\theta W$; $\mathrm{Ric}(W)=0$; $\mathrm{Alt}(W)=0$ (first Bianchi). Explicitly disclaimed: any sign condition, any unit-norm requirement.

**Imported results, and the object each applies to.**

| imported | statement used | object it is applied to | hypotheses it carries | met? |
|---|---|---|---|---|
| bilinearity of $\#$ | $(A-B)^\#=A^\#-2A\#B+B^\#$ | $A=W_+$, $B=W_-$ | $\#$ symmetric bilinear | yes, by definition |
| rank-one positivity of $\#$ | $X,Y\succeq0\Rightarrow X\#Y\succeq0$ | $(W_+,W_+)$, $(W_-,W_-)$, $(W_+,W_-)$ | none, a theorem | yes; $W_\pm\succeq0$ by [conventions.md](../findings/conventions.md):95 |
| [Observation L15](../findings/problem.md) | $\operatorname{scal}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2$ | $R=W_\pm$, **polarised** | $R$ symmetric on $\Lambda^2$; **no Bianchi hypothesis** | yes, and the "no Bianchi" is load-bearing, since $W_\pm$ are exactly the objects that fail it |
| [Lemma L131](../findings/isotropy-cap.md) | supplies L15 by depolarisation | as above | $R$ symmetric | yes |
| [Lemma L154](../findings/bounds.md)(i), [L155](../findings/bounds.md) | used only by the **equality clause**, not by the inequality | $X_{\mathrm{inv}}$ | L154(i) needs criticality; L155 needs none | yes |

**Which hypotheses the written proof actually uses.**

| hypothesis | used where | how many times |
|---|---|---|
| criticality $Q(W)=\theta W$ | Step 1, the partial trace | once (again in the equality clause's closure sub-claim) |
| $\mathrm{Ric}(W)=0$ | Step 4 only | once by the direct route, twice by the $\lvert W\rvert$ route, see §3 |
| $\mathrm{Alt}(W)=0$ | Step 4 only | as above |
| unit norm | nowhere, the statement is homogeneous of degree $2$ | zero |
| sign of $\theta$ | nowhere | zero |
| parity of $n$, size of $n$, $\ker W=0$, diagonalisability | nowhere | zero |

**Three properties used and not named anywhere in the block.**

1. **$W_+W_-=0$.** It kills the $\tfrac12(AB+BA)$ half of the polarised quadratic form in Step 4, and it is what makes $\operatorname{tr}(\Pi_-W^2)=\operatorname{tr}(W_-^2)$ in Step 1. It is automatic for spectral parts, so it is a fact rather than a hypothesis, but the proof does not run without it, and the block never writes it.
2. **$\Pi_-$ is the *spectral* projection**, so $\Pi_-W=W\Pi_-=-W_-$. The block never defines $\Pi_-$ at all. Any other projection of the same rank breaks Step 1.
3. **$\operatorname{scal}=2\operatorname{tr}_{\Lambda^2}$.** Step 3 ends at $2\operatorname{tr}(W_+\#W_-)$ and Step 4 delivers $\operatorname{scal}(W_+\#W_-)$; the two are the same number only under this convention. The factor $2$ is not decoration, it is the whole match between the two halves of the proof.

*No finding: the block imports nothing whose own hypotheses fail at the object it is applied to.*

---

## 2. Question 1, does the compression give the inequality?

### 2.1 The identity, PROVEN

$W_-$ is supported on $E_-$ and $W$ acts there as $-W_-$, so $\Pi_-W=-W_-$ and $\Pi_-W^2=W_-^2$. Applying $\operatorname{tr}(\Pi_-\,\cdot\,)$ to $W^2+W^\#=\theta W$:

$$\operatorname{tr}(W_-^2)+\operatorname{tr}(\Pi_-W^\#)=-\theta\operatorname{tr}(W_-),\qquad\text{i.e.}\qquad \theta\operatorname{tr}(W_-)+\operatorname{tr}(W_-^2)=-\operatorname{tr}(\Pi_-W^\#).$$

Exactly as written. This is the only place criticality enters, and it enters as the *equation*: the weaker bracket form $[W,Q(W)]=0$ ([conventions.md](../findings/conventions.md):119) does not support a trace of the equation, so "at every critical point" is exact rather than loose.

### 2.2 The step that turns it into an inequality, PROVEN, with one wording slip

$W^\#=W_+^\#-2\,W_+\#W_-+W_-^\#$ by bilinearity, so with $C:=W_+\#W_-$,

$$-\operatorname{tr}(\Pi_-W^\#)=\underbrace{-\operatorname{tr}(\Pi_-W_+^\#)}_{\le0}\underbrace{-\operatorname{tr}(\Pi_-W_-^\#)}_{\le0}+\,2\operatorname{tr}(\Pi_-C)\;\le\;2\operatorname{tr}(C).$$

$W_+^\#$, $W_-^\#$ and $C$ are all PSD because $\#$ preserves the PSD cone. **The two dropped terms are killed by $\Pi_-\succeq0$, not by $\Pi_-\preceq I$**; $\Pi_-\preceq I$ is what gives the last step, $\operatorname{tr}(\Pi_-C)\le\operatorname{tr}(C)$. The block's "kills two terms against $\Pi_-\preceq I$" attaches the wrong half of $0\preceq\Pi_-\preceq I$ to the wrong step. Both facts are true and both are used; nothing downstream moves.

### 2.3 Where the $6\delta^2$ comes from, and whether the coefficient is right, PROVEN, and sharp

L15's identity is a quadratic form in $R$. Its polarisation at $(A,B)$ reads $\operatorname{scal}\big(\tfrac12(AB+BA)+A\#B\big)=\langle\mathrm{Ric}A,\mathrm{Ric}B\rangle+6\langle\mathrm{Alt}A,\mathrm{Alt}B\rangle$. At $(W_+,W_-)$ the product term dies on $W_+W_-=0$, and $\mathrm{Ric}(W)=0$, $\mathrm{Alt}(W)=0$ give $\mathrm{Ric}(W_+)=\mathrm{Ric}(W_-)$ and $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$:

$$2\operatorname{tr}(C)=\operatorname{scal}(W_+\#W_-)=\lVert\mathrm{Ric}(W_-)\rVert^2+6\lVert\mathrm{Alt}(W_-)\rVert^2=\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2 .$$

**So the $6$ is L15's, transported by a polarisation that scales both terms of the identity alike, and it is never re-derived.** It cannot be wrong independently of L15, and L15 itself is not taken on faith here: pairing [L131](../findings/isotropy-cap.md)'s $\mathrm{Ric}(R)\wedge\mathrm{id}=R+R\#I-3\mathrm{Alt}(R)$ with $R$, using total symmetry of $\operatorname{tr}((A\#B)C)$ and idempotence of $\mathrm{Alt}$, gives $\tfrac12\lVert\mathrm{Ric}R\rVert^2=\operatorname{tr}(R^2)+\operatorname{tr}(R^\#)-3\lVert\mathrm{Alt}R\rVert^2$, which is L15 exactly. The $6$ is $2\times3$ and the $3$ is $1+c_4$ with $c_4=2$ the $\Lambda^4$ Casimir.

**The coefficient is sharp, and I pinned it by hand at the block's own named point.** At $W_{\mathbb{CP}^2}$, $n=4$: $W$ is self-dual with $\operatorname{spec}=(2\varepsilon,-\varepsilon,-\varepsilon)$ on $\Lambda^2_+$ and $0$ on $\Lambda^2_-$; $\operatorname{tr}W^2=6\varepsilon^2=1$ fixes $\varepsilon=1/\sqrt6$, and $\theta=3\varepsilon=\sqrt{3/2}$.

- $\theta\operatorname{tr}(W_-)+\operatorname{tr}(W_-^2)=3\varepsilon\cdot2\varepsilon+2\varepsilon^2=8\varepsilon^2=\tfrac43$.
- $W_+=\varepsilon\,\omega\omega^{\mathsf T}$ with $\Omega=E_{12}-E_{21}+E_{34}-E_{43}$, so $\lVert\omega\rVert^2=2$ and $\operatorname{tr}W_+=2\varepsilon$ as required; $\mathrm{Ric}(W_+)=\varepsilon\,\Omega\Omega^{\mathsf T}=\varepsilon I_4$, so $\lVert\mathrm{Ric}(W_-)\rVert^2=\lVert\mathrm{Ric}(W_+)\rVert^2=4\varepsilon^2=\tfrac23$.
- $\mathrm{Alt}(W_-)$: $W_-=\varepsilon\Pi_-$ with $\Pi_-$ of rank $2$ inside $\Lambda^2_+$, so $\langle W_-,\star\rangle=2\varepsilon$ and $\delta^2=(2\varepsilon)^2/6=\tfrac4{36}=\tfrac19$; $6\delta^2=\tfrac23$.

$\tfrac23+\tfrac23=\tfrac43$: **equality, exactly, with $\delta^2\ne0$.** Any coefficient below $6$ makes the lemma false at $W_{\mathbb{CP}^2}$; any coefficient above it loses the equality the block claims there. **The coefficient is right and is the only one that works.**

*The sphere products cannot see this, because $\delta^2=0$ there, the block says so, and it is the reason a single anchor would have been worthless.*

---

## 3. Question 3, which hypotheses the proof uses, and how often

**Criticality: once**, at Step 1, and nowhere else. The right-hand side needs none of it: polarising L15 at $(W,W_+)$ instead gives $\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2\ge\operatorname{tr}(W_+^2)+\operatorname{tr}(W_-^2)=\lVert W\rVert^2$ for **every** Weyl $W$, which is [ATTEMPTS.md](../ATTEMPTS.md)'s Result 3 by-product; I confirm it.

**Ricci-flatness and first Bianchi: "twice each in the final step" is defensible, and which count you get depends on the route.**

- *Direct route*, polarising at $(W_+,W_-)$: each is used **once**, to turn a bilinear pairing into a square.
- *$\lvert W\rvert$ route*, which is how [Theorem A](../ATTEMPTS.md) sets the algebra up: subtract L15 at $R=W$ from L15 at $R=\lvert W\rvert$. Since $\lvert W\rvert^2=W^2$ and $\lvert W\rvert^\#=W^\#+4C$, the left side is $4\operatorname{scal}(C)$; on the right, $\mathrm{Ric}(W)=0$ and $\mathrm{Alt}(W)=0$ are used **once each to delete the $R=W$ terms** and **once each again** inside $\mathrm{Ric}(\lvert W\rvert)=\mathrm{Ric}(W)+2\mathrm{Ric}(W_-)=2\mathrm{Ric}(W_-)$ and $\mathrm{Alt}(\lvert W\rvert)=2\mathrm{Alt}(W_-)$, giving $4[\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2]$. **Twice each**, and the same conclusion.

*The block's count is therefore correct under the route the surrounding record uses, and the sentence would be sharper if it said which.* [isotropy-cap.md](../findings/isotropy-cap.md) already records the trap this route runs on, $\lVert\mathrm{Alt}(\lvert W\rvert)\rVert^2=4\delta^2$, so "a constant stated at $\lvert W\rvert$ is not comparable with one stated at $W_-$", and the factor $4$ above is exactly it, cancelling on both sides.

**Further properties used without being named:** the three listed in §1, $W_+W_-=0$, $\Pi_-$ spectral, $\operatorname{scal}=2\operatorname{tr}$. **No finding beyond those:** I found no fourth.

**Two disclaimers checked rather than taken.**

- *"No unit-norm requirement."* **True.** Under $W\mapsto tW$ criticality carries $\theta\mapsto t\theta$, and every one of $\theta\operatorname{tr}W_-$, $\operatorname{tr}W_-^2$, $\lVert\mathrm{Ric}(W_-)\rVert^2$, $\delta^2$ is homogeneous of degree $2$. The statement is scale-invariant. (An on-file report marks unit norm as "used implicitly"; the homogeneity says otherwise, and the block is right.)
- *"No sign condition."* **True.** $\theta$ appears only in Step 1, an identity. At $\theta<0$ the left side may be negative and the bound is weak but valid; at $\theta=0$ it reduces to $\operatorname{tr}(W_-^2)\le\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2$.

---

## 4. Question 2, what the equality clause actually characterises

### 4.1 The slack, computed

Collecting §2.2, the slack $S:=\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2-\theta\operatorname{tr}(W_-)-\operatorname{tr}(W_-^2)$ is a sum of **three separately non-negative** traces:

$$S=\operatorname{tr}(P_-W_+^\#P_-)+\operatorname{tr}(P_-W_-^\#P_-)+2\operatorname{tr}\big((P_++P_0)\,C\,(P_++P_0)\big).$$

Each is the compression of a PSD operator, and by the rank-one law each expands as a **strictly-positively-weighted sum of squares of $\langle[\,\cdot\,,\cdot\,],\xi\rangle$** over eigenbases. Therefore $S=0$ iff each family of brackets vanishes against the relevant subspace:

| term | vanishes iff |
|---|---|
| $\operatorname{tr}(P_-W_+^\#P_-)$ | $[\mathfrak p,\mathfrak p]\perp\mathfrak m$ |
| $\operatorname{tr}(P_-W_-^\#P_-)$ | $[\mathfrak m,\mathfrak m]\perp\mathfrak m$ |
| $2\operatorname{tr}((P_++P_0)C(P_++P_0))$ | $[\mathfrak p,\mathfrak m]\perp\mathfrak p$ **and** $[\mathfrak p,\mathfrak m]\perp\mathfrak k$, i.e. $[\mathfrak p,\mathfrak m]\subseteq\mathfrak m$ |

**These are exactly the block's three displayed conditions, in the block's own order.** The clause is right as displayed, and it needs neither [L154](../findings/bounds.md) nor [L155](../findings/bounds.md) to state. *This derivation is mine; the block carries no argument for the clause, which is §7's finding, and an on-file report reaches the same three conditions independently.*

### 4.2 The closure into $\ker W$, PROVEN, and criticality is what buys it

I checked the block's "the kernel closes too" rather than inheriting it. The three spectral-diagonal blocks of $X_{\mathrm{inv}}$ ([Result 5(a)](../ATTEMPTS.md)) give $\tfrac12\operatorname{tr}X_{\mathrm{inv}}=2\operatorname{tr}(P_+C)+\operatorname{tr}(P_-(W_+^\#+W_-^\#))+\tfrac12\operatorname{tr}(P_0\lvert W\rvert^\#P_0)$, while $S$ above has $2\operatorname{tr}(P_0C)$ in the third slot. At a critical point $W^\#=\theta W-W^2$ annihilates $\ker W$, so $P_0\lvert W\rvert^\#P_0=P_0(W^\#+4C)P_0=4P_0CP_0$ and the two agree: $S=\tfrac12\operatorname{tr}X_{\mathrm{inv}}$, confirming [L154](../findings/bounds.md)'s relation clause by hand.

The same identity gives the closure directly. Writing $\lvert W\rvert^\#=W_+^\#+2C+W_-^\#$ and using $P_0W^\#P_0=0$,
$$P_0W_+^\#P_0+P_0W_-^\#P_0=2P_0CP_0 .$$
Under the third displayed condition $[\mathfrak p,\mathfrak m]\subseteq\mathfrak m$ the right side is $0$, and both PSD terms on the left must vanish, i.e. $[\mathfrak p,\mathfrak p]\perp\mathfrak k$ and $[\mathfrak m,\mathfrak m]\perp\mathfrak k$. **With $[\mathfrak p,\mathfrak m]\perp\mathfrak k$ already in hand, $\mathfrak p\oplus\mathfrak m$ is closed under the bracket.** So at a critical point the three displayed conditions are exactly equivalent to

$$[\mathfrak p,\mathfrak p]\subseteq\mathfrak p,\qquad [\mathfrak p,\mathfrak m]\subseteq\mathfrak m,\qquad [\mathfrak m,\mathfrak m]\subseteq\mathfrak p,$$

i.e. $\mathfrak p\oplus\mathfrak m$ is a $\mathbb Z_2$-graded subalgebra of $\mathfrak{so}(n)$ with even part $\mathfrak p$, [Lemma L155](../findings/bounds.md)'s class. **The block's retirement of the "modulo $\ker W$" hedge is correct**, and I reach it without going through $X_{\mathrm{inv}}=0$.

### 4.3 Is it "a symmetric pair with $E_+$ the isotropy algebra"?, NO, and the split is exactly at $\ker W$

The headings' reading is: $(\mathfrak{so}(n),E_+)$ is a compact symmetric pair, $\mathfrak{so}(n)=E_+\oplus E_+^\perp$ with $E_-=E_+^\perp$.

- **When $\ker W=0$ the two conditions coincide, in both directions.** Equality gives the grading of $\mathfrak p\oplus\mathfrak m=\mathfrak{so}(n)$, which is the symmetric pair; conversely a symmetric pair $(\mathfrak{so}(n),\mathfrak p)$ with $\mathfrak m=\mathfrak p^\perp$ satisfies all three displayed conditions verbatim, hence equality.
- **Forward implication fails at $W_{\mathbb{CP}^2}$, $n=4$.** Equality holds there exactly (§2.3, both sides $\tfrac43$), while $\dim E_+=1$, $\dim E_-=2$, $\dim\ker W=3$. $\mathfrak p\oplus\mathfrak m=\Lambda^2_+\cong\mathfrak{so}(3)$, an ideal of $\mathfrak{so}(4)=\mathfrak{so}(3)\oplus\mathfrak{so}(3)$, graded as $(\mathfrak{so}(3),\mathfrak{so}(2))$, a symmetric pair, but of a proper $3$-dimensional subalgebra of a $6$-dimensional $\mathfrak{so}(4)$. And $E_+$ is the even part of no grading of $\mathfrak{so}(4)$: the fixed algebras of involutions of $\mathfrak{so}(4)$ have dimensions $2$ ($\mathfrak{so}(2)\oplus\mathfrak{so}(2)$), $3$ ($\mathfrak{so}(3)$), $4$ ($\mathfrak u(2)$) and $6$, and $\dim E_+=1$ is not among them. **So equality does not give a symmetric pair of $\mathfrak{so}(n)$.**
- **Converse implication: it can only fail when $\ker W\ne0$, and I found no witness.** If $(\mathfrak{so}(n),\mathfrak p)$ is a symmetric pair but $\mathfrak m\subsetneq\mathfrak p^\perp$, the first two displayed conditions still hold ($[\mathfrak p,\mathfrak p]\subseteq\mathfrak p$ and $[\mathfrak m,\mathfrak m]\subseteq[\mathfrak p^\perp,\mathfrak p^\perp]\subseteq\mathfrak p$, both $\perp\mathfrak m$), but the third, $[\mathfrak p,\mathfrak m]\subseteq\mathfrak m$, is not supplied, the bracket may leak into $\ker W$. **That is the only gap, and no object on the record is exhibited in it.** [bounds.md](../findings/bounds.md):59's converse sentence (*"a symmetric pair gives equality only where $W$'s spectral splitting coincides with it"*), is about a different and looser reading, in which the pair is unrelated to $W$; under that reading it is trivially true, and under the sentence's own reading ("with $E_+$ the isotropy algebra") the failure is unexhibited.

**Answer to question 2, in one line.** *The equality clause characterises "$\operatorname{ran}W_+\oplus\operatorname{ran}W_-$ is a $\mathbb Z_2$-graded subalgebra of $\mathfrak{so}(n)$ with even part $\operatorname{ran}W_+$". That is the symmetric-pair condition of the headings **exactly on $\{\ker W=0\}$**; off it the forward implication fails, at $W_{\mathbb{CP}^2}$, and the converse is open in one narrow case.*

---

## 5. Quantifier order, scope, and every edge of the range

The statement quantifies as: *for all $n$, for all $W\in\mathcal W_n$, for all $\theta$ with $Q(W)=\theta W$, the inequality holds.* There is no existential anywhere and no order to get wrong, $\theta$ is determined by $W$ (up to $W=0$), and the block's "at every critical point" binds $W$ before the inequality. **No finding on quantifier order.**

| edge | reading | verdict |
|---|---|---|
| smallest admissible $n$ | $\mathcal W_n=0$ for $n\le3$, so the first content is $n=4$, where $W_{\mathbb{CP}^2}$ lives and attains equality | fine; the block carries no dimension hypothesis and needs none |
| odd $n$ | nothing in the proof sees parity; $S^3\times S^3\times S^3$ at $n=9$ is a critical point on the strict side (§6) | fine, **and this is the one place a defect would have been expected**, since the record's $\theta_0/\Theta_n$ collision is a parity trap. L7 states no constant in $n$, so it cannot inherit it |
| $\ker W\ne0$ | used nowhere in the inequality; changes the *equality clause*'s content (§4.3) | fine for the inequality; the clause needs the $\ker$-aware reading |
| $W_-=0$ | $W\succeq0$ and $\operatorname{tr}W=\tfrac12\operatorname{scal}(W)=0$ force $W=0$; then both sides are $0$ | degenerate, true, and vacuous. The only $W_-=0$ point is excluded by $\lVert W\rVert=1$ if one imposes it, and satisfied trivially if one does not |
| $\theta\le0$ | $\theta$ enters one identity, unsigned | fine; the record's $\theta=0$ and $\theta=-0.088829$ points are covered |
| $\lVert W\rVert\ne1$ | both sides degree $2$ under $W\mapsto tW$, $\theta\mapsto t\theta$ | fine; the block's disclaimer is correct |

---

## 6. One object from each named family, the universal claim, witnessed

**A general two-block sphere-product formula, derived here and used below.** For $S^p\times S^q$, $p+q=n$, Einstein with $\Lambda=(p-1)\kappa_1=(q-1)\kappa_2$: the curvature operator is $\kappa_1\Pi_1+\kappa_2\Pi_2$ on the factor blocks and $0$ on the mixed block, and $W=R-cI$ with $c=\Lambda/(n-1)$ from $\mathrm{Ric}(I)=(n-1)\mathrm{id}$. So $\mathfrak p=\Lambda^2V_1\oplus\Lambda^2V_2=\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ with eigenvalues $\kappa_i-c>0$, $\mathfrak m=V_1\otimes V_2$ with eigenvalue $-c$, and $\ker W=0$. With $\mathrm{Ric}(\varphi\varphi^{\mathsf T})=\Phi\Phi^{\mathsf T}$ and $\Phi\Phi^{\mathsf T}=e_\alpha e_\alpha^{\mathsf T}+f_\beta f_\beta^{\mathsf T}$ for $\varphi=e_\alpha\wedge f_\beta$, $\mathrm{Ric}(W_-)=c(qP_{V_1}+pP_{V_2})$, so $\lVert\mathrm{Ric}(W_-)\rVert^2=c^2pqn$; since $\delta^2=0$, L7 with equality reads $\theta\,pqc+pqc^2=c^2pqn$, i.e. $\boxed{\theta=(n-1)c}$, and normalising $\operatorname{tr}W^2=1$,

$$\theta^2=\frac{(n-1)^2}{pq\left[\dfrac{q}{2(p-1)}+\dfrac{p}{2(q-1)}+1\right]}.$$

At $p=q=3$ this is $25/22.5=10/9=\theta_0(6)^2$; at $(p,q)=(2,4)$ it is $25/(80/3)=15/16$.

| family | witness | what I evaluated | outcome |
|---|---|---|---|
| **sphere products** | $S^3\times S^3$, $n=6$ | $\kappa^2=5/18$, $a=3\kappa/5$, $b=2\kappa/5$, $\theta=\sqrt{10}/3$; LHS $=\theta\cdot9b+9b^2=2+\tfrac25=\tfrac{12}5$; $\mathrm{Ric}(W_-)=3bI_6$, $\lVert\mathrm{Ric}(W_-)\rVert^2=54b^2=\tfrac{12}5$; $\delta^2=0$ | **equality, $\tfrac{12}5=\tfrac{12}5$** |
| **sphere products, low value** | $S^2\times S^4$, $n=6$ | $\theta^2=15/16$ from the box above, so $\theta=\sqrt{15}/4=0.9682458\ldots<1$; $\mathfrak p=\mathfrak{so}(2)\oplus\mathfrak{so}(4)$, $\mathfrak m$ mixed, $\ker=0$, $(\mathfrak{so}(6),\mathfrak{so}(2)\oplus\mathfrak{so}(4))$ symmetric | **equality at $\theta<1$** |
| **$\mathbb{CP}^m$** | $\mathbb{CP}^4$, $n=8$ | [L10](../results.md)'s $\theta^2=(m+1)(2m-1)/(3m(m-1))=35/36$, so $\theta=0.986\ldots<1$; $\mathfrak p=\mathfrak u(4)$ (dim $16$, matching [bounds.md](../findings/bounds.md)'s table), $\ker=0$, $(\mathfrak{so}(8),\mathfrak u(4))$ symmetric | **equality at $\theta<1$** |
| **$\ker W\ne0$** | $W_{\mathbb{CP}^2}$, $n=4$ | §2.3, in full | **equality, $\tfrac43=\tfrac23+\tfrac23$** |
| **padded** | $W_{\mathbb{CP}^2}\oplus0$ at any $n\ge4$ | $\operatorname{tr}W_-$, $\operatorname{tr}W_-^2$ unchanged; $\mathrm{Ric}(W_-)$ gains only zero rows and columns; $\mathrm{Alt}(W_-)$ is supported on $\Lambda^4$ of the original $\mathbb R^4$, so $\delta^2=\tfrac19$ still. Kernel grows to $\binom n2-3$ | **equality, both sides $\tfrac43$, at every $n$** |
| **subalgebra Casimirs** | the [L4](../results.md)/[L23](../findings/ungraded-slack.md) family $W=\alpha\Pi_{\mathfrak h}-\beta\Pi_{\mathfrak h^\perp}$ | $\mathfrak p=\mathfrak h$, $\mathfrak m=\mathfrak h^\perp$, $\ker=0$; the three conditions reduce to $[\mathfrak h^\perp,\mathfrak h^\perp]\subseteq\mathfrak h$ alone, the other two holding because $\mathfrak h$ is a subalgebra and $\mathfrak h^\perp$ is $\mathrm{ad}(\mathfrak h)$-invariant | **equality exactly at the symmetric members** |
|, its equality member | $\mathbb{HP}^2$, $n=8$, $\mathfrak h=\mathfrak{sp}(2)\oplus\mathfrak{sp}(1)$ | $\mathfrak{sp}(2)\oplus\mathfrak{sp}(1)\cong\mathfrak{so}(5)\oplus\mathfrak{so}(3)$, dim $13$, and its irreducible action on $\mathbb R^8$ is the triality image of the reducible $\mathbb R^5\oplus\mathbb R^3$, so it **is** the fixed algebra of an involution of $\mathfrak{so}(8)$. $\theta^2=56/45$ from [graded-half.md](../findings/graded-half.md)'s closed form | **equality, by hand, replacing the record's $1.4\times10^{-15}$ screen** |
|, its strict member | $\mathfrak h=\mathfrak{su}(3)\subseteq\mathfrak{so}(8)$ | $\dim\mathfrak h=8$; the fixed algebras of involutions of $\mathfrak{so}(8)$ have dimensions $21,16,13,13,12$ only, so $\mathfrak{su}(3)$ is not one and $[\mathfrak m,\mathfrak m]\not\subseteq\mathfrak p$ | **strict** |
| **three-block products, odd $n$** | $S^3\times S^3\times S^3$, $n=9$ | Critical by [L4](../results.md): under $SO(3)^3\rtimes S_3$ the invariant operators on $\Lambda^2\mathbb R^9$ are $2$-dimensional and $\mathrm{Ric}(W)=0$ is one condition, so $\dim\mathcal W_9^K=1$. With $u\in V_1$, $v\in V_2$, $w\in V_3$ orthonormal, $[u\wedge v,\,v\wedge w]=u\wedge w\in\mathfrak m$, so $[\mathfrak m,\mathfrak m]\not\perp\mathfrak m$ | **strict**, by the §4.1 characterisation |

**So the universal claim survives every family the record names**, with two families supplying equality points below $\theta=1$ and one supplying strictness at odd $n$. *No object was found on which the inequality fails.*

---

## 7. Comparing the forms on the record

| site | inequality | equality clause | verdict |
|---|---|---|---|
| [bounds.md](../findings/bounds.md):47–59, canonical | as checked, correct | three bracket conditions **plus** the closure clause; and a box refuting the symmetric-pair reading | **correct as a whole**; the heading still reads *"the symmetric-pair equality class"* |
| [results.md](../results.md):326, canonical statement | identical, correct | *"exactly the condition defining a compact symmetric pair with $E_+$ the isotropy algebra"* and *"it fails strictly at the low-value ones"* | **two refuted claims, no correction anywhere on the page** |
| [results.md](../results.md):122, landscape | correct | *"bracket-graded **modulo $\ker W$**, which is wider than the compact symmetric pairs"* | **stale**: the hedge was retired by [L155](../findings/bounds.md); the "wider than" half is right |
| [findings/INDEX-results.md](../findings/INDEX-results.md):22 | correct | *"The bracket-grading conditions hold modulo $\ker W$"* | **stale**, same hedge |
| [findings/LEDGER.md](../findings/LEDGER.md):646 | correct | *"$E_+\oplus E_-$ is $3$-dimensional inside a $6$-dimensional $\mathfrak{so}(4)$, **with no $\mathbb Z_2$-grading**"* | **false**, the overstatement [bounds.md](../findings/bounds.md):59 records as corrected by [r701](../reviews/REVIEW_r701.md)/[r702](../reviews/REVIEW_r702.md), still standing here |
| [findings/INDEX-traps.md](../findings/INDEX-traps.md) trap W4 |, | *"reports $S=0$ while admitting no grading"* | **false as stated**: at a critical point $S=0$ gives a grading of $\mathfrak p\oplus\mathfrak m$ (§4.2). The true content is "no grading **of $\mathfrak{so}(n)$**" |
| [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex):77 | correct | carries *"it fails strictly at the low-value ones"* | **false**, same as [results.md](../results.md):326 |
| [lean/INDEX.md](../lean/INDEX.md):179 | row exists, status **partial** | records **owed**: the inequality itself, and *"the bracket-grading conditions hold **modulo $\ker W$**"* | **stale in the same way**, the row's own neighbour at :187 says L155 retires that hedge, so the L7 row owes something the record no longer claims |

**What the Lean row would have to claim to be current.** Two obligations, not the one it names: (i) the inequality $\theta\operatorname{tr}(W_-)+\operatorname{tr}(W_-^2)\le\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2$ at $Q(W)=\theta W$, which is genuinely owed; (ii) the equality clause in its **unhedged** form, the three bracket conditions, equivalent at a critical point to *$\operatorname{ran}W_+\oplus\operatorname{ran}W_-$ is a $\mathbb Z_2$-graded subalgebra with even part $\operatorname{ran}W_+$*, with the *symmetric pair of $\mathfrak{so}(n)$* reading recorded as holding **iff $\ker W=0$**. The row's remark that *"a scalar statement does not strengthen into an operator one"* is correct in general and does not bear on L7, whose slack **equals** $\tfrac12\operatorname{tr}X_{\mathrm{inv}}$ (§4.2), so L7 is precisely $\operatorname{scal}(X_{\mathrm{inv}})\ge0$ and nothing weaker.

---

## 8. The gap between what is proven and what is used, and what a consumer may cite

**Proven, and citable without qualification:**

> At every $W\in\mathcal W_n$ with $Q(W)=\theta W$, any $n\ge4$, either parity, any sign of $\theta$, any norm, with or without kernel,
> $$\theta\operatorname{tr}(W_-)+\operatorname{tr}(W_-^2)\;\le\;\lVert\mathrm{Ric}(W_-)\rVert^2+6\,\delta^2,$$
> with $W_\pm=\tfrac12(\lvert W\rvert\pm W)$ as operators on all of $\Lambda^2$ and $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$. Equality holds iff $[\mathfrak p,\mathfrak p]\perp\mathfrak m$, $[\mathfrak m,\mathfrak m]\perp\mathfrak m$ and $[\mathfrak p,\mathfrak m]\subseteq\mathfrak m$, equivalently iff $\mathfrak p\oplus\mathfrak m$ is a $\mathbb Z_2$-graded subalgebra of $\mathfrak{so}(n)$ with even part $\mathfrak p$.

**Not citable:**

- *"with equality exactly where the eigenspace ranges form a symmetric pair"* and any wording in which $E_+$ is the isotropy algebra **of $\mathfrak{so}(n)$**. That is true iff $\ker W=0$ and false at $W_{\mathbb{CP}^2}$, one of the block's own equality points.
- *"it fails strictly at the low-value ones."* False at $S^2\times S^4$ ($\theta=\sqrt{15}/4$) and at $\mathbb{CP}^4$ ($\theta=\sqrt{35/36}$), both catalogued, both equality points.
- *"modulo $\ker W$."* Retired; the class closes into the kernel.
- *"A companion closed form pins such a point by its pair's dimensions alone"* ([results.md](../results.md):122): the closed form is [Lemma L23](../findings/ungraded-slack.md)'s $\theta=\tfrac2n\sqrt{rN/(N-r)}$ and belongs to the **subalgebra family**, not to L7's equality class; a graded point outside that family is not pinned by dimensions.

**The one structural gap, restated as the block itself states it:** L7 bounds $\theta\operatorname{tr}(W_-)$ against $\lVert\mathrm{Ric}(W_-)\rVert^2$, which is not controlled by $(\theta,\delta^2)$, so the inequality alone closes nothing. **No finding:** I found no consumer citing more than the inequality plus the dichotomy.

**The equality clause has no argument in the block.** The proof paragraph closes at $\square$ before the clause appears. The support exists elsewhere, [L154](../findings/bounds.md)'s "$\tfrac12\operatorname{tr}X_{\mathrm{inv}}$ is L7's slack", then L154(i) and [L155](../findings/bounds.md), and an on-file Gate 2 report rebuilds the three conditions directly. **This is a presentation debt, not a mathematical one**, and §4.1–4.2 above is the four-line argument the block could carry.

---

## 9. Discrepancies, each with the three-step record

### D1, the displayed rank-one law is off by a factor of two. **REAL.**

**Locate.** [bounds.md](../findings/bounds.md):51: *"**rank-one positivity ($vv^{\mathsf T}\#ww^{\mathsf T}=[v,w][v,w]^{\mathsf T}$, a theorem rather than an assumption**), kills two terms…"*

**Exhibit.** Take $v,w$ over an orthonormal basis $\{b_\alpha\}$ of $\mathfrak{so}(n)\cong\Lambda^2$ and sum: the displayed law gives $\langle(I\#I)\xi,\xi\rangle=\sum_{\alpha\beta}\langle[b_\alpha,b_\beta],\xi\rangle^2=-\operatorname{tr}(\mathrm{ad}\xi)^2=(n-2)\lVert\xi\rVert_F^2=2(n-2)\lVert\xi\rVert^2$, i.e. $I^\#=2(n-2)I$. The record's own [L131](../findings/isotropy-cap.md), at $R=I$ with $\mathrm{Ric}(I)=(n-1)\mathrm{id}$ and $\mathrm{Alt}(I)=0$, gives $I^\#=(n-2)I$. The two disagree by exactly $2$. [ATTEMPTS.md](../ATTEMPTS.md):941, the source this block was transcribed from, writes the same law **with the $\tfrac12$**: $(uu^{\mathsf T})\#(vv^{\mathsf T})=\tfrac12[u,v][u,v]^{\mathsf T}$.

**Argue the opposite.** The most charitable reading is that the block uses a different normalisation of the bracket or of the $\Lambda^2$ identification. It cannot: the block's own proof matches $2\operatorname{tr}(W_+\#W_-)$ against $\operatorname{scal}(W_+\#W_-)$, which fixes $\operatorname{scal}=2\operatorname{tr}$, and that is the same normalisation in which $\operatorname{tr}(W^\#)=-1$ ([conventions.md](../findings/conventions.md):122) and $I^\#=(n-2)I$. One convention, two incompatible constants.

**Impact: none on L7.** Only the *positivity* of the law is used, and a positive constant does not change a PSD conclusion. **Impact on a consumer: total**, the block calls it "a theorem", so it reads as a citable identity, and it is used as one at [REVIEW_r515](../reviews/REVIEW_r515.md) §3 and §7.

### D2, the canonical statement identifies the equality class with the compact symmetric pairs. **REAL.**

**Locate.** [results.md](../results.md):332: *"equality holds precisely when the eigenspace ranges are graded by the Lie bracket, **which is exactly the condition defining a compact symmetric pair with $E_+$ the isotropy algebra**."*

**Exhibit.** $W_{\mathbb{CP}^2}$ at $n=4$. I computed both sides at $\tfrac43$ in §2.3, so equality holds. There $\dim E_+=1$, and the fixed algebras of involutions of $\mathfrak{so}(4)$ have dimensions $2,3,4,6$, so $E_+$ is the isotropy algebra of no compact symmetric pair in $\mathfrak{so}(4)$, and $E_+\oplus E_-=\Lambda^2_+$ is $3$-dimensional inside a $6$-dimensional algebra.

**Argue the opposite.** The charitable reading is that "symmetric pair" means the **abstract** pair $(E_+\oplus E_-,E_+)$ rather than $(\mathfrak{so}(n),E_+)$; under it the sentence is true, and it is what §4.2 proves. But the sentence says *"with $E_+$ the isotropy algebra"*, and an isotropy algebra is isotropy **in** the ambient algebra the statement has been quantifying over. Both readings cannot be carried by one sentence, and the record's own box at [bounds.md](../findings/bounds.md):59 calls the ambient reading false. **Real.**

### D3, *"it fails strictly at the low-value ones."* **REAL.**

**Locate.** [results.md](../results.md):332, repeated verbatim at [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex):77.

**Exhibit.** Two catalogued equality points below $\theta=1$. $S^2\times S^4$ at $n=6$: from the formula derived in §6, $\theta^2=(n-1)^2/\big(pq[\tfrac{q}{2(p-1)}+\tfrac{p}{2(q-1)}+1]\big)=25/(8\cdot\tfrac{10}3)=\tfrac{15}{16}$, so $\theta=\sqrt{15}/4=0.968\ldots$, and $(\mathfrak{so}(6),\mathfrak{so}(2)\oplus\mathfrak{so}(4))$ is a symmetric pair with $\ker W=0$, so equality holds. $\mathbb{CP}^4$ at $n=8$: $\theta^2=35/36$, $\mathfrak p=\mathfrak u(4)$, $\ker W=0$, $(\mathfrak{so}(8),\mathfrak u(4))$ symmetric, so equality holds.

**Argue the opposite.** One could read "the low-value ones" as naming only the specific low-value points that were catalogued when the sentence was written. The sentence is built as a dichotomy over the whole catalogue, *"Every known critical point with value above $1$ satisfies it … and it fails strictly at the low-value ones"*, and both counterexamples were catalogued before it. **Real.**

### D4, the retired *"modulo $\ker W$"* hedge still stands at three sites. **REAL.**

**Locate.** [results.md](../results.md):122, [findings/INDEX-results.md](../findings/INDEX-results.md):22, [lean/INDEX.md](../lean/INDEX.md):179.

**Exhibit.** §4.2 proves the closure by hand: at a critical point, $[\mathfrak p,\mathfrak m]\subseteq\mathfrak m$ forces $P_0CP_0=0$, hence $P_0W_+^\#P_0+P_0W_-^\#P_0=2P_0CP_0=0$, hence $[\mathfrak p,\mathfrak p]\perp\mathfrak k$ and $[\mathfrak m,\mathfrak m]\perp\mathfrak k$, so $\mathfrak p\oplus\mathfrak m$ is closed and nothing is "modulo" anything. [bounds.md](../findings/bounds.md):57 and the [L155](../findings/bounds.md) row at [lean/INDEX.md](../lean/INDEX.md):187 both say the hedge is retired.

**Argue the opposite.** The hedge is *harmless*, it understates rather than overstates, so no consumer is misled into a false claim. That is why this is a staleness finding and not a break. But [lean/INDEX.md](../lean/INDEX.md):179 records it as **owed work**, which directs a formalisation at a statement the record no longer makes. **Real.**

### D5, *"with no $\mathbb Z_2$-grading"* at [LEDGER.md](../findings/LEDGER.md):646, and *"admitting no grading"* at trap W4. **REAL.**

**Locate.** [findings/LEDGER.md](../findings/LEDGER.md):646 and [findings/INDEX-traps.md](../findings/INDEX-traps.md) row W4.

**Exhibit.** At $W_{\mathbb{CP}^2}$, $\mathfrak p\oplus\mathfrak m=\Lambda^2_+\cong\mathfrak{so}(3)$ is graded as $(\mathfrak{so}(3),\mathfrak{so}(2))$ with $E_+$ a line; and $\mathfrak{so}(4)=\mathfrak u(2)\oplus\mathfrak m'$ is itself a $\mathbb Z_2$-grading. So both "no $\mathbb Z_2$-grading" and "admitting no grading" are false; the true statement is "no grading **with $E_+$ as even part of $\mathfrak{so}(n)$**". [bounds.md](../findings/bounds.md):59 records precisely this correction, crediting [r701](../reviews/REVIEW_r701.md)/[r702](../reviews/REVIEW_r702.md); it was applied in one file only.

**Argue the opposite.** Read in context, both sentences are *about* the ambient algebra and the ellipsis is recoverable. But W4 is an index row a reader consults alone, and it also mis-states the mechanism: it says the screen is vacuous because $S$ "traces only over $E_\pm$", whereas §4.2 shows the criticality equation does reach into $\ker W$ and closes it. **Real.**

### D6, *"kills two terms against $\Pi_-\preceq I$."* **REAL but cosmetic.**

**Locate.** [bounds.md](../findings/bounds.md):51.

**Exhibit.** The two terms $-\operatorname{tr}(\Pi_-W_+^\#)$ and $-\operatorname{tr}(\Pi_-W_-^\#)$ are $\le0$ because $\Pi_-\succeq0$ and $W_\pm^\#\succeq0$; $\Pi_-\preceq I$ is used only for $\operatorname{tr}(\Pi_-C)\le\operatorname{tr}(C)$ on the term that survives.

**Argue the opposite.** "Against $0\preceq\Pi_-\preceq I$" would be right, and the sentence may be compressing both halves. It names only one half and attaches it to the wrong step. **Real; no consequence.**

### Withdrawn candidates

- *"The block never defines $\Pi_-$ or $W_-$."* True of the proof line, but the statement paragraph does define $W_\pm$ *"as operators on all of $\Lambda^2$, so that $\mathrm{Ric}(W_-)$ has its usual meaning"*, which is the reading Step 1 needs and the one trap that would have been fatal. **Withdrawn**, the block closes it.
- *"'Twice each' is wrong; it is once each."* The $\lvert W\rvert$-difference route (§3) uses each exactly twice and is the route the surrounding record runs. **Withdrawn.**
- *"The equality clause omits the closure conditions."* It does not need to state them: §4.2 derives them from the three it states. **Withdrawn.**
- *"Unit norm is used implicitly."* Refuted by homogeneity (§3). **Withdrawn.**

---

## 10. What would break it, and what I did to look

**The object that would falsify the inequality:** a $W\in\mathcal W_n$ with $Q(W)=\theta W$ and $\operatorname{tr}(P_-W_+^\#P_-)+\operatorname{tr}(P_-W_-^\#P_-)+2\operatorname{tr}((P_++P_0)C(P_++P_0))<0$. **No such object exists**, because each of the three summands is the compression of a PSD operator, and PSD-ness of $W_+^\#$, $W_-^\#$ and $W_+\#W_-$ follows from the rank-one law and $W_\pm\succeq0$. So the falsifier would have to be a failure of $\#$ to preserve the PSD cone, or of $W_\pm$ to be PSD, the first is a theorem, the second is [conventions.md](../findings/conventions.md):95's definition. **The inequality has no falsifier; it is closed.**

**The object that would falsify the equality clause:** a critical $W$ satisfying the three bracket conditions with $S>0$, or one with $S=0$ violating one of them. Neither can exist for the same reason, the three conditions are read off the vanishing of the three PSD compressions termwise, and a positive-weight sum of squares vanishes iff every term does.

**The object that would falsify the *headings'* reading, and it exists.** A critical $W$ with $\ker W\ne0$ attaining equality. $W_{\mathbb{CP}^2}$ is one, at $n=4$; $W_{\mathbb{CP}^2}\oplus0$ is one at every $n$. **I looked in the other direction too**, a critical $W$ with $\ker W\ne0$ for which $(\mathfrak{so}(n),E_+)$ is a symmetric pair while $[\mathfrak p,\mathfrak m]\not\subseteq\mathfrak m$, which would falsify the converse. I did not find one: it needs $\mathfrak m$ to be a proper, non-$\mathrm{ad}(\mathfrak p)$-invariant subspace of $\mathfrak p^\perp$, and for an *irreducible* symmetric pair $\mathfrak p^\perp$ has no proper invariant subspace at all, so a witness must come from a reducible pair. **I searched the record's named families** (sphere products, $\mathbb{CP}^m$, $\mathbb{HP}^m$, the subalgebra Casimirs, the padded objects) and every one of them has either $\ker W=0$ or $E_+$ not a symmetric isotropy algebra. **Recorded as unexhibited**, not as refuted.

**How I looked.** By hand, at the objects above, and by reading [bounds.md](../findings/bounds.md), [problem.md](../findings/problem.md), [conventions.md](../findings/conventions.md), [isotropy-cap.md](../findings/isotropy-cap.md), [ungraded-slack.md](../findings/ungraded-slack.md), [INDEX-traps.md](../findings/INDEX-traps.md), [LEDGER.md](../findings/LEDGER.md), [INDEX-results.md](../findings/INDEX-results.md), [ATTEMPTS.md](../ATTEMPTS.md), [results.md](../results.md), [lean/INDEX.md](../lean/INDEX.md) and [REVIEW_r515](../reviews/REVIEW_r515.md). **No script was run and no numerical value was taken from the record without re-deriving it**; the two figures I quote from elsewhere and did not re-derive are $\theta(\mathbb{HP}^2)^2=56/45$ (from [graded-half.md](../findings/graded-half.md)'s closed form) and the $\mathfrak{su}(3)$ decomposition $\Lambda^2\mathbf8=\mathbf8\oplus\mathbf{10}\oplus\overline{\mathbf{10}}$ (from [bounds.md](../findings/bounds.md)), the latter is not load-bearing, since the dimension count of $\mathfrak{so}(8)$'s involutions settles the same point.

**Sources.** [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md) is in [references/](../references/) and is where $\#$ and $\mathrm{Weyl}_n$ come from; I used only the record's own restatements of it via [L131](../findings/isotropy-cap.md), which I re-derived. **Jäger's thesis is not in [references/](../references/)**; nothing in this verification rests on it, L7 uses only [L15](../findings/problem.md)'s surviving identity, which I derived from [L131](../findings/isotropy-cap.md) inside the record.

---

## Verdict: **GAP**

**The mathematics is sound and I reproduced all of it by hand.** The identity, the compression, the $6\delta^2$, the sharpness of the $6$, the equality characterisation and its closure into $\ker W$ are each correct, and the inequality has no possible falsifier. The three hypotheses the block names are the three it uses, at the counts it claims.

**The gap is between the proven statement and the citable one.** The canonical form a consumer meets at [results.md](../results.md):326 asserts an equivalence with the compact symmetric pairs that is false at the block's own leading equality point, and a strictness claim that is false at two catalogued points, with the refutation living in a different file, below a different heading. Four further sites carry a retired hedge or a corrected overstatement, and the block's own displayed "theorem" about $\#$ on rank-ones is off by a factor of two.

**What to do, shortest first:** replace $[v,w][v,w]^{\mathsf T}$ by $\tfrac12[v,w][v,w]^{\mathsf T}$; delete the two refuted sentences from [results.md](../results.md):332 and [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex):77 and replace them with the §8 box; drop *"modulo $\ker W$"* at [results.md](../results.md):122, [INDEX-results.md](../findings/INDEX-results.md):22 and [lean/INDEX.md](../lean/INDEX.md):179; qualify *"no $\mathbb Z_2$-grading"* at [LEDGER.md](../findings/LEDGER.md):646 and *"admitting no grading"* at trap W4 to *"of $\mathfrak{so}(n)$"*; and put §4.1's four lines in the block so the equality clause stops being a claim without an argument in its own home.
