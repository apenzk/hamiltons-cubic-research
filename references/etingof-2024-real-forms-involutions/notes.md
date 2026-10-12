# Notes, Etingof, MIT 18.755 Lecture 15 (read in full; 7 printed pages)

Stored 2026-09-07. [etingof-18755-lec15.pdf](https://ocw.mit.edu/courses/18-755-lie-groups-and-lie-algebras-ii-spring-2024/mit18_755_s24_lec15.pdf), [etingof-18755-lec15.txt](https://ocw.mit.edu/courses/18-755-lie-groups-and-lie-algebras-ii-spring-2024/mit18_755_s24_lec15.pdf) (`pdftotext -layout`). The extraction is clean throughout.

## The equivalence relation, stated (Theorem 41.5, p. 221)

> "**Theorem 41.5.** Real forms of $\mathfrak g$ are in bijection with conjugacy classes of involutions $\theta\in\mathrm{Aut}(\mathfrak g_c)$, via $\theta\mapsto\omega_\theta:=\theta\circ\omega=\omega\circ\theta$."

$\mathfrak g_c$ is the compact form and $\omega$ its compact antilinear involution (p. 219). The proof preceding the statement shows that two elements $\theta,\theta'$ give the same real form exactly when $\theta'=y\theta y^{-1}$ for some $y\in\mathrm{Aut}(\mathfrak g_c)$, so *the conjugating group in the classification is the full automorphism group, not the connected one.* This is the sentence the record's $\mathrm{Aut}$-versus-$SO(n)$ caveat is about, and it can now be cited.

The following paragraph gives the induced decomposition: *"we have a canonical (up to automorphisms of $\mathfrak g_c$) decomposition $\mathfrak g=\mathfrak k\oplus\mathfrak p$, into the eigenspaces of $\theta$ with eigenvalues $1$ and $-1$, such that $\mathfrak k$ is a Lie subalgebra, $\mathfrak p$ is a module over $\mathfrak k$ and $[\mathfrak p,\mathfrak p]\subset\mathfrak k$."*

## The $\mathfrak{so}$ involutions, verbatim (§41.4, pp. 223–224)

**Type $B_n$, item 3, p. 223:**

> "Then $\theta$ is an inner automorphism, given by an element of order $\le2$ in $SO(2n+1)$. So $\theta=\mathrm{Id}_{2p+1}\oplus(-\mathrm{Id}_{2q})$ where $p+q=n$. Thus all the real forms are $\mathfrak{so}(2p+1,2q)$ (all distinct), $\mathfrak k=\mathfrak{so}_{2p+1}\oplus\mathfrak{so}_{2q}$."

**Type $D_n$, compact inner class, item 5, p. 223:**

> "We again have an inner automorphism $\theta$ given by $g\in SO(2n)$ such that $g^2=\pm1$. If $g^2=1$ then $\mathbb C^{2n}=V(1)\oplus V(-1)$, the direct sum of eigenspaces, and since $\det(g)=1$, the eigenspaces are even-dimensional, of dimensions $2p$ and $2q$ where $p+q=n$, and, as in the case of type $C_n$, we may assume $p\ge q$. So the corresponding real form is $\mathfrak g_\theta=\mathfrak{so}(2p,2q)$ with $\mathfrak k=\mathfrak{so}_{2p}\oplus\mathfrak{so}_{2q}$. On the other hand, if $g^2=-1$ then we have $\mathbb C^{2n}=V(i)\oplus V(-i)$, and these are Lagrangian subspaces of dimension $n$. So $\mathfrak k=\mathfrak{gl}_n(\mathbb C)$. The corresponding real form is the quaternionic orthogonal Lie algebra … $\mathfrak g_\theta=\mathfrak{so}^*(2n)$."

**Type $D_n$, the other inner class, item 6, p. 224:**

> "In this case $\theta$ is given by an element $g$ of $O(2n)$ such that $\det(g)=-1$ and $g^2=\pm1$. Note that if $g^2=-1$ then, as shown above, $\det(g)=1$, so in the case at hand we always have $g^2=1$. Then $\mathbb C^{2n}=V(1)\oplus V(-1)$, but now the dimensions of these spaces are odd, $2p+1$ and $2q-1$ where $p+q=n$, and we may assume that $p+1\ge q$. So the real form is $\mathfrak g_\theta=\mathfrak{so}(2p+1,2q-1)$, with $\mathfrak k=\mathfrak{so}_{2p+1}\oplus\mathfrak{so}_{2q-1}$."

## What this settles for the record, and what it does not

**Settles.** Every involution of $\mathfrak{so}(N)$ is conjugation by an element of $O(N)$ (or, for $\mathfrak k=\mathfrak u(N/2)$, by an element with $g^2=-1$), and the fixed algebras are exactly $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ with $p+q=N$ and $\mathfrak u(N/2)$ at even $N$, fact 1, with the parity bookkeeping and the $\det g$ that produces each case made explicit. The determinant is the part [LEDGER.md](../../findings/LEDGER.md) reconstructed by hand: *the even-even split is realised by an element of $SO$ and is therefore inner; the odd-odd split needs $\det=-1$ and is not.*

**Does not settle.**

- **The compact form is not the object classified.** The theorem and §41.4 speak of real forms of the complex $\mathfrak g$ and of $\mathfrak k$ as a complex algebra ($\mathfrak k=\mathfrak{gl}_n(\mathbb C)$ rather than $\mathfrak u(n)$). The compact symmetric pair $(\mathfrak{so}(N),\mathfrak k)$ that the record's gradings are is the corresponding compact-form statement; the bridge is standard and is set up in the same lecture (p. 221), but is not written out. [holland-ion-2012-symmetric-spaces](../holland-ion-2012-symmetric-spaces/) states the compact form directly.
- **$D_4$ is not separated.** Items 5 and 6 exhaust the involutions of $\mathfrak{so}(2n)$ by elements of $O(2n)$, uniformly in $n$. Since $\mathrm{Aut}(\mathfrak{so}(8))/\mathrm{Int}$ is $S_3$ rather than $\mathbb Z_2$ ([ziller-2010-lie-groups-symmetric-spaces](../ziller-2010-lie-groups-symmetric-spaces/) Example 4.45, [yokota-2009-exceptional-lie-groups](../yokota-2009-exceptional-lie-groups/) Theorem 1.3.5), **this enumeration cannot be quoted at $n=8$ as an enumeration up to $\mathrm{Aut}$-conjugacy**; what it enumerates there is the $O(8)$-classes. That is the more useful relation for the record's purposes and the less useful one for reading the classification, and the source does not flag the difference.
- **Exceptional algebras are absent.** §41.4 is titled "Real forms of classical Lie algebras" and closes with Exercise 41.10; $\mathfrak g_2$, $\mathfrak f_4$ and the $\mathfrak e$ series are not treated in this lecture.
