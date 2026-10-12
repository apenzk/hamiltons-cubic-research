# REVIEW r465, Observation L102

**Claim under audit:** [Observation L102](../findings/route-a.md#L391) in [route-a.md](../findings/route-a.md), $M_{W_1}\cdot\Pi_{\ker}Q(W_1)=0$, residual $\le8.5\times10^{-15}$ at $n=12,14,16$, control $0.33$; load-bearing for [Observation L22](../findings/route-a.md#L423).

**VERDICT: PLAUSIBLE, the identity is very probably true and the record has stated it twice, in two forms that contradict each other, one of which would destroy [L22](../findings/route-a.md#L423) if adopted.** No counterexample found and none expected; the defects are in the statement, its scope, its support and its provenance, not in the arithmetic. Analysis only throughout, nothing was run.

**Label it deserves:** *Observation, at $n\in\{12,14,16\}$, for randomly sampled $W_1$, its operator defined nowhere in the record, Gate 2 not held.* That is weaker than the block's own heading in two ways (sampled, not universal in $W_1$; no Gate 2) and no stronger in any.

## Findings

### 1. The record states the identity in two inequivalent forms, ten lines apart, and prefers the wrong one

| where | statement |
| --- | --- |
| [route-a.md:391](../findings/route-a.md#L391), [:395](../findings/route-a.md#L395), [:410](../findings/route-a.md#L410), [:439](../findings/route-a.md#L439), [:447](../findings/route-a.md#L447) | $M_{W_1}\cdot\Pi_{\ker}Q(W_1)=0$, **annihilation**: $q:=\Pi_{\ker}Q(W_1)$ lies in $\ker M_{W_1}$ |
| [route-a.md:381](../findings/route-a.md#L381) | *"The hard-case condition is now known to be a **bilinear** identity ($\langle\Pi_{\ker}Q(W_1),\mathrm{top}(W_1')\rangle=0$"*), **orthogonality to the top eigenspace** |
| [ATTEMPTS.md:1678](../ATTEMPTS.md#L1678) | *"the hard case is $b=\Pi_{\ker}Q(W_1)$ orthogonal to the **top eigenspace**, not annihilated by the operator"* |

The two are not the same statement: annihilation implies orthogonality to the top eigenspace (when $\lambda_{\max}\ne0$), and the converse fails. **The file asserts the strong form in its heading and the weak form, as a correction to it, in the paragraph immediately above.**

### 2. And the difference is load-bearing, the weak form does not give $V(t)$

The inner problem is $\max_{\lVert K\rVert=1}\langle q,K\rangle+t\langle K,M_{W_1}K\rangle$. The derivation of the closed form writes $K=c\hat q+w$, $w\perp\hat q$, and uses $M\hat q=0$ to kill both the $c^2$ and the cross term, leaving $A+tB\le ca+t\lambda(1-c^2)$ and hence $V(t)$.

**Under the weak form alone this collapses, in one line.** If $M\hat q=\mu\hat q$ with $\mu>0$ (which is compatible with $q\perp\mathrm{top}$ whenever $\mu<\lambda_{\max}$) then $K=\hat q$ gives $A+tB=a+t\mu>a=g(a,\lambda,t)$ for $t\le t^*$. The frontier would exceed the closed form, and $\alpha^*=32/141$ with it. So the record cannot keep both sentences: **[route-a.md:381](../findings/route-a.md#L381), read as written, refutes the derivation that [L22](../findings/route-a.md#L423) runs on.**

### 3. Which is right: the annihilation form, and the weakening came from a cycle whose own gate failed

- [review_r21_identity.py](../scripts/reviewers/r21/review_r21_identity.py) computes exactly $\lVert M q\rVert/\lVert q\rVert$ with $M[i,j]=T(W_1,\ker_i,\ker_j)$, the $\ker\to\ker$ operator that [ATTEMPTS.md:1678](../ATTEMPTS.md#L1678) itself names as the correct one. Residuals $2.2\times10^{-15}$ ($n=12$, 40 random $W_1$), $7.5\times10^{-15}$ ($n=14$), $8.5\times10^{-15}$ ($n=16$), against a control of $0.33$ ([review_r21_report.md](../agent_logs/review_r21_report.md), [review_r21.log:14](../agent_logs/review_r21.log#L14)). The heading's "$\le8.5\times10^{-15}$ at $n=12,14,16$" is a correct maximum over the three, **this figure checks out.**
- The same review measured the **unsymmetrised trilinear** form, $\Pi_{\ker}F(x,\Pi_{\ker}F(y,z))=0$ for $x,y,z\in V_{1/3}$, at $1.9\times10^{-15}$.
- Independent corroboration that no reviewer has drawn on: three global optimisers reproduce $V(t)$ (a bound *derived from* annihilation), to $2.7\times10^{-15}$ at every $t$, including $A=5/6,B=1/9$ and $A=25/36,B=0.280864$. Had $Mq\ne0$, $V(t)$ would be an under-estimate of a maximum the optimisers were free to exceed. They did not.
- The contrary sentence comes from [ATTEMPTS.md:1674–1690](../ATTEMPTS.md#L1674), whose **Gate 1 failed twice** (*"the reconstructed operator did not reproduce the known residual"*) and which records *"Nothing recorded as a finding"*. Its first false start, the $\ker\to V_{1/3}$ operator with residual $0.58$, is a build error by its own account; annihilation with the corrected $\ker\to\ker$ operator was then never re-measured, only replaced by the condition trust-region theory *requires*. **A conclusion from a gate-failed cycle was promoted into the findings file as "now known to be".**

**Repair:** restore the annihilation form as the claim, and demote [route-a.md:381](../findings/route-a.md#L381) to what it is, a characterisation of the weaker consequence, useful as a proof target, insufficient as a hypothesis.

### 4. The true statement is a subspace identity, and the record was told to record it and did not

With the containment $Q(V_{1/3})\subseteq\ker F_u\oplus\langle u\rangle$ and $u\circ x=\tfrac{\theta^*}{3}x$ for $x\in V_{1/3}$, the trilinear form of L102 collapses to $\Pi_0\big(V_{1/3}\circ(V_{1/3}\circ V_{1/3})\big)=0$, equivalently

$$\mathcal S:=\Pi_0(V_{1/3}\circ V_{1/3})\ \perp\ \mathcal R:=\Pi_0(V_{1/3}\circ V_0)\quad\text{inside } V_0 .$$

That is one statement about two subspaces, in place of a family of statements indexed by $W_1$, and it is what was actually measured (item 3's trilinear check, and the cross-pair version at [ATTEMPTS.md:1688](../ATTEMPTS.md#L1688)). Recommendation 4 of [review_r21_report.md](../agent_logs/review_r21_report.md) asked for exactly this to be added to the record; recommendations 1, 2, 3, 5, 6 and 7 were all adopted into [route-a.md](../findings/route-a.md) and **4 alone was dropped.**

### 5. It is not vacuous, and no fusion rule explains it

- $q\ne0$: $\lVert q\rVert=a$ is the $A$-coupling, with $\sup a=\sqrt{5/6}$.
- $M_{W_1}\ne0$: $\lambda_{\max}\to2/3$, $\lambda_{\min}=-2/3$ at $W_1^*$; $\sup T(W_1,K,K)=2/3$.
- The control is the right one (same functional, $W_1$ drawn from $\ker F_u$ instead of $V_{1/3}$) and returns $0.33$, so the natural scale of the quantity is $O(1)$ and the residual sits fourteen orders below it.
- **No Peirce fusion rule can give it.** $\Pi_0(V_{1/3}\circ V_0)=0$ would say $M_{W_1}\equiv0$, which $\sup T(W_1,K,K)=2/3$ refutes. The identity is specific to the pairing of $q(W_1)$ with $M_{W_1}$, i.e. to $\mathcal S\perp\mathcal R$.
- **Nor is it a Hsiang-type cubic identity.** Since $x\circ x=Q(x)=\tfrac13e+q$ and $x\circ e=\tfrac13x$, one has $x^{\circ3}=\tfrac19x+x\circ q$, so L102 says exactly $\Pi_0(x^{\circ3})=0$. But $x^{\circ3}\notin\langle x\rangle$: by [Lemma L101](../findings/route-a.md#L356) the $V_{1/2}$ component of $x\circ q$ is $\tfrac13\theta^*\langle A\!\cdot\!x,q\rangle$, which does not vanish. So the third power leaves $\langle x\rangle$ through $V_{1/2}$ and misses $V_0$, a genuine coincidence, not a normalisation.
- **One proof route the record has not tried**, and it is analysis rather than computation: $\mathcal S$ and $\mathcal R$ are both $\mathrm{Stab}(u)$-submodules of $V_0$, so isotypic disjointness would prove the identity outright, at every $n$ and with no sampling. The record's dead entry *"$\mathrm{Stab}^0$-invariance alone"* counts invariant cubics on $V_{1/3}$, a different and cruder use of the same group, and it does not close this.

### 6. Support is the thinnest of the vanishings, not the best

The brief asks whether L102 is the only one of L22's vanishings with numerical support. **It is the one with the weakest support.** The three coupling vanishings are *exhaustive* at $n=10$, the full $770\times770$ $F_{W_1}$ built on all 78 basis vectors of $V_{1/3}$, and a multilinear form vanishing on a basis vanishes identically, so those are machine-checked theorems at that $n$. L102 is 40 random draws at $n=12$ and fewer at $n=14,16$: **never exhaustive at any $n$, and never checked at $n=10$ at all.**

Related bookkeeping defects in the same block:

- **"Four vanishings" does not resolve.** The table at [route-a.md:343](../findings/route-a.md#L343) displays three; [route-a.md:410](../findings/route-a.md#L410) puts L102 *"alongside the four vanishings above"*, making five; the relabelling box at [route-a.md:425](../findings/route-a.md#L425) says *"this one's four vanishings"*, making L102 one of four.
- **That box also misdates them.** The three coupling vanishings are exhaustive at $n=10$ with spot checks at $n=12,14$; only L102 is a $n=12,14,16$ measurement. "Its four vanishings are measured at $n=12,14,16$" is true of none of them jointly.

### 7. The quantifier over $W_1$ is universal and the evidence is a sample, but this is the safe half

The block says *"For every $W_1\in V_{1/3}$"*. $V_{1/3}$ is a continuum (78-dimensional at $n=10$); the evidence is 40 random draws, and the block never says so. The saving grace is that $x\mapsto M_x\Pi_0Q(x)$ is a **homogeneous cubic polynomial map**, whose zero set, if not everything, is measure zero, so 40 independent draws landing at machine zero is overwhelming for identical vanishing in that $n$. **The cheap decisive upgrade exists**: the trilinear form on a basis of $V_{1/3}$ is a finite, exhaustive check that would turn the observation into a machine-checked identity at fixed $n$, exactly as the other three vanishings already are. *That is computation and I did not run it; recorded as the blocked item it is.*

### 8. The extension to all $n\ge12$ is assertion, and the only $n$-evidence points the unsafe way

- Direct verification exists at $n=12,14,16$ only; $n=20,24$ are out of reach of the build.
- **Zero-padding does not help and mildly hurts.** It embeds $n=12$ configurations into larger $m$, so it establishes $V_m(t)\ge V_{12}(t)$, the frontier is monotone **non-decreasing** in $n$. $V(t)$ is used as an *upper* bound on the coupling term, so the one $n$-behaviour the record has established is in the direction that can break the estimate at large $n$, not support it. [route-a.md:410](../findings/route-a.md#L410) says *"monotonicity in $n$ but only as a lower bound"*, which is accurate and easily read as reassurance; it is the opposite.
- **Odd $n$ was never tested, and here it does not matter.** $u$ is the zero-padded Fox point and every count in this block is a polynomial in $n$ with no parity term (orbit dimension $4n-14$ at $n=10,12,14,16$). The parity risk in [L22](../findings/route-a.md#L423) sits elsewhere, in the constant, where $\Theta_n$ splits by parity ([conventions.md](../findings/conventions.md)) and the block uses $\theta_0(n)$.

### 9. The operator in the load-bearing identity is defined nowhere in the record

$M_{W_1}$ appears in [route-a.md](../findings/route-a.md) five times and is never defined there; it is absent from [conventions.md](../findings/conventions.md), which also lacks $V_{1/3}$, $F_u$ and $\Pi_{\ker}$. The only definitions in the repository are a script docstring ([review_r21_identity.py](../scripts/reviewers/r21/review_r21_identity.py)) and an agent report ([review_r21_report.md](../agent_logs/review_r21_report.md)), neither cited from the block: $M_{W_1}$ is the matrix of $K\mapsto\Pi_{\ker}(W_1\circ K)$ on $\ker F_u$, i.e. $M_{W_1}[i,j]=T(W_1,\ker_i,\ker_j)$.

**And the symbol collides inside its own file.** [Observation L103](../findings/route-a.md#L37), the adjacent numbered result, uses $W_1$ for the balanced $S^6\times S^6$ operator at $n=12$ with $P(W_1)=1.236$, an object with no relation to $V_{1/3}$. Three meanings of $W_1$ are live in [route-a.md](../findings/route-a.md): the $V_{1/3}$ component of the Remark 4.18 decomposition, the bound variable of L102, and L103's witness. This is the failure mode [conventions.md](../findings/conventions.md) records for the letter $M$, repeated for $W_1$ and not yet written down.

### 10. Provenance: the heading was placed over a paragraph, and its Gate 2 line belongs to a different claim

`git log -L 391,392` shows the heading inserted by commit 6cf9b1d2, *"place headings for results 100-103"*, over prose that already existed, L102 was never posed as a result, it was numbered after the fact. The consequence is inside the block: [route-a.md:418](../findings/route-a.md#L418) reads *"Gate 2: Reviewer 19, requirement, subdivision and $\alpha$ identity confirmed … the two vanishing couplings confirmed exhaustively"*, which is a verdict on the surrounding argument and the **other** couplings. Reviewer 19 predates this identity; it is Reviewer 21's. [INDEX-results.md:117](../findings/INDEX-results.md#L117) correctly records *"Gate 2: no verdict on the record"*, **so the file and the index disagree on whether this block has been gated**, and the file's version is the wrong one.

### 11. What breaks if L102 is false

| level | consequence |
| --- | --- |
| $V(t)$ | lost, the inner maximisation stops being a hard-case trust-region problem and the closed form has no derivation; the surviving bound is the earlier lossy one |
| [L22](../findings/route-a.md#L423) | lost as stated: no $\alpha^*=32/141$, so the frontier branch does not reach down to Nienhaus's, and the $\alpha\approx1/3$ window reopens |
| beyond | **nothing.** [LEDGER.md:249](../findings/LEDGER.md#L249) records that nothing cites L22, and [r464](REVIEW_r464.md) established that [Lemma L20](../findings/route-a.md) uses neither L22 nor L102 |

So the blast radius is the claimed repair of Nienhaus's Theorem 4.17 and the extension of his Theorem 4.19 past $n=11$ (a claim about the literature) and no internal result of this programme.

## Hypotheses the claim actually needs

$u$ the zero-padded Fox / $\mathbb{CP}^2$-type critical point in $\mathcal W_n$ (fixed up to $SO(n)$, so the statement is orbit-invariant and well posed once $u$ is chosen); $F_u=L_u$ its multiplication operator; $V_{1/3},\ V_0=\ker F_u$ its Peirce spaces; $M_{W_1}=\Pi_0L_{W_1}|_{V_0}$; $q=\Pi_0Q(W_1)$. Then, **at $n\in\{12,14,16\}$ and for random $W_1\in V_{1/3}$**, $M_{W_1}q=0$ to $\le8.5\times10^{-15}$ against a control of $0.33$. Everything past those three dimensions is assertion; the containment $Q(V_{1/3})\subseteq V_0\oplus\langle u\rangle$ is itself one of the unproven vanishings, and the trilinear restatement in finding 4 uses it.

## Repairs, in order of cost

1. **Resolve the contradiction** (findings 1–3): keep the annihilation form as the claim; rewrite [route-a.md:381](../findings/route-a.md#L381) so it does not read as superseding it, and note that the weaker orthogonality would not support $V(t)$.
2. **Fix the Gate 2 line** (finding 10): [route-a.md:418](../findings/route-a.md#L418) is Reviewer 19 on the surrounding argument; L102 has no Gate 2, as its index row already says.
3. **Define $M_{W_1}$** in [conventions.md](../findings/conventions.md), with $V_{1/3}$, $F_u$, $\Pi_{\ker}$, and record the $W_1$ collision with [L103](../findings/route-a.md#L37) as a live trap (finding 9).
4. **State the sample** (finding 7): "verified at 40 random $W_1$", not "for every $W_1$", until a basis check exists; and record the polynomial-genericity argument that makes the $W_1$ quantifier the safe half.
5. **Say the padding points the wrong way** (finding 8), and settle the "four vanishings" count and their dimensions (finding 6).
6. **Add the subspace form $\mathcal S\perp\mathcal R$** (finding 4) (r21's dropped recommendation) and open the $\mathrm{Stab}(u)$-isotypic route (finding 5) as the seventh attempt, in place of the bilinear target now named at [route-a.md:381](../findings/route-a.md#L381).
