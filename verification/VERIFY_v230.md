# Verifier v230, Lemma L42 (the sharp dual weight): the weak-duality bound, the binding triple, sharpness, Passage E's scaling sentence, the proof pointer, and the Lean statement

*I worked cold from [BRIEF_L42.md](BRIEF_L42.md) and did no numerical work. Every value is exact and no scripts were written. I checked the quotations against [findings/stratum-two-negative.md](../findings/stratum-two-negative.md), [results.md](../results.md) and [L42Statement.lean](../lean/HamiltonsCubic/Results/L42Statement.lean). I did not build the Lean file. Log: [agent_logs/verify-L42-v230.log](../agent_logs/verify-L42-v230.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | Passage D's LP weak duality establishes $3M(\lambda_P)\le h(s^2-u)$ for every list of $k\ge3$ positives | CONFIRMED |
| 2 | The product weight $c=h/3$ is feasible at every triple: the three largest entries bind, ties included | CONFIRMED |
| 3 | "The constant cannot be improved" (A, B, D) and "the constant is attained, so no better weight exists for this relaxation" (C) | CONFIRMED |
| 4 | Passage E: $z_{\alpha\beta}=\mu\cdot\tfrac32\lambda_\alpha\lambda_\beta$ "is feasible exactly when $\mu$ is at least the triple's harmonic mean, so the binding value is $h$" | REFUTED AS STATED |
| 5 | Passage A's pointer, "the argument is in this file under 'The $\dim\mathfrak m\le2$ stratum, assembled, closed modulo three nam'" | REFUTED |
| 6 | Passage F's `sharp_dual_weight` is the record's claim | CONFIRMED (inequality clause), with the sharpness clause left untyped as the file declares |
| 7 | Boundary: $k=3$, all entries equal, ties, $k\le2$ | CONFIRMED |

**What the round should do:** record L42 as proven by Passage D, then fix three defects outside the proof: repoint Passage A to the section at line 566, correct or strike Passage E's $\mu$ sentence at lines 518-521, and resolve the dangling "2800 draws" reference at line 583.

## 0. Conventions, fixed once

- $\lambda=(\lambda_1,\dots,\lambda_k)$, $k\ge3$, every $\lambda_\alpha>0$. $\mathcal T$ is the set of unordered triples of distinct indices and $\mathcal P$ the set of unordered pairs. For $T\in\mathcal T$, $\lambda^T$ is the product of its three entries.
- Primal: $M=\max\{\sum_{T}t_T\lambda^T: t\ge0,\ \sum_{T\supset p}t_T\le2\ \forall p\in\mathcal P\}$. For a pair $p=\{\alpha,\beta\}$, the record's $\sum_{\gamma\notin\{\alpha,\beta\}}t_{\alpha\beta\gamma}$ is exactly $\sum_{T\supset p}t_T$.
- $e_2(T)$ is the sum of the three pairwise products in $T$, and $e_3(T)=\lambda^T$. $H(T)=3/\sum_{\alpha\in T}\lambda_\alpha^{-1}=3e_3(T)/e_2(T)$.
- $h=H(T^\ast)$ for $T^\ast$ a set of three indices with $\lambda_\gamma\le\min_{T^\ast}\lambda$ for every $\gamma\notin T^\ast$. $s=\sum\lambda$, $u=\sum\lambda^2$, $s^2-u=2\sum_{p}\lambda_\alpha\lambda_\beta$.
- Line numbers refer to [findings/stratum-two-negative.md](../findings/stratum-two-negative.md) unless another file is named.

**Quotation check.** Passages A (536-545), B ([results.md](../results.md) 182), C ([results.md](../results.md) 633-637), D (581-610) and E (518-525) match the source verbatim. For Passage F the brief cites lines 72-128 of [L42Statement.lean](../lean/HamiltonsCubic/Results/L42Statement.lean), but the theorem's conclusion continues onto line 129, `* ((∑ i, lam i) ^ 2 - ∑ i, lam i ^ 2) := by`, and line 130 is `sorry`. As quoted, the brief's F reads `3 * objective t lam ≤ harmonicMean (lam a) (lam b) (lam c)`, which would be a different inequality. The file itself carries the full right-hand side. This is a defect of the brief, not of the record.

## 1. Hypothesis inventory

**Hypotheses of the statement.**

| Label | Hypothesis | Checked against the object | Used by the proof |
|---|---|---|---|
| H1 | $k\ge3$ | Stated in A, B, C and at line 608 | Yes: $h$ needs three entries, and the sharpness witness divides by $k-2$ |
| H2 | every $\lambda_\alpha>0$ | Stated ("positive") | Yes: the division by $\lambda^T$ at line 593, and $z\ge0$ |
| H3 | $t\ge0$ | Stated | Yes: the first inequality of weak duality |
| H4 | pair cap $\le2$ for every pair | Stated | Yes: the second inequality of weak duality |
| H5 | $t$ indexed by unordered triples | Brief's definitions and the $\alpha<\beta<\gamma$ notation | Yes: the objective counts each triple once |

**Imported facts.**

- *LP weak duality.* Hypotheses: a primal $\max\,c^\top t$ with $At\le b$ and $t\ge0$, and a dual $\min\,b^\top z$ with $A^\top z\ge c$ and $z\ge0$. Conclusion: $c^\top t\le b^\top z$ for every feasible pair. Checked against the object: $A$ is the $\mathcal P\times\mathcal T$ incidence matrix ($A_{pT}=1$ iff $p\subset T$), $b=2\cdot\mathbf 1$, $c_T=\lambda^T$. The dual at line 589, $\min 2\sum z$ subject to $z_{\alpha\beta}+z_{\beta\gamma}+z_{\alpha\gamma}\ge\lambda^T$ and $z\ge0$, is exactly $A^\top z\ge c$, because column $T$ of $A$ has ones on the three pairs of $T$. The fact is used, and all its hypotheses hold.
- *Monotonicity of the harmonic mean.* $H(x,y,z)=3/(x^{-1}+y^{-1}+z^{-1})$ is strictly increasing in each argument on $(0,\infty)^3$, since each $x^{-1}$ is decreasing there. H2 places every argument in that domain. The fact is used.

**Used but unstated.** None of the three is a hypothesis of the statement, and each follows at once from H1-H5.

- $z\ge0$ for the product weight. It holds because $c=h/3>0$ and $\lambda_\alpha\lambda_\beta>0$ (H2). Line 595 does not check it.
- The binding-triple step at line 595 also uses that $H$ is symmetric and that each triple is dominated coordinatewise by $T^\ast$ once both are sorted. See §3.
- *Attainment of the max.* The feasible set is nonempty ($t=0$). It is bounded because $0\le t_T\le\sum_{T'\supset p}t_{T'}\le2$ for any $p\subset T$. So the max exists. The inequality does not need attainment, since it bounds every feasible value. The sharpness claim exhibits its maximiser explicitly.

## 2. Claim 1: weak duality gives the bound (attack item 1)

**The chain, link by link.** Take any feasible $t$ and put $z_p=c\,\lambda_\alpha\lambda_\beta$ with $c=h/3$.

1. *Per-triple feasibility (lines 593-595).* $c\,e_2(T)\ge e_3(T)$. Dividing by $e_3(T)>0$ (H2) gives $c\sum_{T}\lambda^{-1}\ge1$, that is $c\ge1/\sum_T\lambda^{-1}=H(T)/3$. The equivalence is exact in both directions.
2. *Every triple, not only $T^\ast$.* The step needs $h\ge H(T)$ for every $T\in\mathcal T$, which is claim 2 (§3). Given that, $c=h/3\ge H(T)/3$ holds at every triple, so $z$ is dual feasible. Nonnegativity is from §1.
3. *Summation.* $\sum_T t_T\lambda^T\le\sum_T t_T\sum_{p\subset T}z_p$ uses $t_T\ge0$ (H3) and step 2. Exchanging the finite sums gives $\sum_p z_p\sum_{T\supset p}t_T$, and this is at most $\sum_p 2z_p$ by $z_p\ge0$ and H4. That is weak duality, which line 600 invokes by name.
4. *Evaluation (line 600).* $2\sum_p z_p=2c\sum_p\lambda_\alpha\lambda_\beta=2\cdot\tfrac h3\cdot\tfrac{s^2-u}2=\tfrac h3(s^2-u)$. The arithmetic is exact.
5. Taking the max over $t$ gives $M\le\tfrac h3(s^2-u)$, so $3M\le h(s^2-u)$.

Each link follows from the one above and from H1-H5. **No finding:** the written chain establishes the inequality.

## 3. Claim 2: the binding triple, ties included (attack item 2)

**What line 595 says:** "The harmonic mean is increasing in each argument, so the binding triple is the **three largest positives** and $c=h/3$ is feasible."

**Check.** Take $T\in\mathcal T$ with sorted values $x_1\ge x_2\ge x_3$, and let $\ell_1\ge\ell_2\ge\ell_3$ be the three largest entries of $\lambda$. Then $x_j\le\ell_j$, because $T$ has $j$ entries $\ge x_j$, so $\lambda$ has at least $j$ such entries. $H$ is symmetric and increasing in each argument, so $H(T)=H(x_1,x_2,x_3)\le H(\ell_1,\ell_2,\ell_3)=h$. The triple $T^\ast$ does bind: its own constraint forces $c\ge h/3$, so $h/3$ is the least feasible $c$ for a product weight.

**Ties.** Suppose $T^\ast$ satisfies $\lambda_\gamma\le\min_{T^\ast}\lambda$ for every $\gamma\notin T^\ast$. Then every value in $T^\ast$ is at least every value outside it. So the multiset of values on $T^\ast$ equals $\{\ell_1,\ell_2,\ell_3\}$, whichever tied indices are chosen, and $h$ is well defined. Exact screen: at $\lambda=(3,2,2,2)$, every admissible $T^\ast$ has values $\{3,2,2\}$, and $h=3/(\tfrac13+\tfrac12+\tfrac12)=\tfrac94$.

### 3.1 Withdrawn candidate: "monotonicity alone does not give the binding triple"

1. *Location.* Line 595, quoted above. The sentence names monotonicity but uses neither the symmetry of $H$ nor the coordinatewise domination $x_j\le\ell_j$.
2. *Concrete failure.* None exists. By the check above, no positive list has a triple $T$ with $H(T)>h$.
3. *Charitable reading.* "Increasing in each argument" applied to a symmetric function of a sorted triple is the standard one-line comparison, and the omitted domination is immediate.

**Withdrawn at step 2.** The step is elliptical but correct. **No finding.**

## 4. Claim 3: sharpness, and what "the constant" is (attack item 3)

**What is claimed.**

- A (line 544) and B: "The constant cannot be improved."
- D (line 606): "equality genuinely holds for $k\ge3$ and no constant in the lemma can be improved."
- C ([results.md](../results.md) 635): "the constant is attained, so no better weight exists for this relaxation."

The only scalar in $3M\le h(s^2-u)$ is the ratio $3$ against the coefficient $1$ on $h(s^2-u)$. So "the constant" is the claim that no $\kappa<1$ gives $3M\le\kappa\,h(s^2-u)$ for every admissible $\lambda$.

**Derivation of the witness (line 606).**

- Take $\lambda_\alpha\equiv\lambda>0$. Then $h=\lambda$ and $s^2-u=k^2\lambda^2-k\lambda^2=k(k-1)\lambda^2$.
- Put $t_T=2/(k-2)$ on every triple ($k\ge3$). Each pair lies in $k-2$ triples, so the pair marginal is $(k-2)\cdot\tfrac2{k-2}=2$. The cap holds with equality, and $t\ge0$.
- The objective is $\binom k3\tfrac2{k-2}\lambda^3=\tfrac{k(k-1)(k-2)}6\cdot\tfrac2{k-2}\lambda^3=\tfrac{k(k-1)}3\lambda^3$. So $3M\ge k(k-1)\lambda^3=h(s^2-u)$, and with claim 1, $3M=h(s^2-u)>0$.
- A $\kappa<1$ would give $k(k-1)\lambda^3\le\kappa k(k-1)\lambda^3$, which is false.

The constant is therefore attained at every $k\ge3$ and cannot be improved. Line 606 also correctly says that the pair-count bound $\sum t\le k(k-1)/3$ is only an upper bound: $3\sum t=\sum_p\sum_{T\supset p}t_T\le2\binom k2$.

**Passage C's "no better weight".** Two readings are available, and each has a status.

- *Reading (a): the scalar constant.* The claim holds, by the derivation above.
- *Reading (b): the dual product weight $z=c\lambda_\alpha\lambda_\beta$.* The claim holds as well: by §3 the least feasible $c$ is $h/3$. That fact comes from the binding triple, not from attainment.

### 4.1 Withdrawn candidate: "no better weight" read as a pointwise function of $\lambda$

1. *Location.* [results.md](../results.md) 635: "the constant is attained, so no better weight exists for this relaxation."
2. *Concrete failure under the literal functional reading.* Take $k=4$ and $\lambda=(1,1,1,\varepsilon)$ with $0<\varepsilon<\tfrac13$. Here $h=1$, $s^2-u=(3+\varepsilon)^2-(3+\varepsilon^2)=6+6\varepsilon$, and $M=2$.
   - *Lower bound.* $t_{123}=2$ with all else $0$ is feasible.
   - *Upper bound.* Write $x_{ij}=t_{ij4}$. The caps on the pairs $12$, $13$, $23$ give $t_{123}\le2-\max_{ij}x_{ij}$. The objective is then at most $2-\max x+\varepsilon\sum x\le2-(1-3\varepsilon)\max x\le2$.

   So $3M=6<6+6\varepsilon=h(s^2-u)$, and a weight $w(\lambda)\le h$ with $w<h$ at this $\lambda$ (for instance $w=6/(6+6\varepsilon)$ there) also satisfies the bound.
3. *Charitable reading.* The sentence derives "no better weight" from "the constant is attained". Only reading (a) makes that inference valid. The paragraph's last sentence, "it is the relaxation rather than $P$ that it is sharp for", describes the scalar sharpness. No other passage claims pointwise tightness.

**Withdrawn at step 3.** "Weight" means the constant. The wording could name the scalar explicitly, but that is a drafting remark, not a finding.

**Verdict: CONFIRMED.**

## 5. Claim 4: Passage E's $\mu$ sentence (attack item 4)

1. *Location.* Lines 518-521: "For a triple of positives the dual $z_{\alpha\beta}=\mu\cdot\tfrac32\lambda_\alpha\lambda_\beta$ is feasible exactly when $\mu$ is at least the triple's harmonic mean, so the binding value is $h$, the harmonic mean of the three largest positives, and $3M(\lambda_P)\le h\,(s^2-u)$."
2. *Derivation and concrete failure.*
   - With $c=\tfrac32\mu$, §2 step 1 gives feasibility iff $\tfrac32\mu\ge H(T)/3$, that is $\mu\ge\tfrac29H(T)$.
   - *The "only if" direction fails:* at $T=(1,1,1)$, $H=1$ and $\mu=\tfrac29$ give $z_p=\tfrac13$. Then $z_{12}+z_{23}+z_{13}=1=\lambda^T$, which is feasible although $\mu=\tfrac29<1=H$.
   - *The conclusion does not follow from E's premises:* $\mu=h$ gives $M\le2\cdot\tfrac32h\cdot\tfrac{s^2-u}2=\tfrac32h(s^2-u)$, that is $3M\le\tfrac92h(s^2-u)$, not the boxed inequality.
   - The "if" direction ($\mu\ge H$ implies feasible) is true but loses the factor $\tfrac92$.
3. *Charitable reading.* E is a summary of the lemma inside a stratum overview, and its final inequality is true (§2). Even so, the sentence gives an exact threshold ("exactly when") that is false, and its "so" derives the bound from the threshold. No normalisation of $\mu$ consistent with the displayed $z$ makes $\mu\ge H$ the exact condition.

The failure survives all three steps. **Verdict: REFUTED AS STATED.** The lemma is unaffected because Passage D proves it independently.

**Consistency with the file's text after Passage D.** Line 610, the last line of D, concerns $k\le2$ and does not bear on this. Line 612, the italic note immediately after D, says:

- in the normalisation $z=\mu\cdot\tfrac32\lambda_\alpha\lambda_\beta$ the condition is $\mu\ge2/(3\sum\lambda^{-1})=2H/9$.
- "at least the harmonic mean of the triple" is wrong, being $\tfrac92$ times the true threshold.
- $\mu=h$ gives $3M\le\tfrac92h(s^2-u)$.

All three agree exactly with my derivation. The note is consistent with this finding, but it leaves the file inconsistent with itself.

- **Passage E still carries the uncorrected sentence** at lines 518-521.
- The note's "recorded form $\mu\ge2/\sum\lambda^{-1}$" does not appear in Passage E, so the note corrects a form that is not on the page it sits beside.

A second, non-mathematical dangling reference: line 583 reads "The '$2800$ draws' recorded below were checking a theorem", and no "2800" occurs anywhere below line 583 in the file.

## 6. Claim 5: Passage A's pointer (attack item 5)

1. *Location.* Line 538: "the argument is in this file under 'The $\dim\mathfrak m\le2$ stratum, assembled, closed modulo three nam'".
2. *Concrete failure.*
   - The quoted text is a truncated prefix of the heading at line 468, "The $\dim\mathfrak m\le2$ stratum, assembled, closed modulo three named items".
   - Under that heading and before the L42 block (line 536), the only material on the lemma is Passage E (518-525). E states the bound in one sentence, with the threshold refuted in §5, and it has no dual, no weak-duality step and no sharpness witness.
   - The argument is Passage D, lines 581-610, under the level-2 heading at line 566.
3. *Charitable reading.* Line 538 is dated 2026-08-31. The section at line 566 was re-filed on 2026-09-02, and its own italic note at line 567 says that "the Lemma L42 block there points at an argument it does not carry". So the pointer was accurate about location only in the sense that E was the text on file at the time. Read against the file as it stands, it lands on a sketch whose derivation is wrong, not on the argument.

The failure survives all three steps. **Verdict: REFUTED.** Passage C's link, "Proof: [stratum-two-negative.md](../findings/stratum-two-negative.md)", names the right file but no section.

## 7. Claim 6: the Lean statement (attack item 6, standing item 5)

Source: [L42Statement.lean:124-130](../lean/HamiltonsCubic/Results/L42Statement.lean#L124).

**Binders and types.**

- `k : ℕ` is implicit through `variable {k : ℕ}`.
- `t : Fin k → Fin k → Fin k → ℝ` and `lam : Fin k → ℝ` are explicit.
- `a b c : Fin k` are explicit and range over indices, not values.
- Hypotheses: `hk : 3 ≤ k` (H1), `hpos : ∀ i, 0 < lam i` (H2), `hft : Feasible t`, `h3 : ThreeLargest lam a b c`.
- Every binder is universal. The theorem therefore says: for all $k$, $t$, $\lambda$ and $a,b,c$ meeting the hypotheses, the inequality holds.

**Direction.** `3 * objective t lam ≤ harmonicMean (lam a) (lam b) (lam c) * ((∑ i, lam i) ^ 2 - ∑ i, lam i ^ 2)`. This is $3\cdot\text{obj}\le h(s^2-u)$, the record's direction.

**Universal $t$ in place of $M$.** $M$ is the max over the feasible set. "$3\,\text{obj}(t)\le R$ for every feasible $t$" is equivalent to "$3M\le R$", given that the max exists (§1). The file's docstring (lines 42-44) says exactly this. No finding.

**`Feasible` (lines 75-79).**

- `nonneg` is H3, imposed on all ordered triples.
- `symm12` and `symm23` generate the full symmetric group on the three slots, so `t` is totally symmetric. That is H5 transported to ordered triples.
- `pairCap`: for `α ≠ β`, the sum over `γ` with `γ ≠ α ∧ γ ≠ β` of `t α β γ` is at most 2. For distinct $\alpha,\beta$ this ranges over the triples containing $\{\alpha,\beta\}$, each counted once, and symmetry makes the ordered pair $(\alpha,\beta)$ agree with $(\beta,\alpha)$. This is H4.
- *Repeated indices.* `t α α γ` and `t α α α` are constrained only by `nonneg` and symmetry. They never enter `pairCap`, whose filter excludes $\gamma\in\{\alpha,\beta\}$ and requires $\alpha\ne\beta$, and they never enter `objective`, which runs over strict chains.
- So the restriction map from Lean-feasible `t` to record-feasible $t$ on unordered triples is onto (extend symmetrically, with zero on repeats), and it preserves the objective. The quantification over Lean-feasible `t` is therefore equivalent to the record's quantification. No finding.

**`objective` (lines 82-83).** $\sum_\alpha\sum_{\beta>\alpha}\sum_{\gamma>\beta}t_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ counts each unordered triple exactly once, which matches the record's $\sum_{\alpha<\beta<\gamma}$. No finding.

**`ThreeLargest` (lines 88-92).** Three pairwise distinct indices, with every other index at most the minimum of the three. By §3 this makes $\{\lambda_a,\lambda_b,\lambda_c\}=\{\ell_1,\ell_2,\ell_3\}$ as multisets under any tie-breaking, so `harmonicMean (lam a) (lam b) (lam c)` is the record's $h$. With `hpos`, "positives" is automatic. `hk` is implied by `h3`, since three distinct elements of `Fin k` force $k\ge3$. It is redundant and harmless. No finding.

**`harmonicMean` (line 95)** is $3/(x^{-1}+y^{-1}+z^{-1})$, and `hpos` keeps Lean's division-by-zero convention out of play. No finding.

**What the Lean statement is.**

- It is the inequality clause of L42, exactly.
- It does not state the sharpness clause. Lines 57-60 declare that openly.
- It carries a `sorry` (line 130), so it is a statement, not a proof.
- `triple_constraint` (lines 102-113) is the per-triple step of §2 and reads correctly: `hkey` gives $e_2/\sum x^{-1}=xyz$, and multiplying `hc` by $e_2>0$ gives $xyz\le c\,e_2$. I did not build it.

**Verdict: CONFIRMED** for the inequality clause, with the sharpness clause absent by declaration. The brief's truncated quotation (§0) is not a defect of the Lean file.

## 8. Claim 7: the boundary (attack item 7, standing item 3)

- **$k=3$ exactly.** There is a single triple, and each pair lies only in it, so the caps reduce to $t\le2$ and $M=2e_3$. Here $h=3e_3/e_2$ and $s^2-u=2e_2$, so $h(s^2-u)=6e_3=3M$. **Equality holds for every positive triple, not only equal ones.** The witness $t=2/(k-2)=2$ is feasible. Exact screen: at $(2,1,1)$, $3M=12$, $h=\tfrac65$ and $s^2-u=10$, giving $12$.
- **All entries equal.** Equality at every $k\ge3$ (§4).
- **Ties among the largest.** $h$ is well defined (§3). Exact screen at $(3,2,2,2)$:
  - $h=\tfrac94$, $s=9$, $u=21$, so $h(s^2-u)=\tfrac94\cdot60=135$.
  - The LP is invariant under permuting indices $2,3,4$ and is a concave maximisation, so it has a symmetric maximiser with $t_{1ij}=x$ and $t_{234}=y$.
  - The caps are $2x\le2$ on the pairs $\{1,j\}$ and $x+y\le2$ on the pairs $\{i,j\}$. The objective is $36x+8y$, maximised at $x=y=1$ with value $44$.
  - So $3M=132<135$, consistent with the lemma and strict.
- **$k\le2$.** There are no triples, so $M=0$ (the max over the single point of $\mathbb R^0$), and $h$ has no three entries to be built from. H1 excludes this case and line 608 states the exclusion, so the lemma makes no claim there. In Lean, `ThreeLargest` is unsatisfiable at $k\le2$.

**Verdict: CONFIRMED.**

## 9. Quantifier order and scope (standing item 2)

- $M$ is a max over $t$ in the pair-capped polytope, for fixed $\lambda$.
- $h$ is a function of $\lambda$ alone. The "binding" max is over the $\binom k3$ triples of that same $\lambda$, so $c=\max_T H(T)/3=h/3$.
- The inequality is quantified $\forall k\ge3\ \forall\lambda>0$.
- Sharpness is quantified $\forall k\ge3\ \exists\lambda$ (equal entries) with equality, and at $k=3$ for all $\lambda$. It establishes $\neg\exists\kappa<1\ \forall\lambda:\ 3M\le\kappa h(s^2-u)$.
- The Lean statement moves "max over $t$" to "$\forall t$", which is equivalent (§7).

**No finding.**

## 10. The gap between proven, stated and used (standing item 4)

- **Proven (Passage D).** The inequality for every $k\ge3$ and positive $\lambda$, and attainment of the scalar constant at equal spectra for each $k$.
- **Stated (A, B, C).** The same inequality and the same scalar sharpness. Passage C's "no better weight" holds under the reading its own inference requires (§4.1). No gap.
- **Stated in E.** An exact feasibility threshold that is false (§5). E's derivation gives only $3M\le\tfrac92h(s^2-u)$. E's text is not the proof, so this is a defect of the record's exposition, not a gap in the lemma.
- **Pointed to (A, line 538).** The pointer lands on E, not on D (§6).
- **Lean.** It covers the inequality clause only, under `sorry`, and sharpness is untyped (§7).
- **Used.** Passage E feeds $3M\le h(s^2-u)$ into the bound on $G$ in exactly the proven form. The further bounds there, such as $h\le\min(\lambda_1,\tfrac3{2\sqrt2}\sqrt d)$, are outside this round.
- **Dangling.** The "2800 draws recorded below" at line 583 has no referent below it.

## 11. The falsifying object (standing item 7)

- **For the inequality.** An integer $k\ge3$, a positive list $\lambda$ and a feasible $t$ with $3\sum_Tt_T\lambda^T>h(s^2-u)$. The chain in §2 excludes every such object, since each link rests on stated hypotheses.
- **For sharpness.** A $\kappa<1$ with $3M\le\kappa h(s^2-u)$ for all $\lambda$. The exact witness in §4 excludes it.
- **What I did to look.** I rederived the dual from the incidence matrix and checked the direction of every inequality in the weak-duality chain. I tested the binding-triple step against the order-statistic comparison and against ties.
- **Exact hand screens.** $k=3$ in general, $(2,1,1)$, $(3,2,2,2)$ and $(1,1,1,\varepsilon)$. All are consistent with the lemma, with equality exactly where the record says. These are screens, not evidence for a positive claim.
- **For Passage E.** The falsifier is $T=(1,1,1)$ with $\mu=\tfrac29$ (§5).

## Overall verdict

**PROVEN.** Passage D's weak-duality argument establishes $3M(\lambda_P)\le h(s^2-u)$ for every list of at least three positives. Its equal-spectrum witness establishes that the constant is attained and cannot be improved. Three record defects sit outside the proof and should be corrected:

- Passage E's feasibility sentence at lines 518-521 is REFUTED AS STATED. The threshold is $\mu\ge\tfrac29H$, not $\mu\ge H$, and E's own premises give only $3M\le\tfrac92h(s^2-u)$. The file's note at line 612 agrees but leaves E unamended.
- Passage A's pointer at line 538 lands on E, not on the argument at lines 581-610 under line 566.
- Line 583's "2800 draws recorded below" has no referent.

The Lean statement matches the inequality clause and leaves sharpness untyped, as it declares. The brief's quotation of Passage F omits line 129, which carries the factor $(s^2-u)$.
