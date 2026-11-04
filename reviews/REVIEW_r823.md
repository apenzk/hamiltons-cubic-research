# r823: Gate 2 on "Ricci annihilates the defect under one contraction" (L193's fifth box)

*Cold brief: I was given the box, the harmonicity box it rests on and four givens, and read [findings/diagonal-half.md](../findings/diagonal-half.md) (L179 through L193), [findings/conventions.md](../findings/conventions.md), [lean/INDEX.md](../lean/INDEX.md) and [L193Statement.lean](../lean/HamiltonsCubic/Results/L193Statement.lean). **The programme is on an analysis-only footing and I opened no numerical line of work**: no search, sweep, census or falsifier hunt. Three machine actions were screens on objects I constructed for the purpose, reported as screens in §6 and never carrying a positive claim. Every derivation below is by hand. Log: [agent_logs/g2-contraction-r823.log](../agent_logs/g2-contraction-r823.log).*

| Claim | Verdict |
|---|---|
| **The contraction step is valid**, no factor moved across a product | **CONFIRMED.** The left multiplication puts $\omega_k$ adjacent to the $\omega_k$ already there, so $\omega_k(\omega_k\star\!\mathcal B)=\omega_k^2\star\!\mathcal B$ by associativity alone, and $\star\!\mathcal B$ is a common RIGHT factor across the sum, so $\sum_k$ pulls out as $\big(\sum_k\lambda_k\omega_k^2\big)\star\!\mathcal B$. Nothing commutes. The display's index order $\omega_k\omega_i$ is the one left multiplication produces |
| **The harmonicity box's substitution**, the factor $2$, the identification with $\star\!\mathcal B$ | **CONFIRMED, every constant.** $\alpha=\eta=\omega_i$ collides the first two terms of the polarised law into $2\omega_i\beta(\omega_i,\zeta)$, and $\sum_i\lambda_i\beta(\omega_i,\omega_i)=\star\big(\sum_i\lambda_i\omega_i\wedge\omega_i\big)=\star\!\mathcal B$ needs no factor, $\beta$ being bilinear and $\mathcal B$ defined with the same normalisation. Agrees with [r820](REVIEW_r820.md) |
| **"a rank-three Weyl tensor at $\dim V=6$ satisfies $\sum_{i,k}\lambda_i\lambda_k\omega_k\omega_i\beta(\omega_i,\omega_k)=0$"** | **CONFIRMED, and it is NOT the identity $0=0$.** §4 exhibits a Ricci-flat orthonormal triple at $\dim V=6$ with $\lambda=(1,1,-2)$ at which the sum has size $2$ |
| **"the first constraint the record carries in which BOTH Weyl conditions are consumed and neither is merely tested against the other"** | **REFUTED, twice.** [L181](../findings/diagonal-half.md) is Ricci as $\mathop{\mathrm{diag}}(M^{\mathsf T}\Lambda M)=0$ and Bianchi as its off-diagonal, combined into $M^{\mathsf T}\Lambda M=0$ and then into $\Lambda=0$, which neither half yields alone. [L183](../findings/diagonal-half.md) is $\sum_i\lambda_i\Phi(\omega_i)=0$ with $\Phi(\omega)=(\omega^2,\omega\wedge\omega)$, the two conditions as ONE equation in a direct sum. L181's own box already says "the two conditions are complementary halves of one object, which is the content" |
| **"Whether it forces $\mathcal B=0$ is unanswered, and it is what a successor should price"** | **REFUTED as a pricing.** §3 proves the constraint EQUIVALENT to harmonicity given Ricci-flatness, by an identity that holds at every triple. So the question it poses is verbatim [L192](../findings/diagonal-half.md)'s open question, and the box charges a successor for work already on the books |
| **"The combining step is machine-checked as `ricci_annihilates_defect`, taking the harmonicity identity ... as hypotheses"** | **REFUTED as a description of what is typed, with the "what is owed" clause honest.** `starB` and `cross` are FREE variables and `hId` pins `cross k` to $-\tfrac12(\omega_k\,\mathtt{starB})$, so no harmonicity is present. `om` carries no skewness and no orthonormality, `lam` no sign or sum condition. §5 compiles the theorem's full strength as a statement about arbitrary $6\times6$ real matrices. The Lean docstring's headline **"BOTH WEYL CONDITIONS CONSUMED"** is false of the theorem below it |

