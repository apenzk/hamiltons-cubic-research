# Lean build plan: the dimension of the tangent Weyl space, for L17's count

**Goal.** [route-a.md](../findings/route-a.md), Lemma L17, reads its codimension bound $\operatorname{codim}\{F=0\}\le186$ ([L17Codim.lean](../lean/HamiltonsCubic/Results/L17Codim.lean)'s `L17_codim_12`) as $\dim\{F=0\}\ge1451$ of $\dim\mathcal W_{12}\cap T_uS=1637$. The Lean statement is the lower bound $\dim\mathcal W_n\cap T_uS\ge\tfrac{N(N+1)}2-\binom n4-\tfrac{n(n+1)}2-1$ with $N=\binom n2$, which is $1637$ at $n=12$, and with `L17_codim` it gives $\dim(\{F=0\}\cap\mathcal W_{12}\cap T_uS)\ge1451$.

**Route.** Rank-nullity on a constraint map, with no surjectivity needed for the lower bound. $\mathcal W_n$ is the space of symmetric operators $H$ on $\Lambda^2\mathbb R^n$ with $\mathrm{Alt}(H)=0$ and $\mathrm{Ric}(H)=0$.

## Milestones

1. **The symmetric operators.** The family $s\mapsto e_p\otimes e_q+e_q\otimes e_p$ over $s=\{p,q\}\in\mathrm{Sym}^2(\mathrm{Pairs}\,n)$ is linearly independent in the symmetric operators, so their dimension is at least $\binom{N+1}2=\tfrac{N(N+1)}2$. **Proved** as `finrank_symSub_ge` in [Results/L17WeylDim.lean](../lean/HamiltonsCubic/Results/L17WeylDim.lean).
2. **Alternation.** For symmetric $H$, $\mathrm{Alt}(H)_{ijkl}$ changes sign under every transposition of the four indices, so it vanishes everywhere once it vanishes on strictly increasing indices. **Proved** as `altTup_eq_zero`, through `altTup_perm` and `Equiv.Perm.swap_induction_on`.
3. **The constraint map.** $H\mapsto\big((\mathrm{Alt}(H)_{e(0)e(1)e(2)e(3)})_{s},(\mathrm{Ric}(H)_{s'})_{s'},\operatorname{tr}(Hu)\big)$ over 4-subsets $s$ with $e$ their increasing enumeration and $s'\in\mathrm{Sym}^2(\mathrm{Fin}\,n)$, into a space of dimension $\binom n4+\tfrac{n(n+1)}2+1$. Its kernel on the symmetric operators lies in $\mathcal W_n\cap T_uS$. **Proved** as `mem_weylT_of_consMap`, with `finrank_consTarget`.
4. **The count.** $\dim\mathcal W_n\cap T_uS\ge\tfrac{N(N+1)}2-\binom n4-\tfrac{n(n+1)}2-1$, which is $1637$ at $n=12$, and $\dim(\{F=0\}\cap\mathcal W_{12}\cap T_uS)\ge1451$. **Proved** as `finrank_weylT_ge`, `finrank_weylT_12` and `L17_dim_12`.
5. **The upper bound.** The constraint map is onto its target: $(e_a\wedge e_b)\odot(e_c\wedge e_d)$ for $a<b<c<d$ hits the $\Lambda^4$ basis, the Kulkarni–Nomizu product $h\odot g$ with $\mathrm{Ric}=(n-2)h+\operatorname{tr}(h)g$ hits every Ricci target, and $u$ hits the trace. With the symmetric operators spanned by the $\mathrm{Sym}^2$ family, $\dim\mathcal W_{12}\cap T_uS=1637$. **Proved** in [Results/L17WeylUpper.lean](../lean/HamiltonsCubic/Results/L17WeylUpper.lean) as `consMap_range`, `finrank_symSub_le`, `finrank_weylT_le` and `finrank_weylT_12_eq`.
6. **The identification.** `opB` is a linear equivalence from the layer's operators on skew matrices onto operators on $\Lambda^2\mathbb R^n$, and it carries the tangent `IsWeyl2` operators exactly onto `weylT`. **Proved** in [Results/L17WeylIdent.lean](../lean/HamiltonsCubic/Results/L17WeylIdent.lean) as `opBEquiv`, `mem_weylT2` and `finrank_weylT2_12`.

**Bound.** One to two sessions. Milestone 2 is the only argument, the rest is bookkeeping.

**What it does not give.** The independence of the $186$ conditions, which would make the codimension exact.
