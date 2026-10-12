# r822: Gate 2 on the contraction box of L193, "Ricci annihilates the defect under one contraction"

*Cold brief: I was given the contraction box, the harmonicity box it rests on and four givens, and read [findings/diagonal-half.md](../findings/diagonal-half.md) (L179 through L193), [lean/INDEX.md](../lean/INDEX.md), [L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean) and [REVIEW_r820.md](REVIEW_r820.md). **The programme is on an analysis-only footing and I opened no numerical line of work.** Every derivation below is by hand. One machine action was a screen on an object already on disk, reported as a screen in section 7 and never as evidence for a positive claim. Log: [agent_logs/g2-contraction-r822.log](../agent_logs/g2-contraction-r822.log).*

| Claim | Verdict |
|---|---|
| **The harmonicity box**: the substitution $\alpha=\eta=\omega_i$, the factor $2$, the identification $\sum_i\lambda_i\beta(\omega_i,\omega_i)=\star\mathcal B$, the restriction to $\zeta$ in the span | **CONFIRMED**, every constant, and the normalisation needs no correction because $\beta(\omega,\omega)=\star(\omega\wedge\omega)=2\sigma(\omega)$ |
| **The contraction step is algebraically valid**: left-multiply by $\lambda_k\omega_k$, sum over $k$, collect $\big(\sum_k\lambda_k\omega_k^2\big)\star\!\mathcal B$ | **CONFIRMED.** Only associativity and right-distributivity are used, $\star\!\mathcal B$ being a common RIGHT factor. No factor crosses a product and the order $\omega_k\omega_i\beta(\omega_i,\omega_k)$ in the display is the order the step produces |
| **The resulting constraint carries new content** | **REFUTED.** Section 3 derives $2\mathcal M+R\,\star\!\mathcal B+\sum_k\lambda_kh_k\omega_k=0$ as a UNIVERSAL identity on triples, from the polarised law alone. On the harmonic locus this reads $\mathcal M=-\tfrac12R\,\star\!\mathcal B$, so the displayed constraint IS $R\,\star\!\mathcal B=0$ with $R=0$ given. It is $0\cdot\star\!\mathcal B=0$ |
| **"Whether it forces $\mathcal B=0$ is unanswered"** | **REFUTED, and it is answerable in one line.** $\mathcal M$ equals $-\tfrac12R\,\star\!\mathcal B$ on the harmonic locus, so at $R=0$ the constraint is satisfied for EVERY value of $\mathcal B$. It excludes no $\mathcal B$ whatever, so it cannot force $\mathcal B=0$ and there is nothing here for a successor to price |
| **"So a rank-three Weyl tensor at $\dim V=6$ satisfies $\sum_{i,k}\lambda_i\lambda_k\omega_k\omega_i\beta(\omega_i,\omega_k)=0$"** | **CONFIRMED as true and trivially so, by a SHORTER route than the box's.** A rank-three Weyl tensor has $\mathcal B=0$ outright ([L179](../findings/diagonal-half.md)(b)), so the harmonicity identity gives $\sum_i\lambda_i\omega_i\beta(\omega_i,\omega_k)=0$ for each $k$ SEPARATELY, and the sum vanishes term by term. **Ricci is not used at all on the class the sentence quantifies over** |
| **"the first constraint the record carries in which BOTH Weyl conditions are consumed and neither is merely tested against the other"** | **REFUTED on two counts.** [L181](../findings/diagonal-half.md) consumes both as the diagonal and the off-diagonal of the single matrix $M^{\mathsf T}\Lambda M$ and needs both to reach $\Lambda=0$, and [L183](../findings/diagonal-half.md) fuses them into the single equation $\sum_i\lambda_i\Phi(\omega_i)=0$. Both predate this box and the record's own line 790 already calls L181 an instance of the two being tied. Separately, "consumed" flatters what happens here: Ricci enters as multiplication by the zero matrix |
| **[ricci_annihilates_defect](../lean/HamiltonsCubic/Results/L193Statement.lean) is the step it claims** | **CONFIRMED as a faithful transcription, and it certifies nothing geometric.** `starB`, `cross` and `om` are unconstrained matrices with no skewness, no $\star$, no $\wedge$ and no relation to $\mathcal B$. Worse for the box, `hId` PINS `cross k` to $-\tfrac12\,$`om k * starB`, so the theorem's content is exactly $\big(\sum_k\lambda_k\,\mathrm{om}_k^2\big)\cdot\mathrm{starB}=0$. The machine check confirms the triviality rather than the mathematics |

