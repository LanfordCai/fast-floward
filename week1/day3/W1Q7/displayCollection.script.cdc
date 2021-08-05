import Artist from "../W1Q5/artist.contract.cdc"

// Return an array of formatted Pictures that exist in the account with the a specific address.
// Return nil if that account doesn't have a Picture Collection.
pub fun main(address: Address): [String]? {
    let collectionRef =
        getAccount(address)
        .getCapability<&Artist.Collection>(/public/ArtistCollection)
        .borrow()

    if let collectionRef = collectionRef {
        var index = 0
        let picNum = collectionRef.pictures.length
        let picArray: [String] = []
        while index < picNum {
            let picRef: &Artist.Picture = &collectionRef.pictures[index] as &Artist.Picture
            Artist.display(canvas: picRef.canvas)
            picArray.append(picRef.canvas.pixels)
            index = index + 1
        }
        return picArray
    } else {
        return nil
    }
}