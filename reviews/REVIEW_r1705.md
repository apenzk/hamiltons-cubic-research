# REVIEW r1705: L112's pair cap at the operator, hatS_pair_cap and hatS_symm (328b2dda)

**Verdict: CONFIRMED.** `hatS_pair_cap` in [L112Op.lean](../lean/HamiltonsCubic/Results/L112Op.lean) is the record's pair cap $\hat S_{ab}\le1/(n-2)$ in the record's normalisation, $\hat S=S/(2(n-2))$ with $S_{ab}=\sum_cc_{abc}^2$ summed over all $c$, and its proof is the two-line argument [r1704](REVIEW_r1704.md) G1 named: `brnorm_frame` reads $S_{ab}=\lVert[v_a,v_b]\rVert^2$ and `L31_cap_unit` caps that at $2$ for unit skew $v_a,v_b$. The cap is sharp: it is attained with equality at padded $W_{\mathbb{CP}^2}$ at every $n\ge4$ and in every eigenframe. `hatS_symm` is correct and harmless. The row claims no more than the Lean holds, and it states the O1 instantiation as having no separate declaration.

| # | Claim | Verdict |
|---|---|---|
| 1a | `hatS_pair_cap` is the block's $\hat S_{ab}\le1/(n-2)$, same $S$, same normalisation | **CONFIRMED** |
| 1b | $S_{ab}=\lVert[v_a,v_b]\rVert^2$ via `brnorm_frame` | **CONFIRMED** |
| 1c | `L31_cap_unit`'s $\lVert[X,Y]\rVert^2\le2$ applies with the frame's unit norms, in the same pairing | **CONFIRMED** |
| 2a | The cap is sharp | **CONFIRMED BY HAND**: equality at the self-dual pair of padded $W_{\mathbb{CP}^2}$, every $n\ge4$ (below) |
| 2b | The row claims no more than the Lean | **CONFIRMED**, with one wording note (N1) |
| 2c | "The cap does not follow from (A) and (B) on an abstract $T$" | **CONFIRMED BY HAND**: a $4\times4$ witness with entry $3/4>1/2$ (below) |
| 3 | `hatS_symm` correct and harmless | **CONFIRMED** |
| 4 | Axioms: standard three only | **CONFIRMED** (screen by the repo's audit script, 9/9) |

One line: the one clause r1704 left untyped is now a kernel-checked theorem at every Weyl eigenframe, in the record's normalisation, and it is sharp at padded $W_{\mathbb{CP}^2}$.

## Attack line 1: the normalisation and the two inputs

- **$S$ and $\hat S$.** [L112Statement.lean:82](../lean/HamiltonsCubic/Results/L112Statement.lean#L82) defines `Smat T a b = ∑ c, T a b c` and [L112Statement.lean:106](../lean/HamiltonsCubic/Results/L112Statement.lean#L106) `hatS S n = S a b / (2 * (n - 2))`. With `Tc v a b c = cst v a b c ^ 2` this is the block's $S_{ab}:=\sum_cT_{abc}$, $T_{abc}=c_{abc}^2$, the sum over all $c$ (ordered), and $\hat S=S/(2(n-2))$, the scaling that makes the Killing row $2(n-2)$ sum to $1$. `n` is instantiated as `Fintype.card ι`, the dimension of the underlying $\mathbb R^n$, the same $n$ as in `L112_at_frame`.
- **The bound in these units.** $S_{ab}\le2$ gives $\hat S_{ab}\le2/(2(n-2))=1/(n-2)$. The last three tactic lines (`div_le_div_iff₀` with $2(n-2)>0$ and $n-2>0$, then `nlinarith` on $S_{ab}(n-2)\le 2(n-2)$) are exactly this.
- **`brnorm_frame`.** [L41Statement.lean:733](../lean/HamiltonsCubic/Results/L41Statement.lean#L733) states `inner2 (br (v x) (v a)) (br (v x) (v a)) = ∑ b, cst v x a b ^ 2`, from frame completeness and `frame_sq`. With `cst v a b c := inner2 (br (v a) (v b)) (v c)` ([L41Statement.lean:721](../lean/HamiltonsCubic/Results/L41Statement.lean#L721)), the right side is `Smat (Tc v) a b` after `unfold Smat Tc`, which is the rewrite the proof performs. This is Parseval for the complete orthonormal frame of $\mathfrak{so}(n)$, and completeness is an `EigenFrame` field, so no hidden restriction enters.
- **`L31_cap_unit`.** [L31Statement.lean:452](../lean/HamiltonsCubic/Results/L31Statement.lean#L452) takes skew `X`, `Y` with `inner2 X X = 1`, `inner2 Y Y = 1` and returns `inner2 (br X Y) (br X Y) ≤ 2`, in the same `RealLayer` `inner2` ($\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$) and `br` ($XY-YX$) that `cst` uses. The unit hypotheses come from `hf.orthonormal a a` with `if_pos rfl`, and skewness from `hf.skew`. This is the record's L31 display, $\lVert[X,Y]\rVert^2\le2$ for unit $X,Y\in\mathfrak{so}(n)$, and [conventions.md](../findings/conventions.md) already names the pair cap $\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2\le2$ as Lemma L31. The Lean composition is that sentence divided by $2(n-2)$.
- **Scope of the hypotheses.** The theorem needs `EigenFrame W v lam` and `0 < n - 2` and nothing else, in particular no `IsWeyl W`. So it holds at every orthonormal eigenframe of any operator, which contains every Weyl eigenframe. The docstring's "at every Weyl eigenframe" under-states the scope and is correct.

## Attack line 2: sharpness and what the row claims

- **Sharp at padded $W_{\mathbb{CP}^2}$, every $n\ge4$, every eigenframe (hand derivation).** $W_{\mathbb{CP}^2}$ acts on $\Lambda^+\mathbb R^4$ with eigenvalues $(2c,-c,-c)$, the $2c$ line spanned by the Kähler form, and by $0$ on $\Lambda^-$. Padded by zeros to $\Lambda^2\mathbb R^n$, the $-c$ eigenspace is still the two-dimensional complement of the Kähler form in $\Lambda^+\mathbb R^4$, so every eigenframe contains an orthonormal pair $v_a,v_b$ spanning it. Any such pair is $I/\sqrt2,J/\sqrt2$ for anticommuting complex structures $I,J$ on $\mathbb R^4$ with $IJ=K$, so $[v_a,v_b]=\tfrac12[I,J]=K$ and $\lVert K\rVert^2=\tfrac12\operatorname{tr}(K^{\mathsf T}K)=2$. So $S_{ab}=2$ and $\hat S_{ab}=1/(n-2)$ exactly. This is L31's equality case (both rank $4$, singular values $1/\sqrt2$, same image, anticommuting), which padding preserves. At $n=4$ it is consistent with (A): $\Lambda^+$ is an ideal, so row $a$ has two nonzero entries $S_{ab}=S_{ac}=2$, summing to $2(n-2)=4$.
- **What the record says about attainment.** The L112 block states the cap only as the lemma's "one constructive consequence" and says nothing about attainment. [bounds.md:224](../findings/bounds.md) records that the pair-cap consequences it derives are attained at $W_{\mathbb{CP}^2}$ at $n=4$, which agrees with the computation above. The Lean claims the inequality only, and [L31Statement](../lean/HamiltonsCubic/Results/L31Statement.lean) explicitly leaves L31's equality characterisation untyped. Nothing in the row claims sharpness, so nothing is over-claimed. The attainment above is offered as a note, not as a Lean fact.
- **The row's O1 sentence.** It reads that the convex-form majorisation and the L73 shadow "apply at the operator by the same substitution, with no separate declaration (r1704 O1)". That matches r1704 O1 and the Lean: [L112Doubly.lean:74](../lean/HamiltonsCubic/Results/L112Doubly.lean#L74)'s `shadow_convex` takes `hT`, `hT0`, `hA`, `hB` on an abstract `T`, each discharged at `Tc v` by lemmas in L112Op or L41Statement, and no operator-level theorem is declared. The row names the absence rather than hiding it. **CONFIRMED.**
- **"Does not follow from (A) and (B) on an abstract $T$."** Checked by hand at $n=4$ with $\Gamma$ of size $4$ and the Klein-group pairings $P_1=(12)(34)$, $P_2=(13)(24)$, $P_3=(14)(23)$. $\hat S=\tfrac14P_1+\tfrac34P_2$ is symmetric, hollow, nonnegative and doubly stochastic, and $\lambda=(1,1,-1,-1)$ gives $\hat S\lambda=\tfrac14\lambda-\tfrac34\lambda=-\tfrac12\lambda=-\lambda/(n-2)$. Take $T_{abc}=S_{ab}/4$ with $S=2(n-2)\hat S=4\hat S$. Every hypothesis of the abstract statement holds and $\hat S_{13}=3/4>1/2=1/(n-2)$. So the cap genuinely needs the bracket, and the row's placement of it "at the operator" is the correct one.
- **N1 (note, no verdict change).** The statement row beside it still reads **partial** with "the pair cap … DOES NOT FOLLOW from the hypothesis set". That remains true of the abstract hypothesis set, and the L112 row now points to the operator-level theorem, so the two rows are consistent. A reader of the statement row alone is not told the cap is now typed elsewhere, and a pointer to `hatS_pair_cap` there would close that.

## Attack line 3: hatS_symm

- `hatS_symm (hf) (n : ℝ) a b : hatS (Smat (Tc v)) n a b = hatS (Smat (Tc v)) n b a`, by unfolding `hatS` and rewriting with `S_symm hf a b`. Symmetry of a matrix scaled entrywise by the same constant $1/(2(n-2))$ is immediate, and it holds for every real `n`, including $n=2$ where the division is by zero and both sides are $0$ in Lean's convention, so the statement is true everywhere it is stated. It adds no hypothesis and is used by nothing that could be weakened by it. It closes r1704 O2 in the form "symmetry typed at the operator", though `L112_op`'s conjunction itself still omits it. **CONFIRMED, harmless.**

## Attack line 4: axioms

- `python3 scripts/misc/axiom_audit.py --only L112Op`: "9/9 clean, resting on the standard three alone" (propext, Classical.choice, Quot.sound), run after another session's Lean job finished (screen).
- The diff adds no `sorry`, no `native_decide`, no `axiom` declaration (read).

## What would break the claims, and where I looked

- **An $S$ summed over $c<d$ or unordered pairs** would put the cap at $1$ or $4$ rather than $2$ in these units. Looked: `Smat` sums over all `c : Γ`, `brnorm_frame` sums over all `b`, and L31's $2$ is the ordered Parseval norm. The Killing row $2(n-2)$ is on the same ordered footing, so the ratio $1/(n-2)$ is consistent.
- **A second `inner2`** (the layer has per-file `inner2` in L75, L77, L80, L81, L82 statements, over `Fin n`) with a different factor would make `L31_cap_unit` a statement in another norm. Looked: L31Statement opens `HamiltonsCubic.RealLayer` and its `inner2 X Y` is unfolded against the Frobenius `trace` with the $\tfrac12$ in `L31_cap`'s proof, and `L41Statement` uses the same `RealLayer` definitions. The composition typechecks with no coercion, so the two are the same constant.
- **An eigenframe with non-unit vectors** would void `L31_cap_unit`'s hypotheses. Looked: `EigenFrame.orthonormal` gives `inner2 (v a) (v a) = 1` for every `a`.
- **An abstract $T$ satisfying (A), (B) and violating the cap**, which would make any claim "the cap follows from the relations" false. Constructed one (attack line 2), and the row makes no such claim.
- **An operator attaining more than $2$** would refute L31 itself. The padded $W_{\mathbb{CP}^2}$ pair attains exactly $2$, the L31 equality configuration.

## Findings

- **No gap.** r1704 G1 is closed: the pair cap is typed at every Weyl eigenframe in the record's normalisation, and r1704 O2 is closed by `hatS_symm`.
- **Sharpness (hand).** The cap is attained at padded $W_{\mathbb{CP}^2}$ for every $n\ge4$, at the pair spanning the non-Kähler part of $\Lambda^+\mathbb R^4$, in every eigenframe.
- **N1.** The L112 statement row could point to `hatS_pair_cap`, so it does not read as the cap being untyped anywhere.
- **N2.** `hatS_pair_cap` needs no `IsWeyl`, so its docstring's "Weyl eigenframe" is narrower than the theorem.
