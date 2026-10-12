# REVIEW r1836, the matching inequality and the visibility route (I121)

Brief: [BRIEF_I121_matching.md](BRIEF_I121_matching.md). Source: [2026-09-28b-LIT-step8-sweep.md](2026-09-28b-LIT-step8-sweep.md). Log: [agent_logs/r1836-i121-matching.log](../agent_logs/r1836-i121-matching.log). Script: [scripts/reviewers/r1836_witness_frame.py](../scripts/reviewers/r1836_witness_frame.py) (seconds, a check of one value).

**Verdict in one line.** The algebra holds and the matching inequality is true with a better constant ($t^2$, not $3t^2$), but the screen measures visibility in frames that are not maximal, so it says nothing about the route's hypothesis, and the route's "$t\gtrsim\sqrt c$" loses a factor of $n$ once the pair mass is admitted.

| # | claim | verdict |
|---|---|---|
| 1 | $c_2,c_3,c_4$ and $D_1=0$ at pair-free $W$ | CONFIRMED (coefficients, $D_1=0$), PLAUSIBLE (the small-angle consequence) |
| 2 | finite form: $E(M)\le$ the $A$-side, $O(t^2)$, average $\tfrac32\lVert B_f\rVert^2/((n-1)(n-3))$ | CONFIRMED, with the bound holding for every $M$ |
| 3 | matching inequality $E(M)+\sum_{e\ne f}(x^e_k+x^e_l)^2\le3t^2$ | CONFIRMED, and the constant improves to $1$ |
| 4 | visibility plus the inequality bounds $t$ below, "$t\gtrsim\sqrt c$", $n$-free | REFUTED as stated (corrected bound $t^2\ge c/(1+cn)$ under the one-plane pair bound) |
| 5 | the screen: $1.0000$ at the witness, $0.540$ at $P=0.950$, $0.04$ to $0.049$ random, "screened constant $c\approx0.5$" | REFUTED as support for the route (right combination, wrong frames) |

## Claim 1, the fourth-order expansion

- **Coefficients.** $\pi_{\mathcal D}(e^{\varphi\xi}W)=\sum_k\varphi^kD_k/k!$, so the $\varphi^m$ coefficient of $f$ is $\sum_{k+l=m}\langle D_k,D_l\rangle/(k!\,l!)$. At $m=2,3,4$ this gives exactly the quoted $c_2$, $c_3$, $c_4$. CONFIRMED.
- **$D_1=0$ at pair-free $W$.** The first derivative of $a_{ij}$ along $\xi$ is $-2W(\xi\cdot e_{ij},e_{ij})$, and $\xi\cdot e_{ij}=\sum_k\xi_{ki}e_k\wedge e_j+\sum_k\xi_{kj}e_i\wedge e_k$ pairs $e_{ij}$ only with bivectors sharing one index, which are pair entries. The map is linear in $\xi$, so the statement holds for every multi-plane generator, and the one-plane reason quoted in the claim is the per-generator case. CONFIRMED.
- **The consequence.** With $D_1=0$, $c_2=\langle A,D_2\rangle$, $c_3=\tfrac13\langle A,D_3\rangle$ and $c_4=\tfrac14\lVert D_2\rVert^2+O(t)$ at fixed $\lVert\xi\rVert$. The next coefficient $c_5$ carries $\tfrac16\langle D_2,D_3\rangle$, which is $O(1)$. At $\varphi^2\sim|c_2|/c_4\sim t$ the gain $\sim c_2^2/c_4\sim t^2$ beats the $c_3$ and $c_5$ terms, each $O(t^{5/2})$, so the mass rises at a small angle when $\lVert\pi_{\mathcal D}(\xi^2B_f)\rVert$ is bounded below. The claim writes that share as "$O(1)$", which is an upper bound, and the argument needs it bounded below, which is what "sees the four-set part" must mean. PLAUSIBLE as a heuristic.

## Claim 2, the finite form

