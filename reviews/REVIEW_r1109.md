# r1109: I73(c) section 9, the Ky Fan bracket cap

*Gate 2 review of section 9 of [2026-09-23-I73c-summed-pairs.md](2026-09-23-I73c-summed-pairs.md) at commit aea2c311, sections 1 to 8 taken as given. Analysis first, screens of seconds on constructed objects, reported as screens. Log: [r1109-I73c-sec9.log](../agent_logs/r1109-I73c-sec9.log). Scratch scripts in the session scratchpad, not committed.*

| # | Claim | Verdict |
|---|---|---|
| 1 | The lemma's inequality by Ky Fan | CONFIRMED, orthogonality to $X_0$ unused |
| 2 | The spectrum of $-\mathrm{ad}_X^2$ and $\kappa_1,\kappa_2,\kappa_4,\kappa_6=2,4,6,8$ | CONFIRMED, two repairs: signed simple configurations are not covered by the argument as written, and the attainment sentence holds for $\kappa_6$ only |
| 3 | The corollary at L173's witness and the class-level form | CONFIRMED |
| 4 | The ray screen, threshold $1.29372$ | CONFIRMED as a screen, and the threshold is now exact and proved: $\theta^\ast=\tfrac{83\sqrt{21}}{294}=\tfrac{83}{21}a$ |
| 5 | The route paragraph | PLAUSIBLE, one sentence overreaches and two of the three successor directions are inert at the new vertex |
| 6 | Lean: KyFanBracketCap | Nine statements CONFIRMED as faithful, coverage REFUTED: eight three-slot configurations are missing |

## Chain read

[L31](../findings/stratum-two-negative.md) (root-slot spectrum $i(\pm s_a\pm s_b)$, $i(\pm s_a)$ at odd $n$, record norm $\sum s_a^2=\lVert X\rVert^2$), [L104](../findings/bounds-relaxations.md) (class averaging, reduced rows, per-pair cap $\sum_k\mu_k^{(ij)}t_{ijk}\le2$), [L173](../findings/bounds-relaxations.md) (witness $t_{112}=\tfrac23$, $t_{222}=2$, caps $(1,1),(1,2),(2,2)$ tight in its labelling), [post F76](../findings/fence-posts.md). No link broken.

## 1. The lemma

- $-\mathrm{ad}_{X_0}^2$ is self-adjoint and positive semidefinite for $\langle Z,Z'\rangle=\tfrac12\operatorname{tr}(Z^{\mathsf T}Z')$ because $\mathrm{ad}_{X_0}$ is skew-adjoint for that Ad-invariant pairing, so $\lVert[X_0,X_j]\rVert^2=\langle X_j,-\mathrm{ad}_{X_0}^2X_j\rangle$ and Ky Fan's maximum principle gives $\sum_{j\le r}\langle X_j,-\mathrm{ad}^2_{X_0}X_j\rangle\le$ the $r$ largest eigenvalues.
- **Ky Fan needs only that $X_1,\dots,X_r$ are orthonormal.** Orthogonality to $X_0$ is never used, and it would buy nothing: $\ker\mathrm{ad}_{X_0}$ contains a Cartan subalgebra, of dimension $\lfloor n/2\rfloor\ge1$, so deleting one kernel direction leaves the top $r$ eigenvalues unchanged for every $r$ the note uses. Unit $X_0$ is what makes $\kappa_r$ the right constant.
- $\kappa_{2k-1}\le\kappa_{2k}$ holds because the eigenvalues are nonnegative.

## 2. The spectrum and the constants

