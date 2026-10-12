# r1068: Gate 2 on "I111 CLOSES: the norm constraint pins $u$ to $u_{\mathrm{lo}}$ exactly, at every $s$"

Target: the last section of [2026-09-14-I104-tau-positive.md](2026-09-14-I104-tau-positive.md), dated 2026-09-22, with [I111Branch.lean](../lean/HamiltonsCubic/Results/I111Branch.lean). Log: [agent_logs/r1068-i111-closure.log](../agent_logs/r1068-i111-closure.log).

**VERDICT: THE CLOSURE IS REFUTED. Every step of the algebra is right and the conclusion does not follow, because the whole argument runs at $\tau=\tfrac12s^3$ and the surviving set is not confined to that slice.** *The section's own file, four sections earlier, records the surviving set reaching $\tau/(\tfrac12s^3)=0.891690$, and at every surviving configuration below $1$ the pinning is not merely slack, it is violated: $u>u_{\mathrm{lo}}$ STRICTLY, by up to $0.0354$, which is larger than the whole $F<0$ window the previous section tabulated.*

| claim | verdict |
|---|---|
| K1 $\cos2\beta=u_{\mathrm{lo}}/u$ | CONFIRMED at $\tau=\tfrac12s^3$, the general form is $\cos2\beta=u_{\mathrm{lo}}(\tau)/u$ |
| K2 norm expansion | CONFIRMED |
| K3 the cancellation | CONFIRMED, and it is [L220](../findings/second-order.md)'s step 5 restated |
| K4 (i) $g'=6u>0$ | CONFIRMED |
| K4 (ii) $g(u_{\mathrm{lo}})=N$ | CONFIRMED at $\tau=\tfrac12s^3$ ONLY. In general $g(u_{\mathrm{lo}}(\tau))=f^2N$ |
| K4 (iii) $g\le N$ from G7 | CONFIRMED, and the space objection does not bite |
| K5 $u=u_{\mathrm{lo}}$ exactly | **REFUTED** |
| K6 shape forced throughout | **REFUTED** as stated, holds on the $f=1$ slice |
| K7 $\min_s$ gain$/d=1.296955$ | PLAUSIBLE as arithmetic, the number is $1.2968015$, and it is conditional on K6 |
| K8 $(x/u)^2=\tfrac13$ on the Gram boundary | CONFIRMED |
| G2 as a vector equation | CONFIRMED sound, the brief's objection fails |
| the Lean statements | they do not carry the disputed step |

## Finding 1, THE REFUTATION: $g(u_{\mathrm{lo}})=N$ is an artefact of $\tau$ being at its bound

**Write $\tau=f\cdot\tfrac12s^3$ and carry $f$ through instead of setting it to $1$.** Two of the argument's inputs move together, and the note moves only one of them.

- **G6 gives $\langle L_q\nu,\nu\rangle=\tfrac\theta2N-\tau=\tfrac{s^2}2(\theta-fs)$**, so K1 reads $e\cos2\beta=\tfrac12(\theta-fs)$ and $\cos2\beta=u_{\mathrm{lo}}(f)/u$ with $u_{\mathrm{lo}}(f):=(\theta-fs)/\sqrt3$.
- **The criticality bound moves the same way.** $\lvert\langle L_q\nu,\nu\rangle\rvert\le eN$ is exactly $\lvert\cos2\beta\rvert\le1$, so "criticality gives $u\ge u_{\mathrm{lo}}$" is really $u\ge u_{\mathrm{lo}}(f)$, which is LARGER than $u_{\mathrm{lo}}(1)$ when $f<1$.
- **K3 survives verbatim**, $g(u)=\theta^2+3u^2-2\sqrt3\,\theta\,u_{\mathrm{lo}}(f)$, since the cross term is $4\theta\cdot\tfrac12(\theta-fs)$ and carries no $u$ at any $f$.
- **K4 (ii) does not.** $g(u_{\mathrm{lo}}(f))=(\theta-\sqrt3u_{\mathrm{lo}}(f))^2=(fs)^2=f^2N$, verified to $50$ digits at $(s,f)\in\{0.44,0.4676465\}\times\{1,0.95,0.9\}$ with residual below $10^{-50}$.

