# REVIEW r1827: the small-mass node of (MG), threshold form, pair identity and bound (I121)

Brief: [BRIEF_I121_smallmass.md](BRIEF_I121_smallmass.md). Log: [agent_logs/r1827-i121-smallmass.log](../agent_logs/r1827-i121-smallmass.log). Analysis-only footing. One script, arithmetic only: [scripts/reviewers/r1827_reach_crossover.py](../scripts/reviewers/r1827_reach_crossover.py), which solves the stated scalar bound for its threshold $t^*$ and compares it with Schur's floor. It is a check of a value, left uncommitted for the parent to commit.

| # | claim | verdict |
|---|---|---|
| 1 | pair identity, its use of L120, completeness of the expansion | CONFIRMED |
| 2 | pair mass $\lVert B_p\rVert^2\le(n-1)t^2$ | CONFIRMED |
| 3a | the bound, each term's cap, Banach's constant | CONFIRMED, with observations |
| 3b | the reach: $c\approx0.15$, beats Schur from $n\approx270$ | REFUTED as to the numbers: the stated bound gives $c\approx0.13$ and crossover $n=346$ at room $0.17$ |
| 4 | threshold form from $\mathbb{CP}^m$ | PLAUSIBLE, with two corrections (normalisation, scope) |
| 5 | averaging identities die by scaling | frame averages PLAUSIBLE. 3-plane and sectional-moment lines REFUTED as to order and formula: the crude bound is $t\gtrsim n^{-2}$, weaker than Schur. The dead-end verdict stands and is stronger |
| 6 | four-set sector reading and what the route owes | PLAUSIBLE, with corrections: screen lower bounds read as suprema in two places, and the open core understated |
| 7 | hypotheses | CONFIRMED, with two unstated but harmless uses |

## 1. The pair identity: CONFIRMED

- **Characters.** A diagonal sign matrix $\varepsilon$ acts on the entry $W(e_i\wedge e_j,e_k\wedge e_l)$ by $\varepsilon_i\varepsilon_j\varepsilon_k\varepsilon_l$. The trivial character is exactly $\{i,j\}=\{k,l\}$ (diagonal), the characters $\varepsilon_i\varepsilon_j$ are the pair blocks, and the weight-four characters are the four-set blocks. Each part is itself Weyl: Ricci of $B_p$ collects only pair entries, Bianchi with four distinct indices collects only four-set entries. So $A,B_p,B_f$ are Hilbert–Schmidt orthogonal Weyl tensors.
- **$T(A,A,B_f)=0$**: $Q(A)$ is sign-invariant by equivariance, hence diagonal, and orthogonal to $B_f$. Given by L120 as claimed.
- **Expansion of $P(W)$.** Of the ten monomials, $T(A,A,B_p)$ (trivial times pair), $T(A,A,B_f)$ and $T(A,B_p,B_f)$ (pair times weight four is never trivial) vanish. The remaining seven are exactly the stated ones. Complete.
- **Pair-character part of $Q(W)=\rho W$.** $Q(A,B_p)$ is pure pair, $Q(A,B_f)$ pure four-set, and $Q(A)$ trivial, so the stated $\rho B_p=\pi_pQ(B_f)+\pi_pQ(B_p)+2L_AB_p+2\pi_pQ(B_p,B_f)$ is right. Pairing with $B_p$ uses only $\langle W,B_p\rangle=\lVert B_p\rVert^2$ and is unaffected by any non-Weyl part of $Q(W)$, since $B_p\in\mathcal W_n$.
- **Substitution**, redone by hand: $P=P(A)+P(B_f)+3\langle L_AB_f,B_f\rangle+3\rho\lVert B_p\rVert^2-2P(B_p)-3\langle L_AB_p,B_p\rangle-3T(B_p,B_p,B_f)$. Matches, and with $\rho=P(W)$ at a unit critical point it is the stated identity.
- **The Lean remark is right.** Expanding $T(W,W,B_p)$ fully, $3T(A,A,B_p)$ and $6T(A,B_p,B_f)$ cancel between the expansion and three times the criticality equation, so only $T(A,A,B_f)=0$ is consumed, exactly as `pair_identity` in [PairIdentity.lean](../lean/HamiltonsCubic/Results/PairIdentity.lean) has it. *Observation*: by L120 that hypothesis holds in every frame, so "in any frame where the diagonal part's square has no four-set component" is every frame. The identity itself needs no maximal frame.

## 2. The pair mass bound: CONFIRMED

