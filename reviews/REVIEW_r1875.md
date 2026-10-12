# REVIEW r1875: L222 item 1's rotation invariance, Sjk_rot

Gate 2 on [lean/HamiltonsCubic/Results/L222Rot.lean](../lean/HamiltonsCubic/Results/L222Rot.lean) in the working tree on top of 51da4581 (the file is staged, uncommitted), against Lemma L222 item 1 of [findings/second-order.md](../findings/second-order.md) and the L222 row of [lean/INDEX.md](../lean/INDEX.md). Analysis only: the one run was `lake env lean` on a scratch file for `#print axioms`, seconds long. Every step of the proof was re-derived by hand from the consumed statements.

| Claim | Verdict |
|---|---|
| sum_vy, $\sum_c(\mathrm{vy}\,f)_c=\sum f-f_j-f_k$ at $j\ne k$ | CONFIRMED |
| Sjk_rot, $R\cdot(D+\nu)=D'+\nu'$ with $D'$ Weyl of character $1$ and $\nu'$ Weyl of character $\varepsilon_j\varepsilon_k$, $R=\mathrm{Rot}_{jk}(c,s)$, $c^2+s^2=1$ | CONFIRMED |
| Fidelity to L222 item 1's rotation clause | CONFIRMED WITH OBSERVATIONS |
| lean/INDEX.md, the L222 row's L222Rot sentence and owed text | CONFIRMED |
| Record header of L222 | STALE, see O1 |
| Axiom audit | CONFIRMED, 2/2 on the standard three |

**Summary.** Sjk_rot is a faithful and correctly hypothesised statement of "preserved by rotations in the $(j,k)$-plane" in the mapped-into sense, every hypothesis is used, and nothing downstream needs onto, but the L222 record header still lists item 1's rotation invariance as owed.

## A. Hypothesis inventory

- `hjk : j ≠ k` is used by sum_vy, pair_eq_nuX, Dminus_weight, rot_even, rot_Dminus, rot_nuX, nuX_char and nuX_weyl. It is also necessary for sum_vy (section C).
- `hcs : c^2+s^2=1` is used by rot_even, rot_Dminus and rot_nuX (through Rot_diag_fix, which needs the diagonal with equal $j,k$ entries to be fixed).
- `hDW` and `hD` are consumed by trivial_block_iff to produce the weight $w$ with $D=\mathrm{coordOp}\,w$.
- `hνW` and `hν` are consumed by pair_eq_nuX to produce $x$ with $x_j=x_k=0$, $\sum x=0$, $\nu=\nu_x$. After the `rfl` substitution `hνW` is reused as the Weyl property of $\nu_x$ in the last goal.
- No hypothesis is idle and none is stronger than the record's. The statement is non-vacuous: $D=\nu=0$ satisfies every hypothesis, and so does any diagonal Weyl $D$ with $\nu=0$.
- The Lean carries no $n\ge4$. The record's Statement assumes it, so the Lean is the more general.

## B. The rotation and its action

- [PairSquare.lean](../lean/HamiltonsCubic/Results/PairSquare.lean) defines `Rot j k c s` with column $j$ equal to $c\,e_j+s\,e_k$, column $k$ equal to $-s\,e_j+c\,e_k$, and the identity elsewhere. So $\mathrm{Rot}\,e_j=c\,e_j+s\,e_k$, $\mathrm{Rot}\,e_k=-s\,e_j+c\,e_k$, which is $e^{\varphi\xi}$ at $c=\cos\varphi$, $s=\sin\varphi$ with the record's $\xi e_j=e_k$.
- $\mathrm{Rot}^{\mathsf T}\mathrm{Rot}$ is the identity off the $(j,k)$ block and $\begin{pmatrix}c^2+s^2&0\\0&c^2+s^2\end{pmatrix}$ on it, so $c^2+s^2=1$ is exactly orthogonality. The determinant is $c^2+s^2=1$, so the family is exactly $SO(2)$ in the plane, the record's "rotations". Reflections of the plane are outside the quantifier, as they are outside the record's word.
- [FrameOp2.lean](../lean/HamiltonsCubic/Results/FrameOp2.lean): `cU U X = Uᵀ X U` and `rotR U V X = U · V(Uᵀ X U) · Uᵀ` (rotR_coe). Identifying a curvature operator with a map on skew matrices $\cong\Lambda^2$, this is $V\mapsto\Lambda^2U\circ V\circ\Lambda^2U^{-1}$ at orthogonal $U$, the conjugation action $R\cdot W=RWR^{\mathsf T}$ on $\Lambda^2$. The direction ($U$ against $U^{\mathsf T}$) only replaces $\varphi$ by $-\varphi$, which leaves the set of rotations unchanged.

