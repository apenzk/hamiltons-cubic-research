# Review r1153: kappa_r <= r + 2, the uniform Ky Fan bracket cap

Brief: [2026-09-25-kappa-r-gate2-brief.md](2026-09-25-kappa-r-gate2-brief.md). Claim at 9b6a0ad7 in [second-order.md](../findings/second-order.md#L236).

**Verdict: the argument is correct. All four items CONFIRMED, with one strengthening of the tightness remark and one wording note.**

## Item 1, the slot spectrum: CONFIRMED

- The prose matches `slotμ` and `pairMu` in [L240SlotBasis.lean](../lean/HamiltonsCubic/Results/L240SlotBasis.lean#L603): a cross-block index pair carries $(s_c+s_d)^2$ or $(s_c-s_d)^2$, each on two slots per block pair, a block-free index pair carries $s_a^2$ (two per block and free index, one per side $p_a,q_a$), and Cartan and free-free pairs carry $0$.
- Trace check by hand: $\sum_{a<b}4(s_a^2+s_b^2)+2(n-2k)\sum_a s_a^2=(4k-4)+(2n-4k)=2(n-2)$, which is $\mathop{\mathrm{tr}}(-\mathrm{ad}_X^2)$ for unit $X$ under $\langle X,Y\rangle=-\tfrac12\mathop{\mathrm{tr}}XY$.
- Screen (seconds, $n=5,6,7$, random normal forms): the listed values agree with the eigenvalues of the matrix of $-\mathrm{ad}_X^2$ on the $\varphi_{ij}$ basis, and the remainder is zero.
- Wording note: the prose calls the block-free slots "kernel slots", following the Lean comment's naming, although their eigenvalue is $s_c^2$ and not $0$. The argument is unaffected. Calling them "block-free slots" would read more clearly.

## Item 2, the split: CONFIRMED

- On a block pair $(u,v)$ let $P,M\le2$ be the chosen slots of type $(s_u+s_v)^2$ and $(s_u-s_v)^2$. Matching $\min(P,M)$ of each type leaves $e=\lvert P-M\rvert\le2$.
- A matched pair sums to $(s_u+s_v)^2+(s_u-s_v)^2=2(s_u^2+s_v^2)=2(a_u^2+a_v^2)$ as a polynomial identity, so it holds for every sign pattern.
- Each leftover is one of $(s_u\pm s_v)^2$, and both are at most $(a_u+a_v)^2$.

## Item 3, the load: CONFIRMED

- The degree-weighted inequality is AM-GM, $2a_ua_v\le t a_u^2+a_v^2/t$ with $t=d_v/d_u$. Every endpoint of an edge of $G$ has degree at least $1$, so $t$ is defined. Summing over the $E$ edges with multiplicity gives block $u$ the coefficient $d_u+\tfrac1{d_u}\sum_v m_{uv}d_v$.
- $d_v\le(E-d_u)+m_{uv}$: an edge at $v$ is either one of the $m_{uv}$ edges $uv$ or an edge avoiding $u$, and there are $E-d_u$ of the latter.
- $\sum_v m_{uv}^2\le2\sum_v m_{uv}=2d_u$, since $m_{uv}\le2$.
- Hence $\sum_v m_{uv}d_v\le d_u(E-d_u)+2d_u$, and the load is at most $d_u+(E-d_u)+2=E+2$.
- No double count: block $u$'s opposite-sign slots, its block-free slots and the $E$ leftover slots are disjoint subsets of the chosen $r$, and each matched pair contributes coefficient $2$ to $a_u^2$ through exactly $2$ slots. So the coefficient of $a_u^2$ is at most $r-E+E+2=r+2$. A block outside $G$ has coefficient at most $r$. Summing with $\sum a_c^2=1$ gives $\kappa_r(X)\le r+2$.

## Item 4, truth and tightness: CONFIRMED, tightness understated

- The bound holds at every $r$ and $n$ by items 1 to 3. A counterexample screen (random normal forms, $n=3,\dots,12$, $r\le14$, seconds) found no set of $r$ slots above $r+2$. The largest excess is $0$ at $r=2$ and about $-0.001$ at $r=4,6$.
- The doubled triangle at $r=6$, equal $s$, gives $6\cdot\tfrac43=8$ with every load $4+4=8$.
- **Strengthening.** The doubled star with centre weight $k$ and $k$ leaves of weight $1$ (same signs, normalised) gives, at $r=2k$ and $n\ge2k+2$, the sum $2k(k+1)^2/(k^2+k)=2k+2$. Its loads are $2k+2$ at the centre and $2+2k$ at each leaf, and AM-GM is tight because $d_va_u=d_ua_v$. So $\kappa_{2k}=2k+2$ at every $k$ once $n\ge2k+2$, and the tightness remark "at $r=2,4,6$" is the first three cases of an exact value at every even $r$. The screen reproduces $4,6,\dots,14$ for $k=1,\dots,6$.
- At odd $r$ the bound is strict in the screen ($\kappa_1=2<3$, excess about $-0.27$ at $r=3$). The claim asserts nothing there.
- At small $n$ the equality configurations need room: the doubled star at $r=2k$ uses $k+1$ blocks and the doubled triangle three, so the recorded values $\kappa_4=6$, $\kappa_6=8$ hold for $n\ge6$ (at $r=6$ via the triangle).

## Corrections

- None to the argument.
- Suggested addition: $\kappa_{2k}=2k+2$ exactly for $n\ge2k+2$, attained by the doubled $k$-star.
- Suggested wording: "block-free slots" for "kernel slots".
