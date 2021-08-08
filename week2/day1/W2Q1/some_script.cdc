import SomeContract from ./some_contract.cdc

pub fun main() {
  // Area 4
  // Variables that can be read: a b.
  // Variables that can be modified: a.
  // Functions that can be accessed: publicFunc

  let v1 = SomeContract.testStruct.a
  let v2 = SomeContract.testStruct.b

  SomeContract.testStruct.a = "SomeScript"

  SomeContract.testStruct.publicFunc()
}
