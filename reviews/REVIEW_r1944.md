# Review r1944: I124 batch 10, the superposition bound and the reduction of P to (★)

Log: [agent_logs/r1944-i124-superpos.log](../agent_logs/r1944-i124-superpos.log). Section under review: batch 10 of [2026-09-28q-I124-ascent.md](2026-09-28q-I124-ascent.md). Footing: analysis only, with two seconds-scale screens on tensors constructed for the purpose, reported as screens.

**Verdict.** The identity, the superposition bound $P(W)\le\Theta_n+P(N)$ at $n\ge12$ and the balanced-product remark are correct. The reduction to (★) is correct but is a reformulation: (★) at a global maximiser is equivalent to P itself, and any averaging proof of (★) must be exact at the balanced product, where every frame has $P(N_F)\ge0$ and Haar frames give $P(N_F)\approx P(B)$. Two scope repairs are owed in the "What it gives" bullet.

| # | claim | verdict |
|---|---|---|
| 1 | three vanishings and the expansion | CONFIRMED |
| 2 | the identity, weights, unit tensors | CONFIRMED, one degenerate-case remark (O1) |
| 3 | pair-character cap from L224 | CONFIRMED |
| 4 | four-set cap, and no other character type | CONFIRMED |
| 5 | reduction to (★), balanced-product remark | CONFIRMED as stated, the reduction being a restatement at the maximiser (O2) |
| 6 | critical-point reading and cap | CONFIRMED, with a scope repair (O3) and the record link (section 9) |
| 7 | hunt on (★) | no counterexample in the bounded screen, and (★) at a maximiser is equivalent to P (O2, O4) |
| 8 | Lean and the screen | CONFIRMED (Lean line below) |
| 9 | record search | NEW as a bound. Its critical-point reading is L214's first relation rewritten, and its cap strictly sharpens R51's diagonal-locus cap (section 9) |

## 1. The three vanishings

Characters of the frame's sign group $\Gamma$ on $e_{ij}\odot e_{kl}$ are $\chi_{\{i,j\}\triangle\{k,l\}}$, and character spaces are mutually orthogonal ($\Gamma$ acts orthogonally). $T(\hat A,\hat A,N)=\langle\hat A\circ\hat A,N\rangle$ with $\hat A\circ\hat A\in D$ and $N\perp D$. $\hat A\circ N_\chi$ carries $1\cdot\chi=\chi$, so it is orthogonal to $N_\psi$ for $\psi\ne\chi$. $\hat N_\chi\circ\hat N_\chi$ carries $\chi^2=1$, so it lies in $D\perp\hat N_\chi$. The expansion $P(aA+N)=a^3p+3a^2T(\hat A,\hat A,N)+3aT(\hat A,N,N)+P(N)$ then gives $3a\sum_\chi\lVert N_\chi\rVert^2T(\hat A,\hat N_\chi,\hat N_\chi)$ for the middle term, with $P(N)$ left whole (it keeps its triple-character cross terms $\chi\psi\rho=1$, correctly). **CONFIRMED.**

## 2. The identity

$aA$ and $bN_\chi$ are orthogonal, so $\lVert a\hat A+b\hat N_\chi\rVert^2=a^2+b^2=\lVert W\rVert^2=1$. Its cubic is $a^3p+3ab^2T_\chi$ by the same three vanishings, and $w_\chi^2b^2=\lVert N_\chi\rVert^2$, $\sum w_\chi^2=1$ over the characters present, so the weighted sum reproduces the middle term exactly. **CONFIRMED.**

- **O1 (degenerate cases, wording).** At $b=0$ the weights are undefined, and then $W=\hat A$ and $P(W)\le\Theta_n$ by L57 directly. At $a=0$, $\hat A$ is undefined, and any unit $\hat A\in D$ works, every term carrying $a$ vanishing and $P(\hat N_\chi)=0$. One clause would cover both.

## 3. The pair cap

The Weyl part of the $\varepsilon_j\varepsilon_k$ character space is spanned by $e_{ja}\odot e_{ka}$, $a\notin\{j,k\}$, with Ricci condition $R_{jk}=\sum_ax_a=0$ and Bianchi vacuous: this is L224's $V_{jk}$ exactly. So $a\hat A+b\hat N_\chi$ is a unit element of $\mathcal S_{jk}=\mathcal D_n\oplus V_{jk}$, and L224 (every $n\ge4$, no criticality) gives $P\le\Theta_n$. **CONFIRMED.**

