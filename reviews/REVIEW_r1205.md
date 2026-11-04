# REVIEW r1205: small p at n = 12 by L249 at a single element

Reviewer r1205, Gate 2, adversarial, independent of r1204. Claim: the paragraph "Small $p$ is excluded by L249 at a single element" in [2026-09-25-I73c-per-vector-rows.md](2026-09-25-I73c-per-vector-rows.md), and `small_p_scalar`, `p7_scalar` in [CoupledMoment.lean](../lean/HamiltonsCubic/Results/CoupledMoment.lean). Givens taken as passed: L249, the Gram row sum of L251, $\theta_0(12)^2=55/36$, and $p\ge14$ excluded at $n=12$.

**Overall: CONFIRMED.** No item breaks. The one soft spot in the chain (the seven-subset maximum rests on a floating enumeration) is closed here by an integer certificate.

| Item | Verdict |
|---|---|
| (1) half of $\kappa_{2p}$ is the sum of the $p$ largest of the thirty values | CONFIRMED |
| (2) $\kappa\le p-2$ at every $n$ | CONFIRMED |
| (3) $p\le6$ excluded at $n=12$, $(p-2)^2<\tfrac{55}{36}\cdot2p$ | CONFIRMED |
| (4) top seven-sum $4+2\sqrt3$, $p=7$ excluded | CONFIRMED |
| (5) $8\le p\le13$ and the $p=8$ remark | CONFIRMED |
| (6) Lean matches prose | CONFIRMED (scalar tails only, as the prose cites them) |

## (1) The half top sum

At $n=12$ the spectrum of $-\mathrm{ad}_x^2$ on $\mathfrak{so}(12)$ is six zeros and each $(s_i\mp s_j)^2$ twice ($6+60=66$). The $2p$ largest entries of a list in which every value appears twice are the $p$ largest distinct-root values each taken twice, so $\tfrac12\kappa_{2p}$ is the sum of the $p$ largest of the thirty. Ties do not matter since only the sum is used. The form $\tfrac12\kappa_{2p}-3$ is L249's, which uses $2p+m=66$ and $\mathop{\mathrm{tr}}(-\mathrm{ad}_x^2)=2(n-2)=20$ at $\sum s^2=1$ (checked: $\sum_{i<j}2[(s_i-s_j)^2+(s_i+s_j)^2]=20\sum s^2$).

## (2) $\kappa\le p-2$ at every $n$

Attack: at general $n$ there are $\lfloor n/2\rfloor$ angles and, at odd $n$, the extra values $s_i^2$. Neither breaks it.

- The Gram argument is Gershgorin on the Gram matrix of the chosen root vectors $v=e_i\pm e_j$ (norm$^2$ 2) or $e_i$ (norm$^2$ 1, odd $n$): distinct vectors have $\lvert v\cdot w\rvert\le1$, so $\lambda_{\max}\le2+(q-1)=q+1$, independent of the number of angles.
- At every $n$ each nonzero eigenvalue of $-\mathrm{ad}_x^2$ on $\mathfrak{so}(n)$ has even multiplicity (a root pair $\pm\alpha$ spans a real 2-plane), and in any case $\tfrac12\kappa_{2p}$ is at most the sum of the $p$ largest distinct values. With fewer than $p$ nonzero values the bound only improves.
- L249's identity $n-5-\tfrac12\mu_m=\tfrac12\kappa_{2p}-3$ is stated at every $n$ in [second-order.md](../findings/second-order.md), so $\kappa\le(p+1)-3=p-2$.

Wording note: the sentence carrying "at every $n$" speaks of "the thirty values", which is $n=12$ language. The bound itself is valid at every $n$ as argued above.

## (3) $p\le6$