- One-plane bound, read as in [r1797](REVIEW_r1797.md) O1 with $\lVert B_{jk}\rVert$ the Hilbert–Schmidt norm: $\lVert B_{jk}\rVert^2=2\lVert x\rVert^2\le2\lVert\delta\rVert^2$ with $\delta_i=\tfrac12(a_{ji}-a_{ki})=t\,\hat\delta^{jk}_i$. So $\lVert B_{jk}\rVert^2\le2t^2\lVert\hat\delta^{jk}\rVert^2$, as stated.
- **Forced sum**, derived: $\sum_{j<k}\lVert\hat\delta^{jk}\rVert^2=\tfrac18\sum_i\sum_{j\ne k}(\hat a_{ij}-\hat a_{ik})^2$ over $j,k\ne i$. For each $i$ the row $r_j=\hat a_{ij}$ has $n-1$ entries summing to zero (Ricci), so the inner sum is $2(n-1)\sum_jr_j^2$. Summing over $i$ gives $2(n-1)\cdot2\lVert\hat A\rVert^2$, so the total is $\tfrac{n-1}2$. Exact.
- Different pair blocks carry different characters, so $\lVert B_p\rVert^2=\sum_{j<k}\lVert B_{jk}\rVert^2\le(n-1)t^2$. Needs the maximal frame (one-plane bound), which is stated.

## 3a. The bound: CONFIRMED, with observations

- $P(B_f)\le S_F\lVert B_f\rVert^3$ by definition of $S_F$ (frame-independent, since the four-set sectors of two frames are $O(n)$-conjugate).
- $3\langle L_AB_f,B_f\rangle\le\tfrac{3\sqrt3}2t\lVert B_f\rVert^2$ by L218, $B_f\perp\mathcal D_n$. $-3\langle L_AB_p,B_p\rangle=3\langle L_{-A}B_p,B_p\rangle\le\tfrac{3\sqrt3}2t\lVert B_p\rVert^2$ by L218 applied to the diagonal $-A$. The lower bound for the pair term is therefore covered, though the text only says "caps both".
- $P(A)\le\theta_0t^3$ by L57, even $n$.
- **Banach.** $T$ is a symmetric trilinear form on the finite-dimensional real Hilbert space $\mathcal W_n$ (the matrix part is the full symmetrisation of $\mathop{\mathrm{tr}}XYZ$, the sharp part is totally symmetric as the definitions give). Banach/Kellogg applies: $\lVert T\rVert=\sup_{\lVert x\rVert=1}\lvert P(x)\rvert$, and $P$ odd makes this $\sup P=\Theta_n$. So $-2P(B_p)\le2\Theta_n\lVert B_p\rVert^3$ and $-3T(B_p,B_p,B_f)\le3\Theta_n\lVert B_p\rVert^2\lVert B_f\rVert$, with $\Theta_n=\rho$ only at a global maximiser, which the text states. The record already uses this reading in L218's statement.
- The stated bracket $6\rho+\tfrac{3\sqrt3}2t+2\rho\lVert B_p\rVert$ is `small_mass_bound`'s $3\rho+3\rho f+3\mu t+2\rho p$ with $f=\lVert B_f\rVert\le1$. *Observation*: $f\le1$ is used silently, as is $S_F\ge0$ (true, $P$ odd) in the first-link form $\rho\le S_F+3\bar\mu t+\dots$.
- **L121 agreement checked**: $\mu_Q^2=\tfrac14(A^2+B^2+C^2-AB-BC-CA)=\tfrac18[3\Sigma-(A+B+C)^2]$, and $A^2\le2(M_{ij}^2+M_{kl}^2)$ gives $\Sigma\le2\lVert M\rVert^2$, so $\mu_Q\le\tfrac{\sqrt3}2$. Equality needs $M$ supported on $Q$ with $M_{ij}=M_{kl}$ etc. and zero row sums, which is Ricci-free at every $n$. Correct.

## 3b. The reach arithmetic: REFUTED as to the numbers, with corrections

