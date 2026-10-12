# Review r655, Observation L103, the witness $W_1$ and its sharp constant

Reviewer r655, reviewer A of an independent pair on identical briefs. Cold audit from [conventions.md](../findings/conventions.md). Target: [Observation L103, the witness $W_1$ and its sharp constant](../findings/route-a.md#L37), body at [route-a.md:39](../findings/route-a.md#L39).

**Verdict: CONFIRMED, and the whole of it is derivable, every number in the block is a closed form and every "$\approx0$" residual is exactly $0$; the one clause that is not is "sharp", which is a GAP of Conjecture-A strength.**

The refutation reduces to $55>54$. $c_{12}=f(\pi/2)=\sqrt{2/3}\,\theta_0(12)=\sqrt{55/54}$ exactly, and the two figures the heading prints are **one number at two precisions**. Both admissibility conditions (orthogonality to $W_{\mathbb{CP}^2}$ and to the orbit tangent), are exact for a two-line reason, so the $4.8\times10^{-16}$ is a residual of arithmetic and not of the claim. One quantity the block never names, $\alpha(W_1)=0$, is what makes the refutation bite at exactly the angle Nienhaus's minimisation uses, and it is forced by criticality plus the orthogonality the block already asserts. **On the analysis in §2–§4 the label can be `Lemma` at every $n\ge12$ once "sharp" is scoped.**

---

## Readings adopted, stated before anything is derived

| symbol | reading I use | source |
| --- | --- | --- |
| $\theta_0(n)$ | the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$ **and nothing more** | [conventions.md](../findings/conventions.md), as repaired 2026-09-04 |
| $\Theta_n$ | the diagonal maximum; $=\theta_0(n)$ at **even** $n$. $n=12$ is even, so **the parity trap does not bite at the dimension the block names**, it does bite on the generalisation, see §4 | same |
| norm | $\lVert W\rVert^2=\operatorname{tr}(W^2)=\sum_\alpha\lambda_\alpha^2=1$ on $\Lambda^2$, the $\tfrac12$ taken at the $\Lambda^2$ level | [conventions.md](../findings/conventions.md), "norms and pairings" |
| $\theta$, $P$ | $P(W)=\langle W,Q(W)\rangle$, $\theta=P/\lVert W\rVert^3$; critical means $Q(W)=\theta W$ | [conventions.md](../findings/conventions.md) |
| padding | extension by zero; commutes with $Q$ and preserves $\lVert\cdot\rVert$ and $\theta$ | [conventions.md](../findings/conventions.md) |
| $S_{XYZ}$ | ordered slots | [conventions.md](../findings/conventions.md). *It plays no part below; L103 uses no $S_{XYZ}$.* |

**Four symbols this block runs on are in no convention file, and I had to reconstruct all four from the source notes.** [conventions.md](../findings/conventions.md) carries no entry for $f$, for $c_n$ or $c_{12}$, for $W_1$, or for the pair $(\alpha,\gamma)$. I take them from [notes.md](../references/nienhaus-2023-second-best-einstein/notes.md) §"Theorem 4.17" and from [ATTEMPTS.md:1476](../ATTEMPTS.md#L1476), which agree:

$$f(\varphi)=\sqrt{2/3}\,P(\cos\varphi\,W_{\mathbb{CP}^2}+\sin\varphi\,W)=\cos^3\varphi+3\alpha\cos\varphi\sin^2\varphi+\gamma\sin^3\varphi,$$
$$\alpha=\sqrt{2/3}\,\langle Q(W),W_{\mathbb{CP}^2}\rangle,\qquad \gamma=\sqrt{2/3}\,P(W),$$

for unit $W\perp\mathbb RW_{\mathbb{CP}^2}\oplus T_{W_{\mathbb{CP}^2}}(SO(n).W_{\mathbb{CP}^2})$, "admissible" below means exactly that. $c$ is the a priori cap on $f$ that the proof feeds into $g_c(\varphi)=(c-\cos^3\varphi-3\alpha\cos\varphi\sin^2\varphi)/\sin^3\varphi\ge\gamma$. **$f$ is therefore a function of the pair (base point, direction), never of the operator alone**, §4 turns on this.

> **$c_{12}$ COLLIDES WITH A LIVE CONSTANT OF THE SAME NAME, AND THE OTHER ONE IS THREE HUNDRED TIMES SMALLER.** [second-order.md:956](../findings/second-order.md#L956) carries $c_n=3\theta_0(n)/(n-2)$, quoted as $c_{12}=0.370810$ by [r394](REVIEW_r394.md) and [r442](REVIEW_r442.md) and capped at $c_{12}\le0.0126$ by [r393](REVIEW_r393.md). This block's $c_{12}=1.009216785$ is an unrelated object, a cap on $f$, not a third-order margin. Same class as the $B$, $M$ and $\mu$ collisions [conventions.md](../findings/conventions.md) already tables, and not yet written down.

> **AND $W_1$ CARRIES THREE MEANINGS IN THIS ONE FILE.** [r465](REVIEW_r465.md) and [r466](REVIEW_r466.md) recorded this and asked for a conventions entry; there is still none. L103's $W_1$ is one specific tensor, [L102](../findings/route-a.md#L461)'s is a bound variable, and [Remark 4.18](../references/nienhaus-2023-second-best-einstein/notes.md)'s is the $V_{1/3}$ component.

---

## 1. What exactly is refuted, the premise, quoted, and the entry that depended on it

**The premise, verbatim from the source note** ([notes.md](../references/nienhaus-2023-second-best-einstein/notes.md), Theorem 4.17): the proof *"caps $\gamma$ with numerator constant $c=1$, justified by '$f\le1$ on $[0,\pi]$', which is exactly the claim that $W_{\mathbb{CP}^2}$ is the global maximizer, available only for $n\le11$."* Evaluated at $\varphi=\pi/2$ the premise **is** $\gamma\le1$, i.e. $P(W)\le\sqrt{3/2}=P(W_{\mathbb{CP}^2})$ for every admissible $W$.

**Refuted-as-quantified, and the block is on the right side of the line.** Nienhaus states Theorem 4.17 under $10\le n\le11$, where his own Main Theorem supplies the global maximality; there the premise is true and untouched. The block opens *"At $n=12$"*, so it does not misstate its target, but the heading's bare *"kills the $f\le1$ premise"*, read alone, does. The scoped reading is already the record's: correction 2 four lines above, [route-a.md:33](../findings/route-a.md#L33), says the **proof** does not extend and the theorem is not shown false.

**What actually depended on it, and it is three entries of the lab notebook.** [ATTEMPTS.md](../ATTEMPTS.md) items **50**, **51** and **52**, *"the $n\le11$ restriction … is a low-dimension obstruction"*, *"no remaining obstruction in sight"*, *"the restriction appears exactly once, at the top"*, conclude at [ATTEMPTS.md:1529](../ATTEMPTS.md#L1529) that *"there is no dimension restriction anywhere in the argument that fails at $n\ge12$"*. **L103 is the refutation of that census, and the census failed for a structural reason worth recording: it enumerated stated hypotheses and cited results** ([ATTEMPTS.md:1527](../ATTEMPTS.md#L1527), *"the proof of Theorem 4.17 cites precisely two results"*) **and $f\le1$ is neither, it is an inline justification, invisible to a citation graph.**

*Those three entries still read as they did.* That is **correct by policy, not a defect**: [ATTEMPTS.md](../ATTEMPTS.md)'s preamble makes it append-only, with the corrected position owed to [findings/](../findings/), and [findings/](../findings/) carries it in three places, the Gate 2 row *"Theorem 4.17's proof does not extend to $n\ge12$, CONFIRMED"* at [route-a.md:22](../findings/route-a.md#L22), L103 itself, and [post F36](../findings/fence-posts.md#L291). **Checked so the pair can compare: this is a clean negative.**

---

## 2. The constant, derived, the block prints a measurement of a rational number

$W_1$ is the balanced sphere product, so its value is the record's own closed form, [problem.md:486](../findings/problem.md#L486): $\theta_{6,6}^2=55/36$, equivalently $\theta_0(12)^2=2\cdot11\cdot10/144=220/144$. At unit norm $P(W_1)=\theta_0(12)$, so

$$f(\pi/2)=\gamma=\sqrt{2/3}\,P(W_1)=\sqrt{\tfrac23\cdot\tfrac{55}{36}}=\boxed{\sqrt{\tfrac{55}{54}}}=\frac{\sqrt{330}}{18}=1.00921678469916\ldots$$

**and $f(\pi/2)>1\iff 55>54$.** In general $f(\pi/2)^2=\tfrac23\theta_0(n)^2=\tfrac{4(n-1)(n-2)}{3n^2}$, so at even $n$ the witness exists iff $n^2-12n+8>0$, i.e. $n>6+2\sqrt7=11.2915$, the record's own crossover, at [route-a.md:109](../findings/route-a.md#L109) and [r276](REVIEW_r276.md).

- **The two figures are the same number.** $\sqrt{55/54}=1.0092167847$ rounds to $1.0092168$ at eight significant figures and to $1.009216785$ at ten. Printing both in one heading reads as two independently obtained quantities agreeing; there is one quantity. *The block should print the closed form once.*
- **The closed form was already on the record, in the general case, in three places the block does not cite.** [notes.md](../references/nienhaus-2023-second-best-einstein/notes.md) writes *"with the correct $c_n=\sqrt{2/3}\,\theta_0(n)>1$"*; [r275](REVIEW_r275.md) tabulates $c=\sqrt{2/3}\,\theta_0(n)$ with $1.009216785$ in the $n=12$ row; [ATTEMPTS.md:1486](../ATTEMPTS.md#L1486) tabulates $\sqrt{2/3}\,\theta_n$ across nine dimensions. **This is the seventh table in this audit to collapse into a closed form, and the closed form did not have to be found, it had to be quoted.**
- **The block's symbolic side-claim is correct, and I re-derived it by hand rather than trusting it.** Differentiating $g_c$ in $k=\cos\varphi$ and clearing $3(1-k^2)^{1/2}$ gives $[(3\alpha-1)k^2-\alpha](1-k^2)=-k[c+(3\alpha-1)k^3-3\alpha k]$, and the quartic terms cancel to leave $(1-\alpha)k^2-ck+\alpha=0$, the block's equation exactly. At $c=1$ the roots are $k=1$ and $k=\alpha/(1-\alpha)$, and substituting the second gives numerator $4\alpha^3-3\alpha+1=(1-2\alpha)^2(1+\alpha)$ over $(1-\alpha)^3$ against $(1-2\alpha)^{3/2}/(1-\alpha)^3$, i.e. $\gamma_{\max}(c{=}1)=(1+\alpha)\sqrt{1-2\alpha}$, $=\tfrac4{3\sqrt3}$ at $\alpha=\tfrac13$. **Confirmed, and so is the reading that the pdftotext string is a mangling.** *One inconsistency inside the record, cosmetic: this block reports the mangled string as $\sqrt{1-2\alpha(1+\alpha)}$ and [r276](REVIEW_r276.md) reports it as $1-\sqrt{2\alpha(1+\alpha)}$. Both name the same correct form; they cannot both be what the extractor printed.*

### Is $\pi/2$ special? Yes, provably, and the block does not know why

**$\alpha(W_1)=0$ exactly.** $W_1$ is a critical point, so $Q(W_1)=\theta_0(12)\,W_1$, and therefore

$$\alpha=\sqrt{2/3}\,\langle Q(W_1),W_{\mathbb{CP}^2}\rangle=\sqrt{2/3}\,\theta_0(12)\,\langle W_1,W_{\mathbb{CP}^2}\rangle=0,$$

using only the orthogonality the block itself asserts. Criticality is not measured either: the $SO(6)\times SO(6)$-invariants of $\Lambda^2\mathbb R^{12}$ are spanned by the three block projectors ($\Lambda^2V_1$, $\Lambda^2V_2$ and the mixed block are pairwise non-isomorphic irreducibles), tracelessness and factor-swap invariance cut that line down to $\dim=1$, and a gradient constrained to a line through the point is parallel to it, symmetric criticality, no floating point.

Hence, along this geodesic and in closed form,

$$f(\varphi)=\cos^3\varphi+\sqrt{\tfrac{55}{54}}\,\sin^3\varphi,\qquad f'(\varphi)=3\sin\varphi\cos\varphi\,(\gamma\sin\varphi-\cos\varphi).$$

Three consequences, none of them in the block:

1. **$\varphi=\pi/2$ is the unique maximiser of $f$ on $[0,\pi]$**, with $\max f=\gamma$; $f$ falls from $1$ to $\min f=\gamma/\sqrt{1+\gamma^2}=\sqrt{55/109}=0.71034$ at $\tan\varphi=1/\gamma$ ($44.737^\circ$) and rises to $\gamma$. So "sharp" is *true on this curve* and provably so.
2. **The block's own correction 2 falls out exactly.** $f$ decreases on $(0,\arctan\sqrt{54/55})\supset(0,\pi/6)$, and $f(\pi/6)=(\sqrt3/2)^3+\gamma/8=0.7756711509$, the $0.7757$ at [route-a.md:33](../findings/route-a.md#L33), to every digit printed, from a closed form.
3. **It is what makes the refutation bite.** The cap $c$ enters at the minimising angle $k=\alpha/(1-\alpha)$; at $\alpha=0$ that angle is $\pi/2$ itself, and the bound the premise yields is $\gamma\le\gamma_{\max}(0)=(1+0)\sqrt{1-0}=1$, violated by $W_1$ at $\gamma=1.00922$. *Without $\alpha=0$ the refutation would be softer than it looks: at $\alpha=1/3$ the cap is consumed at $\varphi=\pi/3$, where this same $W_1$ has $f=0.78051<1$.* **So "no weaker 'local to the curve' reading escapes" is right, and $\alpha(W_1)=0$ is the reason.**

### The one thing that is not derived: "sharp"

$c$ must be an **upper bound on $f$ over all admissible $W$ and all $\varphi$**. Every point $\cos\varphi\,W_{\mathbb{CP}^2}+\sin\varphi\,W$ is a unit Weyl operator orthogonal to the orbit tangent (the base point is, because $\langle A\!\cdot\!u,u\rangle=0$; the direction is by admissibility), so

$$\sup f=\sqrt{2/3}\cdot\max\{P(V):\lVert V\rVert=1,\ V\perp T_{W_{\mathbb{CP}^2}}(SO(12).W_{\mathbb{CP}^2})\}.$$

Setting that equal to $\sqrt{2/3}\,\theta_0(12)$ asserts $\max P\le\theta_0(12)$ **on a codimension-$34$ subsphere of $\mathcal W_{12}$**, a global maximality statement of exactly Conjecture A's kind, weaker than $M(12)=\theta_0(12)$ but not derivable from anything on the record, and implied by Conjecture A at $n=12$. The block's evidence for it is *"ascent over the whole complement tops at the same value"*: finitely many starts in $1603$ dimensions. **That is a measurement, and the word "sharp" is stated flat.**

> The correct reading is already twice on the record and neither instance is cited here. [r275](REVIEW_r275.md): *"the cap $c$ … is an a priori bound on $\max P$ … Transplanting the same shape … needs the analogous cap $\max P\le\theta_0(n)$, **Conjecture A itself**."* [r276](REVIEW_r276.md): *"The replacement constant is an a priori $\sup P$ bound, i.e. route M's object."* **A block asserting sharpness with no hypothesis, 350 lines from two reviewers who priced it as circular, is the defect to fix.**

**Repair, in one sentence:** *$c_{12}=\sqrt{55/54}$ is attained, hence a lower bound on any admissible cap; it is the sharp cap if and only if $\max P=\theta_0(12)$ on the orbit-tangent complement, which is Conjecture A at $n=12$ restricted, and is unproved.*

---

## 3. The construction, $W_1$ is a Weyl tensor, and both residuals are exactly zero

**Weyl.** $W_1$ is the Weyl part of the Einstein product metric on $S^6(r)\times S^6(r)$: a Riemannian curvature tensor minus its Ricci and scalar traces, so first Bianchi holds (each summand satisfies it) and it is totally trace-free by construction; it lies in $\mathcal W_{12}$, of dimension $\tfrac{12\cdot9\cdot13\cdot14}{12}=1638$. **No formula is being applied off its domain here.** Its block form is the record's own, [bounds.md:399](../findings/bounds.md#L399): $W_1$ is **a scalar on each of the three blocks** $\Lambda^2V_1$, $\Lambda^2V_2$, $V_1\wedge V_2$, with values $\tfrac{\mu(n-p)}{(p-1)(n-1)}$, $\tfrac{\mu(n-q)}{(q-1)(n-1)}$ and $-\tfrac{\mu}{n-1}$. Write $a$ for the first and $c_{\mathrm{mix}}$ for the third; $a\ne c_{\mathrm{mix}}$ always.

**$\langle W_1,W_{\mathbb{CP}^2}\rangle=0$, exact, in one line, and this is where the split choice is spent.** Padded $W_{\mathbb{CP}^2}$ is supported on $\Lambda^2\mathbb R^4$ for the four coordinates of the block. Those four sit inside the first factor, so $W_1$ restricted to $\Lambda^2\mathbb R^4$ is $a\cdot\mathrm{Id}$, and

$$\langle W_1,W_{\mathbb{CP}^2}\rangle=\operatorname{tr}(W_1W_{\mathbb{CP}^2})=a\operatorname{tr}(W_{\mathbb{CP}^2})=0,$$

because every Weyl operator is trace-free on $\Lambda^2$. **The block's "exactly" is right and needs no computation.**

**$W_1\perp T_{W_{\mathbb{CP}^2}}(SO(12).W_{\mathbb{CP}^2})$, also exact; the $4.8\times10^{-16}$ is arithmetic noise, not a residual of the claim.** The action of $\mathfrak{so}(12)$ on curvature tensors is skew for the inner product, so $\langle W_1,A\!\cdot\!W_{\mathbb{CP}^2}\rangle=-\langle A\!\cdot\!W_1,W_{\mathbb{CP}^2}\rangle$, and since $W_{\mathbb{CP}^2}$ has all indices in $\{0,1,2,3\}$ only the four-index restriction of $A\!\cdot\!W_1$ to that block is seen. In $(A\!\cdot\!W_1)_{ijkl}$ with $i,j,k,l\in\{0,1,2,3\}$, a summation index $m\in\{4,5\}$ contributes a $\Lambda^2V_1$ component of $W_1$ off its own diagonal, which vanishes because $W_1$ is scalar there; $m\in\{6,\dots,11\}$ pairs the mixed block against $\Lambda^2V_1$, which vanishes because $W_1$ is block-diagonal; and $m\in\{0,1,2,3\}$ leaves $a\,(A_4\!\cdot\!G)$ with $G_{ijkl}=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}$ the constant-curvature tensor of $\mathbb R^4$, which is $O(4)$-invariant and so killed by the skew $A_4$. **Every term is zero for every $A$.**

### Is the value split-dependent? No, but admissibility is, and the block should say which

$f(\pi/2)=\sqrt{2/3}\,P(W_1)$ depends only on $P(W_1)$, which is $SO(12)$-invariant, so **a conjugate split gives the same value.** Nothing in the number is split-dependent, and the brief's structural worry does not land. What the split buys is **admissibility**: if the $\mathbb{CP}^2$ block straddles the two factors, say $\{0,1\}\mid\{2,3\}$, then $W_1$ on $\Lambda^2\mathbb R^4$ is $\operatorname{diag}(a,c_{\mathrm{mix}},c_{\mathrm{mix}},c_{\mathrm{mix}},c_{\mathrm{mix}},a)$ rather than scalar, and

$$\langle W_1,W_{\mathbb{CP}^2}\rangle=(a-c_{\mathrm{mix}})\big[(W_{\mathbb{CP}^2})_{0101}+(W_{\mathbb{CP}^2})_{2323}\big]=(a-c_{\mathrm{mix}})\cdot2\mu\ne0,$$

since $W_{\mathbb{CP}^2}$ has eigenvalue $2\mu$ on the Kähler form and $\pm$ on its complement. So *"the one whose first factor contains the $\mathbb{CP}^2$ block"* is **load-bearing and correctly stated**, and equivalently one may fix the split and move the competitor, since only the relative position matters. **What the block owes the reader is one clause: $f$ is a function of the base point and the direction jointly, so the choice is about which pairs are admissible, never about the value.**

---

## 4. Label and reach, the block names one dimension and holds at all of them

Every ingredient above is exact, so **nothing in L103 needs the `Observation` label except the "sharp" clause**; scope that clause and the rest is a `Lemma`. And nothing is special about $12$:

| $n$ | split carrying the witness | $c_n=\sqrt{2/3}\,\Theta_n$ | witness? |
| --- | --- | --- | --- |
| even $n\ge12$ | $S^{n/2}\times S^{n/2}$, block inside one factor | $\sqrt{\tfrac{4(n-1)(n-2)}{3n^2}}$ | yes iff $n^2-12n+8>0$, i.e. $n>6+2\sqrt7$ |
| odd $n\ge13$ | $S^{(n-1)/2}\times S^{(n+1)/2}$, block inside the larger factor | $\sqrt{\tfrac{4(n-1)(n-3)}{3(n+1)(n-2)}}$ | yes iff $n^2-13n+18>0$, i.e. $n>\tfrac{13+\sqrt{97}}2$ |

Both orthogonality proofs of §3 use only that the $\mathbb{CP}^2$ block sits inside one factor of a two-factor product (true for any $p\ge4$) and criticality holds for every $S^p\times S^q$, so $\alpha=0$ and $f(\varphi)=\cos^3\varphi+c_n\sin^3\varphi$ at every $n$. **So the refutation of the extension is not an $n=12$ phenomenon; it is every dimension the extension was wanted for**, which is what makes [post F36](../findings/fence-posts.md#L291)'s *"the $n=12$ flip is structural, its sign being exactly $\operatorname{sign}(c-1)$"* the right statement and this block the narrow one.

> **THE PARITY TRAP IS LIVE ON THE GENERALISATION AND ONLY THERE.** At odd $n$ the witness value is $\Theta_n$, **not** $\theta_0(n)$, [conventions.md](../findings/conventions.md) records that substituting the closed form there is what regrew [L0](../findings/problem.md)'s refuted constant. [ATTEMPTS.md:1486](../ATTEMPTS.md#L1486)'s table is headed $\sqrt{2/3}\,\theta_n$ but its odd columns are $\Theta_n$ ($0.9562$ at $n=9$, $0.9938$ at $n=11$, against $\theta_0$'s $0.96011$ and $0.99586$), **correct values under Nienhaus's $\theta_n$, which is the record's $\Theta_n$ and not the record's $\theta_0$.** A third symbol for one object; worth a conventions line before anyone generalises L103.

### What consumes L103: nothing, and two pointers land here by accident

- **No result cites it.** A sweep of [findings/](../findings/), [results.md](../results.md), [plan.md](../plan.md), [plan-verification.md](../plan-verification.md) and [report/](../report/) finds L103 named only in [LEDGER.md](../findings/LEDGER.md) and in reviewer reports. Its blast radius is the claimed repair of Nienhaus's Theorem 4.17, route **R4**, already **closed** in [routes.md](../routes.md#L20), and no result of this programme.
- **[L100](../findings/route-a.md#L41)'s *"the same machinery"* resolves here in file order and should not.** Independently found by [r619](REVIEW_r619.md) and [r620](REVIEW_r620.md), and the record already carries the correction in L100's own block. **Confirmed from this side: L103 yields no dichotomy and nothing L100 could be taking.**
- **A second accidental pointer, not previously flagged.** [LEDGER.md:1479](../findings/LEDGER.md#L1479) lists *"the other Observations carrying Lemmas"* and names **L103** with the file link `diagonal-half.md`, wrong twice: L103 is in [route-a.md](../findings/route-a.md), and no Lemma carries an edge from it. The same line misfiles **L102** to `diagonal-half.md` as well. *This is scanner reach of the kind that line's own paragraph diagnoses two sentences earlier.*

### Duplication, the statement is not numbered twice, but it is written four times

| where | form | numbered? |
| --- | --- | --- |
| [route-a.md:39](../findings/route-a.md#L39) | this block, $n=12$, decimal constant | **L103** |
| [fence-posts.md:291](../findings/fence-posts.md#L291) | *general*: the flip is structural, sign $=\operatorname{sign}(c-1)$ | post F36, unnumbered |
| [routes.md:20](../routes.md#L20) | the R4 register row, same sentence | no |
| [notes.md](../references/nienhaus-2023-second-best-einstein/notes.md) | the witness restated under Theorem 4.17, same figures | no |

**No duplicate number**, so the heading check was not evaded. But the two strongest statements of L103's content are the two unnumbered ones, and neither cites the number. *If anything is renumbered here it should be [post F36](../findings/fence-posts.md#L291), which is the general theorem of which L103 is the $n=12$ instance.*

---

## Provenance

**Checked with `git log -S`, and it is clean, the block is a verbatim lift of a reviewer report, and says so upstream.** The text first enters at `ca236478` (2026-08-20, *"prove no maximizer lies near the CP^2 orbit for n >= 12"*), in [REVIEW_r14.md](REVIEW_r14.md), whose §"Theorem 4.17" is this paragraph word for word; the `#### Observation L103` heading was placed later, at `6cf9b1d2` (2026-09-02, *"place headings for results 100-103"*), and the number assigned at `8d34609b`. [route-a.md:17](../findings/route-a.md#L17) attributes the Gate 2 to Reviewer 14 and links the report. **The block makes no self-historical claim of its own, so there was nothing here to be false.**

*One consequence of that lift worth stating:* the numbers are **one build**, from 2026-08-20. They have since been reproduced independently, [r275](REVIEW_r275.md) and [r276](REVIEW_r276.md) each rebuilt $c_n=\sqrt{2/3}\,\theta_0(n)$, the $\gamma_{\max}$ formula and the crossover, so the arithmetic is not resting on one implementation. **After §2 and §3 it rests on no implementation at all.**

---

## Screens

*Reported as screens, per the analysis-only footing: seconds of exact and floating arithmetic on objects constructed for the check, never evidence for a positive claim. No search, sweep or census was run; nothing in the verdict rests on these.*

| screened | value | against the record |
| --- | --- | --- |
| $\sqrt{55/54}$ | $1.00921678469916389$ | block's $1.0092168$ and $1.009216785$ ✔ both |
| $\sqrt{2/3}\cdot\sqrt{220}/12$ | identical to 30 digits | the two are one number ✔ |
| $(\sqrt3/2)^3+\gamma/8$ | $0.7756711509$ | correction 2's $f(\pi/6)=0.7757$ ✔ |
| $\min f=\sqrt{55/109}$ | $0.7103429847$ at $44.737^\circ$ |, (new) |
| $f(\pi/3)$ | $0.7805055$ | shows the $\alpha=1/3$ angle is *not* where this witness bites |
| $g_c(1/3)$ at $c=\sqrt{55/54}$ | $0.7838055202$ | [r275](REVIEW_r275.md)'s $0.783805520$ ✔ to 9 digits |
| $\sqrt{2/3}\,\Theta_n$, $n=9,11$ | $0.95618$, $0.99381$ | [ATTEMPTS.md:1486](../ATTEMPTS.md#L1486)'s $0.9562$, $0.9938$ ✔, the table is in $\Theta_n$, not $\theta_0$ |

---

## What to change in the block

1. **Print the closed form.** $c_{12}=f(\pi/2)=\sqrt{2/3}\,\theta_0(12)=\sqrt{55/54}=\sqrt{330}/18$, and $>1\iff55>54$. Drop one of the two decimals from the heading; they are the same number.
2. **Scope "sharp".** It is proved on the $W_1$ curve, where $\alpha=0$ makes $\pi/2$ the unique maximiser; over the whole complement it asserts $\max P\le\theta_0(12)$ on a codimension-$34$ subsphere, which is Conjecture A at $n=12$ restricted and is unproved. Cite [r275](REVIEW_r275.md), which prices it.
3. **Add $\alpha(W_1)=0$**, with its one-line proof, and say it is what puts the binding angle at $\pi/2$.
4. **Replace both residuals with the exactness arguments** of §3, and say in one clause that the split choice buys admissibility rather than the value.
5. **Widen the reach or say why not**: the witness exists at every $n\ge12$, with $\Theta_n$ (not $\theta_0(n)$), at odd $n$.
6. **Repairs outside the block**: a `$c_{12}$` and a `$W_1$` line in [conventions.md](../findings/conventions.md), and the two misfiled links at [LEDGER.md:1479](../findings/LEDGER.md#L1479).
