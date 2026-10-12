# Verifier v63, L61's equality clause: does "with equality exactly on that orbit" follow from the sum-of-squares certificate?

**Cold brief, analysis only.** No script was run and no numerical work of any kind was done; every value below is an exact closed form evaluated by hand from constants the record itself names. [findings/sym3-blocks.md](../findings/sym3-blocks.md) was excluded by the brief and was not read. Log: [agent_logs/verify-L61-v63.log](../agent_logs/verify-L61-v63.log). Sources read: [verification/ROUND_L61.md](ROUND_L61.md), [findings/conventions.md](../findings/conventions.md), [results.md](../results.md):23, 204, 623–628, [findings/bounds.md](../findings/bounds.md):496, 500, [findings/INDEX-results.md](../findings/INDEX-results.md):86 (L72), [findings/INDEX-traps.md](../findings/INDEX-traps.md):23 (W5), [scripts/runs/n5_certificate.json](../scripts/runs/n5_certificate.json) (read, not executed).

## Verdict table

| # | The clause, split | Verdict | Reason, in a clause |
|---|---|---|---|
| 1 | **every $W\in O(5)\cdot W_0$ attains equality** | **VALID AS WRITTEN** | $\theta$ is $O(5)$-invariant and $\theta(W_0)=\sqrt{3/2}$ by hand from the spectrum $(2,-1,-1,0^7)/\sqrt6$, *though the certificate alone yields only $\lvert\theta\rvert=\sqrt{3/2}$, the sign being imported* |
| 2 | **every $W$ attaining equality lies on $O(5)\cdot W_0$** | **FAILS** | a sum of squares certifies $\text{orbit}\subseteq Z(F_5)$ and never the converse; and $Z(F_5)\ni-W_0$, which is off the orbit because $\operatorname{spec}(-W_0)\ne\operatorname{spec}(W_0)$ |
| 3 | the clause as a claim about **$Z(F_5)$** | **FAILS, structurally and for every certificate** | $Z(F_5)$ is a cone stable under $W\mapsto-W$ and contains $0$; $O(5)\cdot W_0$ is neither |
| 4 | the clause under its most charitable reading, $\{\lVert W\rVert=1,\ \theta=+\sqrt{3/2}\}=O(5)\cdot W_0$ | **NOT ENTAILED; no argument on file** | the hypothesis given is one-way vanishing on the orbit, which bounds $Z(F_5)$ from below only; nothing in the certificate meets the equality locus |

**One line the round can act on:** the forward direction holds and is cheap, but the word *exactly* is false as written and unreachable by this route, every sum of squares of cubics has a centrally symmetric conical zero set, so $Z(F_5)\supseteq O(5)\cdot(\pm W_0)\cup\{0\}$ and its dilates for *any* such certificate, while the one reading that survives the symmetry, $\{\lVert W\rVert=1,\theta=+\sqrt{3/2}\}=O(5)\cdot W_0$, is a rigidity theorem the record does not carry. This confirms what [results.md](../results.md):23 already says (*"the equality case is unproven and unreachable by that route"*), against [results.md](../results.md):204, which asserts it.

**Verdict: `FAILS` on the converse direction; `VALID` on the forward one.**

---

## 0. What is taken as given, and what is derived

**Given by the brief**, and used without re-derivation:

- **(G1)** $F_5=\sum_{i=1}^N q_i^2$ with each $q_i$ a real cubic on $\mathcal W_5$;
- **(G2)** each $q_i$ vanishes on $O(5)\cdot W_0$;
- **(G3)** this yields $\theta\le\sqrt{3/2}$ on $\mathcal W_5$.

**Imported from the record**, each cited at its line:

- **(I1)** $P(W)=3\operatorname{tr}(W^3)$ on $\mathcal W_5$, from $\langle W,W^\#\rangle=2\operatorname{tr}(W^3)$ and Lemma L50, [results.md](../results.md):623–628. This is the step by which (G3) is drawn from $F_5\ge0$ at all, so the clause under test cannot be read without it.
- **(I2)** $\theta=P(W)/\lVert W\rVert^3$, and $\lVert W\rVert^2=\operatorname{tr}(W^2)=\sum_\alpha\lambda_\alpha^2$ in the $\Lambda^2$ normalisation the record runs in, [findings/conventions.md](../findings/conventions.md), the objects table and *Norms and pairings*.
- **(I3)** padded $W_{\mathbb{CP}^2}$ has $\Lambda^2$ spectrum $(2\varepsilon,-\varepsilon,-\varepsilon,0,\dots)$, [findings/bounds.md](../findings/bounds.md):496 and :500, and $(2,-1,-1)/\sqrt6$ with $\theta=\sqrt{3/2}$ at Lemma L72, [findings/INDEX-results.md](../findings/INDEX-results.md):86.
- **(I4)** $\mathcal W_5$ is a **linear** space, of dimension $\tfrac{5\cdot2\cdot6\cdot7}{12}=35$, [findings/conventions.md](../findings/conventions.md), and the constant $315/35$ at [findings/second-order.md](../findings/second-order.md):221. So $W\in\mathcal W_5\Rightarrow-W\in\mathcal W_5$ and $\lambda W\in\mathcal W_5$.
- **(I5)** $O(5)$ acts on $\mathcal W_5$ through $W\mapsto\Lambda^2(g)\,W\,\Lambda^2(g)^{-1}$ with $\Lambda^2(g)$ orthogonal, so the action is by **conjugation** and preserves the $\Lambda^2$ spectrum, the norm, and $\theta$.

