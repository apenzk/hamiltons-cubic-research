# Adjudication brief, round L64-r2, step H4

**Cold brief. The passages are quoted verbatim with their source lines.**

## The step

From Passage A's setting, "$k_B(d)$ is that module's presentation degree, in the sense of Definition 2.7", and part 2's hypothesis.

**The step: $k_B(d)$ is defined by the setting for every $d\ge1$, and part 2's hypothesis "$n\ge n_0\ge k_B(d)$" has a definite meaning as written, at every $d\ge1$.**



## Passage A, the heading, setting, lemma, proof and scope ([findings/fence-posts.md](../findings/fence-posts.md) lines 227 and 231-248)

#### Lemma L64, the transfer mechanism

**Setting.** Fix a degree $d\ge1$. Zero-padding embeds $\mathcal W_{n_0}$ isometrically in $\mathcal W_n$ and makes $\{\mathrm{Sym}^d\mathcal W_n^*\}$ a module over the base $\{\mathbb R^n\}$ with the group sequence $\{B_n\}$ of signed permutations. **$k_B(d)$ is that module's presentation degree**, in the sense of Definition 2.7 of [Levin–Chandrasekaran](../references/levin-chandrasekaran-dimension-free/notes.md), and $g(d)\le k_B(d)$ is its generation degree.

**Lemma.** Let $F$ be an $O(n_0)$-invariant form of degree $d$ on $\mathcal W_{n_0}$.

1. **Existence.** For every $n\ge n_0$, $F$ has an $O(n)$-invariant extension to $\mathcal W_n$, a form restricting to $F$ on the padded copy. No hypothesis on $n_0$ enters.
2. **Uniqueness.** When $n\ge n_0\ge k_B(d)$, $F$ has exactly one $B_n$-invariant extension, which is therefore the $O(n)$-invariant extension of part 1.

The same holds with $SO$ in place of $O$, because $B_{n_0}$ contains the reflection $\mathrm{diag}(-1,1,\dots,1)$: an $SO(n_0)$-invariant form with a $B_n$-invariant extension is $O(n_0)$-invariant.

**Proof.** (i) Let $\pi_{n_0}$ be the $O(n_0)$-equivariant orthogonal projection of $(\mathbb R^{n_0})^{\otimes4}$ onto $\mathcal W_{n_0}$. The polarisation of $F\circ\pi_{n_0}$ is an $O(n_0)$-invariant multilinear form on $(\mathbb R^{n_0})^{\otimes4d}$, and the first fundamental theorem for $O(n_0)$ writes it as a combination of complete contractions along perfect matchings $\pi$ of the $4d$ slots. On $\mathcal W_{n_0}$ this reads $F=\sum_\pi a_\pi C^{(n_0)}_\pi$, where $C^{(m)}_\pi(W)$ contracts $W^{\otimes d}$ along $\pi$ with every index summed over $[m]$. (ii) Set $G=\sum_\pi a_\pi C^{(n)}_\pi$ on $\mathcal W_n$. Each $C^{(n)}_\pi$ is $O(n)$-invariant. Every summation index sits on a slot of a Weyl factor, so no closed $\delta$-loop occurs, and on a padded tensor every term carrying an index above $n_0$ vanishes. Hence $G$ restricts to $F$, which is part 1. (iii) For $n\ge n_0\ge k_B(d)$, Proposition 2.9 makes restriction from the $B_n$-invariants of $\mathrm{Sym}^d\mathcal W_n^*$ to the $B_{n_0}$-invariants of $\mathrm{Sym}^d\mathcal W_{n_0}^*$ injective. $G$ is $B_n$-invariant and restricts to $F$, so it is the only $B_n$-invariant extension, which is part 2. $\square$

**The hypothesis of part 2 has no established instance, and at $n_0=12$ the degree-$6$ certificate lies outside its range.**