- **Spectrum.** For $X=\sum_as_a\varphi_{2a-1,2a}$, the $4$-dimensional block between planes $a,b$ carries $\mathrm{ad}_X$-eigenvalues $\pm i(s_a+s_b)$, $\pm i(s_a-s_b)$, and at odd $n$ the $2$-dimensional block between plane $a$ and the last axis carries $\pm is_a$. So $-\mathrm{ad}_X^2$ has each slot value with multiplicity exactly $2$ and zero on the Cartan. Hence the top $2k$ eigenvalues are $k$ slots taken twice and $\kappa_{2k}=2\max_s\max_{|S|=k}\sum_{S}$. Every sign pattern of $s$ is realised by some $X$, so the inner maximum over unit $s$ is $\lambda_{\max}(M_S)$ exactly.
- **$k=1,2$.** $\lambda_{\max}=2$ and $3$ as stated, giving $\kappa_2=4$, $\kappa_4=6$. $\kappa_1=(s_1+s_2)^2\le2$ is L31.
- **$k=3$, and a gap in the argument as written.** The note bounds simple unsigned graphs by $\max_{uv}(d_u+d_v)$ (valid: $Q=RR^{\mathsf T}$ with $R^{\mathsf T}R=2I+A(L(G))$) and names the $\pm$-pair and loop configurations. It is silent on signed simple configurations, e.g. the triangle $(s_a+s_b)^2+(s_a+s_c)^2+(s_b-s_c)^2$, which is unbalanced and so not a relabelling of the unsigned triangle. **Repair, two lines, and it makes the case list unnecessary:** $(s_a\pm s_b)^2\le(|s_a|+|s_b|)^2$ gives $s^{\mathsf T}Ms\le|s|^{\mathsf T}Q|s|$ for any configuration without a $\pm$ pair, which is the unsigned bound. With a $\pm$ pair the pair contributes $2(s_a^2+s_b^2)\le2$ and the third slot at most $2$. With a loop there are at most two edges, and Weyl gives $\lambda_{\max}\le3+1$. So every three-slot configuration has $\lambda_{\max}\le4$.
- *Screen, all $\binom{|{\rm slots}|}{k}$ configurations on six vertices, $k\le3$:* maxima $2$, $3$, $4$, with loop-bearing maxima $2.618$ ($k=2$) and $2+\sqrt3$ ($k=3$), and the $\pm$-pair maximum $2+\sqrt2$. This matches the note.
- **Attainment is misstated.** "The maxima are attained, by $s=(1,1,1)/\sqrt3$ at $n\ge6$" is true of $\kappa_6$ only. There the top slot is $\tfrac43$ and the top two sum to $\tfrac83$, so $\kappa_2$ and $\kappa_4$ are not attained there. Suggested text: "$\kappa_1,\kappa_2$ at $s=(1,1)/\sqrt2$ ($n\ge4$), $\kappa_4$ at $s=(1,2,1)/\sqrt6$ ($n\ge6$), $\kappa_6$ at $s=(1,1,1)/\sqrt3$ ($n\ge6$)."

## 3. The corollary

- **Against L173's block.** In L173's labelling (classes $-a$, $\tfrac43a$, $0$ with multiplicities $4,3,59$): $P_{11}=3t_{112}=2$, $P_{12}=3t_{112}+2t_{122}+59t_{123}=2$, $P_{22}=4t_{122}+t_{222}+59t_{223}=2$. So for $i$ in the negative class, $r=(3,3,0)$ gives $12>\kappa_6=8$, and for $i$ in the positive class $r=(4,2,0)$ gives $12>8$. *Already $r=(3,1,0)$ gives $8>\kappa_4=6$.*
- **The class-level form is valid.** For every $a$ and every partner set $B\not\ni a$ of size $R$, $\sum_{b\in B}\sum_cT_{abc}\le\kappa_R$ holds at a genuine $T$. The family is permuted by $G=\prod S_{m_i}$ and is linear, so it holds at L104's average. At the averaged $T$ with $r_b$ partners in class $b$ the left side is $\sum_br_bP_{ab}$ with $P_{ab}=\sum_c(m_c-\delta_{ac}-\delta_{bc})t_{abc}$, and $r_b\le m_b-\delta_{ab}$. The note's $\mu_c$ must be read as that pair-dependent count, and the screen does so.

## 4. The ray screen

