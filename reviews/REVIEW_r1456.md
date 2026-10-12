# REVIEW r1456: L50's link (b) proved in Lean, commit 79ce317e: L50Self.lean, L50Expand.lean, L50Coord.lean, and the citing text in lean/INDEX.md, findings/bispectral.md, L50Lovelock.lean's docstring, report Lemma 51 and scripts/INDEX.md

Log [agent_logs/r1456.log](../agent_logs/r1456.log). One reviewer, working cold, statement fidelity and hypothesis use against the record. Analysis-only: `lake build HamiltonsCubic.Results.L50Coord` (cached, clean), one scratch file in the session scratchpad (outside the repository) carrying `#print axioms` for six names and `#check` of `Pcubic_collapse` and `LL_expand`, and one run of [gen_L50_expand.py](../scripts/misc/gen_L50_expand.py) redirected to the scratchpad (seconds), whose output is byte-identical to the committed [L50Expand.lean](../lean/HamiltonsCubic/Results/L50Expand.lean). Both runs are screens. Everything else is reading and the hand checks below. Record: [findings/bispectral.md](../findings/bispectral.md) at 79ce317e (lines 117 to 145), [lean/INDEX.md](../lean/INDEX.md) line 375, [report/sections/06b-bispectral.tex](../report/sections/06b-bispectral.tex) lines 39 to 56, [findings/fence-posts.md](../findings/fence-posts.md) lines 26 and 121 to 133, [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean), [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean), [L209FoxClosure.lean](../lean/HamiltonsCubic/Results/L209FoxClosure.lean), [SecondKind.lean](../lean/HamiltonsCubic/Results/SecondKind.lean), [L50Spectra.lean](../lean/HamiltonsCubic/Results/L50Spectra.lean), [L50Lovelock.lean](../lean/HamiltonsCubic/Results/L50Lovelock.lean), and reviews [r1404](REVIEW_r1404.md) and [r1455](REVIEW_r1455.md) as leads.

**Standfirst.** The record's claim, quoted from [bispectral.md:143](../findings/bispectral.md): "**As an identity of trilinear forms** ... for $n\le5$ $\beta=\tfrac12\alpha$, so $\langle W^\#,W\rangle=2\operatorname{tr}(W^3)$ and $\theta=3\operatorname{tr}(W^3)$ is a function of $\mu$ alone", with the mechanism $\beta-\tfrac\alpha2=-\tfrac1{64}\,\delta^{a_1\cdots a_6}_{b_1\cdots b_6}WWW$. The Lean chain proves it. `Pcubic_collapse` takes exactly `IsWeylOp R` unpacked (linearity, bivectors to bivectors, self-adjointness on bivectors, first Bianchi, `Ric R = 0`) plus `Fintype.card ι ≤ 5`, and concludes `Pcubic R = 3 * trCube R`, the record's $\theta=3\operatorname{tr}W^3$ before normalising. `selfEdge` is exactly the self-contracted permutations, each of the twelve `self_case` lemmas reduces its term to a Ricci trace with the right signs, `survivor_patterns` and the counts $16$, $64$ are kernel `decide`, and three survivor lemmas check by hand. Standard three axioms on six names, no `native_decide` anywhere in the L50 files. The record text is faithful and r1455's gap is fixed. One gap: the report's new proof sentence rests "only there" on the evaluations at $n=6,7$, which do not reach $n\ge8$ by themselves, while an exact $n=6$ witness and zero-padding, both on file, would.

