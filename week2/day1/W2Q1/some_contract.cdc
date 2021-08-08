access(all) contract SomeContract {
    pub var testStruct: SomeStruct

    pub struct SomeStruct {
        // 4 Variables
        //
        pub(set) var a: String

        pub var b: String

        access(contract) var c: String

        access(self) var d: String

        // 3 Functions
        //
        pub fun publicFunc() {}

        access(self) fun privateFunc() {}

        access(contract) fun contractFunc() {}

        pub fun structFunc() {
            // Area 1
            // Variables that can be read: a b c d.
            // Variables that can be modified: a b c d.
            // Functions that can be accessed: publicFunc contractFunc privateFunc

            let v1 = self.a
            let v2 = self.b
            let v3 = self.c
            let v4 = self.d

            self.a = "structFunc"
            self.b = "structFunc"
            self.c = "structFunc"
            self.d = "structFunc"

            self.publicFunc()
            self.privateFunc()
            self.contractFunc()
        }

        init() {
            self.a = "a"
            self.b = "b"
            self.c = "c"
            self.d = "d"
        }
    }

    pub resource SomeResource {
        pub var e: Int

        pub fun resourceFunc() {
            // Area 2
            // Variables that can be read: a b c.
            // Variables that can be modified: a.
            // Functions that can be accessed: publicFunc contractFunc
            let s = SomeContract.testStruct

            let v1 = s.a
            let v2 = s.b
            let v3 = s.c

            s.a = "resourceFunc"

            s.publicFunc()
            s.contractFunc()
        }

        init() {
            self.e = 17
        }
    }

    pub fun createSomeResource(): @SomeResource {
        return <- create SomeResource()
    }

    pub fun questsAreFun() {
        // Area 3
        // Variables that can be read: a b c.
        // Variables that can be modified: a.
        // Functions that can be accessed: publicFunc contractdFunc

        let v1 = self.testStruct.a
        let v2 = self.testStruct.b
        let v3 = self.testStruct.c

        self.testStruct.a = "questsAreFun"

        self.testStruct.publicFunc()
        self.testStruct.contractFunc()
    }

    init() {
        self.testStruct = SomeStruct()
    }
}