**One line.** *The algebra survives whole: the substitution, the factor $2$, the normalisation and the contraction are all right, and the resulting constraint genuinely cuts on the Ricci-flat class, which is more than the earlier attempts on this line managed. What fails is everything the box says about the result. Over Ricci-flatness the constraint is not a new condition but harmonicity wearing a matrix coat, because the identity $2\sum_{i,k}\lambda_i\lambda_k\omega_k\omega_i\beta(\omega_i,\omega_k)+\big(\sum_k\lambda_k\omega_k^2\big)\star\!\mathcal B=-\sum_k\lambda_k\langle\star\!\mathcal B,\omega_k\rangle\,\omega_k$ holds at EVERY triple with no hypotheses at all. Ricci kills the middle term and the constraint becomes $\sum_k\lambda_k\langle\star\!\mathcal B,\omega_k\rangle\omega_k=0$, which with $\lambda_k\ne0$ and the $\omega_k$ independent is exactly the three harmonicity pairings. Thirty-six apparent equations are three, its trace is $0=0$ for every triple whatsoever, and "whether it forces $\mathcal B=0$" is L192's question with new notation. **The unconditional identity is the thing worth recording**, the box's constraint being one of its specialisations.*

## 0. Conventions, taken from the record and not restated by me

I use [conventions.md](../findings/conventions.md) and the layer files as [r820](REVIEW_r820.md) fixed them: a $2$-form is a skew matrix, $\langle A,B\rangle=\sum_{a<b}A_{ab}B_{ab}=-\tfrac12\mathop{\mathrm{tr}}(AB)$ on skew matrices, $\beta(\alpha,\eta)=\star(\alpha\wedge\eta)$, $\sigma(\omega)=\tfrac12\beta(\omega,\omega)$ and $\mathcal B=\sum_i\lambda_i\,\omega_i\wedge\omega_i$. Juxtaposition of $2$-forms is the matrix product. I write $S=\sum_{i,k}\lambda_i\lambda_k\,\omega_k\,\omega_i\,\beta(\omega_i,\omega_k)$ for the box's left side and $R=\sum_k\lambda_k\omega_k^2$ for the Ricci sum.

One inherited scoping point applies here unchanged. [r820](REVIEW_r820.md) established that at $V\subsetneq\mathbb R^n$ the polarised law reads $\mathrm{Id}_V$ and $\star_V$, so every $\star$ in this box is $\star_V$ and every $\beta$ is formed inside $\Lambda^\bullet V$. The box says $\dim V=6$ throughout and is not damaged by this, but it repeats the silence r820 flagged.

## 1. Locate

The box is [findings/diagonal-half.md:839](../findings/diagonal-half.md), the fifth extension box under **Lemma L193**. The box it rests on is the third, at line 837. The Lean theorem is [L193Statement.lean:128](../lean/HamiltonsCubic/Results/L193Statement.lean), committed in `a79a9aa1`, and [lean/INDEX.md:89](../lean/INDEX.md) carries L193's row, which does not yet mention `ricci_annihilates_defect` at all.

## 2. The two steps, checked

**The harmonicity box.** Put $\alpha=\eta=\omega_i$ in the polarised law $\alpha\beta(\eta,\zeta)+\eta\beta(\alpha,\zeta)+\zeta\beta(\alpha,\eta)=-\langle\beta(\alpha,\eta),\zeta\rangle\mathrm{Id}$. The first two terms are the same term, giving $2\omega_i\beta(\omega_i,\zeta)$, which is the box's factor $2$ and it is right. Multiplying by $\lambda_i$ and summing over $i$ uses only bilinearity of $\beta$ and linearity of the product in each slot, and $\sum_i\lambda_i\beta(\omega_i,\omega_i)=\star\!\mathcal B$ on the nose, with no $\tfrac12$, because $\beta(\omega,\omega)=2\sigma(\omega)$ rather than $\sigma(\omega)$. So

$$2\sum_i\lambda_i\,\omega_i\beta(\omega_i,\zeta)+\zeta\,\star\!\mathcal B=-\langle\star\!\mathcal B,\zeta\rangle\,\mathrm{Id}_6 \qquad(\ast)$$

**at every $\zeta$, with no hypothesis on the triple.** This is the box's display before harmonicity is applied, and it is the object the rest of my report turns on. At $\zeta$ in the span, [L192](../findings/diagonal-half.md) gives $\langle\star\!\mathcal B,\zeta\rangle=0$ and the box's rearranged form follows. **CONFIRMED.**

