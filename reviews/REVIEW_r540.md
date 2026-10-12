# Review r540, Observation L9, "the high ground has more than one peak"

**Target.** [Observation L9](../findings/graded-half.md), at the `#### Observation L9` heading (line 195 of [findings/graded-half.md](../findings/graded-half.md)) down to the next heading, two paragraphs, lines 199 and 201.

**Reviewer.** r540, cold and adversarial, deriving from the definitions. Analysis-only footing: no searches, sweeps, censuses, optimisations or falsifier hunts were run. Nothing below is a numerical result of mine; the arithmetic that appears is hand derivation used to fix conventions and to check the record's own figures.

**VERDICT: PLAUSIBLE**, and *under-claimed*. The load-bearing half is **true and now provable**: the $\mathbb{HP}^2$ claim at $n=8$ follows from [Lemma L24](../findings/second-order.md), [Lemma L27](../findings/nondegeneracy.md) and the record's own triality identification, and the headline follows from L27 alone. The gaps are (i) the stated dimension **$n=12$ names an object that does not exist**, (ii) the second paragraph's every claim rests on the *necessary* second-order condition, which [Lemma L24](../findings/second-order.md) makes automatic at every critical point, the exact inference that refuted [Lemma L3](../findings/second-order.md), and (iii) the paragraph's citation runs to a formula refuted this cycle.

## 0. Conventions, fixed independently before reading

Re-derived from [conventions.md](../findings/conventions.md) rather than taken on trust: $\dim\mathcal W_n=\frac{n(n-3)(n+1)(n+2)}{12}$ gives $84$ at $n=6$, $300$ at $n=8$, $1638$ at $n=12$; $\theta_0(6)^2=2\cdot5\cdot4/36=10/9$, so $\theta_0(6)=\sqrt{10}/3$; $\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing.

**One independent anchor on the target's own object.** From [Petersen–Stanfield](../references/petersen-stanfield-2025-poincare-polynomials/notes.md)'s curvature-operator eigenvalues as quoted at [graded-half.md:172](../findings/graded-half.md), $\mathbb{HP}^2$ has $\tfrac14$ on $\mathfrak{sp}(1)$ (mult $3$), $\tfrac18$ on $\mathfrak{sp}(2)$ (mult $10$), $0$ on $\mathfrak m$ (mult $15$). Weyl projection subtracts $c$ with $3(\tfrac14-c)+10(\tfrac18-c)-15c=0$, so $c=\tfrac1{14}$ and the spectrum is $\tfrac5{28}^{\times3},\ \tfrac3{56}^{\times10},\ -\tfrac1{14}^{\times15}$. Then $\lVert W\rVert^2=\tfrac{75}{784}+\tfrac{90}{3136}+\tfrac{240}{3136}=\tfrac{630}{3136}=\tfrac{45}{224}$, which is the value [graded-half.md:88](../findings/graded-half.md) records. And $\theta^2=\frac{(m+2)^2(4m-1)}{9m(m-1)(2m+1)}$ at $m=2$ is $\tfrac{112}{90}=\tfrac{56}{45}$, $\theta=1.115546702$. **Conventions agree; the object is the one the block means, and its positive eigenspace is exactly $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$, dimension $13$.**

## 1. The one structural fact that governs the whole audit

[Lemma L24](../findings/second-order.md) gives $\mathrm{Hess}_SP=6\theta(L_e-\tfrac12\mathrm{Id})$ on $W^\perp$, and its sharpness paragraph says, verbatim:

> the orbit directions are exact $\tfrac12$-eigenvectors by equivariance, attained at every nonzero critical point because $\mathcal W_n$ carries no $O(n)$-invariant vector

**So $\lambda_{\max}(L_e\vert_{W^\perp})\ge\tfrac12$ at every nonzero critical point, without exception.** Two consequences that decide this review.

- **"Negative semidefinite second variation" is not a finding about a point; it is what $\theta>0$ and no violation of the L24 bound already give.** A local-maximality claim has exactly one piece of content: $\dim E_{L_e}(\tfrac12)\cap W^\perp=\dim T_W\mathcal O$. **L9 states no multiplicity, at any dimension, for any of its three points.**
- **The record's saturation table is therefore not a warrant for L9.** [target.md:588–600](../findings/target.md) reports $\lambda_{\max}(L_e\vert_{W^\perp})=0.50000000$ for $\mathbb{HP}^2$ at $n=8$ and for its paddings at $n=10$ and $n=12$. That is saturation, i.e. the *necessary* condition. [reviews/plan-maximizer.md:62](plan-maximizer.md) reads the division correctly, "target.md's saturating-set table gives this for $\mathbb{HP}^2$ and its padding, Observation L9 for strict local maximality", which means **the strictness has no source on the record other than L9's own unnamed computation.**

