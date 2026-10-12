# Review r1060: I110's deficit in closed form, the corner, and the rigidity claim

Adversarial Gate 2 review of the last three sections of [2026-09-14-I104-tau-positive.md](2026-09-14-I104-tau-positive.md), with the Lean column in [I110Deficit.lean](../lean/HamiltonsCubic/Results/I110Deficit.lean). Analysis only: every algebraic claim below was derived from the GIVENs and confirmed symbolically, and the two numerical items are screens of claims r1060 was about to record, both named as screens where they appear.

Log: [r1060-i110-deficit.log](../agent_logs/r1060-i110-deficit.log)

## Verdicts

| claim | verdict |
|---|---|
| C1 interval's lower end and $t+(N-N_i)/2$ on the diagonal | CONFIRMED |
| C2 $F'(u_{\mathrm{lo}})$ identity and its positivity | CONFIRMED |
| C3 $F'>0$ on the whole interval | CONFIRMED, one implicit step and a stale Lean row |
| C4 the deficit cubic | CONFIRMED |
| C5 $d'$ and monotonicity on the feasible range | CONFIRMED |
| C6 the Gram boundary in radicals | CONFIRMED |
| C7 both constraints active | CONFIRMED, and near-tautological as stated |
| C8 the deficit at the corner | CONFIRMED to all sixteen digits |
| C9 GIVEN 4 saturated identically | CONFIRMED, and TRUE MORE GENERALLY than claimed |
| C10 the rigidity read off the equality case | **REFUTED AS WRITTEN**, repaired by one sign |
| C11 the least $f$ on the surviving set | CONFIRMED on the equal diagonal, OVERSTATED as written |

## C10, the one refutation: the record's own bilinear formula sends $\tau$ to ZERO at the configuration it calls the equality case

**The claim.** Saturation of GIVEN 4 forces $4\lVert\nu_j\circ\nu_k\rVert^2=N_jN_k$, whose equality case is $a_1=a_2=0$ with $\lvert b\rvert=\lvert c\rvert$, reduced by GIVEN 6 to $a_i=0$ and $b_i=-c_i$ in all three blocks, with $\nu_3\parallel\nu_1\circ\nu_2$ cyclically.

**Two of its three steps hold.** The elimination that produced GIVEN 4 is EXACT, so the first step is sound: writing $N_i=\alpha^2+\beta^2$, $\beta^2=(\tau-\tfrac12d_iN_i)/2e_i$ and $(\theta+2e_i)^2-d_i^2=8\theta e_i$ turns the norm equation into $d_i^2N_i+4\theta\tau-2\theta d_iN_i=4\lVert\nu_j\circ\nu_k\rVert^2$, an identity, so $4\theta\tau\le N_jN_k+(\theta^2-4e_i^2)N_i$ passes through exactly one inequality and saturating the conclusion saturates it. *The $\beta^2$ elimination the brief suspected of hiding slack hides none.* The consistency step is sound too: $a_1$ is the coefficient on $Q_1$'s pairing $(ij\vert kl)$ whether it is read off $\nu_1\circ\nu_2$ (shared pair $\{i,j\}$) or off $\nu_3\circ\nu_1$ (shared pair $\{k,l\}$), so the two demands on $\nu_1$ are one demand.

