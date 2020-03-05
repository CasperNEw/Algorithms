import Foundation

//1. Реализовать сортировку подсчетом.

print("First solution : 'Counting sort'\n")

//Формируем исходныe массив данных для сортировки
var array1h = [Int]()

for _ in 1...100 {
    array1h.append(Int.random(in: 0..<100))
}

func countingSortResult(arrayForSort: [Int], maxInArray: Int) {
    
    let startTime = Int(Date().timeIntervalSince1970)
    var array = arrayForSort
    var count = 0
    
    var countArray = Array(repeating: 0, count: maxInArray + 1)
    
    for i in 0..<array.count {
        countArray[array[i]] += 1
        count += 1
    }
    
    var index = 0
    for i in 0..<countArray.count {
        if countArray[i] != 0 {
            for _ in 0..<countArray[i] {
                array[index] = i
                index += 1
                count += 1
            }
        }
    }
    
    let sortingTime = Int(Date().timeIntervalSince1970) - startTime
    print("Counting sort time for an array of \(array.count) elements - \(sortingTime) second, number of comparisons - \(count)")
}

countingSortResult(arrayForSort: array1h, maxInArray: 99)

//2. Реализовать быструю сортировку.

print("\nSecond solution : 'Quick sort'\n")

var count = 0

func quickSort(array: [Int]) -> [Int] {
    
    count += 1
    //Делаем проверку на наличие элементов в исходном массиве
    guard array.count > 1 else { return array }
    
    var less = [Int]()
    var greater = [Int]()
    var equal = [Int]()
    
    let pivot = array[array.count / 2]
    
    //Распределяем элементы по соответствующим массивам, меньше,больше и равные pivot
    for i in 0..<array.count {
        count += 1
        if array[i] == pivot { equal.append(array[i]); continue }
        array[i] < pivot ? less.append(array[i]) : greater.append(array[i])
        count += 1
    }
    
    return quickSort(array: less) + equal + quickSort(array: greater)
}

func quickSortResult(array: [Int]) {
    count = 0
    let startTime = Int(Date().timeIntervalSince1970)
    quickSort(array: array)
    let sortingTime = Int(Date().timeIntervalSince1970) - startTime
    print("Quick sort time for an array of \(array.count) elements - \(sortingTime) second, number of comparisons - \(count)")
}

quickSortResult(array: array1h)

//4. Проанализировать время работы каждого из вида сортировок для 100, 10000, 1000000 элементов.

print("\nThird solution : 'Analytics'\n")

print("Konstantinov Dmitriy Sergeevich\nIntel Core i7 2.6Ghz\nmacOS Catalina ver. 10.15.2\nXcode ver. 11.2 (11B52)\n")


print("Caution! Long run time of the algorithm! Uncomment the code to start.")

/*
var array1t = [Int]()
var array10t = [Int]()
var array100t = [Int]()

for _ in 1...1000 {
    array1t.append(Int.random(in: 0..<100))
}

for _ in 1...10000 {
    array10t.append(Int.random(in: 0..<100))
}

repeat {
    array100t += array10t
} while array100t.count < 100000

countingSortResult(arrayForSort: array1h, maxInArray: 99)
countingSortResult(arrayForSort: array1t, maxInArray: 99)
countingSortResult(arrayForSort: array10t, maxInArray: 99)
countingSortResult(arrayForSort: array100t, maxInArray: 99)

quickSortResult(array: array1h)
quickSortResult(array: array1t)
quickSortResult(array: array10t)
quickSortResult(array: array100t)
*/

/* //Console output at startup:

 Third solution : 'Analytics'

 Konstantinov Dmitriy Sergeevich
 Intel Core i7 2.6Ghz
 macOS Catalina ver. 10.15.2
 Xcode ver. 11.2 (11B52)

 Counting sort time for an array of 100 elements - 0 second, number of comparisons - 200
 Counting sort time for an array of 1000 elements - 0 second, number of comparisons - 2000
 Counting sort time for an array of 10000 elements - 2 second, number of comparisons - 20000
 Counting sort time for an array of 100000 elements - 11 second, number of comparisons - 200000
 Quick sort time for an array of 100 elements - 0 second, number of comparisons - 1153
 Quick sort time for an array of 1000 elements - 1 second, number of comparisons - 15979
 Quick sort time for an array of 10000 elements - 12 second, number of comparisons - 146745
 Quick sort time for an array of 100000 elements - 156 second, number of comparisons - 1391401
 */