- **$k_B(d)\ge g(d)\ge4d$.** Let $T\in\mathcal W_4$ have $T_{1234}=1$, $T_{1342}=-1$, $T_{1423}=0$, with their curvature-symmetry images and every other component zero. Its Bianchi sum is $1-1+0=0$, and it is traceless because every Ricci component carries a repeated index. The product of $d$ copies of $T$ on the disjoint blocks $\{4k-3,\dots,4k\}$ of $[4d]$ has a nonzero component at a multi-index with $4d$ distinct values. A signed permutation maps a support of size $m$ to a support of size $m$, so for $m<4d$ no combination of translates of padded elements of $\mathrm{Sym}^d\mathcal W_m$ has such a component. **So $k_B(6)\ge24>12$.**
- **No finite $k_B(d)$ is on file for any $d\ge1$.** Post F32 records that Theorem 2.11's kernel and sums clauses do not apply to $\{\mathcal W_n\}$.
- **Below the range, uniqueness fails.** $\mathcal W_3=0$, so at $n_0=3$ and $d=2$ both $0$ and $\lvert W\rvert^2$ extend $F=0$.

**The lemma transfers an element and its invariance, and it carries a sign only on the padded copy.** The same mechanism on the module $\{\mathrm{Sym}^2S^n\}$ of quadratic forms on symmetric matrices, presented in degree $4$ by Levin–Chandrasekaran's Example 2.12 and Theorem 2.11, takes $F(X)=\operatorname{tr}X^2-\tfrac14(\operatorname{tr}X)^2=\operatorname{tr}\big((X-\tfrac14\operatorname{tr}X\,I_4)^2\big)\ge0$ on $S^4$ to $G(X)=\operatorname{tr}X^2-\tfrac14(\operatorname{tr}X)^2$ on $S^5$, where $G(I_5)=5-\tfrac{25}4=-\tfrac54$. **Carrying a nonnegativity certificate from $n_0$ to $n$ needs an argument of its own, and none is on file.** Post F31, above, is the instance at the balanced sphere product.

## Passage B, the canonical statement ([results.md](../results.md) line 227, landscape, and lines 794 and 796, detail)

- **Lemma L64 (direct). The transfer mechanism.** An $O(n_0)$-invariant form of degree $d$ on $\mathcal W_{n_0}$ has an $O(n)$-invariant extension to $\mathcal W_n$ at every $n\ge n_0$. When $n_0\ge k_B(d)$, the presentation degree of $\{\mathrm{Sym}^d\mathcal W_n^*\}$ over the signed permutation groups $\{B_n\}$, that extension is the unique $B_n$-invariant one. $k_B(d)\ge4d$, no finite value is on file, and the extension carries a sign only on the padded copy.

##### Lemma L64, the transfer mechanism

Fix $d\ge1$, and let $k_B(d)$ be the presentation degree of the module $\{\mathrm{Sym}^d\mathcal W_n^*\}$ over the base $\{\mathbb R^n\}$ with the signed permutation groups $\{B_n\}$, zero-padding giving the embeddings. Let $F$ be an $O(n_0)$-invariant form of degree $d$ on $\mathcal W_{n_0}$. Then for every $n\ge n_0$, $F$ has an $O(n)$-invariant extension to $\mathcal W_n$, and when $n\ge n_0\ge k_B(d)$ it is the unique $B_n$-invariant extension. The same holds with $SO$ in place of $O$. The first fundamental theorem writes $F$ as a combination of complete contractions, each of which restricts correctly under padding because every slot sits on a Weyl factor, and Proposition 2.9 gives uniqueness. **The hypothesis has no established instance**: $k_B(d)\ge4d$, so $k_B(6)\ge24$ and the lemma does not reach the degree-$6$ certificate at $n_0=12$, and no finite $k_B(d)$ is on file. **The extension carries an element and its invariance, and a sign only on the padded copy**, so transferring a nonnegativity certificate needs an argument of its own.

