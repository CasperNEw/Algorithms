import Foundation

//1. Реализовать простейшую хеш-функцию. На вход функции подается строка, на выходе сумма кодов символов.

print("First solution :")

func hashFunction(string: String) -> String {
    
    print()
    
    var s = 0
    for scalar in string.unicodeScalars {
        s += Int(scalar.value)
    }
    print("Start string - '\(string)'")
    print("Sum of character codes in decimal NS - \(s)")
    print("Sum of character codes in hexadecimal NS - \(String(format:"%2X", s))")
    
    /*
    допустим наша функция будет возвращать 24 знака в 16'ричной СИ. разобьем по парам, итого у нас 12 чисел по 2 знака. нам нужны исходыне 12 чисел по 2 знака. возьмем месяца в обратном порядке: 12 11 ... 03 02 01. находим сумму целых чисел, целых частей скаляров юникода, исходной строки и умножаем отдельно на исходный массив "месяцов". так как мы придумали себе ограничение в 2 знака, то максимально число 10'ричной системы которое мы можем отобразить в 2'х знаках 16'ричной системы это FF, то есть 255. теперь нам нужно найти остаток от деления на 255 каждого элемента полученного массива и перевести в 16' СИ. так как в Swift при выводе значения в 16' СИ "0х" = " х", мы должны сделать проверку на "пустой" знак и заменить его на "0". по итогу вывести результат.
     поехали )
    */
    
    let secretArray = [12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
    var resultString = ""
    
    secretArray.forEach{
        
        let symbol = String(format:"%2X", $0*s % 255)
        
        for char in symbol {
            if char == " " {
                resultString.append("0")
            } else {
                resultString.append(char)
            }
        }
    }
    return "SHA-CasperNEw : \(resultString)"
}

print(hashFunction(string: "Welcome to SHA-CasperNEw algorithm"))
print(hashFunction(string: "?"))
print(hashFunction(string: "!"))


//2. Переписать программу, реализующую двоичное дерево поиска. а) Добавить в него обход дерева различными способами; б) Реализовать поиск в двоичном дереве поиска;

print()
print("Second solution :")
print()


final class Node {
    
    let value: Int
    var leftSon: Node?
    var rightSon: Node?
    var parent: Node?
    
    init(value: Int, leftSon: Node? = nil, rightSon: Node? = nil, parent: Node? = nil) {
        self.value = value
        self.leftSon = leftSon
        self.rightSon = rightSon
        self.parent = parent
    }
}

final class Three {
    var root: Node?
    
    init(root: Node? = nil) {
        self.root = root
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        var description = "Node \(Unmanaged.passUnretained(self).toOpaque()) has value \(value)"
        if let leftSon = leftSon {
            description = description + ", with left son value \(leftSon.value)"
        }
        if let rightSon = rightSon {
            description = description + ", with right son value \(rightSon.value)"
        }
        return description
    }
}

var startArray = [Int]()
//Имитируем исходный файл с N = 100 количеством значений
for _ in 1...100 {
    startArray.append(Int.random(in: 1..<100))
}

/* //Используемые выдержки из методички
Двоичное дерево:
1. Пустая структура — это двоичное дерево.
2. Двоичное дерево — это корень и два связанных с ним отдельных двоичных дерева (левое и
правое поддеревья).

Двоичное дерево поиска:
1. Слева от каждого узла находятся узлы, ключи которых меньше или равны ключу данного узла.
2. Справа от каждого узла находятся узлы, ключи которых больше данного узла.


Что бы метод поиска работал в нашем дереве максимально производительно построим сразу сбалансированное дерево.

Правило равномерного распределения при известном числе узлов n лучше всего сформулировать рекурсивно:
1. Использовать один узел в качестве корня.
2. Построить таким образом левое поддерево с числом узлов nl=n div 2.
3. Построить таким образом правое поддерево с числом узлов nr=n-nl-1.
*/

print("Start array have \(startArray.count) items :")
print(startArray)
print()


var three = Three()
var threeArray = [Node]()
var bool = true //Переменная введенная для разового получения уведомления о статусе "балансности" нашего дерева
var startCount = 0

func createThree(array: [Int], parent: Node?) -> Node? {
    startCount += 1
    if array.count > 3 {
        let sorted = array.sorted { $0 < $1 }
        var center = sorted.count / 2
        
        for i in (sorted.count / 2)...(sorted.count - 1) {
            if i < sorted.count - 1 {
                if sorted[i] != sorted[i+1] {
                    break
                }
                if sorted[i] == sorted[i+1] {
                    center = i + 1
                }
            }
        }

        var nl = [Int]()
        for i in 0...(center - 1) { nl.append(sorted[i]) }
        var nr = [Int]()
        if (sorted.count - 1 - center) > 0 {
            for i in (center + 1)...(sorted.count - 1) { nr.append(sorted[i]) }
        }
    
        var root = Node(value: sorted[center], leftSon: nil, rightSon: nil, parent: parent)
        
        if (sorted.count / 2) == center {
            bool == true ? print("Congratulation! Your tree is balanced") : nil
            bool = false
        } else {
            bool == true ? print("Your tree is unbalanced") : nil
            bool = false
        }
    
        let leftSon = createThree(array: nl, parent: root)
        let rightSon = createThree(array: nr, parent: root)
        root = Node(value: sorted[center], leftSon: leftSon, rightSon: rightSon, parent: parent)
        
        three.root = root
        threeArray.append(root)
        return root
       
    } else if array.count == 1 {
        let root = Node(value: array[0], leftSon: nil, rightSon: nil, parent: parent)
        threeArray.append(root)
        return root
    } else if array.count == 2 {
        let sorted = array.sorted { $0 < $1 }
        var root = Node(value: sorted[1], leftSon: nil, rightSon: nil, parent: parent)
        let leftSon = Node(value: sorted[0], leftSon: nil, rightSon: nil, parent: root)
        root = Node(value: sorted[1], leftSon: leftSon, rightSon: nil, parent: parent)
        threeArray.append(root)
        threeArray.append(leftSon)
        return root
    } else if array.count == 3 {
        let sorted = array.sorted { $0 < $1 }
        var root = Node(value: sorted[1], leftSon: nil, rightSon: nil, parent: parent)
        let leftSon = Node(value: sorted[0], leftSon: nil, rightSon: nil, parent: root)
        let rightSon = Node(value: sorted[2], leftSon: nil, rightSon: nil, parent: root)
        root = Node(value: sorted[1], leftSon: leftSon, rightSon: rightSon, parent: parent)
        threeArray.append(root)
        threeArray.append(leftSon)
        threeArray.append(rightSon)
        return root
    }
    
    return nil
}

createThree(array: startArray, parent: nil)

print("Root have value - \(three.root?.value)")
print("Recursive function worked \(startCount) times")
print("\(threeArray.count) nodes formed")
print()

print("Calculation verification unit :")

threeArray.forEach { if $0.parent == nil { print("No parents, root, node have value - \($0.value)") } }

var threeTwoNillList = [Node]()
var threeOneNillList = [Node]()
var threeNode = [Node]()

threeArray.forEach { if $0.leftSon == nil { if $0.rightSon == nil { threeTwoNillList.append($0) } } }
threeArray.forEach { if $0.leftSon == nil { if $0.rightSon != nil { threeOneNillList.append($0) } } }
threeArray.forEach { if $0.leftSon != nil { if $0.rightSon == nil { threeOneNillList.append($0) } } }
threeArray.forEach { if $0.leftSon != nil { if $0.rightSon != nil { threeNode.append($0) } } }

print("The number of sheets in a tree - \(threeTwoNillList.count)")
print("Number of nodes having one sheet - \(threeOneNillList.count)")
print("Number of full-fledged parents - \(threeNode.count)")

if (threeTwoNillList.count + threeOneNillList.count + threeNode.count) == startArray.count {
    print("Verification compete - Ok")
} else {
    print("Verification compete - Error")
}

func printTree(root: Node?) {
    if let node = root {
        print("\(node.value)", terminator: "")
        if node.leftSon != nil || node.rightSon != nil {
            print("(", terminator: "")
            if node.leftSon != nil {
                printTree(root: node.leftSon)
            } else {
                print("NIL", terminator: "")
            }
            print(",", terminator: "")
            
            if node.rightSon != nil {
                printTree(root: node.rightSon)
            } else {
                print("NIL", terminator: "")
            }
            print(")", terminator: "")
            
        }
    }
}

print()
print("Tree print :")
printTree(root: three.root)
print()

func rootLefRight(root: Node?) {
    if let node = root {
    print("\(node.value)", terminator: " ")
        rootLefRight(root: node.leftSon)
        rootLefRight(root: node.rightSon)
    }
}

func leftRootRight(root: Node?) {
    if let node = root {
        rootLefRight(root: node.leftSon)
        print("\(node.value)", terminator: " ")
        rootLefRight(root: node.rightSon)
    }
}

func leftRightRoot(root: Node?) {
    if let node = root {
        rootLefRight(root: node.leftSon)
        rootLefRight(root: node.rightSon)
        print("\(node.value)", terminator: " ")
    }
}

print()
print("Binary tree recursive traversal")
print()
print("Pre-order, Root -> Left -> Right :")
rootLefRight(root: three.root)
print()
print()
print("In-order, Left -> Root -> Right :")
leftRootRight(root: three.root)
print()
print()
print("Post-order, Left -> Right -> Root :")
leftRightRoot(root: three.root)
print()
print()

print("Search for a value in a tree :")
print()

let searchValue = Int.random(in: 30..<70)
print("Values for search \(searchValue), it is random from 30 to 70")

func searchInThree(root: Node?, value: Int) {
    if let node = root {
        if value == node.value {
            print("\(node) - have value \(value)")
            if let leftNode = node.leftSon?.value {
                if value == leftNode {
                    searchInThree(root: node.leftSon, value: value)
                }
            }
        } else if value > node.value {
            searchInThree(root: node.rightSon, value: value)
        } else if value < node.value {
            searchInThree(root: node.leftSon, value: value)
        }
    }
}

searchInThree(root: three.root, value: searchValue)

/*  //Console output at startup:
 
 First solution :

 Start string - 'Welcome to SHA-CasperNEw algorithm'
 Sum of character codes in decimal NS - 3143
 Sum of character codes in hexadecimal NS - C47
 SHA-CasperNEw : E79441ED9A47F3A04DF9A653

 Start string - '?'
 Sum of character codes in decimal NS - 63
 Sum of character codes in hexadecimal NS - 3F
 SHA-CasperNEw : F6B77839F9BA7B3CFCBD7E3F

 Start string - '!'
 Sum of character codes in decimal NS - 33
 Sum of character codes in hexadecimal NS - 21
 SHA-CasperNEw : 8D6C4B2A09E7C6A584634221

 Second solution :

 Start array have 100 items :
 [63, 45, 34, 61, 53, 35, 74, 46, 30, 68, 24, 67, 62, 95, 13, 7, 71, 80, 16, 18, 25, 64, 9, 42, 12, 4, 40, 5, 88, 6, 86, 15, 10, 76, 62, 17, 85, 46, 87, 4, 95, 8, 70, 64, 17, 36, 21, 53, 26, 74, 69, 59, 16, 40, 78, 36, 95, 25, 18, 33, 24, 80, 42, 66, 23, 59, 6, 75, 71, 75, 49, 21, 71, 83, 23, 27, 44, 35, 48, 64, 6, 4, 86, 18, 4, 94, 54, 24, 74, 64, 37, 26, 30, 2, 77, 23, 8, 85, 34, 77]

 Congratulation! Your tree is balanced
 Root have value - Optional(42)
 Recursive function worked 69 times
 100 nodes formed

 Calculation verification unit :
 No parents, root, node have value - 42
 The number of sheets in a tree - 42
 Number of nodes having one sheet - 17
 Number of full-fledged parents - 41
 Verification compete - Ok

 Tree print :
 42(21(9(6(4(4(4(2,4),NIL),6(5,6)),8(7,8)),17(15(12(10,13),16(16,17)),18(18(18,NIL),21))),30(25(24(23(23(23,NIL),24(24,NIL)),25),27(26(26,NIL),30)),36(35(34(34(33,NIL),35),36),40(40(37,NIL),42)))),71(62(53(46(45(44,46),49(48,53)),59(59(54,NIL),62(61,NIL))),67(64(64(64(63,64),NIL),66),70(69(68,NIL),71(71,NIL)))),83(76(74(74(74,NIL),75(75,NIL)),78(77(77,NIL),80(80,NIL))),88(86(85(85,86),87),95(95(94,95),NIL)))))

 Binary tree recursive traversal

 Pre-order, Root -> Left -> Right :
 42 21 9 6 4 4 4 2 4 6 5 6 8 7 8 17 15 12 10 13 16 16 17 18 18 18 21 30 25 24 23 23 23 24 24 25 27 26 26 30 36 35 34 34 33 35 36 40 40 37 42 71 62 53 46 45 44 46 49 48 53 59 59 54 62 61 67 64 64 64 63 64 66 70 69 68 71 71 83 76 74 74 74 75 75 78 77 77 80 80 88 86 85 85 86 87 95 95 94 95

 In-order, Left -> Root -> Right :
 21 9 6 4 4 4 2 4 6 5 6 8 7 8 17 15 12 10 13 16 16 17 18 18 18 21 30 25 24 23 23 23 24 24 25 27 26 26 30 36 35 34 34 33 35 36 40 40 37 42 42 71 62 53 46 45 44 46 49 48 53 59 59 54 62 61 67 64 64 64 63 64 66 70 69 68 71 71 83 76 74 74 74 75 75 78 77 77 80 80 88 86 85 85 86 87 95 95 94 95

 Post-order, Left -> Right -> Root :
 21 9 6 4 4 4 2 4 6 5 6 8 7 8 17 15 12 10 13 16 16 17 18 18 18 21 30 25 24 23 23 23 24 24 25 27 26 26 30 36 35 34 34 33 35 36 40 40 37 42 71 62 53 46 45 44 46 49 48 53 59 59 54 62 61 67 64 64 64 63 64 66 70 69 68 71 71 83 76 74 74 74 75 75 78 77 77 80 80 88 86 85 85 86 87 95 95 94 95 42

 Search for a value in a tree :

 Values for search 36, it is random from 30 to 70
 Node 0x00006000015304b0 has value 36, with left son value 35, with right son value 40 - have value 36
 */
