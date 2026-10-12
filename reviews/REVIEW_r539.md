# REVIEW r539, Observation L9, "the high ground has more than one peak"

**Target:** [findings/graded-half.md](../findings/graded-half.md), `#### Observation L9` at line 195, through to the next heading at line 203.
**Reviewer:** r539, cold, adversarial.
**Footing:** analysis-only, inherited. No search, sweep, census or falsifier hunt was run. No numerical run of any kind was made; every number below is quoted from the record and audited for internal consistency, and the one positive claim I add is derived by hand.

**VERDICT: REFUTED**, the block asserts two things that the record's own audited measurements contradict, and one of them is a textbook instance of a trap this record already names. The headline survives, and the $n=8$ half is not only true but now **provable analytically**, which the block under-claims.

---

## The block, verbatim

> Testing whether a nonzero defect forces instability answers no, and the counterexample is one of the named families. The quaternionic-Kähler operator on $\mathbb{HP}^2$ is a strict local maximum: its second variation is negative on the whole tangent space apart from the directions along its orbit, at $n=8$ and $n=12$. Two consequences. Any argument excluding defective rivals has to be sensitive to the value and not only to the defect, since defectiveness alone permits a genuine peak. And the landscape carries several peaks below the two named ones rather than a single ridge, so eliminating rivals cannot be a stability argument.
>
> The same computation settles the Ricci-flat Kähler family's internal structure: its $m=3$ member is a *third-order* saddle, second variation negative semidefinite, but the value rises cubically along the extra flat directions, and its $m=4$ member is already an ordinary saddle. So the $\mathbb{CP}^2$-type competitor is the family's only local maximum, matching [Lemma L8](../findings/graded-half.md)'s closed form, which puts it at the family's peak.

Five separable claims: (1) $\mathbb{HP}^2$ strict local max at $n=8$; (2) the same "at $n=12$"; (3) the Kähler family's $m=3$ member is a third-order saddle with negative *semi*definite second variation and extra flat directions; (4) its $m=4$ member is an ordinary saddle; (5) the $\mathbb{CP}^2$-type point is the family's only local maximum, matching L8's closed form. **(1) and (4) are true. (3) is false. (2) is false on its natural reading and unsupported on the other. (5) is half true with a broken citation.**

---

## F1, REFUTED: the $m=3$ Kähler member is an ordinary saddle, not a third-order one, and it has no extra flat directions

The family is the record's own "Ricci-flat Kähler family", named twice inside [Lemma L8](../findings/graded-half.md) and indexed so that $m=2$ is the $\mathbb{CP}^2$-type competitor; L8's own refutation box indexes it as "$\mathbb{CP}^m$ for $m\ge4$". So the $m=3$ member is $\mathbb{CP}^3$ at $n=6$ and the $m=4$ member is $\mathbb{CP}^4$ at $n=8$. The closed form in [findings/INDEX-values.md](../findings/INDEX-values.md), $\theta^2(\mathbb{CP}^m)=\frac{(m+1)(2m-1)}{3m(m-1)}$, gives $3/2$, $10/9$, $35/36$ at $m=2,3,4$, matching the three points below.

[findings/target.md](../findings/target.md), the screen across eleven catalogued points, audited at Gate 2 by r71 and r72 independently:

| point | $n$ | $\theta$ | $\lambda_{\max}(L_e\vert_{e^\perp})$ | $\#>\tfrac12$ | verdict |
|---|---|---|---|---|---|
| $\mathbb{CP}^3$ | 6 | $1.054093$ | $\mathbf{0.62500000}$ | $8$ | **violates** |
| $\mathbb{CP}^4$ | 8 | $0.986013$ | $\mathbf{0.60000000}$ | $15$ | **violates** |

By [Lemma L24](../findings/second-order.md) the Riemannian Hessian is $6\theta(L_e-\tfrac12\mathrm{Id})$ with $\theta>0$, so an eigenvalue $0.625$ of $L_e$ is a Hessian eigenvalue $6\theta(0.625-0.5)=+0.75\,\theta>0$. **$\mathbb{CP}^3$ therefore has an $8$-dimensional strictly positive Hessian subspace.** Its second variation is not negative semidefinite; it is indefinite. Claim (3) is false at its first clause.