**One line.** *Both algebraic steps survive intact and every constant in them is right, but the object they produce is empty: the polarised law makes $2\mathcal M+R\star\!\mathcal B+\sum_k\lambda_kh_k\omega_k=0$ an identity at EVERY triple of $2$-forms, so the box's display is that identity with both defects set to zero, which is $0=0$. The open question it poses is answerable and the answer is no: the constraint holds for every $\mathcal B$ once $R=0$, so it excludes nothing. The priority claim is false against [L181](../findings/diagonal-half.md) and [L183](../findings/diagonal-half.md). **What the derivation does contain, and the box discards, is one genuine identity**: on a rank-three Weyl tensor $\sum_i\lambda_i\,\omega_i\beta(\omega_i,\omega_k)=0$ for each $k$ separately, three matrix equations rather than one, and the contraction throws two thirds of that away before recording it.*

## 0. Conventions, taken from the layer and from r820

- $\beta(\alpha,\eta)=\star(\alpha\wedge\eta)$, $\sigma(\omega)=\tfrac12\beta(\omega,\omega)$, $\mathcal B=\sum_i\lambda_i\,\omega_i\wedge\omega_i$, and $\star\!\mathcal B=\sum_i\lambda_i\beta(\omega_i,\omega_i)$ by linearity of $\star$ alone.
- The pairing on $\Lambda^2$ is `inner2`, under which the plane area forms $\varepsilon_j$ are orthonormal.
- $\mathrm{Pf}$ is `pf6`, so $\mathrm{Pf}(\sum_jc_j\varepsilon_j)=c_1c_2c_3$, and $\sigma(\sum_jc_j\varepsilon_j)=\sum_j\big(\prod_{k\ne j}c_k\big)\varepsilon_j$ with a plus on all three planes ([r820](REVIEW_r820.md), recomputed there from `star6` and `pf6`).
- Three abbreviations used throughout, all polynomial in $(\lambda,\omega)$ and defined at every triple of $2$-forms, Weyl or not:
  $$R=\sum_k\lambda_k\omega_k^2,\qquad h_k=\big\langle\star\!\mathcal B,\omega_k\big\rangle,\qquad \mathcal M=\sum_{i,k}\lambda_i\lambda_k\,\omega_k\,\omega_i\,\beta(\omega_i,\omega_k).$$
  Ricci-flatness is $R=0$ ([L180](../findings/diagonal-half.md)(1)), harmonicity at $m=3$ is $h_k=0$ for $k=1,2,3$ ([L192](../findings/diagonal-half.md)), and $\mathcal M=0$ is the box's display.

## 1. The harmonicity box, re-derived

**Located.** [findings/diagonal-half.md](../findings/diagonal-half.md), the box beginning "AND IT TURNS HARMONICITY INTO A MATRIX IDENTITY", immediately above the box under review.

Put $\alpha=\eta=\omega_i$, $\zeta$ arbitrary, into the polarised law $\alpha\beta(\eta,\zeta)+\eta\beta(\alpha,\zeta)+\zeta\beta(\alpha,\eta)=-\langle\beta(\alpha,\eta),\zeta\rangle\mathrm{Id}_6$. The first two terms collide, giving

$$2\,\omega_i\beta(\omega_i,\zeta)+\zeta\,\beta(\omega_i,\omega_i)=-\big\langle\beta(\omega_i,\omega_i),\zeta\big\rangle\mathrm{Id}_6.$$

Multiply by $\lambda_i$ and sum over $i$. The second left term becomes $\zeta\sum_i\lambda_i\beta(\omega_i,\omega_i)=\zeta\,\star\!\mathcal B$ and the right becomes $-\langle\star\!\mathcal B,\zeta\rangle\mathrm{Id}_6$, both by linearity of $\star$ and of the pairing, with **no factor to reconcile**: $\beta(\omega,\omega)$ is $2\sigma(\omega)$ and not $\sigma(\omega)$, which is exactly why $\sum_i\lambda_i\beta(\omega_i,\omega_i)$ is $\star\!\mathcal B$ on the nose. **CONFIRMED, factor $2$ and normalisation both.**

