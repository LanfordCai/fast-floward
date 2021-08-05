import Artist from "../W1Q5/artist.contract.cdc"

// Print a Picture and store it in the authorizing account's Picture Collection.
transaction(width: UInt8, height: UInt8, pixels: String) {
    let collectionRef: &Artist.Collection
    
    prepare(account: AuthAccount) {
        self.collectionRef = account
            .borrow<&Artist.Collection>(from: /storage/ArtistCollection)
            ?? panic("Couldn't borrow collection reference")
    }

    execute {
        // emulator-artist 0x01cf0e2f2f715450
        let printerRef = getAccount(0x01cf0e2f2f715450)
            .getCapability<&Artist.Printer>(/public/ArtistPicturePrinter)
            .borrow()
            ?? panic("Couldn't borrow printer reference.")

        let canvas = Artist.Canvas(
            width: width,
            height: height,
            pixels: pixels
        )

        let picture <- printerRef.print(canvas: canvas)

        if picture != nil {
            self.collectionRef.deposit(picture: <- picture!)
        } else {
            destroy picture
        }
    }
}