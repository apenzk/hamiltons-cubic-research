"""Test a structural claim about Weyl tensors at RANDOM points, not just the catalogue.

WHY THIS EXISTS. Twice in one cycle a claimed structural identity was read off the
catalogue -- the sphere products, the CP^m family, padded W_CP2 -- and both times it was
false in general:

  * N_ik = sum_{mpq} W_impq W_kmpq was claimed to be a multiple of the identity. It is,
    at every S^k x S^k and (as it happens) for EVERY Weyl tensor at n = 4. It is not
    from n >= 5: deviations 0.20-0.58 at random tensors.
  * ||G||^2 = mu_K^2 for G = sum_a v_a A^a was claimed structural. It holds at every
    catalogued point INCLUDING the non-diagonal CP^m. At random tensors G's off-diagonal
    part carries 86-95% of the norm.

The mechanism is the same both times and it is not carelessness: an object built from W
transforms WITH W, so it is equivariant rather than invariant, and a catalogue made of
symmetric objects agrees on everything the symmetry forces.

**The discriminator is ISOTROPY IRREDUCIBILITY, not catalogue-versus-random.** N = |W|^2 I/n
holds exactly at CP^3, CP^4 and S^3 x S^3 and FAILS at S^4 x S^8 -- which is a catalogue
point. An isotropy-irreducible point forces any equivariant symmetric 2-tensor to be a
multiple of the identity, so it certifies nothing; an ANISOTROPIC one tests the claim for
real. So the cheap fix is not "always go random": it is to keep one anisotropic point in
the catalogue. S^4 x S^8 alone would have caught both errors above, at a fraction of the
cost of a random sweep. Random draws remain the backstop when no anisotropic example is
known.

USAGE

    from random_control import random_weyl, control

    control(lambda W, n: my_quantity(W) - my_predicted_value(W),
            label="N = |W|^2 I / n", dims=(5, 6, 8))

`control` reports the worst relative residual over random Weyl tensors at each dimension
and returns True only if the claim survives. Give it a residual, not a boolean: the size
of the failure is what tells you whether the claim is wrong or merely mis-normalised.

The generator is the same projection the rest of the repo uses -- antisymmetrise, impose
first Bianchi, subtract the Ricci part -- so a tensor it returns is a genuine element of
Weyl_n, and the function asserts that before returning.
"""
import itertools
import numpy as np


def random_weyl(n, rng, tol=1e-10):
    """A uniformly-drawn element of Weyl_n as a (0,4) tensor, normalised on Lambda^2.

    Screened before return: antisymmetry in both pairs, pair symmetry, first Bianchi,
    and Ricci-flatness. A tensor failing any of these is a bug in the projector, not a
    sample, so it raises rather than being returned quietly.
    """
    X = rng.standard_normal((n, n, n, n))
    R = X - X.transpose(1, 0, 2, 3)
    R = R - R.transpose(0, 1, 3, 2)
    R = R + R.transpose(2, 3, 0, 1)
    R = R - (R + R.transpose(1, 2, 0, 3) + R.transpose(2, 0, 1, 3)) / 3
    g = np.eye(n)
    Ric = np.einsum('ikjk->ij', R)
    s = np.trace(Ric)
    E = Ric - s / n * g
    KN = lambda P, Q: (np.einsum('ik,jl->ijkl', P, Q) + np.einsum('jl,ik->ijkl', P, Q)
                       - np.einsum('il,jk->ijkl', P, Q) - np.einsum('jk,il->ijkl', P, Q))
    W = R - KN(E, g) / (n - 2) - s / (2 * n * (n - 1)) * KN(g, g)

    pr = list(itertools.combinations(range(n), 2))
    M = np.array([[W[i, j, k, l] for (k, l) in pr] for (i, j) in pr])
    nrm = np.linalg.norm(M)
    if nrm < 1e-9:
        return None
    W = W / nrm

    assert np.abs(W + W.transpose(1, 0, 2, 3)).max() < tol, "not antisymmetric in the first pair"
    assert np.abs(W - W.transpose(2, 3, 0, 1)).max() < tol, "not pair-symmetric"
    bianchi = W + W.transpose(0, 2, 3, 1) + W.transpose(0, 3, 1, 2)
    assert np.abs(bianchi).max() < tol, "first Bianchi violated"
    assert np.abs(np.einsum('ikjk->ij', W)).max() < tol, "not Ricci-flat"
    return W


def control(residual, label, dims=(5, 6, 7, 8), trials=20, seed=0, tol=1e-10):
    """Evaluate `residual(W, n)` at random Weyl tensors and report the worst case.

    `residual` returns a number that the claim says is zero. Returns True iff every
    sample stays under `tol`.
    """
    rng = np.random.default_rng(seed)
    ok = True
    print(f"RANDOM-POINT CONTROL, {label}")
    for n in dims:
        worst = 0.0
        for _ in range(trials):
            W = random_weyl(n, rng)
            if W is None:
                continue
            worst = max(worst, abs(float(residual(W, n))))
        verdict = "holds" if worst < tol else "*** FAILS ***"
        ok &= worst < tol
        print(f"   n={n:2d}: worst |residual| over {trials} random Weyl tensors = {worst:.3e}   {verdict}")
    if not ok:
        print("   -> the claim is a property of whatever sample suggested it, not of Weyl_n.")
    return ok


if __name__ == "__main__":
    # The two claims this file was written because of. Both were believed on the strength
    # of the catalogue; both are false in general, and the control says so in one call.
    def N_is_scalar(W, n):
        N = np.einsum('impq,kmpq->ik', W, W)
        N = (N + N.T) / 2
        return np.linalg.norm(N - np.trace(N) / n * np.eye(n)) / max(np.linalg.norm(N), 1e-30)

    def G_is_diagonal(W, n):
        pr = list(itertools.combinations(range(n), 2))
        K = np.zeros((n, n))
        for (a, b) in pr:
            K[a, b] = K[b, a] = W[a, b, a, b]
        v = np.linalg.eigh(K)[1][:, -1]
        G = sum(v[a] * W[a, :, a, :] for a in range(n))
        off = G - np.diag(np.diag(G))
        return np.linalg.norm(off) / max(np.linalg.norm(G), 1e-30)

    control(N_is_scalar, "N = |W|^2 I / n  (true at n=4 and at every S^k x S^k)", dims=(4, 5, 6, 8))
    print()
    print("The one-point version of the same test: S^4 x S^8 is ANISOTROPIC and in the")
    print("catalogue, and it refutes N = |W|^2 I / n on its own -- spec N = {0.15^(8), 0.70^(4)}.")
    print()
    control(G_is_diagonal, "G = sum_a v_a A^a is diagonal  (true across the whole catalogue)")