## Passage C, post F32 in the same file, the two paragraphs Passage A draws on ([findings/fence-posts.md](../findings/fence-posts.md) lines 217 and 221)

The transfer mechanism is Lemma L64, below: an $O(n_0)$-invariant form of degree $d$ has an $O(n)$-invariant extension at every $n\ge n_0$, and it is the unique $B_n$-invariant extension once $n_0\ge k_B(d)$. **Equivariance was never the obstruction.** The hypothesis is.

**And Theorem 2.11's calculus yields no $k_B$ here at all**: its kernel clause needs the adjoint to be a morphism, equivalent to $\mathrm{Ric}$ commuting with **truncation**, which it does not; its sums clause needs the Ricci part padding-closed, which holds only for $h\propto I$, and the round sphere is exactly that exception, so testing with $S^{n_0}$ shows the opposite of the truth.

## Passage D, the imported source, Levin and Chandrasekaran

The paper is [paper.pdf](https://arxiv.org/abs/2307.04230), with its text extraction [txt.txt](https://arxiv.org/abs/2307.04230). **Read the PDF where the extraction garbles a subscript**, and read nothing else in that folder. The extraction's own lines, verbatim:

```text
Definition 1.3 (Consistent sequences [16]). Fix a family of compact1 groups G = {Gn }n∈N such that
Gn ⊆ Gn+1 . A consistent sequence of G -representations is a sequence V = {(Vn , φn )}n∈N satisfying the
following properties:
  (a) Vn is an orthogonal Gn -representation;
  (b) φn : Vn ,→ Vn+1 is a linear Gn -equivariant isometry.
Unless we want to emphasize the embeddings φn , we shall identify Vn with its image inside Vn+1 . We then
write V = {Vn } and take φn to be inclusions Vn ⊆ Vn+1 .2

    As φn is an isometry, its adjoint φ∗n defines the orthogonal projection PVn of higher-dimensional spaces
onto lower-dimensional ones. We now formally define dimension-free vectors or linear maps as sequences of
invariants projecting onto each other.

Definition 1.4 (Freely-described elements). A freely-described element in a consistent sequence {(Vn , φn )}
of {Gn }-representations is a sequence {vn ∈ VGnn } of invariants satisfying φ∗n (vn+1 ) = vn for all n.

    Importantly, the set of freely-described elements in a given consistent sequence V is naturally a linear
space,3 because if {vn } and {vn′ } are freely-described elements then so is {αvn + βvn′ } for any α, β ∈ R.
Furthermore, fundamental results in representation stability imply that these spaces of freely-described
elements are often finite-dimensional. More precisely, when the consistent sequence V is finitely-generated,
                                         Gn+1
the restricted projections PVn |VGn+1 : Vn+1  → VGnn become isomorphisms for all n exceeding the presentation
                                   n+1
degree of the sequence, see Section 2 for precise definitions.
     Definition 1.4 also defines freely-described linear maps. Indeed, if V = {(Vn , φn )} and U = {(Un , ψn )}
are consistent sequences of {Gn }-representations, then the sequence of spaces of linear maps between them
can be naturally identified with {(Vn ⊗ Un , φn ⊗ ψn )} where ⊗ is the tensor (or Kronecker) product, and this
is also a consistent sequence. A freely-described element of V ⊗ U is a sequence of equivariant maps {An ∈
L(Vn , Un )Gn } satisfying ψn∗ An+1 φn = An . When φn , ψn are inclusions, this simplifies to PUn An+1 |Vn = An
where PUn is orthogonal projection onto Un . From results in representation stability, it follows that for
a large class of consistent sequences, the sequence V ⊗ U is finitely-generated when V , U are, and the
presentation degree of the former can be bounded in terms of those of the latter; see Theorem 2.11. Thus,
the space of freely-described linear maps is often finite-dimensional as well.

Example 1.5 (Vectors with zero-padding). Let Vn = Rn with the standard inner product, and let φn (x) =
[x⊤ , 0]⊤ correspond to padding a vector with a zero. This is a consistent sequence for many standard sequences
{Gn } of groups, including the groups of n × n orthogonal matrices, and (signed) permutation matrices. Here
Gn is embedded in Gn+1 by sending g ∈ Gn represented as an n × n matrix to blkdiag(g, 1). For each of
these sequences of groups, we get a consistent sequence V = {(Vn , φn )}. When Gn = Sn is the group of
   1
     Our theory can be extended to reductive groups.
   2
     Formally, we obtain such inclusions inside the direct limit of the sequence.
   3
     Formally, the space of freely-described elements is the inverse limit limn VGnn .
                                                                           ←−

                                                            5
permutations on n letters, the space of freely-described elements in V is one-dimensional and consists of
sequences {α1n } for α ∈ R. The space of freely-described linear maps from Vn to itself is two-dimensional,
and consists of sequences {α1 1n 1⊤                    2
                                  n + α2 In } for α ∈ R .
[...]
Definition 2.1 (Morphisms of sequences). If V = {(Vn , φn )} and U = {(Un , ψn )} are two consistent
sequences of {Gn }-representations, then a morphism of consistent sequences A : V → U is a collection of
linear maps A = {An : Vn → Un } such that the following hold for each n:
  (a) An is Gn -equivariant;
  (b) An+1 φn = ψn An .

    If φn and ψn are inclusions, condition (b) above becomes An+1 |Vn = An . Note that morphisms are
freely-described elements (as in Definition 1.4) of V ⊗ U , but the converse may not hold. Morphisms of
sequences have appeared in the representation stability literature as the natural notion of maps between
sequences, see [49, Def. 2.1.1] and [50, §3.2].

2.1    Generation Degree
To relate invariants and equivariants across dimensions, we need canonical isomorphisms between spaces
of invariants in a consistent sequence. Proposition 2.3 below shows that the projections PVn are such
isomorphisms, using the following parameter introduced in [49] to control the complexity of a consistent
sequence.

Definition 2.2 (Generation degree). A consistent sequence V = {Vn } of {Gn }-representations is generated
in degree d if R[Gn ]Vd = Vn for all n ≥ d. The smallest d for which this holds is called the generation
degree of the sequence. A subset S ⊆ Vd is called a set of generators for V if R[Gn ]S = Vn for all n ≥ d.
A sequence is finitely-generated if it is generated in degree d for some d < ∞.

     Note that R[Gn ]S = span{gx}g∈Gn ,x∈S , so that V is generated in degree d if the span of the Gn -orbit of
Vd , when embedded in Vn , is all of Vn for any n ≥ d. Note also that if V is generated in degree d then Vd
is a set of generators for V .

Proposition 2.3. Suppose V = {(Vn , φn )} is a consistent sequence of {Gn }-representations generated in
                                                                 Gn+1
degree d. Then the restrictions of the projections φ∗n |VGn+1 : Vn+1  → VGnn to spaces of invariants are injective
                                                        n+1
for all n ≥ d, and are therefore isomorphisms for all large enough n.

Proof. First, the map φ∗n is Gn -equivariant because Gn acts orthogonally and Gn ⊆ Gn+1 , so it maps Gn+1 -
                                                                                           Gn+1
invariants in Vn+1 to Gn -invariants
                            P          in Vn . Second, suppose φ∗n (v) = 0 for some v ∈ Vn+1    with n ≥ d. For
any u ∈ Vn+1 , write u = i gi φn (ui ) where ui ∈ Vn and gi ∈ Gn+1 . Because v is Gn+1 -invariant, we have
                                                                                                           Gn+1
⟨v, u⟩ = ⟨φ∗n (v), i ui ⟩ = 0. As u ∈ Vn+1 was arbitrary, we conclude that v = 0. Thus, φ∗n maps Vn+1
                  P
                                                   G
injectively into VGnn , so that dim VGnn ≥ dim Vn+1  n+1
                                                         , for all n ≥ d. Therefore, the sequence of dimensions
       Gn                                         ∗
dim Vn eventually stabilizes, at which point φn becomes an isomorphism.

    Note that φ∗n = PVn is precisely the orthogonal projection onto Vn . Proposition 2.3 is stated in the repre-
sentation stability literature in terms of the adjoints of the projections, viewed as maps between coinvariants,
see [49, §3] for example.

2.2    Presentation Degree
While boundedness of the generation degree of a consistent sequence ensures that the projections eventually
become isomorphisms, providing a precise quantification of this phenomenon requires a more sophisticated
concept, namely the presentation degree. We describe this concept after giving some preliminary definitions.
Our presentation here is brief, and we refer the reader to Appendix B for a more detailed derivation of these
notions motivated by our computational considerations.

Definition 2.4 (Centralizing subgroups). Let V = {Vn } be a consistent sequence of {Gn }-representations.
For any d ≤ n, define the centralizing subgroups of Vd by

                                  Hn,d = {g ∈ Gn : g · v = v for all v ∈ Vd }.


                                                       15
     Note that the subgroup generated by Gd and Hn,d inside Gn is the set of products Gd Hn,d = {gh : g ∈
Gd , h ∈ Hn,d } since ghg −1 ∈ Hn,d for all g ∈ Gd and h ∈ Hn,d .
Definition 2.5 (V -modules). Let V = {Vn } and U = {Un } be consistent sequences of {Gn }-representations,
and let {Hn,d }d≤n be the centralizing subgroups of V as in Definition 2.4. We say that U is a V -module if
        H
Ud ⊆ Un n,d for all d ≤ n.
Definition 2.6 (Induction and algebraically free5 sequences). Let V be a consistent sequence of {Gn }-
representations, and for d ≤ n let Hn,d ⊆ Gn be its centralizing subgroups.
  (a) Fix d ∈ N and a Gd -representation W on which Hd,d acts trivially. For each n ≥ d, we view W as
      a Gd Hn,d -representation on which Hn,d acts trivially. The associated V -induction sequence is defined
      as:                                               n            o
                                          IndGd (W) = IndGGnd Hn,d W ,
                                                                               n
         where the induced representation is taken to be 0 when n < d. This is a V -module.
  (b) A consistent sequence F is an algebraically free V -module if it is a direct sum of V -induction se-
      quences. The sequence V itself is algebraically free if it is an algebraically free V -module.
Definition 2.7 (Relation and presentation degrees). Let V be a consistent sequence of {Gn }-representations.
We say that a V -module U is generated in degree d, related in degree r, and presented in degree k =
max{d, r} if there exists an algebraically free V -module F generated in degree d, and a surjective morphism
of sequences F → U whose kernel is generated in degree r. The smallest k for which this holds is called the
presentation degree of U .
       Note that the presentation degree is at least as large as the generation degree (cf. Definition 2.2).
Example 2.8. Let Vn = Rn with embeddings by zero-padding as in Example 1.5. Recall that this is a
consistent sequence for each of the sequences of groups Gn = On , Bn , Dn , Sn acting by their standard n × n
matrix representations. Here Hn,d is the subgroup of n × n orthogonal or signed permutation matrices fixing
the first d coordinates.
    This sequence is generated in degree 1 for all the groups listed above. Indeed, any of the canonical basis
vectors ei are obtained from the first one e1 via the action of Sn .
    If Gn = Bn or Sn then this sequence is algebraically free and hence presented in degree 1 as well,
while if Gn = Dn then it is not free but presented in degree 2. Indeed, we have |Dn /D1 Hn,1 | = 2n
when n ≥ 2 with coset representatives (1, i)sp for p ∈ {0, 1}, i ∈ [n] where s = diag(−1, −1, 1 . . . , 1).
Hence (Ind) yields IndD               n    n
                         D1 Hn,1 R = R ⊕ R on which σ ∈ Sn ⊆ Dn acts by σ(x, y) = (σx, σy) and s(x, y) =
                          n


([y1 , y2 , x3 , . . . , xn ]⊤ , [x1 , x2 , y3 , . . . , yn ]⊤ ). We have equivariant linear maps IndD
                                                                                                     D1 Hn,1 R → R
                                                                                                       n          n
                                                                                                                    sending
(x, y) 7→ x − y giving a morphism of sequences IndD1 R → {Rn } with kernel generated in degree 2.
    The presentation degree enables us to strengthen Proposition 2.3 and to quantify more precisely when
the projections there become isomorphisms.
Proposition 2.9. Let V be a consistent sequence of {Gn }-representations and U be a V -module presented
                                  Gn+1
in degree k. Then the maps PUn : Un+1  → UGnn are isomorphisms for all n ≥ k.
[...]
Theorem 2.11 (Calculus for generation and presentation degrees). Let V be a consistent sequence of {Gn }-
representations and let W , U be V -modules generated in degrees dW , dU and presented in degrees kW , kU ,
respectively. Then
      (Sums) W ⊕ U is generated in degree max{dW , dU } and presented in degree max{kW , kU }.
      (Images and kernels) If A : W → U is a morphism consisting of linear maps A = {An ∈ L(Wn , Un )Gn },
       and if the sequence of their adjoints A ∗ = {A∗n ∈ L(Un , Wn )Gn } is a morphism U → W , then imA
       and ker A are generated in degree dW and presented in degree kW .
If V = {Rn } with Gn = Bn , Dn , or Sn as in Example 1.5, we further have
      (Tensors) W ⊗ U is generated in degree dW + dU and presented in degree max{kW + dU , kU + dW }.
                           Vℓ
      (Sym and ) Symℓ W ,     W are generated in degree ℓdW and presented in degree (ℓ − 1)dW + kW .
                V

Proof. This follows from Theorem A.13 in the appendix.

Example 2.12. Suppose {Rn } as in Example 1.5 with Gn = Bn , Dn , or Sn . Then (Rn )⊗k consists of
n × · · · × n-sized tensors with embeddings by zero padding and Symk Rn consists of homogeneous polynomials
of degree k in n variables. These are generated in degree k and presented in degree k if Gn = Bn , Sn and in
degree k + 1 if Gn = Dn .
```

## Definitions

- $\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$: 4-tensors with the curvature symmetries $W_{ijkl}=-W_{jikl}=-W_{ijlk}=W_{klij}$, the first Bianchi identity $W_{ijkl}+W_{iklj}+W_{iljk}=0$, and every Ricci contraction zero, with the Frobenius inner product. $\mathcal W_n=0$ for $n\le3$.
- $O(n)$, and its subgroups $SO(n)$ and the signed permutation group $B_n$, act on $\mathcal W_n$ by $(g\cdot W)_{ijkl}=g_{ia}g_{jb}g_{kc}g_{ld}W_{abcd}$. Zero-padding sends $W\in\mathcal W_{n_0}$ to the tensor on $\mathbb R^n$ with the same components on indices in $[n_0]$ and zero elsewhere.
- $\mathrm{Sym}^d\mathcal W_n^*$ is the space of homogeneous polynomials of degree $d$ on $\mathcal W_n$. $S^n$ is the space of real symmetric $n\times n$ matrices.
- **This loop does no numerical work.** A claim supported only by a run is `HYPOTHESIS-DEBT`. Screening a claim by hand on an object you construct is allowed, and is reported as a screen, never as evidence for a positive claim.

## The question

**Prove the step above valid as written, from the passages, the imported source and standard mathematics, or exhibit in closed form exactly where it fails.** Give the strongest reading the words support, including a hypothesis the author may have meant but not written, and say which hypotheses that reading needs. Return a verdict of VALID or FAILS, with the argument.