At $\zeta$ in the span, harmonicity kills the right side, since $\star(\mathcal B\wedge\zeta)=\langle\star\!\mathcal B,\zeta\rangle$ for $\mathcal B\in\Lambda^4$ and $\zeta\in\Lambda^2$ on $\mathbb R^6$, where $\star\star=+1$ on $\Lambda^4$. That is [L192](../findings/diagonal-half.md)(2) at $m=3$ read at $x$ with $w(x)=\zeta$. So

$$\zeta\,\star\!\mathcal B=-2\sum_i\lambda_i\,\omega_i\,\beta(\omega_i,\zeta),\qquad \zeta\in\mathrm{span}(\omega_1,\omega_2,\omega_3).\tag{$\dagger$}$$

**CONFIRMED as displayed.**

## 2. The contraction step is valid

**Located.** The box under review, first sentence.

Take $(\dagger)$ at $\zeta=\omega_k$, which is legitimate because $\omega_k$ lies in the span. Left-multiply by $\lambda_k\omega_k$:

$$\lambda_k\,\omega_k^2\,\star\!\mathcal B=-2\lambda_k\sum_i\lambda_i\,\omega_k\,\omega_i\,\beta(\omega_i,\omega_k).$$

Left multiplication is applied to both sides of a matrix equation, so it is sound, and on the right it lands OUTSIDE the existing product, giving the order $\omega_k\,\omega_i\,\beta(\omega_i,\omega_k)$. That is the order printed in the box's display, so **no factor is moved across a product**. Summing over $k$, the left side is $\sum_k(\lambda_k\omega_k^2)\star\!\mathcal B$, and $\star\!\mathcal B$ is a common right factor independent of $k$, so right-distributivity collects it as $\big(\sum_k\lambda_k\omega_k^2\big)\star\!\mathcal B=R\,\star\!\mathcal B$. **No commutation is invoked anywhere.** Hence

$$R\,\star\!\mathcal B=-2\,\mathcal M,\tag{$\ddagger$}$$

and $R=0$ gives $\mathcal M=0$. **The step is CONFIRMED valid.** The brief's first attack finds nothing.

## 3. The constraint is empty, and this is where the box fails

**Located.** The display $\sum_{i,k}\lambda_i\lambda_k\,\omega_k\,\omega_i\,\beta(\omega_i,\omega_k)=0$ and the sentence "Whether it forces $\mathcal B=0$ is unanswered".

Run the polarised law again, this time WITHOUT discharging anything. At $(\alpha,\eta,\zeta)=(\omega_i,\omega_i,\omega_k)$,

$$2\,\omega_i\beta(\omega_i,\omega_k)=-c_{iik}\,\mathrm{Id}_6-\omega_k\beta(\omega_i,\omega_i),\qquad c_{iik}=\big\langle\beta(\omega_i,\omega_i),\omega_k\big\rangle.$$

Left-multiply by $\lambda_i\lambda_k\,\omega_k$ and sum over both indices. The first right term gives $-\sum_k\lambda_k\big(\sum_i\lambda_ic_{iik}\big)\omega_k=-\sum_k\lambda_kh_k\omega_k$, since $\sum_i\lambda_ic_{iik}=\langle\star\!\mathcal B,\omega_k\rangle=h_k$. The second gives $-\big(\sum_k\lambda_k\omega_k^2\big)\big(\sum_i\lambda_i\beta(\omega_i,\omega_i)\big)=-R\,\star\!\mathcal B$. So

$$\boxed{\;2\,\mathcal M+R\,\star\!\mathcal B+\sum_k\lambda_k h_k\,\omega_k=0\;}\tag{$\star$}$$

**at every three $2$-forms on $\mathbb R^6$ and every three weights.** No Weyl condition, no orthonormality, no $\sum_i\lambda_i=0$ enters: $(\star)$ is a consequence of the polarised law and matrix algebra alone.

Three things follow, and each is fatal to the box's account of itself.

