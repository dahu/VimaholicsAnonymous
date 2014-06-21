let x = [1, 2, 3, 4, 5]

let Sum = Partial('Reduce', Fn('(x,y) => a:x + a:y'), 0, undefined)
let Mul = Partial('Reduce', Fn('(x,y) => a:x * a:y'), 1, undefined)

echo Sum(x)
echo Mul(x)

