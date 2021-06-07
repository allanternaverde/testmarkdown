<TeXmacs|0.3.5.12>

<style|article>

<\body>
  <surround|<with|mode|math|<assign|S|<with|math
  font|cal|S>><assign|R|<with|math font|cal|R>><assign|F|<with|math
  font|cal|F>><assign|C|<with|math font|cal|C>><assign|E|<with|math
  font|cal|E>>>||<\expand|make-title>
    <title|Complexity bounds for zero-test algorithms>

    <author|John Shackell<with|mode|math|<rprime|\<dag\>>> and Joris van der
    Hoeven<with|mode|math|<rprime|\<dag\>\<dag\>>>>

    <address|<with|font size|0.84|<tabular|<tformat|<cwith|1|-1|1|-1|cell
    mode|c>|<table|<row|<cell|<with|mode|math|<rprime|\<dag\>>>>|<cell|Depart\
    ment of Mathematics>|<cell|<space|1cm|0mm|1mm>>|<cell|<with|mode|math|<rp\
    rime|\<dag\>\<dag\>>>>|<cell|Dépt.<group|> de Mathématiques (bât.<group|>
    425)>>|<row|<cell|>|<cell|University of Kent at
    Canterbury>|<cell|>|<cell|>|<cell|Université
    Paris-Sud>>|<row|<cell|>|<cell|Canterbury>|<cell|>|<cell|>|<cell|91405
    Orsay Cedex>>|<row|<cell|>|<cell|England>|<cell|<space|1fn|-0.5fn|0.5fn>>\
    |<cell|>|<cell|France>>|<row|<cell|>|<cell|<with|font
    family|tt|jrs@ukc.ac.uk>>|<cell|>|<cell|>|<cell|<with|font
    family|tt|Joris.Vanderhoeven@math.u-psud.fr>>>>>>>>

    <expand|title-date|November 14, 2001>
  </expand>>

  <abstract|In this paper, we analyze the complexity of a zero test for
  expressions built from formal power series solutions of first order
  differential equations with non degenerate initial conditions. We will
  prove a doubly exponential complexity bound. This bound establishes a power
  series analogue for ``witness conjectures''.<vspace|0.5fn>>

  <section|Introduction>

  Zero equivalence is a major issue on the analysis side of symbolic
  computation. Standard mathematical notation provides a way of representing
  many transcendental functions. However, trivial cases apart, this notation
  gives rise to the following problems:

  <surround||, but they represent the same function.|<\itemize>
    <item>Expressions may not be defined: consider <with|mode|math|1/0>,
    <with|mode|math|log(0)> or <with|mode|math|log(e<rsup|x+y>-e<rsup|x>*e<rs\
    up|y>)>.

    <item>Expressions may be ambiguous: what values should we take for
    <with|mode|math|log(<with|math condensed|true|-1>)> or
    <with|mode|math|<sqrt|z<rsup|2>|>><space|0.4spc>?

    <item>Expressions may be redundant: <with|mode|math|sin<rsup|2>
    x+cos<rsup|2> x> and <with|mode|math|1> are different expressions
  </itemize>>

  Often, one is interested in expressions which represent functions in a
  ring. In that case, the third problem reduces to deciding when a given
  expression represents the zero function.

  As to the first two problems, one has to decide where and how we want our
  functions to be defined. In this paper, we will mainly be concerned with
  expressions that represent multivariate power series. The expressions will
  then be formed from the constants and the indeterminates using the ring
  operations and power series solutions to first-order differential
  equations. The correctness and non-ambiguity of expressions may then be
  ensured by structural induction. This may involve zero-testing for the
  series represented by subexpressions.

  <subsection|Zero-tests for constants>

  As a first step, one would like to be able to solve zero-equivalence for
  the elementary constants, that is to say the smallest field of constants
  closed under the application of the exponential, trigonometric and (for
  non-zero argument) logarithmic functions. Alas no such algorithm is known
  and it is clear that some formidable problems in transcendental number
  theory would need to be solved before one was found. In the face of this
  dilemma implementers have used heuristic methods generally involving
  floating-point computations.

  Theoreticians have often resorted to the use of an oracle; in other words
  they pre-supposed a solution to the problem for constants. They have then
  gone on to develop other algorithms, for example to decide zero equivalence
  of functions, on this basis. However for elementary constants one can do
  better than merely invoke an oracle.

  <surround|The Schanuel Conjecture may be stated as follows: |Many special
  cases of this are well known unsolved conjectures in transcendental number
  theory. Following work by Lang, <apply|cite|Lang71>, algorithms for
  deciding the signs of elementary constants based on the Schanuel Conjecture
  have been given by Caviness and Prelle, <apply|cite|C/P> and Richardson,
  <apply|cite|Richardson94a>. The conjecture has been shown to imply the
  decidability of the real exponential field,
  <apply|cite|MW95>.|<\expand|quote>
    Let <with|mode|math|\<alpha\><rsub|1>,\<ldots\>,\<alpha\><rsub|k>> be
    complex numbers which are linearly independent over the rational numbers
    <with|mode|math|math font|Bbb*|Q>. Then the transcendence degree of

    <expand|equation*|<with|math font|Bbb*|Q>(\<alpha\><rsub|1>,\<ldots\>,\<a\
    lpha\><rsub|k>,exp(\<alpha\><rsub|1>),\<ldots\>,exp(\<alpha\><rsub|k>)):<\
    with|math font|Bbb*|Q>>

    is at least <with|mode|math|k>.
  </expand>>

  There are definite advantages in using a conjecture from number theory
  rather than heuristic methods, in that it is clear what is being assumed
  and any counter example found would be of considerable mathematical
  interest. However in a practical situation, a zero equivalence method for
  constants is generally needed very often, and here the algorithms based on
  the Schanuel Conjecture are really rather slow.

  Another limitation of the above approach is that it is very hard to see how
  to generalize the Schanuel Conjecture to cover constants given by
  Liouvillian or Pfaffian functions. For the substance of the conjecture is
  that the relations between exponentials and logarithms of numbers are just
  the ones we already know about, but it seems impossible to even formulate
  such a claim when integrals and solutions of differential equations are
  involved.

  <\expand|quote>
    In <apply|cite|vdH:witness>, the following witness conjecture was made.
    Let <with|mode|math|N\<geqslant\>3> and consider the set
    <with|mode|math|<value|E><rsub|N>> of real exp-log expressions such that
    for each subexpression of the form <with|mode|math|exp f> or
    <with|mode|math|log f>, we have <with|mode|math|\|<wide|f|^>\|\<leqslant\\
    >N> resp.<inactive|<group|>> <with|mode|math|N<rsup|-1>\<leqslant\>\|<wid\
    e|f|^>\|\<leqslant\>N>, where <with|mode|math|<wide|f|^>> denotes the
    value of <with|mode|math|f> as a real constant. Then there exists a
    <em|witness function> of the form <with|mode|math|\<varpi\>(n)=C<rsub|N>*\
    n> such that for any <with|mode|math|f\<in\><value|E><rsub|N>> of size
    <with|mode|math|\<chi\>(f)>, it suffices to evaluate
    <with|mode|math|<wide|f|^>> up to <with|mode|math|\<varpi\>(\<chi\>(f))>
    digits in order to determine whether it vanishes.
  </expand>

  Earlier versions and variants of witness conjectures appeared in
  <apply|cite|vdHoeven97|vdH:singhol|Rich01|vdH:witness>. Also, Dan
  Richardson has accumulated numerical evidence and worked out some
  number-theoretic consequences. It should be noticed that these conjectures
  are independent of the Schanuel conjecture. Indeed, there might exist non
  zero elementary constants, which yet evaluate to extremely small numbers.
  On the other hand, there might exist counterexamples to the Schanuel
  conjecture which can be ``detected'' to be zero by evaluating a reasonable
  number of digits. The interest of witness conjectures is that they
  potentially provide us with fast zero tests, if they can be proved to to
  hold for reasonably small witness functions <with|mode|math|\<varpi\>>.

  <subsection|Zero-tests for functions>

  Although zero-test algorithms for constants are extremely hard to design,
  more progress has been made on zero-tests for functions <apply|cite|Sh3>,
  <apply|cite|Sh4>, <apply|cite|Peladan95>. Unfortunately, no reasonable
  complexity bounds (i.e.<group|> less that the Ackermann function) for these
  algorithms were known up till now. In this paper, we both generalize the
  algorithm from <apply|cite|Sh3> to the multivariate setting and provide
  complexity bounds.

  Now it is interesting to study the significance of such bounds for the
  exp-log constant conjecture. Indeed, since number theoretical questions
  about transcendence or Diophantine approximation are usually very hard, a
  first step usually consists of formulating analogue questions in the
  setting of function fields. A deep and well-known theorem of Ax
  <apply|cite|Ax71> states that the power series part of Schanuel's
  conjecture does hold.

  The exp-log conjecture also admits a natural power series analogue. Given a
  field <with|mode|math|<value|C>>, consider the set
  <with|mode|math|<with|math font|cal|E><rsub|k>> of multivariate power
  series expressions constructed from <with|mode|math|<value|C>> and
  <with|mode|math|z<rsub|1>,\<ldots\>,z<rsub|k>> using
  <with|mode|math|<group|+>,<group|->,<format|no line
  break><group|\<times\>>> and left composition of infinitesimal series by
  <with|mode|math|1/(1+z)>, <with|mode|math|exp z> and <with|mode|math| log
  (1+z)>. Now let <with|mode|math|f\<in\><with|math font|cal|E><rsub|k>> be
  such an expression of size <with|mode|math|\<chi\>(f)> and let
  <with|mode|math|\<rho\>(f)\<in\><value|C>[[z<rsub|1>,\<ldots\>,z<rsub|k>]]>
  be the power series represented by <with|mode|math|f>. Then we expect that
  there exists a constant <with|mode|math|C<rsub|k>>, such that
  <with|mode|math|\<rho\>(f)=0> if and only if the coefficient of
  <with|mode|math|z<rsub|1><rsup|\<alpha\><rsub|1>>*\<cdots\>*z<rsub|k><rsup|\
  \<alpha\><rsub|k>>> in <with|mode|math|\<rho\>(f)> vanishes for all
  <with|mode|math|\<alpha\><rsub|1>,\<ldots\>,\<alpha\><rsub|k>\<in\>{0,\<ldo\
  ts\>,C<rsub|k>*\<chi\>(f)}>.

  As a side effect of our complexity bounds, we will be able to prove a
  weaker result: with the above notation, there exists a constant
  <with|mode|math|C>, such that <with|mode|math|\<rho\>(f)> vanishes if and
  only if the coefficient of <with|mode|math|z<rsub|1><rsup|\<alpha\><rsub|1>\
  >*\<cdots\>*z<rsub|k><rsup|\<alpha\><rsub|k>>> in
  <with|mode|math|\<rho\>(f)> vanishes for all
  <with|mode|math|\<alpha\><rsub|1>,\<ldots\>,\<alpha\><rsub|k>\<in\>{0,\<ldo\
  ts\>,k<rsup|C<rsup|\<chi\>(f)>>}>. Just as the Ax theorem gives theoretical
  evidence that for the numerical Schanuel conjecture, our result thereby
  gives evidence that the numerical witness conjecture might be true.

  <subsection|Overview>

  In section <reference|setup>, we describe our setup of <em|effective local
  domains> for doing computations on power series. Such computations may
  either be effective zero-tests or the extraction of coefficients. We will
  next consider the extension of effective local domains by solutions to
  first order partial differential equations. In section <reference|zt-alg>,
  we will show that such extensions are again effective local domains.

  In section 3, we recall the Bareiss method for Gaussian elimination of
  matrices with coefficients in an integral domain. This method has the
  advantage of limiting the expression swell. More precisely, we give bounds
  in terms of <em|pseudo-norms> on integral domains. In the sequel, the
  Bareiss method is applied to the efficient g.c.d.<inactive|<group|>>
  computation of several polynomials. This is an essential improvement with
  respect to <apply|cite|Sh3>, which allows us to obtain ``reasonable''
  complexity bounds for our zero test.

  In section 4, we prove four key lemmas which ensure the correctness of our
  zero test. We also corrected a small mistake in the original correctness
  proof in <apply|cite|Sh3>. In section <format|no line
  break><reference|zt-alg> we present the actual algorithm and complexity
  bounds.

  In the case of power series over the real numbers, it is possible to obtain
  better theoretical bounds using techniques from <apply|cite|Khov91>.
  Nevertheless, we think that the results of this paper are interesting from
  several point of views:

  <\itemize>
    <item>The framework is more general, because we show how to obtain
    complexity bounds in a relative way for extensions of effective local
    domains.

    <item>We presented an improved version of an actual zero-test algorithm,
    which might have a better average complexity than Khovanskii's complexity
    bounds, although we have not yet proved a better bound for the worst
    case.

    <item>Our methods are likely to generalize to higher order differential
    equations, by adapting the algorithm from <apply|cite|Sh4>.
  </itemize>

  We plan to improve our complexity bounds in a forthcoming paper, with the
  hope of obtaining bounds closer to those in <apply|cite|Khov91>.

  <section|The main setup><label|setup>

  <subsection|Effective local domains>

  Let <with|mode|math|<value|C>> be an effective field of constants, which
  means that all field operations can be performed algorithmically and that
  we have an effective zero test. The ring
  <with|mode|math|<value|C>[[z<rsub|1>,\<ldots\>,z<rsub|k>]]> is a
  differential ring for the partial differentiations
  <with|mode|math|\<partial\><rsub|1>,\<ldots\>,\<partial\><rsub|k>>
  w.r.t.<group|> <with|mode|math|z<rsub|1>,\<ldots\>,z<rsub|k>> on
  <with|mode|math|<value|C>[[z<rsub|1>,\<ldots\>,z<rsub|k>]]>.

  We will frequently consider multivariate power series in
  <with|mode|math|<value|C>[[z<rsub|1>,\<ldots\>,z<rsub|k>]]> as recursive
  power series in <with|mode|math|<value|C>[[z<rsub|1>]]\<cdots\>[[z<rsub|k>]\
  ]>. For this reason, it is convenient to introduce the partial evaluation
  mappings

  <expand|eqnarray*|<tformat|<table|<row|<cell|\<varepsilon\><rsub|i>:<value|\
  C>[[z<rsub|1>,\<ldots\>,z<rsub|j>]]>|<cell|\<longrightarrow\>>|<cell|<value\
  |C>[[z<rsub|1>,\<ldots\>,z<rsub|i>]];>>|<row|<cell|f(z<rsub|1>,\<ldots\>,z<\
  rsub|j>)>|<cell|\<longmapsto\>>|<cell|f(z<rsub|1>,\<ldots\>,z<rsub|i>,0,\<l\
  dots\>,0)>>>>>

  for all <with|mode|math|0\<leqslant\>i\<leqslant\>j\<leqslant\>k>. We
  re-obtain the total evaluation mappings
  <with|mode|math|\<varepsilon\>=\<varepsilon\><rsub|0>> as special cases.
  Notice that

  <expand|equation*|\<partial\><rsub|i> \<varepsilon\><rsub|j>(f)=\<varepsilo\
  n\><rsub|j>(\<partial\><rsub|i> f),>

  for every <with|mode|math|f\<in\><value|C>[[z<rsub|1>,\<ldots\>,z<rsub|k>]]\
  > and <with|mode|math|1\<leqslant\>i\<leqslant\>j\<leqslant\>k>.

  <definition|A differential subring <with|mode|math|<apply|R>> of
  <with|mode|math|<value|C>[[z<rsub|1>,\<ldots\>,z<rsub|k>]]> is called an
  <with|font series|bold|effective power series domain>, if we have
  algorithms for <with|mode|math|+,-,\<times\>,\<varepsilon\>,\<partial\><rsu\
  b|1>,\<ldots\>,\<partial\><rsub|k>> and an algorithm to test whether
  <with|mode|math|\<varepsilon\><rsub|i>(f)=0> for each
  <with|mode|math|0\<leqslant\>i\<leqslant\>k> and
  <with|mode|math|f\<in\><apply|R>>.>

  <remark|Given an effective power series domain
  <with|mode|math|<apply|R>\<subseteq\><value|C>[[z<rsub|1>,\<ldots\>,z<rsub|\
  k>]]>, we observe that <with|mode|math|\<varepsilon\><rsub|i>(<apply|R>)\<s\
  ubseteq\><value|C>[[z<rsub|1>,\<ldots\>,z<rsub|i>]]> may be considered as
  an effective power series domain for each
  <with|mode|math|1\<leqslant\>i\<leqslant\>k>. Indeed, this follows from the
  fact that <with|mode|math|\<varepsilon\><rsub|i>> commutes with
  <with|mode|math|+,-,\<times\>,\<varepsilon\><rsub|0>,\<ldots\>,\<varepsilon\
  \><rsub|i>,\<partial\><rsub|1>,\<ldots\>,\<partial\><rsub|i>>.>

  Let <with|mode|math|<apply|R>> be an effective power series domain and let
  <with|mode|math|f> be a power series in
  <with|mode|math|<value|C>[[z<rsub|1>,\<ldots\>,z<rsub|k>]]>, which
  satisfies partial differential equations

  <equation|<label|pde><left|{><expand|tabular*|<tformat|<table|<row|<cell|\<\
  partial\><rsub|1> f=<frac|A<rsub|1>(f)|B<rsub|1>(f)>>>|<row|<cell|\<vdots\>\
  >>|<row|<cell|\<partial\><rsub|k> f=<frac|A<rsub|k>(f)|B<rsub|k>(f)>>>>>>>

  where <with|mode|math|A<rsub|i>,B<rsub|i>\<in\><apply|R>[F]> are such that
  <with|mode|math|\<varepsilon\>(B<rsub|i>(f))\<neq\>0> for each
  <with|mode|math|i>. Then the ring

  <expand|equation*|<apply|S>=<apply|R><left|[>f,<frac|1|B<rsub|1>(f)>,\<ldot\
  s\>,<frac|1|B<rsub|k>(f)><right|]>>

  is a differential subring of <with|mode|math|<value|C>[[z<rsub|1>,\<ldots\>\
  ,z<rsub|k>]]>, which is called a <with|font shape|italic|regular
  D-algebraic extension> of <with|mode|math|<apply|R>>. The main aim of this
  paper is to show that <with|mode|math|<apply|S>> is also an effective power
  series domain and to give complexity bounds for the corresponding
  algorithms.

  <subsection|Computations in <with|mode|math|<apply|S>>>

  Elements in <with|mode|math|<apply|R>[f]> are naturally represented by
  polynomials <with|mode|math|<apply|R>[F]> in a formal variable
  <with|mode|math|F>, via the unique <with|mode|math|<apply|R>>-algebra
  morphism <with|mode|math|\<rho\>:<apply|R>[F]\<rightarrow\><apply|R>[f]>
  with <with|mode|math|\<rho\>(F)=f>. This mapping <with|mode|math|\<rho\>>
  naturally extends to a mapping <with|mode|math|\<rho\>:<wide|<apply|S>|\<ch\
  eck\>>\<rightarrow\><apply|S>>, where

  <expand|equation*|<wide|<apply|S>|\<check\>>=<apply|R><left|[>F,<frac|1|B<r\
  sub|1>(F)>,\<ldots\>,<frac|1|B<rsub|k>(F)><right|]>\<subseteq\><apply|R>(F)\
  >

  The structure of <with|mode|math|<apply|S>> may be transported to
  <with|mode|math|<wide|<apply|S>|\<check\>>> in a natural way. The partial
  differentiations <with|mode|math|\<partial\><rsub|1>,\<ldots\>,\<partial\><\
  rsub|k>> on <with|mode|math|<apply|R>> extend uniquely to
  <with|mode|math|<wide|<apply|S>|\<check\>>> by setting
  <with|mode|math|\<partial\><rsub|i> F=A<rsub|i>(F)/B<rsub|i>(F)> for each
  <with|mode|math|i> (so that <with|mode|math|\<rho\>\<circ\>\<partial\><rsub\
  |i>=\<partial\><rsub|i>\<circ\>\<rho\>>). Each partial evaluation mapping
  <with|mode|math|\<varepsilon\><rsub|i>:<apply|S>\<rightarrow\><value|C>>
  induces a natural evaluation mapping <with|mode|math|\<varepsilon\><rsub|i>\
  \<circ\>\<rho\>> on <with|mode|math|<wide|<apply|S>|\<check\>>>, which we
  will also denote by <with|mode|math|\<varepsilon\><rsub|i>>. Since
  <with|mode|math|<apply|R>> is an effective local domain, the operations
  <with|mode|math|<group|+>,<group|->,<group|\<times\>>,\<varepsilon\>,\<part\
  ial\><rsub|1>,\<ldots\>,\<partial\><rsub|k>> can clearly be performed
  algorithmically on <with|mode|math|<apply|S>>. Our main problem will
  therefore be to design a zero-test for <with|mode|math|<apply|S>>, which
  amounts to deciding whether <with|mode|math|\<rho\>(P/Q)=0> for a given
  rational function <with|mode|math|P/Q\<in\><wide|S|\<check\>>>.

  Actually, it is more convenient to work with polynomials in
  <with|mode|math|<apply|R>[F]> instead of rational functions in <format|no
  line break><with|mode|math|<wide|<apply|S>|\<check\>>>. Our main problem
  will then be to decide whether <with|mode|math|\<rho\>(P)=0> for
  <with|mode|math|P\<in\><apply|R>[F]>, since a rational function
  <with|mode|math|P/Q\<in\><wide|<apply|S>|\<check\>>> represents zero if and
  only if <with|mode|math|P> does. Unfortunately, the ring
  <with|mode|math|<apply|R>[F]> is not necessarily stable under the
  derivations <with|mode|math|\<partial\><rsub|1>,\<ldots\>,\<partial\><rsub|\
  k>>. For this reason, we introduce the derivations

  <expand|equation*|d<rsub|i>=B<rsub|i>(F)*\<partial\><rsub|i>,>

  which do map <with|mode|math|<apply|R>[F]> into itself.

  In order to determine whether <with|mode|math|\<rho\>(P)=0> for polynomials
  <with|mode|math|P\<in\><apply|R>[F]>, we will consider the roots of such
  polynomials in the algebraic closure <with|mode|math|<apply|R><rsup|alg>>
  of <with|mode|math|<apply|R>>. Now it is classical that the algebraic
  closure of the ring <with|mode|math|K[[z]]> of univariate power series over
  a field <with|mode|math|K> is the field
  <with|mode|math|K<rsup|alg>\<llangle\>z\<rrangle\>> of Puiseux series over
  the algebraic closure <with|mode|math|K<rsup|alg>> of <with|mode|math|K>.
  Interpreting multivariate power series in
  <with|mode|math|<value|C>[[z<rsub|1>,\<ldots\>,z<rsub|k>]]> as recursive
  power series in <with|mode|math|<value|C>[[z<rsub|1>]]\<cdots\>[[z<rsub|k>]\
  ]>, we may thus view elements in <with|mode|math|<apply|R><rsup|alg>> as
  recursive Puiseux series in <with|mode|math|<value|C><rsup|alg>\<llangle\>z\
  <rsub|1>\<rrangle\>\<cdots\>\<llangle\>z<rsub|k>\<rrangle\>>.

  <subsection|Extraction of coefficients>

  We define the anti-lexicographical ordering <with|mode|math|\<leqslant\>>
  on <with|mode|math|<with|math font|Bbb*|Q><rsup|k>> by

  <expand|eqnarray*|<tformat|<table|<row|<cell|<with|math font
  series|bold|\<alpha\>>\<leqslant\><with|math font
  series|bold|\<beta\>>>|<cell|\<Longleftrightarrow\>>|<cell|(\<alpha\><rsub|\
  1><rsub|>=\<beta\><rsub|1>\<wedge\>\<cdots\>\<wedge\>\<alpha\><rsub|k>=\<be\
  ta\><rsub|k>)\<vee\>>>|<row|<cell|>|<cell|>|<cell|(\<alpha\><rsub|1><rsub|>\
  \<less\>\<beta\><rsub|1>\<wedge\>\<alpha\><rsub|2>=\<beta\><rsub|2>\<wedge\\
  >\<cdots\>\<wedge\>\<alpha\><rsub|k>=\<beta\><rsub|k>)\<vee\>>>|<row|<cell|\
  >|<cell|>|<cell|\<vdots\>>>|<row|<cell|>|<cell|>|<cell|(\<alpha\><rsub|k>\<\
  less\>\<beta\><rsub|k>),>>>>>

  for <with|mode|math|<with|math font series|bold|\<alpha\>>=(\<alpha\><rsub|\
  1>,\<ldots\>,<format|no line break>\<alpha\><rsub|k>),<with|math font
  series|bold|\<beta\>>=(\<beta\><rsub|1>,\<ldots\>,<format|no line
  break>\<beta\><rsub|k>)\<in\><with|math font|Bbb*|Q><rsup|k>>.

  Consider a Puiseux series <with|mode|math|\<varphi\>\<in\><value|C>\<llangl\
  e\>z<rsub|1>\<rrangle\>\<cdots\>\<llangle\>z<rsub|k>\<rrangle\>>. We will
  write

  <expand|equation*|\<varphi\>=<big|sum><rsub|\<alpha\>>\<varphi\><rsub|\<alp\
  ha\>>*z<rsub|k><rsup|\<alpha\>>>

  for the power series expansion of <with|mode|math|\<varphi\>>
  w.r.t.<group|> <with|mode|math|z<rsub|k>>. Each coefficient may recursively
  be expanded in a similar way w.r.t.<group|>
  <with|mode|math|z<rsub|k-1>,\<ldots\>,z<rsub|1>>. Alternatively, we may
  expand <with|mode|math|\<varphi\>> at once w.r.t.<group|> all variables
  using the anti-lexicographical ordering:

  <expand|equation*|\<varphi\>=<big|sum><rsub|<with|math font
  series|bold|\<alpha\>>>\<varphi\><rsub|<with|math font
  series|bold|\<alpha\>>>*z<rsup|<with|math font series|bold|\<alpha\>>>,>

  where <with|mode|math|z<rsup|<with|math font
  series|bold|\<alpha\>>>=z<rsub|1><rsup|\<alpha\><rsub|1>>*\<cdots\>*z<rsub|\
  k><rsup|\<alpha\><rsub|k>>>. If <with|mode|math|f\<neq\>0>, then the
  minimal <with|mode|math|math font series|bold|\<alpha\>> with
  <with|mode|math|\<varphi\><rsub|<with|math font
  series|bold|\<alpha\>>>\<neq\>0> is called the valuation of
  <with|mode|math|\<varphi\>> and we denote it by <with|mode|math|<with|math
  font series|bold|v>(\<varphi\>)>. If <with|mode|math|<with|math font
  series|bold|v>(\<varphi\>)\<geqslant\><with|math font series|bold|0>>, then
  may we define <with|mode|math|\<varepsilon\><rsub|i>(\<varphi\>)> to be the
  coefficient of <with|mode|math|z<rsub|i+1><rsup|0>*\<cdots\>*z<rsub|k><rsup\
  |0>> in <with|mode|math|\<varphi\>>, for each
  <with|mode|math|i\<in\>{0,\<ldots\>,k}>. As usual, we denote
  <with|mode|math|\<varepsilon\>(\<varphi\>)=\<varepsilon\><rsub|0>(\<varphi\\
  >)>.

  If <with|mode|math|P\<in\><apply|R>[F]> is a non zero polynomial, then we
  define the valuation <with|mode|math|<with|math font series|bold|v>(P)> of
  <with|mode|math|P> to be the minimum of the valuations of its non zero
  coefficients. If <with|mode|math|P> has degree <with|mode|math|d>, then we
  also define

  <expand|equation*|P<rsub|<with|math font
  series|bold|\<alpha\>>>(\<lambda\>)=P<rsub|d,<with|math font
  series|bold|\<alpha\>>>*\<lambda\><rsup|d>+\<cdots\>+P<rsub|0,<with|math
  font series|bold|\<alpha\>>>\<in\><value|C>[\<lambda\>],>

  for each <with|mode|math|<with|math font
  series|bold|\<alpha\>>\<in\><with|math font|Bbb*|N><rsup|k>>.

  It should be noticed that the recursive extraction of coefficients can be
  done effectively in an effective power series domain
  <with|mode|math|<apply|R>>, because

  <expand|equation*|\<varphi\><rsub|\<alpha\><rsub|k>,\<ldots\>,\<alpha\><rsu\
  b|i+1>>=<frac|1|\<alpha\><rsub|k>!*\<cdots\>*\<alpha\><rsub|i+1>!>*\<vareps\
  ilon\><rsub|i>(\<partial\><rsub|k><rsup|\<alpha\><rsub|k>>*\<cdots\>*\<part\
  ial\><rsub|i+1><rsup|\<alpha\><rsub|i+1>> \<varphi\>)>

  for all <with|mode|math|\<varphi\>\<in\><apply|R>> and
  <with|mode|math|\<alpha\><rsub|k>,\<ldots\>,\<alpha\><rsub|i+1>\<in\><with|\
  math font|Bbb*|N>>. More generally, if <with|mode|math|P\<in\><wide|<apply|\
  S>|\<check\>>>, then we may formally represent the coefficient
  <with|mode|math|\<varphi\><rsub|\<alpha\><rsub|k>,\<ldots\>,\<alpha\><rsub|\
  i+1>>> of <with|mode|math|\<varphi\>=\<rho\>(P)> by polynomials in
  <with|mode|math|\<varepsilon\><rsub|i>(<wide|<apply|S>|\<check\>>)>. Such
  representations are best derived through relaxed evaluation of formal power
  series <apply|cite|VdH:relax>, by using the partial differential equations
  satisfied by <with|mode|math|f>.

  <section|The Bareiss method and g.c.d.<inactive|<group|>>
  computations><label|Bareiss>

  <subsection|Pseudo-norms>

  Let <with|mode|math|<value|R>> be an effective integral domain. In what
  follows, we will describe algorithms to triangulate matrices with entries
  in <with|mode|math|<value|R>> and compute g.c.d.s of polynomials with
  coefficients in <with|mode|math|<value|R>>. In order to state complexity
  bounds, it is convenient to measure the ``sizes'' of constants in
  <with|mode|math|<apply|R>> in terms of a <with|font
  shape|italic|pseudo-norm>, which is a function
  <with|mode|math|\<nu\>:<apply|R>\<rightarrow\><with|math font|Bbb*|N>> with
  the following properties:

  <\description>
    <expand|item*|N1.><with|mode|math|\<nu\>(\<varphi\>+\<psi\>)\<leqslant\>m\
    ax{\<nu\>(\<varphi\>),\<nu\>(\<psi\>)}>.

    <expand|item*|N2.><with|mode|math|\<nu\>(\<varphi\>*\<psi\>)\<leqslant\>\\
    <nu\>(\<varphi\>)+\<nu\>(\<psi\>)>.
  </description>

  If <with|mode|math|<apply|R>> is actually a differential ring with
  derivations <with|mode|math|\<partial\><rsub|1>,\<ldots\>,\<partial\><rsub|\
  k>>, then we also assume the existence of a constant
  <with|mode|math|K<rsub|<apply|R>>\<in\><with|math font|Bbb*|N>> with

  <description|<expand|item*|N3.><with|mode|math|\<nu\>(\<partial\><rsub|i>
  \<varphi\>)\<leqslant\>\<nu\>(\<varphi\>)+K<rsub|<apply|R>>>.>

  <example|If <with|mode|math|<apply|R>=<value|C>[z<rsub|1>,\<ldots\>,z<rsub|\
  k>]>, then we may take <with|mode|math|\<nu\>(P)> to be the maximum of the
  degrees of <with|mode|math|P> in <with|mode|math|z<rsub|1>,\<ldots\>,<forma\
  t|no line break>z<rsub|k>> and <with|mode|math|K<rsub|<apply|R>>=0>.>

  <\example>
    Assume that <with|mode|math|<apply|R>> and <with|mode|math|<apply|S>> are
    as in section <reference|setup> and assume that we have a pseudo-norm
    <with|mode|math|\<nu\>> on <with|mode|math|<apply|R>>. Then we define a
    pseudo-norm on <with|mode|math|<wide|<apply|S>|\<check\>>> by

    <expand|equation*|\<nu\>(P)=max <left|{>deg<rsub|F>
    P,deg<rsub|B<rsub|1>(F)<rsup|-1>> P,\<ldots\>,deg<rsub|B<rsub|k>(F)<rsup|\
    -1>> P,max<rsub|P<rsub|\<ast\>><rsub|*><with|mode|text| coefficient of
    >P>\<nu\>(P<rsub|\<ast\>>)<right|}>.>

    This pseudo-norm induces a pseudo-norm on <with|mode|math|<apply|S>> by

    <expand|equation*|\<nu\>(\<varphi\>)=min<left|{>\<nu\>(P)<mid|\|>P\<in\><\
    wide|<apply|S>|\<check\>>,\<varphi\>=\<rho\>(P)<right|}>.>

    Notice that we may take

    <expand|equation*|K<rsub|<apply|S>>=K<rsub|<wide|<apply|S>|\<check\>>>=ma\
    x <left|{>K<rsub|<apply|R>>,2,max {\<nu\>(A<rsub|1>),\<ldots\>,\<nu\>(A<r\
    sub|k>)}+max <left|{>\<nu\><with|formula
    style|false|<left|(><frac|\<partial\> B<rsub|1>|\<partial\>
    F>><right|)>,\<ldots\>,\<nu\><left|(><with|formula
    style|false|<frac|\<partial\> B<rsub|k>|\<partial\>
    F>><right|)><right|}><right|}>.>
  </example>

  <subsection|The Bareiss method>

  Let <with|mode|math|<value|R>> still be an effective integral domain with a
  pseudo-norm <with|mode|math|\<nu\>> and quotient field
  <with|mode|math|<value|F>>. Consider an <with|mode|math|m\<times\>n> matrix
  <with|mode|math|M> with entries in <with|mode|math|<value|F>>
  (i.e.<inactive|<group|>> a matrix with <with|mode|math|m> rows and
  <with|mode|math|n> columns). For all indices
  <with|mode|math|1\<leqslant\>i<rsub|1>\<less\>\<cdots\>\<less\>i<rsub|k>\<l\
  eqslant\>m> and <with|mode|math|1\<leqslant\>j<rsub|1>\<less\>\<cdots\>\<le\
  ss\>j<rsub|l>\<leqslant\>n>, we will also write
  <with|mode|math|><with|mode|math|M<rsub|[i<rsub|1>,\<ldots\>,i<rsub|k>],[j<\
  rsub|1>,\<ldots\>,j<rsub|l>]>> for the <with|mode|math|k\<times\>l> minor
  of <with|mode|math|M> when we only keep the rows
  <with|mode|math|i<rsub|1>,\<ldots\>,i<rsub|k>> and columns
  <with|mode|math|j<rsub|1>,\<ldots\>,j<rsub|l>>.

  It is classical that we may upper triangulate <with|mode|math|M> using
  Gaussian elimination. This leads to a formula

  <expand|equation*|T=U*M,>

  where <with|mode|math|U> is a matrix with determinant one and
  <with|mode|math|T> an upper triangular matrix. Unfortunately, this process
  usually leads to a fast coefficient growth for the numerators of the
  entries of the successive matrices. In order to remove this drawback, we
  will rather do all computations over <with|mode|math|<value|R>> instead of
  <with|mode|math|<value|F>>. This approach is due to <apply|cite|Bar68>.

  So let us now be given an <with|mode|math|m\<times\>n> matrix
  <with|mode|math|M> with entries in <with|mode|math|<value|R>>. For
  simplicity, we will first assume that the usual triangulation of
  <with|mode|math|M> as a matrix with entries in <with|mode|math|<value|F>>
  does not involve row permutations. This usual triangulation of
  <with|mode|math|M> gives rise to a sequence of identities

  <expand|equation*|<wide|T|\<bar\>><rsub|k>=<wide|U|\<bar\>><rsub|k>*M,>

  with <with|mode|math|k\<in\>{0,\<ldots\>,m}>, where
  <with|mode|math|<wide|T|\<bar\>><rsub|k>> is the matrix obtained from
  <with|mode|math|M=<wide|T|\<bar\>><rsub|0>> after <with|mode|math|k> steps.
  More precisely, <with|mode|math|<wide|T|\<bar\>><rsub|k>> is obtained from
  <with|mode|math|<wide|T|\<bar\>><rsub|k-1>> by leaving the first
  <with|mode|math|k> rows invariant and by adding multiples of the
  <with|mode|math|k>-th row to the others (in particular, the
  <with|mode|math|<wide|U|\<bar\>><rsub|k>> will be lower triangular
  throughout the process). If there exists a <with|mode|math|q> with
  <with|mode|math|(<wide|T|\<bar\>><rsub|k>)<rsub|k,q>\<neq\>0>, then let
  <with|mode|math|p<rsub|k>> be the minimal such <with|mode|math|q>, so that
  <with|mode|math|(<wide|T|\<bar\>><rsub|k>)<rsub|l,r>=0> for all
  <with|mode|math|l\<gtr\>k> and <with|mode|math|r\<less\>p<rsub|k>>. Each
  <with|mode|math|<wide|T|\<bar\>><rsub|k>> may be rewritten as a product

  <expand|equation*|<wide|T|\<bar\>><rsub|k>=D<rsub|k><rsup|-1>*T<rsub|k>,>

  of an invertible diagonal matrix <with|mode|math|D<rsub|k>> and another
  matrix <with|mode|math|T<rsub|k>> with entries in
  <with|mode|math|><with|mode|math|<value|R>>. Our aim is to show that we may
  choose the <with|mode|math|D<rsub|k>> and <with|mode|math|T<rsub|k>> of
  small pseudo-norms. In fact, we claim that we may take
  <with|mode|math|D<rsub|k>=Diag (1,\<delta\><rsub|1>,\<ldots\>,\<delta\><rsu\
  b|k-2>,\<delta\><rsub|k-1>,\<delta\><rsub|k-1>,\<ldots\>,\<delta\><rsub|k-1\
  >)> for each <with|mode|math|k>, where <with|mode|math|\<delta\><rsub|k>=(T\
  <rsub|k>)<rsub|k,p<rsub|k>>>.

  In order to see this, let <with|mode|math|k\<geqslant\>1>,
  <with|mode|math|i\<gtr\>k-1> and <with|mode|math|j\<gtr\>p<rsub|k-1>>. Then
  we first observe that

  <expand|equation*|(<wide|T|\<bar\>><rsub|k>)<rsub|[1,\<ldots\>,k-1,i],[p<rs\
  ub|1>,\<ldots\>,p<rsub|k-1>,j]>=<wide|U|\<bar\>><rsub|k,[1,\<ldots\>,k-1,i]\
  ,[1,\<ldots\>,k-1,i]>*M<rsub|[1,\<ldots\>,k-1,i],[p<rsub|1>,\<ldots\>,p<rsu\
  b|k-1>,j]>.>

  Since <with|mode|math|<wide|U|\<bar\>><rsub|k,[1,\<ldots\>,k-1,i],[1,\<ldot\
  s\>,k-1,i]>> is a lower triangular matrix with ones on its diagonal, we
  obtain

  <expand|equation*|det (<wide|T|\<bar\>><rsub|k>)<rsub|[1,\<ldots\>,k-1,i],[\
  p<rsub|1>,\<ldots\>,p<rsub|k-1>,j]>=det
  M<rsub|[1,\<ldots\>,k-1,i],[p<rsub|1>,\<ldots\>,p<rsub|k-1>,j]>>

  Since <with|mode|math|(<wide|T|\<bar\>><rsub|k>)<rsub|[1,\<ldots\>,k-1,i],[\
  p<rsub|1>,\<ldots\>,p<rsub|k-1>,j]>> is upper triangular, we also have

  <expand|equation*|det (<wide|T|\<bar\>><rsub|k>)<rsub|[1,\<ldots\>,k-1,i],[\
  p<rsub|1>,\<ldots\>,p<rsub|k-1>,j]>=(<wide|T|\<bar\>><rsub|k>)<rsub|1,p<rsu\
  b|1>>*\<cdots\>*(<wide|T|\<bar\>><rsub|k>)<rsub|k-1,p<rsub|k-1>>*(<wide|T|\\
  <bar\>><rsub|k>)<rsub|i,j>.>

  By our choice of <with|mode|math|D<rsub|k>>, we finally have

  <expand|equation*|(<wide|T|\<bar\>><rsub|k>)<rsub|1,p<rsub|1>>*\<cdots\>*(<\
  wide|T|\<bar\>><rsub|k>)<rsub|k-1,p<rsub|k-1>>*(<wide|T|\<bar\>><rsub|k>)<r\
  sub|i,j>=<frac|(T<rsub|k>)<rsub|1,p<rsub|1>>*\<cdots\>*(T<rsub|k>)<rsub|k-1\
  ,p<rsub|k-1>>*(T<rsub|k>)<rsub|i,j>|1*\<delta\><rsub|1>*\<cdots\>*\<delta\>\
  <rsub|k-1>>=(T<rsub|k>)<rsub|i,j>.>

  Putting this together, we see that each coefficient of
  <with|mode|math|T<rsub|k>> (whence in particular
  <with|mode|math|\<delta\><rsub|k>>) may be written as the determinant of a
  minor of <with|mode|math|M>:

  <equation|<label|detrel>(T<rsub|k>)<rsub|i,j>=det
  M<rsub|[1,\<ldots\>,k-1,i],[p<rsub|1>,\<ldots\>,p<rsub|k-1>,j]>.>

  Hence, we have not only shown that the <with|mode|math|D<rsub|k>> and
  <with|mode|math|T<rsub|k>> have coefficients in <with|mode|math|<value|R>>,
  but even that they may be written explicitly as determinants of minors of
  <with|mode|math|M>. This result remains so (up to a factor
  <with|mode|math|\<pm\>1>) if row permutations were needed in the
  triangulation process, since we may always permute the rows of
  <with|mode|math|M> <em|a priori>, so that no further row permutations are
  necessary during the triangulations. This proves the following theorem:

  <\theorem>
    <label|Bareisth>There exists an algorithm, which takes an
    <with|mode|math|m\<times\>n> matrix <with|mode|math|M> with entries in
    <with|mode|math|<value|R>> on input, and which computes an invertible
    <with|mode|math|m\<times\>m> diagonal matrix <with|mode|math|D> and an
    <with|mode|math|m\<times\>n> upper triangular matrix <with|mode|math|T>
    with entries in <with|mode|math|<value|R>>, such that there exists a
    matrix <with|mode|math|<wide|U|\<bar\>>> with entries in
    <with|mode|math|<value|F>>, of determinant one, and so that
    <with|mode|math|D<rsup|-1>*T=<wide|U|\<bar\>>*M>. Moreover,
    <with|mode|math|\<nu\>(D)\<leqslant\>min(m,n)*\<nu\>(M)> and
    <with|mode|math|\<nu\>(T)\<leqslant\>min(m,n)*\<nu\>(M)>. Here
    <with|mode|math|\<nu\>(M)=max<rsub|i,j> \<nu\>(M<rsub|i,j>)>.
  </theorem>

  The actual computation of <with|mode|math|T> involves
  <with|mode|math|O(m*n*min(m,n))> elementary operations. If we do have an
  algorithm for exact division in <with|mode|math|T>, then this is also the
  time complexity of the algorithm in terms of operations in
  <with|mode|math|<value|R>>. Otherwise, it may be necessary to compute the
  entries of the intermediate matrices <with|mode|math|T<rsub|k>> by formula
  (<reference|detrel>), which yields an overall complexity of
  <with|mode|math|O(m*n*(min(m,n))<rsup|3>)>.

  <subsection|Computing greatest common divisors of several polynomials>

  Let <with|mode|math|<value|R>> still be an effective integral domain with a
  pseudo-norm <with|mode|math|\<nu\>> and quotient field
  <with|mode|math|<value|F>>. Consider a finite number
  <with|mode|math|P<rsub|1>,\<ldots\>,P<rsub|k>> of polynomials in
  <with|mode|math|<value|R>[F]>. In this section, we address the question of
  computing a g.c.d.<inactive|<group|>> <with|mode|math|G\<in\><value|R>[F]>
  of <with|mode|math|P<rsub|1>,\<ldots\>,P<rsub|k>> and a corresponding
  Bezout relation. Since we are only computing over an integral domain, we
  call <with|mode|math|G> <em|a> g.c.d., if <with|mode|math|G> is a scalar
  multiple of <em|the> g.c.d.<inactive|<group|>> of
  <with|mode|math|P<rsub|1>,\<ldots\>,P<rsub|k>>, when considered as
  polynomials over the quotient field <format|no line
  break><with|mode|math|<value|F>>. Accordingly, a Bezout relation for
  <with|mode|math|P<rsub|1>,\<ldots\>,P<rsub|k>> has the form

  <equation|<label|Bezout>Q<rsub|1>*P<rsub|1>+\<cdots\>+Q<rsub|k>*P<rsub|k>=c\
  *G,>

  where <with|mode|math|Q<rsub|1>,\<ldots\>,Q<rsub|k>\<in\><value|R>[F]> and
  <with|mode|math|c\<in\><value|R><rsup|\<ast\>>>. From the computational
  point of view, we are interested in minimizing the pseudo-norms of
  <with|mode|math|Q<rsub|1>,\<ldots\>,Q<rsub|k>,c> and <with|mode|math|G>. As
  to the degrees, such ``small Bezout relations'' always exist:

  <proposition|Let <with|mode|math|P<rsub|1>,\<ldots\>,P<rsub|k>\<in\><value|\
  R>[F]> be more than one non-zero polynomial. Then there exists a Bezout
  relation <with|font shape|right|(<reference|Bezout>)>, such that
  <with|mode|math|max {deg Q<rsub|i>*P<rsub|i>}\<less\>max {deg P<rsub|i>+deg
  P<rsub|j>\|i\<neq\>j}>.>

  <\proof>
    Assume the contrary and choose a Bezout relation (<reference|Bezout>) of
    minimal degree <with|mode|math|d=max <format|no line break>{deg
    Q<rsub|i>*P<rsub|i>}> and such that the number <with|mode|math|l> of
    indices <with|mode|math|i<rsub|1>\<less\>\<cdots\>\<less\>i<rsub|l>> with
    <with|mode|math|deg Q<rsub|i<rsub|k>>*P<rsub|i<rsub|k>>=d> is minimal.
    Since <with|mode|math|d\<gtr\>deg G>, we must have
    <with|mode|math|l\<gtr\>1>, and modulo a permutation of indices, we may
    assume that <with|mode|math|i<rsub|k>=k> for each <with|mode|math|k>. Let
    <with|mode|math|\<lambda\>> be the leading coefficient of
    <with|mode|math|Q<rsub|1>> and <with|mode|math|\<mu\>> the leading
    coefficient of <with|mode|math|P<rsub|2>>. Then for
    <with|mode|math|\<delta\>=d-deg P<rsub|1>-deg P<rsub|2>\<geqslant\>0>, we
    have

    <expand|equation*|(\<mu\>*Q<rsub|1>-\<lambda\>*x<rsup|\<delta\>>*P<rsub|2\
    >)*P<rsub|1>+(\<mu\>*Q<rsub|2>+\<lambda\>*x<rsup|\<delta\>>*P<rsub|1>)*P<\
    rsub|2>+\<mu\>*Q<rsub|3>*P<rsub|3>+\<cdots\>+\<mu\>*Q<rsub|k>*P<rsub|k>=\\
    <mu\>*c*G,>

    is again a Bezout relation, which contradicts our minimality hypothesis.
  </proof>

  Let <with|mode|math|d=max {deg P<rsub|i>+deg P<rsub|j>\|i\<neq\>j}>. In
  order to actually find a Bezout relation of degree
  <with|mode|math|\<less\>d>, we now consider the matrix <with|mode|math|M>
  with <with|mode|math|m=k*d-deg P<rsub|1>-\<cdots\>-deg P<rsub|k>> rows and
  <with|mode|math|d> columns, which is the vertical superposition of all
  matrices of the form

  <expand|equation*|<left|(><expand|tabular*|<tformat|<table|<row|<cell|P<rsu\
  b|i,r<rsub|i>>>|<cell|\<cdots\>>|<cell|P<rsub|i,0>>|<cell|>|<cell|>|<cell|>\
  |<cell|0>>|<row|<cell|>|<cell|P<rsub|i,r<rsub|i>>>|<cell|\<cdots\>>|<cell|P\
  <rsub|i,0>>|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|>|<cell|>|<cell|>|<\
  cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|>|<cell|\<ddots\>>|<cell|>|<cell\
  |\<ddots\>>|<cell|>|<cell|>>|<row|<cell|>|<cell|>|<cell|>|<cell|>|<cell|>|<\
  cell|>|<cell|>>|<row|<cell|>|<cell|>|<cell|>|<cell|P<rsub|i,r<rsub|i>>>|<ce\
  ll|\<cdots\>>|<cell|P<rsub|i,0>>|<cell|>>|<row|<cell|0>|<cell|>|<cell|>|<ce\
  ll|>|<cell|P<rsub|i,r<rsub|i>>>|<cell|\<cdots\>>|<cell|P<rsub|i,0>>>>>><rig\
  ht|)>,>

  where <with|mode|math|r<rsub|i>=deg P<rsub|i>>. Now triangulate
  <with|mode|math|M> as in the section above

  <equation|<label|trid>D<rsup|-1>*T=<wide|U|\<bar\>>*M>

  and let <with|mode|math|l> be the number of non-zero rows in
  <with|mode|math|T>. The <with|mode|math|l>-th row of <with|mode|math|T>
  corresponds to a polynomial linear combination of
  <with|mode|math|P<rsub|1>,\<ldots\>,P<rsub|k>> of minimal degree. In other
  words, it contains the coefficients of a g.c.d.<inactive|<group|>> of
  <with|mode|math|P<rsub|1>,\<ldots\>,P<rsub|k>>.

  Moreover, we may obtain a Bezout relation when considering the matrix
  <with|mode|math|M> with an <with|mode|math|m\<times\>m> identity matrix
  glued at its right hand side. When triangulating this matrix, we obtain a
  relation of the form

  <expand|equation*|D<rsup|-1>*<left|(><space|0.8spc>T<space|0.5fn>\|<space|0\
  .5fn>T<rprime|'><space|0.6spc><right|)>=<wide|U|\<bar\>>*<left|(><space|0.6\
  spc>M<space|0.5fn>\|<space|0.5fn>Id<space|0.6spc><right|)>=(<space|0.6spc><\
  wide|U|\<bar\>>*M<space|0.5fn>\|<space|0.5fn><wide|U|\<bar\>><space|0.6spc>\
  ),>

  such that the additional part <with|mode|math|T<rprime|'>> of the
  triangulated matrix gives us the transformation matrix <format|no line
  break><with|mode|math|<wide|U|\<bar\>>> in (<reference|trid>) up to the
  diagonal matrix <with|mode|math|D>:

  <expand|equation*|T<rprime|'>=D*<wide|U|\<bar\>>.>

  The finite sum which leads to the <with|mode|math|l>-th row in the product
  <with|mode|math|T<rprime|'>*M> now yields the desired Bezout relation.
  Notice that <with|mode|math|c=1> in this Bezout relation.

  From the complexity point of view, we also notice that at most
  <with|mode|math|d> rows in <with|mode|math|M> may actually have contributed
  to the first <with|mode|math|l\<leqslant\>d> rows of <with|mode|math|T>.
  When replacing <with|mode|math|M> with its restriction to these rows, the
  above triangulations will therefore yield the same
  g.c.d.<inactive|<group|>> and the same Bezout relation. We have proved

  <\theorem>
    <label|gcdth>Let <with|mode|math|P<rsub|1>,\<ldots\>,P<rsub|k>\<in\><appl\
    y|R>[F]> be more than one non-zero polynomials. Then there exists an
    algorithm to compute a g.c.d.<inactive|<group|>> of
    <with|mode|math|P<rsub|1>,\<ldots\>,P<rsub|k>> as well as a Bezout
    relation <with|font shape|right|(<reference|Bezout>)> with
    <with|mode|math|c=1>, such that

    <expand|equation*|max {\<nu\>(G),\<nu\>(Q<rsub|1>),\<ldots\>,\<nu\>(Q<rsu\
    b|k>)}\<leqslant\>2*(max {\<nu\>(P<rsub|1>),\<ldots\>,\<nu\>(P<rsub|k>)})\
    <rsup|2>.>
  </theorem>

  <subsection|Making polynomials square-free using pseudo-division>

  Let <with|mode|math|<apply|R>> be an effective integral domain and let
  <with|mode|math|U,V\<in\><apply|R>[F]> be polynomials over
  <with|mode|math|<apply|R>> with <with|mode|math|deg <format|no line
  break>V\<leqslant\>deg U>. If <with|mode|math|<apply|R>> were actually an
  effective field, then we might have used the Euclidean division algorithm
  to obtain the unique expression for <with|mode|math|U> of the form

  <expand|equation*|U=Q*V+R,>

  with <with|mode|math|Q,R\<in\><apply|R>[F]> and <with|mode|math|deg
  R\<less\>deg V>. However, this algorithm involves divisions and can no
  longer be used if <with|mode|math|<apply|R>> is an integral domain.
  Nevertheless, pseudo-division may always be used to obtain the unique
  expression for <with|mode|math|U> of the form

  <expand|equation*|I<rsub|V><rsup|deg U-deg V+1>*U=Q*V+R,>

  where <with|mode|math|I<rsub|V>> is the <with|font shape|italic|leading
  coefficient> or <with|font shape|italic|initial> of <with|mode|math|V> and
  <with|mode|math|Q,R\<in\><apply|R>[F]> are such that <with|mode|math|deg
  <format|no line break>R\<less\>deg <format|no line break>V>. We also call
  <with|mode|math|Q> the <with|font shape|italic|pseudo-quotient> and
  <with|mode|math|R> the <with|font shape|italic|pseudo-remainder> of the
  division of <with|mode|math|U> by <with|mode|math|V>.

  <\algorithm|pdiv>
    \;

    <expand|item*|Input:><with|mode|math|U,V\<in\><apply|R>[F]> with
    <with|mode|math|deg U\<geqslant\>deg V>.

    <expand|item*|Output:>the pseudo-quotient resp.<group|> pseudo-remainder
    of the division of <with|mode|math|U> by <with|mode|math|V>.

    <\body>
      Set <with|mode|math|Q\<assign\>0> and <with|mode|math|R\<assign\>U>

      For <with|mode|math|i\<assign\>deg R,\<ldots\>,deg V> do

      <\indent>
        <with|mode|math|Q\<assign\>I<rsub|V>*Q+R<rsub|i>*F<rsup|<space|0.6spc\
        >i-deg V>>

        <with|mode|math|R\<assign\>I<rsub|V>*R-R<rsub|i>*F<rsup|<space|0.6spc\
        >i-deg V>*V>
      </indent>

      Return <with|mode|math|Q>
    </body>
  </algorithm>

  In particular, we may use pseudo-division to make a polynomial
  <with|mode|math|P> square-free. Namely, we take the square-free part of
  <with|mode|math|P> to be <with|mode|math|<with|mode|text|<with|font
  family|tt|sqfree>>(P)=<with|mode|text|<with|font
  family|tt|pdiv>>(P,<with|mode|text|<with|font
  family|tt|gcd>>(P,P<rprime|'>))>. The following complexity bound follows
  from theorem <reference|gcdth>:

  <proposition|<label|sqfreeprop>Let <with|mode|math|S=<with|mode|text|<with|\
  font shape|right|<with|font family|tt|sqfree>>>(P)> of <with|mode|math|P>
  as above. Then <with|mode|math|\<nu\>(S)\<leqslant\>2*\<nu\>(P)<rsup|4>>.>

  <section|Four key lemmas><label|key-lemmas>

  We recall that derivations on integral domains extend uniquely to their
  algebraic closures.

  <\lemma>
    <label|gcd-lem>Let <with|mode|math|P\<in\><apply|R>[F]> be a square-free
    polynomial and

    <expand|equation*|G=<with|mode|text|font shape|right|font family|tt|gcd>
    (P,d<rsub|1> P,\<ldots\>,d<rsub|k> P).>

    Consider the factorization

    <expand|equation*|G=g*(F-h<rsub|1>)*\<cdots\>*(F-h<rsub|q>),>

    with <with|mode|math|h<rsub|1>,\<ldots\>,h<rsub|q>\<in\><apply|R><rsup|al\
    g>>. Then each of the <with|mode|math|h<rsub|p>> satisfies the partial
    differential equations <with|font shape|right|(<reference|pde>)>.
  </lemma>

  <\proof>
    Consider one of the factors <with|mode|math|F-h<rsub|p>> of
    <with|mode|math|G> and write

    <expand|equation*|P=(F-h<rsub|p>)*Q.>

    For each <with|mode|math|i\<in\>{1,\<ldots\>,k}>, we have

    <expand|equation*|d<rsub|i> P=(A<rsub|i>(F)-B<rsub|i>(F)*\<partial\><rsub\
    |i> h<rsub|p>)*Q+(F-h<rsub|p>)*d<rsub|i> Q>

    Since <with|mode|math|F-h<rsub|p>> both divides
    <with|mode|math|d<rsub|i>*P> and <with|mode|math|(F-h<rsub|p>)*d<rsub|i>
    Q>, it also divides <with|mode|math|(A<rsub|i>(F)-B<rsub|i>(F)*\<partial\\
    ><rsub|i> h<rsub|p>)*Q>. Now <with|mode|math|P> is square-free, so that
    <with|mode|math|F-h<rsub|p>> does not divide <with|mode|math|Q>.
    Therefore <with|mode|math|F-h<rsub|p>> divides
    <with|mode|math|A<rsub|i>(F)-B<rsub|i>(F)*\<partial\><rsub|i> h<rsub|p>>.
    Consequently, <with|mode|math|A<rsub|i>(h<rsub|p>)-B<rsub|i>(h<rsub|p>)*\\
    <partial\><rsub|i> h<rsub|p>=0> for each <with|mode|math|i>, i.e.
    <with|mode|math|h<rsub|p>> satisfies (<reference|pde>).
  </proof>

  <lemma|<label|unicity>Let <with|mode|math|\<varphi\>\<in\><value|C><rsup|al\
  g>\<llangle\>z<rsub|1>\<rrangle\>\<cdots\>\<llangle\>z<rsub|k>\<rrangle\>>
  be a Puiseux series with <with|mode|math|<with|math font
  series|bold|v>(\<varphi\>)\<geqslant\><with|math font series|bold|0>>.
  Assume that <with|mode|math|\<varphi\>> satisfies the same equations
  <with|font shape|right|(<reference|pde>)> as <with|mode|math|f> and the
  same initial condition <with|mode|math|\<varepsilon\>(\<varphi\>)=\<varepsi\
  lon\>(f)>. Then <with|mode|math|\<varphi\>=f>.>

  <\proof>
    Let us prove by induction over <with|mode|math|i> that
    <with|mode|math|\<varepsilon\><rsub|i>(\<varphi\>)=\<varepsilon\><rsub|i>\
    (f)> for all <with|mode|math|i\<in\>{0,\<ldots\>,k}>. We have
    <with|mode|math|\<varepsilon\><rsub|0>(\<varphi\>)=\<varepsilon\><rsub|0>\
    (f)> by assumption. Assume therefore that <with|mode|math|i\<gtr\>0> and
    <with|mode|math|\<varepsilon\><rsub|i-1>(\<varphi\>)=\<varepsilon\><rsub|\
    i-1>(f)>. Then <with|mode|math|\<psi\>=\<varepsilon\><rsub|i>(\<varphi\>)\
    > is a Puiseux series in <with|mode|math|<value|C>\<llangle\>z<rsub|1>\<r\
    rangle\>\<cdots\>\<llangle\>z<rsub|i>\<rrangle\>> of the form

    <equation|<label|form-psi>\<psi\>=\<varepsilon\><rsub|i-1>(f)+<big|sum><r\
    sub|\<alpha\>\<gtr\>0>\<psi\><rsub|\<alpha\>>*z<rsub|i><rsup|\<alpha\>>.>

    Since <with|mode|math|\<partial\><rsub|i>> and
    <with|mode|math|\<varepsilon\><rsub|i>> commute, <with|mode|math|\<psi\>>
    satisfies the partial differential equation

    <equation|<label|pde-i>\<partial\><rsub|i>
    \<psi\>=<frac|\<varepsilon\><rsub|i>(A<rsub|i>)(\<psi\>)|\<varepsilon\><r\
    sub|i>(B<rsub|i>)(\<psi\>)>.>

    In particular, extraction of the coefficient in
    <with|mode|math|z<rsub|i><rsup|\<alpha\>-1>> yields

    <equation|<label|rec-rel>\<alpha\>*\<psi\><rsub|\<alpha\>>=<left|(><frac|\
    \<varepsilon\><rsub|i>(A<rsub|i>)(\<psi\>)|\<varepsilon\><rsub|i>(B<rsub|\
    i>)(\<psi\>)><right|)><rsub|\<alpha\>-1>>

    for every <with|mode|math|\<alpha\>\<gtr\>0>. Now

    <expand|equation*|(\<varepsilon\><rsub|i>(B<rsub|i>)(\<psi\>))<rsub|0>=\<\
    varepsilon\><rsub|i-1>(B<rsub|i>)(\<psi\><rsub|0>)=\<varepsilon\><rsub|i-\
    1>(B<rsub|i>(f))\<neq\>0,>

    since <with|mode|math|\<varepsilon\>(\<varepsilon\><rsub|i-1>(B<rsub|i>(f\
    )))=\<varepsilon\>(B<rsub|i>(f))\<neq\><format|no line break>0>.
    Consequently, we may see (<reference|rec-rel>) as a recurrence relation
    which uniquely determines <with|mode|math|\<psi\><rsub|\<alpha\>>> as a
    function of other <with|mode|math|\<psi\><rsub|\<beta\>>> with
    <with|mode|math|\<beta\>\<less\>\<alpha\>>. Hence
    <with|mode|math|\<psi\>=\<varepsilon\><rsub|i>(f)> is the unique solution
    to (<reference|pde-i>) of the form (<reference|form-psi>). The lemma now
    follows by induction.
  </proof>

  <\lemma>
    <label|New-pol>Let <with|mode|math|P> be a polynomial in
    <with|mode|math|<apply|R>[F]>. Given <with|mode|math|\<lambda\>\<in\><val\
    ue|C><rsup|alg>> with

    <equation|<label|New-eq>P<rsub|<with|math font
    series|bold|v>(P)>(\<lambda\>)=0,>

    there exists a root <with|mode|math|\<varphi\>\<in\><value|C><rsup|alg>\<\
    llangle\>z<rsub|1>\<rrangle\>\<cdots\>\<llangle\>z<rsub|k>\<rrangle\>> of
    <with|mode|math|P> with <with|mode|math|<with|math font
    series|bold|v>(\<varphi\>)\<geqslant\><with|math font series|bold|0>> and
    <with|mode|math|\<varepsilon\>(\<varphi\>)=\<lambda\>>.
  </lemma>

  <\proof>
    Intuitively speaking, this lemma follows from the Newton polygon method:
    the existence of a solution <with|mode|math|\<lambda\>\<neq\>0> to
    (<reference|New-eq>) implies that the Newton polygon associated to the
    equation <with|mode|math|P(\<varphi\>)=0> admits a horizontal slope and
    that <with|mode|math|\<lambda\>> is a solution to the associated Newton
    polynomial. Therefore, <with|mode|math|\<lambda\>> is the first term of a
    solution to <with|mode|math|P(\<varphi\>)=0>, the full solution being
    obtained using the Newton polygon method. If
    <with|mode|math|\<lambda\>=0>, then the Newton polygon admits a
    ``strictly positive slope'' and a similar argument applies.

    More precisely, we may apply the results from chapter 3 in
    <apply|cite|vdHoeven97>. We first notice that

    <expand|equation*|<value|C><rsup|alg>\<llangle\>z<rsub|1>\<rrangle\>\<cdo\
    ts\>\<llangle\>z<rsub|k>\<rrangle\>=<value|C><rsup|alg><with|math font
    family|mt|[<space|-0.6spc>[>z<rsub|1><rsup|<with|math
    font|Bbb*|Q>>;\<ldots\>;z<rsub|k><rsup|<with|math font|Bbb*|Q>><with|math
    font family|mt|]<space|-0.6spc>]>>

    is a field <with|mode|math|>of grid-based power series. Now setting
    <with|mode|math|\<varphi\>=\<lambda\>+\<psi\>>, the Newton degree
    <with|mode|math|d> of

    <equation|<label|aae>P<rsub|+\<lambda\>>(\<psi\>)=P(\<lambda\>+\<psi\>)=0\
    <space|4spc>(<with|math font series|bold|v>(\<psi\>)\<gtr\><with|math
    font series|bold|0>)>

    is strictly positive. Indeed, this is clear if
    <with|mode|math|\<lambda\>=0>, and this follows from lemma 3.2 in
    <apply|cite|vdHoeven97> if <with|mode|math|\<lambda\>\<neq\>0>. Now our
    lemma follows from the fact that the algorithm <with|font
    family|tt|polynomial_solve> returns <with|mode|math|d> solutions to
    <format|no line break>(<reference|aae>).
  </proof>

  <\lemma>
    With the notation from lemma <reference|gcd-lem>, we have

    <expand|equation*|\<rho\>(P)=0<space|1spc>\<Longleftrightarrow\><space|1s\
    pc>G<rsub|<with|math font series|bold|v>(G)> (\<varepsilon\>(f))=0.>
  </lemma>

  <proof|The direct implication is trivial. So assume that
  <with|mode|math|G<rsub|<with|math font series|bold|v>(G)>
  (\<varepsilon\>(f))=0>. Lemma <format|no line break><reference|New-pol>
  implies that <with|mode|math|G> admits a root
  <with|mode|math|\<varphi\>\<in\><value|C><rsup|alg>\<llangle\>z<rsub|1>\<rr\
  angle\>\<cdots\>\<llangle\>z<rsub|k>\<rrangle\>> with
  <with|mode|math|<with|math font series|bold|v>(\<varphi\>)\<geqslant\><with\
  |math font series|bold|0>> and <with|mode|math|\<varepsilon\>(\<varphi\>)=\\
  <varepsilon\>(f)>. This root <with|mode|math|\<varphi\>> satisfies the
  equations (<reference|pde>), by lemma <reference|gcd-lem>. Hence
  <with|mode|math|\<varphi\>=f>, by lemma <reference|unicity>. We conclude
  that <with|mode|math|G(f)=0> and <with|mode|math|\<rho\>(P)=P(f)=0>.>

  <section|The algorithm><label|zt-alg>

  <subsection|Statement of the algorithm>

  The lemmas from the previous section yield the following zero-test
  algorithm:

  <\algorithm|zero_test>
    \;

    <expand|item*|Input:><with|mode|math|P\<in\><apply|R>[F]>.

    <expand|item*|Output:>result of the test <with|mode|math|\<rho\>(P)=0>.

    <\body>
      <expand|item*|Step 1. [trivial case]><format|no page break after>

      <indent|If <with|mode|math|P=0> then return <with|font
      family|tt|true>.>

      <expand|item*|Step 2. [g.c.d.<group|> computations]>

      <\indent>
        Replace <with|mode|math|P\<assign\><with|mode|text|font
        family|tt|sqfree>(P)>.

        Let <with|mode|math|G\<assign\><with|mode|text|font
        family|tt|gcd>(P,d<rsub|1> P,\<ldots\>,d<rsub|k> P)>.
      </indent>

      <expand|item*|Step 3. [compute the valuation of
      <with|mode|math|G><with|mode|math|>]>

      <\indent>
        Denote <with|mode|math|G=G<rsub|q>*F<rsup|<space|0.4spc>q>+\<cdots\>+\
        G<rsub|0>>.

        For <with|mode|math|i=k,\<ldots\>,1> do

        <\indent>
          Expand <with|mode|math|G<rsub|0,\<alpha\><rsub|k>,\<ldots\>,\<alpha\
          \><rsub|i+1>>,\<ldots\>,G<rsub|q,\<alpha\><rsub|k>,\<ldots\>,\<alph\
          a\><rsub|i+1>>> in a relaxed way <apply|cite|VdH:relax>
          w.r.t.<group|> <with|mode|math|z<rsub|i>>.

          Stop at the least <with|mode|math|\<alpha\><rsub|i>>, such that
          there exists a <with|mode|math|p> with
          <with|mode|math|G<rsub|p,\<alpha\><rsub|k>,\<ldots\>,\<alpha\><rsub\
          |i>>\<neq\>0>.
        </indent>
      </indent>

      <expand|item*|Step 4. [evaluate and conclude]>

      <indent|Return <with|mode|math|G<rsub|<with|math font
      series|bold|\<alpha\>>> (\<varepsilon\>(f))=0>.>
    </body>
  </algorithm>

  <subsection|Complexity bounds>

  In order to derive complexity bounds, we will to assume that we have a
  pseudo-norm <with|mode|math|\<nu\>> on <with|mode|math|<apply|R>> and that
  there exists a function <with|mode|math|\<xi\><rsub|<apply|R>>:<with|math
  font|Bbb*|N>\<rightarrow\><with|math font|Bbb*|N>>, such that for each
  <with|mode|math|\<varphi\>\<in\><apply|R>\\{0}>, we have
  <with|mode|math|\|<with|math font series|bold|v>(\<varphi\>)\|\<leqslant\>\\
  <xi\><rsub|<apply|R>>(\<nu\>(\<varphi\>))>. Here we understand that

  <expand|equation*|\|(\<alpha\><rsub|1>,\<ldots\>,\<alpha\><rsub|k>)\|=max
  {\<alpha\><rsub|1>,\<ldots\>,\<alpha\><rsub|k>},>

  for each <with|mode|math|<with|math font
  series|bold|\<alpha\>>\<in\><with|math font|Bbb*|N><rsup|k>>. It is also
  reasonable to also assume that <with|mode|math|\<xi\><rsub|<apply|R>>> is
  increasing and that it grows sufficiently fast such that
  <with|mode|math|\<xi\><rsub|<value|R>>(c)\<geqslant\>c>,
  <with|mode|math|\<xi\><rsub|<value|R>>(c+d)\<geqslant\>\<xi\><rsub|<value|R\
  >>(c)+\<xi\><rsub|<value|R>>(d)> and <with|mode|math|\<xi\><rsub|<value|R>>\
  (c*d)\<geqslant\>\<xi\><rsub|<value|R>>(c)*\<xi\><rsub|<value|R>>(d)><with|\
  mode|math|> for all <with|mode|math|c,d\<in\><with|math
  font|Bbb*|N><rsup|<with|math font shape|semi-right|*>>>. Notice that we may
  take <with|mode|math|\<xi\><rsub|<value|C>>(c)=1> for all
  <with|mode|math|c\<in\><with|math font|Bbb*|N>> when
  <with|mode|math|<value|R>=<value|C>>.

  <\theorem>
    <label|val-bound>Let

    <expand|equation*|C=max {K<rsub|<apply|R>>+max
    {\<nu\>(B<rsub|1>),\<ldots\>,\<nu\>(B<rsub|k>)},max
    {\<nu\>(A<rsub|1>),\<ldots\>,\<nu\>(A<rsub|k>)},1}.>

    Then for any <with|mode|math|\<varphi\>\<in\><apply|S>\\{0}>, we have

    <expand|equation*|\|<with|math font series|bold|v>(\<varphi\>)\|\<leqslan\
    t\>\<xi\><rsub|<value|R>>((2*k*C*\<nu\>(\<varphi\>))<rsup|9>).>
  </theorem>

  <\proof>
    Assume first that <with|mode|math|\<varphi\>\<in\><apply|S>\\{0}> can be
    represented by a square-free polynomial
    <with|mode|math|P\<in\><apply|R>[F]>. Then <with|mode|math|P> does not
    change in step 2 of <with|font family|tt|zero_test> and for
    <with|mode|math|i\<in\>{1,\<ldots\>,k}>, we have

    <expand|equation*|\<nu\>(d<rsub|i> P)<space|0.6spc>\<leqslant\><space|0.6\
    spc>\<nu\>(P)+C,>

    Then theorem <reference|gcdth> yields

    <expand|equation*|\<nu\>(G)\<leqslant\>2*(\<nu\>(P)+C)<rsup|2*>.>

    Since <with|mode|math|\|<with|math font
    series|bold|v>(G<rsub|p>)\|\<leqslant\>\<xi\><rsub|<apply|R>>(\<nu\>(G))>
    for each non-zero coefficient <with|mode|math|G<rsub|p>> of
    <with|mode|math|G>, it follows that

    <expand|equation*|\|<with|math font series|bold|\<alpha\>>\|\<leqslant\>\\
    <xi\><rsub|<apply|R>>(2*(\<nu\>(P)+C)<rsup|2>)>

    in step 3 of <with|font family|tt|zero_test>. Since we assumed
    <with|mode|math|\<varphi\>\<neq\>0>, we must have
    <with|mode|math|G<rsub|<with|math font
    series|bold|\<alpha\>>>(\<varepsilon\>(f))\<neq\>0> in the last step of
    <with|font family|tt|zero_test>. Considering the Taylor series expansion

    <expand|eqnarray*|<tformat|<table|<row|<cell|G(f)>|<cell|=>|<cell|G(\<var\
    epsilon\>(f))+G<rprime|'>(\<varepsilon\>(f))*\<delta\>+<with|formula
    style|false|<frac|1|2>>*G<rprime|''>(\<varepsilon\>(f))*\<delta\><rsup|2>\
    +\<cdots\>>>|<row|<cell|>|<cell|=>|<cell|G<rsub|<with|math font
    series|bold|\<alpha\>>>(\<varepsilon\>(f))*z<rsub|1><rsup|\<alpha\><rsub|\
    1>>*\<cdots\>*z<rsub|k><rsup|\<alpha\><rsub|k>>+o(z<rsub|1><rsup|\<alpha\\
    ><rsub|1>>*\<cdots\>*z<rsub|k><rsup|\<alpha\><rsub|k>>)>>>>>

    in the infinitesimal power series <with|mode|math|\<delta\>=f-\<varepsilo\
    n\>(f)>, we observe that <with|mode|math|<with|math font
    series|bold|v>(\<rho\>(G))=<with|math font series|bold|\<alpha\>>>.

    By theorem <reference|gcdth>, <with|mode|math|G> also satisfies a Bezout
    relation of the form

    <expand|equation*|G=S*P+Q<rsub|1>*d<rsub|1>
    P+\<cdots\>+Q<rsub|k>*d<rsub|k> P,>

    Now <with|mode|math|\|<with|math font series|bold|v>(\<rho\>(d<rsub|i>
    P))\|=\|<with|math font series|bold|v>(\<rho\>(B<rsub|i>)*\<partial\><rsu\
    b|i> \<rho\>(P))\|=\|<with|math font series|bold|v>(\<partial\><rsub|i>
    \<rho\>(P))\|\<geqslant\>\|<with|math font
    series|bold|v>(\<rho\>(P))\|-1> for all <with|mode|math|i> (recall that
    <with|mode|math|\<varepsilon\>(B<rsub|i>)\<neq\>0)>, so that

    <expand|equation*|\|<with|math font series|bold|v>(\<rho\>(S*P+Q<rsub|1>*\
    d<rsub|1> P+\<cdots\>+Q<rsub|k>*d<rsub|k> P))\|\<geqslant\>\|<with|math
    font series|bold|v>(\<rho\>(P))\|-1.>

    We conclude that

    <expand|equation*|\|<with|math font series|bold|v>(\<rho\>(P))\|\<leqslan\
    t\>\<xi\><rsub|<apply|R>>(2*(\<nu\>(P)+C)<rsup|2>+1).>

    This gives a bound for <with|mode|math|<with|math font
    series|bold|v>(\<varphi\>)> in the case when <with|mode|math|P> is
    square-free.

    Let us now turn to the more general situation in which
    <with|mode|math|\<varphi\>> is represented by a polynomial
    <with|mode|math|P\<in\><apply|R>[F]> which is no longer square-free.
    Setting <with|mode|math|P<rsub|\<ast\>>\<assign\><with|mode|text|font
    family|tt|pdiv>(P,<with|mode|text|font family|tt|gcd>(P,\<partial\>
    P/\<partial\> F))>, the above discussion yields the bound

    <expand|equation*|\|<with|math font series|bold|v>(\<rho\>(P<rsub|\<ast\>\
    >))\|\<leqslant\>\<xi\><rsub|<apply|R>>(2*(2*\<nu\>(P)<rsup|4>+C)<rsup|2>\
    +1),>

    since <with|mode|math|\<nu\>(P<rsub|\<ast\>>)\<leqslant\>2*\<nu\>(P)<rsup\
    |4>> by proposition <reference|sqfreeprop>. Now <with|mode|math|P>
    divides <with|mode|math|P<rsub|\<ast\>><rsup|deg P>> when we understand
    these polynomials to have coefficients in the quotient field of
    <with|mode|math|<apply|R>>. If <with|mode|math|c> is the leading
    coefficient of <format|no line break><with|mode|math|P>, we thus have
    <with|mode|math|P\|c<rsup|(deg P)<rsup|2>>*P<rsub|\<ast\>><rsup|deg P>>
    in <with|mode|math|<apply|R>[F]>, as is seen by pseudo-dividing
    <with|mode|math|P<rsub|\<ast\>><rsup|deg P>> by <with|mode|math|P>. It
    follows that

    <expand|eqnarray*|<tformat|<table|<row|<cell|\|<with|math font
    series|bold|v>(\<rho\>(P))\|>|<cell|\<leqslant\>>|<cell|\<nu\>(P)*\|<with\
    |math font series|bold|v>(\<rho\>(P<rsub|\<ast\>>))\|+\<nu\>(P)<rsup|2>*\\
    |<with|math font series|bold|v>(c)\|>>|<row|<cell|>|<cell|\<leqslant\>>|<\
    cell|\<nu\>(P)*\<xi\><rsub|<apply|R>>(2*(2*\<nu\>(P)<rsup|4>+C)<rsup|2>+1\
    )+\<nu\>(P)<rsup|2>*\<xi\><rsub|<apply|R>>(\<nu\>(P))>>|<row|<cell|>|<cel\
    l|\<leqslant\>>|<cell|\<xi\><rsub|<apply|R>>(2*\<nu\>(P)*(2*\<nu\>(P)<rsu\
    p|4>+C+1)<rsup|2>),>>>>>

    since <with|mode|math|\|<with|math font
    series|bold|v>(c)\|\<leqslant\>\<xi\><rsub|<apply|R>>(\<nu\>(P))>.

    Let us finally consider the case when <with|mode|math|\<varphi\>> is
    represented by a general element <with|mode|math|P\<in\><wide|<apply|S>|\\
    <check\>>>. Then we may rewrite <with|mode|math|P> as a fraction
    <with|mode|math|\<Phi\>/\<Psi\>> with
    <with|mode|math|\<Phi\>\<in\><apply|R>[F]> and
    <with|mode|math|\<Psi\>=B<rsub|1><rsup|\<nu\>(P)>*\<cdots\>*B<rsub|k><rsu\
    p|\<nu\>(P)>>, and we have

    <expand|equation*|\<nu\>(\<Phi\>)\<leqslant\>\<nu\>(P)+k*\<nu\>(P)*max
    {\<nu\>(B<rsub|1>),\<ldots\>,\<nu\>(B<rsub|k>)}\<leqslant\>k*C*\<nu\>(P).\
    >

    Since <with|mode|math|<with|math font
    series|bold|v>(\<rho\>(\<Psi\>))=<with|math font series|bold|0>>, we thus
    get

    <expand|eqnarray*|<tformat|<table|<row|<cell|\|<with|math font
    series|bold|v>(\<rho\>(P))\|>|<cell|\<leqslant\>>|<cell|\<xi\><rsub|<appl\
    y|R>>(2*\<nu\>(\<Phi\>)*(2*\<nu\>(\<Phi\>)<rsup|4>+C+1)<rsup|2>)>>|<row|<\
    cell|>|<cell|\<leqslant\>>|<cell|\<xi\><rsub|<apply|R>>(2*k**C*\<nu\>(P)*\
    (2*(k*C*\<nu\>(P))<rsup|4>+C+1)<rsup|2>)>>|<row|<cell|>|<cell|\<leqslant\\
    >>|<cell|\<xi\><rsub|<value|R>>(32*(k*C*\<nu\>(P)<rsup|9>),>>>>>

    since <with|mode|math|\<nu\>(P)=0> or
    <with|mode|math|C+1\<leqslant\>2*(k*C*\<nu\>(P))<rsup|4>>.
  </proof>

  As a consequence of the above bound for the valuations of non-zero series
  <with|mode|math|\<varphi\>\<in\><apply|S>>, we have a straightforward
  zero-test algorithm for series <with|mode|math|\<varphi\>\<in\><apply|S>>
  which consists of testing whether all coefficients of
  <with|mode|math|\<varphi\>> up to the bound vanish using relaxed evaluation
  <apply|cite|VdH:relax>. This algorithm satisfies the following complexity
  bound:

  <theorem|Let <with|mode|math|P\<in\><wide|S|\<check\>>><label|compl-bound>.
  With the notation from theorem <reference|val-bound>, we may test whether
  <with|mode|math|P> represents zero in time
  <with|mode|math|O(\<xi\><rsub|<value|R>>((2*k*C*\<nu\>(\<varphi\>))<rsup|9>\
  )<rsup|k>*log<rsup|2> \<xi\><rsub|<value|R>>((2*k*C*\<nu\>(\<varphi\>))<rsu\
  p|9>)*k<rsup|3>)>.>

  <remark|Of course, the complexity bound from theorem
  <reference|compl-bound> is very pessimistic, since it reflects the
  theoretical worst case bounds for the valuations. In practice, we recommend
  using <with|font family|tt|zero_test>, which we expect to be much faster in
  average.>

  <subsection|Consequences of the complexity bounds>

  Consider a tower of regular D-algebraic ring extensions
  <with|mode|math|<apply|R><rsub|0>\<subseteq\><apply|R><rsub|1>\<subseteq\>\\
  <cdots\>\<subseteq\><apply|R><rsub|h>> starting with
  <with|mode|math|<apply|R><rsub|0>=<value|C>[z<rsub|1>,\<ldots\>,z<rsub|k>]>\
  . We have natural representations

  <expand|equation*|\<rho\>:<wide|<value|R>|\<check\>><rsub|i>=<wide|<value|R\
  >|\<check\>><rsub|i-1><left|[>F<rsub|i>,<frac|1|B<rsub|i,1>(F<rsub|i>)>,\<l\
  dots\>,<frac|1|B<rsub|i,n<rsub|i>>(F<rsub|i>)><right|]>\<rightarrow\><value\
  |R><rsub|i>>

  for all <with|mode|math|i\<in\>{1,\<ldots\>,k}>. The repeated application
  of theorem <reference|val-bound> yields

  <corollary|There exists a constant <with|mode|math|K>, such that for all
  <with|mode|math|P\<in\><wide|<value|R>|\<check\>><rsub|h>>, we have either
  <with|mode|math|\<rho\>(P)=0> or <with|mode|math|\|<with|math font
  series|bold|v>(\<rho\>(P))\|\<leqslant\>K**\<nu\>(P)<rsup|9<rsup|h>>>.>

  <remark|In other words, for fixed <with|mode|math|h>, we have a polynomial
  time algorithm zero-test in <format|no line
  break><with|mode|math|<value|R><rsub|h>>. Theoretically speaking, we
  already knew this, because <with|mode|math|<value|R><rsub|h>\<cong\><wide|<\
  value|R>|\<check\>><rsub|h>/I> for a certain ideal <with|mode|math|I> of
  <with|mode|math|<wide|<value|R>|\<check\>><rsub|h>>. Hence, it would
  suffice to reduce a polynomial in <with|mode|math|<wide|<value|R>|\<check\>\
  ><rsub|h>> with respect to a Groebner basis for <with|mode|math|I> in order
  to know whether it represents zero. Unfortunately, we do not know of any
  algorithm to compute such a Groebner basis for <with|mode|math|I>.
  Nevertheless, even without such a Groebner basis the above corollary tells
  us that we still have a polynomial time zero-test.>

  Let us now return to exp-log series in the ring <with|mode|math|<with|math
  font|cal|E><rsub|k>> considered in the introduction. \ Repeated application
  of theorem <reference|val-bound> yields

  <corollary|Consider an exp-log series <with|mode|math|f\<in\><with|math
  font|cal|E><rsub|k>>, which can be represented by an expression of size
  <with|mode|math|\<chi\>>. Then either <with|mode|math|f=0> or
  <with|mode|math|\|<with|math font series|bold|v>(f)\|\<leqslant\>(4*k*\<chi\
  \>)<rsup|9<rsup|\<chi\>>>.>>

  <\proof>
    Let <with|mode|math|<wide|f|\<check\>>> be an expression which represents
    <with|mode|math|f> and let <with|mode|math|<wide|f|\<check\>><rsub|1>,\<l\
    dots\>,<wide|f|\<check\>><rsub|\<chi\>>> be its subexpressions listed in
    the order of a postfix traversal. We construct a tower
    <with|mode|math|<value|R><rsub|0>\<subseteq\>\<cdots\>\<subseteq\><value|\
    R><rsub|h>> with representations <with|mode|math|<wide|<value|R>|\<check\\
    >><rsub|0>\<subseteq\>\<cdots\>\<subseteq\><wide|<value|R>|\<check\>><rsu\
    b|h>>, such that <with|mode|math|<wide|f|\<check\>><rsub|i>\<in\><value|R\
    ><rsub|p<rsub|i>>> for all <with|mode|math|i> and
    <with|mode|math|0=p<rsub|1>\<leqslant\>\<cdots\>\<leqslant\>p<rsub|\<chi\\
    >>=h>. We construct the tower by induction over <with|mode|math|i>. For
    <with|mode|math|i=0> we have nothing to show, so suppose
    <with|mode|math|i\<gtr\>0> and that we have performed the construction up
    to stage <with|mode|math|i-1>.

    If <with|mode|math|<wide|f|\<check\>><rsub|i>\<in\><value|C>> or
    <with|mode|math|<wide|f|\<check\>><rsub|i>\<in\>{z<rsub|1>,\<ldots\>,z<rs\
    ub|k>}>, then we clearly have <with|mode|math|<wide|f|\<check\>><rsub|i>\\
    <in\><wide|<value|R>|\<check\>><rsub|0>=<value|C>[z<rsub|1>,\<ldots\>,z<r\
    sub|k>]>. If <with|mode|math|<wide|f|\<check\>><rsub|i>=<wide|f|\<check\>\
    ><rsub|j<rsub|1>>+<wide|f|\<check\>><rsub|j<rsub|2>>>,
    <with|mode|math|<wide|f|\<check\>><rsub|i>=<wide|f|\<check\>><rsub|j<rsub\
    |1>>-<wide|f|\<check\>><rsub|j<rsub|2>>>,
    <with|mode|math|<wide|f|\<check\>><rsub|i>=<wide|f|\<check\>><rsub|j<rsub\
    |2>>-<wide|f|\<check\>><rsub|j<rsub|1>>> or
    <with|mode|math|<wide|f|\<check\>><rsub|i>=<wide|f|\<check\>><rsub|j<rsub\
    |1>>*<wide|f|\<check\>><rsub|j<rsub|2>>> with
    <with|mode|math|j<rsub|1>\<less\>><with|mode|math|j<rsub|2>\<less\>i>,
    then <with|mode|math|<wide|f|\<check\>><rsub|i>\<in\><wide|<value|R>|\<ch\
    eck\>><rsub|j<rsub|2>>>. Assume finally that
    <with|mode|math|<wide|f|\<check\>><rsub|i>=\<varphi\>\<circ\><wide|f|\<ch\
    eck\>><rsub|j>> with <with|mode|math|j\<less\>i>, where
    <with|mode|math|\<varphi\>\<in\>{1/(1+z),exp z,log (1+z)}>. Then we take
    <with|mode|math|<wide|<value|R>|\<check\>><rsub|p<rsub|i>>=<wide|<value|R\
    >|\<check\>><rsub|p<rsub|i-1>>[<wide|f|\<check\>><rsub|i>]> if
    <with|mode|math|\<varphi\>=exp z> or <with|mode|math|<wide|<value|R>|\<ch\
    eck\>><rsub|p<rsub|i>>=<wide|<value|R>|\<check\>><rsub|p<rsub|i-1>>[<wide\
    |f|\<check\>><rsub|i>,1/(1+<wide|f|\<check\>><rsub|i>)]> otherwise, and
    one the relations

    <expand|eqnarray*|<tformat|<table|<row|<cell|\<partial\>
    f<rsub|i>>|<cell|=>|<cell|-(\<partial\>
    f<rsub|j>)*f<rsub|i><rsup|2>;>>|<row|<cell|\<partial\>
    f<rsub|i>>|<cell|=>|<cell|(\<partial\>
    f<rsub|j>)*f<rsub|i>;>>|<row|<cell|\<partial\>
    f<rsub|i>>|<cell|=>|<cell|<frac|\<partial\> f<rsub|j>|1+f<rsub|j>>>>>>>

    holds for all <with|mode|math|\<partial\>\<in\>{\<partial\><rsub|1>,\<ldo\
    ts\>,\<partial\><rsub|k>}>. Notice that the pseudo-norm of
    <with|mode|math|<wide|f|\<check\>><rsub|i>> is bounded by
    <with|mode|math|i> (whence by <with|mode|math|\<chi\>>) for all
    <with|mode|math|i>. Consequently, the <with|mode|math|C> from theorem
    <reference|val-bound> is bounded by <with|mode|math|2*\<chi\>> at each
    stage. By induction over <with|mode|math|i>, it therefore follows that
    <with|mode|math|\<xi\><rsub|<value|R><rsub|i>>(s)\<leqslant\>(4*k*\<chi\>\
    )<rsup|<frac|9<rsup|i-1>-1|8>>*s<rsup|9<rsup|i-1>>> for all
    <with|mode|math|i\<geqslant\>1>. If <with|mode|math|f\<neq\>0>, we
    conclude that <with|mode|math|\|<with|math font
    series|bold|v>(f)\|\<leqslant\>\<xi\><rsub|<value|R><rsub|\<chi\>>>(\<chi\
    \>)\<leqslant\>(4*k*\<chi\>)<rsup|9<rsup|\<chi\>>>=k<rsup|O(1)<rsup|\<chi\
    \>>>>.
  </proof>

  <\bibliography|bib|alpha|zerotest.bib>
    <apply|bibitem*|Ax71><label|bib-Ax71>J. Ax. <apply|newblock>On Schanuel's
    conjecture. <apply|newblock><with|font shape|italic|Ann. of Math.>,
    93:252--268, 1971.

    <apply|bibitem*|Bar68><label|bib-Bar68>E.H. Bareiss.
    <apply|newblock>Sylvester's identity and multistep integer-preserving
    Gaussian elimination. <apply|newblock><with|font shape|italic|Math. Comp.
    22>, 22:565--578, 1968.

    <apply|bibitem*|CP78><label|bib-C/P>B.F. Caviness and M.J. Prelle.
    <apply|newblock>A note on algebraic independence of logarithmic and
    exponential constants. <apply|newblock><with|font shape|italic|SIGSAM
    Bull.>, 12/2:18--20, 1978.

    <apply|bibitem*|Kho91><label|bib-Khov91>A. G. Khovanskii.
    <apply|newblock><with|font shape|italic|Fewnomials>.
    <apply|newblock>American Mathematical Society, Providence, RI, 1991.

    <apply|bibitem*|Lan71><label|bib-Lang71>S. Lang.
    <apply|newblock>Transcendental numbers and diophantine approximation.
    <apply|newblock><with|font shape|italic|Bull. Amer. Math. Soc.>,
    77/5:635--677, 1971.

    <apply|bibitem*|MW95><label|bib-MW95>A.J. Macintyre and A.J. Wilkie.
    <apply|newblock>On the decidability of the real exponential field.
    <apply|newblock>In P.G. Odifreddi, editor, <with|font
    shape|italic|Kreisel 70th birthday volume>, CLSI. 1995.

    <apply|bibitem*|PG95><label|bib-Peladan95>Ariane Péladan-Germa.
    <apply|newblock>Testing identities of series defined by algebraic partial
    differential equations. <apply|newblock>In Gérard Cohen, Marc Giusti, and
    Teo Mora, editors, <with|font shape|italic|Applied Algebra, Algebraic
    Algorithms and Error-Correcting Codes>, pages 393--407. Springer-Verlag,
    1995. <apply|newblock>Proceedings of the 11th International Symposium,
    AAECC-11, Paris, France, July 1995.

    <apply|bibitem*|Ric94><label|bib-Richardson94a>D. Richardson.
    <apply|newblock>How to recognise zero. <apply|newblock><with|font
    shape|italic|J. Symbol. Comput.>, 24(6):627--646, 1994.

    <apply|bibitem*|Ric01><label|bib-Rich01>D. Richardson.
    <apply|newblock>The uniformity conjecture. <apply|newblock>In <with|font
    shape|italic|Lecture Notes in Computer Science>, volume 2064, pages
    253--272. Springer Verlag, 2001.

    <apply|bibitem*|Sha89><label|bib-Sh3>J.R. Shackell. <apply|newblock>A
    differential-equations approach to functional equivalence.
    <apply|newblock>In G. Gonnet, editor, <with|font shape|italic|ISSAC '89
    Proceedings>, pages 7--10, Portland, Oregon, 1989. A.C.M. Press.

    <apply|bibitem*|Sha93><label|bib-Sh4>J.R. Shackell.
    <apply|newblock>Zero-equivalence in function fields defined by algebraic
    differential equations. <apply|newblock><with|font shape|italic|Trans.
    Amer. Math. Soc.>, 336/1:151--172, 1993.

    <apply|bibitem*|vdH97><label|bib-vdHoeven97>J. van der Hoeven.
    <apply|newblock><with|font shape|italic|Asymptotique automatique>.
    <apply|newblock>PhD thesis, École Polytechnique, Laboratoire
    d'Informatique, École Polytechnique, Paris, France, 1997.

    <apply|bibitem*|vdH99><label|bib-VdH:relax>J. van der Hoeven.
    <apply|newblock>Relax, but don't be too lazy. <apply|newblock>Technical
    Report 78, Prépublications d'Orsay, 1999. <apply|newblock>Submitted to
    JSC.

    <apply|bibitem*|vdH01a><label|bib-vdH:singhol>J. van der Hoeven.
    <apply|newblock>Fast evaluation of holonomic functions near and in
    singularities. <apply|newblock><with|font shape|italic|JSC>, 31:717--743,
    2001.

    <apply|bibitem*|vdH01b><label|bib-vdH:witness>J. van der Hoeven.
    <apply|newblock>Zero-testing, witness conjectures and differential
    diophantine approximation. <apply|newblock>Technical Report 2001-62,
    Prépublications d'Orsay, 2001.
  </bibliography>
</body>

<\initial>
  <\collection>
    <associate|paragraph width|150mm>
    <associate|odd page margin|30mm>
    <associate|shrinking factor|4>
    <associate|page top margin|30mm>
    <associate|page right margin|30mm>
    <associate|reduction page right margin|25mm>
    <associate|paragraph hyphenation|professional>
    <associate|reduction page bottom margin|15mm>
    <associate|page type|a4>
    <associate|reduction page left margin|25mm>
    <associate|font base size|11>
    <associate|even page margin|30mm>
    <associate|page bottom margin|30mm>
    <associate|reduction page top margin|15mm>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|New-eq|<tuple|4.4|11>>
    <associate|bib-vdH:witness|<tuple|vdH01b|15>>
    <associate|bib-VdH:relax|<tuple|vdH99|15>>
    <associate|Bezout|<tuple|3.2|8>>
    <associate|unicity|<tuple|4.2|10>>
    <associate|bib-vdHoeven97|<tuple|vdH97|15>>
    <associate|bib-Bar68|<tuple|Bar68|15>>
    <associate|bib-Sh3|<tuple|Sha89|15>>
    <associate|pnorm1|5.1>
    <associate|bib-Sh4|<tuple|Sha93|15>>
    <associate|Bareiss|<tuple|3|6>>
    <associate|gcdth|<tuple|3.5|9>>
    <associate|Bareisth|<tuple|3.3|7>>
    <associate|rec-rel|<tuple|4.3|10>>
    <associate|New-pol|<tuple|4.3|11>>
    <associate|bib-vdH:singhol|<tuple|vdH01a|15>>
    <associate|bib-Richardson94a|<tuple|Ric94|15>>
    <associate|toc-10|<tuple|3.1|6>>
    <associate|setup|<tuple|2|4>>
    <associate|toc-11|<tuple|3.2|6>>
    <associate|bib-Peladan95|<tuple|PG95|15>>
    <associate|bib-Khov91|<tuple|Kho91|15>>
    <associate|toc-12|<tuple|3.3|8>>
    <associate|pde|<tuple|2.1|4>>
    <associate|aae|<tuple|4.5|11>>
    <associate|toc-13|<tuple|3.4|9>>
    <associate|toc-14|<tuple|4|10>>
    <associate|trid|<tuple|3.3|8>>
    <associate|zt-alg|<tuple|5|11>>
    <associate|toc-15|<tuple|5|11>>
    <associate|toc-16|<tuple|5.1|11>>
    <associate|toc-17|<tuple|5.2|12>>
    <associate|toc-18|<tuple|5.3|14>>
    <associate|pde-i|<tuple|4.2|10>>
    <associate|toc-19|<tuple|5.6|14>>
    <associate|form-psi|<tuple|4.1|10>>
    <associate|gcd-lem|<tuple|4.1|10>>
    <associate|compl-bound|<tuple|5.2|13>>
    <associate|bib-C/P|<tuple|CP78|15>>
    <associate|key-lemmas|<tuple|4|10>>
    <associate|bib-Ax71|<tuple|Ax71|14>>
    <associate|toc-1|<tuple|1|1>>
    <associate|bib-Lang71|<tuple|Lan71|15>>
    <associate|toc-2|<tuple|1.1|1>>
    <associate|bib-Rich01|<tuple|Ric01|15>>
    <associate|dets|6.1>
    <associate|sqfreeprop|<tuple|3.6|10>>
    <associate|toc-3|<tuple|1.2|2>>
    <associate|toc-4|<tuple|1.3|3>>
    <associate|val-bound|<tuple|5.1|12>>
    <associate|toc-5|<tuple|2|4>>
    <associate|bib-MW95|<tuple|MW95|15>>
    <associate|bib-vdH:issac97|vdH97b>
    <associate|toc-6|<tuple|2.1|4>>
    <associate|bib-Mac/Wilkie|<tuple|MW94|?>>
    <associate|toc-7|<tuple|2.2|4>>
    <associate|toc-8|<tuple|2.3|5>>
    <associate|toc-9|<tuple|3|6>>
    <associate|detrel|<tuple|3.1|7>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|bib>
      Lang71

      C/P

      Richardson94a

      MW95

      vdH:witness

      vdHoeven97

      vdH:singhol

      Rich01

      vdH:witness

      Sh3

      Sh4

      Peladan95

      Sh3

      Ax71

      Sh3

      Sh3

      Khov91

      Sh4

      Khov91

      VdH:relax

      Bar68

      vdHoeven97

      vdHoeven97

      VdH:relax

      VdH:relax
    </associate>
    <\associate|toc>
      <vspace*|1fn><with|font series|<quote|bold>|1<space|2spc>Introduction><\
      value|toc-dots><pageref|toc-1><vspace|0.5fn>

      1.1<space|2spc>Zero-tests for constants<value|toc-dots><pageref|toc-2>

      1.2<space|2spc>Zero-tests for functions<value|toc-dots><pageref|toc-3>

      1.3<space|2spc>Overview<value|toc-dots><pageref|toc-4>

      <vspace*|1fn><with|font series|<quote|bold>|2<space|2spc>The main
      setup><value|toc-dots><pageref|toc-5><vspace|0.5fn>

      2.1<space|2spc>Effective local domains<value|toc-dots><pageref|toc-6>

      2.2<space|2spc>Computations in <with|mode|<quote|math>|<with|math
      font|<quote|cal>|S>><value|toc-dots><pageref|toc-7>

      2.3<space|2spc>Extraction of coefficients<value|toc-dots><pageref|toc-8\
      >

      <vspace*|1fn><with|font series|<quote|bold>|3<space|2spc>The Bareiss
      method and g.c.d.<inactive|<group|>>
      computations><value|toc-dots><pageref|toc-9><vspace|0.5fn>

      3.1<space|2spc>Pseudo-norms<value|toc-dots><pageref|toc-10>

      3.2<space|2spc>The Bareiss method<value|toc-dots><pageref|toc-11>

      3.3<space|2spc>Computing greatest common divisors of several
      polynomials<value|toc-dots><pageref|toc-12>

      3.4<space|2spc>Making polynomials square-free using
      pseudo-division<value|toc-dots><pageref|toc-13>

      <vspace*|1fn><with|font series|<quote|bold>|4<space|2spc>Four key
      lemmas><value|toc-dots><pageref|toc-14><vspace|0.5fn>

      <vspace*|1fn><with|font series|<quote|bold>|5<space|2spc>The
      algorithm><value|toc-dots><pageref|toc-15><vspace|0.5fn>

      5.1<space|2spc>Statement of the algorithm<value|toc-dots><pageref|toc-1\
      6>

      5.2<space|2spc>Complexity bounds<value|toc-dots><pageref|toc-17>

      5.3<space|2spc>Consequences of the complexity
      bounds<value|toc-dots><pageref|toc-18>

      <vspace*|1fn><with|font series|<quote|bold>|Bibliography><value|toc-dot\
      s><pageref|toc-19><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>
