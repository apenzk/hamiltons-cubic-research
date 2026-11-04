# Review r428, Lemma L138 and Lemma L139 (adversarial)

*Reviewer r428, 2026-09-03, cold brief. Targets: [Lemma L138](../findings/route-a.md) and [Lemma L139](../findings/route-a.md) in [route-a.md](../findings/route-a.md), read against [Lemma L137](../findings/route-a.md), [Lemma L136](../findings/route-a.md), [Lemma L135](../findings/route-a.md), [Lemma L134](../findings/route-a.md) and [Lemma L17](../findings/route-a.md) (canonical formula at [ATTEMPTS.md line 825](../ATTEMPTS.md)).*

**Standing rule inherited and observed.** This programme is on the analysis-only footing of [analysis-only.md](../.claude/rules/analysis-only.md). Every verdict below rests on a derivation done by hand. Five **screens** were run (seconds of compute at $n=8$ on matrices built for the purpose), to check claims I was about to record. They are reported as screens and are never offered as evidence for a positive claim.

## Verdict table

| Claim | Verdict |
| --- | --- |
| **L138(a)**, Daleckii–Krein multipliers $\{0,\tfrac13,1\}$, structure and dominant-row zeroing | **CONFIRMED in structure, REFUTED in sign.** The multipliers are $0,-\tfrac13,-1$. "$c_1$ contributes nothing to $Z$" is right; the $(K,K)$ block being carried by $D_-$ rather than a multiplier is right |
| **L138(b)**, $\Lambda^4\mathbb R^4$ one-dimensional, $\mathrm{Alt}$ the projection onto $\star$, $\star$ block-diagonal, $E\times A$ dropping out | **CONFIRMED** |
| **L138(b)**, $\langle Z,\star\rangle=(B_{22}+B_{33})-\mathop{\mathrm{tr}}(\Pi_AD_-)$ | **REFUTED in sign.** The true value is $-(B_{22}+B_{33})-\mathop{\mathrm{tr}}(\Pi_AD_-)=-F$ |
| **L138(b)**, $B_{11}=0$, $B_{33}=-B_{22}$ on $\{F=0\}$, hence $\langle Z,\star\rangle=0$ | **CONFIRMED**, and strengthened: $\Pi_AD_-=0$, not merely its trace |
| **L138(b)**, $\lVert g_1\rVert^2\le2(\lVert c_2^{K'}\rVert^2+\lVert c_3^{K'}\rVert^2)+\lVert\mathrm{Alt}(D_-)\rVert^2$ | **REFUTED.** Two incompatible accountings are spliced; the cross term $2\langle\mathrm{Alt}(\hat C),\mathrm{Alt}(D_-)\rangle$ is dropped without justification. Separately the constant $2$ is $3\times$ loose, the sharp one is $\tfrac23$ |
| **L138(c)**, "the $B_{12},B_{13}$ terms cancel exactly" | **REFUTED as a mechanism, and VACUOUS as a statement.** $B_{12}=B_{13}=0$ identically on $T_u\mathcal O^\perp$ |
| **L138(c)**, the displayed $\Delta_2$ bound | **REFUTED**, inheriting [L137](../findings/route-a.md)'s three wrong coefficients. Its internal arithmetic ($2-\tfrac23=\tfrac43$; $\lVert c_1\rVert^2\le\tfrac12$) is correct |
| **L139(a)**, $\mathrm{Alt}(N)$ supported on the distinguished $4$-set alone, hence $\mathrm{Alt}(N)=0$ on $\{F=0\}$ | **REFUTED.** The support claim is false; explicit witness inside $\{F=0\}\cap T_u\mathcal O^\perp$ at $n=8$ with $\lVert\mathrm{Alt}(N)\rVert^2=0.093$. The coefficient $-\tfrac16\mathop{\mathrm{tr}}(B)$ on the distinguished set is **CONFIRMED** |
| **L139(b)** ($\lVert\mathrm{Alt}(N_-)\rVert^2\le\tfrac14\lVert N\rVert^2$ | **CONFIRMED as a conditional**), the record's proof does use Bianchi only through $\mathrm{Alt}(M)=0$, but **INAPPLICABLE**, because (a) does not supply that hypothesis |
| **L139(c)**, the linear-programme arithmetic ($\tfrac23,\tfrac14,\tfrac16$; max $\tfrac23$) | **CONFIRMED** |
| **L139(c)**, the dimension arithmetic ($\lvert\kappa_n\rvert\le1.1022$, $\theta_0\le1.34722$, $n\approx31.75$) | **CONFIRMED**, and the endpoint $n\le31$ is right *for those constants* |
| **L139(c)**, "$\Delta_2\le\tfrac23$, and I3 holds for $12\le n\le31$" | **REFUTED.** Both inputs fail, and the lemma contradicts itself on parity |
| "Conjecture L16 holds in a tube about the competitor's orbit" | **OVERSTATED.** A per-direction second-order coefficient bound gives no radius, and [L134](../findings/route-a.md)'s remainder step is still owed |