## C. The even/odd split and sum_vy

- $y_a=(w_{ja}-w_{ka})/2$. The hys computation: $\sum_c(\mathrm{vy}\,y)_c=\sum y-y_j-y_k$. Here $\sum y=(\sum_c w_{jc}-\sum_c w_{kc})/2=0$ by the row sums, $y_j=(0-w_{kj})/2$ and $y_k=(w_{jk}-0)/2$ by hollowness, so $y_j+y_k=(w_{jk}-w_{kj})/2=0$ by symmetry. The sum vanishes, and Dminus_weight makes $D^-_y$ a weight.
- hevs: for $a\notin\{j,k\}$, $(D^-_y)_{ja}=\mathrm{uj}_j\,y_a+(\mathrm{vy}\,y)_j\,\mathrm{uj}_a=y_a$ and $(D^-_y)_{ka}=-y_a$. So $\mathrm{ev}_{ja}=w_{ja}-y_a=(w_{ja}+w_{ka})/2$ and $\mathrm{ev}_{ka}=w_{ka}+y_a=(w_{ja}+w_{ka})/2$. Equal, which is rot_even's hypothesis. hevT follows from the symmetry of $w$ and of $D^-_y$.
- The values $y_j,y_k$ do not enter $D^-_y$, whose definition reads $y$ only through $\mathrm{vy}$. The same holds for $\nu_y$ (hyy rewrites $\nu_y=\nu_{\mathrm{vy}\,y}$), which is why nuX_char can be applied at $\mathrm{vy}\,y$, zero at $j,k$ with sum $0$ by hys.
- sum_vy at $j=k$ would be false: $\mathrm{vy}$ then zeroes one coordinate, the sum is $\sum f-f_j$, and the formula gives $\sum f-2f_j$. The hypothesis $j\ne k$ is required and present. The record's Statement also assumes $j\ne k$.
- The $D'$ weight is $w-D^-_y+(c^2-s^2)D^-_y-2cs\,D^-_x$, a weight by three uses of isWeight_add_smul, and hD'eq matches it to $\mathrm{coordOp}\,\mathrm{ev}+(c^2-s^2)\mathrm{coordOp}\,D^-_y-2cs\,\mathrm{coordOp}\,D^-_x$ by linearity of coordOp. The $\nu'$ is $2cs\,\nu_y+(c^2-s^2)\nu_x$, Weyl by nuX_weyl and closure under sums and scalars, of character $\varepsilon_j\varepsilon_k$ by nuX_char twice and signChar closure.

## D. Into or onto

- The record's proof of item 1 argues by commutation: a rotation of the $(j,k)$-plane commutes with every flip outside $\{j,k\}$ and with $\varepsilon_j\varepsilon_k$, so it maps the fixed space into itself. Onto then follows because the inverse is again such a rotation. The Lean proves into.
- Onto follows from into in two lines: apply Sjk_rot at $\mathrm{Rot}(c,-s)$ and use $\mathrm{rotR}(\mathrm{Rot}(c,s))\circ\mathrm{rotR}(\mathrm{Rot}(c,-s))=\mathrm{id}$, a fact of FrameOp2's functoriality that is not stated in this file.
- No declaration in [lean/](../lean/) consumes Sjk_rot (grep of lean/HamiltonsCubic and lean/HamiltonsCubic.lean: only the import line). In the record, L224 step 5 uses the rotation to write the equality case as $W=e^{\varphi\xi}\cdot W'$, which [L224EqRot.lean](../lean/HamiltonsCubic/Results/L224EqRot.lean) constructs directly by `assemble`, needing neither into nor onto. Onto is needed nowhere downstream.
- Sjk_rot does close [r1825](REVIEW_r1825.md) O2, the closure $e^{\varphi\xi}\cdot\mathcal D_n\subseteq\mathcal S_{jk}$ (take $\nu=0$), which r1825 recorded as unstated. See O2.

## E. The INDEX row

