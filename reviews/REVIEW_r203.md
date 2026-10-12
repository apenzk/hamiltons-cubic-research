# Review r203, the order-2 theorem is right and stronger than stated, its own check cannot fail, and the rank bound 13 comes from order 1

Audited at HEAD `f5105a3`, commits under review `8d1bf88`, `c2ffea9`, `4ba31e2`. Reviewer 203, Gate 2, brief `brief14.md`. Scripts: [scripts/reviewers/r203/](../scripts/reviewers/r203/). Log: [agent_logs/gate2_203.log](../agent_logs/gate2_203.log).

The brief made claims 1 and 2 the priority. Claim 1 is upheld by a re-derivation that needs strictly fewer hypotheses than the file uses, and its one non-formal input is verified exactly over $\mathbb Q$ by a computation the record has never run. No witness exists, and the reason is structural rather than accidental. Claim 2 divides: the bound 13 is correct, the route to it is correct, and one attached consequence carries an unstated hypothesis. Tightness stays open, but it is reduced here to a single sharp question and screened for the one refutation that would have been cheap to find.

## Verdict table

| claim | verdict | the one line |
|---|---|---|
| 1. order-2 vanishing is automatic | **UPHELD, and true under weaker hypotheses** | $H$-invariance suffices in place of $O(5)$-invariance, any degree suffices in place of 6, and $\lvert W_0\rvert^2\neq0$ suffices in place of $=1$; step (b) verified exactly as $\dim\mathcal W_5^{\mathfrak h}=1$ |
| 1'. the check inside [run_n5_order2.py](../scripts/runs/run_n5_order2.py) | **TWO OF THREE ASSERTS CANNOT FIRE** | `assert ip(R, S) == 0` is the defining equation of `c` and holds for a random non-symmetric matrix; `assert 9 - F(54, 6) == 0` is `9 - 9 == 0` and never touches the data |
| 1''. the $\lambda_2$-even rule applied to $\mathcal W_5$ | **LEGITIMATE, AND NOT NEEDED** | the identity component alone gives $\dim\mathcal W_5^{U(2)}=1$, so the $(-1)^{\lambda_2}$ half of the rule never enters; a larger $H$ can only shrink the fixed space |
| 2a. the bound 13 | **UPHELD** | evaluation at $W_0$ is nonzero on the 14 and the image lands in its kernel, **from order 1**; order 2 is what shows the bound cannot be sharpened by asking for more vanishing |
| 2b. "the affine family is at least 23" | **CARRIES AN UNSTATED HYPOTHESIS** | $36-\mathrm{rank}$ is the dimension of the solution set only when the system is consistent, and consistency is exactly the open necessary condition the same docstring states three lines later |
| 2c. is 13 tight? | **OPEN, reduced to one question** | $\mathrm{rank}=14-\dim\{F:\mathrm{Cat}_F(K,K)=0\}$; that space contains $\mathcal A(W_0^6)$ and a dimension count puts every other intersection at $14+29-65<0$, so 13 holds unless a second coincidence occurs |
| 2d. rank $\geq1$ | **NOW UNCONDITIONAL** | the identity Gram on $K$ maps to $\Delta=\sum_a q_a^2$, nonzero, psd, vanishing on the orbit, no appeal to $F_5$ lying in the image |
| 6. the post-orbit counts | **UPHELD independently** | 16 blocks, 3570, 25, 36, two $3\times3$ / five $2\times2$ / nine scalars, all recomputed from the weights alone; and $36+29=65$ ties claim 6 to claim 3 |
|, the record against itself | **[findings/sym3-blocks.md](../findings/sym3-blocks.md) IS STALE** | it still reads "What is known: $F_5$ lies in the image, so the rank is in $[1,14]$", which `4ba31e2` retracted in the code as assuming what the route exists to establish |

---

## Claim 1, the theorem is correct, and the version that is true is shorter than the one on file

### The statement, with the hypotheses that are actually used

Let $V$ be a real orthogonal representation of a compact group $G$, let $x\in V$ be nonzero, let $H=\mathrm{Stab}_G(x)$, and suppose $V^H=\mathbb Rx$. Then every $H$-invariant polynomial $p$, homogeneous of degree $d$, with $p(x)=0$, has $\nabla p(x)=0$.