Its second clause fails too, and independently. The block says the value "rises cubically along the *extra flat directions*". The flat directions are $E(\tfrac12)$, and "extra" is the excess above the orbit, [trap 37](../findings/INDEX-traps.md) states this in exactly those words, "the *excess* $\dim A(\tfrac12)-\dim(\text{orbit tangent})$". [findings/target.md](../findings/target.md)'s multiplicity table records

| point | $\lambda_{\max}$ off $e$ | $\dim E(\tfrac12)$ | orbit | excess |
|---|---|---|---|---|
| $\mathbb{CP}^3$, $\mathbb{CP}^4$ | $0.625$, $0.600$ | $6$, $12$ | $6$, $12$ | $\mathbf 0$ |

**$\mathbb{CP}^3$ has excess $0$: there are no extra flat directions for the value to rise cubically along.** The prose below that table says so in the record's own voice ("Excess $0$ holds on both sides of the discriminator), at the saturating $S^4\times S^4$ *and* at the violating $\mathbb{CP}^3$, $\mathbb{CP}^4$".

### The diagnosis: L9 has transferred $S^3\times S^3$'s profile onto $\mathbb{CP}^3$

The description L9 gives of its "$m=3$ member", negative semidefinite second variation, extra flat directions, value rising cubically along them, is, word for word, the record's description of **$S^3\times S^3$ at $n=6$**, from [Lemma L3](../findings/second-order.md)'s correction box: "$\dim E(\tfrac12)=18$ against an orbit of $9$, leaving **nine Hessian null directions transverse to the orbit**, along which $P$ increases at cubic order". The excess table gives $S^3\times S^3$ excess $\mathbf 9$, against $\mathbb{CP}^3$'s $0$.

