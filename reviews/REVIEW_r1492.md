# Review r1492: the dimension of the tangent Weyl space in Lean, dim 𝒲₁₂ ∩ T_uS at least 1637 and L17's dim {F=0} at least 1451, and r1491's gaps repaired

Gate 2 review of commit a949ce48: the new [Results/L17WeylDim.lean](../lean/HamiltonsCubic/Results/L17WeylDim.lean) (`IsCurv`, `alt4_swap01`, `alt4_swap12`, `alt4_swap23`, `altTup`, `altTup_swap`, `altTup_perm`, `altTup_eq_zero`, `coords_neg`, `isCurv_compOf`, `compOf_add`, `compOf_smul`, `ric`, `ric_symm`, `symSub`, `weylT`, `admissible_of_weylT`, `ep`, `inner_ep`, `E1`, `symOp`, `symOp_mem`, `entry_symOp`, `finrank_symSub_ge`, `Q4`, `consMap`, `finrank_consTarget`, `mem_weylT_of_consMap`, `finrank_weylT_ge`, `card_pairs12`, `finrank_weylT_12`, `L17_dim_12`), the build of [the Weyl-dimension plan](2026-09-26-lean-weyl-dimension-plan.md), the record edits for it ([lean/INDEX.md](../lean/INDEX.md) line 480, [INDEX-results.md](../findings/INDEX-results.md) line 32, [route-a.md](../findings/route-a.md) line 93), and the repairs of [r1491](REVIEW_r1491.md)'s gaps E-1, E-2 and F-1. One reviewer. Analysis-only rule inherited: the only compute was the module build (8729 jobs, no error, no warning in L17WeylDim.lean, the replayed warnings all upstream in Base/WeylReal.lean and similar) and `scripts/misc/axiom_audit.py --only L17WeylDim`.

| item | claim | verdict |
| --- | --- | --- |
| A | `weylT n` is the record's $\mathcal W_n\cap T_uS$, and `L17_dim_12` states the record's "dimension at least $1451$" | CONFIRMED WITH GAP |
| B | the alternation argument, the independence of `symOp`, the target dimension $\binom n4+\binom{n+1}2+1$ and the rank-nullity step are sound | CONFIRMED |
| C | $\binom{67}2=2211$, $\binom{12}4=495$, $\binom{13}2=78$, $2211-495-78-1=1637$, $1637-186=1451$ | CONFIRMED |
| D | every theorem of L17WeylDim.lean rests on `propext`, `Classical.choice`, `Quot.sound` only | CONFIRMED |
| E | no edited sentence overstates, and the unproved upper bound $\dim\mathcal W_{12}\cap T_uS\le1637$ is said wherever it matters, with r1491's E-1 and E-2 repaired | CONFIRMED WITH GAP |
| F | no em dash, no clause-splicing semicolon, no backticks in link text, no hard-wrapped markdown prose, r1491's F-1 repaired | CONFIRMED |

**Summary: the Lean is sound and on the standard three axioms, the count is right, and `L17_dim_12` proves the record's $\dim\{F=0\}\ge1451$ for the bivector model's tangent Weyl space. All three r1491 gaps are repaired. Two small gaps remain: `weylT` is identified with the layer's `IsWeyl2` space on paper only, a bridge the record lines drop, and route-a.md line 93 attributes the $1637$ to `L17_dim_12` where it is `finrank_weylT_12`. CONFIRMED WITH GAP.**

## A. Fidelity

The definition (L17WeylDim.lean lines 154 to 155): `weylT n` is the set of $H:\Lambda^2\mathbb R^n\to\Lambda^2\mathbb R^n$ (the Euclidean model `Biv n` on pairs $i<j$) with $H$ symmetric, `alt4 (compOf H) = 0`, `ric H = 0` where `ric H a b` $=\sum_k$ `compOf H a k b k`, and $\mathop{\mathrm{tr}}(H\circ u)=0$.