**So $g\le N$ gives $3u^2\le s^2+\theta^2-2\theta fs$, that is**

$$u_{\mathrm{lo}}(f)^2\;\le\;u^2\;\le\;u_{\mathrm{lo}}(f)^2+\frac{s^2(1-f^2)}{3},$$

**an interval of width exactly $s^2(1-f^2)/3$ in $u^2$, which collapses to a point at $f=1$ and at no other $f$.** *The pin is the equality case of the product bound reappearing, and the note reads it as a theorem about $u$ when it is a theorem about $\tau$.*

**AND THE $f<1$ PART OF THE SURVIVING SET IS NOT EMPTY, BY THE FILE'S OWN ARITHMETIC.** *Screen, not evidence, on the closed forms already in the file: taking the surviving set to be $d(s,f)>0$ together with the Gram condition $u_{\mathrm{lo}}(f)^2\le\tfrac59t$, it is nonempty for every $f$ down to about $0.8917$, which reproduces the $f=0.891690$ at $s=0.441973$ the file records four sections earlier.*

| $f$ | surviving $s$ | $u_{\mathrm{lo}}(f)-u_{\mathrm{lo}}(1)$, max | $u$-interval width, max |
|---|---|---|---|
| $1.00$ | $[0.3588,\,0.4676]$ | $0$ | $0$ |
| $0.97$ | $[0.3774,\,0.4608]$ | $0.00798$ | $0.00453$ |
| $0.95$ | $[0.3914,\,0.4561]$ | $0.01317$ | $0.00708$ |
| $0.91$ | $[0.4241,\,0.4465]$ | $0.02320$ | $0.01122$ |
| $0.90$ | $[0.4336,\,0.4440]$ | $0.02563$ | $0.01034$ |
| $0.89$ | empty | | |

**The third column is the refutation.** *It is the amount by which $u$ EXCEEDS $u_{\mathrm{lo}}$ at a surviving configuration, forced from below by criticality, so it is not slack that some further argument might close. K5 says $u=u_{\mathrm{lo}}$ at every surviving configuration, and at $f=0.90$, $s=0.44$ every surviving configuration has $u\ge u_{\mathrm{lo}}+0.0256$.*

**The excess also dwarfs what the previous section called the item.** *That section tabulated the $F<0$ window at widths up to $0.0197$ and asked whether the shape survives across it. The $f<1$ configurations sit $0.035$ above the window's left endpoint at $s_*$, outside the window that section drew.*

## Finding 2, WHY THE ARGUMENT LOOKED CLOSED: $f=1$ IS THE WORST CASE FOR THE CHAIN AND THE BEST CASE FOR THE RIGIDITY

**Both readings of $f=1$ are correct and they are about different things, and the section uses them at the same configuration.**

- **The deficit is increasing in $f$**, so $f=1$ maximises it. $\partial d/\partial f$ at $f=1$ runs $0.0971$ at $s=0.36$ to $0.1056$ at $s_*$, positive throughout, so the file is right to take $f=1$ when asking which $s$ survive.
- **The forcing needs $f=1$ too**, since that is where $g(u_{\mathrm{lo}})=N$ and the pin closes.

**A closure needs one configuration at which the chain fails AND the shape is forced. The section establishes that the chain fails somewhere on the $f=1$ slice and that the shape is forced on the $f=1$ slice, and concludes the two meet, which is true. What it then asserts is the different statement that the shape is forced at EVERY surviving configuration**, and the surviving set is two-dimensional in $(s,f)$ while the forcing lives on a one-dimensional slice of it. *The brief asked whether the deficit is increasing in $\tau$ in the presence of the norm constraint. It is, and that is the reason the gap is invisible: nothing goes wrong on the slice the deficit analysis lives on.*

