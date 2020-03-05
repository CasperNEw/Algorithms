import Foundation

final class Node {
    
    let value: Int
    var nextNode: Node?
    
    init(value: Int, nextNode: Node? = nil) {
        self.value = value
        self.nextNode = nextNode
    }
}

final class SinglyLinkedList {
    
    var firstNode: Node?
    
    init(firstNode: Node? = nil) {
        self.firstNode = firstNode
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        let firstPart = "Node \(Unmanaged.passUnretained(self).toOpaque()) has value \(value) and"
        if let nextNode = nextNode {
            return firstPart + " next node value \(nextNode.value)"
        } else {
            return firstPart + " no next node"
        }
    }
}

extension SinglyLinkedList: CustomStringConvertible {
    var description: String {
        var description = "List \(Unmanaged.passUnretained(self).toOpaque())"
        if firstNode != nil {
            description += " has nodes:\n"
            
            var node = firstNode
            while node != nil {
                description += (node!.description + "\n")
                node = node!.nextNode
            }
            return description
        } else {
            return description + " has no nodes"
        }
    }
}

var list = SinglyLinkedList()

func pushNode(value: Int ) throws {
    
    guard let currentNode = list.firstNode else {
        let firstNode = Node(value: value)
        list.firstNode = firstNode
        return
    }
    let newNode = Node(value: value, nextNode: currentNode)
    list.firstNode = newNode
}

func printNodes() {
    guard var entity = list.firstNode else {
        print("Stack is empty")
        return
    }
    repeat {
        print("\(entity.value)", terminator: "")
        guard let newEntity = entity.nextNode else {
            print()
            print()
            return
        }
        entity = newEntity
    } while true //нас выбьет из цикла когда не будет ссылки на nextNode
}

func decToBin(value: Int) {
    var int = value
    
    if int > -1 {
        while int != 0 {
            if int % 2 == 1 {
                do {
                    try pushNode(value: 1)
                } catch {
                    print(error)
                }
            } else {
                do {
                    try pushNode(value: 0)
                } catch {
                    print(error)
                }
            }
            int = int / 2
        }
        printNodes()
    } else {
        print("incorrect Int")
    }
}

//1. Реализовать перевод из десятичной в двоичную систему счисления с использованием стека.

print("First solution :")
decToBin(value: 134)

//2. Добавить в программу «реализация стека на основе односвязного списка» проверку на выделение памяти. Если память не выделяется, то выводится соответствующее сообщение. Постарайтесь создать ситуацию, когда память не будет выделяться (добавлением большого количества данных).

print("Second solution :")
print(String(describing: list))

//Добавили в метод pushNode уведомление о возможности ошибки и соответственно при попытке выполнения метода pushNode в методе decToBin печать ошибки.
//Добавили расширения на наши классы для печати информации о выделенном адресе в памяти.

//3. Написать программу, которая определяет, является ли введенная скобочная последовательность правильной. Примеры правильных скобочных выражений: (), ([])(), {}(), ([{}]), неправильных — )(, ())({), (, ])}), ([(]) для скобок [,(,{. Например: (2+(2*2)) или [2/{5*(4+7)}]


print("Third solution :")
//пользователь вводит строку.
let insertString = "{2*[3+3]/2}*(2+2)"
var bracketsArray = [Character]()

let closingBracket: [Character] = [")","]","}"]

let allBrackets: [Character] = ["(","[","{",")","]","}"]

for character in insertString {
    if allBrackets.contains(character) {
        bracketsArray.append(character)
    }
}

var i = 0

let z:Character = "("
let x:Character = "["
let c:Character = "{"
let v:Character = "}"
let b:Character = "]"
let n:Character = ")"


repeat {
    if closingBracket.contains(bracketsArray[i]) {
        print("Incorrect brackets!")
        break
    }
    if bracketsArray[i] == z {
        if bracketsArray[i+1] == n {
            bracketsArray.remove(at: i)
            bracketsArray.remove(at: i)
            i = 0
            continue
        }
    }
    if bracketsArray[i] == x {
        if bracketsArray[i+1] == b {
            bracketsArray.remove(at: i)
            bracketsArray.remove(at: i)
            i = 0
            continue
        }
    }
    if bracketsArray[i] == c {
        if bracketsArray[i+1] == v {
            bracketsArray.remove(at: i)
            bracketsArray.remove(at: i)
            i = 0
            continue
        }
    }
    
    i += 1
    
} while i < bracketsArray.count - 1

if bracketsArray.count > 0 {
    print("Incorrect brackets!")
} else if bracketsArray.count == 0 {
    print("Parenthesis validation passed!")
} else {
    print("???")
}

/* //Console output at startup:
 
 First solution :
 10000110
 List 0x000060000226e360 has nodes:
 Node 0x000060000223b180 has value 1 and next node value 0
 Node 0x000060000223b7c0 has value 0 and next node value 0
 Node 0x000060000223b500 has value 0 and next node value 0
 Node 0x000060000223b6e0 has value 0 and next node value 0
 Node 0x000060000226fce0 has value 0 and next node value 1
 Node 0x000060000226fdc0 has value 1 and next node value 1
 Node 0x000060000226fe80 has value 1 and next node value 0
 Node 0x000060000226e280 has value 0 and no next node

 Parenthesis validation passed!
 
 */
