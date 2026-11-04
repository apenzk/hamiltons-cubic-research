# Review r1493: the upper bound on the tangent Weyl dimension in Lean, dim 𝒲₁₂ ∩ T_uS = 1637 in the bivector model, and r1492's gaps repaired

Gate 2 review of commit ce5bcfbd: the new [Results/L17WeylUpper.lean](../lean/HamiltonsCubic/Results/L17WeylUpper.lean) (`coords_phi_apply`, `sum_coords_phi`, `opOf`, `inner_opOf`, `opOf_mem`, `compOf_opOf`, `pairF`, `pairF_swap`, `pairF_lt`, `pairF_gt`, `T4`, `isCurv_T4`, `pairF_mul_eq_zero`, `ric_T4`, `alt4_T4`, `dlt`, `dlt_comm`, `KN`, `isCurv_KN`, `alt4_KN`, `ric_KN`, `ext_ep`, `symSub_eq_sum`, `finrank_symSub_le`, `ric_opOf`, `consMap_uOp`, `mem_range_T4`, `mem_range_KN`, `consMap_range`, `consMap_of_weylT`, `finrank_weylT_le`, `finrank_weylT_12_eq`), milestone 5 of [the Weyl-dimension plan](2026-09-26-lean-weyl-dimension-plan.md), the record edits for it ([lean/INDEX.md](../lean/INDEX.md) line 480, [INDEX-results.md](../findings/INDEX-results.md) line 32, [route-a.md](../findings/route-a.md) line 93, the plan's milestone 5 and "What it does not give"), and the repairs of [r1492](REVIEW_r1492.md)'s gaps A-1 and E-1. One reviewer. Analysis-only rule inherited: the only compute was the module build (8771 jobs, "Build completed successfully") and `scripts/misc/axiom_audit.py --only L17WeylUpper`.

| item | claim | verdict |
| --- | --- | --- |
| A | `finrank_weylT_12_eq` states the record's $\dim\mathcal W_{12}\cap T_uS=1637$ in the bivector model, and the record edits say which model the count lives in | CONFIRMED |
| B | `compOf_opOf`, `alt4_T4`, `ric_KN`, `alt4_KN`, `mem_range_KN`, `consMap_uOp`, `consMap_range`, `symSub_eq_sum` and `finrank_weylT_le` are sound, with no hypothesis missing | CONFIRMED |
| C | $\binom{67}2-\big(\binom{12}4+\binom{13}2+1\big)=2211-574=1637$ | CONFIRMED |
| D | every theorem of L17WeylUpper.lean rests on `propext`, `Classical.choice`, `Quot.sound` only | CONFIRMED |
| E | no edited sentence overstates, and r1492's A-1 and E-1 are repaired | CONFIRMED WITH GAP |
| F | no em dash, no clause-splicing semicolon, no backticks in link text, no hard-wrapped markdown prose | CONFIRMED |

**Summary: the Lean is sound and on the standard three axioms, the constraint map is onto its target, and with L17WeylDim.lean's lower bound `finrank_weylT_12_eq` proves $\dim$ `weylT 12` $=1637$. r1492's A-1 and E-1 are repaired. One small gap: lean/INDEX.md line 480 says `admissible_opB` gives the `IsWeyl2`-to-`weylT` identification "in one direction", where it gives inclusion into `Admissible`, which drops Ricci-flatness. CONFIRMED WITH GAP.**

## A. Fidelity

- **The statement.** `finrank_weylT_12_eq : finrank ℝ (weylT 12) = 1637` (L17WeylUpper.lean line 365). `weylT n` is L17WeylDim.lean's bivector-model space (symmetric $H$ on `Biv n`, `alt4 (compOf H) = 0`, `ric H = 0`, $\mathop{\mathrm{tr}}(H\circ u)=0$), which r1492 matched against `IsWeyl2` and tangency term for term through `compOf_opB`. The theorem is the record's "$\dim\mathcal W_{12}\cap T_uS=1637$" read in that model. **Faithful.**
- **The model qualifier in the record.** lean/INDEX.md line 480 introduces "the bivector model `weylT` of $\mathcal W_n\cap T_uS$" with its four conditions spelled out before the counts, and names the identification with `IsWeyl2` as owed. route-a.md line 93 says "in the bivector model of $\mathcal W_{12}\cap T_uS$ (symmetric operators on $\Lambda^2\mathbb R^{12}$ with $\mathrm{Alt}=0$, $\mathrm{Ric}=0$ and orthogonal to $u$)". INDEX-results.md line 32 says "at $n=12$ in the bivector model" and points to lean/INDEX.md for the owed identification. The module header (line 10) says "in the bivector model". **Each record line places the count in the model.**
- **Module docstrings.** Line 343 calls the tangent Weyl operators "exactly the symmetric operators the constraint map kills". `consMap_of_weylT` proves one direction and L17WeylDim.lean's `mem_weylT_of_consMap` the other, so the sentence is true of the pair. Line 364's "the record's dimension" sits under the header's model qualifier. Nothing to repair.

## B. Soundness

- **`coords_phi_apply`, `sum_coords_phi`.** $\mathrm{coords}(\varphi_{ij})_p=[i=p_1\wedge j=p_2]-[j=p_1\wedge i=p_2]$ on pairs $p_1<p_2$. For antisymmetric $f$, $\sum_p\mathrm{coords}(\varphi_{kl})_p f(p)$ is $f(k,l)$ from $p=(k,l)$ when $k<l$, $-f(l,k)=f(k,l)$ from $p=(l,k)$ when $k>l$, and $0=f(k,k)$ when $k=l$. The three branches of the proof are these cases, and `hf` is used in the last two. **Sound.**
- **`compOf_opOf`.** `inner_opOf` gives $\langle x,\mathrm{opOf}(T)y\rangle=\sum_{p,q}T(q,p)\,x_py_q$. With $x=\mathrm{coords}(\varphi_{kl})$, $y=\mathrm{coords}(\varphi_{ij})$, the $q$-sum reads off $T(i,j,p)$ by `sum_coords_phi` on $f(a,b)=T(a,b,p)$, antisymmetric by `hT.left`, and the $p$-sum reads off $T(i,j,k,l)$ on $f(a,b)=T(i,j,a,b)$, antisymmetric by `hT.right`. The $\pm$ signs are carried by `sum_coords_phi` and need exactly the two antisymmetries. `hT.pair` is unused here and used in `opOf_mem` for the symmetry of $\mathrm{opOf}(T)$. **Sound, no hypothesis missing.**
- **`ric_T4`.** $T4_{xkyk}=\mathrm{pairF}_{ab}(x,k)\mathrm{pairF}_{cd}(y,k)+\mathrm{pairF}_{cd}(x,k)\mathrm{pairF}_{ab}(y,k)$, and each product needs $k\in\{a,b\}\cap\{c,d\}=\varnothing$ (`pairF_mul_eq_zero`, the four inequalities). The sum $\sum_kT_{akbk}$ is `ric`'s contraction (L17WeylDim.lean `ric`, `compOf H a k b k`), linked by `ric_opOf`. **Sound.**
- **`alt4_T4`.** `alt4` is $\tfrac13(T_{ijkl}+T_{iklj}+T_{iljk})$. At $i<j<k<l$, $a<b<c<d$, the six products are, after `pairF_lt` and `pairF_gt` (the two reversed pairs are $(l,j)$ in the second term): $[ij=ab][kl=cd]$, $[ij=cd][kl=ab]$, $-[ik=ab][jl=cd]$, $-[ik=cd][jl=ab]$, $[il=ab][jk=cd]$, $[il=cd][jk=ab]$. By hand: the second needs $j=d<a=k$, the third $k=b<c=j$, the fourth $j=a<c=i$, the fifth $l=b<c=j$, the sixth $j=a<c=i$, each contradicting $i<j<k<l$. The rewrites in lines 142 to 143 match these twelve factors and `t2` to `t6` discharge exactly these five by `order`. The survivor is $\tfrac13[ijkl=abcd]$. **Sound.**
- **`isCurv_KN`, `alt4_KN`, `ric_KN`.** $KN(h)_{ijkl}=h_{ik}\delta_{jl}+h_{jl}\delta_{ik}-h_{il}\delta_{jk}-h_{jk}\delta_{il}$, the standard $h\odot g$. The three cyclic terms of `alt4` cancel in six pairs using only $h$ and $\delta$ symmetric (checked by hand), which is what `hh` supplies. $\sum_kKN_{akbk}=n\,h_{ab}+\mathop{\mathrm{tr}}(h)\delta_{ab}-h_{ab}-h_{ab}$, so $(n-2)h_{ab}+\mathop{\mathrm{tr}}(h)\delta_{ab}$, matching `ric`'s single contraction, and it needs no symmetry, which is why `hh` is omitted. **Sound.**
- **`mem_range_KN`.** $m_{ab}=y(s(a,b))$, $\tau=\mathop{\mathrm{tr}}m/(2n-2)$, $h=(m-\tau g)/(n-2)$. Then $\mathop{\mathrm{tr}}h=(\mathop{\mathrm{tr}}m-n\tau)/(n-2)=\tau$ because $\mathop{\mathrm{tr}}m=(2n-2)\tau$, and $(n-2)h+\tau g=m$. At the representative $(p,q)=$ `Quot.out` $s'$, $m_{pq}=y(s(p,q))=y(s')$ by `Quot.out_eq`, so the Ricci block is $y$ at every $s'$. $n\ge4$ keeps $n-2$ and $2n-2$ nonzero. The Alt block is $0$ by `alt4_KN`. **Sound.**
- **`mem_range_T4`.** $3\,\mathrm{opOf}(T4_{e_0e_1e_2e_3})$ with $e$ the sorted embedding of $s$ has Alt $=\mathbf 1_s$ on $Q_4$ (an increasing $s'$ with the same four entries has the same range, hence $s'=s$) and Ricci $0$. The trace coordinate is left free and removed in `consMap_range`. **Sound.**
- **`consMap_uOp`.** Alt and Ricci of $u$ vanish because $u=\mathrm{opB}(u_2)$ (`opB_u2`) with $u_2$ Weyl (`Wc_weyl`), through `alt4_opB_eq_zero` and `hW.ric` after `compOf_opB`. The trace is $\mathop{\mathrm{tr}}(u\circ u)=\sum_\gamma\lambda_\gamma\langle v_\gamma,uv_\gamma\rangle=\sum_\gamma\lambda_\gamma^2$ by `trace_comp_rankSum` and orthonormality of `vec`, and $\lambda=(2,-1,-1,0,0,0)/\sqrt6$ gives $\tfrac46+\tfrac16+\tfrac16=1$. **Sound.**
- **`consMap_range`.** $(\mathbf 1_s,0,0)$ and $(0,y,0)$ are the `mem_range_T4` and `mem_range_KN` images less $z$ times $(0,0,1)$, and $(x,y,z)=\sum_sx_s(\mathbf 1_s,0,0)+(0,y,0)+z(0,0,1)$. **Every target reached.**
- **`symSub_eq_sum`, `finrank_symSub_le`.** A symmetric $H$ equals $\sum_sc_s\,\mathrm{symOp}(s)$ with $c_s=\langle e_p,He_q\rangle/(2\text{ or }1)$: by `entry_symOp` only $s=s(a,b)$ contributes at entry $(a,b)$, with factor $2$ on the diagonal and $1$ off it, and a swapped representative is handled by `hH`. So the $\binom{N+1}2$ vectors span `symSub`. **Sound.**
- **`finrank_weylT_le`.** Rank-nullity on $C=\mathrm{consMap}\circ\mathrm{symSub}.\mathrm{subtype}$ with $\mathop{\mathrm{range}}C=\top$ gives $\dim\mathrm{symSub}=(\binom n4+\binom{n+1}2+1)+\dim\ker C$. `weylT` $\le$ the image of $\ker C$ because every $H\in$ `weylT` is symmetric and `consMap_of_weylT` kills it. With `finrank_symSub_le`, `omega` closes. `hn` enters through `consMap_range` only. **Sound.**
- **Hypotheses.** `hn : 4 ≤ n` is needed by `consMap_uOp` (`vec_orthonormal`, `Wc_weyl`) and `mem_range_KN` ($n\ne2$). `alt4_T4` uses all six orderings. None missing. **CONFIRMED.**