| Item | Verdict | Reason |
| --- | --- | --- |
| A. Statement fidelity | CONFIRMED | `LL_expand` is $\mathrm{LL}=16\alpha-64\gamma$ under `WeylC` and a zero Ricci trace, with no card hypothesis. `collapse` adds `card ι ≤ 5` and gives `betaC = alphaC / 2`. `sharpPair_collapse` and `Pcubic_collapse` carry the hypotheses of `IsWeylOp` clause for clause, none stronger and none weaker. `trCube`, `sharpPair`, `Pcubic` are `innerOp (compOp R) R`, `innerOp R (sharpOp R)` and their sum, the record's $\operatorname{tr}M^3$, $\langle M^\#,M\rangle$ and unnormalised $\theta$. |
| B. `selfEdge_zero` | CONFIRMED | `owner (σ p) = owner p` says slot $p$'s upper label is one of its own factor's lower labels, which is self-contraction exactly. `fin_cases p` and the two values of `σ p` in each block give the twelve cases. `sum_ricci_zero` sums the contracted label first and uses `anti12` then `anti34` to reach `hRic`. The sign bookkeeping in each case is checked by the kernel against the stated `A`. |
| C. The survivors | CONFIRMED | `survivor_patterns` says every non-self-contracted $\tau$ is one of $80$ listed $(\tau,\operatorname{sgn}\tau)$ patterns, closed by `decide`. `survivor_term`'s `if owner (σ 0) = owner (σ 1)` separates the cyclic class from the mixed class. `c1` and `c2` are `decide`. By hand: `surv_0` ($+\alpha$, sign $+1$), `surv_1` ($-\alpha$, sign $-1$), `surv_5` ($-\gamma$, sign $+1$, total $-1$). |
| D. L50Coord | CONFIRMED | `sum6` peels six `Fin.cons` layers. `weylC_R4` draws each field from the layer's `R4` lemmas. `ricci_R4` holds by `rfl`: `R4 R a c b c` unfolds to `inner2 (R (phi a c)) (phi b c)`, the summand of `Ric`. `alphaC_R4` and `betaC_R4` match `alphaW` and `betaW` index for index with $(i,j,k,l,m,n)=(x_0,\dots,x_5)$. |
| E. Axioms | CONFIRMED | `LL_expand`, `collapse`, `survivor_patterns`, `selfEdge_zero`, `sharpPair_collapse`, `Pcubic_collapse`: each `[propext, Classical.choice, Quot.sound]`. No `native_decide`, `sorry` or `axiom` in any L50 file. |
| F. Record text | CONFIRMED WITH GAP | The L50 row, bispectral.md's "Machine-checked in full", and the L50Lovelock docstring are faithful, and the row's lead now names (a) and (b) as the record does. The report paragraph keeps to status language. Gap: [06b-bispectral.tex:51](../report/sections/06b-bispectral.tex) rests "only there" on evaluations at $n=6,7$, while Lemma 51's statement (line 42) quantifies over every $n\ge6$. |
| G. Downstream | CONFIRMED | No file in findings/, results.md, report/, lean/INDEX.md, plan.md, plan-lean.md or STATUS.md still calls the expansion owed or unproved. The one "Owed ... $P=3\operatorname{tr}(W^3)$ on $\mathcal W_5$" at lean/INDEX.md:314 sits inside the L62 row's labelled earlier account, superseded by its statement row. |

**One-line summary.** The $720$-term expansion, the collapse $\beta=\alpha/2$ and $P=3\operatorname{tr}M^3$ on $\mathcal W_n$ for $n\le5$ are proved in Lean exactly as the record states them, on the standard three axioms, and the one gap is the report's support for "only there" beyond $n=7$. **CONFIRMED WITH GAP**

## A. Statement fidelity

**The printed type of `Pcubic_collapse`** (from `#check`):

```
∀ {ι} [Fintype ι] [DecidableEq ι] (R : Matrix ι ι ℝ → Matrix ι ι ℝ),
  IsLinOp R → (∀ X, IsSkew X → IsSkew (R X)) →
  (∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) →
  (∀ i j k l, bianchi R i j k l = 0) → (∀ a b, Ric R a b = 0) →
  Fintype.card ι ≤ 5 → Pcubic R = 3 * trCube R
```

**Hypotheses against $\mathcal W_n$.** [FoxProduct.lean:110](../lean/HamiltonsCubic/Base/FoxProduct.lean) defines the record's $\mathcal W_n$ as `IsWeylOp R := IsLinOp R ∧ IsWeyl R`, and [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)'s `IsWeyl` is the conjunction of the four remaining clauses in the same order and the same form. So the hypotheses are `IsWeylOp R` unpacked, with $n=$ `Fintype.card ι`. None is stronger than what $W\in\mathcal W_n$ supplies, and none is weaker: linearity is needed because `trCube` reads `R (R (phi i j))`, which `R4` alone does not determine for a nonlinear map, and `hskew` is needed because `inner2` sees `R X` only through its skew part. At $n\le3$ the hypotheses force nothing false, since the conclusion is an identity there too.