- **Against the layer's `IsWeyl2`** (Base/Bivectors2.lean line 352). Its three clauses are self-adjointness on $\Lambda^2$, first Bianchi $\langle R\varphi_{ij},\varphi_{kl}\rangle+\langle R\varphi_{ik},\varphi_{lj}\rangle+\langle R\varphi_{il},\varphi_{jk}\rangle=0$, and Ricci-flatness $\sum_c\langle R\varphi_{ac},\varphi_{bc}\rangle=0$. L17Phi.lean's `compOf_opB` (line 154) gives `compOf (opB R) i j k l` $=\langle R\varphi_{ij},\varphi_{kl}\rangle$, so under `opB` the Bianchi clause is $3\,\mathrm{alt4}$ of `compOf`, the Ricci clause is `ric` term for term, and `opB_isSymmetric` carries self-adjointness. The tangent clause is `admissible_opB`'s, through `innerOp2_eq_trace`. **The same four conditions.**
- **Against route-a.md's Setting.** $T_uS=u^\perp$ in $\mathcal W_n$ (line 197, "$T_uS=u^\perp$"), with $u$ the unit padded competitor, which the model carries as `uOp` (`opB_u2`). **Matches.**
- **Normalisation and sign.** Irrelevant. Each condition is the vanishing of a linear functional, and a nonzero rescaling or sign flip leaves the kernel unchanged. The contraction $\sum_k R_{akbk}$ agrees with any other single-index Ricci contraction up to sign under the curvature symmetries. The full Ricci tensor vanishes (not only its trace-free part), which is the Weyl condition. The alternation is the $\tfrac13$-normalised cyclic sum, again a vanishing condition.
- **The statement.** `L17_dim_12` gives, for every $H\in$ `weylT 12`, $H\in\ker(\mathrm{condMap}|_{\mathrm{weylT}})\iff F(H)=0$, and $1451\le\dim\ker(\mathrm{condMap}|_{\mathrm{weylT}})$. That is the record's "dimension at least $1451$" for $\{F=0\}\cap\mathcal W_{12}\cap T_uS$. **Faithful.**

**Gap A-1.** `weylT` is the tangent Weyl space in the bivector model, and the Lean docstring says so (line 152). No theorem identifies it with the layer's $\mathcal W_n$, the `IsWeyl2` operators on `CurvOp2` tangent to `u2`. The dimension bound transfers only through a linear equivalence: `opB` restricted to self-adjoint operators, inverse $H\mapsto$ `toSkew` $\circ H\circ$ `coords`, which `coords_toSkew` and `toSkew_coords` (L17Phi.lean lines 105, 120) make bijective, with `compOf_opB` matching the clauses. Every ingredient is on the layer and the identification is true, but the lemma is unwritten, while lean/INDEX.md line 480 and route-a.md line 93 state "$\dim\mathcal W_{12}\cap T_uS\ge1637$" without the model qualifier. For contrast, L17Codim.lean needed only the inclusion `admissible_opB`, since a codimension bound on every admissible space is a strengthening, and a dimension lower bound is not. Repair: either a lemma `weylT n` $\cong$ {`IsWeyl2` $\wedge$ tangent} as a `LinearEquiv` (or an injection from `weylT` into it), or "in the bivector model" in both record lines.

## B. Soundness

