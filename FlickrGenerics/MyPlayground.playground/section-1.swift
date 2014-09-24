// Playground - noun: a place where people can play

import UIKit

struct OrderedDictionary<KeyType : Hashable, ValueType>
{
    typealias ArrayType = [KeyType]
    typealias DictionaryType = [KeyType: ValueType]
    
    var array = ArrayType()
    var dictionary = DictionaryType()
    
    
    mutating func insert(value : ValueType, forKey key : KeyType, atIndex index : Int) -> ValueType?
    {
        var adjustedIndex = index
        
        let existingValue = self.dictionary[key]
        
        if ( existingValue != nil )
        {
            let existingIndex = find(self.array, key)!
            
            if ( existingIndex < index)
            {
                adjustedIndex--
            }
            
            self.array.removeAtIndex(existingIndex)
        }
        
        self.array.insert(key, atIndex: adjustedIndex)
        self.dictionary[key] = value
        
        return existingValue
    }
    
    mutating func removeAtIndex(index : Int) -> (KeyType, ValueType)
    {
        precondition(index < self.array.count, "Index out-of-bounds")
        
        let key = self.array.removeAtIndex(index)
        
        let value = self.dictionary.removeValueForKey(key)!
        
        return (key, value)
    }
    
    var count:Int
        {
        return self.array.count
    }
    
    subscript(key : KeyType) -> ValueType?
        {
        get
        {
            return self.dictionary[key]
        }
        
        set
        {
            if let index = find(self.array, key)
            {
                
            }
            else
            {
                self.array.append(key)
            }
            
            self.dictionary[key] = newValue
        }
    }
    
    
    subscript(index : Int) -> (KeyType, ValueType)
        {
        get
        {
            precondition(index < self.array.count, "Index out-of-bounds")
            
            let key = self.array[index]
            let value = self.dictionary[key]!
            return (key, value )
        }
        
        set
        {
            let (key, value) = newValue
            precondition(index <= self.array.count, "Index out-of-bounds")
            
            if ( index < self.array.count)
            {
                
            }
            else
            {
                self.array.append(key)
            }
            
            self.dictionary[key] = value
            
        }
    }
    
}



var dict = OrderedDictionary<Int, String>()

dict.insert("dog", forKey: 0, atIndex: 0)
dict.insert("cat", forKey: 1, atIndex: 1)

println(dict.array.description + " : " + dict.dictionary.description)

var byIndex :(Int, String) = dict[0]
println(byIndex)

var byKey : String? = dict[1]
println(byKey)

dict[2] = (2, "Rabbit")

println(dict.array.description + " : " + dict.dictionary.description)

var byIndex1 :(Int, String) = dict[2]
println(byIndex1)







