- $c\approx\sqrt{\delta/(6\rho)}=0.150$ at $\delta=0.17$, $\rho=\theta_0(14)=1.2617$ is correct arithmetic, and $\sqrt6/c$ squared gives $n\approx267$. But it drops the linear L218 term $\tfrac{3\sqrt3}2t=2.6\,c\,n^{-1/2}$ (about $0.02$ at $n=270$, an eighth of $\delta$) and uses $\rho=\theta_0(14)$ where the crossover sits at $n$ in the hundreds, with $\theta_0(270)=1.406$.
- **Solving the stated bound itself** (contradiction when $\theta_0(1-6p^2-2p^3)>S_F+\tfrac{3\sqrt3}2t(1+p^2)+\theta_0t^3$, $p^2=(n-1)t^2$, $S_F=\theta_0(n)-\delta$) against Schur's exact floor $t^2=\tfrac6{(n+1)(n+2)}$: crossover $n=346$ with $c=0.131$ at $\delta=0.17$, $n=294$ at $\delta=0.20$, $n=586$ at $\delta=0.10$.
- **Correction**: "$c\approx0.13$, beating Schur from $n\approx350$ at a room of $0.17$ held to that $n$". The qualitative conclusion (asymptotic, leaves $12\le n\lesssim$ a few hundred to other means) stands.
- The room $0.17$ is itself an upper bound on $\theta_0-S_F$ at $n=14$ (ascents give lower bounds on $S_F$, and $n=14$ is unconverged), and nothing is known at $n\approx350$. The crossover scales roughly as $36\theta_0/\delta$, so it moves out as the room shrinks.

## 4. Threshold form from $\mathbb{CP}^m$: PLAUSIBLE, with corrections

- **Normalisation.** $\kappa^2=\tfrac3{m+1}$ is [L94](../findings/bispectral.md)/L95's $\max_F\sum_{a\ne b}W_{abab}^2$, the ordered-pair sum, with $\kappa^2\le2\lVert M\rVert^2$. The brief's $t^2=\sum_{a<b}a_{ab}^2$ is half of it: **$t^2(\mathbb{CP}^m)=\tfrac3{2(m+1)}=\tfrac3{n+2}$**. The sweep's "maximal-frame diagonal mass $\kappa^2$" conflates the two. Nothing downstream changes, since both tend to zero. The $J$-adapted frames attain $\kappa$, so the maximal-frame reading is right.
- **Values and limit.** $\theta^2(\mathbb{CP}^m)=\tfrac{(m+1)(2m-1)}{3m(m-1)}$ reproduces $10/9$, $35/36$, $9/10$ and tends to $\tfrac23$, so $\theta\to\sqrt{2/3}$: bounded below for all $m$, which the claim needs and the sweep only shows by three values. Criticality holds by isotropy (the $U(m)$-invariant Weyl tensors form a line).
- **Scope.** The family refutes only a bound $P\le F(t)$ with $F$ **uniform in $n$** and holding **at every critical point**. At fixed $n$ Schur's floor keeps $t\ge\sqrt{6/((n+1)(n+2))}$, so "$F_n(t)\to0$" is vacuous, and [bispectral.md](../findings/bispectral.md) already records that $\theta(\mathbb{CP}^m)<\theta_0(2m)$ for $m\ge4$, so the family says nothing about bounds restricted to global maximisers. "No bound $P\le F(t)$ with $F(t)\to0$ exists" should carry both qualifiers. The conclusion that (MG) must take threshold form, with threshold at least $\sup$ of $\theta$ over small-$t$ critical points, follows.
- **Families at or below $\sqrt{3/2}$**: symmetric spaces (record), $\theta^2(\mathbb{HP}^m)$ with $m=2$ giving $56/45$ and limit $2/9$, and $1.088948$ at $n=8$ all check against [INDEX-values.md](../findings/INDEX-values.md). CONFIRMED as a report of the record.

## 5. Averaging identities: verdict stands, two of the three scaling statements REFUTED

