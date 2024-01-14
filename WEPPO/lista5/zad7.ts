/* _____________ Pick _____________ */

type MyPick<T, K extends keyof T> = {
  [P in K]: T[P]
}

/* _____________ Readonly _____________ */

type MyReadonly<T> = {
  readonly [K in keyof T]: T[K]
}

/* _____________ TupleToObject _____________ */

type TupleToObject<T extends readonly any[]> = {
  [K in T[number]] : K
}

/* _____________ First _____________ */

type First<T extends any[]> = T extends [] ? never : T[0]

/* _____________ Length _____________ */

type Length<T extends readonly any[]> = T['length']

/* _____________ Exclude _____________ */

type MyExclude<T, U> = T extends U ? never : T

/* _____________ Await _____________ */
type MyAwaited<T extends PromiseLike<any>> = 
T extends PromiseLike<infer U> ? U extends PromiseLike<any> ? MyAwaited<U> : U : never

/* _____________ If _____________ */
type If<C, T, F> = C extends true ? T : F

/* _____________ Concat _____________ */
type Concat<T extends any[], U extends any[]> = [...T, ...U]

/* _____________ Push _____________ */
type Push<T extends unknown[], U> = [...T,U]

/* _____________ Unshift _____________ */
type Unshift<T extends any[], U> = [U, ...T];