**One more thing the record should show and does not.** [plan.md](../plan.md) already records [L136](../findings/route-a.md), [L137](../findings/route-a.md) "and the two lemmas standing on them" as REFUTED by [r425](REVIEW_r425.md) and [r426](REVIEW_r426.md), and the $12\le n\le31$ claim as WITHDRAWN. [route-a.md](../findings/route-a.md) still carries L136–L139 with no withdrawal marker, so a reader who opens the subject file alone will cite a withdrawn result. That is a record defect independent of the mathematics.

---

## 0. The convention, pinned first, because every sign below turns on it

The record's negative part is the **positive semidefinite** one,
$$X_-:=\tfrac12(\lvert X\rvert-X)\succeq0,\qquad f(x)=\max(-x,0),$$
and nothing else is consistent with the rest of the chain. Three independent anchors force it:

- $g_0=\mathrm{Alt}(u_-)=a\star$ with $a=+\tfrac1{3\sqrt6}$ ([L135](../findings/route-a.md), and [r9](REVIEW_r9.md)'s hand derivation $\mathrm{Alt}(\hat\omega_i\hat\omega_i^{\mathsf T})=\tfrac16\star$). Under $x\mapsto\min(x,0)$ one gets $-a\star$.
- [L137](../findings/route-a.md)'s Hansen–Pedersen step needs $f$ **convex** with $f(0)=0$. $\max(-x,0)$ is convex; $\min(x,0)$ is concave.
- [L17](../findings/route-a.md)'s chain $F\ge\tfrac23\mathop{\mathrm{tr}}(B_+)+\tfrac13\mathop{\mathrm{tr}}(B_-)$ closes only with $B_\pm\succeq0$ and $\mathop{\mathrm{tr}}B=\mathop{\mathrm{tr}}B_+-\mathop{\mathrm{tr}}B_-$.

*Screen (reported as a screen).* At $n=8$: $\lVert\star\rVert^2=6$, $\mathrm{Alt}(\hat\omega_1\hat\omega_1^{\mathsf T})$ has norm$^2$ $\tfrac16$, $\mathrm{Alt}(\star)$ has norm$^2$ $6$, and $\langle u_-,\star\rangle/6=0.136083=\tfrac1{3\sqrt6}$, all to $10^{-15}$, under $X_-\succeq0$ and no other.

**A normalisation this review uses throughout.** $\mathrm{Alt}$ is the orthogonal projection of $S^2(\Lambda^2)$ onto its $\Lambda^4$ summand, and that summand is the orthogonal span of the elements $\star_S$, one per $4$-set $S=\{i,j,k,l\}$, with entries $1$ on the three complementary pairings and $\lVert\star_S\rVert^2=6$. Hence
$$\mathrm{Alt}(Z)=\sum_S\frac{\langle Z,\star_S\rangle}{6}\star_S,\qquad \lVert\mathrm{Alt}(Z)\rVert^2=\frac23\sum_S\alpha_S(Z)^2,\quad \alpha_S(Z)=Z_{ij,kl}-Z_{ik,jl}+Z_{il,jk}.$$
Every entry $Z_{P,Q}$ with $P,Q$ **disjoint** planes belongs to exactly one $4$-set; entries with $P\cap Q\ne\emptyset$ reach $\mathrm{Alt}$ not at all. This is the bookkeeping the two lemmas need and never write down.

---

## 1. L138(a), the multipliers are negative

With $f(x)=\max(-x,0)$ and $\mathop{\mathrm{spec}}(u)=\tfrac1{\sqrt6}(2,-1,-1)$ on $E$, $0$ on $K$, the divided differences $f^{[1]}(\lambda,\mu)$ are

| pair | value |
| --- | --- |
| $(\hat\omega_1,\hat\omega_1)$ | $f'(2/\sqrt6)=0$ |
| $(\hat\omega_1,K)$ | $\big(f(2/\sqrt6)-f(0)\big)/(2/\sqrt6)=0$ |
| $(\hat\omega_1,\hat\omega_{2,3})$ | $\big(0-\tfrac1{\sqrt6}\big)\big/\tfrac3{\sqrt6}=\mathbf{-\tfrac13}$ |
| $(\hat\omega_{2,3},\hat\omega_{2,3})$ | $f'(-1/\sqrt6)=\mathbf{-1}$ |
| $(\hat\omega_{2,3},K)$ | $\big(\tfrac1{\sqrt6}-0\big)\big/\big(-\tfrac1{\sqrt6}\big)=\mathbf{-1}$ |

L138(a) states $+\tfrac13$ and $+1$. The record's own [r9](REVIEW_r9.md) already carries "$0$ on $(+,+)$, $-1$ on $(-,-)$ and $(-,0)$, $-\tfrac13$ on $(+,-)$, $0$ on $(+,0)$", so the lemma disagrees with the report it descends from.

**Consistency check that settles it.** $\mathop{\mathrm{tr}}(\Pi_EZ)=0\cdot B_{11}-B_{22}-B_{33}$, so $\langle Z,\star\rangle=-(B_{22}+B_{33})-\mathop{\mathrm{tr}}(\Pi_AD_-)=-F$, and $d^+\delta^2=2a\langle\star,Z\rangle=-2aF$, **exactly [ATTEMPTS.md line 825](../ATTEMPTS.md)**. With L138(a)'s signs one gets $+2aF$, contradicting the record's first-order lemma. The negative signs are forced.

**What survives.** The *structure* is right, and it is the part L138 uses: the $(\hat\omega_1,K)$ multiplier is genuinely $0$, so $c_1$ contributes nothing to $Z$; and the $(K,K)$ block is genuinely carried by $D_-$ rather than by a multiplier, because $f$ has no derivative at $0$. Magnitudes $\tfrac13$ and $1$ are right, so the squares that enter $\lVert Z\rVert^2$ are unaffected.

**A citation correction.** The Daleckii–Krein theorem needs $f\in C^1$ on a neighbourhood of the spectrum, which fails at $0$. What is actually legitimate here is the Schur-complement-plus-positive-homogeneity route of [L136](../findings/route-a.md)'s proof; L138(a) should cite that, not DK.

*Screen.* Fitting $(u+tH)_-$ in $t$ at $n=8$ for random symmetric $H\perp u$: $Z$'s $E$-diagonal reproduces $(0,-B_{22},-B_{33})$, $Z_{12}=-B_{12}/3$, $Z_{\hat\omega_1,K}=0$ to $8\times10^{-8}$, $Z_{KK}=D_-$ to $10^{-6}$, and $\langle Z,\star\rangle=-0.187745$ against $-F=-0.187744$.

---

## 2. L138(b), the geometry is right, the inequality is not

### 2.1 What is confirmed

$\Lambda^2\mathbb R^4=E\oplus A$ and $\Lambda^4\mathbb R^4$ is one-dimensional, spanned by $\star$; $\mathrm{Alt}$ restricted to $S^2(\Lambda^2\mathbb R^4)$ is the orthogonal projection onto $\star$; and $\star=\Pi_E-\Pi_A$ is block-diagonal across $E\oplus A$, so the $E\times A$ entries of $Z$ pair to zero against it. Every entry of $Z$'s $(\Lambda^2\mathbb R^4)\times(\Lambda^2\mathbb R^4)$ block therefore reaches $\mathrm{Alt}$ only through the single number $\langle Z,\star\rangle$, the lemma's stated mechanism, and it is correct.

$B_{11}=0$ and $B_{33}=-B_{22}$ on the cone also hold, and the derivation is worth writing out because L138 compresses it. [L17](../findings/route-a.md)'s ingredient (d) is $\langle H,\star\rangle=0$, i.e. $H_{11}+H_{22}+H_{33}=\mathop{\mathrm{tr}}(B_{\mathrm{ASD}})$ with $B_{\mathrm{ASD}}=\Pi_AH\Pi_A$, together with tangency $2H_{11}=H_{22}+H_{33}$. **On $\{F=0\}$ the equality case forces $B_{\mathrm{ASD}}=0$** (both $\mathop{\mathrm{tr}}B_+$ and $\mathop{\mathrm{tr}}B_-$ vanish and both parts are PSD), hence $\mathop{\mathrm{tr}}(B)=H_{11}+H_{22}+H_{33}=0$; with tangency, $3H_{11}=0$ and $H_{22}+H_{33}=0$. So the indices do mean what L138 assumes, L17's $B$ is the ASD block, L138's $B$ is $H_{EE}$, and the two are correctly bridged.

**A strengthening the lemma leaves on the table.** L17's equality also gives $\mathop{\mathrm{tr}}(\Pi_AD_-)=0$ with $D_-\succeq0$ and $\Pi_A\succeq0$, which forces $\Pi_AD_-=0$ outright, not merely its trace. So on the cone $D_-$ has no $A$-content at all: its $A\times A$ and $A\times K'$ blocks vanish. That is exactly what makes the block split below clean.

### 2.2 The displayed inequality is refuted

$$\lVert g_1\rVert^2\;\le\;2\big(\lVert c_2^{K'}\rVert^2+\lVert c_3^{K'}\rVert^2\big)+\lVert\mathrm{Alt}(D_-)\rVert^2 .$$

Write $\hat C$ for $Z$'s $E\times K'$ block (rows $0,-c_2^{K'},-c_3^{K'}$) and $\gamma^2=\lVert c_2^{K'}\rVert^2+\lVert c_3^{K'}\rVert^2$. On the cone $\mathrm{Alt}(Z)=\mathrm{Alt}(\hat C)+\mathrm{Alt}(D_-)$, the $R^4$-block having been killed. **Two accountings are available and the lemma uses one for each summand:**

- $\mathrm{Alt}$ is a projection, so $\lVert\mathrm{Alt}(Z)\rVert^2\le\lVert Z\rVert^2$, and the blocks are Frobenius-orthogonal: $\lVert\mathrm{Alt}(Z)\rVert^2\le\lVert\hat C\rVert^2+\lVert D_-\rVert^2=2\gamma^2+\lVert D_-\rVert^2$. **This is where the constant $2$ comes from**, a cross block counted twice in the Frobenius norm. It is valid, and it delivers $\lVert D_-\rVert^2$, **not** $\lVert\mathrm{Alt}(D_-)\rVert^2$.
- Or apply $\mathrm{Alt}$ blockwise. Then $\lVert g_1\rVert^2=\lVert\mathrm{Alt}(\hat C)\rVert^2+2\langle\mathrm{Alt}(\hat C),\mathrm{Alt}(D_-)\rangle+\lVert\mathrm{Alt}(D_-)\rVert^2$, and **the cross term does not vanish**: both images live on the same $4$-sets. For $S=\{i,j,a,b\}$ with $i,j\le4<a,b$ the three pairings are $(ij\vert ab)$, which is an $E\times K'$ entry, and $(ia\vert jb),(ib\vert ja)$, which are $K'\times K'$ entries of $D_-$, one and the same $\star_S$ line.

The lemma takes the first constant and the second term. That splice is not an inequality. Quantitatively, with $Y=\lVert\mathrm{Alt}(D_-)\rVert$ and $\mathrm{Alt}(\hat C)$ aligned with $\mathrm{Alt}(D_-)$, the claim requires $\lVert\mathrm{Alt}(\hat C)\rVert^2+2\lVert\mathrm{Alt}(\hat C)\rVert Y\le2\gamma^2$, which fails as soon as $Y\gtrsim0.82\,\gamma$, a regime the budget reaches easily, since $\lVert D\rVert$ may carry almost the whole of $\lVert H\rVert=1$.

### 2.3 The constant, computed

The bound the lemma wanted is available and is three times better. From the $4$-set formula, with $\hat C$'s rows against $\hat\omega_2,\hat\omega_3$ and each coordinate plane of $\mathbb R^4$ contributing its $\hat\omega$-component $\pm\tfrac1{\sqrt2}$:

- a $K'$ entry of type $e_{ab}$ ($a,b>4$) reaches exactly two $4$-sets and contributes $\tfrac13c^2$ to each;
- a $K'$ entry of type $e_{xa}$ ($x\le4<a$) reaches exactly one $4$-set, paired there with one other mixed entry, contributing $\tfrac13(c\pm c')^2$.

