import Artist from "../W1Q5/artist.contract.cdc"

// Create a Picture Collection for the transaction authorizer.
transaction {
    prepare(account: AuthAccount) {
        var collectionRef = account.borrow<&Artist.Collection>(from: /storage/ArtistCollection)
        if collectionRef == nil {
            account.save(<- Artist.createCollection(), to: /storage/ArtistCollection)
            account.link<&Artist.Collection>(/public/ArtistCollection, target: /storage/ArtistCollection)
            collectionRef = account
                .borrow<&Artist.Collection>(from: /storage/ArtistCollection)
                ?? panic("Couldn't borrow collection reference")
        }
    }
}