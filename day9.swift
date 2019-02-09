import Foundation

// Structs Part II

// initializers are special 'methods' that provide different ways to create
// your struct. All structs come with one by default, called their
// 'memberwise initializer' - this asks you to provide a value for
// each property when you create the struct.

struct User {
    var username: String

    init() {
        // do use 'func' for the initializer
        // make sure *all* struct variables are initialized
        // before the method ends
        // -- they can be initialized outside init() too
        username = "Anonymous"
        print("Creating a new user!")
    }
}

var user = User()
user.username = "twostraws"

// Referring to the current instance
// Inside methods you get a special constant called 'self', which 
// points to whatever instance of the struct is currently being used.

struct Person {
    var name: String
    init(name: String)  {
        print("\(name) was born!")
        self.name = name
    }
}

// Lazy properties

struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}

struct Person {
    var name: String
    lazy var familyTree = FamilyTree() // creates only when first accessed

    init(name: String) {
        self.name = name
    }
}

// if you want to see the "Creating family tree!" message,
// you'll need to access the property at least once before
// it is initialized

ed.familyTree

// Static properties and methods
// Structs can share specific properties and methods across all instances
// of the struct by declaring them as 'static'

struct Student {
    static var classSize = 0
    var name: String

    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}

let ed = Student(name: "Ed")
let taylor = Student(name: "Taylor")

print(Student.classSize)

// Access control
// use 'private' to prevent access to a method or property from
// outside of the instance.

struct Person {
    private var id: String

    init(id: String) {
        self.id = id
    }

    func identify() -> String {
        return "My social security number is \(id)"
    }
}

let ed = Person(id: "12345")