*The harmonicity reading is right too.* At $m=3$, L192 is $L[\mathrm{Pf}(w)]=\star(\mathcal B\wedge w)$, and $\star\star=+\mathrm{id}$ on $\Lambda^2\mathbb R^6$ since $(-1)^{2\cdot4}=1$, so $\mathcal B\wedge w=\mathcal B\wedge\star\star w=\langle\mathcal B,\star w\rangle\mathrm{vol}=\langle\star\!\mathcal B,w\rangle\mathrm{vol}$ and harmonicity is $\langle\star\!\mathcal B,\zeta\rangle=0$ on the span, which is the given.

**The contraction.** Take $\zeta=\omega_k$ in the box's rearranged identity $\omega_k\star\!\mathcal B=-2\sum_i\lambda_i\omega_i\beta(\omega_i,\omega_k)$ and multiply on the left by $\lambda_k\omega_k$:

$$\lambda_k\,\omega_k\big(\omega_k\star\!\mathcal B\big)=\lambda_k\,\omega_k^2\,\star\!\mathcal B,\qquad -2\lambda_k\sum_i\lambda_i\,\omega_k\,\omega_i\,\beta(\omega_i,\omega_k).$$

**The attack's worry does not bite.** The left side is associativity and nothing else: $\omega_k$ meets the $\omega_k$ that is already leftmost, and $\star\!\mathcal B$ never moves. Summing over $k$ pulls $\star\!\mathcal B$ out as a common RIGHT factor, which is legitimate for a right factor without any commutation, giving $R\,\star\!\mathcal B=0$ by [L180](../findings/diagonal-half.md)(1). On the other side $\omega_k$ lands to the LEFT of $\omega_i$, and the box's display writes $\omega_k\omega_i$ in that order. **No factor is silently moved across a product. CONFIRMED.**

## 3. The constraint is harmonicity, and that is the finding

**Do the same contraction to $(\ast)$ instead, before any hypothesis is used.** Set $\zeta=\omega_k$, left-multiply by $\lambda_k\omega_k$, sum over $k$, and use $\omega_k\,\mathrm{Id}=\omega_k$ on the right side:

$$2S+R\,\star\!\mathcal B=-\sum_k\lambda_k\,\langle\star\!\mathcal B,\omega_k\rangle\,\omega_k \qquad(\dagger)$$

**at every triple of $2$-forms and every weight vector, Weyl or not.** Now impose Ricci-flatness alone, which is $R=0$ by L180(1):

$$2S=-\sum_k\lambda_k\,\langle\star\!\mathcal B,\omega_k\rangle\,\omega_k.$$

The $\omega_k$ are orthonormal, hence linearly independent in $\Lambda^2$, and every $\lambda_k\ne0$. So the right side vanishes **if and only if** $\langle\star\!\mathcal B,\omega_k\rangle=0$ for $k=1,2,3$, which is harmonicity on the span.

> **SO $S=0$ IS EQUIVALENT TO HARMONICITY, GIVEN RICCI-FLATNESS.** *It is implied by the two Weyl conditions, as the box says, and it implies harmonicity back. It cannot be stronger than the hypothesis it was derived from.*

Three consequences the box should carry.

- **The constraint is three equations, not thirty-six.** Under Ricci, $S$ is pinned to $-\tfrac12\sum_k\lambda_k\langle\star\!\mathcal B,\omega_k\rangle\omega_k$, which lies in $\mathop{\mathrm{span}}(\omega_1,\omega_2,\omega_3)$ for every Ricci-flat triple. A $6\times6$ matrix equation looks like $36$ conditions and this one has at most $3$, all of them already on the record.
- **Its trace is $0=0$ for every triple whatsoever.** $R$ is symmetric, being a sum of squares of skew matrices, and $\star\!\mathcal B$ is skew, so $\mathop{\mathrm{tr}}(R\star\!\mathcal B)=0$ unconditionally, and $\mathop{\mathrm{tr}}(\omega_k)=0$, so $(\dagger)$ gives $\mathop{\mathrm{tr}}S=0$ with no hypothesis used. The attack asked whether the trace collapses. It does, and it collapses harder than expected: it is vacuous off the Weyl class as well as on it. This extends [r820](REVIEW_r820.md)'s observation that the trace of the harmonicity box is L192's scalar identity.
- **"Whether it forces $\mathcal B=0$" is L192's open question.** L192 leaves exactly "does harmonicity, on the Ricci-flat class, force first Bianchi". By the equivalence above that is the same sentence. The box's closing instruction to a successor is therefore a duplicate row, and it should point at L192 rather than open a new price.

**What should be recorded instead is $(\dagger)$.** It holds at every triple, it needs neither Weyl condition, and it says something the record does not have: the double contraction of the polarised law against the weights is a linear combination of the $\omega_k$ with the harmonicity pairings as coefficients, corrected by $R\star\!\mathcal B$. That is a tool. The box's $S=0$ is one of its specialisations and is not.

