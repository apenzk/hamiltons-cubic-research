# REVIEW_r1061: the I110 deficit, the cubic corner, and the two $\tau$ bounds

Reviewer `r1061`, adversarial Gate 2, 2026-09-21. Target: the last three sections of [2026-09-14-I104-tau-positive.md](2026-09-14-I104-tau-positive.md), dated 2026-09-21, and the Lean statements in [I110Deficit.lean](../lean/HamiltonsCubic/Results/I110Deficit.lean). Log: [agent_logs/r1061-i110-deficit.log](../agent_logs/r1061-i110-deficit.log).

**Headline. Every constant in the three sections is exact and every algebraic identity checks, including the radicals for $s_*$, $N_i$, $t$, $u$ and $d(s_*)$.** Two defects are in the prose rather than the arithmetic: the monotonicity section states a diagonal-only theorem in general language and the general statement is false, and the second section's heading claims a rigidity for "every surviving block" that its own body establishes only at the single point $f=1$. Two claims are stronger than recorded: the identity behind C9 holds for unequal $N_i$ as well, and the equal-$N_i$ hypothesis, which the record supports with a grid screen it itself criticises, has a one-line first-order proof.

## Verdict table

| claim | verdict | note |
|---|---|---|
| C1 interval lower end, $t+\tfrac{N-N_i}2=1-2s^2$ | CONFIRMED | exact |
| C2 $F'(u_{\mathrm{lo}})\ge1/\sqrt3$ | CONFIRMED | discriminant $-6$ verified |
| C3 $F$ increasing on the whole interval | CONFIRMED on the diagonal, REFUTED as stated | see [F3](#f3) |
| C4 the cubic $d(s)$ | CONFIRMED | exact, derived independently |
| C5 $d'(s)$ and monotonicity on the feasible range | CONFIRMED | roots $(\sqrt6\pm1)/2$ |
| C6 the Gram boundary in radicals | CONFIRMED | all four radicals exact |
| C7 both constraints active at $s_*$ | CONFIRMED | identity, not coincidence |
| C8 $d(s_*)$ in radicals | CONFIRMED | $=\tfrac{44\sqrt{10}-45\sqrt6}{1944}$, same number |
| C9 GIVEN 4 saturated identically | CONFIRMED and STRONGER | see [F1](#f1) |
| C10 the rigidity read off the equality case | CONFIRMED in substance, heading REFUTED | see [F2](#f2), [F4](#f4) |
| C11 the least $f$ on the surviving set | CONFIRMED | crossing at $f=0.891690$ reproduced |

Direction of the deficit, checked as asked: the chain excludes when $F\ge0$ throughout, $\min F=F(u_{\mathrm{lo}})=-d$, so $d>0$ is exactly "the chain does not close", and $\partial d/\partial\tau=+2.0645$ at the corner with $\partial d/\partial f\ge0.0198$ over the whole box $s\in(0,s_*]$, $f\in[0,1]$. The worst case really is $\tau$ at its GIVEN 3 bound.

## <a id="f1"></a>F1. C9's identity is not about the diagonal, and not about $\tau$ being maximal. It is GIVEN 3 rewritten.

**The record proves the identity by substituting $N_i=s^2$ and $\tau=\tfrac12s^3$. Neither substitution is needed.** Substitute only $u_i=u_{\mathrm{lo},i}=(\theta-2\tau/N_i)/\sqrt3$ into GIVEN 4's numerator, with $N_1,N_2,N_3$ and $\tau$ free:

$$N_jN_k+\big(\theta^2-3u_{\mathrm{lo},i}^2\big)N_i-4\theta\tau\;=\;N_jN_k+\Big(\frac{4\theta\tau}{N_i}-\frac{4\tau^2}{N_i^2}\Big)N_i-4\theta\tau\;=\;N_jN_k-\frac{4\tau^2}{N_i}.$$

**So GIVEN 4 evaluated at the lower end of block $i$'s interval says $4\tau^2\le N_iN_jN_k$, which is GIVEN 3, verbatim and for every $N$.** The two are one inequality read at one point, which is the strongest form of what the section is claiming, and the $s^4$ cancellation the record highlights is the $N_jN_k$ term surviving alone.

**Three consequences the section does not draw.** First, the reduction is symmetric in $i$, so saturation for one block forces it for all three, which is what C10's "cyclically" needs and it now needs no separate argument. Second, GIVEN 4 is not spent: at $u_i>u_{\mathrm{lo},i}$ its numerator is strictly smaller, so it is strictly stronger than GIVEN 3 there. Read as a bound on $u_i$ it is an upper pin $u_{\mathrm{cap},i}$ with $u_{\mathrm{cap},i}^2-u_{\mathrm{lo},i}^2=\tfrac13N_jN_k(1-f^2)/N_i$ on the diagonal, collapsing the interval to the single point $u_{\mathrm{lo}}$ exactly at $f=1$. Third, that pin closes nothing, because $F$ is minimised at $u_{\mathrm{lo}}$ and $u_{\mathrm{cap}}\ge u_{\mathrm{lo}}$ always, so the section's conclusion survives with a better reason than the one given.

## <a id="f2"></a>F2. C10's derivation step is sound, and the suspicion about the $\beta^2$ elimination is unfounded.

**The elimination that produced GIVEN 4 introduces no inequality at all.** Reconstructing it from [the vector-system section](2026-09-14-I104-tau-positive.md), with $e_i=\tfrac{\sqrt3}2u_i$ and $d_i=\theta-\sqrt3u_i$: $\beta^2=(2\tau-d_iN_i)/4e_i$ and $\alpha^2=N_i-\beta^2$ are exact substitutions, and

$$d_i^2\alpha^2+(\theta+2e_i)^2\beta^2=d_i^2N_i+8\theta e_i\beta^2=d_i^2N_i+2\theta(2\tau-d_iN_i)=4\theta\tau-N_id_i(d_i-2\theta)=4\theta\tau-N_i(3u_i^2-\theta^2).$$

**So $4\theta\tau\le N_jN_k+(\theta^2-3u_i^2)N_i$ rests on the single inequality $4\lVert\nu_j\circ\nu_k\rVert^2\le N_jN_k$, and saturation of the bound forces equality in it.** C10's first step is therefore correct, and it is correct for the reason that there is nowhere else for slack to hide. One hypothesis the elimination needs and nobody states: $e_i\ne0$, that is $u_i>0$. It holds at the corner, $u=0.437110$.

**The equality case is read off GIVEN 3's proof correctly, with one condition omitted that turns out to be free.** Expanding, $(b_1b_2+c_1c_2)^2+(b_1c_2+c_1b_2)^2=(b_1^2+c_1^2)(b_2^2+c_2^2)+4b_1b_2c_1c_2$, so the first step is equality iff $\lvert b_1\rvert=\lvert c_1\rvert$, $\lvert b_2\rvert=\lvert c_2\rvert$ **and $b_1c_1b_2c_2\ge0$**. The record omits the sign condition. Under GIVEN 6 with $a=0$ one has $bc=-b^2\le0$ in each block, so the product of the two is nonnegative and the condition is met. The second step is equality iff $a_1^2a_2^2+2a_1^2B_2+2a_2^2B_1=0$, which for two nonzero blocks is $a_1=a_2=0$, as recorded.

**The consistency argument is right about which pairing each condition kills.** $Q_1$ shares $\{i,j\}$ with $Q_2$ and $\{k,l\}$ with $Q_3$, and the pairing of $Q_1$ having $\{i,j\}$ as one part is $(ij\vert kl)$, which is also the one having $\{k,l\}$ as one part. The same check for $Q_2=\{i,j,m,p\}$ gives $(ij\vert mp)$ twice and for $Q_3=\{k,l,m,p\}$ gives $(kl\vert mp)$ twice. Three demands, one coordinate each, no collision.

**One imprecision.** The record calls $4\lVert\nu_j\circ\nu_k\rVert^2=N_jN_k$ "the product bound's own equality case". It is the norm half of it. Saturating GIVEN 3 itself needs the Cauchy-Schwarz equality $\nu_3\parallel\nu_1\circ\nu_2$ as well, which the record does list, so the content is right and only the phrase is loose.

## <a id="f3"></a>F3. C3 is true on the diagonal and false in the generality its heading claims, and the failure is not harmless.

**The heading reads "$F$ is increasing on the WHOLE admissible interval, derived rather than sampled", and the conclusion sentence reads "$F'>0$ ON ALL OF $[u_{\mathrm{lo}},\sqrt t\,]$". Both are unqualified. The derivation is not**: Step 1 substitutes $t+N_i=1-2s^2$, which is the equal-$N_i$ diagonal with $\tau$ at its bound, and Step 2 inherits it.

**Off the diagonal the statement fails, at an explicit configuration.** Take $N=(0.02,0.30,0.30)$, so $\tau=\tfrac12\sqrt{N_1N_2N_3}=0.0212132$ and $2\tau/N_1=2.12132>\theta$. Then block 1's criticality lower end is $u_{\mathrm{lo},1}=-0.517638$, so the binding lower end is $u_1\ge0$, and with $K=t+\tfrac{N-N_1}2=0.68$,

$$F_1'(0)=-K/\sqrt3=-0.392598<0,$$

with $F_1$ falling from $F_1(0)=+0.00897$ to about $-0.0235$ and turning at the lower root $\sqrt2-\sqrt{2-\tfrac23K}=0.170563$, well inside $[0,\sqrt t\,]=[0,0.616]$.

**That is a live trap rather than a formality.** At this configuration $F_1(0)>0$, so a reader applying "the minimum is at the lower end" concludes block 1 is excluded, when the true minimum is negative and it is not. The correction is one clause: the claim holds whenever $2\theta w-\tfrac12w^2\ge K$ with $w=\theta-2\tau/N_i$, which on the diagonal is guaranteed because $w\ge\theta-s_*=0.757$ gives $2\theta w-\tfrac12w^2\ge1.5685>1\ge K$.

**The Lean file is not at fault here.** [chainF](../lean/HamiltonsCubic/Results/I110Deficit.lean) hardcodes the diagonal and its docstring says so, so `chainF_strictMonoOn` is a correct diagonal statement. The prose is where the scope is lost.

**A presentational gap in the same section, for completeness.** Steps 1 and 2 give $F'(u_{\mathrm{lo}})>0$ and "upper root $>1\ge\sqrt t$", and the conclusion needs one more line: a downward parabola positive at the left endpoint puts that endpoint above the lower root, and the right endpoint below the upper root then puts the whole interval between the roots. The line is missing from the prose and present in Lean as `chainFderiv_pos`.

## <a id="f4"></a>F4. "That pins every surviving block" is an overclaim, and the section's own C11 is what refutes it.

**The rigidity in C10 follows from EXACT saturation of GIVEN 4, which by [F1](#f1) is exact saturation of GIVEN 3, that is $f=1$.** The same section then proves that the surviving set only bounds $f\ge0.891690$. So the rigidity holds at the corner and nowhere else that has been shown.

**The shortfall is not a perturbation that can be waved through.** At $u_i=u_{\mathrm{lo},i}$ the exact elimination in [F2](#f2) gives $4\lVert\nu_j\circ\nu_k\rVert^2=4\tau^2/N_i=f^2N_jN_k$, so at $f=0.891690$ the norm equality misses by $1-f^2=0.2049$, a fifth of $N_jN_k$. No stability statement converts a 20% defect in the equality case into a bound on $\lvert a_i\rvert$, and none is offered. **The body's honest claim is the one it makes two sentences later, that $\tau$ is within $11\%$ of its bound on the surviving set, and the heading should say that.**

## <a id="f5"></a>F5. The equal-$N_i$ hypothesis deserves better than the grid screen the record rests it on, and it gets it in one line.

**The record's evidence that the diagonal is optimal is [screen_I104_unequal_N.py](../scripts/misc/screen_I104_unequal_N.py) at spacing $0.005$, and the very next section says "a grid cannot find this point" because the optimum sits on a constraint boundary.** The two statements sit a paragraph apart and the second undercuts the first: a grid that cannot land on the boundary in the diagonal slice cannot land on it in any slice, so it compares interior points, none of which is its slice's optimum.

**The first-order argument settles it.** Write the objective as $\max\min_i d_i$ over $(N_1,N_2,N_3)$ with $\tau=\tfrac12\sqrt{N_1N_2N_3}$, subject to $g=\sum_iu_{\mathrm{lo},i}^2-\tfrac53t\le0$. At the corner all three $d_i$ equal $0.0148730342706614$ and $g=0$ exactly. By symmetry $\nabla d_1=(A,B,B)$ with, computed there, $A=-0.115185$ and $B=+0.115185$, and $\nabla g=(C,C,C)$ with $C=1.127017$. For a trace-free perturbation $\sum_i\epsilon_i=0$ this gives $\delta g=0$ and $\delta d_i=(A-B)\epsilon_i=-0.230371\,\epsilon_i$, so $\min_i\delta d_i=-0.230371\max_i\epsilon_i<0$ for every nonzero such $\epsilon$. **Feasibility is untouched to first order and the objective strictly falls, so the diagonal is a strict local maximum in the transverse directions**, and the symmetric direction is the $d(s)$ analysis the record already has.

**A screen, reported as a screen.** A 6-variable constrained maximisation of $\min_i(-F_i(u_i))$ over $(N_1,N_2,N_3,u_1,u_2,u_3)$ with $\sum u_i^2\le\tfrac53t$, $u_i\ge\max(0,u_{\mathrm{lo},i})$ and $u_i\le\sqrt t$, from 301 starts, returns $0.014873034270662645$ at $N_i=0.21869398$, $u_i=0.4371105$ with zero Gram slack, against the exact $0.0148730342706614$. This screen chooses each $u_i$ freely rather than assuming the minimum sits at $u_{\mathrm{lo},i}$, so it is not exposed to [F3](#f3). It is evidence, not a proof of global optimality.

## The Lean column

**The file type-checks**, `lake env lean HamiltonsCubic/Results/I110Deficit.lean` exiting 0 with no diagnostics, so every statement below is a real theorem and the question is only whether it is the claim. **The Lean column handed to `r1061` and the file's own header are both stale in the same direction: they under-report what is typed.**

- **C3 is typed, against a Lean column that records it as untyped.** `chainFderiv_pos (s a) (hs : s ≤ theta) (hlo : uLo s ≤ a) (ha1 : a ≤ 1) : 0 < chainFderiv s a` and `chainF_strictMonoOn (s) (hs : s ≤ theta) : StrictMonoOn (chainF s) (Set.Icc (uLo s) 1)` are exactly C3, over $[u_{\mathrm{lo}},1]\supseteq[u_{\mathrm{lo}},\sqrt t\,]$, and non-vacuous, since $s\le\theta$ gives $0\le u_{\mathrm{lo}}\le\theta/\sqrt3=0.7071<1$.
- **The file's "What is proved" list omits that whole group**: `chainF_sub`, `chainFderiv`, `chainF_sub`'s companion `chainFderiv_sub`, `chainFderiv_at_uLo`, `chainFderiv_at_uLo_pos`, `chainFderiv_pos` and `chainF_strictMonoOn` are all absent from lines 23 to 34 while sitting in the file.
- **`chainFderiv` is a definition that is never connected to `deriv`.** Its docstring says "this is its derivative and the difference identity below proves it is". No declaration in the file states `deriv (chainF s) = chainFderiv s`. The identity `chainF_sub` does give the mean-value slope whose diagonal value is `chainFderiv`, and `chainF_strictMonoOn` is proved from `chainF_sub` directly, so nothing depends on the missing link. The docstring sentence is still false as written, and either a `HasDerivAt` lemma or a reworded docstring fixes it.
- **`chainFderiv_at_uLo_pos` is weaker than C2.** C2 claims $F'(u_{\mathrm{lo}})\ge1/\sqrt3$, Lean states $0<F'(u_{\mathrm{lo}})$. The full content is in `chainFderiv_at_uLo`, which gives the identity, so the bound is one `div_le_div` away.
- **`deficit_strictMonoOn` is weaker than C5 and sufficient.** C5 claims monotonicity up to $(\sqrt6-1)/2=0.72474$, Lean proves it on $[0,1/2]$, and $s_*=0.46765<1/2$.
- **`gram_boundary_eq` states that $s_*$ is a root, not that it is the positive root or that feasibility is $[0,s_*]$.** The substantive half of C6 and C7 is carried by `both_constraints_active`, which is the real identity.
- **C8's numeral is untyped.** `deficit_at_sStar` gives the radical; $0.0148730342706614$ lives only in a docstring.
- **Statement fidelity elsewhere is good.** `chainF` matches GIVEN 1 on the diagonal, `chainF_uLo` and `deficit_eq` reproduce the substitution I derived by hand, `deficit_sub` factors correctly, and `both_constraints_active` and `deficit_at_sStar` are the claims and not weakenings. One docstring slip at line 17 writes the coefficient as $t+N_i$ where GIVEN 1 has $t+\tfrac{N-N_i}2$; they agree on the diagonal, which is all `chainF` covers.

C9, C10 and C11 are untyped, correctly so: C9 is a one-line identity nothing depends on typing, and C10 and C11 reach objects the base layer does not carry.

## Recommendation

**Three edits, in this order.** Qualify the monotonicity section's heading and conclusion with "on the equal-$N_i$ diagonal" and add the $2\theta w-\tfrac12w^2\ge K$ condition, because [F3](#f3) is the only finding here that can mislead a later reader into a false exclusion. Change "that pins every surviving block" to "that pins the corner", since [F4](#f4) shows the body proves the weaker thing. Replace the grid-screen justification of the equal-$N_i$ hypothesis with the two-line first-order argument in [F5](#f5), which closes the item [commit 269f871e](../findings/LEDGER.md) flagged as owing a reviewer.

## Reach

**What these findings are about.** The algebra of the three sections dated 2026-09-21, the scope of their hypotheses, the structure of GIVEN 4's derivation as reconstructed from [the vector-system section](2026-09-14-I104-tau-positive.md) of the same file, and the fidelity of the Lean statements in [I110Deficit.lean](../lean/HamiltonsCubic/Results/I110Deficit.lean) to the prose.

**What they are NOT about.** They are not about whether GIVEN 1 through GIVEN 6 are true; those were handed to `r1061` as givens and were not re-derived. They are not about whether the corner configuration satisfies the full criticality system, which is [I110](../plan.md)'s open question. They are not about whether $\tau=\tfrac12\sqrt{N_1N_2N_3}$ is realised by any actual Weyl tensor, only about what saturation would force. They say nothing about the $x_i<0$ regime, the coupling bound's $0.0089895$ pricing, or anything in the file dated before 2026-09-21. **And [F5](#f5)'s first-order argument establishes a strict LOCAL maximum at the diagonal corner, not global optimality**, which still rests on a screen.

**Single-reader claims, mine, flagged as such.** The counterexample in [F3](#f3) is one configuration evaluated by `r1061` alone and has had no second reader. The reconstruction of GIVEN 4's elimination in [F2](#f2) infers the intermediate quantities $e_i=\tfrac{\sqrt3}2u_i$ and $d_i=\theta-\sqrt3u_i$ from the reduced form and from the scalar pinning quoted in the same paragraph; if the record's $e_i$ is something else, the conclusion that no inequality enters the elimination would need rechecking, though the general identity in [F1](#f1) reaches the same place without it. The gradient numbers in [F5](#f5) were computed once, symbolically differentiated and evaluated at one point.