## Finding 3, K3 IS THE RECORD'S OWN VECTOR BOUND, READ BACKWARDS

**$g\le N$ is verbatim the bound this file already derived.** *Expanding $\lVert(\theta-2L_q)\nu\rVert^2=\theta^2N-4\theta\langle L_q\nu,\nu\rangle+4\lVert L_q\nu\rVert^2$ and using $\lVert L_q\nu\rVert^2=e^2N$, which holds because BOTH eigenvalues on the Bianchi plane have modulus $e$, gives $g=3u^2-\theta^2+4\theta\tau/N_i$, so $g\le N_jN_k/N_i$ is $4\theta\tau\le N_jN_k+(\theta^2-3u_i^2)N_i$.* **That is the "vector system's bound" of the section headed "The second $\tau$ bound is the product bound, IDENTICALLY"**, checked here to agree to $10^{-51}$ at $(s,f,u)=(0.43,0.93,0.48)$.

**So K1 to K3's "cancellation" is not a new mechanism.** *$L_q$ restricted to the plane is $e$ times a reflection, so $\lVert L_q\nu\rVert=e\lVert\nu\rVert$ for every $\nu$ and the $\beta$-dependence was never there to collapse.* **And that earlier section already proved this bound SATURATED at $\tau=\tfrac12s^3$, $u=u_{\mathrm{lo}}$, for every $s$**, which is K4 (ii) in the other reading. *The closure re-reads a saturation identity as a pin and inherits its hypothesis.*

## Finding 4, THE BRIEF'S SPACE OBJECTION FAILS, AND G2 IS SOUND

**G2 is a genuine vector equation, not a pairing upgraded to one.** *[L220](../findings/second-order.md)'s step 4 proves $L_r\nu=0$ outright: $L_r\nu$ lies in $V_Q$ by L120 and is orthogonal to all of $V_Q$ because $\nu\circ\nu'\in\Pi_Q\perp r$, so $D\circ\nu=L_q\nu$ as VECTORS, and [L221](../findings/second-order.md)(a) repeats the argument in the shared-index setting.* **The record's own prose states it as the pairing $\langle D\circ\nu_i,\nu_i\rangle=\langle L_{q_i}\nu_i,\nu_i\rangle$, which would not license K2's norm**, and the vector form is available one step back in L220. *Worth a sentence in the record, since the weaker form is what L221 item 2 prints.*

**And K4's norm comparison is legitimate even though $\nu_b\circ\nu_c$ lives in three dimensions.** *Criticality holds after projection to $\mathcal W_n$, so the left side is $2\Pi_{\mathcal W}(\nu_b\circ\nu_c)$ and $\lVert\Pi_{\mathcal W}(\nu_b\circ\nu_c)\rVert\le\lVert\nu_b\circ\nu_c\rVert$, with G7 bounding the larger.* **The inequality therefore runs the right way and the two spaces do not need reconciling.** *The stronger consequence the brief hoped for is real but empty as a route: an out-of-plane part would make $g<N$ strictly and exclude the configuration, which closes nothing extra, because at $f<1$ the strict inequality is what the geometry already permits.*

## Finding 5, K7's number is wrong in the fifth digit

**The minimum of gain$/d$ is $1.2968015$, not $1.296955$.** *At $s_*=(\sqrt6+\sqrt{10})/12$, gain $=\tfrac1{2\sqrt3}u_{\mathrm{lo}}(t-u_{\mathrm{lo}}^2)=0.0192873726$ and $d=\tfrac{11\sqrt{10}}{486}-\tfrac{5\sqrt6}{216}=0.0148730343$, whose ratio is $1.29680146$ at 30 digits.* **The file's own I110 section quotes $0.0192874$ against $0.0148730$, whose ratio is $1.2968063$, so the section disagrees with its neighbour rather than with r1068 alone.**