And the two points are exactly the pair the record already flags as the trap: $\mathbb{CP}^3$ and $S^3\times S^3$ share $\theta=1.054093$ **exactly**, at the same $n=6$. [findings/target.md](../findings/target.md) names the hazard directly ("**$\theta$ does not predict the verdict**), $\mathbb{CP}^3$ and $S^3\times S^3$ share $\theta=1.054093$ exactly and land on opposite sides". L9 is on the wrong side of that sentence.

Claim (4), "$m=4$ is already an ordinary saddle", is true, but by the same measurement, and the word "already" is what breaks: $\mathbb{CP}^4$ violates the bound by $0.100$ where $\mathbb{CP}^3$ violates it by $0.125$. The family gets *less* saddle-like at $m=4$, not more. **The block's monotone story runs backwards.**

## F2, REFUTED on the natural reading: "at $n=12$"

$\mathbb{HP}^2$ is $8$-dimensional, so "at $n=8$ and $n=12$" does not parse as one space. Two readings, and both fail.

**Reading (A), the natural one: $\mathbb{HP}^2$ and $\mathbb{HP}^3$.** This is what [findings/graded-half.md](../findings/graded-half.md)'s own Wolf-space table offers, its only two quaternionic rows are $\mathbb{HP}^2$ at $n=8$ and $\mathbb{HP}^3$ at $n=12$, in that order. Under it the claim is **refuted by the record**: [findings/target.md](../findings/target.md) puts $\mathbb{HP}^3$ first on the list of points that do *not* saturate ("nothing else saturates), $\mathbb{HP}^3$, four Grassmannians, $SO(8)/U(4)$, $Sp(3)/U(3)$, $\mathbb{CP}^5$, …". Non-saturation means $\lambda_{\max}(L_e\vert_{e^\perp})\ne\tfrac12$, and by the orbit argument (below, and a theorem per r71) it is always $\ge\tfrac12$; so it exceeds $\tfrac12$, the Hessian has a strictly positive direction, and **$\mathbb{HP}^3$ is not a local maximum at all**, let alone a strict one.

**Reading (B): $\mathbb{HP}^2$ padded.** [findings/target.md](../findings/target.md) tabulates padded $\mathbb{HP}^2$ at $n=10$ **and** $n=12$, both with $\lambda_{\max}=0.50000000$. Under this reading L9 silently drops the $n=10$ row from the same three-row table, and the word "padded", load-bearing, since the record's very next paragraph shows padding acts *oppositely* on the two families, is absent from the block. Worse, the datum is the wrong one: that table's second column is $\#>\tfrac12$, and $\#>\tfrac12=0$ says only $\lambda_{\max}\le\tfrac12$, i.e. the Hessian is negative **semi**definite. **No excess figure for $\mathbb{HP}^2$ at any $n$ exists in the record**, the multiplicity table above contains $\mathbb{CP}^2$, $\mathbb{CP}^2$ padded, $S^4\times S^4$, $S^3\times S^5$, $S^5\times S^5$, $S^3\times S^3$, $\mathbb{CP}^3$, $\mathbb{CP}^4$, $[3,3,3]$, and no quaternionic row at all.

**So on reading (B) the block does exactly what [Observation L3](../findings/second-order.md) was refuted for today**: it reads the necessary second-order condition as the sufficient one. L3's box states the failure ("The diagonalisation returns a negative **semi**definite Hessian), the *necessary* second-order condition (and the block read it as the sufficient one") and L9, two files away, asserts a *strict* local maximum off exactly that kind of datum. That L9's own second paragraph draws the semidefinite/definite distinction makes the lapse harder to excuse, not easier.

## F3, but claim (1) is TRUE, and the record can now PROVE it. The block under-claims

$\mathbb{HP}^2$ at $n=8$ is a strict local maximum transverse to its orbit, and this follows analytically from three things the record already holds. No computation is needed.

**Input, from the record:** $\mathbb{HP}^2=\tau(S^3\times S^5)$, where $\tau$ is the triality automorphism of $\mathfrak{so}(8)$, built explicitly by r71 as the spin representation on $\Delta_+=\mathbb O$ and **exactly orthogonal** ([findings/graded-half.md](../findings/graded-half.md), [findings/target.md](../findings/target.md); the identification is recorded as *confirmed by a stronger test than was originally run*).

**Step 1, $\tau$-conjugation commutes with $Q$.** Write $\tau$ for the induced orthogonal map on $\Lambda^2\mathbb R^8\cong\mathfrak{so}(8)$ and act on operators by $W\mapsto\tau W\tau^{-1}$. Then $(\tau W\tau^{-1})^2=\tau W^2\tau^{-1}$ trivially; and $\#$ is built from the structure constants $c_{abc}=\langle[v_a,v_b],v_c\rangle$ ([findings/conventions.md](../findings/conventions.md)), which $\tau$ preserves because it is simultaneously a Lie-algebra automorphism and orthogonal, so $(\tau W\tau^{-1})^\#=\tau W^\#\tau^{-1}$. Hence $Q(\tau W\tau^{-1})=\tau Q(W)\tau^{-1}$, and $\tau$-conjugation maps critical points to critical points at the same $\theta$, which is why $\mathbb{HP}^2$ and $S^3\times S^5$ share $\theta=\sqrt{56/45}$ in the first place.

**Step 2, $\tau$-conjugation preserves $\mathcal W_8$.** $\mathcal W_n$ is the irreducible $\mathfrak{so}(n)$-summand of highest weight $2\omega_2$ inside $\mathrm{Sym}^2(\Lambda^2)$. Triality permutes $\omega_1,\omega_3,\omega_4$ and **fixes $\omega_2$**, so the $2\omega_2$-isotypic component is $\tau$-stable. (Dimension check against the record's anchor: $\dim\mathcal W_8=\frac{8\cdot5\cdot9\cdot10}{12}=300$.)

**Step 3, $\tau$ carries $SO(8)$-orbits to $SO(8)$-orbits.** The $SO(8)$-action on $\mathcal W_n$ is conjugation by $\mathrm{Ad}(g)$, and $\mathrm{Inn}(\mathfrak{so}(8))$ is normal in $\mathrm{Aut}(\mathfrak{so}(8))$, so $\tau\,\mathrm{Ad}(g)\,\tau^{-1}=\mathrm{Ad}(g')$. Orbits map to orbits and orbit tangents to orbit tangents. The dimensions agree independently: $\dim\mathfrak{so}(8)=28$, and both stabilisers are $13$-dimensional, $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ for the sphere product, $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ for $\mathbb{HP}^2$ (the record records $\dim\mathfrak k(W)=13$ for both), so both orbits are $15$-dimensional.

**Step 4, [Lemma L27](../findings/nondegeneracy.md) at $(p,q)=(3,5)$.** L27 is stated for $p,q\ge3$ with $(p,q)\ne(3,3)$, which $(3,5)$ satisfies: $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$ at $W_{p,q}$, **attained exactly on the orbit tangent**, with $\dim E(\tfrac12)=pq=15=\dim(\text{orbit})$.

**Step 5, transport, then [Lemma L24](../findings/second-order.md).** Steps 1–3 give $L_{e(\mathbb{HP}^2)}=\tau\,L_{e(S^3\times S^5)}\,\tau^{-1}$ on $\mathcal W_8$, so the spectra and eigenspace dimensions coincide and $\tau$ carries the $\tfrac12$-eigenspace of one to that of the other, i.e. orbit tangent to orbit tangent. Hence at $W_{\mathbb{HP}^2}$: $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$ with $E(\tfrac12)$ **exactly** the $15$-dimensional orbit tangent. L24 gives $\mathrm{Hess}_SP=6\theta(L_e-\tfrac12\mathrm{Id})$ with $\theta=1.115547>0$, so the Hessian is **negative definite on the orthogonal complement of the orbit tangent in $T_WS$, and zero along the orbit**, where $P$ is constant by $O(8)$-invariance. $\mathbb{HP}^2$ is a Morse–Bott nondegenerate local maximum, strict transverse to its orbit. $\square$

This is the same argument shape that promoted [Observation L3](../findings/second-order.md) to a Lemma today (L24 for the Hessian, L27 for the multiplicity), with one extra step, the triality transport. **L9's $n=8$ half is therefore an under-claimed Lemma, and it should not have been carrying an $\mathbb{HP}^2$-specific numerical warrant at all.**

It also answers the brief's question about consistency with L24: "negative on the whole tangent space apart from the orbit directions" is not merely consistent with L24 but is the *only* form a strict maximum can take under it. L24's orbit directions are always exact $\tfrac12$-eigenvectors ("differentiating $Q(W_t)=\theta W_t$ along an orbit gives $e\circ\dot W=\tfrac12\dot W$", a theorem per r71), so the Hessian is identically zero along the orbit at every critical point, and "strict" can only ever mean "strict transverse to the orbit". The block's phrasing is right; its warrant was not.

## F4, the input, [Lemma L8](../findings/graded-half.md), was downgraded to a Conjecture today, and L9's use of it is the part that failed

L9's only numbered input is the last clause of its second paragraph: the $\mathbb{CP}^2$-type competitor is the family's only local maximum, "matching [Lemma L8](../findings/graded-half.md)'s closed form, which puts it at the family's peak".

- **The value ordering survives without L8.** $\theta^2(\mathbb{CP}^m)=\frac{(m+1)(2m-1)}{3m(m-1)}$ is strictly decreasing, so the family's peak in value is $m=2$. That is [findings/INDEX-values.md](../findings/INDEX-values.md)'s closed form, independent of L8.
- **The citation itself is broken twice over.** L8's claim that its pinning "reproduces the Ricci-flat Kähler family … identically" is refuted inside L8's own correction box, which lists the failures and ends "and $\mathbb{CP}^m$ for $m\ge4$". So L8's closed form demonstrably does *not* cover the family L9 cites it for. And L8 is now a `Conjecture` ([findings/INDEX-results.md](../findings/INDEX-results.md) row 8), while [results.md](../results.md) still heads it `##### Lemma L8` and still states the pinning as fact, a stale label L9's citation inherits.
- **"Peak in value" is not "only local maximum" anyway.** The block slides from the first to the second in one clause, and F1 shows the second was established from the wrong point.

**So the surviving part of L8 does not carry L9, and the part L9 leans on is the refuted part.** The damage is contained: the clause is decorative, since the value ordering has an independent closed form.

## F5, the label, and what should replace it

`Observation` means verified numerically at named dimensions. The block:

- **names dimensions** for paragraph 1 ($n=8$, $n=12$), one of which is wrong or wrongly stated (F2);
- **names none** for paragraph 2, giving only "$m=3$" and "$m=4$"; the reader must supply $n=6$ and $n=8$;
- **cites no computation at all**, no script, no reviewer, no residual, no table. Its sibling results in this record cite theirs ([b_second_order_screen.py](../scripts/lib/b_second_order_screen.py) for the very table that refutes it). The phrase "the same computation" in paragraph 2 refers to a computation the block never identifies.
- [findings/INDEX-results.md](../findings/INDEX-results.md) row 9 reads "**Gate 2: no verdict on the record**", which is accurate as of this audit's start.

**What the label should become.** Split the block. Paragraph 1 at $n=8$ becomes a **Lemma**, with the F3 proof (L27 + triality + L24), no dimension list and no numerics. Paragraph 2's $m=3$ sentence is deleted and replaced by the record's own measurement: both $\mathbb{CP}^3$ and $\mathbb{CP}^4$ violate the L24 bound, at $0.625$ and $0.600$, each with excess $0$, so each is an ordinary saddle with an $(m^2-1)$-dimensional unstable subspace. The "$n=12$" claim is withdrawn pending a decision on which object was meant.

## F6, the citations

Five loci in [results.md](../results.md) carry L9 (the brief's sixth is the heading/body pair at 346/348 counted separately):

| line | what it takes | taken as proved? | survives? |
|---|---|---|---|
| [68](../results.md) | "$\mathbb{HP}^2$ is a strict local maximum with nonzero defect (Observation L9)", used to argue a separator must see the *value*, not the defect | yes, as an established counterexample | **yes**, F3 proves it, and the defect is real ($\delta^2=0.031746$, [findings/graded-half.md](../findings/graded-half.md)) |
| [126](../results.md) | the headline plus the $\mathbb{HP}^2$ strictness | yes | **yes**, same grounds |
| [320](../results.md) | L5's list, "quaternionic-Kähler operators on $\mathbb{HP}^m$" losing on value | it is L5's claim, not L9's | **yes**, independent of L9 |
| [346](../results.md) | heading of the canonical restatement |, | heading survives |
| [348](../results.md) | the statement, **paragraph 1 only** | yes | **the "$n=12$" clause does not** |

Two things worth flagging. **No citation takes the Kähler-family structure**, the refuted paragraph 2 is not copied into [results.md](../results.md) at all, so F1's blast radius is confined to [findings/graded-half.md](../findings/graded-half.md). And **every live citation takes only the $\mathbb{HP}^2$-at-$n=8$ claim**, which F3 proves. **So the refutation costs the programme nothing downstream**; it costs the block its second paragraph and its "$n=12$".

## F7, internal contradiction: where it is, and where it is not

The brief asked whether a later passage in [findings/graded-half.md](../findings/graded-half.md) contradicts the block. **It does not.** The file's later $\mathbb{HP}^2$ passages *support* the surviving half, line 418 records it as "a **graded** critical point with **nonzero defect** ($\delta^2=0.031746$) at $\theta=1.115547$, the highest defective graded point on record", which is precisely what citation [68](../results.md) needs; and line 375 supplies the triality identification F3's proof runs on.

**The contradictions are cross-file, in [findings/target.md](../findings/target.md)**, the $\mathbb{CP}^3$/$\mathbb{CP}^4$ rows, the excess table, the $\mathbb{HP}^3$ non-saturation list. This is worth recording as a structural point: L9 sits in the graded-half file while the second-order screen that governs every one of its claims sits in the target file, and nothing in either points at the other. The block would have been caught the day the screen was written had it carried a link.

---

## Summary of the verdict

| claim | verdict | witness |
|---|---|---|
| $\mathbb{HP}^2$ strict local max at $n=8$ | **true, and now provable** | [L27](../findings/nondegeneracy.md) at $(3,5)$ + triality + [L24](../findings/second-order.md) |
| the same "at $n=12$" | **refuted** (as $\mathbb{HP}^3$) / **unsupported** (as padded) | $\mathbb{HP}^3$ on target.md's non-saturating list; no excess datum for $\mathbb{HP}^2$ at any $n$ |
| $m=3$ member a third-order saddle, negative semidefinite, extra flat directions | **refuted** | $\mathbb{CP}^3$: $\lambda_{\max}=0.625$, $8$ positive Hessian directions, excess $0$ |
| $m=4$ member an ordinary saddle | **true**, but "already" inverts the family's trend | $\mathbb{CP}^4$: $\lambda_{\max}=0.600$, $15$ positive directions |
| $\mathbb{CP}^2$-type point the family's peak | **true in value**, by the independent closed form; the [L8](../findings/graded-half.md) citation is broken | $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ strictly decreasing |
| headline: "the high ground has more than one peak" | **CONFIRMED** | $\mathbb{HP}^2$ at $n=8$, proved in F3 |

**VERDICT: REFUTED**
