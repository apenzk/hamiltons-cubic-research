# REVIEW r470, Lemma L15 (what stops the diagonal proof from lifting)

**Reviewer:** r470 · **Claim:** [Lemma L15](../findings/problem.md) · **Verdict:** `REFUTED as stated; identity CONFIRMED` · **Started:** 2026-09-04

Analysis-only footing (`.claude/rules/analysis-only.md`). No sweeps; screening only, labelled as such.

## Findings

(appended as reached)

---

### Finding 1, the displayed identity is CORRECT, constant and all, and it is not vacuous

$$\operatorname{scal}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2$$

checks out analytically, in the record's own conventions, by three independent routes.

- **Depolarising [Lemma L131](../findings/isotropy-cap.md).** $\mathrm{Ric}(R)\wedge\mathrm{id}=R+R\#I-3\,\mathrm{Alt}(R)$ paired with $R$: $\langle R\#I,R\rangle=\langle R\#R,I\rangle=\operatorname{tr}(R^\#)$ by full symmetry of Huisken's $\mathrm{tri}$, $\langle\mathrm{Alt}(R),R\rangle=\lVert\mathrm{Alt}(R)\rVert^2$ by idempotent self-adjointness ([conventions.md](../findings/conventions.md)), and $\langle\mathrm{Ric}(R)\wedge\mathrm{id},R\rangle=\tfrac12\lVert\mathrm{Ric}(R)\rVert^2$ since $\mathrm{Ric}^*=2(\cdot\wedge\mathrm{id})$ is $\mathrm{Ric}$'s adjoint. Doubling and using $\operatorname{scal}=2\operatorname{tr}$ on $\Lambda^2$ gives the display exactly.
- **Anchor $R=\mathrm{Id}$.** $\mathrm{Id}\#\mathrm{Id}=(n-2)\mathrm{Id}$, so $\operatorname{scal}((n-1)\mathrm{Id})=2(n-1)\binom n2=n(n-1)^2=\lVert\mathrm{Ric}\rVert^2$, $\mathrm{Alt}=0$. Holds at every $n$.
- **Anchor $R\in\Lambda^4$.** $\mathrm{Ric}$ annihilates $\Lambda^4$ and $\#I=+2$ there ([Lemma L79](../findings/isotropy-cap.md) via $\mathcal A=-2(\cdot\#I)$), so LHS $=2\lVert R\rVert^2+2\cdot2\lVert R\rVert^2=6\lVert R\rVert^2$ against RHS $=6\lVert\mathrm{Alt}R\rVert^2$. **This is where the $6$ comes from, and it is $2(1+c_4)$ with $c_4=2$, dimension-free**, so "exactly $6$ in every dimension" is right.

No cross-term because $\Lambda^4\perp\operatorname{im}\mathrm{Ric}^*$. **The $\tfrac13$ in $\mathrm{Alt}$ and the $\Lambda^2$-level $\tfrac12$ are both used and both used correctly.** The downstream $+24\delta^2$ is $6\lVert\mathrm{Alt}(\lvert W\rvert)\rVert^2=6\cdot4\delta^2$ via $\mathrm{Alt}(\lvert W\rvert)=2\,\mathrm{Alt}(W_-)$, which is consistent with [isotropy-cap.md](../findings/isotropy-cap.md)'s own warning that a constant stated at $\lvert W\rvert$ is not comparable with one stated at $W_-$. **Nothing in the sign convention on $W_-$ bites here**: $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)=\tfrac12\mathrm{Alt}(\lvert W\rvert)$ under $W_-=\tfrac12(\lvert W\rvert-W)$, and $\delta^2$ is a square, so it is sign-blind. "Every sphere product, in any frame, has defect zero" is right and frame-invariance is real: a sphere product is coordinate-diagonal in its product frame, a coordinate-diagonal operator has no all-distinct-index components, so $\mathrm{Alt}=0$, and $\delta^2$ is $O(n)$-invariant.

**So the identity half of L15 survives. The completeness half does not.**

---

### Finding 2, REFUTED: there is a second exception, it is not Bianchi, and the record names it two lines from the first

