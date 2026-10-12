# Review r1514: L189's determinant step and contradiction (commit b3bda3f3)

*Gate 2, one reviewer, Lean layer. Subject: [L189Det.lean](../lean/HamiltonsCubic/Results/L189Det.lean) (`one_lt_det_one_add`, `det_lt_det_add`, `L189_core`, `L189_four`) and the three records commit b3bda3f3 edited for Lemma L189. Analysis only: the one build and the axiom audit were run, and the witnesses below are hand arithmetic on objects built for the purpose.*

| item | claim | verdict |
| --- | --- | --- |
| A | the four theorems are the record's determinant step, its contradiction and its $\dim V=4$ instance, with the right hypotheses | **CONFIRMED WITH GAP** |
| B | the file builds, carries no `sorry`, and rests on the standard three axioms | **CONFIRMED** |
| C | lean/INDEX.md's L189 row, INDEX-results row 189 and the diagonal-half.md sentence state what the file proves and name what it owes | **CONFIRMED WITH GAP** |
| D | the edited text meets the style rules | **CONFIRMED WITH GAP** |

**Summary: the monotonicity and the contradiction are proved exactly as the record uses them, but "the whole chain at dim V = 4" overstates a theorem that takes the matrix equations and M's invertibility as hypotheses, and the owed clause omits the Weyl reduction, the odd-m route and the general-m source of invertibility.**

## A. Fidelity

**`det_lt_det_add` is the record's sentence verbatim.** [diagonal-half.md:713](../findings/diagonal-half.md) says "a nonzero positive-semidefinite bump on a positive definite matrix strictly raises the determinant", and [L189Det.lean:65](../lean/HamiltonsCubic/Results/L189Det.lean) states `A.PosDef → B.PosSemidef → B ≠ 0 → A.det < (A + B).det` over ℝ at every finite index type. The proof writes $B=C^{\mathsf T}C$, applies the matrix determinant lemma and reduces to `one_lt_det_one_add`, $\det(1+P)=\prod(1+\mu_i)>1$. *Witness for the hypotheses*: $A=I_2$, $B=\mathrm{diag}(1,0)$, with $\det A=1<2=\det(A+B)$.

**`L189_core` is the contradiction, with the hypotheses the record's proof spends.** It takes $\det N^2=\det M^2$, $M$ invertible, $B\succeq0$, $B\ne0$ and $NN^{\mathsf T}=MM^{\mathsf T}+B$ ([L189Det.lean:101](../lean/HamiltonsCubic/Results/L189Det.lean)). The record's $\det(NN^{\mathsf T})=\mathrm{Pf}(N)^4$ is $(\det N)^2$, so equal squared determinants is exactly what $\mathrm{Pf}N=\mathrm{Pf}M$ delivers.

- **$\lvert\lambda_3\rvert\Pi_3$ is PSD and nonzero in the record's setting.** $\Pi_3=\omega_3\omega_3^{\mathsf T}$ is the orthogonal projection onto the plane $P_3$ of the unit decomposable $\omega_3$ ([diagonal-half.md:649](../findings/diagonal-half.md)), of rank two, and $\lambda_3\ne0$ at rank three.
- **Both hypotheses on $B$ and the one on $M$ are load-bearing.** With $E$ the $4\times4$ skew matrix $E_{01}=1=-E_{10}$, $N=2E$ and $M=E$ give $\det N=\det M=0$ and $B=3\,\mathrm{diag}(1,1,0,0)$, PSD and nonzero, so only `hM` fails. $N=M$ with $B=0$ fails only `hB0`.
- **Orientation is consistent.** The file uses $N N^{\mathsf T}$, as the record does, and for skew $N$ this equals $N^{\mathsf T}N=-N^2$ anyway. `L189_core` needs no skewness.
- **Entering invertibility as a hypothesis is right**, since the layer has neither [L180](../findings/diagonal-half.md)(3) at general dimension nor the Pfaffian step that transfers full rank from $\omega_1$ to $\omega_2$.

**Gap A-1: the invertibility is cited to L188(1), which is stated at $\dim V=8$ only.** [L189Det.lean:25-26](../lean/HamiltonsCubic/Results/L189Det.lean) and [lean/INDEX.md:90](../lean/INDEX.md) say $M$'s invertibility "is L188(1)'s full rank". [diagonal-half.md:695](../findings/diagonal-half.md) proves full rank eight, at $m=4$. At $\dim V=2m$ with $m$ even the same argument holds: L180(3) makes $\omega_1$ full rank on $V$, and the owed $\mathrm{Pf}N=\mathrm{Pf}M$ passes it to $\omega_2$. So the source at general $m$ is L180(3) together with the owed Pfaffian step, and the citation covers one dimension of the range the core serves.