- **Frame averages, PLAUSIBLE.** If $P=\mathbb E_g[C(A_g)]$ with $\lvert C\rvert\le K\lVert\cdot\rVert^3$, then $\lVert A_g\rVert\le t$ gives $t^3\ge P/K$. By Schur on the irreducible $\mathcal W_n$, $\mathbb E\lVert A_g\rVert^2=\tfrac6{(n+1)(n+2)}$ for every unit $W$. The identity forces $K\ge P/\mathbb E\lVert A_g\rVert^3$, which is order $n^3$ once $\lVert A_g\rVert$ concentrates (Jensen alone gives the wrong direction). So the bound is **at best** $t\gtrsim n^{-1}$. The text's "K grows like $n^3$" is a lower bound on $K$, and should say "at best".
- **3-planes, REFUTED as to order.** A random 3-plane restriction of a unit $W$ has six coordinates, so its expected squared norm is of order $6/\dim\mathcal W_n\sim n^{-4}$: it sees $O(n^{-2})$ of the curvature in norm, not $O(1/n)$. Each entry is $O(t)$ (sectional curvatures directly, the pair entries by polarising sectional curvatures), so the same argument gives $K\gtrsim n^6$ and $t\gtrsim n^{-2}$.
- **Sectional moments, REFUTED as to formula and order.** L118 is $\theta=c_n\Psi_3+\tfrac5{72}\Phi$ with $\Psi_3=\mathbb E[\sec^3]$, $c_n=[n+4]_6/144$, and $\Phi$ the unnormalised Gaussian correlation. $\lvert\sec\rvert\le t$ gives $c_n\Psi_3\le c_nt^3$, and $\lvert N_{xy}\rvert\le t\lvert x\rvert^2\lvert y\rvert^2$ gives $\lvert\Phi\rvert\lesssim n^6t^3$. So $\theta\lesssim n^6t^3$, that is $t\gtrsim n^{-2}$. **The stated "$\theta\lesssim n^6t^3/c_n$" equals $144t^3$ and is false**: $\mathbb{CP}^m$ has $t^2=\tfrac3{n+2}\to0$ with $\theta\to\sqrt{2/3}$. The factor $c_n$ belongs in the numerator.
- **Effect.** Both lines land at $n^{-2}$, strictly weaker than Schur's $n^{-1}$, so they are deader than the text says. The corrected sentence should read "at best Schur's order for frame averages, and $n^{-2}$ for 3-plane and sectional-moment averages".

## 6. The four-set sector reading: PLAUSIBLE, with corrections

- **Phase 3a**: $\lVert B_p\rVert^2\le(n-1)t^2\ll1$ and $\lVert A\rVert=t$ give $\lVert B_f\rVert^2\approx1$. Correct, and the regime $\tfrac6{n^2}\lesssim t^2\ll\tfrac1n$ is nonempty for large $n$.
- **The open core is understated.** L220 is one four-set and L221 is disjoint families or two four-sets sharing two indices with $\tau\le0$, all as exact critical points inside $\mathcal D_n\oplus\bigoplus V_{Q_i}$. A near-four-set $W$ generically populates all $\binom n4$ four-set blocks at once and is critical only in $\mathcal W_n$, with pair mass up to $(n-1)t^2$. So what is open there is every family with overlaps beyond one two-shared pair, three or more mutually overlapping four-sets included, plus the perturbation from exact to approximate. "Overlap: three shared indices and $\tau>0$" names only the two-block cases. The route table's "quantitatively" partly covers the second item.
- **Screens read as more than screens, in two places.**
  - "So at $n\le12$ a tensor wholly in the four-set sector is not a maximiser, with room." Twelve ascents give lower bounds on $S_F$. The sentence needs $S_F<\theta_0(n)$, an upper bound, which is the route's owed item (i). It should read "no ascent found a four-set-sector value above $\dots$, room at most $\dots$".
  - "about $0.15$ at the screened room" and the $n\approx270$ crossover treat the room as a measured $\delta$ where it is an upper bound on $\delta$ at $n\le14$ (see 3b).
  - The identification of $0.948683$ with $\theta(\mathbb{CP}^5)$ is a value match. That is consistent with it being a screen, but a reader could take it as structure.
- **Arithmetic checks.** $\theta_0(n)$ and the rooms $0.312,0.251,0.203,0.171$ are right. The first sup step is $0.948683-0.833333=0.1154$, written $0.116$ (rounding slip). The $+c_*$ subsector bound $\tfrac{5\sqrt3}{12}\sqrt2=1.0206<1.021$ is right, and $\tfrac{5\sqrt3}{12}\cdot\tfrac2{\sqrt3}=\tfrac56$ matches the $n=8$ row. "Nothing in range suggests it closes" is an extrapolation of four points, and $n=14$ is unconverged.
- **What the route owes**, items (i) to (iii), is stated honestly, and the Lean table marks every untyped link.

## 7. Hypotheses: CONFIRMED, with observations

- Maximal frame: used only for the pair mass (one-plane bound). Stated.
- Global maximality: used for $\lvert T\rvert\le\rho\lVert\cdot\rVert^3$ ($\rho=\Theta_n$) and for $\rho\ge\theta_0(n)$ in the reach. Stated at "a global maximiser".
- Even $n$: used through L57 for $P(A)\le\theta_0t^3$. The first-link inequality $\rho\le S_F+3\bar\mu t+K(n-1)t^2+\theta_0t^3$ is written without it, though (i) says "every even $n\ge12$". The line should carry "$n$ even".
- $f\le1$ and $S_F\ge0$: used silently, both trivially true.
- "Attempt 4's joint bound stops failing" at $t\sim n^{-1/2}$ refers to the first sweep and was not examined here.