This is [Lemma L3](../findings/second-order.md)'s failure mode exactly: "The diagonalisation returns a negative **semi**definite Hessian (the *necessary* second-order condition) and the block read it as the sufficient one."

## 2. The $\mathbb{HP}^2$ claim at $n=8$ is TRUE, and the record can now prove it

L9's own words for the claim are the right ones, "negative on the whole tangent space apart from the directions along its orbit" is precisely $E_{L_e}(\tfrac12)\cap W^\perp=T_W\mathcal O$, which with L24 is Morse–Bott local maximality. Here is the proof.

**Step 1, $S^3\times S^5$ at $n=8$.** [Lemma L27](../findings/nondegeneracy.md) covers $p,q\ge3$, $(p,q)\ne(3,3)$, so it covers $(3,5)$; its gap is $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}=\frac{1\cdot3-1}{2\cdot2\cdot4}=\tfrac18>0$, and it concludes $\dim E(\tfrac12)=pq=15=\dim\mathcal O$. *(Checked independently: Nienhaus's ten summands at $(3,5)$ are $1+0+35+15+5+14+70+30+25+105=300=\dim\mathcal W_8$, and $28-\dim(\mathfrak{so}(3)\oplus\mathfrak{so}(5))=28-13=15$.)* With L24 this makes $S^3\times S^5$ a Morse–Bott local maximum, strict transverse to its orbit.

**Step 2, triality is an automorphism of the algebra $(\mathcal W_8,\circ,\langle\cdot,\cdot\rangle)$.** [target.md:411](../findings/target.md) states it: $\tau$ "preserves the bracket (hence $\#$) and the inner product (hence $W^2$)". [graded-half.md:460](../findings/graded-half.md) states it again and adds that $\tau$ "preserves $\mathrm{Weyl}_8$, criticality and $\theta$". *Independent check that $\mathcal W_8$ is $\tau$-stable*: the complement of $\mathcal W_8$ in $S^2(\Lambda^2\mathbb R^8)$ has dimension $406-300=106=1+35+70$, i.e. the scalar plus $S^2_0(\mathbb R^8)$ plus $\Lambda^4=\Lambda^4_+\oplus\Lambda^4_-$; the three $35$s are $S^2_0$ of $8_v,8_s,8_c$, which triality permutes. So the complement is $\tau$-stable and, $\tau$ being orthogonal, so is $\mathcal W_8$. Since $Q(X)=X^2+X^\#$ is built from operator composition on $\mathfrak{so}(8)$ and the structure constants alone, $Q(\tau\cdot X)=\tau\cdot Q(X)$, hence $\tau$ intertwines $\circ$ and $L_{\tau e}=\tau L_e\tau^{-1}$.

**Step 3, $\tau$ carries the one orbit to the other.** [graded-half.md:375](../findings/graded-half.md) states it flatly: "$\mathbb{HP}^2=\tau(S^3\times S^5)$". The mechanism is checkable: $\tau$ sends $8_v$ to $8_s$, and $\mathfrak{so}(3)\oplus\mathfrak{so}(5)=\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ acting on $8_s$ as $\mathbb H\otimes_{\mathbb H}\mathbb H^2$ is exactly $\mathbb{HP}^2$'s isotropy; the $\mathrm{ad}(\mathfrak h)$-commutant in $\mathcal W_8$ is one-dimensional ([graded-half.md:248](../findings/graded-half.md)), so the invariant tensor is unique per embedding and $\tau(W_{S^3\times S^5})=g\cdot(\pm W_{\mathbb{HP}^2})$, with $\theta>0$ fixing the sign.

**Step 4, transfer.** $\tau$ normalises $\mathrm{Inn}(\mathfrak{so}(8))$, so $\tau(SO(8)\cdot W)=SO(8)\cdot\tau W$ and orbit tangents correspond. Therefore
$$E_{L_{e'}}(\tfrac12)\cap W'^\perp=\tau\big(E_{L_e}(\tfrac12)\cap W^\perp\big)=\tau(T_W\mathcal O)=T_{W'}\mathcal O',$$
and $\mathbb{HP}^2$ is a Morse–Bott local maximum of $P$ on the unit sphere of $\mathcal W_8$, negative definite transverse to a $15$-dimensional orbit. $\square$

**This also explains, rather than merely tolerating, the pairing L9 depends on.** Local maximality is intrinsic to $(\mathcal W_8,\circ,\langle\cdot,\cdot\rangle)$ and so is $\tau$-invariant; the defect is *not* intrinsic to it, because it is read off the vector representation, $\mathbb{HP}^2$'s top eigenspace is $\langle I,J,K\rangle$ with every nonzero element of bivector rank $8$ ([target.md:407](../findings/target.md)), while $S^3\times S^5$'s is spanned by decomposables. **So "identical Hessian spectrum, different defect" is forced, not coincidental**, which is precisely L9's point, now with a reason.

**Consequence for the label.** L9's $n=8$ content is a **Lemma**, not an `Observation`. [INDEX-results.md](../findings/INDEX-results.md) row 3 records exactly this promotion for L3 on exactly these grounds; row 9 still reads "Gate 2: no verdict on the record".

## 3. And the headline is provable without $\mathbb{HP}^2$ at all

"The high ground has more than one peak" follows from [Lemma L27](../findings/nondegeneracy.md) alone. Every $S^p\times S^q$ with $p,q\ge3$, $(p,q)\ne(3,3)$ is a Morse–Bott local maximum. At $n=8$, $S^3\times S^5$ is one, at $\theta=1.115547$, strictly below both named competitors ($S^4\times S^4$ at $\theta_0(8)=1.145644$, the $\mathbb{CP}^2$-type competitor at $\sqrt{3/2}=1.224745$). So there are at least **two** peaks below the named ones at $n=8$ ($S^3\times S^5$ and $\mathbb{HP}^2$) which is what makes L9's word "several" honest. **The block does not know this**, and states its headline as though $\mathbb{HP}^2$ were the only witness.

The *second* consequence, "nonzero defect does not force instability", genuinely needs $\mathbb{HP}^2$: sphere products are provably defect-free (a survivor of the L8 audit). That is the consequence [results.md:68](../results.md) and [results.md:126](../results.md) take, and it now rests on §2's proof.

## 4. The defects in the block as written

### 4.1 "at $n=8$ and $n=12$" names an object that does not exist

Verbatim: "The quaternionic-Kähler operator on $\mathbb{HP}^2$ is a strict local maximum: its second variation is negative on the whole tangent space apart from the directions along its orbit, **at $n=8$ and $n=12$**."

$\mathbb{HP}^2$ is $8$-dimensional. There is no $\mathbb{HP}^2$ at $n=12$. The two readings both fail:

- **Padded $\mathbb{HP}^2$.** [target.md:592–594](../findings/target.md) lists $\mathbb{HP}^2$ padded at $n=10$ **and** $n=12$. If the table were the source, $n=10$ would be in the sentence. It is not.
- **$\mathbb{HP}^3$.** That is the $n=12$ quaternionic point, $\theta=0.852943860$ ([graded-half.md:71](../findings/graded-half.md)), a *different point*, of a different family member, and nothing on the record calls it a local maximum.

`Observation` is defined by [INDEX-results.md](../findings/INDEX-results.md) as "verified numerically at the dimensions stated". **The dimensions stated do not identify the objects**, so the label's own contract is unmet. Under either reading the $n=12$ half is unwarranted: for padded $\mathbb{HP}^2$ the only record evidence is saturation at $0.5$, which §1 shows is automatic; the multiplicity comparison that would settle it is stated nowhere.

*A note on why padding is not a free ride.* Padding preserves $Q$ and $\theta$, and for $V$ supported on the complementary $\Lambda^2\mathbb R^k$ one has $\tilde W\circ V=0$ (the operator products vanish on disjoint blocks and the $\#$ term needs $[\Lambda^2\mathbb R^8,\Lambda^2\mathbb R^4]\ne0$), giving eigenvalue $0$, so those directions are harmless. The live sector is the cross block $\mathbb R^8\otimes\mathbb R^4$, where the orbit contributes $32$ of the $47$ orbit dimensions and where nothing on the record separates orbit from non-orbit $\tfrac12$-vectors. **And the sector is known to be delicate**: [target.md:600](../findings/target.md) records padded *sphere products* violating the bound at $\tfrac12+\frac1{2(n-3)}$, while padded $\mathbb{HP}^2$ at the same $n=10$ and the same padding $k=2$ sits at exactly $\tfrac12$. Padding therefore creates near-flat non-orbit directions whose eigenvalue depends on the point, and at $\mathbb{HP}^2$ they land at or below the value that decides the claim. **That is where the $n>8$ claim has to be settled, and the block does not touch it.**

### 4.2 The second paragraph rests on the semidefinite reading and cites a refuted formula

Verbatim: "its $m=3$ member is a *third-order* saddle, second variation negative semidefinite, but the value rises cubically along the extra flat directions, and its $m=4$ member is already an ordinary saddle. So the $\mathbb{CP}^2$-type competitor is the family's only local maximum, matching Lemma L8's closed form, which puts it at the family's peak."

- **"Second variation negative semidefinite" is, by §1, true at every critical point.** Stated as the observation about the $m=3$ member, it carries no information; the content is that $\dim E(\tfrac12)$ exceeds the orbit dimension, which is not stated. **L9 thus displays the correct necessary/sufficient distinction in one clause and omits the multiplicity that would discharge it in the other**, the same block asserts strictness for $\mathbb{HP}^2$ on no stated multiplicity either.
- **The citation is to a downgraded result, for the one part of it that was refuted.** [Lemma L8](../findings/graded-half.md) is now a `Conjecture` ([INDEX-results.md](../findings/INDEX-results.md) row 8), and its refutation names the failure explicitly: the pinning "holds exactly on balanced splits ... and fails at $S^3\times S^5$, ..., and $\mathbb{CP}^m$ for $m\ge4$." L9 cites it for the family that includes $m=4$, one of the two members the paragraph is about. **The survivor list (the balanced-split formula, defect-freeness of sphere products, and L69's sentence), does not contain the $\mathbb{CP}^m$ closed form.**
- **The substance survives elsewhere, and the citation should be redirected.** [Lemma L10](../findings/graded-half.md) (Gate 2 passed) carries $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$, monotone decreasing, $=\tfrac32$ at $m=2$, checked here: $m=3$ gives $\tfrac{10}9$, $m=4$ gives $\tfrac{35}{36}$, both matching the record's own values. [graded-half.md:193](../findings/graded-half.md) already says in as many words that "Lemma L10 carries all of them". **L9 is the one citation in the file that was not redirected when that note was written.**
- **"The family's only local maximum" is an infinite claim from two data points.** $m=3$ and $m=4$ are checked; $m\ge5$ is not, and the sentence quantifies over the family. Monotone decreasing values make it likely; they do not make it checked.

### 4.3 A coincidence at $n=6$ that deserves a line

L9's $m=3$ member is $\mathbb{CP}^3$ at $n=6$, $\theta^2=\tfrac{10}9$. That is *the same value* as $\theta_0(6)^2$, i.e. as $S^3\times S^3$. And [Lemma L3](../findings/second-order.md)'s refutation describes $S^3\times S^3$ at $n=6$ in the same words L9 uses for $\mathbb{CP}^3$: "nine Hessian null directions transverse to the orbit, along which $P$ increases at cubic order." The points are distinct, isotropies $\mathfrak u(3)$ (dim $9$) against $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ (dim $6$), both $\mathbb Z_2$-gradings of $\mathfrak{so}(6)$ by [trap W2](../findings/INDEX-traps.md), so this is a value coincidence rather than a contradiction. **But L9's $m=3$ sentence is indistinguishable from a description of $S^3\times S^3$, and the block names no run**, so nothing on the record separates the two readings.

## 5. The citations

The brief's count is itself off: **L9 is cited four times in [results.md](../results.md), not six**, and four further times outside it.

| where | what it takes | taken as proved? | verdict |
| --- | --- | --- | --- |
| [results.md:68](../results.md) | "$\mathbb{HP}^2$ is a strict local maximum with nonzero defect" | as an `Observation` in a list of failed separators | **Sound**, and now provable at $n=8$ by §2 |
| [results.md:126](../results.md) | the headline plus "nonzero defect does not force instability" | `Observation` | **Sound**; the headline is also provable from L27 alone (§3) |
| [results.md:320](../results.md) | "quaternionic-Kähler operators on $\mathbb{HP}^m$, $m\le4$ ... **remaining a genuine peak in its own right** (Observation L9)" | asserted of the whole family | **OVER-CITED.** L9 speaks only of $\mathbb{HP}^2$. Nothing on the record makes $\mathbb{HP}^3$ or $\mathbb{HP}^4$ a local maximum, and $\mathbb{HP}^3$ is recorded as *ungraded* with $S=+0.6734$ ([graded-half.md:414](../findings/graded-half.md)) |
| [results.md:346–348](../results.md) | the stub |, | **Not a stub.** [graded-half.md:197](../findings/graded-half.md) says "That file now carries the statement and points here", but results.md:348 reproduces the block's first paragraph **verbatim**, `n=12` error and all. A second copy to correct |
| [graded-half.md:45](../findings/graded-half.md) | byte-identical duplicate of results.md:320 |, | inherits the over-citation |
| [plan-maximizer.md:62](plan-maximizer.md) | "Observation L9 for strict local maximality" as an input to Lemma L20's proof | as an input | **Reads the division correctly** and is the clearest statement that the strictness has no other source |
| [plan-maximizer.md:75](plan-maximizer.md) | "Consumes ... Observation L9" |, | same |
| [REVIEW_r315.md:74](REVIEW_r315.md) | the $m=3$ member as the cautionary example of semidefinite-plus-cubic-rise | as a cautionary example | **Sound as a caution**, but it is the one live consumer of §4.2's unwarranted half |

## 6. Internal contradiction below the block

Grepped [findings/graded-half.md](../findings/graded-half.md) for every later passage bearing on $\mathbb{HP}^2$ or the $\mathbb{CP}^m$ family. **Nothing below line 201 contradicts L9.** The later passages corroborate it: line 375 and line 460 give $\mathbb{HP}^2=\tau(S^3\times S^5)$ with $\tau$ preserving $\mathrm{Weyl}_8$ and criticality; line 397 gives the isospectral pair with differing defect; line 418 gives $\delta^2=0.031746$ at $\theta=1.115547$, "the highest defective graded point on record". **These are the ingredients of §2's proof, sitting in the same file, unused by the block.**

*Two adjacent tensions worth recording, neither reaching L9.* (i) [graded-half.md:190](../findings/graded-half.md) says "$\mathbb{HP}^3$ is a symmetric pair and therefore graded" while line 414 measures it *ungraded*, $S=+0.6734$, the (C)-versus-(A) conflation that [trap W4](../findings/INDEX-traps.md) exists to prevent, in the file that defines the trap. (ii) [results.md:336](../results.md) lists $\mathbb{HP}^2$ among the points satisfying the graded equality clause, i.e. defect-free, against this file's $\delta^2=0.031746$; but [INDEX-results.md](../findings/INDEX-results.md) row 7 already records that equality clause as false, so the list is known-defective and L9 is unaffected.

## 7. What should change

1. **Promote the $n=8$ content to a Lemma** with §2's proof, L24 + L27 at $(3,5)$ + the triality identification the file already carries at lines 375 and 460. Row 9 of [INDEX-results.md](../findings/INDEX-results.md) then stops reading "no verdict on the record".
2. **Delete "and $n=12$", or replace it with the object actually meant** and the multiplicity that supports it. As written the label's own contract ("verified numerically at the dimensions stated"), is unmet.
3. **State the multiplicities.** $\dim E_{L_e}(\tfrac12)\cap W^\perp$ against $\dim T_W\mathcal O$, for each of the three points. Without them the block is reporting the necessary condition, and §1 shows that condition holds at every critical point in the programme.
4. **Redirect the citation from [Lemma L8](../findings/graded-half.md) to [Lemma L10](../findings/graded-half.md)**, per [graded-half.md:193](../findings/graded-half.md)'s own instruction.
5. **Narrow [results.md:320](../results.md) and its duplicate at [graded-half.md:45](../findings/graded-half.md)** from "$\mathbb{HP}^m$, $m\le4$ ... a genuine peak" to $\mathbb{HP}^2$.
6. **Reduce [results.md:348](../results.md) to a pointer**, as [graded-half.md:197](../findings/graded-half.md) claims it already is.
7. **Add the free strengthening**: L27 makes every $S^p\times S^q$ with $p,q\ge3$, $(p,q)\ne(3,3)$ a peak, so the headline holds independently of $\mathbb{HP}^2$ and "several" is provable.

**Computation that would settle what analysis cannot**, named and *not run*, per the standing rule: at padded $\mathbb{HP}^2$ in $\mathcal W_{10}$ and $\mathcal W_{12}$, the dimension of $E_{L_e}(\tfrac12)\cap W^\perp$ against the orbit dimensions $45-\dim\mathrm{Stab}$ and $47$. Equality promotes the $n>8$ half; a strict excess refutes it. The same one number at $\mathbb{CP}^3$ in $\mathcal W_6$ decides §4.2's $m=3$ clause.