- **Three adjacent transpositions.** `alt4_swap01` rewrites $T_{jikl}=-T_{ijkl}$, $T_{jkli}=T_{lijk}=-T_{iljk}$ (pair, then left) and $T_{jlik}=T_{ikjl}=-T_{iklj}$ (pair, then right), so $\mathrm{alt4}\,T_{jikl}=-\mathrm{alt4}\,T_{ijkl}$. `alt4_swap12` and `alt4_swap23` use the right antisymmetry alone. Checked by hand. **Sound.**
- **Six transpositions.** `altTup_swap` splits $a\ne b$ over `Fin 4` by `fin_cases` and closes each by `linarith` on ten instances of the three adjacent swaps. The non-adjacent ones are composites of adjacent ones, and each instance used is a valid substitution. **Sound.**
- **Swap induction.** `altTup_perm` inducts with `Equiv.Perm.swap_induction_on`, rewriting $v\circ(\tau f)=(v\circ\tau)\circ f$, then `ih` at $v\circ\tau$ and `altTup_swap`, with `sign_mul` and `sign_swap`. The statement is universally quantified over $v$ inside the induction, which is what makes `ih` applicable at $v\circ\tau$. **Sound.**
- **The sorting permutation.** For injective $v$, $s=\mathop{\mathrm{image}}v$ has card $4$, $\sigma(i)$ is the preimage of $v(i)$ under `orderIsoOfFin`, so `orderEmbOfFin s` $\circ\,\sigma=v$, and $\sigma$ is injective hence bijective on `Fin 4`. Then `altTup_perm` and the hypothesis on increasing tuples give $0$. **Sound.**
- **The non-injective case.** $v(a)=v(b)$ with $a\ne b$ gives $v\circ(a\,b)=v$, and `altTup_swap` gives $x=-x$. **Sound.**
- **`isCurv_compOf`.** Left and right antisymmetry come from $\varphi_{ji}=-\varphi_{ij}$ (`phi_swap`, `coords_neg`), pair symmetry from $H$ symmetric. The hypothesis `hH` is used exactly for the pair clause. **Sound.**
- **Independence of `symOp`.** `entry_symOp` computes $\langle e_a,\mathrm{symOp}(s)\,e_b\rangle$ as $2$ or $1$ when $\{a,b\}=s$ (diagonal or off-diagonal) and $0$ otherwise, generalising over the representative after recording `Quot.out_eq`. The sixteen-way case split covers every coincidence. In `finrank_symSub_ge` the entry at the representative $(a,b)$ of $s_0$ picks out $g(s_0)\cdot c$ with $c\in\{1,2\}$, so $g(s_0)=0$. `Sym2.card` is Mathlib's $\binom{|\alpha|+1}2$. **Sound.**
- **`Quot.out`.** It appears three times. `symOp` is symmetric in the two components, so any representative defines the same operator. `entry_symOp` and `finrank_symSub_ge` use only `Quot.out_eq`. `consMap`'s Ricci component reads $\mathrm{ric}(H)$ at one chosen ordering, which is linear in $H$ for any choice, and `mem_weylT_of_consMap` recovers both orderings by `Sym2.eq_iff`, using `ric_symm` (which needs $H$ symmetric, supplied by `hH`) in the swapped case. **No representative can misbehave.**
- **The target.** $(Q_4\to\mathbb R)\times(\mathrm{Sym}^2(\mathrm{Fin}\,n)\to\mathbb R)\times\mathbb R$, with $|Q_4|=\binom n4$ by `Fintype.card_finset_len` and $|\mathrm{Sym}^2(\mathrm{Fin}\,n)|=\binom{n+1}2$ by `Sym2.card`. The diagonal pairs are included, so the Ricci block counts all $n(n+1)/2$ components of a symmetric $n\times n$ tensor, as it must. **$\binom n4+\binom{n+1}2+1$, right.**
- **Rank-nullity.** $C=\mathrm{consMap}\circ\mathrm{symSub}.\mathrm{subtype}$, and $\dim\mathrm{symSub}=\mathop{\mathrm{rank}}C+\dim\ker C\le(\binom n4+\binom{n+1}2+1)+\dim\mathrm{weylT}$, the last from $\ker C$ mapping injectively into `weylT` (`mem_weylT_of_consMap`, `finrank_map_subtype_eq`, `finrank_mono`). With `finrank_symSub_ge`, `omega` closes it. No surjectivity is used, as the plan says. **Sound.**
- **Hypotheses.** `altTup_eq_zero` needs `LinearOrder ι` for `orderEmbOfFin` and nothing else. `finrank_weylT_ge` holds at every $n$. `L17_dim_12`'s `hN` feeds `Fval` and `L17_codim`. None unused, none missing. **CONFIRMED.**

## C. Arithmetic