L15's completeness claim is *"Every step of that transfer survives off the diagonal locus … with one exception."* The record carries a second one, in three places, none of them joined to L15.

| where | what it says |
| --- | --- |
| [ATTEMPTS.md:862](../ATTEMPTS.md) | *"Lemma 3.3.4's proof rests on the refuted operator inequality $X_{\mathrm{inv}}\succeq0$ **and** on the Bianchi-dependent identity (1.5)."*, **two** obstructions, in one sentence |
| [ATTEMPTS.md:868](../ATTEMPTS.md) | *"His diagonal case is exactly $J_4=0$, $J_5\ge0$."*, the diagonal locus buys **two** things |
| [routes.md:29](../routes.md), [LEDGER.md:25](../findings/LEDGER.md) | route R17, the lifted chain, *"owes two steps: the grant $J_5\ge0$ … and the global closure"*; *"Two grants remain in the lifted chain."* |

**The second exception is free on the diagonal locus for a reason that has nothing to do with Bianchi, and I can display it.** With $X_{\mathrm{inv}}=\lvert W\rvert^\#+(W-\theta)\lvert W\rvert$ ([ATTEMPTS.md](../ATTEMPTS.md) Result 5(a)) and $M$ the vertex matrix, on the diagonal locus every one of $W,\lvert W\rvert,W^\#,\lvert W\rvert^\#$ is diagonal in the coordinate pair basis, the transported $c^2$ is supported on triangles ([diagonal-half.md](../findings/diagonal-half.md)), so $(W^\#)_{(ab)}=(M^2)_{ab}$ and $(\lvert W\rvert^\#)_{(ab)}=(\lvert M\rvert^2)_{ab}$ with $\lvert M\rvert$ **entrywise**. Criticality is $w_{ab}^2+(M^2)_{ab}=\theta w_{ab}$, so the $(ab)$ entry of $X_{\mathrm{inv}}$ is

$$(\lvert M\rvert^2)_{ab}+(w_{ab}-\theta)\lvert w_{ab}\rvert=\begin{cases}(\lvert M\rvert^2)_{ab}-(M^2)_{ab}\ \ge0,& w_{ab}\ge0\\[2pt](\lvert M\rvert^2)_{ab}+(M^2)_{ab}\ \ge0,& w_{ab}<0\end{cases}$$

both by the entrywise triangle inequality. **So $X_{\mathrm{inv}}\succeq0$ on the diagonal locus, at every critical point, in two lines**, and $J_5=\langle\mathrm{Ric}(X_{\mathrm{inv}}),\mathrm{Ric}(\lvert W\rvert)\rangle\ge0$ follows since both Ricci matrices are then entrywise nonnegative. **Off the diagonal locus $X_{\mathrm{inv}}\succeq0$ is REFUTED** at a genuine $n=6$ critical point, $\lambda_{\min}\approx-2.4\times10^{-2}$ at $\theta=0.6611$ ([ATTEMPTS.md:618, :633](../ATTEMPTS.md)), and so are $\mathrm{Ric}(X_{\mathrm{inv}})\succeq0$ and both congruence intermediates at an $n=5$ critical point ([ATTEMPTS.md:932](../ATTEMPTS.md)). What is left is the scalar contraction $J_5\ge0$, which is **an open grant**, proven only where $[H,W]=0$ and on the multi-block family.

**This is a different mechanism from L15's.** The Bianchi exception is that $\mathrm{Alt}$ of a spectral part is nonzero; this one is that the entrywise triangle inequality has no operator analogue once $\lvert\cdot\rvert$ stops being entrywise. It is exactly the confusion [conventions.md](../findings/conventions.md) fences, *"diagonal in coordinate 2-planes, not diagonal as an operator on $\Lambda^2$ … conflating the two is what makes the diagonal case look liftable"*, and L15's own opening sentence, *"transfers the eigenvalue equation to the entrywise absolute value $\lvert W\rvert$"*, is written in the coordinate reading while its exception is stated in the spectral one.

### Finding 3, and the record already knows one exception is not enough: the dichotomy is open with the defect switched off