Summing, $\boxed{\lVert\mathrm{Alt}(\hat C)\rVert^2\le\tfrac23\gamma^2}$, **sharp**, attained by a single $e_{ab}$ entry and by an aligned mixed pair. So the honest form of (b) is
$$\lVert g_1\rVert\;\le\;\sqrt{\tfrac23}\,\gamma+\lVert\mathrm{Alt}(D_-)\rVert .$$

*Screen.* At $n=8$, $\lVert\mathrm{Alt}(\hat C)\rVert^2/\gamma^2$ over 4000 random $(c_2^{K'},c_3^{K'})$ tops out at $0.5998$; the single-$e_{45}$ entry and the aligned mixed pair both give $0.666667$.

**Note on the brief's hint.** The $4$-sets to consider are *not* only those with two indices inside $\mathbb R^4$ and two outside. Sets with **three** indices inside also receive $E\times K'$ entries, the plane $\{i,j\}\subset\mathbb R^4$ pairs with $\{k,a\}$, $k\le4<a$. Both families must be counted, and both are counted above.

---

## 3. L138(c), the cancellation is vacuous, and the assembly inherits L137

**The mechanism as stated is wrong.** "The multiplier $\tfrac13$ squares to $\tfrac19$ and enters $\lVert Z\rVert^2$ twice, against L137's $-\tfrac29$" describes the route $\lVert g_1\rVert^2\le\lVert Z\rVert^2$; the factor-of-two bookkeeping is correct for that route ($Z_{12}$ and $Z_{21}$ each contribute $B_{12}^2/9$). But (b) takes the *other* route, on which the whole $(E\oplus A)$-block contributes nothing, so $B_{12},B_{13}$ appear in $\lVert g_1\rVert^2$ with coefficient $0$ and L137's $-\tfrac29$ is simply a negative term being discarded. Nothing cancels; a bonus is thrown away.