## 4. Exhibit: the constraint is not vacuous on the Ricci-flat class

The equivalence above would be worthless if $S$ vanished on every Ricci-flat triple, so I built one where it does not, in closed form and with no search.

Take the three orthogonal planes $\varepsilon_1=e^{01}$, $\varepsilon_2=e^{23}$, $\varepsilon_3=e^{45}$ in $\mathbb R^6$, weights $\lambda=(1,1,-2)$, and let $M$ be the orthogonal matrix whose $j$-th COLUMN is

$$m_j=\Big(\sqrt{\tfrac23}\cos\theta_j,\ \sqrt{\tfrac23}\sin\theta_j,\ \tfrac1{\sqrt3}\Big),\qquad \theta_j=\tfrac{2\pi j}{3},$$

with $\omega_i=\sum_jM_{ij}\varepsilon_j$. **The columns are orthonormal** because $m_j\cdot m_k=\tfrac23\cos(\theta_j-\theta_k)+\tfrac13=-\tfrac13+\tfrac13=0$ for $j\ne k$, so $M\in O(3)$ and the $\omega_i$ are an orthonormal triple. **It is Ricci-flat** because each column satisfies $m_j^{\mathsf T}\Lambda m_j=\tfrac23-2\cdot\tfrac13=0$, which by [L181](../findings/diagonal-half.md)'s reading is $\mathop{\mathrm{diag}}(M^{\mathsf T}\Lambda M)=0$, that is $R=0$. **It is not harmonic**: $M^{\mathsf T}\Lambda M$ has every off-diagonal entry $-1$, so $\mathcal B\ne0$, and $\langle\star\!\mathcal B,\omega_3\rangle=-2\sqrt3\ne0$ while the other two pairings vanish, $\omega_3$ being the flat row $\tfrac1{\sqrt3}(1,1,1)$.

At this triple $S=-\tfrac12\lambda_3\langle\star\!\mathcal B,\omega_3\rangle\,\omega_3=-2\sqrt3\,\omega_3\ne0$, whose largest entry is $2$. **So $S=0$ is a real condition on Ricci-flat orthonormal triples and the box is not asserting $0=0$.** Screened, §6.

*This also shows the constraint failing at a triple that is not Weyl, which is what the attack asked for, and it shows the failure being carried entirely by the harmonicity slot that the equivalence predicts.*

## 5. What the Lean theorem certifies

[ricci_annihilates_defect](../lean/HamiltonsCubic/Results/L193Statement.lean) takes

```
(lam : Fin 3 → ℝ) (om : Fin 3 → Matrix (Fin 6) (Fin 6) ℝ)
(starB : Matrix (Fin 6) (Fin 6) ℝ) (cross : Fin 3 → Matrix (Fin 6) (Fin 6) ℝ)
(hId : ∀ k, om k * starB = (-2 : ℝ) • cross k)
(hRicci : ∑ k, lam k • (om k * om k) = 0)
```

**Every one of those is free.** `om` carries no `IsSkew` and no orthonormality, `lam` no nonvanishing and no zero-sum, `starB` is an arbitrary matrix with no relation to any wedge, and `cross` is an arbitrary family. `hId` is not a hypothesis about `cross`, it is a DEFINITION of it: over $\mathbb R$ it says exactly $\mathtt{cross}\ k=-\tfrac12(\mathtt{om}\ k\cdot\mathtt{starB})$. The record's $\mathrm{cross}_k=\sum_i\lambda_i\omega_i\beta(\omega_i,\omega_k)$, which is where the polarised law and harmonicity live, is nowhere in the file.

**So the theorem's full strength is this**, which I compiled against the module (§6):

```
theorem what_it_actually_certifies (lam) (om) (starB)
    (hRicci : ∑ k : Fin 3, lam k • (om k * om k) = 0) :
    ∑ k : Fin 3, lam k • (om k * ((-1/2 : ℝ) • (om k * starB))) = 0
```

a one-line consequence of associativity and $\sum_k\lambda_k\,\mathtt{om}_k^2=0$ about arbitrary $6\times6$ real matrices.

**What it therefore certifies is exactly the attack's first item and nothing more**: that the left multiplication and the sum rearrange without commuting anything. That is worth having, and it is the step most likely to hide a sign or an order error, so the typing is not idle. **What it does not certify is any part of the mathematics that makes the conclusion a statement about Weyl tensors.**

Two consequences.