*Proof.* $p(hy)=p(y)$ for $h\in H$ differentiates to $h^{\mathsf T}\nabla p(hy)=\nabla p(y)$, so $\nabla p(x)=h\,\nabla p(x)$ and $\nabla p(x)\in V^H=\mathbb Rx$; write it $\kappa x$. Euler's identity gives $\kappa\langle x,x\rangle=\langle\nabla p(x),x\rangle=d\,p(x)=0$, and $\langle x,x\rangle>0$. $\square$

Three hypotheses in the file do no work. **Degree 6 is not used**, the same holds in every degree, which is why the corollary for $F_5$ needs no minimality. **$O(5)$-invariance is not used**, invariance under the stabiliser alone suffices, and that is the sharp form, because it locates precisely what a counterexample would have to fail. **$\lvert W_0\rvert^2=1$ is not used**, only positivity is, and since $\mathcal W_5$ is $O(5)$-irreducible its invariant inner product is unique up to a positive scalar, so the brief's worry about which inner product normalises $W_0$ dissolves: whichever one defines $\nabla$ appears on both sides of Euler's identity, and any rescaling cancels.

### Step (b), which is the only step that is a fact about $W_0$

[stab_fixed_space.py](../scripts/reviewers/r203/stab_fixed_space.py), exact over $\mathbb Q$ throughout, on the $35\times35$ generators of [run_n5_weyl_module.py](../scripts/runs/run_n5_weyl_module.py):

```
1. dim Stab_{so(5)}(W_0) = 4   (u(2) has dim 4: True)
   orbit dimension = 10 - 4 = 6
   every basis element of h annihilates W_0 exactly

2. dim (Weyl_5)^h = 1   <- step (b) needs 1
   the fixed line is spanned by W_0: True
```

This settles the brief's second question. The computation uses the **identity component only** ($\mathfrak h=\{X\in\mathfrak{so}(5):\rho(X)W_0=0\}$) and a smaller group has a larger fixed space, so $\mathcal W_5^H\subseteq\mathcal W_5^{\mathfrak h}$ and one dimension upstairs forces one dimension downstairs. Whether $H$ has two components or four, and whether the reflection on the padding axis is redundant, cannot change the answer.

It also settles the first question. The $\lambda_2$-even rule of [findings/sym3-blocks.md](../findings/sym3-blocks.md) is a branching argument about an arbitrary $SO(5)$-irrep on which $-\mathrm{Id}$ acts trivially, and $\mathcal W_5=V_{(2,2)}$ is one of those, so applying it outside $\mathrm{Sym}^3$ is legitimate, that file already hand-checks $(2,2)\mapsto1$. But the rule has two halves, and only the first is needed here: the $U(2)$-invariants are one-dimensional for **every** $\lambda$, and the $(-1)^{\lambda_2}$ sign decides only whether the extra component kills that line. For $\mathcal W_5$ the line survives because $W_0$ itself spans it, so the parity never enters. The rule's second half remains load-bearing for the 16 blocks of $\mathrm{Sym}^3$, where it is doing real work.

### The check the file describes is not the check it runs

[run_n5_order2.py](../scripts/runs/run_n5_order2.py) says it tests step (b) "by testing the consequence the argument uses: the Weyl-projection of $W_0^2$ must be a multiple of $W_0$". The assert it reaches is

```python
c = F(ip(S2, S), ip(S, S))
R = [[S2[i][j] - c*S[i][j] for j in range(NP)] for i in range(NP)]
assert ip(R, S) == 0
```

and $\langle R,S\rangle=\langle S^2,S\rangle-c\langle S,S\rangle=0$ is the equation defining $c$. **Nothing about $W_0$ enters.** [plant_and_witness.py](../scripts/reviewers/r203/plant_and_witness.py):

```
A1. `assert ip(R, S) == 0` with c = ip(S2,S)/ip(S,S), R = S2 - c*S.
    the real S                         ip(R,M) == 0 -> True
    S with one entry corrupted         ip(R,M) == 0 -> True
    a random symmetric matrix          ip(R,M) == 0 -> True
    a random NON-symmetric matrix      ip(R,M) == 0 -> True
```

A second assert is a constant. The file prints `9 - 54*tr3*tr3/6` and then asserts `9 - F(54, 6) == 0`, which is `9 - 9 == 0`; the printed number moves when $\mathrm{tr}(W_0^3)$ is corrupted and the assert does not. Only `assert F(tr2,6) == 1 and F(tr3,6) == 1` has teeth, and it fires under a one-entry corruption of $S$.

**The check that does test step (b)**, and that the file's own prose describes, is $\pi(S^m)=\tfrac16\mathrm{tr}(S^{m+1})\,S$: every power $S^m$ is $H$-fixed, $\pi$ is equivariant, so a non-proportional projection refutes step (b) outright, and Euler fixes the constant. Exactly over $\mathbb Q$:

```
3. pi(S^m) against the prediction (tr(S^{m+1})/6) S:
   m=1: tr(S^2) =          6   pi(S^m) == (tr/6) S : True
   m=2: tr(S^3) =          6   pi(S^m) == (tr/6) S : True
   m=3: tr(S^4) =         18   pi(S^m) == (tr/6) S : True
   m=4: tr(S^5) =         30   pi(S^m) == (tr/6) S : True
   m=5: tr(S^6) =         66   pi(S^m) == (tr/6) S : True
   m=6: tr(S^7) =        126   pi(S^m) == (tr/6) S : True
```

### The witness hunt

An $O(5)$-invariant sextic vanishing at $W_0$ with a nonzero gradient there would refute the claim; the theorem says none exists, and the hunt confirms it where it can be made concrete. The four trace sextics $t_2^3$, $t_2t_4$, $t_3^2$, $t_6$ ($t_k=\mathrm{tr}(W^k)$ on $\Lambda^2\mathbb R^5$) take the values $1,\tfrac12,\tfrac16,\tfrac{11}{36}$ at $W_0$ and span a three-dimensional space of invariant sextics vanishing there. Every gradient is exactly zero, $F_5$ among them:

```
  invariant sextic            p(W_0)   grad p(W_0) as a multiple of W_0
   t_2 t_4 - (1/2) t_2^3            0        0     Euler 6p = 0
   t_3^2 - (1/6) t_2^3              0        0     Euler 6p = 0
   t_6 - (11/36) t_2^3              0        0     Euler 6p = 0
   F_5 = 3/2 t_2^3 - 9 t_3^2        0        0     Euler 6p = 0
```

The control shows the test has teeth: $p(W)=\langle W,v\rangle^6-\langle W_0,v\rangle^6\lvert W\rvert^6$ vanishes at $W_0$, is not $H$-invariant, and has a gradient there that is neither zero nor proportional to $W_0$. **Vanishing at $W_0$ contributes nothing; invariance is the entire mechanism.** A witness would have to break $H$-invariance, and an $O(5)$-invariant sextic cannot.

One limit worth stating positively: the argument stops at order 2. The same reasoning applied to a directional derivative $\partial_vp$ fails because $\partial_vp$ is not $H$-invariant, so the Hessian at $W_0$ is unconstrained by this route.

---

## Claim 2, 13 is right, it comes from order 1, and tightness is one question

### The bound

The containment is valid. Every element of $\mathrm{Sym}^2(K)$ maps to $\sum_iq_ir_i$ with $q_i,r_i\in K$, each factor vanishes at $W_0$, so the image lies in the invariant sextics vanishing at $W_0$. Evaluation at $W_0$ is a nonzero functional on the fourteen because $\lvert W\rvert^6$ takes the value 1 there, so that space has dimension exactly $14-1=13$. Both steps hold.

**What the bound uses is order-1 vanishing.** Claim 1 is not an input to it. The commit message for `4ba31e2` reads "order-2 vanishing is automatic, capping the restricted rank at 13", and the cap is produced by $q(W_0)=0$ alone. What claim 1 supplies is the complementary fact that the two candidate target spaces (invariant sextics vanishing at $W_0$, and invariant sextics vanishing there to order 2), are the **same** 13-dimensional space, so the bound cannot be sharpened by demanding more vanishing at the point. That is a statement about where further progress will not come from, and it is worth keeping for exactly that reason.

### The unstated hypothesis in "family $\geq23$"

The docstring's first consequence reads "rank on the restricted space is at most 13, so the affine family is at least $36-13=23$". The solution set of $A\,x=F_5$ has dimension $36-\mathrm{rank}(A)$ **when it is nonempty**, and nonemptiness is $F_5\in\mathrm{image}$, which the same docstring lists two bullets later as a necessary condition that is not known. Empty is not 23-dimensional. The honest form is conditional: *if* a certificate exists at all, the family containing it has dimension at least 23.

The same sentence survives, unconditioned and in its discredited form, in [findings/sym3-blocks.md](../findings/sym3-blocks.md): "What is known: $F_5$ lies in the image, so the rank is in $[1,14]$ and the surviving family has dimension $36-\mathrm{rank}$, between 22 and 35." Commit `4ba31e2` retracted precisely that sentence in [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py), "an earlier version of this comment used it as one, which assumes what the route exists to establish", and the findings file was not carried along. Two numbers there are also superseded: the rank interval is now $[1,13]$ and the family is $[23,35]$.