- **The displayed constraint is one linear combination of the two defects, and nothing else.** Reading $(\star)$, $\mathcal M=0$ is EQUIVALENT to $R\,\star\!\mathcal B+\sum_k\lambda_kh_k\omega_k=0$. That is strictly weaker than the conjunction of $R=0$ and $h_k=0$, so it adds no constraint to the Weyl class and it is not an independent equation on it.
- **The constraint holds identically in $\mathcal B$ once Ricci is imposed, so it PROVABLY does not force $\mathcal B=0$.** On the harmonic locus $(\star)$ collapses to $\mathcal M=-\tfrac12R\,\star\!\mathcal B$, which is $(\ddagger)$ again. At $R=0$ this is zero for whatever value $\star\!\mathcal B$ takes. Every harmonic Ricci-flat triple satisfies $\mathcal M=0$ whether its defect vanishes or not, so the equation cannot separate $\mathcal B=0$ from $\mathcal B\ne0$ and the question the box hands a successor has no purchase on $\mathcal B$ at all. **The box's own sentence, "the left side becomes $\big(\sum_k\lambda_k\omega_k^2\big)\star\!\mathcal B$, which is $0$", says this out loud**: the left side is the zero matrix times $\star\!\mathcal B$, and multiplying an identity by zero transfers no information.
- **On the class the display quantifies over, Ricci is not used at all.** The sentence reads "a rank-three Weyl tensor at $\dim V=6$ satisfies", and a rank-three Weyl tensor has first Bianchi in the form $\mathcal B=0$ ([L179](../findings/diagonal-half.md)(b), quoted in [L192](../findings/diagonal-half.md)'s own statement). Then $\star\!\mathcal B=0$, $(\dagger)$ reads $0=-2\sum_i\lambda_i\omega_i\beta(\omega_i,\omega_k)$, and the inner sum vanishes for each $k$ SEPARATELY. The double sum $\mathcal M$ is then zero term by term with no appeal to $R$. So "BOTH Weyl conditions are consumed" is false in the setting the sentence names, and in the weaker harmonicity-only setting Ricci is consumed as an annihilator, which is the degenerate case of consumption.

**What survives, and it is worth folding.** The three equations $\sum_i\lambda_i\,\omega_i\,\beta(\omega_i,\omega_k)=0$, $k=1,2,3$, are a real matrix constraint on a rank-three Weyl tensor at $\dim V=6$, carrying $3\times15$ scalar conditions before symmetry. The contraction collapses them to a single weighted sum, and the record then presents the collapse as the finding. **The uncollapsed form is the one a successor should price**, and it comes out of the same box with the contraction step deleted.

## 4. Exhibited: the identity $(\star)$ checked at a configuration where $\mathcal M\ne0$

The brief asks whether any triple falsifies the constraint. One does, which shows $\mathcal M=0$ is not an unconditional polynomial identity and simultaneously tests $(\star)$ on real objects.

Take $\omega_1=J=\varepsilon_1+\varepsilon_2+\varepsilon_3$ with weights $\lambda=(1,0,0)$, all quantities in section 0 being polynomials that are defined here. Then $\mathrm{Pf}(J)=1$, $\sigma(J)=J$ so $\beta(J,J)=2J$, and $J^2=-\mathrm{Id}_6$.

- $\mathcal M=\lambda_1^2\,\omega_1\omega_1\beta(\omega_1,\omega_1)=(-\mathrm{Id}_6)(2J)=-2J\ne0$.
- $R=J^2=-\mathrm{Id}_6$ and $\star\!\mathcal B=\beta(J,J)=2J$, so $R\,\star\!\mathcal B=-2J$.
- $h_1=\langle 2J,J\rangle=2\lVert J\rVert^2=6$, so $\sum_k\lambda_kh_k\omega_k=6J$.

Then $2\mathcal M+R\,\star\!\mathcal B+\sum_k\lambda_kh_k\omega_k=-4J-2J+6J=0$. **$(\star)$ holds exactly**, and $\mathcal M\ne0$ here because both defects are nonzero. *This is a hand computation on a non-Weyl configuration, used to test the identity of section 3 and not offered as evidence for any positive claim about the Weyl class.*

The brief's trace suggestion adds nothing beyond this. Taking $\operatorname{tr}$ of $(\star)$ and using $\operatorname{tr}(\omega_k)=0$ gives $2\operatorname{tr}\mathcal M=-\operatorname{tr}(R\,\star\!\mathcal B)$, which vanishes under Ricci for the same reason the matrix identity does. **The scalar collapse [r820](REVIEW_r820.md) already found inside the harmonicity box** is $\operatorname{tr}\big(\sum_i\lambda_i\omega_i\beta(\omega_i,\zeta)\big)=-2\langle\star\!\mathcal B,\zeta\rangle$, and it is a different collapse from this one.

## 5. What the Lean theorem certifies

**Located.** [ricci_annihilates_defect](../lean/HamiltonsCubic/Results/L193Statement.lean), the last theorem of the file.

The signature takes `lam : Fin 3 → ℝ`, `om cross : Fin 3 → Matrix (Fin 6) (Fin 6) ℝ` and `starB : Matrix (Fin 6) (Fin 6) ℝ`, with

```
hId : ∀ k, om k * starB = (-2 : ℝ) • cross k
hRicci : ∑ k, lam k • (om k * om k) = 0
```

and concludes `∑ k, lam k • (om k * cross k) = 0`.

**Are `starB` and `cross` free?** They are unconstrained on entry: no `IsSkew`, no `star6`, no `wedgeSelf`, no orthonormality, no tie to $\mathcal B$ or to $\beta$, and `lam` carries neither $\sum\lambda_i=0$ nor $\lambda_i\ne0$. So the theorem is a statement about arbitrary real $6\times6$ matrices, and it would type at any size.

**But `cross` is not free once `hId` is assumed, and that is the point.** `hId` is an equation solvable for `cross k`, giving `cross k = (-1/2) • (om k * starB)`. Substituting, the conclusion is

$$\sum_k\lambda_k\big(\mathrm{om}_k\cdot(-\tfrac12)\,\mathrm{om}_k\,\mathrm{starB}\big)=-\tfrac12\Big(\sum_k\lambda_k\,\mathrm{om}_k^2\Big)\mathrm{starB},$$

which `hRicci` sends to zero. The proof in the file does exactly this and no more: `hL` moves the scalar past the product and pulls `starB` out of the sum by `Finset.sum_mul`, then cancels the factor $-2$ by `smul_eq_zero`. **So the machine check certifies associativity, right-distributivity and the cancellation of a nonzero scalar.** It is a correct and faithful transcription of the step the box describes, and it verifies the diagnosis of section 3 rather than the box's account: the certified content is "the zero matrix times `starB` is zero".

**A record gap, noted and not fixed.** The [lean/INDEX.md](../lean/INDEX.md) row for L193 lists `adjugate_law`, `adjugate_law_plane`, `adjugate_law_agree`, `area_form_sq` and `starWedge_of_adjugate`, and does not mention `ricci_annihilates_defect` at all. A reader of the index cannot find the theorem the findings block cites.

## 6. The priority claim

**Located.** "This is the first constraint the record carries in which BOTH Weyl conditions are consumed and neither is merely tested against the other."

Two earlier results do exactly that, and the record says so about one of them in its own prose.

- **[L181](../findings/diagonal-half.md).** On a simultaneously block-diagonal family, Ricci-flatness is $\operatorname{diag}(M^{\mathsf T}\Lambda M)=0$ and first Bianchi is $(M^{\mathsf T}\Lambda M)_{j\ne k}=0$, so the two are the diagonal and the off-diagonal entries of one symmetric matrix and together force it to vanish. The block's own extension box states that **neither condition is redundant** and exhibits a Ricci-flat member with Bianchi sum $2\varepsilon_1\wedge\varepsilon_2\ne0$, so both are load-bearing and neither is tested against the other. It reaches a conclusion, $W=0$, which the box under review does not.
- **[L183](../findings/diagonal-half.md).** "Together they are the single equation $\sum_i\lambda_i\Phi(\omega_i)=0$" with $\Phi(\omega)=(\omega^2,\omega\wedge\omega)$. Two conditions fused into one equation in $S^2\oplus\Lambda^4$ is the cleanest instance of the property claimed, and the collinearity criterion consumes both halves jointly, joint collinearity in the direct sum being strictly stronger than collinearity in each factor.

**And the record already flags this.** [findings/diagonal-half.md](../findings/diagonal-half.md) line 790 reads "THE RECORD NOW HOLDS TWO INDEPENDENT INSTANCES OF RICCI AND BIANCHI BEING TIED", naming [L166](../findings/ungraded-slack.md) and [L181](../findings/diagonal-half.md). The contraction box asserts a priority the same file denies four hundred lines earlier.

**The neighbouring box states a narrower and defensible version**, "the first place the two Weyl conditions meet as MATRICES rather than as scalars". Even that is contestable against L181, where the object is a matrix of pairings rather than a matrix product of forms, but it is a real distinction. The contraction box drops the qualifier and inherits a false claim. **REFUTED.**

## 7. Screens

One machine action, reported as a screen and not as evidence.

- `lake build HamiltonsCubic.Results.L193Statement` completes, with `declaration uses sorry` reported at line 79 and nowhere else. Line 79 is `adjugate_law`. So `ricci_annihilates_defect` is sorry-free **as a statement about arbitrary matrices**, which is what section 5 says it is, and the file's only debt is the normal form the block already names.

No numerical work was opened. Sections 1 through 4 and 6 are by hand.

## 8. Falsifiers, and what I did to look for each

| Claim | What would falsify it | What I did |
|---|---|---|
| The harmonicity box is right | A wrong factor on the collision term, or $\sum_i\lambda_i\beta(\omega_i,\omega_i)\ne\star\!\mathcal B$ | Re-derived the substitution from the polarised law from scratch, and checked the normalisation through $\beta(\omega,\omega)=2\sigma(\omega)$ rather than through the box. It survives |
| The contraction is valid | A silent commutation, or $\star\!\mathcal B$ collected as a left factor when it sits on the right | Tracked the order of every product through both steps. Left multiplication lands outside the existing product, and $\star\!\mathcal B$ is collected only by right-distributivity. It survives |
| The constraint is empty | An algebraic obstruction to writing $\mathcal M$ in terms of $R$ and the $h_k$, that is, a term in $\mathcal M$ that the polarised law cannot reach | Derived $(\star)$ directly from the law with no discharging, which reaches every term of $\mathcal M$ because the law applies at $(\omega_i,\omega_i,\omega_k)$ for all $i,k$. Then checked $(\star)$ at $J$ with $\lambda=(1,0,0)$, where all three terms are nonzero and cancel exactly |
| It cannot force $\mathcal B=0$ | A harmonic Ricci-flat triple at which $\mathcal M=0$ fails for some $\mathcal B\ne0$, which would mean the constraint does bite | $(\ddagger)$ makes $\mathcal M=-\tfrac12R\star\!\mathcal B$ on the harmonic locus, so at $R=0$ it holds for every $\mathcal B$ and no such triple can exist. The conclusion is structural rather than a failed search |
| $\mathcal M=0$ is not an unconditional identity | Failure to produce any triple with $\mathcal M\ne0$, which would make even the non-Weyl statement vacuous | Section 4 exhibits one, $\mathcal M=-2J$. So the box's display is a genuine equation off the Weyl class and a tautology on it |
| The Lean theorem is what it claims | `hId` failing to determine `cross`, or the conclusion needing a hypothesis the signature omits | Solved `hId` for `cross k` and substituted, recovering the conclusion in two lines. The theorem is faithful and its content is the substitution |
| The priority claim is false | No earlier result consuming both conditions jointly | Read [L179](../findings/diagonal-half.md), [L180](../findings/diagonal-half.md), [L181](../findings/diagonal-half.md), [L183](../findings/diagonal-half.md), [L184](../findings/diagonal-half.md), [L189](../findings/diagonal-half.md), [L191](../findings/diagonal-half.md) and [L192](../findings/diagonal-half.md). L181 and L183 both qualify, L184 uses no Weyl hypothesis at all and so does not, and line 790 already names L181 as such an instance |

## 9. Repairs, stated as what the box should say

1. **Delete the display as a finding and record $(\star)$ instead**, noting that it holds at every triple and that the box's equation is $(\star)$ with both defects set to zero.
2. **Record the uncollapsed identity**, $\sum_i\lambda_i\,\omega_i\,\beta(\omega_i,\omega_k)=0$ for each $k$ on a rank-three Weyl tensor at $\dim V=6$, which is three matrix equations and is what the harmonicity box actually buys.
3. **Replace "Whether it forces $\mathcal B=0$ is unanswered"** with the answer: it holds for every $\mathcal B$ at $R=0$, so it forces nothing.
4. **Drop the priority sentence** or narrow it to the neighbouring box's "as matrices", with [L181](../findings/diagonal-half.md) and [L183](../findings/diagonal-half.md) cited as the earlier joint consumptions.
5. **Restate what the Lean theorem certifies**, that `starB`, `cross` and `om` are arbitrary matrices and `hId` pins `cross`, so the certified content is the associativity of the step and not any fact about $\mathcal B$.
6. **Add `ricci_annihilates_defect` to the L193 row of [lean/INDEX.md](../lean/INDEX.md)**, whatever survives of the box.