**The third step breaks.** Take the three GIVENs in the one coordinate system the record writes them in: the product formula, $\lVert\nu\rVert^2=2(a^2+b^2+c^2)$ (so the three pairing coordinates are orthogonal and the inner product is $2(aa'+bb'+cc')$), and GIVEN 6's $a+b+c=0$. Put $a_1=a_2=0$, so $c_1=-b_1$ and $c_2=-b_2$. Then the product's three coefficients are

$$\tfrac12a_1a_2=0,\qquad \tfrac12(b_1b_2+c_1c_2)=b_1b_2,\qquad -\tfrac12(b_1c_2+c_1b_2)=+b_1b_2,$$

**equal on the last two slots.** And $\nu_3$ with $a_3=0$ has $c_3=-b_3$, **opposite on the same two slots.** So $\tau=2b_1b_2(b_3+c_3)=-2b_1b_2a_3$, which is $0$ when $a_3=0$. *The configuration C10 names as the one where $\tau$ sits at $\tfrac12\sqrt{N_1N_2N_3}$ is a configuration where $\tau$ vanishes.* Worse, $\nu_1\circ\nu_2=(0,B,B)$ is orthogonal to the whole Bianchi plane's $a=0$ line, so $\nu_3\parallel\nu_1\circ\nu_2$ is unreachable for any Bianchi $\nu_3$: the parallelism C10 asserts and the constraint it invokes to get $\lvert b\rvert=\lvert c\rvert$ exclude each other.

**A second symptom, independent of Bianchi.** The trilinear form the record's formula defines is not cyclically symmetric. Its coefficients on the orbit $\{(c,c,b),(b,c,c),(c,b,c)\}$ are $+1,-1,-1$, and over random Bianchi triples the median $\lvert\tau_{12}-\tau_{23}\rvert$ is $1.14$ times the median $\lvert\tau_{12}\rvert$. No relabelling of which non-shared pairing is $b$ and which is $c$ repairs it, in any of the eight per-block combinations. **GIVEN 4 is used cyclically, in three per-block instances of one $\tau$, so a non-cyclic $\tau$ would break that too.**

**The repair is one sign, and it is forced.** Rescaling the third output slot by $-1$, so that the coefficient on $(kp,lm)$ reads $+\tfrac12(b_1c_2+c_1b_2)$, sends the coefficient orbit to $+1,+1,+1$. Then, verified on random Bianchi triples to $2\times10^{-15}$:

- $\tau$ becomes fully symmetric in its three arguments, which is what GIVEN 4's cyclic use requires;
- $\lVert\nu_1\circ\nu_2\rVert^2=\tfrac12A$ is untouched, because $A$ sees only the SQUARE of that coefficient, so GIVEN 3 and its proof survive verbatim;
- the equality case gives $\tau=+\tfrac12\sqrt{N_1N_2N_3}$ EXACTLY, and $\nu_1\circ\nu_2=(0,B,-B)$ is then parallel to $\nu_3=(0,b_3,-b_3)$, so C10's parallelism holds;
- the product's Bianchi defect $a+b+c$ becomes $a_1a_2$ rather than $\tfrac12(b_1-c_1)(b_2-c_2)$, so the product falls INTO the Bianchi space exactly when the bound saturates, which is the structure the equality case wants.

**So C10's mathematical content survives, and the chain that reaches it does not.** *The record's own remark that the equality case matches "the screened maximum $\tfrac12$" is evidence for the repaired sign and against the printed one: under the printed sign a screen over Bianchi blocks maxes at $\tfrac1{2\sqrt3}=0.2887$, not $\tfrac12$.*

**What the sign was worth.** Had the printed formula been right, the largest $f=2\tau/\sqrt{N_1N_2N_3}$ available under Bianchi would be $1/\sqrt3=0.5774$, against C11's least surviving $f=0.8917$, and the surviving set on the equal diagonal would be EMPTY, closing I104's $\tau>0$ case outright. *That is the size of the thing a sign convention decides here, and it is why the repair should be written into the record rather than left as a reader's inference.* **Screened, not proved**: the two numbers $0.2887$ and $0.5000$ come from a $400$-restart optimisation over the three-torus of unit Bianchi blocks, seconds of compute, and they are reported as screens. The algebra above them is exact.

**Two smaller logical faults in the same section.**

- **The route through GIVEN 4 is redundant.** C9 DERIVES GIVEN 4's saturation from $\tau$ sitting at the product bound, so deducing rigidity from that saturation recovers only what $\tau=\tfrac12\sqrt{N_1N_2N_3}$ gives directly through GIVEN 3 and Cauchy-Schwarz. The section presents the detour as the source of the rigidity, and it is a consequence of the hypothesis it starts from.
- **GIVEN 4's saturation does not force the parallelism.** It forces the norm equality $4\lVert\nu_j\circ\nu_k\rVert^2=N_jN_k$ alone, because Cauchy-Schwarz never enters its derivation. The record writes that this equality "is the product bound's own equality case", which folds in a step GIVEN 4 cannot supply. At the corner the parallelism does hold, from $\tau$ being at the bound, so the conclusion stands on a hypothesis other than the one named.

## C9, confirmed and understated

The identity is exact: with $N_j=N_k=N_i=s^2$ and $3u_i^2=(\theta-s)^2$, the numerator is $s^4+(2\theta s-s^2)s^2=2\theta s^3=4\theta\tau$.

**It holds for UNEQUAL $N_i$ as well.** Substituting $u_i=(\theta-2\tau/N_i)/\sqrt3$ into GIVEN 4's right-hand side and subtracting $\tau$ gives

$$\frac{N_jN_k+(\theta^2-3u_i^2)N_i}{4\theta}-\tau\;=\;\frac{\sqrt6\,(N_iN_jN_k-4\tau^2)}{12\,N_i},$$

so **on the criticality lower end GIVEN 4 is not merely saturated by GIVEN 3's extremal $\tau$, it IS GIVEN 3**, restated, with no equal-$N_i$ hypothesis. The section's heading "IDENTICALLY" is therefore right for a reason wider than the one given, and simultaneously **too strong in the other direction**: the two bounds coincide only ON the curve $u_i=u_{\mathrm{lo}}$. For $u_i>u_{\mathrm{lo}}$ GIVEN 4 is strictly sharper, since its numerator falls in $u_i$. *A reader taking the heading at face value would conclude GIVEN 4 carries nothing anywhere, which is false off the lower end.*

## C11, right on the diagonal and overstated off it

The closed form checks exactly, and so do the critical points: eliminating $f$ between $d=0$ and $\partial d/\partial s=0$ gives the resultant $-768\sqrt6\,s^6(s^2-2)^2(8s^2-5)$, whose roots are $s=0$, $s=\sqrt{10}/4$ and $s=\sqrt2$, the last two outside the feasible range as claimed. Solving $d=0$ against the Gram boundary $3f^2s^2+15s^2-3\sqrt6fs-\tfrac12=0$ reproduces $f=0.891690422$, $s=0.441973080$, $N_i=0.195340204$.

**The direction is right too**, and r1060 recomputed it rather than take it: $\partial d/\partial f=(1-f^2)s^3/6+5s/12-\sqrt6fs^2/6$, positive throughout the feasible set (least value $4.2\times10^{-4}$ on a screen, and positive by inspection since $fs\le0.47<5/(2\sqrt6)=1.02$). So $d$ increases in $\tau$, the worst case is $\tau$ at its bound, and a positive $d$ means $F(u_{\mathrm{lo}})<0$, which with C3 means $F<0$ somewhere on the interval, which means the chain does NOT close. **No sign is inverted anywhere in the chain.**

**What is overstated is the sentence, not the number.** "Every surviving configuration has $\tau$ within $11\%$ of its product bound" is a statement about the equal-$N_i$ diagonal only, and the section never restates the restriction it inherits from its own first line. The file's own unequal-$N_i$ evidence is a grid screen that the file itself calls "a screen over a grid and not a proof that the diagonal is optimal", and in any case that screen located the deficit's MINIMISER, which says nothing about the $f$-range of survivors off the diagonal. *The claim needs "on the equal diagonal" in its own sentence.*

## C3, confirmed, with one step the write-up leaves to the reader and a Lean row that is stale

The algebra is exact. $F'(u)=2\theta u-\tfrac{\sqrt3}2u^2-(1-2s^2)/\sqrt3$, its roots are $\sqrt2\pm\tfrac23\sqrt{3+3s^2}$, and $F'(u_{\mathrm{lo}})=\tfrac1{\sqrt3}\big(\tfrac32(s-\tfrac{\sqrt6}6)^2+1\big)$.

**The written argument needs a third sentence.** A downward parabola is positive BETWEEN its roots, and the lower root is positive for every $s$ ($0.2595$ at $s=0$), so bounding the upper root away from $1$ does not on its own place the interval inside the positive region. What closes it is that step 1 already puts $u_{\mathrm{lo}}$ strictly between the roots, so $[u_{\mathrm{lo}},\sqrt t\,]$ is a connected set with its left end inside and its right end below the upper root. *The conclusion is right, the two steps as printed do not reach it without that observation, and [I110Deficit.lean](../lean/HamiltonsCubic/Results/I110Deficit.lean) supplies exactly the missing link in `chainFderiv_pos` via the mean-value factorisation rather than via the roots.*

**On the upper end.** It is not $\sqrt t$, and it is not $\sqrt{5t/9}$ either. With all three blocks sharing $N_i$ and each $u_a\ge u_{\mathrm{lo}}$, GIVEN 5 gives block $i$ the end $u_i^2\le\tfrac53t-2u_{\mathrm{lo}}^2$, which equals $5t/9$ only where the interval has already collapsed, that is at $s_*$. **None of it changes a thing**, for two reasons that should be on the record: $F$ increases, so the minimum stays at $u_{\mathrm{lo}}$ whatever the upper end is, and non-emptiness of the interval is $3u_{\mathrm{lo}}^2\le\tfrac53t$, the same condition either way. *Using $\sqrt t$ in C3 is conservative and safe.*

**The brief's Lean table is wrong about C3.** It is typed, by `chainFderiv_pos` (`F' > 0` on `[u_lo, 1]` under `s ≤ theta`) and `chainF_strictMonoOn` (`F` strictly increasing on `Set.Icc (uLo s) 1`), and since $\sqrt t\le1$ that interval CONTAINS the admissible one. Those are the two strongest statements in the file and the table records them as absent.

## The Lean layer, statement by statement

Read rather than rebuilt, as the brief directs. No `sorry`, no `native_decide`, no `axiom` in the file, and it is imported at [HamiltonsCubic.lean:524](../lean/HamiltonsCubic.lean#L524).

- `chainF` matches GIVEN 1 under the diagonal substitutions $N_i=s^2$, $\tau=s^3/2$, $t+\tfrac{N-N_i}2=1-2s^2$, and the docstring states that restriction. `uLo` matches. `deficit_eq` has the sign the prose has, $d=-F(u_{\mathrm{lo}})$.
- `deficit_strictMonoOn` is on `Set.Icc (0:ℝ) (1/2)`, which contains $s_*=0.4676$ with room. Not vacuous, not weakened.
- `gram_boundary_eq`, `both_constraints_active` and `deficit_at_sStar` are the three identities, and all three are exact.
- **One naming gap.** `chainFderiv` is DEFINED and never proved to be a derivative: no `HasDerivAt`, no `deriv`. Nothing rests on it, because `chainF_strictMonoOn` runs through the algebraic difference identity `chainF_sub` instead, so the file proves monotonicity without ever needing the name to be earned. *Worth a line in the docstring, since a reader who trusts the name is trusting something unstated.*
- **What is NOT typed, and could be, is C9.** The identity $s^4+(\theta^2-(\theta-s)^2)s^2=2\theta s^3$ is one `ring` away, and its general form above is one `field_simp; ring`. C11's closed form and resultant are typeable too. C10 is correctly marked untypeable in this layer, and after the finding above it should not be typed until the sign is settled.

## Reach

**These findings are about** the three named sections of [2026-09-14-I104-tau-positive.md](2026-09-14-I104-tau-positive.md), the algebra they contain, and the statements in [I110Deficit.lean](../lean/HamiltonsCubic/Results/I110Deficit.lean). C1 through C9 and C11 were derived from the GIVENs and confirmed symbolically, so those verdicts carry the weight of the GIVENs and no more.

**They are NOT about** whether the corner is a corner of the full three-parameter problem. Everything from C1 to C11 lives on the equal-$N_i$ diagonal, the record's evidence for the diagonal being optimal is its own grid screen, and r1060 did not open that question, which needs the first-order condition in the three $N_i$ separately and is a run this brief does not authorise. They are also not about whether the corner satisfies the FULL criticality system, which is [I110](../plan.md)'s own open question, nor about $\mathcal W_n$: every object here is a point in the scalar relaxation.

**They are NOT a refutation of GIVEN 3 or GIVEN 4.** Both bounds survive the sign finding untouched, because the bound's proof runs through $A$, which is blind to the sign, and GIVEN 4's derivation never touches the product's coordinates at all.

**Flagged as having had one reader, r1060 alone:**

- **The sign repair.** r1060 could not settle from the record alone WHICH of the two readings the $n=8$ basis-tensor computation actually produced, and argues for the repaired sign on three grounds (cyclic symmetry, attainment of the screened $\tfrac12$, and the product landing in the Bianchi space at saturation) rather than by redoing that computation, which would mean importing the code the brief forbids. **The right next step is for the owner of [screen_I104_gram.py](../scripts/misc/screen_I104_gram.py) or of whatever produced the bilinear formula to print $\tau$ on a cyclic permutation of one triple.** One number settles it.
- **The two screened figures**, $\tfrac1{2\sqrt3}$ and $\tfrac12$, from a $400$-restart Nelder-Mead over the three-torus. The $\tfrac12$ is corroborated by the record's own screen. The $\tfrac1{2\sqrt3}$ is corroborated only by the hand computation that $\lVert P(\nu_1\circ\nu_2)\rVert=\lVert\nu_1\circ\nu_2\rVert/\sqrt3$ at the equality case, which bounds it from below and not above.
- **The claim that no per-block $b\leftrightarrow c$ relabelling restores cyclic symmetry**, which rests on one enumeration of the eight combinations plus the coefficient-orbit argument.