Everything below is derived from these.

## 1. $F_5$ in closed form: it is $\theta^2$ in disguise

By (I1), $9\operatorname{tr}(W^3)^2=\big(3\operatorname{tr}(W^3)\big)^2=P(W)^2$, and by (I2) $P(W)^2=\theta(W)^2\lVert W\rVert^6$. Hence, **identically on $\mathcal W_5$**,

$$\boxed{\;F_5(W)=\lVert W\rVert^6\Big(\tfrac32-\theta(W)^2\Big).\;}$$

Three consequences, each used below.

1. **What the certificate proves is two-sided.** $F_5\ge0$ says $\theta^2\le\tfrac32$, i.e. $\lvert\theta\rvert\le\sqrt{3/2}$. The statement's "$\theta\le\sqrt{3/2}$" is the weaker half of what (G1) gives.
2. **The zero set is the two-sided equality locus.** For $W\ne0$, $F_5(W)=0\iff\theta(W)=+\sqrt{3/2}$ **or** $\theta(W)=-\sqrt{3/2}$. And $F_5(0)=0$, where $\theta$ is undefined ($0/0$).
3. **$F_5$ is an even function**: $F_5(-W)=\tfrac32\lVert W\rVert^6-9\big(-\operatorname{tr}(W^3)\big)^2=F_5(W)$, visible either from the display above ($\theta(-W)=-\theta(W)$, squared) or directly from the two terms.

## 2. Direction 1, every $W$ on the orbit attains equality

**True.** Two steps.

**(a) $\theta$ is constant on the orbit.** By (I5) the action is orthogonal conjugation, so $\lVert gW\rVert=\lVert W\rVert$ and $\operatorname{tr}((gW)^3)=\operatorname{tr}(W^3)$; hence $\theta(g\cdot W_0)=\theta(W_0)$ for every $g\in O(5)$, both components of $O(5)$ included. No connectedness is needed.

**(b) $\theta(W_0)=+\sqrt{3/2}$, by hand.** With $\operatorname{spec}(W_0)=(2\varepsilon,-\varepsilon,-\varepsilon,0^7)$ from (I3),

$$\lVert W_0\rVert^2=\varepsilon^2(4+1+1)=6\varepsilon^2=1\ \Longrightarrow\ \varepsilon=\tfrac1{\sqrt6},$$
$$\operatorname{tr}(W_0^3)=\varepsilon^3(8-1-1)=6\varepsilon^3=\tfrac{6}{6\sqrt6}=\tfrac1{\sqrt6},\qquad \theta(W_0)=3\operatorname{tr}(W_0^3)=\tfrac3{\sqrt6}=\sqrt{\tfrac32}.$$

Cross-check against §1: $F_5(W_0)=\tfrac32-9\cdot\tfrac16=0$, consistent with (G2) as it must be.

**The one caveat, and it is real.** From the given alone, (G2) forces $F_5\equiv0$ on the orbit, and §1 turns that into $\lvert\theta\rvert=\sqrt{3/2}$, *not* $\theta=+\sqrt{3/2}$. The sign is supplied by step (b), i.e. by (I3), not by the certificate. So the forward direction is **true**, and is true for a reason the sentence's own "Hence" does not carry. Recorded as a hypothesis debt rather than a defect: the record does hold (I3), twice.

## 3. Direction 2, the converse, and where it fails

### 3.1 What a sum of squares determines about a zero set

Over $\mathbb R$, $\sum_i q_i(W)^2=0\iff q_i(W)=0$ for every $i$. So (G1) gives the **identity**

$$Z(F_5)=\bigcap_{i=1}^N Z(q_i).$$

Hypothesis (G2) says $O(5)\cdot W_0\subseteq Z(q_i)$ for each $i$, hence