**The minimiser is confirmed at the right endpoint.** *gain$/d$ decreases monotonically across $(0.3588,\,s_*]$ on a $2001$-point evaluation of the closed forms, with its least value at $s_*$ exactly, so "attained at $s_*$" stands and $1.297$ to four figures stands.*

**The deficit's closed form is exact.** *$d(s_*)-\big(\tfrac{11\sqrt{10}}{486}-\tfrac{5\sqrt6}{216}\big)=-1.7\times10^{-52}$ at 50 digits, so that radical is confirmed.*

## Finding 6, K8 is confirmed, and so is the non-vacuity check

**K8 is an identity and holds.** *$\tfrac56-\tfrac{5t}{18u^2}$ at $u^2=\tfrac59t$ is $\tfrac56-\tfrac12=\tfrac13$, and $u_{\mathrm{lo}}(s_*)^2-\tfrac59t(s_*)=1.1\times10^{-41}$ at 40 digits, so the Gram boundary and the criticality end really do coincide at $s_*$.* **It is independent of the pinning dispute**, resting on [r1059](REVIEW_r1059.md)'s forcing and the Gram relation alone.

**The vacuity check passes.** *On the $f=1$ slice, where K5 does hold, the surviving set is $d(s)>0$ over an interval of width $0.109$ in $s$, so "$u=u_{\mathrm{lo}}$" is a statement about a nonempty set and K7 is not true-and-pointless.* **What is empty there is the $u$-interval, which is the section's actual content on that slice**, and it is correct.

## Finding 7, the Lean file compiles and states less than the prose

`lake env lean HamiltonsCubic/Results/I111Branch.lean` exits $0$ with no output, so all five declarations are proved on standard axioms and no `sorry` remains. **What they prove is thinner than the section reads.**

- **`u_eq_uLo` is monotonicity with the disputed step as a hypothesis.** Its `hbound` is $\theta^2+3u^2-2\sqrt3\theta L\le(\theta-\sqrt3L)^2$, which is $g(u)\le g(L)$, so the theorem says only that $g$ is increasing. **The content is the passage from $g\le N$ to $g\le g(u_{\mathrm{lo}})$, which is exactly $g(u_{\mathrm{lo}})=N$, the step Finding 1 refutes off $f=1$, and it is assumed rather than derived.**
- **The single free symbol `L` is where the defect hides.** `hu : L ≤ u` is the criticality bound, whose true $L$ is $u_{\mathrm{lo}}(f)$, while `hbound`'s $N$ is $s^2$, whose matching $L$ is $u_{\mathrm{lo}}(1)$. *Writing one letter for both is the $f=1$ assumption made invisible by notation, and Lean cannot see it because neither $\tau$ nor $s$ appears in the file.*
- **`g_closed_form` is an identity in free variables and never says $L/u=\cos2\beta$.** It is $\theta^2+4e^2-4\theta e(L/u)=\theta^2+3u^2-2\sqrt3\theta L$ at $e=\sqrt3u/2$, true for any $L$, so K1 is untyped and the substitution it licenses is unchecked.
- **`g_at_uLo` is $\theta^2+3L^2-2\sqrt3\theta L=(\theta-\sqrt3L)^2$**, a square completed. *The identification of $(\theta-\sqrt3u_{\mathrm{lo}})^2$ with $s^2$ is `coeff_at_uLo` in another file and holds only at $f=1$, which the docstring cites without stating.*
- **`norm_expand`, `ratio_sq` and `ratio_sq_at_gram` are faithful**, and the file's own "What is NOT stated" section is accurate for the K8 half.

**WHAT THE LEAN LEAVES UNPROVED IS THE WHOLE OF K1, K5 AND K6.** *K2, K3 and K4 (ii) are typed as algebra with their hypotheses free, and the three statements that would make the closure a closure, that $\cos2\beta$ equals $u_{\mathrm{lo}}/u$, that $g\le N$ implies $g\le g(u_{\mathrm{lo}})$, and that the forced shape follows, are absent.*