Values of $\theta_0\sqrt{2p}$ against $p-2$ (screen): $p=3$: $3.028$ vs $1$, $p=6$: $4.282$ vs $4$, $p=7$: $4.625$ vs $5$. At $p\le2$ the bound gives $\kappa\le0<\theta_0\sqrt{2p}$ directly, and for $3\le p\le6$ squaring is legitimate since both sides are positive. $p=6$: $16<\tfrac{55}{36}\cdot12=18.33$. Correct.

## (4) The seven-subset maximum and $p=7$

- **Exact lower value.** The maximiser found is a star at one vertex $c$: doubled pairs to two leaves and single gaps to three. The doubled leaves decouple (eigenvalue 2), and on the symmetric vector of the single leaves $G$ acts as $\begin{psmallmatrix}7&-\sqrt3\\-\sqrt3&1\end{psmallmatrix}$, eigenvalues $4\pm2\sqrt3$. So $4+2\sqrt3$ is attained exactly.
- **Independent enumeration (screen, 5 s).** Rebuilt from scratch over all 2,035,800 seven-subsets of the thirty roots: $\max\lambda_{\max}=7.464101615137756$, matching $4+2\sqrt3$. Also $q=6$: $6.7015621187$ $=(7+\sqrt{41})/2$, matching the script header.
- **Integer certificate (closes the floating gap).** $38I-5G_S$ has all six leading principal minors positive integers at every one of the 2,035,800 subsets (least values $3,74,1617,26136,731808,20490624$, float error far below $\tfrac12$ at these sizes), so by Sylvester $\lambda_{\max}(G_S)<7.6$ exactly. Hence $\kappa\le4.6<\theta_0\sqrt{14}=4.62481$ without trusting any eigenvalue routine. The prose's exact $4+2\sqrt3$ then follows from the attained star and the floating maximum, and the use needs only the certificate.
- **The scalar.** $(1+2\sqrt3)^2=13+4\sqrt3=19.928<\tfrac{55}{36}\cdot14=21.389$. Margin $4.6248-4.4641=0.161$, matching "margin $0.16$".
- The step $\max_s(\text{top-}q\text{ sum})=\max_S\lambda_{\max}(G_S)$ swaps two maxima and is exact.

## (5) Conclusion and the $p=8$ remark

- $p\le7$ excluded here, $p\ge14$ excluded by L244, L250, L251, L252, so $8\le p\le13$.
- Enumeration over all 5,852,925 eight-subsets (screen, 15 s): $\max\lambda_{\max}=8.274917$, so the single-element bound is $5.2749$ against $\theta_0\sqrt{16}=4.9441$. Matches "$5.275$ against $4.944$". The remark is correctly labelled a screen.

## (6) Lean

- `small_p_scalar`: $1\le p\le6\Rightarrow(p-2)^2<\tfrac{55}{36}\cdot2p$, by `interval_cases`. True at every case including $p=1,2$, where the prose's exclusion is by sign rather than squaring.
- `p7_scalar`: $(1+2\sqrt3)^2<\tfrac{55}{36}\cdot14$.
- [CoupledMoment.lean](../lean/HamiltonsCubic/Results/CoupledMoment.lean) compiles with `lake env lean`, exit 0, no output, no `sorry` or `native_decide`.
- Scope: both are the scalar tails the prose cites them for. The spectral steps (the half top sum, the Gram row sum, the seven-subset maximum) are prose and script only, and the docstrings say so by naming them as inputs.

## Most serious finding

Minor. The seven-subset maximum was supported only by a floating eigenvalue enumeration. An integer Sylvester certificate ($38I-5G_S\succ0$ at all 2,035,800 subsets) now gives $\lambda_{\max}<7.6$ exactly, enough for the use. Suggested edit: cite the certificate beside the enumeration, and say "at every $n$" in a sentence separate from "the thirty values".

## Screens run

Seconds each, on objects constructed for this review: independent enumerations at $q=6,7,8$, and the integer leading-minor certificate at $q=7$. Scripts in the reviewer's scratchpad, reproducible from the description above.