$\binom{67}2=67\cdot66/2=2211$. $\binom{12}4=495$. $\binom{13}2=78$. $2211-495-78-1=1637$. $3\cdot66-12=186$ (`L17_codim`'s $3N-12$ at $N=66$) and $1637-186=1451$. `card_pairs12` is $\binom{12}2=66$ by `rfl`. As a paper check on the owed upper bound, the classical $\dim\mathcal W_n=\tfrac{n(n+1)(n+2)(n-3)}{12}$ is $1638$ at $n=12$, and $1638-1=1637$, so the bound proved is the true value. **CONFIRMED.**

## D. Axioms

`python3 scripts/misc/axiom_audit.py --only L17WeylDim`: "auditing 23 declarations across 1 files, 23/23 clean, resting on the standard three alone". The twenty-three are the theorems. The definitions (`IsCurv`, `altTup`, `ric`, `symSub`, `weylT`, `ep`, `E1`, `symOp`, `Q4`, `consMap`) reach the audit through the theorems that use them. No `sorry`, no `native_decide` in the file. **CONFIRMED.**

## E. Record accuracy

- **L17WeylDim.lean line 29** says the upper bound is not proved. Exact.
- **lean/INDEX.md line 480** names `finrank_weylT_ge`, `finrank_weylT_12` and `L17_dim_12` with the right content, and "**Owed**: the upper bound $\dim\mathcal W_{12}\cap T_uS\le1637$". Exact, except for the model qualifier (gap A-1).
- **INDEX-results.md line 32** says "[dimension at least $1451$]" at $n=12$ and that lean/INDEX.md "names the upper bound $\dim\mathcal W_{12}\cap T_uS\le1637$ as owed". Exact. Its Gate 2 column's "the $1637$-dimensional tangent Weyl space" is pre-existing record mathematics, true by the classical formula (item C), and not a Lean claim.
- **The plan file** marks milestones 1 to 4 proved and lists equality as not given. Exact.
- **route-a.md line 93.** Says the upper bound is not kernel-checked. Gap E-1 below.

**r1491's gaps.**

- **E-1, repaired.** route-a.md line 93 now names what is kernel-checked (`L17_codim`, `L17_codim_12`, `L17_dim_12`) and ends "The upper bound $\dim\mathcal W_{12}\cap T_uS\le1637$ is not kernel-checked". The identification of the kernel with $\{F=0\}$ is now attributed to `L17_codim`.
- **E-2, repaired.** lean/INDEX.md line 480's file column lists L17Codim.lean and L17WeylDim.lean, and reads "the $3\cdot63$ components of $P_0HP_0$ on the three anti-self-dual bivectors less the $3$ that symmetry makes redundant".
- **F-1, repaired.** L134bPhi.lean line 25 reads "(`L24Hess.lean`'s `L24_hessian_Le`). At other norms ...", two sentences.

**Gap E-1.** route-a.md line 93: "`L17_dim_12` in L17WeylDim.lean gives $\dim\mathcal W_{12}\cap T_uS\ge1637$ and so $\dim\{F=0\}\ge1451$". `L17_dim_12` states only the $1451$ (and the kernel identification). The $1637$ is `finrank_weylT_12`. Nothing is overstated, the attribution is loose in the way r1491's E-1 flagged for `L17_codim_12`. Repair: "`finrank_weylT_12` and `L17_dim_12` in L17WeylDim.lean give ...".

## F. Style

- No em dash in any added line of the commit (grep count $0$). "Kulkarni–Nomizu" in the plan is an en dash in a name.
- No backticks inside markdown link text in any added line.
- The semicolons in lean/INDEX.md line 480 separate items of a list whose items carry commas, the layer's convention r1491 accepted.
- The edited markdown lines (route-a.md 93, lean/INDEX.md 480, INDEX-results.md 32, each plan paragraph and list item) are each one unwrapped line.
- r1491's F-1 repaired (item E). **CONFIRMED.**

## Verdict

**CONFIRMED WITH GAP.** The Lean is sound: alternation from three adjacent swaps by swap induction, the independent symmetrised rank-one family giving $\binom{N+1}2$, the target of dimension $\binom n4+\binom{n+1}2+1$, and rank-nullity with no surjectivity, on the standard three axioms, giving $\dim\ge1637$ and, with `L17_codim`, $\dim\{F=0\}\ge1451$ at $n=12$. r1491's E-1, E-2 and F-1 are repaired. Open: A-1, `weylT` is the bivector model's space and its identification with the layer's `IsWeyl2` space is unwritten, while lean/INDEX.md line 480 and route-a.md line 93 drop the qualifier. E-1, route-a.md line 93 credits `L17_dim_12` with the $1637$, which is `finrank_weylT_12`.
