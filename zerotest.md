$\newcommand{\tmS}{\mathcal{S}} \newcommand{\R}{\mathcal{R}} \newcommand{\F}{\mathcal{F}} \newcommand{\C}{\mathcal{C}} \newcommand{\E}{\mathcal{E}}$Complexity bounds for zero-test algorithms

2001-11-14

**Abstract:** *In this paper, we analyze the complexity of a zero test for 
expressions built from formal power series solutions of first order 
differential equations with non degenerate initial conditions. We will prove a 
doubly exponential complexity bound. This bound establishes a power series 
analogue for “witness conjectures”.0.5fn*

# 1 Introduction

Zero equivalence is a major issue on the analysis side of symbolic 
computation. Standard mathematical notation provides a way of representing many 
transcendental functions. However, trivial cases apart, this notation gives 
rise to the following problems:

, but they represent the same function.  * Expressions may not be defined: consider $1 / 0$, $\log (0)$ or $\log (e^{x 
  + y} - e^x e^y)$.
  * Expressions may be ambiguous: what values should we take for $\log (- 1)$ or 
  $\sqrt[]{z^2}$0.4spc?
  * Expressions may be redundant: $\sin^2 x + \cos^2 x$ and $1$ are different 
  expressions

Often, one is interested in expressions which represent functions in a ring. 
In that case, the third problem reduces to deciding when a given expression 
represents the zero function.

As to the first two problems, one has to decide where and how we want our 
functions to be defined. In this paper, we will mainly be concerned with 
expressions that represent multivariate power series. The expressions will then 
be formed from the constants and the indeterminates using the ring operations 
and power series solutions to first-order differential equations. The 
correctness and non-ambiguity of expressions may then be ensured by structural 
induction. This may involve zero-testing for the series represented by 
subexpressions.

## 1.1 Zero-tests for constants

As a first step, one would like to be able to solve zero-equivalence for the 
elementary constants, that is to say the smallest field of constants closed 
under the application of the exponential, trigonometric and (for non-zero 
argument) logarithmic functions. Alas no such algorithm is known and it is 
clear that some formidable problems in transcendental number theory would need 
to be solved before one was found. In the face of this dilemma implementers 
have used heuristic methods generally involving floating-point computations.

Theoreticians have often resorted to the use of an oracle; in other words they 
pre-supposed a solution to the problem for constants. They have then gone on to 
develop other algorithms, for example to decide zero equivalence of functions, 
on this basis. However for elementary constants one can do better than merely 
invoke an oracle.

The Schanuel Conjecture may be stated as follows: Many special cases of this are well known unsolved conjectures in transcendental number theory. Following work by Lang, , algorithms for deciding the signs of elementary constants based on the Schanuel Conjecture have been given by Caviness and Prelle,  and Richardson, . The conjecture has been shown to imply the decidability of the real exponential field, .Let $\alpha \_{1}, \ldots, \alpha \_{k}$ be complex numbers which are linearly 
independent over the rational numbers $\mathbb{Q}$. Then the transcendence 
degree of

\\[ \mathbb{Q} (\alpha \_{1}, \ldots, \alpha \_{k}, \exp (\alpha \_{1}),
   \ldots, \exp (\alpha \_{k})) : \mathbb{Q} \\]

is at least $k$.

There are definite advantages in using a conjecture from number theory rather 
than heuristic methods, in that it is clear what is being assumed and any 
counter example found would be of considerable mathematical interest. However 
in a practical situation, a zero equivalence method for constants is generally 
needed very often, and here the algorithms based on the Schanuel Conjecture are 
really rather slow.

Another limitation of the above approach is that it is very hard to see how to 
generalize the Schanuel Conjecture to cover constants given by Liouvillian or 
Pfaffian functions. For the substance of the conjecture is that the relations 
between exponentials and logarithms of numbers are just the ones we already 
know about, but it seems impossible to even formulate such a claim when 
integrals and solutions of differential equations are involved.

In , the following witness conjecture was made. Let $N \geqslant 3$ and 
consider the set $\E\_{N}$ of real exp-log expressions such that for each 
subexpression of the form $\exp f$ or $\log f$, we have $| \hat{f} | \leqslant 
N$ resp. $N^{- 1} \leqslant | \hat{f} | \leqslant N$, where $\hat{f}$ denotes 
the value of $f$ as a real constant. Then there exists a *witness function* of 
the form $\varpi (n) = C\_{N} n$ such that for any $f \in \E\_{N}$ of size 
$\chi (f)$, it suffices to evaluate $\hat{f}$ up to $\varpi (\chi (f))$ digits 
in order to determine whether it vanishes.

Earlier versions and variants of witness conjectures appeared in . Also, Dan 
Richardson has accumulated numerical evidence and worked out some 
number-theoretic consequences. It should be noticed that these conjectures are 
independent of the Schanuel conjecture. Indeed, there might exist non zero 
elementary constants, which yet evaluate to extremely small numbers. On the 
other hand, there might exist counterexamples to the Schanuel conjecture which 
can be “detected” to be zero by evaluating a reasonable number of digits. 
The interest of witness conjectures is that they potentially provide us with 
fast zero tests, if they can be proved to to hold for reasonably small witness 
functions $\varpi$.

## 1.2 Zero-tests for functions

Although zero-test algorithms for constants are extremely hard to design, more 
progress has been made on zero-tests for functions , , . Unfortunately, no 
reasonable complexity bounds (i.e. less that the Ackermann function) for these 
algorithms were known up till now. In this paper, we both generalize the 
algorithm from  to the multivariate setting and provide complexity bounds.

Now it is interesting to study the significance of such bounds for the exp-log 
constant conjecture. Indeed, since number theoretical questions about 
transcendence or Diophantine approximation are usually very hard, a first step 
usually consists of formulating analogue questions in the setting of function 
fields. A deep and well-known theorem of Ax  states that the power series part 
of Schanuel's conjecture does hold.

The exp-log conjecture also admits a natural power series analogue. Given a 
field $\C$, consider the set $\mathcal{E}\_{k}$ of multivariate power series 
expressions constructed from $\C$ and $z\_{1}, \ldots, z\_{k}$ using ${+}, {-}, 
{\nobreak} {\times}$ and left composition of infinitesimal series by $1 / (1 + 
z)$, $\exp z$ and $\log (1 + z)$. Now let $f \in \mathcal{E}\_{k}$ be such an 
expression of size $\chi (f)$ and let $\rho (f) \in \C [[z\_{1}, \ldots, 
z\_{k}]]$ be the power series represented by $f$. Then we expect that there 
exists a constant $C\_{k}$, such that $\rho (f) = 0$ if and only if the 
coefficient of $z\_{1}^{\alpha \_{1}} \cdots z\_{k}^{\alpha \_{k}}$ in $\rho 
(f)$ vanishes for all $\alpha \_{1}, \ldots, \alpha \_{k} \in \lbrace 0, 
\ldots, C\_{k} \chi (f)\rbrace$.

As a side effect of our complexity bounds, we will be able to prove a weaker 
result: with the above notation, there exists a constant $C$, such that $\rho 
(f)$ vanishes if and only if the coefficient of $z\_{1}^{\alpha \_{1}} \cdots 
z\_{k}^{\alpha \_{k}}$ in $\rho (f)$ vanishes for all $\alpha \_{1}, \ldots, 
\alpha \_{k} \in \lbrace 0, \ldots, k^{C^{\chi (f)}} \rbrace$. Just as the Ax 
theorem gives theoretical evidence that for the numerical Schanuel conjecture, 
our result thereby gives evidence that the numerical witness conjecture might 
be true.

## 1.3 Overview