**And the statement is vacuous on its own domain.** For $X\in\mathfrak{so}(4)$ the orbit tangent $[\rho(X),u]$ is supported on $E$ alone (because $\mathfrak{so}(4)$ preserves $\Lambda^2_\pm$), with entries $(\lambda_i-\lambda_j)x_{ij}$: the $(1,2)$ and $(1,3)$ entries are $\tfrac3{\sqrt6}x_{1j}\ne0$ and the $(2,3)$ entry is $0$. Orthogonality to those two directions gives
$$B_{12}=B_{13}=0\quad\text{identically on }T_u\mathcal O^\perp .$$
So the $B_{12},B_{13}$ terms on **both** sides of the claimed cancellation are zero throughout the lemma's own domain. *Screen: the $\mathfrak{so}(4)$ generator $X_{02}$ gives an orbit tangent with $B_{13}=1.224745=\tfrac3{\sqrt6}$ and every other $E$-entry and the whole $E\times K$ block equal to $0$.*

**The arithmetic that is right.** $2-\tfrac23=\tfrac43$ is the correct assembly of (b)'s constant with L137's $-\tfrac23$, and $\lVert c_1\rVert^2\le\tfrac12$, $\lVert c_2\rVert^2+\lVert c_3\rVert^2\le\tfrac12$ do follow from $\lVert H\rVert^2=\lVert B\rVert^2+2\sum\lVert c_i\rVert^2+\lVert D\rVert^2=1$.

