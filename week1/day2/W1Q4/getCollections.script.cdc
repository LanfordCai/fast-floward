import Artist from 0x02

pub fun main() {
  // Quest W1Q4
  let addresses: [Address] = [0x01, 0x02, 0x03, 0x04, 0x05]
  for address in addresses {
    log("collection of ".concat(address.toString()).concat(":"))
    printCollection(address: address)
  }
}

pub fun printCollection(address: Address) {
  let collectionRef =
    getAccount(address)
    .getCapability<&Artist.Collection>(/public/ArtistCollection)
    .borrow()

  if let collectionRef = collectionRef {
    var index = 0
    let picNum = collectionRef.pictures.length
    while index < picNum {
      let picRef: &Artist.Picture = &collectionRef.pictures[index] as &Artist.Picture
      log("collection ".concat(index.toString()).concat(":"))
      Artist.display(canvas: picRef.canvas)
      index = index + 1
    }
  } else {
    log("address ".concat(address.toString()).concat(" don't yet have a collection"))
  }
}