**`L189_four` is a correct instance.** [SelfDual.lean:98-105](../lean/HamiltonsCubic/Base/SelfDual.lean) defines `wedgeSelf X 0 1 2 3` as `halfw X X + halfw X X` at $(0,1,2,3)$, which is $2(X_{01}X_{23}-X_{02}X_{13}+X_{03}X_{12})=2\,\mathrm{Pf}X$. On $\mathbb R^4$, $\Lambda^4$ is one-dimensional, so the single component is the whole of $N\wedge N=M\wedge M$. The factor 2 cancels in `hpf`, and [L186Rank.lean:31](../lean/HamiltonsCubic/Results/L186Rank.lean)'s `det_skew4` gives $\det=\mathrm{Pf}^2$ on both sides.

**The remark that L187 already excludes $\dim V=4$ is accurate.** L187's statement is $\dim V\ge8$, and INDEX-results row 187 keeps "empty at $\dim V\in\{4,6,10,14,\dots\}$" among what survives Gate 2. The emptiness at 4 is carried in the record by the L178 step-1 note under L186, which the census cites, so the row could name that block, but the claim stands.

## B. Soundness

- `lake build HamiltonsCubic.Results.L189Det`: **Build completed successfully**, four longLine warnings (lines 41, 59, 115, 117) and nothing else.
- `axiom_audit.py --only L189Det`: **4/4 clean, resting on the standard three alone.**
- No `sorry`, `admit`, `native_decide` or `axiom` in the file.

## C. Records

**Gap C-1: "the whole chain" at $\dim V=4$ is overstated.** [lean/INDEX.md:90](../lean/INDEX.md) says "At $\dim V=4$ the whole chain is proved", and [INDEX-results.md:205](../findings/INDEX-results.md) says the file proves "the whole chain at $\dim V=4$". `L189_four` ([L189Det.lean:114-116](../lean/HamiltonsCubic/Results/L189Det.lean)) takes the linearised Ricci identity `hric`, the Bianchi component `hbianchi`, the PSD bump and $M$'s invertibility as hypotheses. What it proves is the chain from the linearised equations onward. The rescaling from the Weyl tensor, the collapse of $\omega_3\wedge\omega_3$, and the identification $B=\lvert\lambda_3\rvert\Pi_3$ are typed nowhere.

**Gap C-2: the owed clause is incomplete.** [lean/INDEX.md:90](../lean/INDEX.md) owes only the Pfaffian step at $m$ even above 2. The lemma's statement, "empty at every dimension", also needs:

- the reduction from a rank-three Weyl tensor to $NN^{\mathsf T}=MM^{\mathsf T}+\lvert\lambda_3\rvert\Pi_3$ and $N\wedge N=M\wedge M$, including the sign pattern and $c>0$ the record itself calls load-bearing;
- $M$'s invertibility, which the row mentions but places outside the owed list, with the source correction of A-1;
- the odd residue, which the record closes by [r802](REVIEW_r802.md)'s $\tau$ route and the layer does not carry.

**Gap C-3: INDEX-results row 189 omits that the $\dim V=4$ instance is vacuous for the lemma.** [lean/INDEX.md:90](../lean/INDEX.md) says the case "is an instance of the argument, L187 already excluding $\dim V=4$". [INDEX-results.md:205](../findings/INDEX-results.md) presents "the whole chain at $\dim V=4$" with no such qualifier, so the reader of that row takes it as a covered dimension of the lemma.

**The diagonal-half.md sentence is accurate** ([diagonal-half.md:713](../findings/diagonal-half.md)): it credits only the monotonicity and the contradiction, which is what is proved. It would read more precisely with "given equal determinants and $M$ invertible".

**partial** is the right status on both rows, and "statement: not typed" is accurate, since no theorem states L189 as a whole.

## D. Style

- No em dashes in any added line, and no backticks inside link text.
- Both edited INDEX rows end with a closing pipe, and none is hard-wrapped.
- **Gap D-1**: [INDEX-results.md:205](../findings/INDEX-results.md) keeps the older splice "linearises both equations; at even $m$ Bianchi forces", in the row this commit rewrote.
- **Gap D-2**: [lean/INDEX.md:90](../lean/INDEX.md) ends "enters as a hypothesis **statement: not typed**" with no full stop, so the status tag runs into the sentence.
- The semicolons in the lean/INDEX.md row and the file docstring separate list items that carry commas, which is the permitted use.
