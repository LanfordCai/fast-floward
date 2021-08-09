import KittyItems from Project.KittyItems
import NonFungibleToken from Flow.NonFungibleToken

transaction(recipient: Address, typeIDs: [UInt64]) {
    
    let minter: &KittyItems.NFTMinter
    let receiver: &{NonFungibleToken.CollectionPublic}

    prepare(signer: AuthAccount) {
        pre {
            typeIDs.length <= 10
            : "max batch size is 10"
        }

        self.minter = signer.borrow<&KittyItems.NFTMinter>(from: KittyItems.MinterStoragePath)
                            ?? panic("Signer is not the token admin")
        
        self.receiver = getAccount(recipient).getCapability(KittyItems.CollectionPublicPath)
                            .borrow<&{NonFungibleToken.CollectionPublic}>()
                            ?? panic("Unable to borrow receiver reference")
    }

    execute {
        var counter: Int = 0
        while counter < typeIDs.length {
            let typeID = typeIDs[counter]
            self.minter.mintNFT(recipient: self.receiver, typeID: typeID)
            counter = counter + 1
        }
    }
}