**`LL_expand` and `collapse`.** `LL_expand : WeylC W → (∀ a b, ∑ c, W a c b c = 0) → LL W = 16 * alphaC W - 64 * gammaC W`, with no restriction on `ι`. The Ricci clause is the second-and-fourth-slot trace, which is the layer's `Ric` under `R4` (item D). `collapse` is `collapse_of_display` fed by `LL_expand`, so it now carries no expansion hypothesis. `LL` is the unnormalised delta with $b=x\circ\sigma$, which r1455 checked against the record's display. Arithmetic: `LL_zero`, `gamma_eq` ($\gamma=\beta-T$) and `T_eq` ($4T=\alpha$) give $0=16\alpha-64\beta+16\alpha$, so $\beta=\alpha/2$, and at every $n$ `LL_expand` with `gamma_eq` and `T_eq` gives $\mathrm{LL}=-64(\beta-\tfrac\alpha2)$, the record's display.

**The three layer quantities.** `trCube R = innerOp (compOp R) R` $=\tfrac12\sum_{i,j}\langle R^2\varphi_{ij},R\varphi_{ij}\rangle$, $\operatorname{tr}M^3$ with the ordered-pair doubling. `sharpPair R = innerOp R (sharpOp R)`, $\langle M,M^\#\rangle$. `Pcubic = trCube + sharpPair`, the record's $P=\langle W,W^2+W^\#\rangle$, which is $\theta$ at unit norm. This agrees with r1404, which is a lead only. The chain's last two steps are `trCube_eq_alpha` ($\operatorname{tr}M^3=\alpha/8$) and `sharpPair_eq_beta` ($\langle M,M^\#\rangle=\beta/2$), so $\beta=\alpha/2$ gives $\langle M^\#,M\rangle=\alpha/4=2\operatorname{tr}M^3$ and $P=\alpha/8+\alpha/4=3\operatorname{tr}M^3$, the record's two statements.

**Record quantities.** `alphaC` $=W_{abcd}W_{abef}W_{cdef}$ and `betaC` $=W_{abcd}W_{aecf}W_{bedf}$. The record's $\beta=W_{tspq}W_{tjpl}W_{sjql}$ is `betaC` under $t,s,p,q,j,l\mapsto a,b,c,d,e,f$, and its $\alpha=W_{tpsq}W_{tpkl}W_{sqkl}$ is `alphaC` under $t,p,s,q,k,l\mapsto a,b,c,d,e,f$.

## B. `selfEdge_zero`

**The predicate.** In `LLterm W σ x`, factor $k$ is `W (x (2k)) (x (2k+1)) (x (σ (2k))) (x (σ (2k+1)))`. Label $x_u$ occurs in exactly one lower slot, of factor `owner u`, and in exactly one upper slot, slot $\sigma^{-1}(u)$. A factor contracts with itself exactly when one of its upper slots $p$ carries a label $\sigma(p)$ from its own lower pair, which is `owner (σ p) = owner p`. So `selfEdge` is the set of self-contracted permutations, both-slot cases ($W_{abab}$, $W_{abba}$) included, and `¬selfEdge` is the set with none.

**`sum_ricci_zero`.** `sum_update` is the involution $(x,v)\mapsto(\mathrm{update}\,x\,q\,v,\,x_q)$, so $\sum_x\sum_vF(\mathrm{update}\,x\,q\,v)=\lvert\iota\rvert\sum_xF(x)$. With `hF`, the left side is $\sum_xA(x)\sum_vW(v,y,v,z)$. `anti12` then `anti34` give $W(v,y,v,z)=W(y,v,z,v)$ (two sign flips), and `hRic y z` kills the inner sum. The empty-`ι` case is split off, and otherwise $\lvert\iota\rvert>0$ divides out. Correct. `hF` constrains nothing that could make the lemma vacuous: it is proved in each case, from `LLterm`'s definition.