## C. Arithmetic

$\binom{67}2=2211$ (with $N=66$ by `card_pairs12`), $\binom{12}4=495$, $\binom{13}2=78$, $495+78+1=574$, $2211-574=1637$. `finrank_weylT_12_eq` combines `finrank_weylT_12` ($\ge$) and `finrank_weylT_le` at $n=12$ ($\le$) by `norm_num [Nat.choose]` and `omega`. As a paper check, the classical $\dim\mathcal W_n=\tfrac{n(n+1)(n+2)(n-3)}{12}$ is $1638$ at $n=12$, less $1$ for tangency. **CONFIRMED.**

## D. Axioms

`python3 scripts/misc/axiom_audit.py --only L17WeylUpper`: "auditing 27 declarations across 1 files, 27/27 clean, resting on the standard three alone". No `sorry` and no `native_decide` in the file (grep). **CONFIRMED.**

## E. Record accuracy

- **INDEX-results.md line 32.** "[dimension at least $1451$] of [$1637$] at $n=12$ in the bivector model, and lean/INDEX.md names that model's identification with the layer's Weyl operators as owed." Exact.
- **route-a.md line 93.** Attributes the codimension to `L17_codim` and `L17_codim_12`, the $1637$ to `finrank_weylT_12` and `finrank_weylT_12_eq` "in the bivector model of $\mathcal W_{12}\cap T_uS$", and the $1451$ to `L17_dim_12`. Exact. Its earlier sentence "Equality needs those conditions independent ... which is not shown" is about the codimension $186$, still unproved, and stays true. The line carries the model qualifier but does not itself say the identification is owed, while the commit body says both lean/INDEX.md and route-a.md "name the identification as owed". r1492's A-1 accepted the qualifier alone as a repair, so this is an inaccuracy of the commit message and not of the record.
- **The plan.** Milestone 5 marked proved with the four right theorem names. "What it does not give" names the `opB` identification and the independence of the $186$ conditions. Exact.
- **lean/INDEX.md line 480.** The four conditions of `weylT`, the three preimage families, `finrank_symSub_le`, `finrank_weylT_12_eq`, and "**Owed**: the identification of `weylT` with the layer's `IsWeyl2` tangent operators through `opB`" are exact. Gap E-1 below.

