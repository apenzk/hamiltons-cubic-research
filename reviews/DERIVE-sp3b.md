# I13, step 2, RETRACTED in its $\mathbb Z_3$ half; the symmetric-pair vertex stands

*Derived after [DERIVE-sp3.md](DERIVE-sp3.md) went to Gate 2; not part of what r343 and r344 are reviewing. Gate 2 owed on its own account.*

**Where this starts.** [DERIVE-sp3.md](DERIVE-sp3.md) shows that at $d=3$ the pinned optimum sits at a vertex where at least four of the ten $t_{ijk}$ vanish, and that $t_{ijk}=0$ means $\langle[E_i,E_j],E_k\rangle=0$. That leaves $\binom{10}4=210$ candidate supports and no way to choose among them. **The question this note answers is which four-subsets are the vanishing sets of an actual grading**, because a grading is the one kind of vanishing set that is automatically closed under Jacobi.

## RETRACTED: the $\mathbb Z_3$ half of this note is false, and the run that was meant to use it found the error

> **THE TABLE BELOW WAS BUILT FROM A NON-SYMMETRIC CONDITION AND IS WRONG.** $\langle[X,Y],Z\rangle$ is **totally antisymmetric** on $\mathfrak{so}(n)$ by ad-invariance, so $T_{abc}$ depends only on the multiset $\{a,b,c\}$ and a type vanishes unless *every* reading of it is permitted. For a $\mathbb Z_m$-grading the invariant form pairs $\mathfrak g_a$ with $\mathfrak g_{-a}$, so the nonvanishing condition is $a+b+c\equiv0\pmod m$, symmetric, as it must be. **This note used $a+b\equiv c$, which is not symmetric**, and read its table off that.
>
> **And the real obstruction is worse than a wrong table.** Over $\mathbb R$ with a positive-definite inner product the pairing is $\mathfrak g_a$ with $\mathfrak g_a$, so a grading needs $2a\equiv0\pmod m$ for every part. At $m=2$ every part qualifies, **the symmetric pair is a genuine real orthogonal grading and that half of this note stands**. At $m=3$ only $a=0$ qualifies: the $\omega$ and $\bar\omega$ eigenspaces of an order-$3$ automorphism are complex conjugates whose real form is a **single** subspace. So an order-$3$ element of $SO(n)$ gives $\mathfrak{so}(n)=\mathfrak g_0\oplus\mathfrak m$, a **two**-part real decomposition, not the three orthogonal eigenspaces this note assumed.
>
> **What falls with it.** The claim that a $\mathbb Z_3$-grading has exactly four vanishing types; the claim that it is therefore a vertex; and **the six candidate multiplicity triples at $n=12$** ($(46,10,10)$, $(32,17,17)$, $(24,21,21)$, $(22,22,22)$, $(26,20,20)$, $(36,15,15)$) which were computed as $(\dim\mathfrak g_0,\dim\mathfrak g_1,\dim\mathfrak g_2)$ for spaces that are not real eigenspaces. *The consequence drawn from them, that [DERIVE-t11](DERIVE-t11.md)'s witness $(30,20,16)$ is excluded because its multiplicities are distinct, is withdrawn with them.* The $SO(p)\times U(q)$ centraliser computation is correct as complex dimensions and says nothing about a three-eigenvalue real spectrum.
>
> **What survives.** The symmetric pair with a split even part: zeros $\{113,123,223,333\}$, exactly four, a genuine vertex, confirmed by the enumeration in [run_jacobi_closure_d3.py](../scripts/runs/run_jacobi_closure_d3.py), which also passes it as a control. **And the note's framing survives**: a vertex is a partial grading, and asking which supports are Jacobi-consistent is the right question. It is answered in [DERIVE-sp3c.md](DERIVE-sp3c.md).
>
> *How it was caught*: the approved Jacobi enumeration reported **zero** of its admissible supports to be full gradings, which is impossible if a $\mathbb Z_3$-grading were a four-zero vertex. The run was authorised to test a hypothesis and refuted the note that motivated it.