### rank $\geq1$, without assuming anything

The lower end can be recovered honestly. Let $q_1,\dots,q_{4200}$ be an orthonormal basis of $K$ for the apolar form. The identity Gram is an invariant quadratic form on $K$, so it is one of the 36 unknowns, and it maps to

$$\Delta(W)\;=\;\sum_a q_a(W)^2\;=\;c\Big(\lvert W\rvert^6-\tfrac1{3!}\lVert P_C\,W^3\rVert^2\Big),\qquad C=\mathrm{span}\{(gW_0)^3\},$$

which is a sum of squares of cubics of $K$, is psd, vanishes on the orbit, and is **nonzero**, [orbit_cubic_span.py](../scripts/reviewers/r203/orbit_cubic_span.py) measures $\Delta/\lvert W\rvert^6$ near $0.5$ at random points. So $\mathrm{rank}\geq1$ with no appeal to $F_5$, and the interval is $[1,13]$ on a derivation rather than on the retracted assumption.

### What tightness actually is

Write $\mathrm{Sym}^3\mathcal W_5^*=K\oplus C$, with $C$ the copy generated by $W_0^3$: one line $u_\lambda$ in the multiplicity space of each of the 16 blocks with $\lambda_2$ even, and nothing in the 8 odd blocks. For an invariant sextic $F$ the middle catalecticant $\mathrm{Cat}_F(q,r)=q(\partial)r(\partial)F$ is $O(5)$-equivariant, hence block-diagonal with a symmetric $m_\lambda\times m_\lambda$ matrix $M_\lambda$ per block. Then

$$\mathrm{rank}\;=\;\dim(K\!\cdot\!K)^{O(5)}\;=\;14-\dim\{F\in(\mathrm{Sym}^6)^{O(5)}\;:\;M_\lambda=0\ (\lambda_2\ \text{odd}),\ P_{u^\perp}M_\lambda P_{u^\perp}=0\ (\lambda_2\ \text{even})\}.$$

Counting those conditions inside the 65 gives $\sum_{\lambda_2\ \mathrm{even}}m_\lambda=29$ for the annihilator of $K\cdot K$, so the complement is $65-29=36$, **the 36 unknowns of claim 6 and the 65 of claim 3 are one computation read two ways**, an identity the record does not state ([blocks_and_unknowns.py](../scripts/reviewers/r203/blocks_and_unknowns.py)).

The tightness question is then whether that annihilator meets the 14-dimensional image of $\mathrm{Cat}$ in more than a line. It meets it in at least a line, because $\mathcal A(W_0^6)=\int_G(gW_0)^6\,dg$ has $\mathrm{Cat}(q,r)=6!\int q(gW_0)r(gW_0)\,dg$, which vanishes for $q,r\in K$. **That single forced element is the whole content of "$\leq13$".** A 14-dimensional and a 29-dimensional subspace of a 65-dimensional space in general position meet in $14+29-65<0$, that is, not at all, so the drop from 14 is already the exception; a drop to 12 needs a second, independent coincidence. **The dimension count favours 13, and it is not a proof.**

Two containments the bound 13 glosses over, each a place a second coincidence could hide:

$$(K\!\cdot\!K)^{O(5)}\;\subseteq\;(K\!\cdot\!\mathrm{Sym}^3)^{O(5)}\;\subseteq\;(I_6)^{O(5)}=13\text{-dimensional},$$

the first strict unless every invariant sextic in the ideal generated by $K$ is already a combination of products of two elements of $K$, the second strict unless every invariant sextic vanishing at $W_0$ lies in that ideal at all.

### The cheap refutation, screened and not found

There is one refutation that would have been inexpensive, and it matters beyond the rank. The image consists of invariant sextics vanishing on **all** of $V(K)$, the common zero locus of the cubics of $K$, which contains the orbit cone and could be larger. A point $u\in V(K)$ off the orbit cone would lower the bound below 13, and if $F_5(u)\neq0$ it would kill the certificate route outright, since $F_5$ could not then lie in the image.

The test is exact in principle and cheap in practice: $u\in V(K)$ exactly when $u^3\in C$, that is when $\rho(u)=\lVert P_Cu^3\rVert^2/\lVert u^3\rVert^2$ equals 1. [orbit_cubic_span.py](../scripts/reviewers/r203/orbit_cubic_span.py) builds $C$ from 3700 sampled orbit points in double precision:

