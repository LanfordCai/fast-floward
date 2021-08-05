import Artist from 0x02

transaction() {
    let pixels: String
    let picture: @Artist.Picture?
    let collectionRef: &Artist.Collection

    prepare(account: AuthAccount) {
        let printerRef = getAccount(0x02)
            .getCapability<&Artist.Printer>(/public/ArtistPicturePrinter)
            .borrow()
            ?? panic("Couldn't borrow printer reference.")

        self.pixels = "*   * * *   *   * * *   *"
        let canvas = Artist.Canvas(
            width: printerRef.width,
            height: printerRef.height,
            pixels: self.pixels
        )

        self.picture <- printerRef.print(canvas: canvas)

        var collectionRef = account.borrow<&Artist.Collection>(from: /storage/ArtistCollection)
        if collectionRef == nil {
            account.save(<- Artist.createCollection(), to: /storage/ArtistCollection)
            account.link<&Artist.Collection>(/public/ArtistCollection, target: /storage/ArtistCollection)
            collectionRef = account
                .borrow<&Artist.Collection>(from: /storage/ArtistCollection)
                ?? panic("Couldn't borrow collection reference")
        }

        self.collectionRef = collectionRef!
    }

    execute {
        if (self.picture == nil) {
            log("Picture with ".concat(self.pixels).concat(" already exists!"))
            destroy self.picture
        } else {
            log("Picture printed!")
            self.collectionRef.deposit(picture: <- self.picture!)
        }
    }
}