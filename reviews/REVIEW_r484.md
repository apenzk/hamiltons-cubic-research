# REVIEW r484, Lemma L20 (the tube theorem)

**Reviewer:** r484, adversarial, cold brief, twin r485 unread. **Target:** `#### Lemma L20` in [route-a.md](../findings/route-a.md), canon entry [results.md](../results.md).

## Verdict: PLAUSIBLE

**The mathematics is right; the label is not.** Every step of the displayed argument re-derives independently, the radius is exact to all fifteen quoted digits, and no circular input enters. What fails is the word **unconditional** and the phrase **for every $n\ge12$**:

| | |
| --- | --- |
| The cubic-expansion argument | **CONFIRMED**, re-derived from $Q$, $\circ$ and $F_u$ without consulting the block's algebra |
| Radius $\varphi_c=0.574826297515555$ | **CONFIRMED**, and $0.5748$ is a truncation in the safe direction |
| Free of circular inputs | **CONFIRMED**, no a priori cap, no [Observation L22](../findings/route-a.md), no [Observation L102](../findings/route-a.md) |
| "Unconditional" | **NOT EARNED**, the one substantive input is [Lemma L21](../findings/route-a.md), whose substance is two in-range tabulated spectra, and which [INDEX-results.md](../findings/INDEX-results.md) row 21 records as **"Gate 2: no verdict on the record"** |
| "For every $n\ge12$" | **NOT PROVED BY THE BLOCK** at odd $n$, the proof's witness does not exist there |

---

## Findings

### F1, What the proof actually consumes, so a fifth wrong description does not follow

Read line by line, the block uses exactly these, and nothing else:

1. **Compactness** of the unit sphere of $\mathrm{Weyl}_n$, so $m:=\sqrt{2/3}\max P$ is attained.
2. **$O(n)$-invariance of $P$**, to rotate the nearest orbit point to $u$.
3. **$u=W_{\mathbb{CP}^2}$ (padded) is critical with $P(u)=\theta^*=\sqrt{3/2}$**, consumed only through $\langle Q(u),V\rangle=0$. Record's support: [problem.md](../findings/problem.md) line 223 (Ricci-flat in dim 4 $\Rightarrow$ padding lands in $\mathrm{Weyl}_n$ untouched; twelve digits at $n=10,12,14$, criticality residual $4\times10^{-16}$).
4. **First-variation orthogonality** at a nearest point of a submanifold of the sphere, giving $V\perp T_u\mathcal O$. Standard, and correct: $\langle W^*,X\rangle=0$ on $T_u\mathcal O$ with $u\perp T_u\mathcal O$ forces $\sin\varphi\langle V,X\rangle=0$.
5. **$\lambda_{\max}\big(F_u|_{u^\perp\cap T_u\mathcal O^\perp}\big)\le\tfrac13\theta^*$**, *the one substantive input.* The block cites **Nienhaus Theorem 4.14(c)**; [Lemma L21](../findings/route-a.md) is the record's replacement for it.
6. **$\gamma_V\le m$**, definitional.
7. **$\psi\le1$ on $[0,0.5748]$**, elementary calculus.
8. **A unit Weyl operator with $P>\theta^*$ at $n\ge12$**, see [F6](#f6-the-blocks-proof-is-false-at-odd-n-while-its-heading-claims-all-nge12).

**It does NOT consume:** [Observation L22](../findings/route-a.md), [Observation L102](../findings/route-a.md), any a priori cap $P\le\theta^*$, any multiplicity-free hypothesis, and (pace the canon's third description), no "orbit decomposition". The orbit decomposition is *internal to L21*, where it identifies the $\tfrac12\theta^*$-eigenspace; it is not what bounds $\alpha$. **The canon's current L20 entry (L21 + the self-bootstrap) is the correct description.**

### F2, The expansion, re-derived from scratch

With $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ as fixed in [conventions.md](../findings/conventions.md), expanding $P(u+tV)=\langle u+tV,\,Q(u)+2t\,u\circ V+t^2Q(V)\rangle$ gives the $t^2$ coefficient $\langle u,Q(V)\rangle+2\langle V,u\circ V\rangle=3\langle F_uV,V\rangle$, using total symmetry of $\langle X,Y\circ Z\rangle$ and $F_u=u\circ(\cdot)$. So

$$\sqrt{\tfrac23}P(\cos\varphi\,u+\sin\varphi\,V)=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V$$

with $\alpha,\gamma_V$ exactly as the block defines them, and the linear term vanishing because $3T(u,u,V)=3\langle Q(u),V\rangle=3\theta^*\langle u,V\rangle=0$. **Reproduces the block display term for term, including the $\sqrt{2/3}$.** The identification $F_u=\theta^*L_e$ used by [Lemma L134](../findings/route-a.md) is consistent with this.

Both substitutions are legal: $3\cos\varphi\sin^2\varphi\ge0$ and $\sin^3\varphi\ge0$ on $[0,\pi/2]$, and $1-\sin^3\varphi>0$ there, so $m\le\psi(\varphi)$ follows with no sign hazard and with no assumption on the sign of $m$.

### F3, $\gamma_V\le m$ is not circular

$m$ is the attained maximum of $\sqrt{2/3}P$ over the unit sphere of $\mathrm{Weyl}_n$; $V$ is a unit element of $\mathrm{Weyl}_n$ (it is $(W^*-\cos\varphi\,u)/\sin\varphi$ with $W^*,u\in\mathrm{Weyl}_n$). So $\gamma_V\le m$ is the definition of a maximum. **No instance of the conjecture, no a priori cap, no value of $\max P$ is assumed**, the bound derived, $m\le1$, is then contradicted by a *lower* bound on $\max P$ from an exhibited operator. The logic is clean. **This is the step that makes L20 the record's one tube theorem that does not assume its own conclusion, and it survives the attack.**

### F4, The radius: recomputed, exact, and safely truncated

$\varphi_c$ solves $\sin^3\varphi=1-\cos\varphi$. Recomputed at 30 digits:

$$\varphi_c=0.574826297515555412339136838\ldots$$

**Matches all fifteen digits the record quotes.** And $\psi(0.5748)=0.99999371559<1$ while $\psi(0.5749)=1.0000176>1$, so the working value $0.5748$ is a truncation *downward*, the safe direction. Uniqueness of the crossing on $(0,\pi/2)$: with $g=1-\cos\varphi-\sin^3\varphi$, $g'=\sin\varphi\,(1-\tfrac32\sin2\varphi)$, which is positive on $(0,0.36485)$ and negative on $(0.36485,1.20595)$, so $g>0$ strictly on $(0,\varphi_c)$ and $\sup_{[0,0.5748]}\psi=\psi(0)=1$, attained only at $\varphi=0$. **$m\le1$ follows.**

**Is it sharp?** Sharp *for this argument* ($\varphi_c$ is exactly where $\psi$ recrosses $1$) and far from sharp as a statement, which the record says and its own sweep ($\max f=0.9147$ at $\varphi=0.5748$ against $\psi=0.99999$) supports.

### F5, What the exact value $0.5748$ depends on, and how brittle it is

Replacing $\alpha\le\tfrac13$ by $\alpha\le a$ makes the radius the root of $\cos^3\varphi+3a\cos\varphi\sin^2\varphi=1-\sin^3\varphi$. **Screened** (seconds of compute, on a one-line function I constructed; reported as a screen):

| $a$ | $1/3$ | $0.36$ | $0.40$ | $0.45$ | $0.49$ | $\to 1/2$ |
| --- | --- | --- | --- | --- | --- | --- |
| $\varphi_c(a)$ | $0.5748$ | $0.4761$ | $0.3308$ | $0.1582$ | $0.0303$ | $\to 0$ |

To leading order $\psi_a(\varphi)\approx1+(3a-\tfrac32)\varphi^2+\varphi^3$, so $\varphi_c(a)\approx\tfrac32-3a$. Two consequences worth recording:

- **The number $0.5748$ needs the exact $\tfrac13$**, and degrades linearly in any slack. Every consumer that quotes the number ([Conjecture D](../results.md) at line 80, "more than double the largest published $\gamma_n$" at [problem.md](../findings/problem.md) line 423) is quoting a value with no margin in $a$.
- **The conclusion survives for any $a<\tfrac12$** with a smaller radius. $\tfrac12\theta^*$ is the orbit's own eigenvalue, so the qualitative theorem (a tube of *some* positive radius), needs only that no transverse direction reaches the orbit's eigenvalue. That is a weaker and more robust demand than the record makes of L21, and the record nowhere states it.

### F6, The block's proof is false at odd $n$, while its heading claims all $n\ge12$

The closing line reads: *"the balanced sphere product is a unit Weyl operator with $P=\theta_0(n)$, which exceeds $\sqrt{3/2}$ for $n\ge12$."* **At odd $n$ there is no balanced sphere product**, and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ is not attained there. At $n=13$, $\theta_0(13)=1.2498521$ against the attained $\Theta_{13}=1.2483756$ ([conventions.md](../findings/conventions.md)'s odd-$n$ $\Theta_n$, screened). So the exhibited witness does not exist and the quoted value is not attained.

**The conclusion survives**, $\Theta_{13}=1.2483756>\theta^*=1.2247449$ and $\Theta_{15}=1.2709778$, both reproducing the record's own figures, so the repair is one clause. **But the repair is not in the block.** [route-a.md](../findings/route-a.md) Gate-2 correction 4 states it thirty lines above and says *"Applied throughout"*; it was not applied to the proof. The same defect stands in the second copy at [problem.md](../findings/problem.md) line 419 and in the report at [90-appendix.tex](../report/sections/90-appendix.tex) line 308, where the statement at line 295 says **"with no parity restriction"** and the proof four lines later uses the balanced product. **That is an outright internal contradiction inside the deliverable.**

### F7, "Unconditional" is not earned, and the record misidentifies its own gap

The brief's account is **verified**: [route-a.md](../findings/route-a.md) calls the transverse eigenvalue bound L20's *"one external input"* at line 120 and again at line 159, and line 159 says in terms that the four $F_\lambda$ spectra are *"tabulated at $n=10,12,14$ and asserted stable beyond"*. Three refinements the record does not make:

- **The block's own citation is to a conditional statement.** It cites *Nienhaus Theorem 4.14(c), valid for $n\ge9$*, and the record itself ([Lemma L21](../findings/route-a.md), line 120) says that argument is *"valid only where those components are multiplicity-free, which is unverified at large $n$."* So the block, read alone, rests on a hypothesis its own file calls unverified.
- **Only two of the three tabulated dimensions are usable.** L21's stable-range argument is correct and genuine: $\mathrm{Weyl}_n\subset S^2(\Lambda^2\mathbb R^n)$ puts at most four $\mathbb R^{n-4}$ tensor factors in play, so the $SO(n-4)$ branching is stable once $n-4\ge8$, which is $n\ge12$, **exactly L20's range**. The $n=10$ column sits *outside* that range and is evidence only. So the measurement supporting L20 is at $n=12$ and $n=14$: **two points.**
- **The record names the wrong remaining obligation.** It writes *"The remaining formal obligation is a proof that the stable range begins at $n-4\ge8$ rather than a check at two dimensions."* That obligation is (i) the standard stable-range statement for $k\le4$ factors, not something to prove, and (ii) binding only at $n=10$, which L20 never uses. **The obligation that actually remains is different:** stability of the *labels and multiplicities* is what the stable range delivers; the $n$-independence of the four *matrices* $F_\lambda$ needs an equivariant identification of the $M_\lambda$ across $n$ that intertwines $F_u$. The record supplies no such identification, it supplies two in-range data points.

**Status inversion.** [INDEX-results.md](../findings/INDEX-results.md) row 21 records L21 as **"Gate 2: no verdict on the record"**; row 20 carries no status note at all and the canon calls L20 unconditional. *A Lemma advertised as the programme's one unconditional tube theorem rests on a Lemma that has never been reviewed.*

### F8, The load-bearing table hides its majority

L21's claim is that *the four blocks exhaust the nonzero eigenvalues*. The four named rows check out internally, and I verified each:

- multiplicities sum to $\dim M_\lambda$ in every row: $20,20,6,10$ &#10003;
- $\dim V_\lambda$ are $1,\;n-4,\;\binom{n-4}2,\;\dim S^2_0(\mathbb R^{n-4})$ at $n=10/12/14$ &#10003;
- the $\tfrac12$-eigenvalue count is $2\cdot1+4\cdot(n-4)=4n-14=\dim\mathcal O$ &#10003; so the $\tfrac12$-eigenspace/orbit coincidence is arithmetically consistent, and at $n=12$ the complement dimension $1638-1-34=1603$ matches the Gate-2 sweep's figure.

**But the fifth row is "two higher types | $-$ | $-$ | $0$ throughout"**, with no dimensions given. At $n=12$ the four named blocks account for $20+160+168+350=698$ of $\dim\mathrm{Weyl}_{12}=1638$. **The unnamed row carries the other $940$ dimensions (57% of the space) and the assertion that $F_u$ vanishes identically on all of it is the very thing the bound needs.** It is plausible (for the top degree, both bivector slots lie in $\Lambda^2\mathbb R^{n-4}$, where $uh=hu=0$ and $[\mathfrak{so}(4),\mathfrak{so}(n-4)]=0$ kills $u\#h$), but the table names neither the types nor their dimensions, so **no reader can check the exhaustion claim from the record.**

### F9, The block has no statement

The block is headed *"canonical statement and proof"*. It contains the move note, one notation sentence, and `*Proof.*`. **There is no statement sentence, and the radius $0.5748$ appears only inside the proof's supposition**, a reader of [route-a.md](../findings/route-a.md) recovers the theorem by reverse-engineering the argument, or goes to [results.md](../results.md) for it. This is the same defect flagged today at [Lemma L17](../findings/route-a.md) two blocks above ("THIS BLOCK SAID 'CANONICAL STATEMENT AND PROOF' AND CARRIED NEITHER"), in milder form: here the *proof* is present and complete, and the *statement* is the missing half.

Related: **the metric is never named.** $\varphi$ is introduced as $d(W^*,SO(n)\cdot W_{\mathbb{CP}^2})$ and then used as $W^*=\cos\varphi\,u+\sin\varphi\,V$, which is coherent only if $d$ is **angular**. The canon says "angular distance"; the block does not. Chordal distance at $\varphi_c$ is $2\sin(\varphi_c/2)=0.5669$, so a reader taking $0.5748$ as Euclidean would claim a **larger** tube than is proved.

### F10, The fourth wrong description is live in the canon right now

The brief says the canon has described this proof wrongly three times. **It is describing it wrongly a fourth time, in the adjacent entry.** [results.md](../results.md) line 676, inside the **Observation L22** block:

> "With Lemma L21 it is what Lemma L20's bootstrap consumes."

That asserts L22 is consumed by L20. [route-a.md](../findings/route-a.md) line 417 says flatly *"**Lemma L20 uses neither**"*, and [INDEX-results.md](../findings/INDEX-results.md) row 22 says *"the canon named it as an input to L20, which does not use it"*. **The L20 entry was repaired; the L22 entry retained the retracted claim.** L22 is a different argument about Nienhaus's Theorem 4.17 (it shares only the symbol $\alpha$ with L20) and it is conditional on Conjecture A by its own scope note, so this sentence would re-import the circularity L20 was praised for avoiding.

Two smaller stale labels in the same neighbourhood: [results.md](../results.md) line 48 writes "Lemma L22" twice after the 2026-09-04 relabel to Observation, and [INDEX-results.md](../findings/INDEX-results.md) row 102 says "load-bearing for Lemma L22".

### F11, A wrong pointer

[plan.md](../plan.md) line 133 (item I10, the proposed $\mathbb{HP}^2$ tube) links **[Lemma L20](findings/target.md)**. L20 lives in [route-a.md](../findings/route-a.md); [target.md](../findings/target.md) contains no L20. The item's use is otherwise inside hypotheses, it is an open plan item and explicitly flags its transverse-eigenvalue step **UNSCREENED**, which is the right flag, since F5 shows that step is exactly what sets the radius.

### F12, Two inconsistent locations for $\psi$'s dip, neither correct

- [route-a.md](../findings/route-a.md) line 34: *"it dips near $\varphi\approx0.33$"*
- [route-a.md](../findings/route-a.md) line 77: *"$\psi$ falls to $0.9787$ near $\varphi=0.3927$"*
- Screened truth: $\min\psi=0.9785932$ at $\varphi=0.3747344$. The quoted $0.9787$ is $\psi(\pi/8)$, a sweep gridpoint, not the minimum.

Two mutually inconsistent values in one file, propagated into [90-appendix.tex](../report/sections/90-appendix.tex) line 308. **Non-load-bearing** (the proof needs only $\psi\le1$) but it is a third recurrence of the record's "value quoted from a grid" pattern.

### F13, Would this be true vacuously? Partly yes, and the record oversells the localization

- **The tube's measure is nil.** At $n=12$ the sphere has dimension $1637$ and the orbit $34$; a tube of angular radius $0.5748$ covers at most $\sim\sin(0.5748)^{1603}\approx10^{-424}$ of it. **As a localization result it removes essentially nothing.** [problem.md](../findings/problem.md) line 423's *"the entire tube around the competitor's orbit is excluded"* is true and reads larger than it is.
- **The tube is empty as far as anyone has looked**, three hunts, nothing inside, tube-constrained ascent running back to $\varphi=0$.
- **It is not vacuous, though**, because it eliminates a *named* rival critical point plus a neighbourhood, and $W_{\mathbb{CP}^2}$ is the operator that actually beats the sphere product for $n\le11$.
- **But the incremental content over one line of arithmetic is exactly the neighbourhood.** Excluding the orbit *itself* is the comparison $\sqrt{3/2}<\theta_0(n)$, already [Lemma L44](../results.md)'s territory. Everything L20 adds is the radius $0.5748$, and F5 shows that number has no robustness margin in its one input.

### F14, Citations: all inside hypotheses, and none of them consumes the conclusion

| site | use | inside hypotheses? |
| --- | --- | --- |
| [results.md](../results.md) line 232, line 658 | canon statement and entry | **Yes**, and the entry names L21 and the self-bootstrap correctly |
| [results.md](../results.md) line 80, Conjecture D | *"for some $\gamma\le0.5748$"*, would pair with L20 | **Yes**, and explicitly conditional; note it says "even $n\ge12$" where L20 claims all $n\ge12$ |
| [results.md](../results.md) line 676 | asserts L20 consumes L22 | **No**, see [F10](#f10-the-fourth-wrong-description-is-live-in-the-canon-right-now) |
| [Lemma L134](../findings/route-a.md) | reuses the $\tfrac13\theta^*$ gap as a Hessian bound, for $H\perp T_u\mathcal O$, $\lVert H\rVert=1$ | **Yes**, exactly the set where the bound holds, and the orthogonality hypothesis was added at Gate 2 for this reason |
| [plan.md](../plan.md) line 51 | domain note, "at the padded $\mathbb{CP}^2$ competitor only" | **Yes** |
| [plan.md](../plan.md) line 96 | listed under I7 as offering nothing that is a route | **Yes**, honestly framed |
| [plan.md](../plan.md) line 133 | $\mathbb{HP}^2$ transplant | **Yes**, flagged UNSCREENED; wrong file link ([F11](#f11-a-wrong-pointer)) |
| [problem.md](../findings/problem.md) lines 417–423 | second full copy of statement and proof | carries the odd-$n$ defect ([F6](#f6-the-blocks-proof-is-false-at-odd-n-while-its-heading-claims-all-nge12)) and the oversell ([F13](#f13-would-this-be-true-vacuously-partly-yes-and-the-record-oversells-the-localization)) |
| [90-appendix.tex](../report/sections/90-appendix.tex) lines 295–317 | third copy | statement and proof contradict each other on parity ([F6](#f6-the-blocks-proof-is-false-at-odd-n-while-its-heading-claims-all-nge12)) |

**The finding that matters here: nothing in the record consumes L20's *conclusion* inside a proof.** [Lemma L134](../findings/route-a.md), its only live consumer, consumes **L21's spectral input**, not the tube. The tube's would-be consumer is [Conjecture D](../results.md), which is unproved and conditional on Conjecture A. So L20 is at present a correct theorem with no downstream proof depending on it.

---

## The hypotheses it actually needs

> For every $n\ge12$, **assuming** $\lambda_{\max}\big(F_u|_{u^\perp\cap T_u\mathcal O^\perp}\big)\le\tfrac13\theta^*$, [Lemma L21](../findings/route-a.md), whose $n$-independence of the four $F_\lambda$ matrices is measured at $n=12,14$ and carries no Gate 2 verdict, no maximizer of $P$ on the unit sphere of $\mathrm{Weyl}_n$ lies within **angular** distance $0.5748$ of $SO(n)\cdot W_{\mathbb{CP}^2}$. At odd $n$ the witness must be $\Theta_n$, not $\theta_0(n)$.

Everything else in the proof, compactness, invariance, the criticality of the padded competitor, the first-variation orthogonality, the self-bootstrap, and $\psi\le1$, is proved, standard, or definitional, and I confirm each.

## Is "unconditional" earned?

**In the sense the record means it, yes; in the sense a reader takes it, no.** It is free of circular inputs, that claim I confirm outright, and it is the property that distinguishes L20 from every other tube statement here. It is not free of *measured* inputs, and one of them is the step that sets the radius. The honest headline is **"free of circular inputs, resting on one measured spectral bound"**, which is what [route-a.md](../findings/route-a.md) says twice and what the word "unconditional" in [results.md](../results.md) line 232 and [problem.md](../findings/problem.md) line 417 does not.

## Repairs, in order of cost

1. **[results.md](../results.md) line 676**, delete *"With Lemma L21 it is what Lemma L20's bootstrap consumes."* It is the fourth wrong description and it re-imports circularity. *(one sentence)*
2. **The odd-$n$ clause**, in [route-a.md](../findings/route-a.md) line 77, [problem.md](../findings/problem.md) line 419 and [90-appendix.tex](../report/sections/90-appendix.tex) line 308, replace the balanced-product witness with $\max_p P(S^p\times S^{n-p})$, per the Gate-2 correction that says it was applied and was not. *(one clause, three files)*
3. **Give the L20 block a statement**, with the radius and the word *angular* in it.
4. **[plan.md](../plan.md) line 133**, retarget the link to [route-a.md](../findings/route-a.md).
5. **The dip figures**, one value, $\min\psi=0.9785932$ at $\varphi=0.3747$, in all three copies; or drop them, since only $\psi\le1$ is used.
6. **Name the two higher types and their dimensions** in L21's table, so the exhaustion claim over the other 57% of $\mathrm{Weyl}_{12}$ is checkable.
7. **Send L21 to Gate 2.** It is the whole of L20's conditionality and has no verdict on the record.
8. **Record F5's robustness margin**, the tube survives for any transverse bound $a<\tfrac12$, with radius $\approx\tfrac32-3a$. It is the cheapest hedge available against item 7 going badly.

*Computation in this report is confined to screens of claims recorded here: root-finding and evaluation of $\psi$, $\varphi_c(a)$, $\theta_0$ and $\Theta_n$, seconds of compute on one-line functions. No search, sweep or census was run. No positive claim rests on a screen.*