$$O(5)\cdot W_0\ \subseteq\ Z(F_5).$$

**This is a one-way containment and it is all (G2) can give.** The reverse containment $Z(F_5)\subseteq O(5)\cdot W_0$ is a statement about the *common real zero locus* of the particular cubics $q_1,\dots,q_N$, that the real radical of the ideal they generate is the vanishing ideal of the orbit cone. Nothing in "each $q_i$ vanishes on the orbit" bears on it: the same hypothesis is satisfied by cubics cutting out any larger set whatever. A positive-semidefinite Gram matrix, which is what [scripts/runs/n5_certificate.json](../scripts/runs/n5_certificate.json) stores (a `point`, a `shape` and a list of `blocks`), certifies non-negativity of a form; it does not certify the dimension, the components, or the extent of that form's zero set.

**So direction 2 has no argument on file, and the brief's step supplies none.** That alone settles the question. The next two subsections show the situation is worse than an omission.

### 3.2 A counterexample in closed form: $-W_0$

Let $W_1:=-W_0$. By (I4), $W_1\in\mathcal W_5$.

- **$W_1\in Z(F_5)$.** By §1.3, $F_5(W_1)=F_5(W_0)=0$. Explicitly: $\lVert W_1\rVert=1$, $\operatorname{tr}(W_1^3)=-\tfrac1{\sqrt6}$, so $9\operatorname{tr}(W_1^3)^2=9\cdot\tfrac16=\tfrac32$ and $F_5(W_1)=\tfrac32-\tfrac32=0$. Consequently, by §3.1, $q_i(W_1)=0$ for **every** cubic of **every** sum-of-squares presentation of $F_5$, a fact also readable off parity, since §3.3 forces the $q_i$ to be homogeneous cubics and hence odd: $q_i(-W_0)=-q_i(W_0)=0$. [findings/conventions.md](../findings/conventions.md)'s $W_0$ row states this same consequence.
- **$W_1\notin O(5)\cdot W_0$.** By (I5) the orbit is a conjugacy class, so every point of it has $\Lambda^2$ spectrum $\tfrac1{\sqrt6}(2,-1,-1,0^7)$. But $\operatorname{spec}(W_1)=\tfrac1{\sqrt6}(-2,1,1,0^7)$, one eigenvalue $-2/\sqrt6$ of multiplicity one and two of $+1/\sqrt6$, against one of $+2/\sqrt6$ and two of $-1/\sqrt6$. **The multisets differ**, so no orthogonal conjugation carries $W_0$ to $W_1$. $\square$
- **$\theta(W_1)=-\sqrt{3/2}$**, so $W_1$ is a *minimiser* of $P$ on the unit sphere, not a maximiser.

**Two further points of $Z(F_5)$ off the orbit**, for completeness: $W=0$, since $F_5$ is homogeneous of degree $6$ and the orbit consists of unit vectors; and $\lambda W_0$ for every $\lambda\in\mathbb R\setminus\{\pm1\}$, since $F_5(\lambda W_0)=\lambda^6F_5(W_0)=0$ while $\lVert\lambda W_0\rVert=\lvert\lambda\rvert\ne1$ and (I5) preserves the norm.

So, as a statement about $Z(F_5)$, "exactly on that orbit" fails on three independent counts: the origin, the dilates, and the sign.

### 3.3 The failure is structural, no certificate of this shape can give the clause

**Lemma (homogeneity is forced).** If $F=\sum_iq_i^2$ with $F$ homogeneous of degree $6$ and each $q_i\in\mathbb R[\mathcal W_5]$ of degree $\le3$, then every $q_i$ is a homogeneous cubic form.

*Proof.* Write $q_i=\sum_{d\le3}q_{i,d}$ in homogeneous components and let $d_{\min}$ be the least $d$ with $q_{i,d}\ne0$ for some $i$. The degree-$2d_{\min}$ component of $\sum_iq_i^2$ is $\sum_{i:\,q_{i,d_{\min}}\ne0}q_{i,d_{\min}}^2$, a sum of squares of real forms; if $2d_{\min}<6$ it must vanish, forcing every $q_{i,d_{\min}}=0$, a contradiction. So $d_{\min}=3$, and since $\deg q_i\le3$ each $q_i=q_{i,3}$. $\square$

**Corollary.** For any sum-of-squares presentation of $F_5$ by cubics, $Z(F_5)=\bigcap_iZ(q_i)$ is

- a **cone**: $q_i(\lambda W)=\lambda^3q_i(W)$, so $W\in Z\Rightarrow\lambda W\in Z$ for all $\lambda\in\mathbb R$; in particular $0\in Z$;
- **centrally symmetric**: $q_i$ odd gives $Z=-Z$.

