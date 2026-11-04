# Review r1850: the reduction at I121's small-mass node (brief [BRIEF_I121_Ereduction.md](BRIEF_I121_Ereduction.md))

Log: [agent_logs/r1850-i121-ered.log](../agent_logs/r1850-i121-ered.log). Script: [review_r1850_check.py](../scripts/reviewers/review_r1850_check.py), seconds at $n=6,8$ on a random pair-free Weyl tensor I built (Bianchi and Ricci asserted), used only to check values.

**Verdict: every formula is right. The closing sentence of the three-source paragraph overclaims: the coupling is open too, outside a very thin mass range, and the reduction covers pair-free $W$ only.**

| # | claim | verdict |
|---|---|---|
| 1 | Claim 1, $\theta^2\le\tfrac32+\theta E$ and the threshold $\varepsilon_n$ | CONFIRMED (two remarks on the written proof) |
| 2 | Claim 2, $E$ in a frame at pair-free $W$ | CONFIRMED |
| 3a | coupling estimate $\tfrac32\sqrt{3(n-3)}\,t^2$ | CONFIRMED, with $\sum_{e,f}$ read as an ordered sum |
| 3b | visible cubic per matching as $P(D_M)$, bound $\Theta_nE(M)^{3/2}$ | CONFIRMED |
| 4 | what is open, the invisible part spent by L198, the screen | PLAUSIBLE, corrections below |

## 1. Claim 1

- $E=P-\tfrac32\mathop{\mathrm{tr}}W^3=\langle W^\#,W\rangle-\tfrac12\mathop{\mathrm{tr}}W^3$ follows from $P=\mathop{\mathrm{tr}}W^3+\langle W^\#,W\rangle$. It is $O(n)$-invariant because conjugation by any orthogonal $g$, of either determinant, preserves the bracket on $\mathfrak{so}(n)$ and so commutes with $\#$.
- $\mathop{\mathrm{tr}}W^3\le\lambda_{\max}$ holds termwise from $\lambda_k\le\lambda_{\max}$ and $\lambda_k^2\ge0$. **The sign $\lambda_{\max}\ge0$ is true (the trace on $\Lambda^2$ is half the scalar curvature, zero) and unused.**
- L198's top-index row gives $\lambda_k\theta-\lambda_k^2\le1-\lambda_k^2$, so $\theta\lambda_k\le1$ at every $k$, which is what is used.
- **The written proof divides by $\theta$** ("$\le\tfrac3{2\theta}+E$"), so as written it covers $\theta>0$. Both stated conclusions live there, so nothing is lost. The inequality holds at every $\theta$: it is equivalent to $\theta\mathop{\mathrm{tr}}W^3\le1$, and at $\theta<0$ this follows from $\mathop{\mathrm{tr}}W^3\ge\lambda_{\min}$ and $\theta\lambda_{\min}\le1$, the same row of L198 at the bottom index.
- Threshold: $\theta^2\le\tfrac32+\theta E$ with $\theta>0$ gives $E\ge\theta-\tfrac3{2\theta}$, increasing in $\theta$, so $\theta\ge\theta_0$ gives $E\ge\varepsilon_n$. With $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$: $\varepsilon_{12}=1.2360331-1.2135597=0.022473$, and the limit is $\sqrt2-\tfrac3{2\sqrt2}=0.353553$. Both values as stated.

## 2. Claim 2

- $\mathop{\mathrm{tr}}(A^2B_f)=\sum_ea_e^2(B_f)_{ee}=0$. $\mathop{\mathrm{tr}}(AB_f^2)=\sum_ea_e\sum_gW_{e,g}^2$, and the only nonzero $W_{e,g}$ in $B_f$ have $g$ disjoint from $e$, each being $J_{eg}$ by definition. Folding into unordered pairs gives $\sum_{(e,f)}(a_e+a_f)J_{ef}^2$.
- $\mathop{\mathrm{tr}}B_f^3$: the six orderings of a rectangle give one product each, and flipping an edge's orientation flips two factors, so $6\sum_RJJJ$ is well defined.
- Subtraction: $J^2$ coefficient $\tfrac92-\tfrac32\cdot3=0$, rectangle $9-\tfrac32\cdot6=0$. The result follows.
- Check (mine): $E$ invariant against frame formula, $-189.7577161904$ both ways at $n=6$ and $169.9444892489$ at $n=8$ (agreement to $3\times10^{-13}$).

## 3a. The coupling

