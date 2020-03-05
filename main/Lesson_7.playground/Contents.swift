import Foundation

//1. Написать функции, которые считывают матрицу смежности из файла и выводят ее на экран.

print("First solution : 'Read matrix from file'")
print()

@discardableResult func readFromFile() -> [Int]? {
    
    var tmpArrayOne = [String]()
    var tmpArrayTwo = [String]()
    var resultArray = [Int]()
    
    //Считываем данные из файла text.txt, расположенного в $Project\Resources, разбиваем полученный текст на строки разделенные знаком переноса на новую строку ("\n"), полученые строки в свою очередь разбиваем на строки разделенные пробелом (" "). Пробегаем по всем значениям полученных данных и удаляем пустые элементы (""). Переводим значения в целочисленные и сохраняем в массив resultArray.
    
    if let pathT = Bundle.main.path(forResource: "text", ofType: "txt") {
        if let textT = try? String(contentsOfFile: pathT) {
            tmpArrayOne = textT.components(separatedBy: "\n")
            tmpArrayOne.forEach{ tmpArrayTwo += $0.components(separatedBy: " ") }
            tmpArrayTwo.removeAll(where: {$0 == ""})
            tmpArrayTwo.forEach{ resultArray.append(Int($0) ?? 0)}
        }
    }
    
    //Делаем проверку на наличие данных
    if resultArray.count == 0 {
        print("Error in reading matrix")
        return nil
    }
    
    //Делаем проверку на правильную размерность матрицы
    if resultArray[0] * resultArray[0] == resultArray.count - 1 {
        print("Congratulation! Matrix reading was successful, size \(resultArray[0]) x \(resultArray[0]) with \(resultArray.count - 1) elements.")
        print()
    } else {
        print("Error in reading matrix")
        return nil
    }

    //Формируем массив обозначений наших вершин графа, A,B,C, ... с количеством элементов равному размерности матрицы
    var letters = [Character]()
    var l = 65
    for _ in 0..<resultArray[0] {
        letters.append( Character(UnicodeScalar(l) ?? "A") )
        l += 1
    }
    
    //Выводим на печать верхний ряд матрицы, обозначение вершин графа
    print(" ", terminator: "  ")
    for i in 0..<letters.count {
        print(letters[i], terminator: "  ")
    }
    print()
    //Выводим на печать основную матрицу с обозначением столбцов, вершин графа
    var j = 0
    for i in 1..<resultArray.count {
        if i % resultArray[0] == 1 {
            print(letters[j], terminator: "  ")
            j += 1
        }
        print(resultArray[i], terminator: "  ")
        
        if i % resultArray[0] == 0 {
            print()
        }
    }
    print()
    return resultArray
}

let array = readFromFile()

//2. Написать рекурсивную функцию обхода графа в глубину.

print("Second solution : 'Depth-first search, DFS'")
print()


print("We have \(String(describing: array?[0])) vertices of the graph")
print()

var vertexLetters = [Character]()
if let size = array?[0] {
    //Формируем массив обозначений наших вершин графа, A,B,C, ... с количеством элементов равному размерности матрицы
    var l = 65
    for _ in 0..<size {
        vertexLetters.append( Character(UnicodeScalar(l) ?? "A") )
        l += 1
    }
}

//Формируем массив "контрольных точек" вершин [0,1,2...]
var processDfs = Array(repeating: false, count: vertexLetters.count)

//Найдем длину всех пройденных ребер
var sumOfEdges = 0

func graphTraversalInDepth(array: [Int], vertex: Int, sum: Int) {
    
    //Делаем проверку на наличие исходных данных
    if array.count == 0 { return }
    
     //Последовательно обойдем все вершины графа, которые доступны из начальной вершины. Если ребро ведет в не пройдённую до этого момента вершину, то алгоритм запускается с нее. В случае если ребер, которые ведут в не рассмотренную вершину, больше нет, то происходит возврат назад.
    
    //Делаем проверку на повторное пребывание в данной вершине
    if processDfs[vertex] == true {
        return
    } else if processDfs[vertex] == false {
        //Помечаем вершину проверенной и учитываем пройденный путь
        print("Vertex \(vertexLetters[vertex]) checked")
        processDfs[vertex] = true
        sumOfEdges += sum
    }
   
    for i in 1...5 {
        if array[i + (vertex * 5)] != 0 {
            let newVertex = i - 1
            let edges = array[i + (vertex * 5)]
            graphTraversalInDepth(array: array, vertex: newVertex, sum: edges)
        }
    }
}