**The twelve cases.** For `σ p = q'` with `owner q' = owner p`, the label $x_{q'}$ occurs only in factor `owner p`: once in its lower pair and once in its upper slot $p$, because $\sigma$ is injective (the five `h` lemmas say no other slot reads $q'$). Updating $x_{q'}$ to $v$ therefore changes only that factor. Signs, read off each case:
- `0_0`, `2_2`, `4_4` (upper slot 1 of the factor reads lower slot 1): the factor is $W(v,y,v,z)$ directly, sign $+$.
- `1_1`, `3_3`, `5_5` (upper slot 2 reads lower slot 2): $W(y,v,z,v)=W(v,y,v,z)$ by `anti12` and `anti34`, sign $+$.
- `0_1`, `2_3`, `4_5` (upper slot 1 reads lower slot 2): $W(y,v,v,z)=-W(v,y,v,z)$ by `anti12`, and `A` carries the minus.
- `1_0`, `3_2`, `5_4` (upper slot 2 reads lower slot 1): $W(v,y,z,v)=-W(v,y,v,z)$ by `anti34`, and `A` carries the minus.

These are the signs in the file and the `rw` in each case is the named antisymmetry. **Coverage**: `fin_cases p` gives all six $p$, and `owner (σ p) = owner p` with `(σ p).isLt` leaves exactly the two values of `σ p` in $p$'s block, dispatched by `omega`. Every $p$ and every `σ p` in its block has a lemma.

## C. The survivors

**`survivor_patterns`** states `∀ τ, ¬selfEdge τ → (pattern 0) ∨ … ∨ (pattern 79)`, each pattern fixing all six values of `τ` and `Equiv.Perm.sign τ`. It is closed by `decide`, so the kernel evaluates it on all $720$ permutations. It asserts membership only, which is all `survivor_term` uses. The sign in each disjunct is part of what `decide` checks, so the signs are derived. Forty patterns carry sign $+1$ and forty $-1$.

**The class split.** `owner (σ 0) = owner (σ 1)` says both upper slots of factor $0$ read one other factor's lower pair. Without self-contraction that forces the cyclic pattern: if factor $0$'s upper pair is factor $j$'s lower pair, the third factor's uppers must come from factor $0$'s lower pair, and factor $j$'s uppers from the third factor's. Otherwise the pattern is the all-ones off-diagonal one. So the `if` is the $\alpha$/$\gamma$ split. The docstring's wording ("the first factor's lower pair lands in one other factor") describes the inverse map, which agrees with the condition on every survivor. `survivor_term` closes each branch with `simp [owner, h0, h1]` after `rw [hs, surv_k]`, so the kernel checks that each `surv_k`'s value times its sign is the branch value.

**Counts.** `c1` (card $16$ for the $\alpha$ branch) and `c2` (card $64$ for the $\gamma$ branch) are `by decide` inside `LL_expand`, and `Finset.sum_ite` with `Finset.sum_const` turns them into $16\alpha+64(-\gamma)$. Neither count is asserted. The generator's `assert c=={'alpha':16,'gamma':-64}` is a script-side check and nothing in Lean depends on it.

**Three survivor lemmas by hand.**
- **`surv_0`**, $\sigma=(2,3,4,5,0,1)$: two $3$-cycles $(0\,2\,4)(1\,3\,5)$, sign $+1$. The term is $W_{x_0x_1x_2x_3}W_{x_2x_3x_4x_5}W_{x_4x_5x_0x_1}$, and pair symmetry on the third factor gives $W_{x_0x_1x_4x_5}$, so the product is `alphaC`'s summand. Value $+\alpha$, total $+\alpha$. `owner 2 = owner 3`, the $\alpha$ branch. Agrees.
- **`surv_1`**, $\sigma=(2,3,4,5,1,0)$: the $6$-cycle $0\to2\to4\to1\to3\to5\to0$, sign $-1$. Third factor $W_{x_4x_5x_1x_0}=-W_{x_0x_1x_4x_5}$ (`sym5`), so the value is $-\alpha$ and the total $(-1)(-\alpha)=+\alpha$. $\alpha$ branch. Agrees.
- **`surv_5`**, $\sigma=(2,4,0,5,3,1)$, a $\gamma$-class lemma with total $-1$: cycles $(0\,2)(1\,4\,3\,5)$, sign $(-1)(-1)=+1$. The term is $W_{x_0x_1x_2x_4}W_{x_2x_3x_0x_5}W_{x_4x_5x_3x_1}$. The relabelling `![0,1,2,5,3,4]` evaluates at $x\circ\pi$, so with $y=x\circ\pi$ the original $x_3,x_4,x_5$ read $y_5,y_3,y_4$, and the term is $W_{y_0y_1y_2y_3}\,W_{y_2y_5y_0y_4}\,W_{y_3y_4y_5y_1}$. Pair symmetry gives $W_{y_2y_5y_0y_4}=W_{y_0y_4y_2y_5}$, and `sym5` gives $W_{y_3y_4y_5y_1}=-W_{y_1y_5y_3y_4}$. Against $\gamma=W_{abcd}W_{aecf}W_{bfde}$ at $a,\dots,f=y_0,\dots,y_5$, the value is $-\gamma$, the total $(+1)(-\gamma)=-\gamma$. `owner 2 = 1`, `owner 4 = 2`, the $\gamma$ branch. Agrees, and these are the two `rw` steps in the file.

## D. L50Coord.lean

- **`sum6`**: `sum_cons` is `Fin.consEquiv` under `Fintype.sum_equiv`, applied at $k=5,\dots,0$, then `Fintype.sum_unique` on `Fin 0 → ι` and `rfl`. Correct.
- **`weylC_R4`**: `anti12` from `R4_anti1` (which needs `hR`, `hskew`, `hsym`), `anti34` from `R4_anti2`, `pair` from `R4_pair`, `bianchi` from `hB`. `WeylC.bianchi` is $W_{abcd}+W_{acdb}+W_{adbc}=0$ and the layer's `bianchi R i j k l` is `inner2 (R (phi i j)) (phi k l) + inner2 (R (phi i k)) (phi l j) + inner2 (R (phi i l)) (phi j k)`, which is $R4_{ijkl}+R4_{iklj}+R4_{iljk}$, the same cyclic sum. The field is supplied as `hB a b c d` with no rewriting, which the elaborator accepts only because the two are definitionally equal.
- **`ricci_R4`**: `R4 R a c b c` is `inner2 (R (phi a c)) (phi b c)` by [L209FoxClosure.lean:42](../lean/HamiltonsCubic/Results/L209FoxClosure.lean), and [WeylReal.lean:106](../lean/HamiltonsCubic/Base/WeylReal.lean) defines `Ric R a b := ∑ c, inner2 (R (phi a c)) (phi b c)`. Syntactically the same sum, so `rfl` is right.
- **`alphaC_R4`**: `alphaC` summand `W x0 x1 x2 x3 * W x0 x1 x4 x5 * W x2 x3 x4 x5`, `alphaW`'s `R4 i j k l * R4 i j m n * R4 k l m n`, matched by $(i,j,k,l,m,n)=(x_0,\dots,x_5)$.
- **`betaC_R4`**: `betaC` summand `W x0 x1 x2 x3 * W x0 x4 x2 x5 * W x1 x4 x3 x5`, `betaW`'s `R4 i j k l * R4 i m k n * R4 j m l n`, matched by the same assignment ($m=x_4$, $n=x_5$).

## E. Axioms

`#print axioms`, from a scratch file importing `HamiltonsCubic.Results.L50Coord`:

```
LL_expand          [propext, Classical.choice, Quot.sound]
collapse           [propext, Classical.choice, Quot.sound]
survivor_patterns  [propext, Classical.choice, Quot.sound]
selfEdge_zero      [propext, Classical.choice, Quot.sound]
Pcubic_collapse    [propext, Classical.choice, Quot.sound]
sharpPair_collapse [propext, Classical.choice, Quot.sound]
```

No `Lean.ofReduceBool`, so no `native_decide` reaches any of them, and a grep of the six L50 files finds no `native_decide`, `sorry` or `axiom`. The build emits linter warnings only (unused `DecidableEq ι` in the types of `LL_expand` and `collapse`).

## F. Record text

**The L50 row** ([lean/INDEX.md:375](../lean/INDEX.md)). The lead now reads "so are both of the block's links, (a) the dictionary and (b) the collapse below dimension six", which is the record's own naming at bispectral.md:139, so r1455's gap is fixed. The link (b) sentences name the right lemmas in the right files with the right content. The owed list is the $n\ge6$ converse alone, and that is right for Lean: the three items r1455 saw owed (the expansion, the passage to $\mathcal W_n$'s coordinates, the converse) are now `LL_expand`, `weylC_R4` with `alphaC_R4` and `betaC_R4`, and still owed. Status **partial** with an owed item is consistent. Two wording points, withdrawn as gaps:
- "so `collapse` holds unconditionally" means without the display hypothesis, which the preceding clause makes clear.
- "for a Ricci-flat operator self-adjoint on bivectors with first Bianchi" omits linearity and bivector preservation. Against: the row's lead fixes those as the standing hypotheses, "operator" carries linearity by FoxProduct's own definition of $\mathcal W_n$, and "self-adjoint on bivectors" presupposes the map preserves them.

**bispectral.md:139's "Machine-checked in full".** Each named piece exists with the stated content: `gamma_eq`, `T_eq`, `LL_zero` in L50Lovelock, `selfEdge_zero` in L50Self, `LL_expand` in L50Expand, `sharpPair_collapse` and `Pcubic_collapse` in L50Coord. The display itself, $\mathrm{LL}=-64(\beta-\tfrac\alpha2)$ at general $n$, is not one named theorem but is `LL_expand`, `gamma_eq` and `T_eq` with no card hypothesis, so "in full" is faithful for the collapse the sentence names.

**L50Lovelock's docstring** says the expansion is `LL_expand`, discharging `collapse`'s hypothesis. Faithful.

**The report** ([06b-bispectral.tex:51](../report/sections/06b-bispectral.tex)). The paragraph states the derivation and its checking status, with no sentence that needs a previous version, so it keeps [update-report](../.claude/skills/update-report/SKILL.md)'s status-not-history rule. "Every step, the collapse $\theta=3\tr(W^3)$ at $n\le5$ included, is kernel-checked" is faithful, since `Pcubic_collapse` is the unnormalised form and $\theta$ is $P$ at unit norm.

**GAP: "only there" beyond $n=7$.** Located at [06b-bispectral.tex:51](../report/sections/06b-bispectral.tex), last sentence: "The clause \emph{only there} rests on the evaluations at $n=6,7$ in the certificate below." Lemma 51's statement (line 42) reads "On $\Weyl_n$ for $n\le5$, and only there", a claim about every $n\ge6$, and the certificate (line 55) supports it with "It fails at $n=6,7$", sampled evaluations. Exhibited: a reader holding only the report finds no step from $n=6,7$ to $n=8$, so the cited support covers two of the dimensions the clause quantifies over.
- *Against:* the sentence discloses the support rather than claiming a proof, which is more honest than the text it replaced. And the missing step is one line: zero-padding embeds $\mathcal W_6$ in $\mathcal W_n$ with $\alpha$, $\beta$, $P$ and $\operatorname{tr}W^3$ unchanged, so one $n=6$ failure is a failure at every $n\ge6$.
- *Why it stands:* the one-line step appears nowhere near the claim, and the report's status table (09-status.tex:77) calls the lemma **Proven** "for $n\le5$ and no further". The step also has an exact input already on file: [fence-posts.md:26](../findings/fence-posts.md) exhibits, exhaustively and exactly, diagonal Weyl tensors at $n=6$ with $\operatorname{tr}W^3=0$ and $P=\pm24$, which contradict $P=3\operatorname{tr}W^3$ outright. Padded, they give the converse at every $n\ge6$ exactly, not by sampling.

**Observation, recorded without a gap.** The same padding argument bears on two sentences that understate the record: [bispectral.md:139](../findings/bispectral.md)'s "'only there' has no argument at all ... nothing on file reaches $n\ge10$", and the L50 row's "the converse ... which the record does not argue". Both are literally true of the L50 block, which never assembles the witness with padding, and both predate this commit in substance. They are understatements, so they overclaim nothing. No sentence in the commit overclaims "only there" beyond the gap above.

## G. Downstream

Grep over findings/, results.md, report/sections/, lean/INDEX.md, plan.md, plan-lean.md and STATUS.md for "expansion itself is the enumeration", "collapse_of_display", "left as a hypothesis", Lovelock, and $2\operatorname{tr}(W^3)$ and $3\operatorname{tr}(W^3)$ near "owed":
- No live sentence calls the expansion owed or unproved. The old "the expansion itself is the enumeration" is gone from bispectral.md, and scripts/INDEX.md no longer names `collapse_of_display` as the script's consumer.
- plan-lean.md:77 carries the row's new lead.
- lean/INDEX.md:314 (L62) owes "$P=3\operatorname{tr}(W^3)$ on $\mathcal W_5$ (L50's collapse)", but inside the paragraph the row itself labels "this row's earlier account", superseded by the L62 statement row (line 315, "names nothing owed"). This is not a live claim. `Pcubic_collapse` is not wired into L62, and nothing says it is.
- results.md:816, sym3-blocks.md:36 and :207, fence-posts.md:121 to 133, and report 01-introduction.tex:61 and 09-status.tex:77 cite the collapse as holding, which now has a Lean proof, and none of them calls it unproved. sym3-blocks.md:36's owed clause concerns the spanning of cubic invariants, which is a separate claim.
