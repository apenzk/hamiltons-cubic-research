# Notes, Nienhaus, *Towards Finding the Second Best Einstein Metric in Low Dimensions*

Transcribed from [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404) (`pdftotext -layout` of [nienhaus-2311.02404.pdf](https://arxiv.org/abs/2311.02404)). Line numbers below refer to the extraction, so any statement can be checked against the source directly. Index card in [README.md](../INDEX.md).

## Conjecture A, the target (extraction L212)

> "Let $W\in\mathrm{Weyl}_n$ be a unit Weyl curvature operator that is a **critical point** of $P(R)=\langle R^2+R^\#,R\rangle$ among $\mathrm{Weyl}^1_n=\{W\in\mathrm{Weyl}_n\mid\|W\|=1\}$. If either $n\ge12$, or $8\le n\le11$ and $W\notin SO(n).W_{\mathbb{CP}^2}$, we have $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$." **Here $R^{\mathrm{crit}}_{\mathrm{sym},n}$ is the curvature operator of $S^{\lceil n/2\rceil}\times S^{\lfloor n/2\rfloor}$**, *so the conclusion's constant is $\Theta_n$, which differs from $\theta_0(n)$ at odd $n$, and the hypothesis is **criticality**, which a statement quantifying over every unit Weyl operator does not carry.* **The quotation stopped before the conclusion, which is what left both substitutions available; restored verbatim from [the extraction](https://arxiv.org/abs/2311.02404):212–222.**

**The criticality hypothesis is part of the conjecture.** This matters for reading Theorem 4.19: the conjecture is a statement about critical points, and 4.19's second case invokes it by name.

The $\mathbb{CP}^2$ exception is carried explicitly at $8\le n\le11$ and dropped at $n\ge12$.

## Chapter 2, sphere products

### Proposition 2.24 (L1475)

$\mathcal S^{\mathrm{crit},n}$ is Einstein, with the Einstein constant given in closed form. Valid for odd $n$ as well as even.

### Proposition 2.25 (L1483)

> "The Weyl curvature of $S_{k,l}$ satisfies $W_{S_{k,l}}^2+W_{S_{k,l}}^\#=\theta_{k,l}\cdot W_{S_{k,l}}$, where
> $$\theta_{k,l}=\sqrt2\sqrt{\frac{k-1}{k}\cdot\frac{l-1}{l}\cdot\frac{n-1}{n-2}}.$$
> Moreover, $P(W_{S_{k,l}})=\theta_{k,l}$."

**Every sphere product, in closed form, for every split $k+l=n$.** This is what the project's own three-way derivation of $\theta_0(n)$ reproduces, and what identifies the "new" $S^4\times S^{n-4}$ point as prior art. The convention is that the split $\mathbb R^k\oplus\mathbb R^l$ gives $S^k\times S^l$, an off-by-one here caused a labelling error that Reviewer 15 corrected.

## Chapter 4, decompositions and the Hessian at $W_{\mathbb{CP}^2}$

### Proposition 4.6 (L3761), the $SO(k)\times SO(l)$ decomposition

> "Let $k,l\in\mathbb N$ with $k+l=n$ and $k,l\ge5$, $k,l\ne6$."

**There are TWO decompositions here with different ranges, and the second is the one the Morse–Bott work needs.** Proposition 4.6 decomposes $S^2(\mathfrak{so}(n))$ into eighteen summands under the hypothesis quoted above. The ten-summand $\mathrm{Weyl}_n$ display that summarises it, two pages later, closes with a range of its own:

> "This decomposition is orthogonal and irreducible under the $SO(k)\times SO(l)$-action for any $k,l\ge5$. Furthermore, it is irreducible under the action of $O(k)\times O(l)$ for any $k,l\ge3$."

**Neither half excludes $6$, and the $O\times O$ half reaches $k,l\ge3$**, so a split with a $6$-block, and the small splits $(3,4)$, $(3,5)$, $(4,4)$, are covered by the display and not by Proposition 4.6. Citing the proposition for them attaches restrictions the statement in use does not carry, and citing the display as "Proposition 4.6" hides which range is being claimed.

**Hypotheses matter and are frequently misquoted.** The orbit tangent space is $\mathbb R^k\otimes\mathbb R^l$, of dimension $kl$, the identity the Morse–Bott work verifies. The $\Lambda^2_\pm(\mathbb R^k)$ splitting exists only at $k=4$; the general statement uses $\Lambda^2(\mathbb R^k)\otimes\Lambda^2(\mathbb R^l)$.

### Proposition 4.11 (L4240), the stabilizer decomposition

> **Proposition 4.11.** Let $n\ge9$. Then the space $\mathrm{Weyl}_n$ decomposes orthogonally as
> $$\mathrm{Weyl}_n=\langle W_{S^4\times S^{n-4}}\rangle\oplus\mathrm{Weyl}^+_4\oplus\mathrm{Weyl}^{-,1}_4\oplus\mathrm{Weyl}^{-,2}_4\oplus\langle W_{\mathbb{CP}^2}\rangle\oplus\mathrm{Weyl}_{n-4}$$
> $$\oplus\ T_{W_{S^4\times S^{n-4}}}SO(n).W_{S^4\times S^{n-4}}\oplus S^2_1\oplus S^2_2\oplus S^2_0(\mathbb R^{n-4})$$
> $$\oplus\ S^2_1\otimes S^2_0(\mathbb R^{n-4})\oplus S^2_2\otimes S^2_0(\mathbb R^{n-4})\oplus\Lambda^2_+(\mathbb R^4)\otimes\Lambda^2(\mathbb R^{n-4})$$
> $$\oplus\ X^+_4\otimes\mathbb R^{n-4}\oplus X^{-,1}_4\otimes\mathbb R^{n-4}\oplus X^{-,2}_4\otimes\mathbb R^{n-4}\oplus\mathbb R^4\otimes X_{n-4}$$
> $$\oplus\ \Lambda^{2}_{-,1}(\mathbb R^4)\otimes\Lambda^2(\mathbb R^{n-4})\oplus\Lambda^{2}_{-,2}(\mathbb R^4)\otimes\Lambda^2(\mathbb R^{n-4}).$$
>
> **The decomposition is irreducible under the action of $\mathrm{Pin}(2)\cdot SU(2)_+\times SO(n-4)$.**

**Eighteen summands, and the group is named.** *The irreducibility clause is the load-bearing part: it says these are the isotypic pieces, so an equivariant operator is scalar on each, which is what makes a block-by-block argument at $W_{\mathbb{CP}^2}$ available at all.* Both $\langle W_{S^4\times S^{n-4}}\rangle$ and $\langle W_{\mathbb{CP}^2}\rangle$ appear as their own lines, so the decomposition is adapted to *both* competitors simultaneously.

Includes the summand $\mathrm{Weyl}^{-,2}_4$, which is case (g) of Theorem 4.14, the seventh eigenvalue this project first recorded as an omission.

**Remark 4.12 (L4264)** gives the same decomposition for $n=5,6,7,8$ under the same group, so the low dimensions are covered rather than excluded.

### Lemma 4.13 (L4349), Schur

Valid **only on multiplicity-free isotypic components**. This is the hypothesis Theorem 4.14's proof inherits, and the one the project's $SO(n-4)$-equivariant argument avoids entirely by absorbing multiplicities into the spaces $M_\lambda$.

### Lemma 4.15 (L4412)

The trace of $F$ vanishes on any $SU(2)_-$-invariant subspace of $\mathrm{Weyl}_n$. Cited as the model for proving that $P$ vanishes on the $\tfrac13$-eigenspace, which the 4.17 repair needs.

### Theorem 4.14 (L4365), the eigenvalues of $F_{W_{\mathbb{CP}^2}}$

> "For $n\ge9$ the eigenvalues of the map $F_{W_{\mathbb{CP}^2}}:\mathrm{Weyl}_n\to\mathrm{Weyl}_n$ are given as follows:
> (a) $W\in\langle W_{\mathbb{CP}^2}\rangle$ is an eigenvector of eigenvalue $\sqrt{3/2}$.
> (b) $W\in\mathrm{Weyl}^{-,1}_4\oplus X^{-,2}_4\otimes\mathbb R^{n-4}$ is an eigenvector of eigenvalue $\tfrac12\sqrt{3/2}$.
> (c) $W\in S^2_1\oplus S^2_1\otimes\mathbb R^{n-4}\oplus\Lambda^2_{-,1}(\mathbb R^4)\otimes\Lambda^2(\mathbb R^{n-4})$ is an eigenvector of eigenvalue $\tfrac13\sqrt{3/2}$."

Cases (a)–(g); the full spectrum is $\{1,\tfrac12,\tfrac13,0,-\tfrac16,-\tfrac12,-1\}\cdot\sqrt{3/2}$.

**Case (c) is the source of $\alpha\le1/3$**, the one external input to the tube lemma. Proof: Lemma 4.13 plus Lemma 4.15 (L4475–4652). Independently reproduced here at $n=10,12,14$, with multiplicities summing to $\dim\mathrm{Weyl}_n$ exactly.

### Theorem 4.17 (L4698), where the dimension restriction really binds

> "Let $10\le n\le11$. Then for any unit Weyl curvature operator $W\in\mathrm{Weyl}(n)$ that is perpendicular to $\mathbb R W_{\mathbb{CP}^2}\oplus T_{W_{\mathbb{CP}^2}}(SO(n).W_{\mathbb{CP}^2})$, the function $f(\varphi)=\sqrt{2/3}\,P(\cos\varphi\,W_{\mathbb{CP}^2}+\sin\varphi\,W)$ is strictly decreasing on $(0,\pi/6]$ with $f(\pi/6)<\sqrt{2/3}\,\Theta$."

**The restriction is not scope here, the proof genuinely breaks.** It caps $\gamma$ with numerator constant $c=1$, justified by "$f\le1$ on $[0,\pi]$", which is exactly the claim that $W_{\mathbb{CP}^2}$ is the global maximizer, available only for $n\le11$. With the correct $c_n=\sqrt{2/3}\,\theta_0(n)>1$, the closing estimate $g_1(1/3)$ moves from $0$ (borderline by construction at $c=1$) to $+0.0061$ at $n=12$ and grows.

The explicit witness that kills the $f\le1$ premise: at $n=12$, the balanced $S^6\times S^6$ operator for the split containing the $\mathbb{CP}^2$ block has $\langle W_1,W_{\mathbb{CP}^2}\rangle=0$ exactly and $f(\pi/2)=1.0092168>1$.

### Remark 4.18 (L4788), the repair route, and the author's own gap

Sets out the subdivision $W=\cos\beta\,W_1+\sin\beta\,W_2$ with $W_1$ in the $\tfrac13$-eigenspace and $\langle F(W_2),W_2\rangle\le0$, so that $\alpha$ near $1/3$ forces $\beta$ small. Then, verbatim:

> "a strategy on proving the estimate is to estimate $\gamma=\sqrt{2/3}P(W)$ for $W$ as above. **Unfortunately, we were not able to do this yet.**"

He works the analogous repair at the other end ($n\le9$) and localises it identically. Only the $n=9$ instance $\alpha>0.317\Rightarrow\beta<0.223$ is recorded.

### Theorem 4.19 (L4820), conditional on Conjecture A

> "Let $10\le n\le11$. Then for any $W\in\mathrm{Weyl}^1_n\setminus U_{W_{\mathbb{CP}^2}}$ the potential satisfies $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})=\theta_n$, where $U_{W_{\mathbb{CP}^2}}=\{W\in\mathrm{Weyl}^1_n\mid d(W,SO(n).W_{\mathbb{CP}^2})<\gamma_n\}$."

with $\gamma_{11}=0.13$, $\gamma_{10}=0.26$.

**The proof splits on the limit of the gradient flow, and the second case reads (L4854–4860):**

> "1st case. $W(t_0)\in SO(n).W_{\mathbb{CP}^2}$: Then by Theorem 4.17 …
> 2nd case. $W(t_0)\notin SO(n).W_{\mathbb{CP}^2}$: Then we find that $P(W)\le P(W(t_0))\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$ **by Conjecture A**."

Section 4.6 (L4810) says the same in its own framing: *"**Together with Conjecture A** this shows that for any $W\in\mathrm{Weyl}^1_n\setminus U_{W_{\mathbb{CP}^2}}$ …"*

**So 4.19's real content is removing the criticality hypothesis outside the tube, given the conjecture at critical points.** It is a localization *reduction*, not a free bound. Any use of it as an unconditional input is an error.

## Citation graph

- Theorem 4.19 → Theorem 4.17 → the Hessian at $W_{\mathbb{CP}^2}$ → Theorem 4.14 → Lemma 4.13 (Schur, multiplicity-free) and Lemma 4.15.
- Theorem 4.19 → Conjecture A itself, in its second case.
- Proposition 2.25 is independent of the chain and unconditional.