**The inputs that are not.** I re-derived [L136(a)](../findings/route-a.md) from scratch and it is wrong in three separate ways, agreeing with [r425](REVIEW_r425.md) and [r426](REVIEW_r426.md), which I read only after finishing. The root cause is that $\mathop{\mathrm{tr}}(\Pi_EX_2)$ uses the **fixed** projector $\Pi_E$, while L136's proof evaluates the trace over the **moving** invariant subspace $E(t)$; the two differ at exactly order $t^2$, by the eigenvector tilt.

*Screen, isolated unit directions at $n=8$, $t^2$-coefficients:*

| $H$ | $\mathop{\mathrm{tr}}(\Pi_EX_2)$ | $\langle\star,X_2\rangle$ | L136(a) predicts |
| --- | --- | --- | --- |
| $\hat\omega_2\odot e_{45}$ (i.e. $c_2$ into $K'$) | $+0.00009$ | $+0.00009$ | $-1.224745$ |
| $\hat\omega_2\odot\hat\eta_1$ (i.e. $c_2$ into $A$) | $+0.00009$ | $-1.224469$ | $-1.224745$ |
| $\hat\omega_1\odot\hat\omega_2$ (i.e. $B_{12}$) | $+0.408245$ | $+0.408245$ | $-0.408248$ |
| $\hat\omega_1\odot e_{45}$ ($c_1$ into $K'$) | $+0.000011$ | $+0.000011$ | $0$ |
| $\hat\omega_1\odot\hat\eta_1$ ($c_1$ into $A$) | $+0.000011$ | $-0.612338$ | $0$ |

Read off: the $CC^\top$ term **does not exist** for the $K'$ part of $c_2,c_3$, the eigenvalue deepening $+\sqrt6t^2\lVert c\rVert^2$ is cancelled exactly by the eigenvector tilt $-6t^2\lVert c\rVert^2\cdot\tfrac1{\sqrt6}$, and survives only for the $A$ part, where it arrives through $-\mathop{\mathrm{tr}}(\Pi_AX_2)$. The $B_{12}$ term has the **opposite sign** ($+\tfrac{\sqrt6}3$, and the $2a$ conversion makes it $+\tfrac29$: deepening a negative eigenvalue *increases* the defect). And $\rho$ enters with a minus sign, so L137's $+\tfrac13\lVert c_1\rVert^2$ (its only positive term, the one the whole chain was built to fight), is spurious.

Consequence for L138(c): the $-\tfrac23(\lVert c_2\rVert^2+\lVert c_3\rVert^2)$ that produces the $\tfrac43$ does not exist off the $A$-component, and the $K'$-component is precisely what (b)'s term is made of. **The displayed bound is refuted.**

---

## 4. L139(a), refuted, with a witness

**The proof step is false.** "A pairing involving $E$ needs its partner inside $\mathbb R^4$ too: the only $4$-set reached is $\{1,2,3,4\}$." A $\Lambda^4$ component pairs a plane with its **complement in the $4$-set**, and the $4$-set need not lie in $\mathbb R^4$. The plane $\{1,2\}\subset\mathbb R^4$ pairs with $\{3,5\}$ on the $4$-set $\{1,2,3,5\}$ and with $\{5,6\}$ on $\{1,2,5,6\}$. Since $e_{12}=\tfrac1{\sqrt2}(\hat\omega_1+\hat\eta_1)$ has a nonzero $E$-component, the block $\Pi_EH\Pi_{K'}$ reaches $\mathrm{Alt}$ on **every** $4$-set with three or two indices in $\mathbb R^4$.

**The exact identity.** With $\mathrm{Alt}(H)=0$ and $\mathop{\mathrm{tr}}(B)=0$ on the cone,
$$\mathrm{Alt}(N)=-\mathrm{Alt}\big(\Pi_EH\Pi_{K'}+\Pi_{K'}H\Pi_E\big),$$
and on a $4$-set $S=\{i,j,a,b\}$ with $i,j\le4<a,b$ this reads $\alpha_S(N)=-s_{ij}\,c_{p(ij)}^{ab}$ with $s_{ij}=\pm\tfrac1{\sqrt2}$. Concretely $\alpha_{\{1,2,5,6\}}(N)=-\tfrac1{\sqrt2}c_1^{56}$. So $\mathrm{Alt}(N)=0$ would require the whole $E\times K'$ block of $H$ to have vanishing $\mathrm{Alt}$, a condition on $C$, about which $\{F=0\}$ says nothing.

*Screen 1.* Random Bianchi $H$ at $n=8$ ($\max_S\lvert\alpha_S(H)\rvert=6\times10^{-16}$): $\alpha_S(N)$ matches the identity above to $10^{-15}$ on the $(2,2)$-sets $\{0,1,4,5\},\{0,2,4,5\},\{0,3,4,5\}$ and the $(3,1)$-sets $\{0,1,2,4\},\{0,1,3,4\}$, is $0$ on $\{4,5,6,7\}$, and equals $-\tfrac{\mathop{\mathrm{tr}}B}{6}\alpha(\star)$ on $\{0,1,2,3\}$.

*Screen 2, the witness.* Solving, inside $S^2(\Lambda^2\mathbb R^8)$, the linear system {first Bianchi} $\cap$ {Ricci-flat} $\cap$ $\{\Pi_AH\Pi_A=0\}$ $\cap$ $\{\Pi_AH\Pi_K=0\}$ $\cap$ $\{B_{22}+B_{33}=0\}$ $\cap$ $\{H\perp u\}$ $\cap$ $\{H\perp T_u\mathcal O\}$ gives a **209-dimensional** space of genuine Weyl tensors on the equality cone (verified: $F=7\times10^{-17}$, $\mathop{\mathrm{tr}}B=4\times10^{-17}$; note $\Pi_AH\Pi_K=0$ forces $\Pi_AD_-=0$, so this is a subset of $\{F=0\}$, which is all that is needed). On it, $\max_{S\ne\{1,2,3,4\}}\lvert\alpha_S(N)\rvert=0.238$, and the extremal unit member has $\lVert\mathrm{Alt}(N)\rVert^2=0.0925$ with $\lVert N\rVert^2=0.609$.

**What is right in (a).** The distinguished-$4$-set coefficient. $\langle\Pi_EH\Pi_E,\star\rangle=\mathop{\mathrm{tr}}(\Pi_EH\Pi_E)=\mathop{\mathrm{tr}}(B)$ using $\star\vert_E=+1$, and $\lVert\star\rVert^2=6$ gives $\mathrm{Alt}(\Pi_EH\Pi_E)=\tfrac{\mathop{\mathrm{tr}}B}6\star$, so $\mathrm{Alt}(N)\vert_{\{1,2,3,4\}}=-\tfrac{\mathop{\mathrm{tr}}B}6\star$, and it does vanish on the cone. The $E\times A$ terms are indeed killed there by $\star$'s block-diagonality. All of that is correct, it just does not exhaust $\mathrm{Alt}(N)$.

**Vacuity check.** The refutation is not vacuous in either direction: the cone is $209$-dimensional at $n=8$, and $\mathrm{Alt}(N)$ is nonzero on an open subset of it. Conversely the *claim* is not vacuously true, it holds on the padded flat (where $C=0$), which is exactly the family the lemma's sanity checks are run on, and fails off it.

---

## 5. L139(b), correct as a conditional, unusable as applied

Reconstructing the record's proof ([ATTEMPTS.md line 831](../ATTEMPTS.md)): for symmetric $M$ with $\mathrm{Alt}(M)=0$, $\mathrm{Alt}(M_+)=\mathrm{Alt}(M_-)$, so $\mathrm{Alt}(\lvert M\rvert)=2\mathrm{Alt}(M_-)$ and
$$\lVert\mathrm{Alt}(M_-)\rVert^2=\tfrac12\langle\mathrm{Alt}(M_-),\mathrm{Alt}(\lvert M\rvert)\rangle=\tfrac12\langle\mathrm{Alt}(M_-),\lvert M\rvert\rangle\le\tfrac12\lVert\mathrm{Alt}(M_-)\rVert\,\lVert M\rVert .$$
The ingredients are: $\mathrm{Alt}$ an orthogonal projection (used twice, to move $\mathrm{Alt}$ across the pairing and for Cauchy–Schwarz), $\lVert\,\lvert M\rvert\,\rVert=\lVert M\rVert$, and $\mathrm{Alt}(M)=0$. It uses **no** Ricci-flatness, **no** unit norm (both sides are $2$-homogeneous, so the scaled form is free), and **no** pair symmetry beyond $M=M^{\mathsf T}$. So L139(b)'s reading of the record's proof is **CONFIRMED**, and it is the one part of the chain I found nothing wrong with.

It is nonetheless unusable here, because (a) does not supply $\mathrm{Alt}(N)=0$. The degraded version is
$$\lVert\mathrm{Alt}(N_-)\rVert\le\tfrac12\big(\lVert N\rVert+\lVert\mathrm{Alt}(N)\rVert\big),$$
obtained by carrying $\mu=\mathrm{Alt}(N)$ through the same three lines, and $\lVert\mathrm{Alt}(N)\rVert$ is controlled only by the $E\times K'$ block of $H$, i.e. by the very $c_i$ the budget is fighting over. **The obligation L138 named (a $\tfrac14$ ceiling for a compression that need not be Bianchi), is still open.**

---

## 6. L139(c), the arithmetic is right and the inputs are not

**The linear programme.** Against $\lVert B\rVert^2+2\sum_i\lVert c_i\rVert^2+\lVert D\rVert^2=1$, the three families in $\tfrac43(\lVert c_2\rVert^2+\lVert c_3\rVert^2)+\tfrac14\lVert D\rVert^2+\tfrac13\lVert c_1\rVert^2$ pay $\tfrac{4/3}2=\tfrac23$, $\tfrac14$ and $\tfrac{1/3}2=\tfrac16$ per unit; the objective is linear in the squared-norm variables, so the maximum is the largest ratio, $\tfrac23$, at $c_2,c_3$ and $B$ contributing nothing. **CONFIRMED.**

**The dimension arithmetic.** $\tfrac23\le\tfrac19+\tfrac{\theta^*}{2\lvert\kappa_n\rvert}\iff\lvert\kappa_n\rvert\le\tfrac{9\theta^*}{10}=1.102270\iff\theta_0(n)\le\theta^*+\tfrac{\theta^*}{10}=1.347219$, using $\kappa_n=9(\theta^*-\theta_0)$. With $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ ([conventions.md](../findings/conventions.md)), $\theta_0(n)^2=1.815$ gives $0.185n^2-6n+4=0$, $n=(6+\sqrt{33.04})/0.37=31.7515$. Check: $\theta_0(31)=\sqrt{1740}/31=1.345591\le1.347219$ and $\theta_0(32)=\sqrt{1860}/32=1.347741>1.347219$. **CONFIRMED**, endpoint included.

**Parity, and an internal contradiction.** Statement (c) reads "for every **even** $n$ with $12\le n\le31$"; the lemma's own heading and its closing paragraph read "$12\le n\le31$", and so does [ATTEMPTS.md line 4038](../ATTEMPTS.md). These are different claims. [conventions.md](../findings/conventions.md) records that the diagonal maximum equals $\theta_0(n)$ **at even $n$** and $2(n-1)(n-3)/((n+1)(n-2))$ at odd $n$, so the parity qualifier is not decorative. If it stands, the range is $n\in\{12,14,\dots,30\}$ and the endpoint $31$ is vacuous, the headline names a dimension the result excludes. The record must pick one reading; as written it asserts both.

**The verdict.** $\Delta_2\le\tfrac23$ rests on L138(c), which rests on [L137](../findings/route-a.md)'s refuted coefficients and on (b)'s unproven inequality, and on L139(b), whose hypothesis L139(a) fails to supply. **REFUTED.**

**How far the chain misses, if one repairs only what is repairable.** Grant the cross term's sign repair (on $T_u\mathcal O^\perp$ the self-dual branch is identically zero, since $B_{12}=B_{13}=0$) and use the sharp constant of §2.3. Then $\Delta_2\le\big(\sqrt{\tfrac23}\gamma+Y\big)^2$ with $Y=\lVert\mathrm{Alt}(D_-)\rVert$.

- *With* the $\tfrac14$ ceiling ($Y\le\tfrac12\lVert D\rVert$): maximising $\sqrt{\tfrac{d(1-d)}3}+\tfrac d4$ over the budget gives $\Delta_2\le0.4396$ at $\lVert D\rVert^2=0.6987$, **below** the binding $0.4702$, i.e. I3 at every $n\ge12$ rather than a range. That is the prize, and it is exactly what L139(a) was needed for.
- *Without* it, using only $Y\le\lVert D_-\rVert\le\lVert D\rVert$: the same maximisation gives $\Delta_2\le\tfrac43$, three times the binding threshold.

So the whole result turns on the compression ceiling, there is no fallback bound in reserve, and the honest current state is that the $\lVert\mathrm{Alt}(N_-)\rVert^2\le\tfrac14\lVert N\rVert^2$ question is open for non-Bianchi compressions. *(This paragraph is a repair sketch offered for the next cycle, not a verified result; it inherits [L136](../findings/route-a.md)/[L137](../findings/route-a.md)'s repair, which is itself owed.)*

---

## 7. What the conclusion says versus what it can say

Even granting everything, "**Conjecture L16 holds in a tube about the competitor's orbit** for $12\le n\le31$" is more than the chain delivers, for two reasons the record half-acknowledges:

1. **The remainder step.** [L134](../findings/route-a.md) itself says the $O(t^3)$ on the defect side comes from a Rellich branch whose radius depends on $H$, that $\delta^2$ has no third derivative at $u$, and that *both* of its reviewers flagged this as a second gap. A bound on a per-direction second-order coefficient gives a punctured statement along each ray, not a radius; "tube" asserts a uniform neighbourhood. L139's parenthetical "granting the remainder step L134 still owes" concedes this, but the heading, the statement (c), and the [ATTEMPTS.md](../ATTEMPTS.md) entry do not.
2. **The quantifier.** $\{F=0\}\cap T_u\mathcal O^\perp$ is where the second order decides; off the cone $d^+\Phi<0$ and the first order decides, which is fine, but the conjunction is a statement about $\Phi$ along rays from $u$, and turning it into a neighbourhood statement needs the uniformity of item 1.

The safe formulation is: *on $\{F=0\}\cap T_u\mathcal O^\perp$, $c_2(H)\le\ldots$ per direction*, which is what I3 was defined to be in [plan.md](../plan.md), with the tube claim deferred to the remainder step.

---

## 8. Summary of corrections, in the order they should be applied

1. **L138(a).** Multipliers are $0,-\tfrac13,-1$. Cite the Schur-complement/homogeneity route rather than Daleckii–Krein, which does not apply at a kernel.
2. **L138(b).** $\langle Z,\star\rangle=-(B_{22}+B_{33})-\mathop{\mathrm{tr}}(\Pi_AD_-)=-F$; note the identity, it is cleaner than the two-terms-separately reading. Record $\Pi_AD_-=0$ on the cone, not just its trace. Replace the displayed inequality by $\lVert g_1\rVert\le\sqrt{\tfrac23}\gamma+\lVert\mathrm{Alt}(D_-)\rVert$ with $\gamma^2=\lVert c_2^{K'}\rVert^2+\lVert c_3^{K'}\rVert^2$, and say that the $4$-sets involved carry three or two indices in $\mathbb R^4$.
3. **L138(c).** Strike the cancellation claim. Record instead that $B_{12}=B_{13}=0$ on $T_u\mathcal O^\perp$, which makes both the L136 term and the $\lVert Z\rVert^2$ term identically zero there, a fact worth having, because it removes the $B$ block from the budget entirely.
4. **L139(a).** Withdraw. Replace by $\mathrm{Alt}(N)=-\mathrm{Alt}(\Pi_EH\Pi_{K'}+\Pi_{K'}H\Pi_E)$ on the cone, with the $(2,2)$-set coefficient $-s_{ij}c_{p(ij)}^{ab}$.
5. **L139(b).** Keep as a conditional, restate with the hypothesis explicit and with the degraded form $\lVert\mathrm{Alt}(N_-)\rVert\le\tfrac12(\lVert N\rVert+\lVert\mathrm{Alt}(N)\rVert)$ beside it.
6. **L139(c).** Withdraw the range. Keep the linear programme and the $n\approx31.75$ computation, which are correct and will be reusable once the inputs are; resolve the parity contradiction.
7. **[route-a.md](../findings/route-a.md).** Mark L136–L139 withdrawn, as [plan.md](../plan.md) already does.