## 4. The four-set cap and the character list

- A symmetric difference of two 2-sets has size 0, 2 or 4, so the nontrivial characters are exactly pairs and four-sets. Size 0 is $\{i,j\}=\{k,l\}$, the diagonal. No other type.
- $\mathcal S_Q$ is the fixed space of $\ker\chi_Q$ (L220 step 1), hence closed under $\circ$. The gradient $3Q(W)$ at $W\in\mathcal S_Q$ lies in $\mathcal S_Q$, so the maximum on its unit sphere is critical on $\mathcal W_n$ with $\theta=P(W)$.
- L220's hypotheses at the maximiser: $n\ge12\ge5$. $\theta>0$ because the maximum is at least $\Theta_n>0$, attained in $\mathcal D_n\subset\mathcal S_Q$. If $\nu\ne0$ then $\theta\le\sqrt{3/2}<\Theta_n$, a contradiction, so $\nu=0$ and L57 gives $\Theta_n$. L220's own statement already carries this conclusion ("at $n\ge12$, $\sup P=\Theta_n$ on the unit sphere of $\mathcal S_Q$"), which the batch could cite directly.
- $\sqrt{3/2}=1.22474$ against $\Theta_{11}=1.21716$, $\Theta_{12}=1.23603$, $\Theta_{13}=1.24838$ (odd formula), and both parity formulas increase in $n$. So $\sqrt{3/2}<\Theta_n$ exactly at $n\ge12$.

**CONFIRMED.** The threshold is load-bearing: at $n\le11$ padded $W_{\mathbb{CP}^2}$ lies in one $\mathcal S_Q$ with $P(N)=0$ in its frame and $P=\sqrt{3/2}>\Theta_n$, so the superposition bound itself fails below 12.

## 5. The reduction and the balanced product

If (★) holds at every unit $W$ then $P(W)\le\Theta_n$ everywhere, which is P at even $n\ge12$. At the balanced product $B$, $\Theta_n=P(B)\le\Theta_n+P(N_F)$ in every frame, so $P(N_F)\ge0$, and adapted frames give $N=0$. **CONFIRMED.**

- **O2 (what the reduction is).** (★) at a global maximiser is equivalent to P. If P fails, a maximiser has $P>\Theta_n$ and every frame gives $P(N_F)\ge P(W)-\Theta_n>0$. If P holds, the balanced product is a maximiser and its adapted frame gives $N=0$. So the reduction exchanges P for the same statement read one frame at a time: it names a frame-local target, and the difficulty stays whole. The record should say so beside "P follows from (★)".

## 6. The critical-point reading

Pair $Q(W)=\theta W$ with $\hat A$: $\pi_DQ(W)=a^2\hat A\circ\hat A+\pi_D(N\circ N)$, so $a^2p+S=\theta a$ with $S=\sum\lVert N_\chi\rVert^2T_\chi$. The weighted sum is $a^3p+3aS=3\theta a^2-2a^3p\le\Theta_n$. With $p\le\Theta_n$ (L57) and $a>0$ this is $\theta\le\Theta_n\frac{1+2a^3}{3a^2}$, which tends to $\Theta_n$ at $a\to1$. **CONFIRMED.**

- **O3 (scope).** The inequality holds at every critical point, whatever $\theta$, and "with $\theta\ge\Theta_n$" names only the case of interest. The cap needs $a>0$. And $f(a)=\frac{1+2a^3}{3a^2}$ has $f'(a)=\frac23(1-a^{-3})\le0$ on $(0,1]$, so $f\ge1$ everywhere: the cap never excludes $\theta>\Theta_n$ by itself and reads only as "a critical point above $\Theta_n$ has diagonal mass $a\le f^{-1}(\theta/\Theta_n)<1$ in every frame". This is post F26's shape (exact at full diagonal mass, monotone below), so it closes nothing when paired with a $\theta$-free lower bound on $a$ unless that bound reaches $f^{-1}(\theta/\Theta_n)$.
- **O3b (scope of "What it gives").** "At a unit $W$ with $P(W)>\theta_0$ the off-diagonal part has $P(N_F)\ge P(W)-\theta_0>0$ in every frame" needs even $n\ge12$ written into the sentence. At $n=10$, padded $W_{\mathbb{CP}^2}$ has $P=1.2247>\theta_0(10)=1.2$ and $P(N_F)=0$ in its own frame.

## 7. Hunt on (★)

