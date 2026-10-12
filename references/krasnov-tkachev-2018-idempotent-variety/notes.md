# Krasnov–Tkachev 2018, extraction

## Proposition 6.6 (§6.2, p. 23), verbatim

> **Proposition 6.6.** Let $A$ be a Euclidean metrised algebra. Then for any extremal idempotent $c$ there holds $\sigma(c)\subset(-\infty,\tfrac12]$. In particular, $1$ is a simple eigenvalue of $L_c$.

Proof mechanism, at the level of which estimate binds: $f(x)=\langle x^2;x\rangle/|x|^3$ is degree-zero homogeneous; at an extremal idempotent $D^2f(c)\le0$ reads $2L_c-\mathrm{Id}\le P_c$, the **orthogonal projector** onto $\mathbb Rc$, and $P_c=0$ on $c^\perp$, giving $2L_c-1\le0$ there.

> **THE PAPER'S NEXT LINE PRINTS $2L_c-1\le c\otimes c$, AND THAT IS A MISPRINT**, it drops the factor $\lVert c\rVert^{-2}$ that the paper's own equation (56) carries. *Substituting $x=c$ into (56) gives $\tfrac13D^2f(c)=\big[2L_c-\mathrm{Id}-(c\otimes c)/\lVert c\rVert^2\big]/\lVert c\rVert$.* The printed form is **false** whenever $\lVert c\rVert<1$: at $y=c$ it reads $\lVert c\rVert^2\le\lVert c\rVert^4$. In this project $c=W/\theta$ has $\lVert c\rVert=1/\theta<1$, so the printed form fails on our own objects while the projector form holds. *Found at Gate 2 by [r367](../../reviews/REVIEW_r367.md) and [r368](../../reviews/REVIEW_r368.md), independently, each from equation (56).* Exactly this project's Lemma 24, with the same one-line proof shape ($\mathrm{Hess}=6\theta(L_e-\tfrac12)$).

**"Extremal idempotent" is the idempotent associated to a GLOBAL maximum** of $\langle x,x^2\rangle$ on the unit sphere, Definition 6.4, and the minimal-norm remark says the same. *This entry read "local maximum" and cited "their (19)", which is an unrelated syzygy.* **The distinction is load-bearing for [L24](../../findings/second-order.md)**, which is cited across the record at *local* maximisers: what covers those is 6.6's **proof**, which consumes only $c^2=c$, self-adjointness and $D^2f(c)\le0$, rather than 6.6 as stated. A witness that the two differ: $S^4\times S^4$ at $n=8$ has $\lVert c\rVert^2=16/21$ against padded $W_{\mathbb{CP}^2}$'s $2/3$. Their normalisation is $c=x/\langle x^2,x\rangle$, so extremal idempotents are the **minimal-norm** ones, $\theta=1/\|c\|$, and maximizing $\theta$ is minimizing $\|c\|$.

> **A SECOND MISPRINT, alongside the $c\otimes c$ one above.** The proposition as printed says $\sigma(c)\subset(-\infty,\tfrac12]$ and its own next sentence says $1$ is a simple eigenvalue of $L_c$, which $(-\infty,\tfrac12]$ excludes. **The statement a consumer may cite is $\sigma(L_c\vert_{c^\perp})\subseteq(-\infty,\tfrac12]$ with $1$ simple on $\mathbb Rc$**, which is what the proof gives and what this record's L24 states.

**No unit is required.** The definition of a Euclidean metrised algebra at `kt-1801.00617.txt:969-974` asks for equation (48) and positive-definiteness and nothing more, and 6.6's proof consumes only idempotency, self-adjointness and $D^2f(c)\le0$, *so the unitality trap that killed another route here does not reach this import.* Confirmed independently by three verifiers reading the source.

## Proposition 6.7 (§6.2, p. 23–24), verbatim

> **Proposition 6.7.** If $c$ is an extremal idempotent and $\tfrac12\in\sigma(c)$ then $\langle z^2;z\rangle=0$ for all $z\in A_c(\tfrac12)$. In other words, the following fusion rule holds: $A_c(\tfrac12)A_c(\tfrac12)\subset A_c(\tfrac12)^\perp$. (57)

Proof mechanism: for $z\in A_c(\tfrac12)$, the first AND second directional derivatives of $f$ at $c$ along $z$ vanish identically, so local maximality forces the **third** derivative to vanish and the **fourth** to be $\le0$ (their sign convention: $\partial^3f/\partial z^3|_c=0$ and $\partial^4f/\partial z^4|_c\ge0$ as printed, check the sign against the maximum convention when applying). The third-derivative identity evaluates to $\langle z^2;z\rangle=0$.

**Why this matters here.** The orbit tangent at any critical point lies in $A_c(\tfrac12)$ (proven in this project by differentiating equivariance), so at a maximizer the fusion rule constrains products of orbit directions, non-invariant data. The rule has the same $\mathbb Z_2$-shape as gradedness ($[\mathfrak m,\mathfrak m]\perp\mathfrak m$), and the third/fourth-variation calculus continues past the second-order tool that this project's attacks exhausted.

## Also in the paper

- §3: at least $n-1$ syzygies on the Peirce spectrum of a generic $n$-dimensional algebra, obstructions our random critical points must satisfy.
- Footnote 3 (p. ~14): extremal idempotents with $\tfrac12$-eigenspace "can be related to Clifford algebras", the reference is Tkachev, *On an extremal property of Jordan algebras of Clifford type* [56], the route to Hurwitz–Radon dimension constraints on $A_c(\tfrac12)$.
- What each proof cites: the extremal calculus comes from the Nadirashvili–Tkachev–Vlăduţ book (SURV 200) and [54],[56].