If the Bianchi defect were *exactly* what stops the lift, setting it to zero would make the proof run. It does not.

- **Zero defect does not imply coordinate-diagonalisability**, even among critical points, even at $n=12$, [ATTEMPTS.md:729](../ATTEMPTS.md), Result 4, *"The proposed dichotomy is **false**"*, with explicit non-diagonal $\delta=0$ critical points at $\theta=0.699737,\,0.828079,\,0.679366$ ($n=6$) and $0.757274,\,0.749771$ ($n=8$), all with trivial stabiliser.
- At every one of those points L15's exception is **inactive**: $\mathrm{Alt}(W_-)=0$, hence $\mathrm{Alt}(\lvert W\rvert)=0$, hence $\lvert W\rvert$ satisfies the first Bianchi identity, $\ker\mathrm{Alt}$ *is* the Bianchi subspace ([conventions.md](../findings/conventions.md)).
- And [LEDGER.md:26](../findings/LEDGER.md) states the consequence outright: *"**The threshold form of the Jäger §3.2 dichotomy is unproven.** … what remains is: is $\sup\{P(W):Q(W)=\lambda W,\ \mathrm{Alt}(W_-)=0,\ W\text{ non-diagonal}\}$ strictly below $\theta_0(n)$?"*, supported by sweeps, proven nowhere.

**So there is a whole population off the diagonal locus at which the one identified exception vanishes and the diagonal proof still does not lift.** That is a refutation of "identified exactly", from the record's own ledger, two lines below the entry that records the $J_5$ grant.

---

### Finding 4, the primary text settles it: Jäger's opening step has exactly two inputs, and both are diagonal-locus facts

[diss_jaeger_florian.txt](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) L2012–2040, Lemma 3.2.2 and its proof, read at the hit and nowhere else:

> **Lemma 3.2.2.** … $\theta n\bar\lambda=r^2-4\lVert W_-\rVert^2-C_\#(W)$. In particular, $C_\#(W)\ge0$ …
> *Proof.* As seen in equation (1.6), it is known that $\operatorname{scal}(R^2+R^\#)=\sum_{i,j}(\mathrm{Ric}(R)_{ij})^2$ **for all operators $R\in S^2_B(\mathfrak{so}(n))$**. … Moreover, $C_\#(W)\ge0$ **because $X(W)\ge0$**.

and the line closing Lemma 3.2.1's proof, L2003:

> "which concludes the proof since $X(W)\ge0$ **is obvious by the definitions of $W_+$ and $W_-$**."

**Two inputs, and each one is a diagonal-locus fact.**

| Jäger's input | why it is free on the locus | off the locus |
| --- | --- | --- |
| eq. (1.6), stated on $S^2_B$ | a coordinate-diagonal operator has no all-distinct-index components, so $\mathrm{Alt}(\lvert W\rvert)=0$ | **priced**: $+6\lVert\mathrm{Alt}\rVert^2$, i.e. $+24\delta^2$, L15's exception, and L15 identifies it correctly |
| $X(W)\succeq0$, "obvious by the definitions of $W_\pm$" | $W_\pm$ are **entrywise masks** there, so every summand is entrywise signed | **REFUTED**, $\lambda_{\min}\approx-2.4\times10^{-2}$ at a real $n=6$ critical point ([ATTEMPTS.md:618](../ATTEMPTS.md)) |

The second is repaired at §3.2 ($\operatorname{scal}(X)\ge0$ survives because $\#$ preserves the PSD cone) and that repair is a *replacement of a failed step by a weaker one*, which is not the same as the step surviving. At §3.3 the identical pair recurs and **the repair is only conjectural**: the surviving contraction there is $J_5\ge0$, still owed. **"Every step of that transfer survives … with one exception" is false at the exact step L15 names**, by the thesis's own two-line proof.

### Finding 5, as written it is a note, and its one checkable sentence is [Lemma L131](../findings/isotropy-cap.md) depolarised

Strip the prose and L15 displays exactly one thing: the identity of Finding 1. Everything the title promises (*"what stops the diagonal proof from lifting, **identified exactly**"*), is carried by unquantified prose ("every step", "one exception", "using spectral rather than coordinate projections"), with no enumeration of the steps, no citation to the section they live in, and nothing a reader can check. The enumeration is not incidental: **it is the whole claim**, and Findings 2–4 show it is wrong.

And the identity itself is duplicated: [isotropy-cap.md](../findings/isotropy-cap.md) records *"This is [Lemma L15] polarised"*, so L131 (Gate 2 passed on arrival, two independent derivations) and L15 are one statement at two levels. Under [ATTEMPTS.md](../ATTEMPTS.md) Result 2 the identity also has two independent proofs, one fully symbolic. **The surviving content of L15 is a corollary of a lemma the record proves elsewhere.**

Two smaller inaccuracies in the same paragraph, both from over-stating:

- *"$\lvert W\rvert$ and the spectral parts $W_\pm$ do not satisfy the first Bianchi identity."* They fail it **exactly when $\delta\ne0$**, and $\{\delta=0\}$ is strictly larger than the diagonal locus ([ATTEMPTS.md:729](../ATTEMPTS.md)). The correct statement is "need not".
- [results.md:218](../results.md) narrows the canon copy to *"the negative spectral part"*; $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$, so both parts leave Bianchi together, and the two copies of the same lemma do not say the same thing.

**What is right and should be kept, unchanged:** the identity, the constant $6$, "no cross-term", the $+24\delta^2$ in the master inequality (via $\mathrm{Alt}(\lvert W\rvert)=2\,\mathrm{Alt}(W_-)$), the Fox factor of three ($4=\tfrac43+\tfrac83$ with $24\cdot\tfrac19=\tfrac83$, [ATTEMPTS.md:625](../ATTEMPTS.md)), the saturation there, the wrong sign, and zero defect at every sphere product in every frame. **What must go is "exactly", "every step", and "one exception".**

---

## Verdict, **REFUTED as stated; the identity half is CONFIRMED**

| component | verdict |
| --- | --- |
| $\operatorname{scal}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2$, constant $6$ at every $n$, no cross-term | **CONFIRMED**, three independent derivations, all $n\ge3$, non-vacuous |
| the Bianchi failure of $\lvert W\rvert,W_\pm$ is *an* obstruction, priced at $+24\delta^2$, sharp at $\mathcal S^4(\alpha)$ | **CONFIRMED** |
| it is **the** obstruction, "every step survives with one exception", "identified exactly" | **REFUTED** |
| L15 as a *lemma* | **REFUTED**, a note; its displayed content is [Lemma L131](../findings/isotropy-cap.md) depolarised |

**Hypotheses the surviving statement needs.** The identity: none beyond $R$ symmetric on $\Lambda^2\mathbb R^n$, no criticality, no Weyl condition, no dimension bound. The $+24\delta^2$ reading of the master inequality: $\mathrm{Ric}(W)=0$ and $\theta W=W^2+W^\#$, at any $n\ge4$.

**Label it deserves.** *Observation L15, the Bianchi defect of the spectral parts, and its exact price in Jäger's §3.2*, with the completeness sentence replaced by the two-line table of Finding 4 and an explicit pointer to the second obstruction ($X(W)\succeq0$ / the grant $J_5\ge0$) and to the zero-defect non-diagonal population of [ATTEMPTS.md:729](../ATTEMPTS.md).

**Impact.** Numerically nil, every downstream citation ([Conjecture L16](../findings/problem.md), [Lemma L18](../findings/problem.md), [Lemma L7](../findings/bounds.md)) draws on the identity or on the definition of $\delta^2$, both of which stand, and [routes.md](../routes.md) already books the second obstruction as an owed step of route R17. The damage is to the record's self-description: **[results.md](../results.md) tells a reader that one term stops the lift, while [LEDGER.md](../findings/LEDGER.md) lines 25–26 record two further things that stop it, and no file joins the three.**

*Reviewer r470, closed 2026-09-04. Analysis only; no computation was run, every number quoted is the record's own or derived by hand.*