- **The docstring headline "BOTH WEYL CONDITIONS CONSUMED, NEITHER MERELY TESTED AGAINST THE OTHER" is false of the theorem it sits on.** Only `hRicci` appears. First Bianchi and harmonicity appear neither in the statement nor in any hypothesis, `hId` being an equation between unconstrained symbols.
- **The record's sentence "taking the harmonicity identity and Ricci-flatness as hypotheses" overstates by one hypothesis.** Ricci-flatness is genuinely a hypothesis, in the shape L180(1) gives it. The harmonicity identity is not, because the only thing that made it the harmonicity identity, the value of its right side, is a free variable. The trailing clause "what is owed is the step producing the identity" is honest and should be the whole sentence.

*The file itself is otherwise in good order.* It builds, and `sorry` appears at `adjugate_law` alone (line 79), not in this theorem.

## 6. The three screens, reported as screens

Each was seconds of compute on objects I constructed for the purpose. **None is evidence for a positive claim**: every claim above is derived by hand in §2 through §5, and the screens exist to catch a slip in my own derivation.

1. **The polarised law and $(\dagger)$**, on twenty random triples each, with $\Lambda^2$ and $\Lambda^4$ carried as coefficient vectors on ordered index sets and $\star$ as the complementary-set sign, so no library convention entered. Residues $5.3\times10^{-15}$ and $7.6\times10^{-16}$. **The triples were normalised but NOT orthogonalised**, which is why I can say $(\dagger)$ needs no orthonormality.
2. **The §4 exhibit**, evaluated once. $|R|=2.2\times10^{-16}$, pairings $(0,0,-3.4641)$, $\max|S|=2$, and $\big|S+\tfrac12\sum_k\lambda_k\langle\star\!\mathcal B,\omega_k\rangle\omega_k\big|=6.7\times10^{-16}$.
3. **The Lean instantiation of §5**, built against the module and then removed. `lake build` returns `Build completed successfully`, the only `sorry` warning being `adjugate_law`.

## 7. What would falsify each verdict, and what I did to look for it

| Verdict | What would falsify it | What I did |
|---|---|---|
| Contraction step valid | A place where $\star\!\mathcal B$ or an $\omega$ crosses another factor, or an index order that does not match left multiplication | Rewrote the step factor by factor in §2, checked $\star\!\mathcal B$ is a RIGHT factor throughout, checked the display's $\omega_k\omega_i$ order against the side the multiplier lands on |
| Substitution and constants right | A stray $\tfrac12$ in $\sum_i\lambda_i\beta(\omega_i,\omega_i)=\star\!\mathcal B$, or the factor $2$ being a $1$ | Re-derived from the polarised law, checked $\beta(\omega,\omega)=2\sigma(\omega)$ against $\mathcal B$'s definition, screened the law itself rather than trusting the given |
| Constraint non-vacuous | Every Ricci-flat orthonormal triple giving $S=0$ automatically | Built one in closed form with $S\ne0$, §4. Constructed, not searched: the columns solve $m^{\mathsf T}\Lambda m=0$ in one line |
| Constraint equivalent to harmonicity given Ricci | $(\dagger)$ failing at some triple, or the right side of $(\dagger)$ vanishing without the pairings vanishing | Derived $(\dagger)$ with no hypotheses and screened it on non-orthogonal triples. The second needs $\lambda_k\ne0$ and independence of the $\omega_k$, both givens, and the §4 exhibit is a case where one pairing survives and $S$ survives with it |
| Priority claim false | An honest reading on which L181 and L183 do not consume both conditions, for instance "consume" meaning one condition ANNIHILATING the other | Read L181, L183, L184, L188, L189, L191 and L192. L183 conjoins into one equation and L181 genuinely combines, multiplying $M^{\mathsf T}\Lambda M=0$ by $M$ and $M^{\mathsf T}$ to reach $\Lambda=0$, which is more than conjunction. The claim fails on either reading |
| Lean theorem is about arbitrary matrices | `starB` or `cross` being constrained somewhere I did not look, for instance by a `variable` binder or a section hypothesis | Read the whole file, checked the namespace and the `open ... in` lines carry no binders, then compiled the instantiation at a definitionally supplied `cross` |

**One thing I could not settle.** Whether $(\dagger)$ has a use the box's specialisation lacks. It is an unconditional identity relating a double contraction to the harmonicity pairings, and the natural next question is what it gives when tested against something other than the $\omega_k$, for instance at $\zeta$ off the span where $\langle\star\!\mathcal B,\zeta\rangle$ survives. **That is analysis and not computation**, and it is the successor item I would put in place of the one the box proposes.