In section [2](#setup), we describe our setup of *effective local domains* for 
doing computations on power series. Such computations may either be effective 
zero-tests or the extraction of coefficients. We will next consider the 
extension of effective local domains by solutions to first order partial 
differential equations. In section [5](#zt-alg), we will show that such 
extensions are again effective local domains.

In section 3, we recall the Bareiss method for Gaussian elimination of 
matrices with coefficients in an integral domain. This method has the advantage 
of limiting the expression swell. More precisely, we give bounds in terms of 
*pseudo-norms* on integral domains. In the sequel, the Bareiss method is 
applied to the efficient g.c.d. computation of several polynomials. This is an 
essential improvement with respect to , which allows us to obtain 
“reasonable” complexity bounds for our zero test.

In section 4, we prove four key lemmas which ensure the correctness of our 
zero test. We also corrected a small mistake in the original correctness proof 
in . In section [5](#zt-alg) we present the actual algorithm and complexity 
bounds.

In the case of power series over the real numbers, it is possible to obtain 
better theoretical bounds using techniques from . Nevertheless, we think that 
the results of this paper are interesting from several point of views:

  * The framework is more general, because we show how to obtain complexity 
  bounds in a relative way for extensions of effective local domains.
  * We presented an improved version of an actual zero-test algorithm, which 
  might have a better average complexity than Khovanskii's complexity bounds, 
  although we have not yet proved a better bound for the worst case.
  * Our methods are likely to generalize to higher order differential equations, 
  by adapting the algorithm from .

We plan to improve our complexity bounds in a forthcoming paper, with the hope 
of obtaining bounds closer to those in .

# 2 The main setup
<span id="setup"></span>

## 2.1 Effective local domains

Let $\C$ be an effective field of constants, which means that all field 
operations can be performed algorithmically and that we have an effective zero 
test. The ring $\C [[z\_{1}, \ldots, z\_{k}]]$ is a differential ring for the 
partial differentiations $\partial \_{1}, \ldots, \partial \_{k}$ w.r.t. 
$z\_{1}, \ldots, z\_{k}$ on $\C [[z\_{1}, \ldots, z\_{k}]]$.

We will frequently consider multivariate power series in $\C [[z\_{1}, \ldots, 
z\_{k}]]$ as recursive power series in $\C [[z\_{1}]] \cdots [[z\_{k}]]$. For 
this reason, it is convenient to introduce the partial evaluation mappings

\begin{eqnarray*}
  \varepsilon \_{i} : \C [[z\_{1}, \ldots, z\_{j}]] & \longrightarrow & \C
  [[z\_{1}, \ldots, z\_{i}]] ;\\\\\\
  f (z\_{1}, \ldots, z\_{j}) & \longmapsto & f (z\_{1}, \ldots, z\_{i}, 0,
  \ldots, 0)
\end{eqnarray*}

for all $0 \leqslant i \leqslant j \leqslant k$. We re-obtain the total 
evaluation mappings $\varepsilon = \varepsilon \_{0}$ as special cases. Notice 
that

\\[ \partial \_{i} \varepsilon \_{j} (f) = \varepsilon \_{j} (\partial \_{i}
   f), \\]

for every $f \in \C [[z\_{1}, \ldots, z\_{k}]]$ and $1 \leqslant i \leqslant j 
\leqslant k$.

**Definition 1:** A differential subring

$\R$

 of

$\C [[z\_{1}, \ldots, z\_{k}]]$

 is called an

**effective power series domain**

, if we have algorithms for

$+, -, \times, \varepsilon, \partial \_{1}, \ldots, \partial \_{k}$

 and an algorithm to test whether

$\varepsilon \_{i} (f) = 0$

 for each

$0 \leqslant i \leqslant k$

 and

$f \in \R$

.

**Remark 2:** Given an effective power series domain

$\R \subseteq \C [[z\_{1}, \ldots, z\_{k}]]$

, we observe that

$\varepsilon \_{i} (\R) \subseteq \C [[z\_{1}, \ldots, z\_{i}]]$

 may be considered as an effective power series domain for each

$1 \leqslant i \leqslant k$

. Indeed, this follows from the fact that

$\varepsilon \_{i}$

 commutes with

$+, -, \times, \varepsilon \_{0}, \ldots, \varepsilon \_{i}, \partial \_{1}, 
\ldots, \partial \_{i}$

.

Let $\R$ be an effective power series domain and let $f$ be a power series in 
$\C [[z\_{1}, \ldots, z\_{k}]]$, which satisfies partial differential equations

<span id="pde"></span>
\begin{equation}
  \label{pde}\tag{1} \left\lbrace \begin{array}{c}
    \partial \_{1} f = \frac{A\_{1} (f)}{B\_{1} (f)}\\\\\\
    \vdots \\\\\\
    \partial \_{k} f = \frac{A\_{k} (f)}{B\_{k} (f)}
  \end{array} \right.
\end{equation}

where $A\_{i}, B\_{i} \in \R [F]$ are such that $\varepsilon (B\_{i} (f)) \neq 
0$ for each $i$. Then the ring

\\[ \tmS = \R \left[ f, \frac{1}{B\_{1} (f)}, \ldots, \frac{1}{B\_{k} (f)}
   \right] \\]

is a differential subring of $\C [[z\_{1}, \ldots, z\_{k}]]$, which is called 
a *regular D-algebraic extension* of $\R$. The main aim of this paper is to 
show that $\tmS$ is also an effective power series domain and to give 
complexity bounds for the corresponding algorithms.

## 2.2 Computations in $\tmS$

Elements in $\R [f]$ are naturally represented by polynomials $\R [F]$ in a 
formal variable $F$, via the unique $\R$-algebra morphism $\rho : \R [F] 
\rightarrow \R [f]$ with $\rho (F) = f$. This mapping $\rho$ naturally extends 
to a mapping $\rho : \check{\tmS} \rightarrow \tmS$, where

\\[ \check{\tmS} = \R \left[ F, \frac{1}{B\_{1} (F)}, \ldots, \frac{1}{B\_{k}
   (F)} \right] \subseteq \R (F) \\]

The structure of $\tmS$ may be transported to $\check{\tmS}$ in a natural way. 
The partial differentiations $\partial \_{1}, \ldots, \partial \_{k}$ on $\R$ 
extend uniquely to $\check{\tmS}$ by setting $\partial \_{i} F = A\_{i} (F) / 
B\_{i} (F)$ for each $i$ (so that $\rho \circ \partial \_{i} = \partial \_{i} 
\circ \rho$). Each partial evaluation mapping $\varepsilon \_{i} : \tmS 
\rightarrow \C$ induces a natural evaluation mapping $\varepsilon \_{i} \circ 
\rho$ on $\check{\tmS}$, which we will also denote by $\varepsilon \_{i}$. 
Since $\R$ is an effective local domain, the operations ${+}, {-}, {\times}, 
\varepsilon, \partial \_{1}, \ldots, \partial \_{k}$ can clearly be performed 
algorithmically on $\tmS$. Our main problem will therefore be to design a 
zero-test for $\tmS$, which amounts to deciding whether $\rho (P / Q) = 0$ for 
a given rational function $P / Q \in \check{S}$.

Actually, it is more convenient to work with polynomials in $\R [F]$ instead 
of rational functions in $\check{\tmS}$. Our main problem will then be to 
decide whether $\rho (P) = 0$ for $P \in \R [F]$, since a rational function $P 
/ Q \in \check{\tmS}$ represents zero if and only if $P$ does. Unfortunately, 
the ring $\R [F]$ is not necessarily stable under the derivations $\partial 
\_{1}, \ldots, \partial \_{k}$. For this reason, we introduce the derivations

\\[ d\_{i} = B\_{i} (F) \partial \_{i}, \\]

which do map $\R [F]$ into itself.

In order to determine whether $\rho (P) = 0$ for polynomials $P \in \R [F]$, 
we will consider the roots of such polynomials in the algebraic closure 
$\R^{\operatorname{alg}}$ of $\R$. Now it is classical that the algebraic 
closure of the ring $K [[z]]$ of univariate power series over a field $K$ is 
the field $K^{\operatorname{alg}} {\langle\!\langle} z {\rangle\!\rangle}$ of 
Puiseux series over the algebraic closure $K^{\operatorname{alg}}$ of $K$. 
Interpreting multivariate power series in $\C [[z\_{1}, \ldots, z\_{k}]]$ as 
recursive power series in $\C [[z\_{1}]] \cdots [[z\_{k}]]$, we may thus view 
elements in $\R^{\operatorname{alg}}$ as recursive Puiseux series in 
$\C^{\operatorname{alg}} {\langle\!\langle} z\_{1} {\rangle\!\rangle} \cdots 
{\langle\!\langle} z\_{k} {\rangle\!\rangle}$.

## 2.3 Extraction of coefficients

We define the anti-lexicographical ordering $\leqslant$ on $\mathbb{Q}^k$ by

\begin{eqnarray*}
  \boldsymbol{\alpha} \leqslant \boldsymbol{\beta} & \Longleftrightarrow &
  {(\alpha \_{1}}  = \beta \_{1} \wedge \cdots \wedge \alpha \_{k} = \beta
  \_{k}) \vee\\\\\\
  &  & {(\alpha \_{1}}  < \beta \_{1} \wedge \alpha \_{2} = \beta \_{2}
  \wedge \cdots \wedge \alpha \_{k} = \beta \_{k}) \vee\\\\\\
  &  & \vdots \\\\\\
  &  & (\alpha \_{k} < \beta \_{k}),
\end{eqnarray*}

for $\boldsymbol{\alpha}= (\alpha \_{1}, \ldots, {\nobreak} \alpha \_{k}), 
\boldsymbol{\beta}= (\beta \_{1}, \ldots, {\nobreak} \beta \_{k}) \in 
\mathbb{Q}^k$.

Consider a Puiseux series $\varphi \in \C {\langle\!\langle} z\_{1} 
{\rangle\!\rangle} \cdots {\langle\!\langle} z\_{k} {\rangle\!\rangle}$. We 
will write

\\[ \varphi = \sum\_{\alpha} \varphi \_{\alpha} z\_{k}^{\alpha} \\]

for the power series expansion of $\varphi$ w.r.t. $z\_{k}$. Each coefficient 
may recursively be expanded in a similar way w.r.t. $z\_{k - 1}, \ldots, 
z\_{1}$. Alternatively, we may expand $\varphi$ at once w.r.t. all variables 
using the anti-lexicographical ordering:

\\[ \varphi = \sum\_{\boldsymbol{\alpha}} \varphi \_{\boldsymbol{\alpha}}
   z^{\boldsymbol{\alpha}}, \\]

where $z^{\boldsymbol{\alpha}} = z\_{1}^{\alpha \_{1}} \cdots z\_{k}^{\alpha 
\_{k}}$. If $f \neq 0$, then the minimal $\boldsymbol{\alpha}$ with $\varphi 
\_{\boldsymbol{\alpha}} \neq 0$ is called the valuation of $\varphi$ and we 
denote it by $\boldsymbol{v} (\varphi)$. If $\boldsymbol{v} (\varphi) \geqslant 
\boldsymbol{0}$, then may we define $\varepsilon \_{i} (\varphi)$ to be the 
coefficient of $z\_{i + 1}^0 \cdots z\_{k}^0$ in $\varphi$, for each $i \in 
\lbrace 0, \ldots, k\rbrace$. As usual, we denote $\varepsilon (\varphi) = 
\varepsilon \_{0} (\varphi)$.

If $P \in \R [F]$ is a non zero polynomial, then we define the valuation 
$\boldsymbol{v} (P)$ of $P$ to be the minimum of the valuations of its non zero 
coefficients. If $P$ has degree $d$, then we also define

\\[ P\_{\boldsymbol{\alpha}} (\lambda) = P\_{d, \boldsymbol{\alpha}} \lambda^d
   \+ \cdots + P\_{0, \boldsymbol{\alpha}} \in \C [\lambda], \\]

for each $\boldsymbol{\alpha} \in \mathbb{N}^k$.

It should be noticed that the recursive extraction of coefficients can be done 
effectively in an effective power series domain $\R$, because

\\[ \varphi \_{\alpha_k, \ldots, \alpha_{i + 1}} = \frac{1}{\alpha \_{k} !
   \cdots \alpha \_{i + 1} !} \varepsilon \_{i} (\partial \_{k}^{\alpha \_{k}}
   \cdots \partial \_{i + 1}^{\alpha \_{i + 1}} \varphi) \\]

for all $\varphi \in \R$ and $\alpha \_{k}, \ldots, \alpha \_{i + 1} \in 
\mathbb{N}$. More generally, if $P \in \check{\tmS}$, then we may formally 
represent the coefficient $\varphi \_{\alpha_k, \ldots, \alpha_{i + 1}}$ of 
$\varphi = \rho (P)$ by polynomials in $\varepsilon \_{i} (\check{\tmS})$. Such 
representations are best derived through relaxed evaluation of formal power 
series , by using the partial differential equations satisfied by $f$.

# 3 The Bareiss method and g.c.d. computations
<span id="Bareiss"></span>

## 3.1 Pseudo-norms

Let $\R$ be an effective integral domain. In what follows, we will describe 
algorithms to triangulate matrices with entries in $\R$ and compute g.c.d.s of 
polynomials with coefficients in $\R$. In order to state complexity bounds, it 
is convenient to measure the “sizes” of constants in $\R$ in terms of a 
*pseudo-norm*, which is a function $\nu : \R \rightarrow \mathbb{N}$ with the 
following properties:

N1$\nu (\varphi + \psi) \leqslant \max \lbrace \nu (\varphi), \nu 
(\psi)\rbrace$.

N2$\nu (\varphi \psi) \leqslant \nu (\varphi) + \nu (\psi)$.

If $\R$ is actually a differential ring with derivations $\partial \_{1}, 
\ldots, \partial \_{k}$, then we also assume the existence of a constant 
$K\_{\R} \in \mathbb{N}$ with

N3$\nu (\partial \_{i} \varphi) \leqslant \nu (\varphi) + K\_{\R}$.

**Example 3:** If

$\R = \C [z\_{1}, \ldots, z\_{k}]$

, then we may take

$\nu (P)$

 to be the maximum of the degrees of

$P$

 in

$z\_{1}, \ldots, {\nobreak} z\_{k}$

 and

$K\_{\R} = 0$

.

**Example 4:** Assume that $\R$ and $\tmS$ are as in section [2](#setup) and 
assume that we have a pseudo-norm $\nu$ on $\R$. Then we define a pseudo-norm 
on $\check{\tmS}$ by

\\[ \nu (P) = \max \left\lbrace \deg \_{F} P, \deg \_{B_1 (F)^{- 1}} P, 
\ldots,
   \deg \_{B_k (F)^{- 1}} P, \max \_{{P_{\ast}}_{} \text{ coefficient of } P}
   \nu (P\_{\ast}) \right\rbrace . \\]

This pseudo-norm induces a pseudo-norm on $\tmS$ by

\\[ \nu (\varphi) = \min \left\lbrace \nu (P) | P \in \check{\tmS}, \varphi =
   \rho (P) \right\rbrace . \\]

Notice that we may take

\\[ \left. K\_{\tmS} = K\_{\check{\tmS}} = \max \left\lbrace K\_{\R}, 2, \max
   \lbrace \nu (A\_{1}), \ldots, \nu (A\_{k})\rbrace + \max \left\lbrace \nu
   \left( \frac{\partial B\_{1}}{\partial F} \right. \right), \ldots, \nu
   \left( \frac{\partial B\_{k}}{\partial F} \right) \right\rbrace
   \right\rbrace . \\]

## 3.2 The Bareiss method

Let $\R$ still be an effective integral domain with a pseudo-norm $\nu$ and 
quotient field $\F$. Consider an $m \times n$ matrix $M$ with entries in $\F$ 
(i.e. a matrix with $m$ rows and $n$ columns). For all indices $1 \leqslant 
i\_{1} < \cdots < i\_{k} \leqslant m$ and $1 \leqslant j\_{1} < \cdots < j\_{l} 
\leqslant n$, we will also write $M\_{[i_1, \ldots, i_k], [j_1, \ldots, j_l]}$ 
for the $k \times l$ minor of $M$ when we only keep the rows $i\_{1}, \ldots, 
i\_{k}$ and columns $j\_{1}, \ldots, j\_{l}$.

It is classical that we may upper triangulate $M$ using Gaussian elimination. 
This leads to a formula

\\[ T = UM, \\]

where $U$ is a matrix with determinant one and $T$ an upper triangular matrix. 
Unfortunately, this process usually leads to a fast coefficient growth for the 
numerators of the entries of the successive matrices. In order to remove this 
drawback, we will rather do all computations over $\R$ instead of $\F$. This 
approach is due to .

So let us now be given an $m \times n$ matrix $M$ with entries in $\R$. For 
simplicity, we will first assume that the usual triangulation of $M$ as a 
matrix with entries in $\F$ does not involve row permutations. This usual 
triangulation of $M$ gives rise to a sequence of identities

\\[ \bar{T}\_{k} = \bar{U}\_{k} M, \\]

with $k \in \lbrace 0, \ldots, m\rbrace$, where $\bar{T}\_{k}$ is the matrix 
obtained from $M = \bar{T}\_{0}$ after $k$ steps. More precisely, 
$\bar{T}\_{k}$ is obtained from $\bar{T}\_{k - 1}$ by leaving the first $k$ 
rows invariant and by adding multiples of the $k$-th row to the others (in 
particular, the $\bar{U}\_{k}$ will be lower triangular throughout the 
process). If there exists a $q$ with $(\bar{T}\_{k})\_{k, q} \neq 0$, then let 
$p\_{k}$ be the minimal such $q$, so that $(\bar{T}\_{k})\_{l, r} = 0$ for all 
$l > k$ and $r < p\_{k}$. Each $\bar{T}\_{k}$ may be rewritten as a product

\\[ \bar{T}\_{k} = D\_{k}^{- 1} T\_{k}, \\]

of an invertible diagonal matrix $D\_{k}$ and another matrix $T\_{k}$ with 
entries in $\R$. Our aim is to show that we may choose the $D\_{k}$ and 
$T\_{k}$ of small pseudo-norms. In fact, we claim that we may take $D\_{k} 
=\operatorname{Diag} (1, \delta \_{1}, \ldots, \delta \_{k - 2}, \delta \_{k - 
1}, \delta \_{k - 1}, \ldots, \delta \_{k - 1})$ for each $k$, where $\delta 
\_{k} = (T\_{k})\_{k, p_k}$.

In order to see this, let $k \geqslant 1$, $i > k - 1$ and $j > p\_{k - 1}$. 
Then we first observe that

\\[ (\bar{T}\_{k})\_{[1, \ldots, k - 1, i], [p_1, \ldots, p_{k - 1}, j]} =
   \bar{U}\_{k, [1, \ldots, k - 1, i], [1, \ldots, k - 1, i]} M\_{[1, \ldots,
   k - 1, i], [p_1, \ldots, p_{k - 1}, j]} . \\]

Since $\bar{U}\_{k, [1, \ldots, k - 1, i], [1, \ldots, k - 1, i]}$ is a lower 
triangular matrix with ones on its diagonal, we obtain

\\[ \det (\bar{T}\_{k})\_{[1, \ldots, k - 1, i], [p_1, \ldots, p_{k - 1}, j]} 
=
   \det M\_{[1, \ldots, k - 1, i], [p_1, \ldots, p_{k - 1}, j]} \\]

Since $(\bar{T}\_{k})\_{[1, \ldots, k - 1, i], [p_1, \ldots, p_{k - 1}, j]}$ 
is upper triangular, we also have

\\[ \det (\bar{T}\_{k})\_{[1, \ldots, k - 1, i], [p_1, \ldots, p_{k - 1}, j]} 
=
   (\bar{T}\_{k})\_{1, p_1} \cdots (\bar{T}\_{k})\_{k - 1, p_{k - 1}}
   (\bar{T}\_{k})\_{i, j} . \\]

By our choice of $D\_{k}$, we finally have

\\[ (\bar{T}\_{k})\_{1, p_1} \cdots (\bar{T}\_{k})\_{k - 1, p_{k - 1}}
   (\bar{T}\_{k})\_{i, j} = \frac{(T\_{k})\_{1, p_1} \cdots (T\_{k})\_{k - 1,
   p_{k - 1}}  (T\_{k})\_{i, j}}{1 \delta \_{1} \cdots \delta \_{k - 1}} =
   (T\_{k})\_{i, j} . \\]

Putting this together, we see that each coefficient of $T\_{k}$ (whence in 
particular $\delta \_{k}$) may be written as the determinant of a minor of $M$:

<span id="detrel"></span>
\begin{equation}
  \label{detrel}\tag{2} (T\_{k})\_{i, j} = \det M\_{[1, \ldots, k - 1, i],
  [p_1, \ldots, p_{k - 1}, j]} .
\end{equation}

Hence, we have not only shown that the $D\_{k}$ and $T\_{k}$ have coefficients 
in $\R$, but even that they may be written explicitly as determinants of minors 
of $M$. This result remains so (up to a factor $\pm 1$) if row permutations 
were needed in the triangulation process, since we may always permute the rows 
of $M$ *a priori*, so that no further row permutations are necessary during the 
triangulations. This proves the following theorem:

**Theorem 5:** <span id="Bareisth"></span>There exists an algorithm, which 
takes an $m \times n$ matrix $M$ with entries in $\R$ on input, and which 
computes an invertible $m \times m$ diagonal matrix $D$ and an $m \times n$ 
upper triangular matrix $T$ with entries in $\R$, such that there exists a 
matrix $\bar{U}$ with entries in $\F$, of determinant one, and so that $D^{- 1} 
T = \bar{U} M$. Moreover, $\nu (D) \leqslant \min (m, n) \nu (M)$ and $\nu (T) 
\leqslant \min (m, n) \nu (M)$. Here $\nu (M) = \max \_{i, j} \nu (M\_{i, j})$.

The actual computation of $T$ involves $O (mn \min (m, n))$ elementary 
operations. If we do have an algorithm for exact division in $T$, then this is 
also the time complexity of the algorithm in terms of operations in $\R$. 
Otherwise, it may be necessary to compute the entries of the intermediate 
matrices $T\_{k}$ by formula ([2](#detrel)), which yields an overall complexity 
of $O (mn (\min (m, n))^3)$.

## 3.3 Computing greatest common divisors of several polynomials

Let $\R$ still be an effective integral domain with a pseudo-norm $\nu$ and 
quotient field $\F$. Consider a finite number $P\_{1}, \ldots, P\_{k}$ of 
polynomials in $\R [F]$. In this section, we address the question of computing 
a g.c.d. $G \in \R [F]$ of $P\_{1}, \ldots, P\_{k}$ and a corresponding Bezout 
relation. Since we are only computing over an integral domain, we call $G$ *a* 
g.c.d., if $G$ is a scalar multiple of *the* g.c.d. of $P\_{1}, \ldots, 
P\_{k}$, when considered as polynomials over the quotient field $\F$. 
Accordingly, a Bezout relation for $P\_{1}, \ldots, P\_{k}$ has the form

<span id="Bezout"></span>
\begin{equation}
  \label{Bezout}\tag{3} Q\_{1} P\_{1} + \cdots + Q\_{k} P\_{k} = cG,
\end{equation}

where $Q\_{1}, \ldots, Q\_{k} \in \R [F]$ and $c \in \R^{\ast}$. From the 
computational point of view, we are interested in minimizing the pseudo-norms 
of $Q\_{1}, \ldots, Q\_{k}, c$ and $G$. As to the degrees, such “small Bezout 
relations” always exist:

**Proposition 6:** Let

$P\_{1}, \ldots, P\_{k} \in \R [F]$

 be more than one non-zero polynomial. Then there exists a Bezout relation

([3](#Bezout))

, such that

$\max \lbrace \deg Q\_{i} P\_{i} \rbrace < \max \lbrace \deg P\_{i} + \deg 
P\_{j} |i \neq j\rbrace$

.

**Proof 7:** Assume the contrary and choose a Bezout relation ([3](#Bezout)) 
of minimal degree $d = \max {\nobreak} \lbrace \deg Q\_{i} P\_{i} \rbrace$ and 
such that the number $l$ of indices $i\_{1} < \cdots < i\_{l}$ with $\deg 
Q\_{i_k} P\_{i_k} = d$ is minimal. Since $d > \deg G$, we must have $l > 1$, 
and modulo a permutation of indices, we may assume that $i\_{k} = k$ for each 
$k$. Let $\lambda$ be the leading coefficient of $Q\_{1}$ and $\mu$ the leading 
coefficient of $P\_{2}$. Then for $\delta = d - \deg P\_{1} - \deg P\_{2} 
\geqslant 0$, we have

\\[ (\mu Q\_{1} - \lambda x^{\delta} P\_{2}) P\_{1} + (\mu Q\_{2} + \lambda
   x^{\delta} P\_{1}) P\_{2} + \mu Q\_{3} P\_{3} + \cdots + \mu Q\_{k} P\_{k}
   = \mu cG, \\]

is again a Bezout relation, which contradicts our minimality hypothesis.

Let $d = \max \lbrace \deg P\_{i} + \deg P\_{j} |i \neq j\rbrace$. In order to 
actually find a Bezout relation of degree $< d$, we now consider the matrix $M$ 
with $m = kd - \deg P\_{1} - \cdots - \deg P\_{k}$ rows and $d$ columns, which 
is the vertical superposition of all matrices of the form

\\[ \left( \begin{array}{ccccccc}
     P\_{i, r_i} & \cdots & P\_{i, 0} &  &  &  & 0 \\\\\\
     & P\_{i, r_i} & \cdots & P\_{i, 0} &  &  &  \\\\\\
     &  &  &  &  &  &  \\\\\\
     &  & \ddots &  & \ddots &  &  \\\\\\
     &  &  &  &  &  &  \\\\\\
     &  &  & P\_{i, r_i} & \cdots & P\_{i, 0} &  \\\\\\
     0 &  &  &  & P\_{i, r_i} & \cdots & P\_{i, 0}
   \end{array} \right), \\]

where $r\_{i} = \deg P\_{i}$. Now triangulate $M$ as in the section above

<span id="trid"></span>
\begin{equation}
  \label{trid}\tag{4} D^{- 1} T = \bar{U} M
\end{equation}

and let $l$ be the number of non-zero rows in $T$. The $l$-th row of $T$ 
corresponds to a polynomial linear combination of $P\_{1}, \ldots, P\_{k}$ of 
minimal degree. In other words, it contains the coefficients of a g.c.d. of 
$P\_{1}, \ldots, P\_{k}$.

Moreover, we may obtain a Bezout relation when considering the matrix $M$ with 
an $m \times m$ identity matrix glued at its right hand side. When 
triangulating this matrix, we obtain a relation of the form

\\[ D^{- 1}  \left( \hspace{0.8em} T \enspace | \enspace T' \; \right) =
   \bar{U}  \left( \; M \enspace | \enspace \operatorname{Id} \; \right) = (\;
   \bar{U} M \enspace | \enspace \bar{U} \;), \\]

such that the additional part $T'$ of the triangulated matrix gives us the 
transformation matrix $\bar{U}$ in ([4](#trid)) up to the diagonal matrix $D$:

\\[ T' = D \bar{U} . \\]

The finite sum which leads to the $l$-th row in the product $T' M$ now yields 
the desired Bezout relation. Notice that $c = 1$ in this Bezout relation.

From the complexity point of view, we also notice that at most $d$ rows in $M$ 
may actually have contributed to the first $l \leqslant d$ rows of $T$. When 
replacing $M$ with its restriction to these rows, the above triangulations will 
therefore yield the same g.c.d. and the same Bezout relation. We have proved

**Theorem 8:** <span id="gcdth"></span>Let $P\_{1}, \ldots, P\_{k} \in \R [F]$ 
be more than one non-zero polynomials. Then there exists an algorithm to 
compute a g.c.d. of $P\_{1}, \ldots, P\_{k}$ as well as a Bezout relation 
([3](#Bezout)) with $c = 1$, such that

\\[ \max \lbrace \nu (G), \nu (Q\_{1}), \ldots, \nu (Q\_{k})\rbrace \leqslant 
2
   (\max \lbrace \nu (P\_{1}), \ldots, \nu (P\_{k})\rbrace)^2 . \\]

## 3.4 Making polynomials square-free using pseudo-division

Let $\R$ be an effective integral domain and let $U, V \in \R [F]$ be 
polynomials over $\R$ with $\deg {\nobreak} V \leqslant \deg U$. If $\R$ were 
actually an effective field, then we might have used the Euclidean division 
algorithm to obtain the unique expression for $U$ of the form

\\[ U = QV + R, \\]

with $Q, R \in \R [F]$ and $\deg R < \deg V$. However, this algorithm involves 
divisions and can no longer be used if $\R$ is an integral domain. 
Nevertheless, pseudo-division may always be used to obtain the unique 
expression for $U$ of the form

\\[ I\_{V}^{\deg U - \deg V + 1} U = QV + R, \\]

where $I\_{V}$ is the *leading coefficient* or *initial* of $V$ and $Q, R \in 
\R [F]$ are such that $\deg {\nobreak} R < \deg {\nobreak} V$. We also call $Q$ 
the *pseudo-quotient* and $R$ the *pseudo-remainder* of the division of $U$ by 
$V$.

pdiv

Input$U, V \in \R [F]$ with $\deg U \geqslant \deg V$.

Outputthe pseudo-quotient resp. pseudo-remainder of the division of $U$ by 
$V$.

Set $Q := 0$ and $R := U$

For $i := \deg R, \ldots, \deg V$ do

$Q := I\_{V} Q + R\_{i} F^{\; i - \deg V}$

$R := I\_{V} R - R\_{i} F^{\; i - \deg V} V$

Return $Q$

In particular, we may use pseudo-division to make a polynomial $P$ 
square-free. Namely, we take the square-free part of $P$ to be sqfree$(P) = 
\text{\text{{\ttfamily{pdiv}}}} (P, \text{\text{{\ttfamily{gcd}}}} (P, P'))$. 
The following complexity bound follows from theorem [8](#gcdth):

**Proposition 9:** <span id="sqfreeprop"></span>

Let

$S = \text{\text{{\upshape{\text{{\ttfamily{sqfree}}}}}}} (P)$

 of

$P$

 as above. Then

$\nu (S) \leqslant 2 \nu (P)^4$

.

# 4 Four key lemmas
<span id="key-lemmas"></span>

We recall that derivations on integral domains extend uniquely to their 
algebraic closures.

**Lemma 10:** <span id="gcd-lem"></span>Let $P \in \R [F]$ be a square-free 
polynomial and

\\[ G = \text{\text{{\upshape{\text{{\ttfamily{gcd}}}}}}}  (P, d\_{1} P,
   \ldots, d\_{k} P) . \\]

Consider the factorization

\\[ G = g (F - h\_{1}) \cdots (F - h\_{q}), \\]

with $h\_{1}, \ldots, h\_{q} \in \R^{\operatorname{alg}}$. Then each of the 
$h\_{p}$ satisfies the partial differential equations ([1](#pde)).

**Proof 11:** Consider one of the factors $F - h\_{p}$ of $G$ and write

\\[ P = (F - h\_{p}) Q. \\]

For each $i \in \lbrace 1, \ldots, k\rbrace$, we have

\\[ d\_{i} P = (A\_{i} (F) - B\_{i} (F) \partial \_{i} h\_{p}) Q + (F - 
h\_{p})
   d\_{i} Q \\]

Since $F - h\_{p}$ both divides $d\_{i} P$ and $(F - h\_{p}) d\_{i} Q$, it 
also divides $(A\_{i} (F) - B\_{i} (F) \partial \_{i} h\_{p}) Q$. Now $P$ is 
square-free, so that $F - h\_{p}$ does not divide $Q$. Therefore $F - h\_{p}$ 
divides $A\_{i} (F) - B\_{i} (F) \partial \_{i} h\_{p}$. Consequently, $A\_{i} 
(h\_{p}) - B\_{i} (h\_{p}) \partial \_{i} h\_{p} = 0$ for each $i$, i.e. 
$h\_{p}$ satisfies ([1](#pde)).

**Lemma 12:** <span id="unicity"></span>

Let

$\varphi \in \C^{\operatorname{alg}} {\langle\!\langle} z\_{1} 
{\rangle\!\rangle} \cdots {\langle\!\langle} z\_{k} {\rangle\!\rangle}$

 be a Puiseux series with

$\boldsymbol{v} (\varphi) \geqslant \boldsymbol{0}$

. Assume that

$\varphi$

 satisfies the same equations

([1](#pde))

 as

$f$

 and the same initial condition

$\varepsilon (\varphi) = \varepsilon (f)$

. Then

$\varphi = f$

.

**Proof 13:** Let us prove by induction over $i$ that $\varepsilon \_{i} 
(\varphi) = \varepsilon \_{i} (f)$ for all $i \in \lbrace 0, \ldots, k\rbrace$. 
We have $\varepsilon \_{0} (\varphi) = \varepsilon \_{0} (f)$ by assumption. 
Assume therefore that $i > 0$ and $\varepsilon \_{i - 1} (\varphi) = 
\varepsilon \_{i - 1} (f)$. Then $\psi = \varepsilon \_{i} (\varphi)$ is a 
Puiseux series in $\C {\langle\!\langle} z\_{1} {\rangle\!\rangle} \cdots 
{\langle\!\langle} z\_{i} {\rangle\!\rangle}$ of the form

<span id="form-psi"></span>
\begin{equation}
  \label{form-psi}\tag{5} \psi = \varepsilon \_{i - 1} (f) + \sum\_{\alpha >
  0} \psi \_{\alpha} z\_{i}^{\alpha} .
\end{equation}

Since $\partial \_{i}$ and $\varepsilon \_{i}$ commute, $\psi$ satisfies the 
partial differential equation

<span id="pde-i"></span>
\begin{equation}
  \label{pde-i}\tag{6} \partial \_{i} \psi = \frac{\varepsilon \_{i} (A\_{i})
  (\psi)}{\varepsilon \_{i} (B\_{i}) (\psi)} .
\end{equation}

In particular, extraction of the coefficient in $z\_{i}^{\alpha - 1}$ yields

<span id="rec-rel"></span>
\begin{equation}
  \label{rec-rel}\tag{7} \alpha \psi \_{\alpha} = \left( \frac{\varepsilon
  \_{i} (A\_{i}) (\psi)}{\varepsilon \_{i} (B\_{i}) (\psi)} \right)\_{\alpha -
  1}
\end{equation}

for every $\alpha > 0$. Now

\\[ (\varepsilon \_{i} (B\_{i}) (\psi))\_{0} = \varepsilon \_{i - 1} (B\_{i})
   (\psi \_{0}) = \varepsilon \_{i - 1} (B\_{i} (f)) \neq 0, \\]

since $\varepsilon (\varepsilon \_{i - 1} (B\_{i} (f))) = \varepsilon (B\_{i} 
(f)) \neq {\nobreak} 0$. Consequently, we may see ([7](#rec-rel)) as a 
recurrence relation which uniquely determines $\psi \_{\alpha}$ as a function 
of other $\psi \_{\beta}$ with $\beta < \alpha$. Hence $\psi = \varepsilon 
\_{i} (f)$ is the unique solution to ([6](#pde-i)) of the form 
([5](#form-psi)). The lemma now follows by induction.

**Lemma 14:** <span id="New-pol"></span>Let $P$ be a polynomial in $\R [F]$. 
Given $\lambda \in \C^{\operatorname{alg}}$ with

<span id="New-eq"></span>
\begin{equation}
  \label{New-eq}\tag{8} P\_{\boldsymbol{v} (P)} (\lambda) = 0,
\end{equation}

there exists a root $\varphi \in \C^{\operatorname{alg}} {\langle\!\langle} 
z\_{1} {\rangle\!\rangle} \cdots {\langle\!\langle} z\_{k} {\rangle\!\rangle}$ 
of $P$ with $\boldsymbol{v} (\varphi) \geqslant \boldsymbol{0}$ and 
$\varepsilon (\varphi) = \lambda$.

**Proof 15:** Intuitively speaking, this lemma follows from the Newton polygon 
method: the existence of a solution $\lambda \neq 0$ to ([8](#New-eq)) implies 
that the Newton polygon associated to the equation $P (\varphi) = 0$ admits a 
horizontal slope and that $\lambda$ is a solution to the associated Newton 
polynomial. Therefore, $\lambda$ is the first term of a solution to $P 
(\varphi) = 0$, the full solution being obtained using the Newton polygon 
method. If $\lambda = 0$, then the Newton polygon admits a “strictly positive 
slope” and a similar argument applies.

More precisely, we may apply the results from chapter 3 in . We first notice 
that

\\[ \C^{\operatorname{alg}} {\langle\!\langle} z\_{1} {\rangle\!\rangle} 
\cdots
   {\langle\!\langle} z\_{k} {\rangle\!\rangle} = \C^{\operatorname{alg}}
   \texttt{[\!\!\! [} z\_{1}^{\mathbb{Q}} ; \ldots ; z\_{k}^{\mathbb{Q}}
   \texttt{] \!\!\!]} \\]

is a field of grid-based power series. Now setting $\varphi = \lambda + \psi$, 
the Newton degree $d$ of

<span id="aae"></span>
\begin{equation}
  \label{aae}\tag{9} P\_{+ \lambda} (\psi) = P (\lambda + \psi) = 0
  \hspace{4em} (\boldsymbol{v}(\psi) >\boldsymbol{0})
\end{equation}

is strictly positive. Indeed, this is clear if $\lambda = 0$, and this follows 
from lemma 3.2 in  if $\lambda \neq 0$. Now our lemma follows from the fact 
that the algorithm polynomial_solve returns $d$ solutions to ([9](#aae)).

**Lemma 16:** With the notation from lemma [10](#gcd-lem), we have

\\[ \rho (P) = 0 \hspace{1em} \Longleftrightarrow \hspace{1em}
   G\_{\boldsymbol{v} (G)}  (\varepsilon (f)) = 0. \\]

**Proof 17:** The direct implication is trivial. So assume that

$G\_{\boldsymbol{v} (G)}  (\varepsilon (f)) = 0$

. Lemma



[14](#New-pol)

 implies that

$G$

 admits a root

$\varphi \in \C^{\operatorname{alg}} {\langle\!\langle} z\_{1} 
{\rangle\!\rangle} \cdots {\langle\!\langle} z\_{k} {\rangle\!\rangle}$

 with

$\boldsymbol{v} (\varphi) \geqslant \boldsymbol{0}$

 and

$\varepsilon (\varphi) = \varepsilon (f)$

. This root

$\varphi$

 satisfies the equations (

[1](#pde)

), by lemma

[10](#gcd-lem)

. Hence

$\varphi = f$

, by lemma

[12](#unicity)

. We conclude that

$G (f) = 0$

 and

$\rho (P) = P (f) = 0$

.

# 5 The algorithm
<span id="zt-alg"></span>

## 5.1 Statement of the algorithm

The lemmas from the previous section yield the following zero-test algorithm:

zero_test

Input$P \in \R [F]$.

Outputresult of the test $\rho (P) = 0$.

Step 1. [trivial case]

If $P = 0$ then return true.

Step 2. [g.c.d. computations]

Replace $P := \text{\text{{\ttfamily{sqfree}}}} (P)$.

Let $G := \text{\text{{\ttfamily{gcd}}}} (P, d\_{1} P, \ldots, d\_{k} P)$.

Step 3. [compute the valuation of $G$]

Denote $G = G\_{q} F^{\: q} + \cdots + G\_{0}$.

For $i = k, \ldots, 1$ do

Expand $G\_{0, \alpha_k, \ldots, \alpha_{i + 1}}, \ldots, G\_{q, \alpha_k, 
\ldots, \alpha_{i + 1}}$ in a relaxed way  w.r.t. $z\_{i}$.

Stop at the least $\alpha \_{i}$, such that there exists a $p$ with $G\_{p, 
\alpha_k, \ldots, \alpha_i} \neq 0$.

Step 4. [evaluate and conclude]

Return $G\_{\boldsymbol{\alpha}}  (\varepsilon (f)) = 0$.

## 5.2 Complexity bounds

In order to derive complexity bounds, we will to assume that we have a 
pseudo-norm $\nu$ on $\R$ and that there exists a function $\xi \_{\R} : 
\mathbb{N} \rightarrow \mathbb{N}$, such that for each $\varphi \in \R 
\backslash \lbrace 0\rbrace$, we have $|\boldsymbol{v}(\varphi) | \leqslant \xi 
\_{\R} (\nu (\varphi))$. Here we understand that

\\[ | (\alpha \_{1}, \ldots, \alpha \_{k}) | = \max \lbrace \alpha \_{1},
   \ldots, \alpha \_{k} \rbrace, \\]

for each $\boldsymbol{\alpha} \in \mathbb{N}^k$. It is also reasonable to also 
assume that $\xi \_{\R}$ is increasing and that it grows sufficiently fast such 
that $\xi \_{\R} (c) \geqslant c$, $\xi \_{\R} (c + d) \geqslant \xi \_{\R} (c) 
+ \xi \_{\R} (d)$ and $\xi \_{\R} (cd) \geqslant \xi \_{\R} (c) \xi \_{\R} (d)$ 
for all $c, d \in \mathbb{N}^{}$. Notice that we may take $\xi \_{\C} (c) = 1$ 
for all $c \in \mathbb{N}$ when $\R = \C$.

**Theorem 18:** <span id="val-bound"></span>Let

\\[ C = \max \lbrace K\_{\R} + \max \lbrace \nu (B\_{1}), \ldots, \nu
   (B\_{k})\rbrace, \max \lbrace \nu (A\_{1}), \ldots, \nu (A\_{k})\rbrace,
   1\rbrace . \\]

Then for any $\varphi \in \tmS \backslash \lbrace 0\rbrace$, we have

\\[ |\boldsymbol{v}(\varphi) | \leqslant \xi \_{\R} ((2 kC \nu (\varphi))^9) .
\\]

**Proof 19:** Assume first that $\varphi \in \tmS \backslash \lbrace 0\rbrace$ 
can be represented by a square-free polynomial $P \in \R [F]$. Then $P$ does 
not change in step 2 of zero_test and for $i \in \lbrace 1, \ldots, k\rbrace$, 
we have

\\[ \nu (d\_{i} P) \; \leqslant \; \nu (P) + C, \\]

Then theorem [8](#gcdth) yields

\\[ \nu (G) \leqslant 2 (\nu (P) + C)^2 . \\]

Since $|\boldsymbol{v}(G\_{p}) | \leqslant \xi \_{\R} (\nu (G))$ for each 
non-zero coefficient $G\_{p}$ of $G$, it follows that

\\[ |\boldsymbol{\alpha}| \leqslant \xi \_{\R} (2 (\nu (P) + C)^2) \\]

in step 3 of zero_test. Since we assumed $\varphi \neq 0$, we must have 
$G\_{\boldsymbol{\alpha}} (\varepsilon (f)) \neq 0$ in the last step of 
zero_test. Considering the Taylor series expansion

\begin{eqnarray*}
  G (f) & = & G (\varepsilon (f)) + G' (\varepsilon (f)) \delta + \frac{1}{2}
  G'' (\varepsilon (f)) \delta^2 + \cdots\\\\\\
  & = & G\_{\boldsymbol{\alpha}} (\varepsilon (f)) z\_{1}^{\alpha \_{1}}
  \cdots z\_{k}^{\alpha \_{k}} + o (z\_{1}^{\alpha \_{1}} \cdots
  z\_{k}^{\alpha \_{k}})
\end{eqnarray*}

in the infinitesimal power series $\delta = f - \varepsilon (f)$, we observe 
that $\boldsymbol{v} (\rho (G)) =\boldsymbol{\alpha}$.

By theorem [8](#gcdth), $G$ also satisfies a Bezout relation of the form

\\[ G = SP + Q\_{1} d\_{1} P + \cdots + Q\_{k} d\_{k} P, \\]

Now $|\boldsymbol{v}(\rho (d\_{i} P)) | = |\boldsymbol{v}(\rho (B\_{i}) 
\partial \_{i} \rho (P)) | = |\boldsymbol{v}(\partial \_{i} \rho (P)) | 
\geqslant |\boldsymbol{v}(\rho (P)) | - 1$ for all $i$ (recall that 
$\varepsilon (B\_{i}) \neq 0$), so that

\\[ |\boldsymbol{v}(\rho (SP + Q\_{1} d\_{1} P + \cdots + Q\_{k} d\_{k} P)) |
   \geqslant |\boldsymbol{v}(\rho (P)) | - 1. \\]

We conclude that

\\[ |\boldsymbol{v}(\rho (P)) | \leqslant \xi \_{\R} (2 (\nu (P) + C)^2 + 1) .
\\]

This gives a bound for $\boldsymbol{v} (\varphi)$ in the case when $P$ is 
square-free.

Let us now turn to the more general situation in which $\varphi$ is 
represented by a polynomial $P \in \R [F]$ which is no longer square-free. 
Setting $P\_{\ast} := \text{\text{{\ttfamily{pdiv}}}} (P, 
\text{\text{{\ttfamily{gcd}}}} (P, \partial P / \partial F))$, the above 
discussion yields the bound

\\[ |\boldsymbol{v}(\rho (P\_{\ast})) | \leqslant \xi \_{\R} (2 (2 \nu (P)^4 +
   C)^2 + 1), \\]

since $\nu (P\_{\ast}) \leqslant 2 \nu (P)^4$ by proposition [9](#sqfreeprop). 
Now $P$ divides $P\_{\ast}^{\deg P}$ when we understand these polynomials to 
have coefficients in the quotient field of $\R$. If $c$ is the leading 
coefficient of $P$, we thus have $P|c^{(\deg P)^2} P\_{\ast}^{\deg P}$ in $\R 
[F]$, as is seen by pseudo-dividing $P\_{\ast}^{\deg P}$ by $P$. It follows 
that

\begin{eqnarray*}
  |\boldsymbol{v}(\rho (P)) | & \leqslant & \nu (P)  |\boldsymbol{v}(\rho
  (P\_{\ast})) | + \nu (P)^2  |\boldsymbol{v}(c) |\\\\\\
  & \leqslant & \nu (P) \xi \_{\R} (2 (2 \nu (P)^4 + C)^2 + 1) + \nu (P)^2
  \xi \_{\R} (\nu (P))\\\\\\
  & \leqslant & \xi \_{\R} (2 \nu (P) (2 \nu (P)^4 + C + 1)^2),
\end{eqnarray*}

since $|\boldsymbol{v}(c) | \leqslant \xi \_{\R} (\nu (P))$.

Let us finally consider the case when $\varphi$ is represented by a general 
element $P \in \check{\tmS}$. Then we may rewrite $P$ as a fraction $\Phi / 
\Psi$ with $\Phi \in \R [F]$ and $\Psi = B\_{1}^{\nu (P)} \cdots B\_{k}^{\nu 
(P)}$, and we have

\\[ \nu (\Phi) \leqslant \nu (P) + k \nu (P) \max \lbrace \nu (B\_{1}), 
\ldots,
   \nu (B\_{k})\rbrace \leqslant kC \nu (P) . \\]

Since $\boldsymbol{v} (\rho (\Psi)) =\boldsymbol{0}$, we thus get

\begin{eqnarray*}
  |\boldsymbol{v}(\rho (P)) | & \leqslant & \xi \_{\R} (2 \nu (\Phi) (2 \nu
  (\Phi)^4 + C + 1)^2)\\\\\\
  & \leqslant & \xi \_{\R} (2 kC \nu (P) (2 (kC \nu (P))^4 + C + 1)^2)\\\\\\
  & \leqslant & \xi \_{\R} (32 (kC \nu (P)^9),
\end{eqnarray*}

since $\nu (P) = 0$ or $C + 1 \leqslant 2 (kC \nu (P))^4$.

As a consequence of the above bound for the valuations of non-zero series 
$\varphi \in \tmS$, we have a straightforward zero-test algorithm for series 
$\varphi \in \tmS$ which consists of testing whether all coefficients of 
$\varphi$ up to the bound vanish using relaxed evaluation . This algorithm 
satisfies the following complexity bound:

**Theorem 20:** Let

$P \in \check{S}$

<span id="compl-bound"></span>

. With the notation from theorem

[18](#val-bound)

, we may test whether

$P$

 represents zero in time

$O (\xi \_{\R} ((2 kC \nu (\varphi))^9)^k \log^2 \xi \_{\R} ((2 kC \nu 
(\varphi))^9) k^3)$

.

**Remark 21:** Of course, the complexity bound from theorem

[20](#compl-bound)

 is very pessimistic, since it reflects the theoretical worst case bounds for 
the valuations. In practice, we recommend using

zero_test

, which we expect to be much faster in average.

## 5.3 Consequences of the complexity bounds

Consider a tower of regular D-algebraic ring extensions $\R\_{0} \subseteq 
\R\_{1} \subseteq \cdots \subseteq \R\_{h}$ starting with $\R\_{0} = \C 
[z\_{1}, \ldots, z\_{k}]$. We have natural representations

\\[ \rho : \check{\R}\_{i} = \check{\R}\_{i - 1} \left[ F\_{i}, 
\frac{1}{B\_{i,
   1} (F\_{i})}, \ldots, \frac{1}{B\_{i, n_i} (F\_{i})} \right] \rightarrow
   \R\_{i} \\]

for all $i \in \lbrace 1, \ldots, k\rbrace$. The repeated application of 
theorem [18](#val-bound) yields

**Corollary 22:** There exists a constant

$K$

, such that for all

$P \in \check{\R}\_{h}$

, we have either

$\rho (P) = 0$

 or

$|\boldsymbol{v}(\rho (P)) | \leqslant K \nu (P)^{9^h}$

.

**Remark 23:** In other words, for fixed

$h$

, we have a polynomial time algorithm zero-test in



$\R\_{h}$

. Theoretically speaking, we already knew this, because

$\R\_{h} \cong \check{\R}\_{h} / I$

 for a certain ideal

$I$

 of

$\check{\R}\_{h}$

. Hence, it would suffice to reduce a polynomial in

$\check{\R}\_{h}$

 with respect to a Groebner basis for

$I$

 in order to know whether it represents zero. Unfortunately, we do not know of 
any algorithm to compute such a Groebner basis for

$I$

. Nevertheless, even without such a Groebner basis the above corollary tells 
us that we still have a polynomial time zero-test.

Let us now return to exp-log series in the ring $\mathcal{E}\_{k}$ considered 
in the introduction.  Repeated application of theorem [18](#val-bound) yields

**Corollary 24:** Consider an exp-log series

$f \in \mathcal{E}\_{k}$

, which can be represented by an expression of size

$\chi$

. Then either

$f = 0$

 or

$|\boldsymbol{v}(f) | \leqslant (4 k \chi)^{9^{\chi}}$

.

**Proof 25:** Let $\check{f}$ be an expression which represents $f$ and let 
$\check{f}\_{1}, \ldots, \check{f}\_{\chi}$ be its subexpressions listed in the 
order of a postfix traversal. We construct a tower $\R\_{0} \subseteq \cdots 
\subseteq \R\_{h}$ with representations $\check{\R}\_{0} \subseteq \cdots 
\subseteq \check{\R}\_{h}$, such that $\check{f}\_{i} \in \R\_{p_i}$ for all 
$i$ and $0 = p\_{1} \leqslant \cdots \leqslant p\_{\chi} = h$. We construct the 
tower by induction over $i$. For $i = 0$ we have nothing to show, so suppose $i 
> 0$ and that we have performed the construction up to stage $i - 1$.

If $\check{f}\_{i} \in \C$ or $\check{f}\_{i} \in \lbrace z\_{1}, \ldots, 
z\_{k} \rbrace$, then we clearly have $\check{f}\_{i} \in \check{\R}\_{0} = \C 
[z\_{1}, \ldots, z\_{k}]$. If $\check{f}\_{i} = \check{f}\_{j_1} + 
\check{f}\_{j_2}$, $\check{f}\_{i} = \check{f}\_{j_1} - \check{f}\_{j_2}$, 
$\check{f}\_{i} = \check{f}\_{j_2} - \check{f}\_{j_1}$ or $\check{f}\_{i} = 
\check{f}\_{j_1}  \check{f}\_{j_2}$ with $j\_{1} < j\_{2} < i$, then 
$\check{f}\_{i} \in \check{\R}\_{j_2}$. Assume finally that $\check{f}\_{i} = 
\varphi \circ \check{f}\_{j}$ with $j < i$, where $\varphi \in \lbrace 1 / (1 + 
z), \exp z, \log (1 + z)\rbrace$. Then we take $\check{\R}\_{p_i} = 
\check{\R}\_{p_{i - 1}} [\check{f}\_{i}]$ if $\varphi = \exp z$ or 
$\check{\R}\_{p_i} = \check{\R}\_{p_{i - 1}} [\check{f}\_{i}, 1 / (1 + 
\check{f}\_{i})]$ otherwise, and one the relations

\begin{eqnarray*}
  \partial f\_{i} & = & - (\partial f\_{j}) f\_{i}^2 ;\\\\\\
  \partial f\_{i} & = & (\partial f\_{j}) f\_{i} ;\\\\\\
  \partial f\_{i} & = & \frac{\partial f\_{j}}{1 + f\_{j}}
\end{eqnarray*}

holds for all $\partial \in \lbrace \partial \_{1}, \ldots, \partial \_{k} 
\rbrace$. Notice that the pseudo-norm of $\check{f}\_{i}$ is bounded by $i$ 
(whence by $\chi$) for all $i$. Consequently, the $C$ from theorem 
[18](#val-bound) is bounded by $2 \chi$ at each stage. By induction over $i$, 
it therefore follows that $\xi \_{\R_i} (s) \leqslant (4 k \chi)^{\frac{9^{i - 
1} - 1}{8}} s^{9^{i - 1}}$ for all $i \geqslant 1$. If $f \neq 0$, we conclude 
that $|\boldsymbol{v}(f) | \leqslant \xi \_{\R_{\chi}} (\chi) \leqslant (4 k 
\chi)^{9^{\chi}} = k^{O (1)^{\chi}}$.

**Bibliography not implemented for raw Markdown**