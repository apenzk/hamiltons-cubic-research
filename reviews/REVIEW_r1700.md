# REVIEW r1700: L156's contour optimum in Lean (39260692)

**Verdict: CONFIRMED, with one presentation finding and two observations.** [L156Opt.lean](../lean/HamiltonsCubic/Results/L156Opt.lean) defines `dmin` and `J` exactly as [L156](../findings/second-order.md) displays $d$, $C$ and $J=C/\gamma$, and `L156_opt` states, at $D=(2m-1)/(m-1)$ with $m\ge2$, that $(D/2,D/4)$ lies in the record's open domain $0<\alpha<D$, $0<\gamma<\min(d,1)$, that $J$ there equals the record's $J^*=4(1+\alpha^*)/\alpha^{*2}$, and that $J(D/2,D/4)\le J(\alpha,\gamma)$ on the whole domain. That is the record's "its minimum is interior and attained at $\alpha^*=D/2$, $\gamma^*=D/4$". The proof's split at the kink is complete, the point $\alpha=D/2$ falling in the first branch. The module builds and rests on the standard three axioms. The docstring carries two lines over the 100-character limit (P1).

| # | Claim | Verdict |
|---|---|---|
| 1a | `dmin D α = min α (D - α)` is the record's $d$ | **CONFIRMED** |
| 1b | `J` is $C/\gamma$ with $C=\alpha(1+\alpha)/(d(d-\gamma))$ | **CONFIRMED** |
| 1c | `L156_opt`'s domain is the record's $0<\alpha<D$, $0<\gamma<\min(d,1)$ | **CONFIRMED** |
| 1d | $D=(2m-1)/(m-1)$ at $m\ge2$ is the record's $D$ | **CONFIRMED** (real $m\ge2$, which contains the record's integers) |
| 2a | `J_star` gives the record's $J^*$ | **CONFIRMED** |
| 2b | `J_ge` and `L156_opt` state the minimum attained at $(D/2,D/4)$ over exactly the domain | **CONFIRMED** |
| 2c | The kink split is complete on both sides and at $\alpha=D/2$ | **CONFIRMED** |
| 3 | Nothing stronger or weaker than the record is claimed where it matters | **CONFIRMED**, `J_ge` generalises soundly (O1), uniqueness is left unstated as the record's statement leaves it (O2) |
| 4 | Axioms: standard three only | **CONFIRMED** (screen by the repo's audit script) |
| 5 | The INDEX row says what is proved and what is owed | **ACCURATE** |

One line: L156's minimisation, which [L156.lean](../lean/HamiltonsCubic/Results/L156.lean) left owed, is now a kernel-checked statement over the record's own domain, and the only thing the row still owes is the resolvent bound $M\le C\gamma g_n$.

## Attack line 1: the definitions and the domain

- **The record** ([second-order.md](../findings/second-order.md), Lemma L156): $D=\tfrac{2m-1}{m-1}$, $d=\min(\alpha,D-\alpha)$, domain $0<\alpha<D$, $0<\gamma<\min(d,1)$, $C(\alpha,\gamma)=\tfrac{\alpha(1+\alpha)}{d(d-\gamma)}$, $J=C/\gamma$.
- **`dmin D α := min α (D - α)`** is $d$ character for character.
- **`J D α γ := α * (1 + α) / (dmin D α * (dmin D α - γ)) / γ`** is $\tfrac{\alpha(1+\alpha)}{d(d-\gamma)}\cdot\tfrac1\gamma$. The grouping is left-associated division, so the $\gamma$ divides the whole of $C$.
- **Lean's division by zero is inert on the domain.** Every hypothesis set in which `J` is compared has $\gamma>0$, $d>0$ (from $0<\alpha<D$) and $d-\gamma>0$, so no junk value enters. At the optimum, $d=D/2$ and $d-\gamma=D/4$, both positive for $D>0$.
- **`L156_opt`'s domain** is `0 < α`, `α < D`, `0 < γ`, `γ < min (dmin D α) 1`, which is the record's, with the record's $\min(d,1)$ as a single `min`.
- **$D$.** `let D := (2 * m - 1) / (m - 1)` with `2 ≤ m` over $\mathbb R$. The record's $m$ is an integer $\ge2$, so the Lean statement contains the record's range. $D=2+\tfrac1{m-1}\in(2,3]$, so $0<D<4$, which `hD` and `hD4` derive.

## Attack line 2: the minimum, its value, and the kink

- **`J_star`.** At $\alpha=D/2$, `dmin D (D/2) = min (D/2) (D/2) = D/2`, and $J=\tfrac{(D/2)(1+D/2)}{(D/2)(D/4)}\cdot\tfrac4D=\tfrac{4(1+D/2)}{(D/2)^2}$, which is the record's $J^*=4(1+\alpha^*)/\alpha^{*2}$ at $\alpha^*=D/2$. Checked by hand.
- **`L156_opt` has three conjuncts**: $(D/2,D/4)$ in the domain (with $\gamma^*<\min(d^*,1)$ as `lt_min`), the value, and the inequality for every $(\alpha,\gamma)$ in the domain. The first is what makes "attained" and "interior" true, since the domain is open and the point satisfies every inequality strictly (`star_mem`'s five conjuncts, of which `L156_opt` exports the three on $\gamma$, and $0<D/2<D$ is immediate).
- **`hstep`**, $J\ge4\alpha(1+\alpha)/d^3$. From $\gamma(d-\gamma)\le d^2/4$ (by $(d-2\gamma)^2\ge0$) and $\alpha(1+\alpha)>0$, $\tfrac{\alpha(1+\alpha)}{d\,\gamma(d-\gamma)}\ge\tfrac{4\alpha(1+\alpha)}{d^3}$. This is the record's "minimising over $\gamma$ maximises $\gamma(d-\gamma)$" in inequality form, which avoids needing $\gamma=d/2$ to lie in the domain.
- **Below the kink, $\alpha\le a=D/2$.** $d=\alpha$, and the goal $\tfrac{4(1+a)}{a^2}\le\tfrac{4\alpha(1+\alpha)}{\alpha^3}=\tfrac{4(1+\alpha)}{\alpha^2}$ cross-multiplies to $(1+a)\alpha^2\le(1+\alpha)a^2$, i.e. $(a-\alpha)(a+\alpha+a\alpha)\ge0$, which is the `key` fact. Checked by hand.
- **Above the kink, $\alpha\ge a$.** $d=D-\alpha\le a$, $a(1+a)\le\alpha(1+\alpha)$ by monotonicity on positives, and $d^3\le a^3$. Then $\tfrac{4\alpha(1+\alpha)}{d^3}\ge\tfrac{4a(1+a)}{a^3}=\tfrac{4(1+a)}{a^2}$. The proof reaches this through `nlinarith` with the product of the two monotone facts. Checked by hand.
- **Completeness of the split.** `rcases le_total α a` covers $\alpha\le a$ and $a\le\alpha$, so $\alpha=D/2$ lies in both branches and in particular in the first, where $d=\alpha$ by `min_eq_left` at equality. No case is missing.
- **The Lean proof is weaker in method than the record's and sufficient**: the record argues through strict monotonicity of the two branches, the Lean through the two direct inequalities, which is all "minimum at $D/2$" needs.

## Attack line 3: stronger or weaker than the record

- **O1: `J_ge` drops $\gamma<1$ and holds at every $D>0$.** Sound: $\gamma<1$ only restricts the domain, and the inequality uses neither $\gamma<1$ nor the value of $D$. It is a genuine strengthening of the minimisation, and `L156_opt` restores the record's exact domain by `min_le_left`. The strengthening says something the record implies without stating: on $0<\gamma<d$ alone the minimum is still $(D/2,D/4)$, and $\gamma<1$ is slack there for every $m\ge2$, as the record's "slack for every $m\ge2$" says.
- **O2: uniqueness is left unstated.** The record's statement says "attained at", and its proof's strict monotonicity would also give that $(D/2,D/4)$ is the unique minimiser. Neither `J_ge` nor `L156_opt` asserts uniqueness. Nothing in the record's statement or its consumers ([L157](../findings/second-order.md), the corollary's intervals) needs it, so the row is accurate as written. A later round could add it cheaply (strict inequality off the point, from strict monotonicity and $\gamma(d-\gamma)<d^2/4$ at $\gamma\ne d/2$).
- **"Interior" is preserved** by `star_mem`/`L156_opt`'s first conjunct: every defining inequality holds strictly at the optimum.
- **$C^*$ is outside this file.** `L156_opt` states $J^*$ only. $C^*=2+4(m-1)/(2m-1)$ and its agreement with $J^*\gamma^*$ stay in [L156.lean](../lean/HamiltonsCubic/Results/L156.lean) over $\mathbb Q$ with its own `D`. The two files share no declaration, so the chain "minimum attained" to "at the value $C^*$" is composed by reading the two together, which the INDEX row does.

## Attack line 4: build and axioms

- **Build (screen).** `lake build HamiltonsCubic.Results.L156Opt` in the background: "Build completed successfully (8706 jobs)", exit 0, with two `linter.style.longLine` warnings at lines 6 and 8 (P1). The working-tree file is identical to 39260692's.
- **Axioms (screen).** `python3 scripts/misc/axiom_audit.py --only L156Opt.lean`: "auditing 4 declarations across 1 files", "4/4 clean -- resting on the standard three alone", matching the commit message. Both are screens of the build, never evidence beyond it.

## Attack line 5: the INDEX row

- The new sentence names `J_ge` on $0<\gamma<d$ at every $D>0$, `J_star`, `star_mem` at $D<4$ and `L156_opt` at $m\ge2$, each as stated in the file. The owed item is now the resolvent bound $M\le C\gamma g_n$ alone, and the minimisation, previously owed, is no longer listed as owed. Accurate.
- **P1: two docstring lines over 100 characters** (lines 6 and 8, 102 and 108 characters), the source of the two linter warnings. Rewrapping the module docstring there silences them. Presentation only.

## What would break the claims, and what I did to look for it

- **A `J` that divides only part of $C$ by $\gamma$, or a different $d$.** I read both definitions against the record's display and checked the associativity of the division.
- **A domain wider or narrower than the record's in `L156_opt`.** I compared the four hypotheses with the record's inequalities one by one.
- **A point $(\alpha,\gamma)$ in the domain with $J<J^*$**, for example past the kink where $d=D-\alpha$ shrinks. I derived both branch inequalities by hand, including the reduction $(a-\alpha)(a+\alpha+a\alpha)\ge0$ below the kink and the product of $a(1+a)\le\alpha(1+\alpha)$ with $d^3\le a^3$ above it, and checked that $\alpha=D/2$ lies in a branch.
- **An optimum outside the domain**, which would make "attained" vacuous. `star_mem` places it strictly inside once $D<4$, and $D\le3$ at $m\ge2$.
- **Junk values from division by zero.** Every denominator is positive on the domain.
- **No object found.** No point of the record's domain beats $(D/2,D/4)$, and none outside it is claimed.