- The L222 row adds L222Rot.lean to the file list and a sentence "Item 1's rotation invariance, PROVED" naming Sjk_rot, its hypotheses and conclusion, the proof's route through rot_even, rot_Dminus and rot_nuX with $y_a=(w_{ja}-w_{ka})/2$, sum_vy, and standard three axioms. Each part matches the file.
- The state **partial** is right. Item 5 is still owed: the infinitesimal form $\xi\cdot D\in V_{jk}$ with coordinates $K_{ja}-K_{ka}$, $\xi\cdot\nu\in\mathcal D_n$ with $\lVert\xi\cdot\nu\rVert^2=4\lVert\nu\rVert^2$, and the minimising-angle conditions $\langle x,K_{j\cdot}-K_{k\cdot}\rangle=0$ and $\lVert\nu\rVert^2\le\tfrac12\sum_a(K_{ka}-K_{ja})^2$. Only the scalar step pair_mass_le is typed, and the finite action (L224Rot) is proved. The row says exactly this, plus the generality item for normSq2_nuX (r1804 O2).
- The row does not yet cite a Gate 2 for L222Rot, which is this review.

## F. Axioms

`#print axioms` on a scratch file importing HamiltonsCubic.Results.L222Rot, run with `lake env lean` (exit 0): Sjk_rot and sum_vy each depend on [propext, Classical.choice, Quot.sound], the standard three. No sorryAx and no project axiom.

## G. The breaking object

- A breaker would be a rotation $R=\mathrm{Rot}_{jk}(c,s)$ and a pair $D,\nu$ meeting the hypotheses with $R\cdot(D+\nu)$ carrying a component of some other character: a pair character $\varepsilon_a\varepsilon_b$ with $\{a,b\}\ne\{j,k\}$ or a four-set character $\chi_Q$. Equivalently, a weight $w$ whose image under $R$ leaves the diagonal-plus-$V_{jk}$ span.
- The proof is kernel-checked, so a breaker can only come from a transcription gap. I looked for three: (1) $j=k$, where sum_vy fails, excluded by `hjk`; (2) $c^2+s^2\ne1$, where Rot is not orthogonal and rot_even's fixing of the equal-entry diagonal fails, excluded by `hcs`; (3) a mismatch between rotR and the record's conjugation, ruled out in section B.
- By hand, a general swap-odd weight entry at $(j,k)$ is the first place a leak could hide: $w_{jk}$ lies in the swap-even part (ev keeps it since $D^-_y$ has zero $(j,k)$ entry), and rot_even's split carries it through the term $\tfrac{e_{jk}}2(PP^{\mathsf T}-uu^{\mathsf T})$ with $P=e_j+e_k$, $u=e_j-e_k$, whose $(j,k)$ entry is $e_{jk}$, and rot_even (Gate 2 [r1824](REVIEW_r1824.md)) fixes the whole coordinate operator. No leak.
- No numerical screen was run, per the footing.

## Observations

- **O1.** The L222 header in [findings/second-order.md](../findings/second-order.md) (line 1591) still says "The Lean owes item 1's rotation invariance and item 5". With Sjk_rot proved it should read that the Lean owes item 5, and name Sjk_rot in L222Rot.lean for item 1's rotation clause. The same header calls OddPart's Gate 2 r1806 "pending", while the INDEX row records r1806 as CONFIRMED WITH OBSERVATIONS.
- **O2.** Sjk_rot at $\nu=0$ is the closure $e^{\varphi\xi}\cdot\mathcal D_n\subseteq\mathcal S_{jk}$ that [r1825](REVIEW_r1825.md) O2 recorded as unstated. The L224 row's sentence "the closure $e^{\varphi\xi}\cdot\mathcal D_n\subseteq\mathcal S_{jk}$ and $\mathrm{Rot}_{jk}(c,s)=e^{\varphi\xi}$ hold by reading and are untyped (O2, O3)" can now cite Sjk_rot for the first half. The second half (r1825 O3) stays by reading.
- **O3.** The Lean proves "mapped into". Onto is a two-line corollary through the inverse rotation $\mathrm{Rot}(c,-s)$ and is consumed nowhere. A docstring sentence saying the record's "preserved" is read as mapped into, with onto by the inverse, would pre-empt the question.
- **O4.** Sjk_rot quantifies over the two summands rather than over a membership predicate for $\mathcal S_{jk}$. L222Op's `InSjk` exists, and a restatement `InSjk W → InSjk (rotR (Rot j k c s) W)` (with the Weyl property) would match item 1's wording and Sjk_mul's form. This is presentation, the content is the same.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** Sjk_rot proves item 1's rotation clause in the mapped-into sense on the standard three axioms, which is all any consumer needs. O1, the stale "owes item 1's rotation invariance" in the L222 record header, should be folded with this review. O2 lets the L224 row cite Sjk_rot for r1825 O2. O3 and O4 are presentation.