```
(1) spectrum of the orbit Gram <g_i W_0, g_j W_0>^3:
    ev[3569] =  6.509526e-06
    ev[3570] =  1.863287e-15
    ev[3569]/ev[3570] = 3.494e+09   <- the gap sits at 3570
    record's dim C = 3570 (sum of d_lam over the 16 lambda_2-even blocks): True
```

That is an independent confirmation over $\mathbb R$, with a nine-order gap, of the 3570 the record established mod 46337, the number on which every one of the sixteen evaluation ranks, the 25 multiplicities and the 36 unknowns rest.

The screen itself: $\rho=1$ on fresh orbit points and at $-W_0$, $\rho\approx0.43$–$0.53$ at random points, and twelve projected-gradient ascents on $\rho$ from random starts all reach $\rho=1$, **at points whose $\Lambda^2$-spectrum matches that of $W_0$ to $10^{-8}$, that is, on the orbit**. No point of $V(K)$ beyond the orbit cone was found. This is a screen and not a proof: it says the obvious refutation is absent, and it leaves 13 versus 12 undecided.

A by-product worth recording: $\Delta$ appears to vanish exactly on the orbit cone, so the image of the certificate map already contains a psd invariant sextic with the zero set $F_5$ is conjectured to have. Testing whether $F_5$ is proportional to $\Delta$, which would *be* the certificate, since $\Delta$ is a sum of squares of cubics of $K$ by construction, is one line, and the ratio is not constant: $F_5/\Delta$ ranges over $[2.50,3.15]$ across twelve random unit points. It stays bounded and positive there, which makes $F_5-\lambda\Delta$ with $\lambda$ near $2.5$ the natural recentring for any search over the 36.

---

## Claim 6, the post-orbit counts, recomputed from the weights

[blocks_and_unknowns.py](../scripts/reviewers/r203/blocks_and_unknowns.py) takes only the 24 highest weights and their multiplicities and recomputes everything else from the Weyl dimension formula for $B_2$:

```
  Weyl dimension formula reproduces all 24 recorded dimensions: True
  sum m_lam d_lam = 7770   (dim Sym^3(35) = 7770: True)
  blocks 24, sum m = 41, sum m(m+1)/2 = 65, sum m(m-1)/2 = 24, sum m^2 = 89
  distinct degree-2 Casimir values: 21; collisions: [[(4,3),(5,0)], [(4,1),(3,3)], [(6,2),(5,4)]]
  even blocks: 16, sum of dims = 3570
  sum of multiplicities over even blocks = 29
  post-orbit multiplicities sum = 25
  post-orbit unknowns = sum m^K(m^K+1)/2 = 36
  shape: {3: 2, 2: 5, 1: 9}
  blocks that die outright: [(0,0),(1,0),(5,0),(5,4),(6,0),(6,2),(6,4),(6,6)]
  surviving Casimir collisions: [[(4,1),(3,3)]]
```

Every number of claim 6 is confirmed, together with the eight block deaths, the 21 Casimir values and the single surviving collision. The reconstruction $36+29=65$ links it to claim 3.

---

## What I would change

1. **Replace the two vacuous asserts in [run_n5_order2.py](../scripts/runs/run_n5_order2.py)** with `pi(S^m) == (tr(S^{m+1})/6) * S`, which is the check the file's prose already describes and which fires on any corruption of $S$. The exact projection needed is 20 lines and is in [stab_fixed_space.py](../scripts/reviewers/r203/stab_fixed_space.py).
2. **State claim 1 in the form that is true**: $H$-invariant, any degree, $\lvert W_0\rvert^2\neq0$. The narrower statement invites exactly the three questions the brief asked.
3. **Say that 13 comes from order 1**, and that order 2 is the proof that 13 cannot be improved by asking for more vanishing at the point.
4. **Condition "family $\geq23$" on the certificate existing**, and update [findings/sym3-blocks.md](../findings/sym3-blocks.md), which still asserts the retracted "$F_5$ lies in the image" and still carries $[1,14]$ and $[22,35]$.
5. **Record $\mathrm{rank}\geq1$ as a derivation** via $\Delta=\sum_aq_a^2$, replacing the retracted assumption.
6. **The open task is $\dim\{F:\mathrm{Cat}_F(K,K)=0\}$**, not "the rank of $A$ on the restricted space" in the abstract. Written that way it is 52 linear conditions on a 14-dimensional space, with one solution known and the question being whether there is a second.
