# REVIEW r1739: L264Support.lean against L264 (1)

**Verdict: CONFIRMED WITH OBSERVATIONS.** [L264Support.lean](../lean/HamiltonsCubic/Results/L264Support.lean) states L264 (1) faithfully at $\mathfrak{so}(n)$, $n\ge3$, and its proofs are sound as read. The INDEX rows for L260, L264 and L273 claim only what is typed.

Read from the staged working tree. The olean for `L264Support` (00:07) postdates the source (00:02), so the file compiled. `lake build` was not run (another session holds the build). Standing rule observed: analysis only, no computation run.

## Source

[findings/second-order.md](../findings/second-order.md), Lemma L264 (1): "Let $X$ maximise $F$ on the unit sphere of $\mathop{\mathrm{Sym}}^2\mathfrak{so}(n)$, taken positive semidefinite by L260 (1). Then $C=X/F(X)$ is an idempotent, positive definite on the semisimple subalgebra $\mathfrak h$ it is supported on, and stable: $\langle C\#H,H\rangle\le\tfrac12\lVert H\rVert^2$ for every $H\perp C$."

## Answers

1. **The maximisation hypotheses are faithful.** $\mathop{\mathrm{Sym}}^2\mathfrak{so}(n)$ is the set of self-adjoint operators on $\Lambda^2$, so `IsSelfAdjoint2 X`, `normSq2 X = 1` and `hmax` (every self-adjoint unit $Y$ has $F(Y)\le F(X)$) render "maximises $F$ on the unit sphere" exactly. `IsPSD2 X` is the record's "taken positive semidefinite by L260 (1)", entered as a hypothesis and shown attainable by `L264_one_exists`. L260 (1) at self-adjoint $X$ (`L260_psd_cone`) suffices here because every point of the sphere is self-adjoint.
2. **`maximiser_pos` computes correctly.** `Ftri_smul_left/mid/right` give $s^3F(I,I,I)$, and `Ftri_id` at $C=I$ gives $(n-2)\langle I,I\rangle=(n-2)\lVert I\rVert^2$, so $F(sI)=s^3(n-2)\lVert I\rVert^2=(n-2)/\lVert I\rVert$ at $s=1/\sqrt{\lVert I\rVert^2}$. `normSq2_smul'` gives $\lVert sI\rVert^2=s^2\lVert I\rVert^2=1$ by `Real.sq_sqrt`. Then $0<F(sI)\le F(X)$ by `hmax` at the self-adjoint $sI$. `normSq2_id_pos` is sound: $I\ne0$ because $I\varphi_{ij}$ has entry $(j,i)$ nonzero at $i\ne j$, and definiteness (`normSq2_eq_zero`) gives $\lVert I\rVert^2\ne0$. With $\lVert I\rVert^2=N$, the value is $(n-2)/\sqrt N$, consistent with $I\#I=(n-2)I$.
3. **The support clause matches, with one untyped step.** Bracket closure plus $\mathop{\mathrm{range}}C=\mathop{\mathrm{span}}[\mathop{\mathrm{range}}C,\mathop{\mathrm{range}}C]$ says the range is a perfect subalgebra, and $\langle CA,A\rangle>0$ on nonzero $A$ in the range is positive definiteness there. Perfect implies semisimple inside compact $\mathfrak{so}(n)$ (a compact Lie algebra is its centre plus a semisimple ideal, and a perfect one has zero centre). This step is prose, as both the docstring and the row say. "Supported on" is the range: $C$ is self-adjoint (`isSelfAdjoint2_smul hX`, inside the proof), so $\mathop{\mathrm{range}}C=(\ker C)^\perp$. See O1.
4. **`IsStable` is the record's stability.** `Ftri C H H` is $\langle C\#H,H\rangle$ by `Ftri`'s docstring. $H\perp C$ is `innerOp2 H C = 0`, and the norm is `normSq2` in the same pairing. The record's "every $H\perp C$" ranges over the tangent space of $\mathop{\mathrm{Sym}}^2\mathfrak{so}(n)$, whose elements are exactly the self-adjoint operators. So the self-adjoint restriction is the record's own scope. The record's closing line "the maximiser is stable on all of $\mathop{\mathrm{Sym}}^2\mathfrak{so}(n)$" confirms that reading.
5. **The INDEX rows are faithful.**
   - The L264 row adds `L264_one` and `L264_one_exists` with the $n\ge3$ scope and `maximiser_pos`'s value. It correctly moves the owed item from "(1)'s positive definiteness of $C$ on its support" to "perfect to semisimple". It still owes (2)'s cross block $E$, and (3)'s reduction to simple subalgebras stays prose, as stated earlier in the row. The row stays **partial**, which is correct.
   - The L260 row now reads "(4) is typed at $\mathfrak h=\mathfrak{so}(n)$ and prose at a proper semisimple $\mathfrak h$". This resolves r1738 O1 and is accurate.
   - The L273 row now reads "$\Psi_\kappa$ lives in the record only". This is r1738 O3's positive rewording and keeps the same content.
   - The composition in `L264_one` is exact. `maximiser_pos` feeds `L264_maximiser_stable`'s `hpos`. $C$ is self-adjoint and PSD by `isPSD2_smul` with $1/F(X)>0$. `L260_range_subalgebra` then applies to $C$. Lean's convention $1/0=0$ is never reached, because $F(X)>0$ is proved.
   - The hypotheses are satisfiable at $n\ge3$ by `L264_one_exists`, so the theorem is not vacuous.

## Falsifiers

- `normSq2_id_pos`: an $n\ge2$ at which $I=0$ on $\Lambda^2$.
- `maximiser_pos`: a self-adjoint unit maximiser with $F(X)\le0$ at $n\ge3$. $F(I/\lVert I\rVert)=(n-2)/\sqrt N>0$ excludes it. At $n=2$, $\mathfrak{so}(2)$ is abelian and $F\equiv0$, which is why $n\ge3$ is needed.
- `L264_one`: a PSD unit maximiser with $C\#C\ne C$, or a self-adjoint $H\perp C$ with $F(C,H,H)>\tfrac12\lVert H\rVert^2$, or a bracket of range elements leaving the range, or a range with an abelian ($\mathfrak u(1)$) summand that brackets do not span, or a nonzero $A$ in the range with $\langle CA,A\rangle=0$.
- `L264_one_exists`: an $n\ge2$ with no PSD self-adjoint unit maximiser.

## Observations

- **O1.** `L264_one`'s conclusion omits `IsSelfAdjoint2 C`, which is the fact that makes "range" equal to "support". The proof derives it as `hCsa`, so adding it to the conjunction costs one term.
- **O2.** The provenance line of L264 in [findings/second-order.md](../findings/second-order.md) still says only that (1) is proved as `L264_maximiser_stable`. It does not name `L264_one` or [L264Support.lean](../lean/HamiltonsCubic/Results/L264Support.lean). The staged change touches STATUS.md and plan-lean.md but not the findings note. This is the same drift r1738 O2 found for L260.
- **O3.** No single declaration composes `L264_one_exists` with `L264_one` into "there exists $C$ with all six properties" at $n\ge3$. The composition is immediate, and the row states the two separately, which is accurate.