- $\lvert6\sum_{(e,f)}(a_e+a_f)X_{ef}^2\rvert=6\lvert\sum_ea_eS_e\rvert\le6t\big(\sum_eS_e^2\big)^{1/2}$ with $S_e=\sum_fX_{ef}^2$.
- $S_e\le\tfrac{n-3}4t^2$: over the $(n-3)!!$ matchings containing $e$, each $f$ disjoint from $e$ appears $(n-5)!!$ times, and each such $M$ has $\sum_{f\in M}4X_{ef}^2\le E(M)\le t^2$. So $(n-5)!!\cdot4S_e\le(n-3)!!\,t^2$. Correct, and it **needs the globally maximal frame**, the matching inequality's hypothesis, which the paragraph names only as "small mass".
- **Notation.** On one block $\sum_\pi X_\pi^2=\tfrac38\lVert\nu_Q\rVert^2$, so the sum over unordered pairs is $\tfrac38\lVert B_f\rVert^2$ (script: ratio $0.375$ at $n=6$ and $8$). The stated $\tfrac34$ is the ordered sum $\sum_eS_e$, which is what Cauchy–Schwarz uses. The paragraph writes $\sum_{(e,f)}$ for unordered pairs one clause earlier, so it should write $\sum_eS_e=\tfrac34\lVert B_f\rVert^2$.
- Then $\sum S_e^2\le\max S_e\sum S_e\le\tfrac{3(n-3)}{16}t^2$ (using $\lVert B_f\rVert^2\le1$), giving $\tfrac32\sqrt{3(n-3)}\,t^2$ as stated.

## 3b. The visible cubic

- Take $d_{i_\pm k_\pm}=\sigma\sigma'X_{pq}$ between the rotated indices of matched edges $p\ne q$, zero inside an edge. Row sums vanish, so $D_M$ is a diagonal Weyl tensor. $\lVert D_M\rVert^2=\sum_{p<q}4X_{pq}^2=E(M)$.
- $P(D)=\sum d^3+3\sum_{\text{triangles}}ddd$. The cubes cancel in each $2\times2$ block, and a triangle across three edges carries $X_{pq}X_{pr}X_{qr}$ under all $8$ sign choices, so $P(D_M)=24\sum_{R\subset M}XXX$. $X$ is orientation-free, so the products are well defined.
- **$D_M$ is literally the cross-pair diagonal of $B_f$ after the $\tfrac\pi4$ rotation in $M$'s planes**: $e_{i_+}\wedge e_{k_+}=\tfrac12(e_{ik}+e_{il}+e_{jk}+e_{jl})$ picks up $\tfrac12(W_{ik,jl}+W_{il,jk})=X$ from the disjoint cross terms. Script: agreement to $9\times10^{-16}$, and $P(D_M)=24\sum_{R\subset M}XXX$, $\lVert D_M\rVert^2=E(M)$ at $n=6,8$.
- L57 applied to $\pm D_M$ gives $\lvert\cdot\rvert\le\Theta_nE(M)^{3/2}$. Each rectangle lies in $(n-7)!!$ matchings, so $24\sum_RXXX=\tfrac1{(n-7)!!}\sum_MP(D_M)$. With $E(M)^{3/2}\le t\,E(M)$ and $\sum_ME(M)=3(n-5)!!\lVert B_f\rVert^2$, the total is at most $3\Theta_n(n-5)\,t\lVert B_f\rVert^2$, which matches "order $nt$".

## 4. What the section claims beyond what it shows

- **"What is open is the visible cubic" is too strong. The coupling is open as well except at very small mass.** The coupling bound falls below $\varepsilon_n$ only when $t^2<\varepsilon_n/\big(\tfrac32\sqrt{3(n-3)}\big)$, which is $0.00288$ at $n=12$ and about $0.136/\sqrt n$ for large $n$. At F81's witness scale $t^2=\tfrac1n$ the bound is $0.650$ at $n=12$, which is $29\varepsilon_{12}$. The coupling is sign-indefinite. So unless $\tau_n$ sits below that range, a proof must control the coupling and the visible cubic together. Correction: "what is open is the visible cubic, and the coupling above $t^2\approx\varepsilon_n/(\tfrac32\sqrt{3(n-3)})$".
- **The reduction is pair-free only.** Claim 2 and the three-source paragraph assume $B_p=0$, while the Theorem sought covers every small-mass critical point in a globally maximal frame. The heading ("the value lives in the visible and diagonal parts") should carry "at pair-free $W$". Claim 1 is general.
- **"The invisible part of $B_f$ is spent entirely by L198" is interpretation, and loose.** L198 bounds the whole $\tfrac32\mathop{\mathrm{tr}}W^3$, which includes $\mathop{\mathrm{tr}}A^3$ and the $A$–$J^2$ coupling. Also, by the note's own line, each $J_{\pi_1}=\tfrac23(\pm X_{\pi_2}\pm X_{\pi_3})$, so the $J$'s have no degrees of freedom apart from the $X$'s. The accurate statement: $E$ is written in the $X$'s and $A$ alone, and everything else in $P$ is $\tfrac32\mathop{\mathrm{tr}}W^3$, which L198 bounds by $\tfrac3{2\theta}$.
- **The screen** is labelled a screen and asserts no positive statement. It is not reproduced here, since no script path is given. Nothing to correct.
