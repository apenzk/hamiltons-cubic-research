# Review r1909: sp2_unique against I117's k = 2 claim

Log: [agent_logs/r1909-sp2-unique.log](../agent_logs/r1909-sp2-unique.log). Footing: analysis only. The one Lean call was the build of [Sp2Torus.lean](../lean/HamiltonsCubic/Results/Sp2Torus.lean) and `#print axioms`, run in the background.

| # | item | verdict |
|---|---|---|
| 1 | `sp2_unique` states the claim | CONFIRMED |
| 2 | the prose chain, and the Lean proof follows it | CONFIRMED |
| 3 | axioms | CONFIRMED: propext, Classical.choice, Quot.sound |
| 4 | already on the record | CONFIRMED new: L279 to L281 do not cover $\mathfrak{so}(5)$ |

## 1. The statement

- Hypotheses: `TorusRows P Q u a` over `Fin 2`, `∀ i, 0 < u i`, `0 < P 0 1`, `0 < Q 0 1`. A positive-definite torus-invariant idempotent supplies exactly these: positivity of each root-plane weight is necessary for positive definiteness (the weight is the operator's scalar on that plane), and at $k=2$ the only off-diagonal entries are $P_{01}=P_{10}$, $Q_{01}=Q_{10}$, the second pair by `symP`, `symQ`. The Cartan block's positivity is not assumed, so the hypotheses are weaker than positive definiteness, which only strengthens the result.
- Conclusion: `u i = 1/3` for both $i$, `P 0 1 = 1/3`, `Q 0 1 = 1/3`. With $a_i=2u_i^2+\tfrac12(p^2+q^2)=\tfrac29+\tfrac19=\tfrac13$ from `ha`, every weight of the family is $\tfrac13$.
- The reading "the only positive-definite torus-invariant idempotent of $\mathfrak{sp}(2)$ is $I/3$" is fair on two conditions carried by prose, both on the record: that `TorusRows` is $C^\#C=C$ on the torus family (r1888 and r1889, with r1893 and r1894 for the displayed system), and that the uniform point is $I/3$ (the reading L285 already carries). At that point the Cartan block $A=\sum_\alpha w_\alpha^2\alpha\alpha^{\mathsf T}$ has off-diagonal entry $q^2-p^2=0$ and diagonal $\tfrac13$, so $C=I/3$ in full.
- The Lean result covers every solution with positive weights, a slightly larger set than the positive-definite idempotents, so "only" holds a fortiori.

## 2. The chain, derived

- **Empty third-index sums.** At $k=2$, $(i,j)=(0,1)$: $\sum_l(p_{0l}p_{1l}+q_{0l}q_{1l})$ has $l=0$ term $p_{00}p_{10}+q_{00}q_{10}=0$ and $l=1$ term $p_{01}p_{11}+q_{01}q_{11}=0$ by the zero diagonal. The $q$-row sum vanishes the same way. Confirmed.
- **Rows.** With $m=\tfrac12(a_0+a_1)$: $p(1-m+\tfrac12(q^2-p^2))=(u_0+u_1)q$ and $q(1-m-\tfrac12(q^2-p^2))=(u_0+u_1)p$.
- **Difference.** $(p-q)(1-m)+\tfrac12(q^2-p^2)(p+q)+(u_0+u_1)(p-q)=0$, and $\tfrac12(q^2-p^2)(p+q)=-\tfrac12(p-q)(p+q)^2$, giving $(p-q)\big(1-m+u_0+u_1-\tfrac12(p+q)^2\big)=0$. Confirmed. The Lean `hdiff` is `linear_combination hp - hq`, the same identity.
- **Long rows.** $u_i(1-2a_i)=pq>0$ with $u_i>0$ gives $a_i<\tfrac12$, so $m<\tfrac12$. From $a_0=2u_0^2+\tfrac12(p^2+q^2)<\tfrac12$: $\tfrac12(p^2+q^2)<\tfrac12-2u_0^2$. From $pq=u_0(1-2a_0)$ and $a_0>0$: $pq<u_0$. Confirmed.
- **Bracket.** $\tfrac12(p+q)^2=\tfrac12(p^2+q^2)+pq<\tfrac12-2u_0^2+u_0$, so the bracket exceeds $1-\tfrac12+u_0+u_1-\tfrac12+2u_0^2-u_0=u_1+2u_0^2>0$. Confirmed. Lean's `hB` asserts only positivity, by `nlinarith` from the same facts (`ha0lt`, `ha1lt`, `hpq`, `hu0`, `hu1`, the rows).
- **L285.** With $p=q$ the Lean builds `Q = P`, `Pᵀ = P`, zero diagonal, off-diagonal positivity, and passes `h.ha`, `h.hlong`, `h.hp` to `equal_weight_torus`, whose conclusion $\tfrac1{k+1}$ at $k=2$ is $\tfrac13$ after `norm_num`. Confirmed: the proof follows the prose link for link.
- The closing italic sentence (from $k=3$ the $d$-rows carry $(D^2)_{ij}\ne0$) is a scope remark and is consistent: at $k\ge3$ the third-index sums are nonzero and the difference no longer factors through $p-q$ alone.

## 3. Axioms

`sp2_unique` depends on axioms: [propext, Classical.choice, Quot.sound], the standard three, with no sorryAx. The build of `HamiltonsCubic.Results.Sp2Torus` completed with only long-line lint warnings (in SpTorusBlocks.lean line 80).

## 4. The record

- L279 to L281 ([second-order.md](../findings/second-order.md)) are statements of J1 and H (a cubic-form bound $F(C)\le\kappa\lVert C\rVert^3$) on $\mathfrak{so}(2m+1)$'s torus slice for $m\ge7$, i.e. odd $n\ge15$. $\mathfrak{so}(5)$ is $m=2$, outside their range, and they bound $F$ rather than classify idempotents. They do not cover this result.
- L271 and L261 classify the $Q=0$ sector of $\mathfrak{so}(2m)$'s torus system, a different algebra family.
- Searching findings/ for $\mathfrak{sp}(2)$, $\mathfrak{so}(5)$ and the uniqueness of $I/3$ on a torus family finds nothing that states this result. It is new to the record. Since $\mathfrak{sp}(2)\cong\mathfrak{so}(5)$ share a maximal torus and root system $B_2=C_2$, the result also settles U on $\mathfrak{so}(5)$'s torus family, which the entry may say.