## Corrections owed

1. **Withdraw K5, K6 and the heading.** The correct statement is: **at $\tau=\tfrac12s^3$ the norm constraint pins $u=u_{\mathrm{lo}}$ exactly, at every $s$**, and off that slice it confines $u^2$ to an interval of width $s^2(1-f^2)/3$ above $u_{\mathrm{lo}}(f)^2$.
2. **Withdraw "I104's $\tau>0$ case is closed on the equal-$N_i$ diagonal."** What is closed is the $\tau$-saturated sub-case of it.
3. **Read $u_{\mathrm{lo}}$ as $\tau$-dependent throughout**, $u_{\mathrm{lo}}(\tau)=(\theta-2\tau/N)/\sqrt3$. The symbol carrying $f=1$ silently is what made two different lower bounds look like one.
4. **Correct $1.296955$ to $1.2968015$**, and reconcile it with the $0.0192874/0.0148730$ the I110 section prints.
5. **Add `s` and `τ` to the Lean file** so `u_eq_uLo`'s two uses of `L` are forced apart, and derive `hbound` from the product bound rather than assuming it.

## Reach

**I111 IS OPEN AND ITS STATEMENT IS NOW SHARPER THAN BEFORE.** *The item is no longer "does the forced shape survive a window of width $0.02$ in $u$", which was the previous section's frame and which this section correctly collapses on its own slice. It is: does the forced shape survive a misalignment of the eigenvector, on the two-dimensional surviving set in $(s,\tau)$?*

**AND THE MISALIGNMENT IS SMALL, WHICH IS THE ROUTE.** *$\cos2\beta=u_{\mathrm{lo}}(f)/u\ge u_{\mathrm{lo}}(f)/\sqrt{u_{\mathrm{lo}}(f)^2+s^2(1-f^2)/3}$, and maximising the resulting angle over the surviving set gives $\beta\le6.32^\circ$, attained near $s=0.432$, $f=0.9015$.* **So $\nu$ is within $6.4^\circ$ of $L_q$'s top eigenvector at every surviving configuration**, against $0^\circ$ on the saturated slice. *A quantitative version of [I110](../plan.md)'s eigenvalue algebra, bounding $\max(x,y,z)$ in terms of $\beta$ rather than evaluating it at $\beta=0$, would close the item, and the margin it has to survive is the $29.7\%$ of K7.*

**THE SAME CORRECTION APPLIES WHEREVER $u_{\mathrm{lo}}$ APPEARS.** *The two preceding sections use $u_{\mathrm{lo}}=(\theta-s)/\sqrt3$ as the criticality end of the $F$ interval, and that end is also $\tau$-dependent, so their tabulated widths are the widths on the saturated slice.* **The "$F$ is increasing on the whole admissible interval" section is unaffected**, since its two discriminants are statements about $F$ in $u$ at fixed $s$ and never use $\tau$'s value.

**WHAT DOES NOT REACH FURTHER.** *[L220](../findings/second-order.md) and [L221](../findings/second-order.md) are untouched, since L221's own chain bounds the pinning term by $\tfrac{\sqrt3}2u_iN_i$ and never sets $\tau$ to its bound. [I110](../plan.md)'s exclusion of the corner is untouched, because at $s_*$ the Gram relation $u_{\mathrm{lo}}^2=\tfrac59t$ and $f=1$ coincide by the identity K8 confirms, so the corner really is on the saturated slice.* **The damage is confined to the claim that the corner's rigidity extends off the corner.**

## Method

Analysis throughout, with three screens on the closed forms already in the file, each seconds of arithmetic at 30 to 50 digits and each reported as a screen: the $f$-carrying identities of Finding 1, the surviving-region table, and the $6.32^\circ$ bound. No sweep, census or unbounded search was opened. The Lean check ran once, backgrounded.