**r1492's gaps.**

- **A-1, repaired.** Every record line that states the count places it in the bivector model (item A), and lean/INDEX.md names the identification as owed.
- **E-1, repaired.** route-a.md line 93 now credits $1637$ to `finrank_weylT_12` and `finrank_weylT_12_eq` and $1451$ to `L17_dim_12`.

**Gap E-1.** lean/INDEX.md line 480 ends "the identification of `weylT` with the layer's `IsWeyl2` tangent operators through `opB`, which `admissible_opB` gives in one direction only". `admissible_opB` (L17Converse.lean line 199) sends an `IsWeyl2` tangent $H$ to `Admissible (opB H)`, the class that drops Ricci-flatness, so it is not the inclusion into `weylT`. That inclusion needs `hH.ric` through `compOf_opB` as well, the step `consMap_uOp` performs for $u_2$ at lines 239 to 240, and no lemma states it. The owed item is unaffected. Repair: "which `admissible_opB` gives into the larger class `Admissible`", or state the inclusion into `weylT` as a lemma.

## F. Style

- No em dash in any added line of the commit (grep count $0$). "Kulkarni–Nomizu" uses an en dash in a name.
- No backticks inside markdown link text in any added line (grep count $0$).
- The semicolons in lean/INDEX.md line 480's new sentence separate items of a list whose items carry commas, the convention r1491 and r1492 accepted.
- The edited markdown lines (route-a.md 93, lean/INDEX.md 480, INDEX-results.md 32, the plan's milestone 5 item and "What it does not give" paragraph) are each one unwrapped line. **CONFIRMED.**

## Verdict

**CONFIRMED WITH GAP.** The Lean is sound: every curvature-symmetric tensor is `compOf` of `opOf`, the $\Lambda^4$ preimages $(e_a\wedge e_b)\odot(e_c\wedge e_d)$ hit the Alt basis with no Ricci, the Kulkarni–Nomizu products with $\tau=\mathop{\mathrm{tr}}m/(2n-2)$ hit every Ricci target, $u$ hits the trace, the `symOp` span the symmetric operators, and rank-nullity with range $\top$ gives the upper bound, so `finrank_weylT_12_eq` proves $\dim$ `weylT 12` $=1637$ on the standard three axioms. r1492's A-1 and E-1 are repaired. Open: E-1, lean/INDEX.md line 480 says `admissible_opB` gives one direction of the `weylT` identification, where it gives inclusion into `Admissible` only.