- The inequality $\sum_{e<f}\Delta_{ef}\le0$ holds for every perfect matching in a globally maximal frame (a finite rotation, so a local maximum would not suffice, and the brief's hypothesis is global). Its $A$-side is at most $t^2$ for every $M$ by claim 3's argument below, so "$O(t^2)$ on average over $M$" undersells it.
- **The average.** A four-set with entries $u=W_{ij,kl}$, $v=W_{ik,jl}$, $w=W_{il,jk}$ and Bianchi $u=v-w$ has Hilbert–Schmidt mass $2(u^2+v^2+w^2)$, and its three pairings show $(v+w)^2$, $(u-w)^2$, $(u+v)^2$, summing to $3(u^2+v^2+w^2)$ (checked by hand from $u=v-w$). Each pairing lies in a uniform matching with probability $1/((n-1)(n-3))$, which gives $\tfrac32\lVert B_f\rVert^2/((n-1)(n-3))$ with $\lVert B_f\rVert$ the Hilbert–Schmidt norm. CONFIRMED. One pairing sees at most the whole of its four-set's mass (equality at $u=0$, $v=w$), so the visible share lies in $[0,1]$.
- "Random four-set tensors hide from every matching at $\sim\lVert B_f\rVert^2/n^2$" is an averaging heuristic about a maximum over $(n-1)!!$ matchings. A concentration count (fluctuation $\sim n\sqrt{n\log n}$ against a mean $\sim n^2$ in units of the entry variance) makes it plausible. The screen's $0.04$ to $0.049$ at $n=12$ is about three times the mean $1.5/99$. PLAUSIBLE.

## Claim 3, the matching inequality

- Each step checks. $\tfrac14\square^2\le\sum$ of the four squares is Cauchy–Schwarz. The cross entries of distinct edge pairs are disjoint. $(\delta^e_k+\delta^e_l)^2\le2(\delta^{e\,2}_k+\delta^{e\,2}_l)$, and over the edges $f\ne e$ the indices $k,l$ run once through the complement of $e$, so the $\delta$ side is $2\sum_{e\in M}\lVert\delta^e\rVert^2$. $\lVert\delta^e\rVert^2\le\tfrac12(r_i+r_j)$ and $\sum_ir_i=2t^2$. So the $3t^2$ bound is CONFIRMED, using only the block exchange, the exact matching identity and global maximality. The row-sum given is unused.
- **The constant is $1$, not $3$.** In the block of the edge pair $(e,f)$ write $m=(a_{ik},a_{il},a_{jk},a_{jl})$. The $A$-side of $\Delta_{ef}$ is
$$\tfrac14(m_0-m_1-m_2+m_3)^2+\tfrac14(m_0-m_1+m_2-m_3)^2+\tfrac14(m_0+m_1-m_2-m_3)^2,$$
the three pair and rectangle differences of `block_exchange` exactly, since $\tfrac14(m_0-m_1+m_2-m_3)^2=(\delta^f_i+\delta^f_j)^2$ and $\tfrac14(m_0+m_1-m_2-m_3)^2=(\delta^e_k+\delta^e_l)^2$. The four $\pm1$ Hadamard vectors are orthogonal of norm $2$, so this sum equals $\lVert m\rVert^2-\tfrac14s_{ef}^2$ with $s_{ef}=a_{ik}+a_{il}+a_{jk}+a_{jl}$ (residual $4\times10^{-16}$ in the script). Summing over $e<f$ with disjoint cross entries:
$$E(M)+\sum_{e\ne f\in M}(x^e_k+x^e_l)^2\ \le\ t^2-\sum_{e\in M}a_e^2-\tfrac14\sum_{e<f}s_{ef}^2\ \le\ t^2 .$$
The written proof bounds the three differences separately and so counts the block's diagonal mass three times.

## Claim 4, the route's conclusion

- The implication is valid in form: a share $c$ of $\lVert B_f\rVert^2$ visible in the maximal frame gives $c\lVert B_f\rVert^2\le t^2$ (with the constant of claim 3).
- **The lower bound on $t$ depends on $n$.** At unit $W$, $\lVert B_f\rVert^2=1-t^2-\lVert B_p\rVert^2$. With the one-plane bound $\lVert B_p\rVert^2\le(n-1)t^2$ this gives $\lVert B_f\rVert^2\ge1-nt^2$ and so $t^2\ge c/(1+cn)$ (or $c/(3+cn)$ with the written constant). That is $O(1/n)$, a factor $n$ better than attempt 1's $O(1/n^2)$ and short of an absolute constant. The quoted "$t\gtrsim\sqrt c$" and "an $n$-free inequality to feed" hold only when the pair mass is $O(t^2)$ with an $n$-free constant, which the text lists as one branch ("either small") without supplying it. REFUTED as stated. The correction is $t^2\ge c/(1+cn)$, with the $n$-free bound owed a separate pair-mass estimate. A natural source is the $\sum(x^e_k+x^e_l)^2$ term already on the left of claim 3, which is a pair-visibility quantity in the same form.
- **The hypothesis must be read in the maximal frame.** The "visibility" statement as first formulated ("has a perfect matching, or a multi-plane rotation, seeing a fixed fraction") names no frame. The inequality holds only in a globally maximal frame, so visibility is needed there and nowhere else. The later paragraph says so, and the statement the node needs must carry it.
- "Visibility is the conjecture's core in combinatorial form" is framing. It is a reformulation of the small-mass node, and the record holds no argument that it is equivalent to Conjecture A.

## Claim 5, the screen

- **The combination is right.** [screen_I121_visibility.py](../scripts/misc/screen_I121_visibility.py) uses $(W_{ik,jl}+W_{il,jk})^2$ per edge pair and the Hilbert–Schmidt four-set mass over ordered bivector pairs, matching the identity and the share's $[0,1]$ range.
- **The frames are not maximal, so the numbers are not the route's quantity.** "The witness" is the unit $S^6\times S^6$ product rotated by $\tfrac\pi4$ in the planes $(k,6+k)$. Its own frame is diagonal with $t=1$, globally maximal, and has $B_f=0$ there. In the screened frame the script gives $t^2=1/12$, pair mass $0$, $\lVert B_f\rVert^2=11/12$ and $E(M_0)=11/12$ for $M_0=\{(k,6+k)\}$, which exceeds $3t^2=1/4$. The matching inequality fails there, which shows directly that the frame is not maximal. The random and ascent tensors are pure four-set in the standard frame, where $t=0$, so that frame is not maximal either. None of the three numbers measures a share in a maximal frame.
- **The ascent is below the route's threshold.** $P=0.950<\sqrt{3/2}\approx1.2247$, so "a screened constant ($c\approx0.5$ at $P\approx0.95$)" is neither in the right frame nor in the right value range. "High value goes with high visibility" is shown only for visibility in a hand-chosen frame.
- The numbers are quoted as a screen, which is correct labelling, but the route paragraph then uses the $0.540$ as a constant to feed, which is more than the screen shows. REFUTED as support. The correct screen would move each tensor to a (numerically) globally maximal frame first and measure $\max_ME(M)/\lVert B_f\rVert^2$ there. That is an optimisation over $O(n)$ with unknown cost per tensor, so it is named here and not run.

## Corrections to carry

1. Claim 3's constant: replace $3t^2$ by $t^2-\sum_{e\in M}a_e^2-\tfrac14\sum_{e<f}s_{ef}^2$ (Hadamard Parseval on each block).
2. Claim 4: replace "$t\gtrsim\sqrt c$" by $t^2\ge c/(1+cn)$ under the one-plane pair bound, and name the $n$-free pair-mass estimate as owed.
3. Claim 5: withdraw "$c\approx0.5$" as a screened constant, and state that visibility is to be measured in the maximal frame, where the witness has $B_f=0$.
