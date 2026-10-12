# Branca, Catino, Dameno, Mastrolia 2024, the cubic Weyl estimate and its conjectured constant

## The cubic (1.3), p. 3

$Q:=2W_{pqrs}W_{ptru}W_{qtsu}+\tfrac12W_{pqrs}W_{pqtu}W_{rstu}$, the reaction term of the Weyl tensor's evolution on an Einstein manifold. In dimension four, $Q^\pm=36\det_{\Lambda^\pm}W^\pm$ on the self-dual and anti-self-dual parts.

## The estimate (2.7), p. 7

> **Estimate 2.7.** For every algebraic Weyl tensor in dimension $n$, $\lvert Q\rvert\le C(n)\lvert W\rvert^3$, with $C(4)=\tfrac{\sqrt6}4$ (sharp, equality at $\mathbb{CP}^2$ and at quotients of $S^4$ with the opposite sign), and constants for $n=5$ (Tran) and $n=6$ (Huisken) and $n\ge7$ (Huisken) that the extraction garbles.

*The $n\ge7$ constant reads as $\tfrac52$ in the extraction; the $n=5,6$ constants are not legible from `pdftotext` and were not needed.* $\lvert W\rvert$ is the full tensor norm.

## The conjecture of Section 4.2, p. 22 to 23

> **Conjecture 4.2.** *(Unnumbered in the paper, stated at the end of Section 4.2.)* The estimate $Q\le C(n)\lvert W\rvert^3$ holds with $C(n)=\tfrac{\sqrt6}4$ for every $n$.

**Its evidence**: SLSQP maximisation of $f(W)/\lvert W\rvert^3$ under the Weyl constraints at $n=5$ and $6$ from many random starts, recovering $\tfrac{\sqrt6}4$ at $n=4$ as a control and returning $C(5),C(6)\approx\tfrac{\sqrt6}4$. The authors note that equality in higher dimension might be realised by an algebraic Weyl tensor that is not the Weyl tensor of a metric. Nothing is run above $n=6$ "due to the heavy computational cost".

**Against the record.** $Q$ is Huisken's cubic of Lemma 3.5, and the [Huisken note](../huisken-1985-ricci-deformation/notes.md) converts its normalisation: with $\lvert W\rvert=2\lVert W\rVert$, $\theta=2Q/\lvert W\rvert^3$, so $\tfrac{\sqrt6}4$ against $\lvert W\rvert^3$ is $\theta=\sqrt{3/2}$. The conjecture is therefore $\theta\le\sqrt{3/2}$ at every $n$, true on the record's catalogue for $n\le11$ and false from $n=12$, where the balanced product has $\theta_0(12)=1.236033$.