- **Encoding faithful.** KAPPA $=\{1{:}2,2{:}4,3{:}6,4{:}6,5{:}8,6{:}8\}$ uses only proved values, odd $r$ capped by the next even. Partner ranges are $0\le r_b\le\min(6,m_b-\delta_{ab})$, $2\le R\le6$. `P` divides the ordered-triple sums $\tau$ by $m_a(m_b-\delta_{ab})(m_c-\delta_{ac}-\delta_{bc})$, the right normalisation for the builder's rows. *I suspected the linearisation `coeff(x)` drops a $g_{12}^2$ term in the Cauchy–Schwarz rows. It does not: $G_{ab}^2-G_{aa}G_{bb}$ is identically affine in $g_{12}$ for all three pairs (sympy, symbolic in $\varepsilon,s$).*
- **Reproduced.** The bisection gives $1.293720$ at $n=8,10,12$, with and without the window, in 33 s. The block is headed "Screen" and scoped as one.
- **Exact value, with a proof.** Along the ray the spectrum is fixed, $\nu=a(-1,0,\tfrac43)$ with $a=\sqrt{3/28}=\sqrt{21}/14$, and only $\theta$ moves. So the threshold is an LP optimum in $(t,\theta)$ with L104's rows. Rows, $t\ge0$ and the pair and Ky Fan caps alone (no Gram rows, no window) give the same $1.293720$, and the optimum is
$$\theta^\ast=\tfrac{83}{21}a=\tfrac{83\sqrt{21}}{294}=1.2937203\ldots$$
*Certificate, exact in sympy at $n=8,10,12,20$:* $\theta-\theta^\ast=\sum_iy_i(\text{row}_i)+z\,(3P_{00}+3P_{02}-8)-c_0t_{000}-c_1t_{001}-c_2t_{022}$ identically (note's labelling, class $0$ negative, $1$ kernel, $2$ positive), with $z=\tfrac{8\sqrt{21}}{147}>0$, $c_0=\tfrac{11\sqrt{21}}{14}$, $c_2=\tfrac{8\sqrt{21}}{21}$, $c_1>0$ ($n$-dependent). **So one Ky Fan cap, $r=(3,0,3)$ at the negative class, does all the work, and $\theta\le\tfrac{83\sqrt{21}}{294}$ at this spectrum is proved, at every $n$ checked.** The primal vertex is $t_{002}=\tfrac{26}{63}$, $t_{222}=\tfrac47$, $t_{000}=t_{001}=t_{022}=0$, kernel-bearing types scaling with $n$ ($n=12$: $t_{011}=\tfrac{40}{11977}$, $t_{012}=\tfrac4{1239}$, $t_{111}=\tfrac{170}{32509}$, $t_{112}=\tfrac{106}{35931}$, $t_{122}=\tfrac4{413}$). Row (C$_0$) reads $\theta/a=12t_{002}-3t_{000}-\tfrac{16}3t_{022}-1$, so $\theta^\ast/a=12\cdot\tfrac{26}{63}-1=\tfrac{83}{21}$. The Gram and window rows are feasible at that vertex (the bisection), so $\theta^\ast$ is the full system's value on the ray.
- **The note's derived numbers.** Factor $7a/\theta^\ast=\tfrac{147}{83}=1.7711$, and $\theta^\ast/\sqrt{3/2}=1.0563$. Both correct. *With the conjectured $\kappa_3=3+\sqrt3$, $\kappa_5=4+2\sqrt2$ (not used by the note) the screen gives $1.28461$, still above $\sqrt{3/2}$.*

## 5. The route paragraph

- **Overreach.** "A class-level exclusion is no longer blocked by L173" holds for L173's witness point and fails for L173's spectrum. At that spectrum the capped system still reaches $\theta^\ast=\tfrac{83\sqrt{21}}{294}>\sqrt{3/2}$, and at the new vertex **no pair cap is tight**: $P_{00}=\tfrac{26}{21}$, $P_{02}=\tfrac{10}7$, $P_{22}=\tfrac87$. So L31's equality case, the ingredient post F76 named, has nothing to act on there. Suggested text: "The Ky Fan caps exclude L173's witness point. L173's spectrum still blocks a class-level closure, now at the vertex $\theta^\ast=\tfrac{83\sqrt{21}}{294}$, where no pair cap is tight."
- **Direction 1 (more partners) is inert at this vertex.** $R\le6$ already exhausts the non-kernel partners in this family ($3+3$ for the negative class, $4+2$ for the positive). So larger $R$ adds kernel-class partners at $P_{01}\approx P_{21}\approx0.19$–$0.20$ each, against $\kappa_{6+r}-8$. *Screen, explicit $X$ found by restarts at $n=8$:* $\kappa_7\ge8.43$, $\kappa_8\ge9.12$ ($\ge10$ at $n=10$ by the star $K_{1,4}$), so these caps cannot bind.
- **Direction 2 (other mixes)** is already in the screen for $R\le6$, which enumerates every $(r_0,r_1,r_2)$. Beyond $R=6$ it is direction 1.
- **Direction 3 is answered above.** The $n$-independence is the certificate's: $\theta^\ast$ comes from row (C$_0$) and one cap on the seven non-kernel vectors, and the kernel types carry all the $n$-dependence.
- *A suggestion, not checked:* at the vertex the seven rows are simultaneously at their $\kappa_6$ caps, so $\sum_{i<j\le7}\lVert[X_i,X_j]\rVert^2=28$. A frame cap $\max\sum_{i<j}\lVert[X_i,X_j]\rVert^2$ over orthonormal $7$-frames is linear in class variables and may sit well below $28$.
- The closing "What (c) now is" section is outside section 9 and was not reviewed.

## 6. Lean: [KyFanBracketCap.lean](../lean/HamiltonsCubic/Results/KyFanBracketCap.lean)

- **The nine statements are faithful.** Each is a slot sum $\le4\sum s^2$ over the angles it touches: triangle, star $K_{1,3}$, path $P_4$, $P_3+K_2$, $3K_2$, $\pm$ pair with an edge at $a$, $\pm$ pair with a disjoint edge, $P_3$ with a loop at the centre, edge with both endpoint loops. All are true (screen maxima $4,4,2+\sqrt2,3,2,2+\sqrt2,2,2+\sqrt3,3$). The variables are universally quantified reals, so sign-switching covers every signed tree. `l173_row_exceeds` is the corollary's arithmetic.
- **Coverage REFUTED.** The docstring's "one theorem per three-slot configuration up to relabelling" and the note's "one per configuration" are false. Missing, up to relabelling and sign-switching (screen $\lambda_{\max}$ in brackets):
  1. the unbalanced triangle $(a+b)^2+(a+c)^2+(b-c)^2$ ($3$), which no substitution reduces to `slot3_triangle`,
  2. $P_3$ with a loop at a leaf, $(a+b)^2+(b+c)^2+a^2$ ($3.247$),
  3. $2K_2$ with a loop, $(a+b)^2+(c+d)^2+a^2$ ($2.618$),
  4. an edge with a loop at one end and one off it, $(a+b)^2+a^2+c^2$ ($2.618$),
  5. an edge with two loops off it ($2$),
  6. three loops ($1$),
  7. a $\pm$ pair with a loop on it, $(a+b)^2+(a-b)^2+a^2$ ($3$),
  8. a $\pm$ pair with a loop off it ($2$).
- **Repair.** Either add the eight (each closes by the same `nlinarith` pattern), or replace the list by the three facts of the repair in claim 2: $(a\pm b)^2\le(|a|+|b|)^2$, the three-edge unsigned bound, and the Weyl splits for loops and $\pm$ pairs. The latter is the structure a reader can check. Not compiled here (statement fidelity only).

## Screens run

All in the session scratchpad, seconds each, reported as screens: the LP of claim 4 in L104 variables with $\theta$ free; the exact vertex and dual solve in sympy; the Cauchy–Schwarz affinity check; the slot enumeration on six vertices for $k\le3$; restarts for lower bounds on $\kappa_7,\kappa_8$ at $n=8,9,10$. The exact certificate of claim 4 is an identity checked in exact arithmetic and stands as a proof at the $n$ checked.