$O(5)\cdot W_0$ is neither, it lies on the unit sphere, and $-\big(O(5)\cdot W_0\big)=O(5)\cdot(-W_0)$ is disjoint from it by §3.2. **Hence no sum-of-squares-of-cubics certificate, exact or otherwise, can have $O(5)\cdot W_0$ as its zero set.** The equality clause is not merely unproved by this certificate; it is unprovable *by any certificate of this shape*. This is exactly the assessment already standing at [results.md](../results.md):23, "the equality case is unproven and unreachable by that route".

### 3.4 The charitable reading, and why it still does not follow

The two structural obstructions of §3.3 (cone and sign), are artefacts of reading "equality" as $Z(F_5)$. The reading that survives them is the one $\theta\le\sqrt{3/2}$ invites:

$$E:=\{W\in\mathcal W_5:\lVert W\rVert=1,\ \theta(W)=+\sqrt{3/2}\}\ \overset{?}{=}\ O(5)\cdot W_0 .$$

Normalisation kills the dilates and the origin; the sign condition kills $-W_0$. **$E\supseteq O(5)\cdot W_0$ is §2. $E\subseteq O(5)\cdot W_0$ remains unentailed**, for the reason of §3.1: the given fixes $Z(F_5)$ only from below, and $E=Z(F_5)\cap\{\lVert W\rVert=1,\ \operatorname{tr}(W^3)>0\}$ inherits exactly that one-way information.

**Nor is the gap closed by the spectral facts on file.** Points of $E$ are global maximisers of $P$ on the unit sphere, hence critical, so Lemma L72 ([findings/INDEX-results.md](../findings/INDEX-results.md):86) applies to those of them that lie in the one-positive-two-negative rank-$3$ stratum, giving spectrum $(2,-1,-1)/\sqrt6$ there. **That is the forward direction of a stratum statement and does not reach $E$**, because equality does not by itself force rank $3$: on the trace-free unit sphere of symmetric operators on $\Lambda^2\mathbb R^5$ ($N=10$) the unconstrained maximum of $\sum\lambda^3$ is $\tfrac{N-2}{\sqrt{N(N-1)}}=\tfrac8{\sqrt{90}}=0.8433$, far above $\tfrac1{\sqrt6}=0.4082$, so $\operatorname{tr}(W^3)=1/\sqrt6$ is compatible with every rank. It is the Weyl conditions on $\mathcal W_5$ that exclude the higher-rank spectra, and *that exclusion is precisely the content of the certificate*, which, per §3.1, delivers it as an inequality and not as a description of where it is tight. Even granting the spectrum, one would still owe: **a $\Lambda^2$ spectrum does not determine an $O(5)$-orbit in $\mathcal W_5$**, the conjugating group being $\Lambda^2(O(5))$ inside $O(10)$, so a second orbit with the same spectrum is not excluded by anything cited here. Compare [findings/second-order.md](../findings/second-order.md):235, where the record records precisely this phenomenon at $n=8$: "the spectrum does not determine the point".

So the clause under its best reading is an **open rigidity statement**, plausible, unrefuted, and unargued.

## 4. What the given does support

Stated positively, so the round has a repair to hand:

$$F_5\ \text{SOS}\ \Longrightarrow\ \lvert\theta\rvert\le\sqrt{3/2}\ \text{ on }\mathcal W_5,\qquad\text{with equality \textbf{on} }O(5)\cdot(\pm W_0)\text{ and its dilates}.$$

The sentence becomes true by deleting one word ("with equality **on** that orbit") or, if the stronger content is wanted, by carrying the two-sided bound and naming the equality case as open. The strengthening from $\theta\le\sqrt{3/2}$ to $\lvert\theta\rvert\le\sqrt{3/2}$ is free and is not currently claimed.

## 5. Verdict

| direction | verdict |
|---|---|
| every $W$ on the orbit attains equality | **VALID AS WRITTEN**, proved in §2, with the sign of $\theta(W_0)$ imported from (I3) rather than from the certificate |
| every $W$ attaining equality lies on the orbit | **FAILS**, §3.1 (a sum of squares gives one containment only), §3.2 ($-W_0$ exhibited in closed form), §3.3 (no certificate of this shape can do it), §3.4 (the surviving reading has no argument on file) |

**`FAILS`.** The word *exactly* is unsupported, and under the literal reading it is false with the counterexample $-W_0$, spectrum $\tfrac1{\sqrt6}(-2,1,1,0^7)$, which every cubic of every sum-of-squares presentation of $F_5$ must annihilate and which no orthogonal conjugation carries to $W_0$.
