# Reviewer r1838, L220 steps 6 and 7, the norm split and the character lemma in FourStep67.lean, and the r1835 repairs of f57c6be9

Cold Gate 2 review of commits f206153f and f57c6be9 against [findings/second-order.md](../findings/second-order.md) Lemma L220 (setting, steps 3 to 7 and step 9's norm split) and against the consumer `theta_sq_le` in [L220Statement.lean](../lean/HamiltonsCubic/Results/L220Statement.lean). Everything was read from the Lean source and the record, and derived by hand. Runs, all on objects in hand: `#print axioms` and `#check` on the five theorems, two `example` instantiations showing `step6` and `norm_split` non-vacuous, one `example` testing whether `inner_char_four`'s distinctness hypotheses are needed, and a module build of `HamiltonsCubic.Results.FourStep67`. The scratch file is `/private/tmp/r1838/Check.lean` (0 errors). Heartbeats in [agent_logs/review-r1838.log](../agent_logs/review-r1838.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | `inner_char_four`: Weyl operators of characters $1$ and $\chi_Q$ are orthogonal | CONFIRMED WITH OBSERVATIONS |
| 2 | `P_PiQ`, `P_PiQ_zero`: $P(\Pi_Q(x,y,z))=2(x^3+y^3+z^3)+12xyz$, which is $18xyz$ at $x+y+z=0$ | CONFIRMED |
| 3 | `step7`: $6P(q)\le\theta^3$ at $x+y+z=0$, $\theta\ge0$, $3\lVert q\rVert^2=\theta^2$ | CONFIRMED WITH OBSERVATIONS |
| 4 | `step6`: $P(q)+\langle r\circ r,q\rangle+\tfrac\theta2\lVert\nu\rVert^2=\theta\lVert q\rVert^2$ | CONFIRMED WITH OBSERVATIONS |
| 5 | `norm_split`: $\lVert q+r+\nu\rVert^2=\lVert q\rVert^2+\lVert r\rVert^2+\lVert\nu\rVert^2$ | CONFIRMED |
| 6 | lean/INDEX.md, the two L220 rows' owed lists after f57c6be9 | CONFIRMED WITH OBSERVATIONS |
| 7 | `omit hij hik hil hjk hjl hkl in` on `double_single` | CONFIRMED |

**Summary:** all five theorems say what the record's steps say (two of them in a strictly more general form), compose with `step5`, `Lq_eigen`, `L220_split` and `theta_sq_le` as claimed, rest on the standard three axioms, and are non-vacuous. The one bookkeeping defect found lies outside the two commits: the record's own L220 header still lists steps 5, 6, 7 and the norm split as owed by the Lean (O5).

## 1. Statement fidelity (attack line A)

- **`step6`'s `hsplit`** is `foxProd2 (q + r) (q + r) + foxProd2 ν ν = θ • (q + r)`. This is the first conjunct of `L220_split` (BlockSub.lean:191) with $D$ written as $q+r$, so it is the record's step 3 equation $D\circ D+\nu\circ\nu=\theta D$. `foxProd2_self` gives `foxProd2 X X = Qop2 X`, so $Q(D+\nu)=D\circ D+2D\circ\nu+\nu\circ\nu$ with $\circ$ = `foxProd2`, and $L_D\nu$ is `foxProd2 D ν` with no extra factor.
- **`step6`'s `heig`** is `(2 : ℝ) • foxProd2 q ν = θ • ν`, the record's $L_q\nu=\tfrac\theta2\nu$ under that normalisation. It is literally the conclusion of `Lq_eigen` (FourStep4.lean:102) with its free `q` instantiated to `coordOp (PiQ i j k l x y z)`, and `Lq_eigen` takes `L220_split`'s second conjunct at $D=q+r$ as its `hD`. So `heig` is available from existing lemmas with no rewriting. It is also exactly `step5`'s hypothesis `h`, so one term feeds both.
- **`hperp`**, `∀ a b c, a + b + c = 0 → innerOp2 r (coordOp (PiQ i j k l a b c)) = 0`, is $r\perp\Pi_Q$, since the setting defines $\Pi_Q$ as exactly the operators $\Pi_Q(a,b,c)$ with $a+b+c=0$. The proof uses it at two points of $\Pi_Q$: at $(x,y,z)$ for $\langle r,q\rangle=0$, and at the coordinates of $q\circ q$ (through `PiQ_closed`) for $\langle q\circ r,q\rangle=\langle r,q\circ q\rangle=0$. A hypothesis at the single point $(x,y,z)$ would not suffice, as $q\circ q$ is in general a different point of $\Pi_Q$.
- **$\kappa$** is `innerOp2 (foxProd2 r r) q`, which is $\langle r\circ r,q\rangle$, the record's first definition of $\kappa$. The record's second form $\langle L_qr,r\rangle$ is one application of `inner_fox_move` away (O3).
- **The right side.** The record writes $\tfrac{\theta^3}3$, which is $\theta\lVert q\rVert^2$ only after step 5's $\lVert q\rVert^2=\theta^2/3$. Lean keeps $\theta\lVert q\rVert^2$, which is the consumer's form (`hpair`'s right side is `θ * a`) and holds with no appeal to step 5, $\nu\ne0$ or $\theta>0$. This is a strengthening.
- **Generality of `step6`.** It asks for $r$ Weyl and orthogonal to $\Pi_Q$, with no character-$1$ hypothesis, and for $\nu$ Weyl, with no character-$\chi_Q$ hypothesis. The record's $r\in\mathcal D_n\ominus\Pi_Q$ and $\nu\in V_Q$ satisfy both, so every record instance is covered. The character hypotheses are spent upstream, in `Lq_eigen`, which is where the record spends them (step 4).
- **`step7`** says $6P(q)\le\theta^3$ from $x+y+z=0$, $\theta\ge0$ and $3\lVert q\rVert^2=\theta^2$, which is the record's $P(q)\le\tfrac{\theta^3}6$ at step 5's norm. The record's intermediate $P(q)\le\tfrac{\sqrt3}2\lVert q\rVert^3$ is absorbed into the proof, and its equality clause is left out (O2).
- **`P_PiQ`.** Hand check: at $x+y+z=0$, $x^3+y^3+z^3=3xyz$, so $2(x^3+y^3+z^3)+12xyz=18xyz$, matching `P_PiQ_zero` and the record. The screen instance below gives $P(\Pi_Q(2,-1,-1))=36=18\cdot2$, which agrees.
- **`norm_split`** asks for $r$ Weyl of character $1$ orthogonal to $\Pi_Q$ and $\nu$ Weyl of character $\chi_Q$. These are the record's $r\in\mathcal D_n\ominus\Pi_Q$ and $\nu\in V_Q$ as the L220 row types them elsewhere (`Lr_zero` uses the same hypotheses), and the conclusion is step 9's $\lVert W\rVert^2=\lVert q\rVert^2+\lVert r\rVert^2+\lVert\nu\rVert^2$.

No hypothesis is stronger than the setting provides, and none that the record uses is missing.

## 2. Hypothesis inventory and non-vacuity (attack line B)

| Theorem | Hypothesis | Used for |
|---|---|---|
| all in the section | `hij … hkl` | `PiQ_mul`, `PiQ_weight`, `normSq2_PiQ` (and the `include` puts them on every theorem) |
| `P_PiQ` | none besides the six | `PiQ_mul`, `inner_PiQ`, `PiQ_T` |
| `P_PiQ_zero` | `hs` | substitution $z=-x-y$ |
| `step7` | `hs`, `hθ`, `ha` | `P_PiQ_zero`, the sign of $\theta^3$ in the final `nlinarith`, and the norm through `normSq2_PiQ` |
| `step6` | `hs` | `PiQ_weight`, so $q$ is Weyl, and `PiQ_closed` |
| `step6` | `hrW`, `hνW` | self-adjointness for `inner_fox_move` |
| `step6` | `hperp` | $\langle r,q\rangle=0$ and $\langle r,q\circ q\rangle=0$ |
| `step6` | `hsplit`, `heig` | the paired equation and $\langle\nu\circ\nu,q\rangle=\tfrac\theta2\lVert\nu\rVert^2$ |
| `norm_split` | `hs` | $q$ Weyl of character $1$ |
| `norm_split` | `hrW`, `hr`, `hνW`, `hν` | the two calls of `inner_char_four` |
| `norm_split` | `hperp` | $\langle q,r\rangle=0$ at $(x,y,z)$ |
| `inner_char_four` | `hij`, `hik`, `hil` | the `simp` evaluating `setChar` (O1) |

Every hypothesis is used, and none is vacuous. Two instances were checked in Lean and typecheck (screens of satisfiability, nothing more):

- **`step6`** at $q=\Pi_Q(2,-1,-1)$, $r=0$, $\nu=0$, $\theta=3$. By `PiQ_mul`, $q\circ q=\Pi_Q(6,-3,-3)=3q$, so `hsplit` holds, `heig` reads $0=0$, and the conclusion is $P(q)=3\lVert q\rVert^2=36$.
- **`norm_split`** at $q=\Pi_Q(2,-1,-1)$, $r=0$, $\nu=\sigma_A$ (`sig4 i k j l`, with `sig_weyl` and `sigA_char`), a nonzero element of $V_Q$.
- **`step7`** by hand at the same $q$: $\lVert q\rVert^2=2\cdot6=12$, $\theta=6$ satisfies $3\cdot12=36=\theta^2$, and $6P(q)=216=\theta^3$. The instance sits at equality, as the record's $S^2\times S^2$ shape $(2,-1,-1)$ should.

The `step6` instance has $\nu=0$. The record's own witness, padded $W_{\mathbb{CP}^2}$ with $\nu=t(2\sigma_A+\sigma_B)$, would exercise the $\nu$ term. It was not built, because doing so needs `nu_sq` and a computation of $q\circ\nu$, and non-vacuity of the hypothesis set is already shown.

## 3. Composition (attack line C)

- `step5` exports `θ ^ 2 = 3 * normSq2 q` from `hs`, `hνW`, `hν`, `hν0` and the same `h` as `step6`'s `heig`. `step7`'s `ha` is `3 * normSq2 q = θ ^ 2`, its symmetric form, and so is `theta_sq_le`'s `ha : 3 * a = θ ^ 2` at `a := normSq2 q`. The chain composes through `.symm`.
- `theta_sq_le`'s `hθ : 0 < θ` gives `step7`'s `0 ≤ θ` through `le_of_lt`.
- `step6`'s conclusion is `hpair` at `p := Pcubic2 q`, `κ := innerOp2 (foxProd2 r r) q`, `N := normSq2 ν`, `a := normSq2 q`, up to `θ / 2 * N` against `θ * N / 2`, which `linarith` or `ring_nf` closes.
- `norm_split`'s conclusion is `hunit` at `R := normSq2 r` once the consumer supplies `normSq2 (q + r + ν) = 1`, which is the unit hypothesis on $W=D+\nu$ with $D=q+r$. `hR` and `hN` are `normSq2_nonneg` (SphereCurve.lean:53).
- What the composition still needs and no lemma yet provides: the decomposition itself, that a Weyl $D$ of character $1$ is $q+r$ with $q=\Pi_Q(x,y,z)$, $x+y+z=0$, and $r$ Weyl of character $1$ orthogonal to $\Pi_Q$. A search of `Results/` for a projection onto $\Pi_Q$ found none (O4).

## 4. `inner_char_four` (attack line D)

- With $\varepsilon$ equal to $-1$ at $i$ and $1$ elsewhere, character $1$ gives `rotR (signMat ε) A = A`, and `setChar {i, j, k, l} ε` is $\prod_{p\in\{i,j,k,l\}}\varepsilon_p=-1$, since $i$ occurs once in the `Finset` and every other element is $1$. So `rotR (signMat ε) B = -B`, and `inner_flip_zero` gives $\langle A,B\rangle=0$. The bookkeeping is right.
- The three hypotheses are not needed mathematically. A `Finset` holds $i$ once however $j,k,l$ coincide with it, so the product is $-1$ with no distinctness. The scratch file proves `setChar {i, j, k, l} (fun p => if p = i then -1 else 1) = -1` for arbitrary `i j k l` through `Finset.prod_ite_eq_of_mem'`, and it typechecks (O1).

## 5. Axioms (attack line E)

`#print axioms` on `step6`, `step7`, `norm_split`, `inner_char_four` and `double_single`: each depends on `[propext, Classical.choice, Quot.sound]` and nothing else.

## 6. INDEX bookkeeping (attack line F)

- **Statement row.** Its owed list is now the $n\ge12$ clause, the equality case at the operators (r1792 O6), and step 8's spectrum of $\hat q$ and $\kappa$ bound. It says steps 2, 4, 5, 6 and 7 and the norm split are proved in the result row. That matches the Lean: `step5` in FourStep5.lean, `step6`, `step7` and `norm_split` in FourStep67.lean, `Lq_eigen` and `mixed_sq` in FourStep4.lean. The earlier list's "the eigenvalue step (r1790 O6)" is step 5 and is rightly dropped.
- **Result row.** It records FourStep67's five theorems with the standard axioms and cites r1835 beside r1831 and r1832. Its owed list names the $n\ge12$ clause, the equality case, step 8 (`hκ`), and the assembly through `theta_sq_le` and `equality_case`. That matches the Lean.
- Neither row owes something proved, and neither claims something unproved. The statement row omits the assembly, and neither row names the $D=q+r$ decomposition as an ingredient (O4).
- The record's L220 header in [second-order.md](../findings/second-order.md) is stale (O5).

## 7. `double_single` (attack line G)

`#check @double_single` shows `∀ {n} (p q : Fin n) (b : Matrix (Fin n) (Fin n) ℝ), ∑ a, ∑ c, vecMulVec (Pi.single p 1) (Pi.single q 1) a c * b a c = b p q`. That is the same statement with the six unused distinctness binders removed, and it is true with none of them. The only caller is `inner_PiQ` (FourStep5.lean:58), which now passes `double_single` bare to `simp only`. A grep of `lean/HamiltonsCubic` finds no other use. `lake build HamiltonsCubic.Results.FourStep67`, which imports FourStep5, completed with 0 errors (8914 jobs), so the statement and its caller compile.

## 8. What would break each statement (attack line H)

- **`step6`**: a Weyl $r\perp\Pi_Q$ and a Weyl $\nu$ satisfying `hsplit` and `heig` where the identity fails. None can exist, because the proof is a linear pairing: $\langle(q+r)\circ(q+r),q\rangle$ expands with $\langle q\circ r,q\rangle=0$, and $\langle\nu\circ\nu,q\rangle=\langle q\circ\nu,\nu\rangle$ by `inner_fox_move`. What would break the statement is a weaker `hperp` (one point instead of all of $\Pi_Q$), and I checked that the proof uses the second point.
- **`step7`**: a pattern with $x+y+z=0$ and $(18xyz)^2>\tfrac34(2(x^2+y^2+z^2))^3$. `pattern_cubic_sq_le` excludes it. By hand, at $(2,-1,-1)$ both sides are $1296$, the equality point, and at $(1,-1,0)$ the left side is $0$.
- **`norm_split`**: a Weyl pair of characters $1$ and $\chi_Q$ with nonzero inner product. The flip at $i$ is an isometry (`innerOp2_rotR`) fixing one and negating the other, so none exists.
- **`inner_char_four`**: the same object. The Lean instance with $\nu=\sigma_A\ne0$ is consistent with it.
- **INDEX**: a proved item still listed as owed, or an owed item listed as proved. I compared each listed name with the source and found none in lean/INDEX.md. The record's header does have this defect (O5).

## Observations

- **O1.** `inner_char_four`'s `hij`, `hik`, `hil` are not needed, since `setChar {i, j, k, l}` is $-1$ at the flip at $i$ for any $j,k,l$. Dropping them would make it a lemma about any `Finset` containing $i$. This is cosmetic, because every caller has the hypotheses in scope.
- **O2.** `step7` leaves out the record's equality clause ("equality at the $S^2\times S^2$ shape"). It falls under the owed "equality case at the operators", and the INDEX rows could say that step 7's equality clause is part of it.
- **O3.** `step6`'s $\kappa$ is $\langle r\circ r,q\rangle$. Step 8's bound will be proved on $\langle L_qr,r\rangle=\langle q\circ r,r\rangle$, so the consumer needs one `inner_fox_move` rewrite (or `innerOp2_comm` plus it) to match `hκ`'s $\kappa$.
- **O4.** The assembly needs a lemma that a Weyl $D$ of character $1$ splits as $\Pi_Q(x,y,z)+r$ with $x+y+z=0$ and $r$ Weyl of character $1$ orthogonal to $\Pi_Q$ (the orthogonal projection onto $\Pi_Q$). No such lemma exists yet. The result row's "assembly of steps 1 to 8" covers it only implicitly, and the statement row does not list the assembly at all. Naming the projection in both owed lists would make the remaining work explicit.
- **O5.** The record's L220 italic header in [second-order.md](../findings/second-order.md) still says "The Lean owes the norm split, step 6's pairing, steps 7 and 8 at the operators, the eigenvalue step, …". Step 5 (the eigenvalue step), step 6, step 7 and the norm split are now proved, in FourStep5.lean and FourStep67.lean, and neither file is cited there. The header should cite them and owe only step 8, the assembly, the $n\ge12$ clause and the equality case.

## Overall verdict

CONFIRMED WITH OBSERVATIONS. `step6`, `step7`, `norm_split`, `P_PiQ`, `P_PiQ_zero` and `inner_char_four` are faithful to L220 steps 6, 7 and 9's norm split. They are non-vacuous, use every hypothesis, and supply `theta_sq_le`'s `hpair`, `hp` and `hunit` as claimed. The f57c6be9 repairs are correct. The remaining work is step 8, the projection onto $\Pi_Q$, the assembly, and the record header's stale owed list (O5).
