//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

enum Wombat {
    case A(a:Double)
    case AB(a:Double, b:Double)
    case ABC(Double, Double, Double)
}

var a = Wombat.A(a:1)
var ab = Wombat.AB(a:1,b:2)
var abc = Wombat.ABC(1,2,3)

switch (a)
{
case .ABC(let x): println(x.1 + x.2 + x.0)
case .AB(let x): println("\(x.a) \(x.b)")
case .A(let x): println("\(x)")
}

enum Result : Printable {
    case Value(Double)
    case Error(String)

    init (_ val: Double) {self = .Value(val)}

    var description : String {
        switch self {
        case .Value(let val): return "\(val)"
        case .Error(let err): return "<\(err)>"
        }
    }

    var value : Double? {
        switch self {
        case .Value(let val): return val
        case .Error(let err): return nil
        }
    }

    var error : String {
        switch self {
        case .Value(let val): return ""
        case .Error(let err): return err
        }
    }
}

extension Double {
    func __conversion() -> Result {
        return .Value(self)
    }
}

func foo () -> Result
{
    return Result(2.0)
    //return .Value(2.0)
}
func bar () -> Result
{
    return .Error("Wombat")
}

"\(foo())"
"\(bar())"

-2.0 / 0.0
Double.NaN
sqrt(-1.0)

var s = "X"
s.decomposedStringWithCanonicalMapping