//Безопасно извлекаем массив данных и делаем обход графа в глубину
if let newArray = array {
    graphTraversalInDepth(array: newArray, vertex: 0, sum: 0)
}

//Делаем проверку на не пройденные вершины
for i in 0..<processDfs.count {
    processDfs[i] == true ? nil : print("Vertex \(vertexLetters[i]) not checked")
}

print()
print("Length of all edges traversed - \(sumOfEdges)")
print()

//3. Написать функцию обхода графа в ширину.

print("Third solution : 'Breadth-first search, BFS'")
print()

//Формируем массив "контрольных точек" вершин [0,1,2...]
var processBfs = Array(repeating: 0, count: vertexLetters.count)
var process = 0

//Начинаем обход с первой вершины, обнуляем сумму длин пройденных ребер
processBfs[0] = 1
sumOfEdges = 0

func logicBfs(array: [Int], vertex: Int) {
    
    //Делаем проверку на наличие исходных данных
    if array.count == 0 { return }
    
    /*
    Cначала посещаются все вершины, смежные с текущей, а затем их потомки.
    Введем обозначения:
    0 — вершина не достигнута волной;
    1 — вершина находится во фронте волны;
    2 — волна ушла из вершины.
    */
    
    //Делаем проверку на повторное пребывание в данной вершине
    if processBfs[vertex] == 2 {
        return
    } else if processBfs[vertex] == 1 {
        //Помечаем вершину проверенной
        print("Vertex \(vertexLetters[vertex]) checked")
        processBfs[vertex] = 2
    }
    
    for i in 1...5 {
        if array[i + (vertex * 5)] != 0 {
            if processBfs[i-1] == 0 {
                //Помечаем смежные вершины
                processBfs[i-1] = 1
                sumOfEdges += array[i + (vertex * 5)]
            }
        }
    }
}

func graphTraversalInBreadth() {
    var secure = 0
    repeat {
        //Создаем (обнуляем) очередь и безопасно извлекаем исходный массив данных
        var nextVertexs = [Int]()
        if let newArray = array {
            //Добавляем в очередь вершины находящиеся во фронте волны
            for i in 0..<processBfs.count {
                if processBfs[i] == 1 { nextVertexs.append(i) }
            }
            //Запускаем обход графа в ширину для данных вершин
            if nextVertexs.count > 0 {
                for i in 0..<nextVertexs.count {
                    logicBfs(array: newArray, vertex: nextVertexs[i])
                }
            }
        }
        //Так как условие выхода из цикла у нас отсутствие вершин со статусом ниже 2, сделаем ограничение в 30 циклов, на случай варианта с недоступностью одной или нескольких вершин
        secure += 1
        if secure == 30 { break }
        
    } while process != processBfs.count * 2
}


print("We have \(String(describing: array?[0])) vertices of the graph")
print()

graphTraversalInBreadth()

//Делаем проверку на не пройденные вершины
for i in 0..<processBfs.count {
    processBfs[i] == 2 ? nil : print("Vertex \(vertexLetters[i]) not checked")
}

print()
print("Length of all edges traversed - \(sumOfEdges)")
print()

/*
 
 First solution : 'Read matrix from file'

 Congratulation! Matrix reading was successful, size 5 x 5 with 25 elements.

    A  B  C  D  E
 A  0  2  0  3  0
 B  0  0  2  0  1
 C  0  0  0  0  0
 D  0  0  0  0  0
 E  0  0  0  0  0

 Second solution : 'Depth-first search, DFS'

 We have Optional(5) vertices of the graph

 Vertex A checked
 Vertex B checked
 Vertex C checked
 Vertex E checked
 Vertex D checked

 Length of all edges traversed - 8

 Third solution : 'Breadth-first search, BFS'

 We have Optional(5) vertices of the graph

 Vertex A checked
 Vertex B checked
 Vertex D checked
 Vertex C checked
 Vertex E checked

 Length of all edges traversed - 8
 
 */