- **Screen** (seconds, $n=6$, own code: Weyl basis by null space of Bianchi and Ricci, $\#$ from so$(n)$ structure constants normalised to $I\#I=(n-2)I$, checked to $4\times10^{-16}$, $Q(W)$ Weyl to $10^{-16}$). For 4 random unit $W$ and their negatives, $\min_FP(N_F)$ over frames (three local searches each) was between $-0.37$ and $-0.16$, so (★) held at all 8 with margin. A screen, and at $n=6$, below the bound's range.
- **Screen at the balanced product** (200 frames at $n=6$ and 60 at $n=12$, half Haar, half within $0.05$ of the identity). $P(B)$ reproduced $\theta_0(n)$ to $10^{-16}$. $P(N_F)\ge0$ at every frame: near-identity frames gave $[4\times10^{-3},2.5\times10^{-2}]$ at $n=12$, and **Haar frames gave $P(N_F)\in[1.03,1.18]$ at $n=12$**, against $P(B)=1.236$.
- **O4 (consequence for the owed step).** "Averaging $P(N_F)$ over a family of frames" must return $\le0$ at $B$, where every frame gives $\ge0$. So any such family must sit inside the zero set of $P(N_F)$ at $B$ (frames adapted to the splitting and those that pass L224's equality in each character), and a Haar or other spread-out average is strictly positive at $B$, by about $P(B)$ at $n=12$. An averaging argument therefore has to be exact at the balanced product, the pattern post F67 and the R26 closure record five times. Whether (★) holds at every unit Weyl tensor (the batch's formulation) is open and harmless either way. At a maximiser it is P (O2).

## 8. Lean and the batch's screen

`superposition_bound` in [I124Circle.lean](../lean/HamiltonsCubic/Results/I124Circle.lean#L108) states exactly the averaging step: $\sum w_i^2=1$, $v_i\le\Theta$, $P_W=\sum w_i^2v_i+P_N$ give $P_W\le\Theta+P_N$. The proof is sound (nonnegative weights from `sq_nonneg`). It is imported in [HamiltonsCubic.lean:1132](../lean/HamiltonsCubic.lean#L1132). `lake env lean` on the file returned exit 0 with no errors, warnings or sorry. The identity and caps are prose, as the table says. The batch's own screen matches mine: at $n=6$, two seeds, $P(W)$ and the right side agree to machine precision with $\sum w_\chi^2=1$, $P(N_\chi)=0$ for each character, and $T(\hat A,\hat A,N)=0$. **CONFIRMED.**

## 9. On the record already?

- **L214** ([second-order.md](../findings/second-order.md)): the frame split $W=D+N$ and $\theta=\sqrt t\,P(d)+\frac{1-t}{\sqrt t}\langle L_d\nu,\nu\rangle$. With $t=a^2$ this is $\theta a=a^2p+S$, so **the batch's critical-point reading $3\theta a^2-2a^3p=a^3p+3aS$ is L214's first relation rewritten**, and P(N) $=\theta(1-3a^2)+2a^3p$ is its second.
- **R51** ([routes.md](../routes.md)): at a global maximiser the reflection $D+F\mapsto D-F$ gives $P(F)\ge0$, and on the diagonal locus $\theta\le\theta_0\frac{2a^3}{3a^2-1}$. The batch's bound $P(N)\ge P(W)-\Theta_n$ holds at every $W$, critical or not, and its cap $\frac{1+2a^3}{3a^2}$ is strictly below R51's for $a<1$ ($1.147$ against $1.460$ at $a=0.7$, $1.0115$ against $1.0196$ at $a=0.9$).
- **Post F67** forbids bounding $P(d)$ and $\langle L_d\nu,\nu\rangle$ by independent suprema. The batch keeps them coupled inside each single-character subalgebra, bounded jointly by L224 and L220, so it avoids F67's lossy step, and what it leaves free is $P(N)$.
- **L220's corollary (J)** and **L224's "What it gives"** use one character at a time. The I121 note, R53, R54, L284 and bispectral.md line 90 hold per-mode or per-frame relations and the $(t_F/2)^{3/2}\Theta_n+\frac92C(1-t_F/2)$ display, and none of them states the character-weighted average or $P(W)\le\Theta_n+P(N)$.

**Classification: NEW** as a bound, assembled from L214's split, L123's equivariance and the single-character caps L224 and L220. Its critical-point reading is L214 rewritten, and it strictly sharpens R51's diagonal-locus consequence, which the record should cite.
