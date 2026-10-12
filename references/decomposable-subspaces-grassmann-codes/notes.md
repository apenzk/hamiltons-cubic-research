# Ghorpade–Patil–Pillai, the structure theorem, transcribed

**S. R. Ghorpade, A. R. Patil and H. K. Pillai, *Decomposable subspaces, linear sections of Grassmann varieties, and higher weights of Grassmann codes*, [arXiv:0710.5161](https://arxiv.org/abs/0710.5161).** Page numbers are those of the extraction.

## The definitions (p. 4)

*A subspace $E\subseteq\Lambda^\ell V$ is called **decomposable** when every element of $E$ is decomposable.* For $\omega\in\Lambda^\ell V$ write $V_\omega$ for its support, and for a subspace $E$ set $V_E=\bigcap_{\omega\in E}V_\omega$ and $V^E=\sum_{0\ne\omega\in E}V_\omega$.

> Now, let $r=\dim E$. We say that the subspace $E$ is **close of type I** if there are $\ell+r-1$ linearly independent elements $f_1,\dots,f_{\ell-1},g_1,\dots,g_r$ in $V$ such that $E=\mathrm{span}\{f_1\wedge\cdots\wedge f_{\ell-1}\wedge g_i:i=1,\dots,r\}$. And we say that $E$ is **close of type II** if there are $\ell+1$ linearly independent elements $u_1,\dots,u_{\ell-r+1},g_1,\dots,g_r$ in $V$ such that $E=\mathrm{span}\{u_1\wedge\cdots\wedge u_{\ell-r+1}\wedge g_1\cdots\wedge\check g_i\wedge\cdots\wedge g_r:i=1,\dots,r\}$, where $\check g_i$ indicates that $g_i$ is deleted.

> Evidently, every one-dimensional subspace of $\Lambda^\ell V$ is close of type I as well as of type II, whereas for two-dimensional subspaces, the notions of close subspaces of type I and type II are identical. A corollary of the following lemma is that in dimensions three or more, the two notions are distinct and mutually disjoint.

## Lemma 5 (p. 4)

> Let $E$ be a close subspace of $\Lambda^\ell V$ of dimension $r$. Then $E$ is decomposable. Moreover, if $\{\omega_1,\dots,\omega_r\}$ is a basis of $E$, then $V_E=V_{\omega_1}\cap\cdots\cap V_{\omega_r}$ and $V^E=V_{\omega_1}+\cdots+V_{\omega_r}$. Further, assuming $r>1$, we have $\dim V_E=\ell-1$ and $\dim V^E=\ell+r-1$ if $E$ is close of type I, whereas $\dim V_E=\ell-r+1$ and $\dim V^E=\ell+1$ if $E$ is close of type II.

## Theorem 6, the Structure Theorem (p. 5)

> **Theorem 6 (Structure Theorem for Decomposable Subspaces).** A subspace of $\Lambda^\ell V$ is decomposable if and only if it is close.

*The proof inducts on $r=\dim E$, the cases $r=1,2$ from Lemmas 1 and 3, the case $r=3$ splitting on whether $\dim(V_1\cap V_2\cap V_3)$ is $\ell-1$ (type I) or $\ell-2$ (type II), and $r>3$ by induction through the codimension-one subspaces $E_i$.* **Provenance, in the paper's own words**: the low-dimensional statements are classical, cited to Marcus Theorem 1.1 and to reference [2, p. 650], while *"as far as we know, Theorem 6 is new."*

## What it says at $\ell=2$, which is the case this record needs

**Type I becomes a PENCIL**: with $\ell=2$ there is a single $f_1$, so $E=f_1\wedge\mathrm{span}\{g_1,\dots,g_r\}$, of any dimension $r$, and $\dim V_E=1$, the shared line.

**Type II becomes $\Lambda^2$ OF A THREE-SPACE**: with $\ell=2$ the $u$'s number $3-r$, so $r\le3$, and at $r=3$ there are none, leaving $E=\mathrm{span}\{g_2\wedge g_3,\,g_1\wedge g_3,\,g_1\wedge g_2\}=\Lambda^2\mathrm{span}\{g_1,g_2,g_3\}$, with $\dim V^E=3$.

> **So: a subspace of $\Lambda^2V$ every element of which is decomposable is a pencil $f\wedge U$ or $\Lambda^2U$ with $\dim U=3$, and nothing else.** *That is the classical $\alpha$/$\beta$ dichotomy for linear subspaces of the Grassmann cone over $G(2,n)$, here as a theorem with a proof rather than as folklore.*

## The scope limit, which is what the record must carry beside it

**Decomposable subspace means EVERY element decomposable.** *A subspace carrying a decomposable BASIS is strictly weaker: $\mathrm{span}\{e_1\wedge e_2,e_3\wedge e_4\}$ has the decomposable basis $\{e_1\wedge e_2,e_3\wedge e_4\}$ while $\cos t\,e_1\wedge e_2+\sin t\,e_3\wedge e_4$ has $\mathrm{Pf}=\cos t\sin t\ne0$ off the axes.* **So Theorem 6 classifies the strong condition, and [I36b](../../plan.md) needs the weak one.**
