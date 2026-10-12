# Reeder–Levy–Yu–Gross 2013, Gradings of positive rank on simple Lie algebras

Transcribed from [reeder-1307.5765.txt](https://arxiv.org/pdf/1307.5765) (`pdftotext -layout`, 3562 lines); line references are to that dump. Read for [SP-3](../../plan.md), whether the $\mathbb Z_m$-gradings of a simple Lie algebra are classified, since a vertex of the $d=3$ pinned polytope is a partial grading ([DERIVE-sp3.md](../../reviews/DERIVE-sp3.md), [DERIVE-sp3b.md](../../reviews/DERIVE-sp3b.md)).

## The definition, verbatim (L64–L72)

> Let $\mathfrak g$ be the Lie algebra of a connected simple algebraic group $G$ of adjoint type over an algebraically closed field $k$. A grading on $\mathfrak g$ is a decomposition $\mathfrak g=\bigoplus_{i\in\mathbb Z/m}\mathfrak g_i$ where $m$ is an integer $\ge0$ and $[\mathfrak g_i,\mathfrak g_j]\subset\mathfrak g_{i+j}$ for all $i,j$. The summand $\mathfrak g_0$ is a Lie subalgebra of $\mathfrak g$ and we let $G_0$ denote the corresponding connected subgroup of $G$.

**This is exactly the object [DERIVE-sp3b.md](../../reviews/DERIVE-sp3b.md) needs**, and the record's eigenspace decomposition of a critical point is a candidate for it.

## Vinberg theory, the parts this programme uses (L86–L99)

> A Cartan subspace is a linear subspace $\mathfrak c\subset\mathfrak g_1$ which is abelian as a Lie algebra, consists of semisimple elements, and is maximal with these two properties. All Cartan subspaces are conjugate under $G_0$. Hence the dimension of $\mathfrak c$ is an invariant of the grading, called the rank … The little Weyl group is the subgroup $W_{\mathfrak c}$ of $GL(\mathfrak c)$ arising from the action of the normalizer of $\mathfrak c$ in $G_0$. The group $W_{\mathfrak c}$ is finite … and we have an isomorphism of invariant polynomial rings $k[\mathfrak g_1]^{G_0}\xrightarrow{\ \sim\ }k[\mathfrak c]^{W_{\mathfrak c}}$.

> We have a dichotomy: either the rank $r=0$, in which case $\mathfrak g_1$ consists entirely of nilpotent elements of $\mathfrak g$, or $r>0$, in which case $m>0$ and $\mathfrak g_1$ contains semisimple elements of $\mathfrak g$.

**Chronology of the theory, as the paper states it** (L74–L85): $m=1$ is Chevalley; $m=2$ is Kostant–Rallis [16]; **all $m\ge0$ is Vinberg [35]**, over $\mathbb C$, extended to good odd characteristic not dividing $m$ in Levy [19].

## THE POINT THAT MATTERS HERE: this paper does NOT cover $\mathfrak{so}(n)$

> The classification of positive-rank gradings and their little Weyl groups, along with verification of Popov's conjecture was given in [19] and [20] for gradings of Lie algebras of classical type and those of types $G_2$ and $F_4$. In this paper we complete this work by proving analogous results for types $E_6$, $E_7$ and $E_8$. (L127–L131)

**So for $\mathfrak{so}(n)$ the citation is Levy, not this paper.** [19] is P. Levy, *Vinberg's $\theta$-groups in positive characteristic and Kostant–Weierstrass slices*, Transform. Groups **14** no. 2 (2009), 417–461; [20] is Levy, *KW-sections for exceptional type Vinberg's $\theta$-groups*; [35] is E. B. Vinberg, *The Weyl group of a graded Lie algebra*, Izv. Akad. Nauk SSSR Ser. Mat. **40** no. 3. *A citation of this paper for a statement about $\mathfrak{so}(n)$ would be wrong, and that is the main thing this reading establishes.*

One remark it does make about type $D$ (L2984): *"It is known ([35], [19]) that all gradings on classical Lie algebras are saturated except for certain outer automorphisms of order divisible by $4$ in type $D_n$."* Order $3$ is not divisible by $4$, so the $\mathbb Z_3$-gradings of $\mathfrak{so}(2l)$ are saturated.

## The mechanism, for the record's own use

> The main idea is to compute Kac coordinates of lifts of automorphisms of the root system … To each $\vartheta\in\Theta$ one can associate an affine root system $\Psi=\Psi(R,\vartheta)$ … If $x$ lies in the closure $C$ of the fundamental alcove of $A$ then the affine coordinates of $x$ are those defined by Kac … we call these normalized Kac coordinates. (L132–L150)

## What the programme takes, and what it derived instead

**Taken**: that the classification exists, is finite, and is standard, enough to know the candidate three-eigenvalue multiplicity triples form a known list rather than a search space.

**Derived rather than transcribed**, because $\mathfrak{so}(n)$ needs none of the machinery: for $n\ne8$ every order-$3$ automorphism of $\mathfrak{so}(n)$ is inner, hence conjugation by an order-$3$ element of $SO(n)$, which splits $\mathbb R^n$ as a fixed space of dimension $p$ plus a complex space of complex dimension $q$ with $n=p+2q$; the centraliser is $SO(p)\times U(q)$, so $\dim\mathfrak g_0=\binom p2+q^2$ and $\dim\mathfrak g_1=\dim\mathfrak g_2$. See [DERIVE-sp3b.md](../../reviews/DERIVE-sp3b.md). **At $n=8$ triality supplies outer order-$3$ automorphisms and that derivation does not apply.**

## Verdict

**Confirms the classification exists and is finite; supplies no bound on $\theta$ and no statement about $\mathfrak{so}(n)$.** Its value to this programme is negative-going-on-useful: it says where the $\mathfrak{so}(n)$ statement actually lives (Levy [19], Vinberg [35]) so the record does not miscite this paper for it. **Owed if a Levy or Vinberg statement is ever cited as read**: those two sources filed with their own notes.
